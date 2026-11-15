# AI Log — System Architecture & ADRs (Gate 1)

| Trường | Giá trị |
|---|---|
| Ngày | 2026-11-15 |
| Thành viên | be |
| Công cụ / Model | Antigravity AI (Google Deepmind) |
| Loại công việc | docs / architecture / adr |
| Liên quan | Gate 1 · Epics E1–E9 · `docs/04-ARCHITECTURE.md` |
| Thời lượng | <!-- điền --> |

## 1. Mục tiêu
Thiết kế kiến trúc hệ thống (4 sơ đồ chuẩn hóa: System Overview, Chat Streaming & HITL, LangGraph State Machine có Agentic Loops, Deployment Diagram), đặc tả Backend cốt lõi (`AgentState`, Latency Budget, Indexing/Immutability DB, Takeover & SLA Watchdog) và bộ ADR (ADR-001 đến ADR-006) cho dự án Bình An (VMEC-20) dưới vai trò Senior Backend Engineer, đối chiếu với bộ hướng dẫn thiết kế kiến trúc & ADR và PRD v0.1.

## 2. Prompt chính
```text
[Mẫu ADR-001 + 8 ảnh hướng dẫn thiết kế kiến trúc System Overview, Chat Interface, LangGraph State Machine, Agent Flow, Deployment, Quy tắc vẽ diagram, ADR]
"Bạn xem vào thiết kế dưới vai trò Senior Backend Engineer nhé"
```

## 3. Đầu ra của AI (tóm tắt)
- Tạo mới `docs/04-ARCHITECTURE.md` gồm:
  - 4 sơ đồ Mermaid tuân thủ 5 quy tắc diagram (đặt tên rõ chức năng, phân nhóm `subgraph`, nhãn hướng dữ liệu, đánh số thứ tự `(1)..(n)`, tách riêng góc nhìn): System Overview, Chat SSE + WebSocket Takeover Sequence, LangGraph State Machine với Safety-First Fast Path + 2 Agentic Loops (Corrective RAG & Output Guardrail), Deployment Diagram.
  - Thiết kế Backend sâu: `AgentState` với `monotonic_risk_reducer`, bảng Latency Budget & Fail-safe `detector_degraded` ở `1500ms`, thiết kế Postgres trigger `append-only`, HNSW/Partial B-Tree index, mã hóa AES-256-GCM + Break-glass audit, và Redis Pub/Sub + Sorted Set cho Takeover/SLA.
  - 6 ADR chuẩn mẫu (`ADR-001` đến `ADR-006`): Hybrid Crisis Detection, LangGraph Orchestration, Postgres + pgvector, SSE + WebSocket, Curated Local KB vs Live Web Search (Tavily/Serper.dev/Google Custom Search), và Pre-LLM PII Redaction + AES-256 + Append-only `risk_events`.
- Cập nhật `docs/02-PRD.md` lên **v0.2** đồng bộ với kiến trúc trong `docs/04-ARCHITECTURE.md` (phi mục tiêu `ADR-005`, `monotonic_risk_reducer`, `CRISIS_DETECTOR_TIMEOUT_MS=1500ms` / `detector_degraded`, 2 Agentic Loops trong LangGraph, Redis Pub/Sub + Sorted Set cho Takeover/SLA, `HNSW`/`Partial Index`, `AES-256-GCM`, `append-only` triggers, Break-glass audit, API `/v1/hotlines` & `/break-glass`, Latency Budget Breakdown).
- Cập nhật `demo/index.html`: tích hợp hiệu ứng lá rơi tự nhiên (`#leavesContainer`, `.falling-leaf`, `leafSVGs`, tôn trọng `prefers-reduced-motion: reduce`) vào giao diện demo đầy đủ chức năng hiện có; đồng bộ mô tả trong `docs/03-WIREFRAME-UI-FLOW.md`.
- Cập nhật `.env.example` (thêm `REDIS_URL`) và liên kết tài liệu tại `README.md`, `docs/01-BRIEF.md`, `docs/02-PRD.md`, `docs/03-WIREFRAME-UI-FLOW.md`.

## 4. Con người đã review & chỉnh sửa
| Hạng mục | Quyết định | Lý do |
|---|---|---|
| Chặn Live Web Search (Tavily/Serper) ở runtime (ADR-005) | ⏳ Chờ Tech Lead & PM duyệt | Tránh hallucinated hotline/nguồn y khoa chưa kiểm định |
| Ngân sách Latency P95 & Timeout `1500ms` | ⏳ Chờ benchmark Sprint 1 | Đang gắn nhãn `[ESTIMATE]` theo PRD |
| Region deploy Singapore vs Việt Nam | ⏳ Chờ Mentor & Tech Lead chốt | Mở ở PRD Q4, gắn `[ASSUMPTION]` / `[UNKNOWN]` |

## 5. Kiểm chứng
- [x] Đã đối chiếu toàn bộ API contract, bảng dữ liệu và luật an toàn với `docs/02-PRD.md` và `CLAUDE.md`
- [ ] Render thử 4 sơ đồ Mermaid trên GitHub / Mermaid Live Editor
- [x] Mọi chỉ số ước lượng/giả định đều gắn `[ESTIMATE]` / `[ASSUMPTION]` / `[UNKNOWN]`
- [x] Không có PII thật / secret trong prompt và output

## 6. Safety review (bắt buộc nếu chạm crisis rules / safety templates / guardrails / hotline)
| Reviewer | Vai trò | Kết luận |
|---|---|---|
| <!-- điền --> | Tech Lead / BE | Chờ review kiến trúc fast-path L-1 & fail-safe `detector_degraded` |
| <!-- điền --> | Cố vấn lâm sàng | Chờ review chính sách chặn Live Web Search (ADR-005) |

## 7. Files bị ảnh hưởng
- `docs/04-ARCHITECTURE.md` (tạo mới)
- `docs/02-PRD.md` (nâng lên v0.2 đồng bộ kiến trúc)
- `demo/index.html` (tích hợp hiệu ứng lá rơi tự nhiên)
- `.env.example` (thêm `REDIS_URL`)
- `README.md`, `docs/01-BRIEF.md`, `docs/03-WIREFRAME-UI-FLOW.md` (cập nhật liên kết & ghi chú wireframe)
- `ai-log/sessions/2026-11-15_be_system-architecture-adr.md`, `ai-log/INDEX.md`

## 8. Bài học / Ghi chú
- Cần tách rõ bài toán tìm kiếm web mở (Tavily/Serper phù hợp cho chatbot tổng hợp tin tức) với bài toán y tế có tính an toàn cao (chỉ truy xuất Curated Local KB + bảng `hotlines` đã xác minh ở runtime; chỉ dùng web search ở pipeline thu thập tài liệu offline có người duyệt).
