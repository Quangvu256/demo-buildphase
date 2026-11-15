# AI Log — Gate 1 deliverables (Brief, PRD, Wireframe, Repo setup)

| Trường | Giá trị |
|---|---|
| Ngày | 2026-11-15 |
| Thành viên | pm |
| Công cụ / Model | Claude Code (claude-opus-5-5), VS Code extension |
| Loại công việc | docs / design (lo-fi) / repo setup |
| Liên quan | Gate 1 · Epics E1–E9 |
| Thời lượng | <!-- điền --> |

## 1. Mục tiêu
Từ đề bài VMEC-20, tạo bộ deliverables Gate 1 (Brief, PRD, Wireframe/UI Flow, GitHub repo + AI log setup) với góc nhìn Senior PM.

## 2. Prompt chính
```text
[Dán đề VMEC-20 + danh sách deliverables]
"Thực hiện các yêu cầu trên dựa trên đề tài này dưới vai trò là 1 senior Project Manager"
```

## 3. Đầu ra của AI (tóm tắt)
- `docs/01-BRIEF.md`: problem statement, personas, 4 trụ cột, non-negotiables, scope MVP/Nâng cao, KPI, timeline giả định, rủi ro.
- `docs/02-PRD.md`: RBAC, ma trận nguy cơ L0–L3, phát hiện đa lớp, epics E1–E9 có acceptance criteria, kiến trúc LangGraph, data model, API contract, NFR, eval plan, rủi ro, RACI, open questions.
- `docs/03-WIREFRAME-UI-FLOW.md`: sitemap, wireframe ASCII (user mobile, counselor desktop, admin), 5 UI flow (Mermaid).
- Cấu trúc AI log, PR/Issue templates, CI check, script tạo log, `CLAUDE.md`, `.gitignore`, `.env.example`.

## 4. Con người đã review & chỉnh sửa
| Hạng mục | Quyết định | Lý do |
|---|---|---|
| Số hotline ngoài 115/113/111 | ⏳ Cần xác minh | AI đánh dấu `[UNVERIFIED]` |
| Mã LOINC PHQ-9/GAD-7 | ⏳ Cần xác minh trên loinc.org | `[UNVERIFIED]` |
| Ngưỡng SLA, KPI latency | ⏳ Team chốt | `[ASSUMPTION]`/`[ESTIMATE]` |
| Chính sách auto-notify người thân L3 | ⏳ Cố vấn lâm sàng chốt | PRD Q3 |

## 5. Kiểm chứng
- [x] Ngưỡng điểm PHQ-9 (0-4/5-9/10-14/15-19/20-27) và GAD-7 (0-4/5-9/10-14/15-21) khớp tài liệu chuẩn
- [ ] Xác minh hotline "Ngày Mai" (số + giờ hoạt động)
- [ ] Xác minh LOINC 44261-6, 70274-6
- [ ] Rà license các nguồn KB trước khi ingest
- [x] Không có PII thật trong prompt/output

## 6. Safety review
| Reviewer | Vai trò | Kết luận |
|---|---|---|
| <!-- điền --> | PM | Chờ review ma trận L0–L3 & safety flow |
| <!-- điền --> | Cố vấn lâm sàng | Chưa có |

## 7. Files bị ảnh hưởng
- `README.md`, `CLAUDE.md`, `.gitignore`, `.env.example`
- `docs/01-BRIEF.md`, `docs/02-PRD.md`, `docs/03-WIREFRAME-UI-FLOW.md`
- `ai-log/**`, `scripts/new-ai-log.*`, `.github/**`

## 8. Bài học / Ghi chú
- Mọi số liệu/mã chuẩn y khoa do AI đưa ra phải gắn tag trạng thái. Mục nào chưa xác minh thì đưa vào Open Questions của PRD.
