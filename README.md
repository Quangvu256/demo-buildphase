# BÌNH AN — AI Agent đồng hành sức khỏe tinh thần (VMEC-20)

> **Codename:** Bình An · **Khối:** Y tế – Ứng dụng chăm sóc sức khỏe & Hỗ trợ lâm sàng · **Mã đề:** VMEC-20

> ⚠️ **Giới hạn:** Bình An là công cụ **hỗ trợ ban đầu**. Bình An **KHÔNG chẩn đoán** rối loạn tâm thần, **KHÔNG thay thế** trị liệu, **KHÔNG kê/tư vấn liều thuốc**.
> Nếu bạn hoặc người thân đang gặp nguy hiểm ngay lúc này: **gọi 115 (Cấp cứu)**.

---

## Deliverables — Gate 1

| # | Deliverable | File | Trạng thái |
|---|---|---|---|
| 1 | Project Brief | [docs/01-BRIEF.md](docs/01-BRIEF.md) | ✅ v0.1 |
| 2 | PRD | [docs/02-PRD.md](docs/02-PRD.md) | ✅ v0.1 |
| 3 | Wireframe & UI Flow | [docs/03-WIREFRAME-UI-FLOW.md](docs/03-WIREFRAME-UI-FLOW.md) | ✅ v0.1 |
| 4 | GitHub Repo + AI Log setup | [ai-log/README.md](ai-log/README.md), [.github/](.github/), [CLAUDE.md](CLAUDE.md) | ✅ v0.1 |
| 5 | System Architecture & ADRs | [docs/04-ARCHITECTURE.md](docs/04-ARCHITECTURE.md) | ✅ v0.1 |

## Cấu trúc repo

```
.
├── README.md
├── CLAUDE.md                     # Luật bắt buộc cho mọi AI coding agent làm việc trong repo
├── .env.example                  # Mẫu biến môi trường (KHÔNG commit .env thật)
├── docs/
│   ├── 01-BRIEF.md
│   ├── 02-PRD.md
│   ├── 03-WIREFRAME-UI-FLOW.md
│   └── 04-ARCHITECTURE.md
├── ai-log/                       # Nhật ký sử dụng AI trong quá trình phát triển
│   ├── README.md                 # Chính sách + quy ước
│   ├── TEMPLATE.md
│   ├── INDEX.md
│   └── sessions/
├── scripts/
│   ├── new-ai-log.sh             # Tạo entry AI log (bash)
│   └── new-ai-log.ps1            # Tạo entry AI log (PowerShell)
└── .github/
    ├── pull_request_template.md
    ├── ISSUE_TEMPLATE/
    └── workflows/ai-log-check.yml
```

Thư mục code (`apps/web`, `apps/api`, `packages/agent`, `tests/safety`) sẽ được tạo ở Sprint 1, theo kiến trúc mô tả trong PRD §7.

## Tech stack (theo PRD)

Next.js (web, 3 vai trò) · FastAPI · LangGraph · Postgres + pgvector · RAG trên tài liệu CBT/tự chăm sóc có nguồn · HL7 FHIR R4 export · Deploy cloud.

## Quy tắc làm việc với AI

Mọi phiên làm việc có dùng AI (ChatGPT, Claude, Copilot, Cursor…) để tạo code, tài liệu hoặc dữ liệu **phải có AI log**. Xem [ai-log/README.md](ai-log/README.md).

```bash
./scripts/new-ai-log.sh <ten-thanh-vien> <chu-de>       # macOS/Linux/Git Bash
.\scripts\new-ai-log.ps1 -Member <ten> -Topic <chu-de>   # Windows PowerShell
```
