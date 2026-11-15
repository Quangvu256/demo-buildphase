# AI Log — Nhật ký sử dụng AI trong phát triển

> Ghi lại **minh bạch** cách team dùng AI để tạo code, tài liệu, dữ liệu: người làm, công cụ, mục đích, đầu ra, và con người đã kiểm chứng ra sao.

## 1. Phân biệt 2 loại log

| | **AI Log (thư mục này)** | **Safety/Audit log (runtime)** |
|---|---|---|
| Ghi gì | Team dùng AI để **xây dựng** sản phẩm | Agent Bình An **vận hành** với người dùng |
| Ở đâu | `ai-log/` trong git | Bảng `risk_events`, `audit_log`, `case_events` (PRD §6) |
| Ai đọc | BGK, mentor, team | Chuyên gia, admin, QA |

## 2. Quy tắc bắt buộc

1. **Mỗi phiên làm việc có AI tạo ra artifact được commit** (code, docs, prompt, test data, design) thì có **1 file log** trong `ai-log/sessions/`.
2. Tên file: `YYYY-MM-DD_<thanh-vien>_<chu-de>.md` (kebab-case, không dấu).
3. Dùng [TEMPLATE.md](TEMPLATE.md). Có thể tạo nhanh bằng script:
   ```bash
   ./scripts/new-ai-log.sh hoang crisis-detector-regex
   ```
   ```powershell
   .\scripts\new-ai-log.ps1 -Member hoang -Topic crisis-detector-regex
   ```
   Script tạo file từ template và thêm 1 dòng vào [INDEX.md](INDEX.md).
4. **Commit trailer** cho commit có nội dung do AI hỗ trợ:
   ```
   feat(agent): add crisis keyword layer L-1

   AI-Assisted: claude-sonnet / copilot
   AI-Log: ai-log/sessions/2026-11-16_hoang_crisis-detector-regex.md
   ```
5. **PR** phải điền mục "AI Usage" trong PR template. CI [`ai-log-check`](../.github/workflows/ai-log-check.yml) sẽ fail nếu thiếu.
6. **Không bao giờ** dán PII/PHI thật, API key, secret vào prompt hay vào log. Dữ liệu mẫu phải gắn `[SYNTHETIC]`.
7. Nội dung **nhạy cảm an toàn** (safety templates, crisis rules, danh bạ hotline, guardrail prompts) do AI sinh ra **bắt buộc** có người review được ghi tên trong log, và phải có cố vấn lâm sàng duyệt trước khi merge vào `main`.

## 3. Mức độ chi tiết

| Loại phiên | Mức log tối thiểu |
|---|---|
| Autocomplete nhỏ (Copilot gợi ý vài dòng) | Không cần file riêng; ghi `AI-Assisted: copilot` ở commit |
| Sinh hàm/module, tài liệu, test, dữ liệu | File log đầy đủ theo template |
| Prompt/rule/template an toàn | File log đầy đủ + mục **Safety review** bắt buộc |

## 4. Prompt có giá trị tái sử dụng

Prompt hệ thống của sản phẩm (system prompt, judge prompt) là **source code**: đặt ở `packages/agent/prompts/` và quản lý version. `ai-log/` chỉ ghi lại **quá trình tạo ra** chúng.
