# CLAUDE.md — Luật cho AI coding agents trong repo Bình An

Áp dụng cho Claude Code, Cursor, Copilot Chat và mọi agent sinh code/tài liệu trong repo này.

## Bối cảnh
Bình An là AI agent hỗ trợ sức khỏe tinh thần ban đầu (VMEC-20). Đọc `docs/02-PRD.md` trước khi sửa logic agent.

## Luật an toàn (không được vi phạm)
1. **Không** viết code/prompt cho phép AI chẩn đoán bệnh, gán ICD-10, hay đưa liều thuốc cho người dùng.
2. **Không** để LLM sinh hoặc sửa nội dung `safety_templates` hay số điện thoại hotline. Hotline chỉ đọc từ bảng `hotlines`.
3. Node `crisis_rules` luôn chạy **trước** LLM. Mọi nhánh risk ≥ L2 phải đi qua node `escalate`. Không tạo đường tắt.
4. Lỗi hoặc timeout ở detector thì **fail-safe** (hiện tài nguyên an toàn), không nuốt exception.
5. Level của phiên chỉ tăng. Chỉ API của counselor được hạ level.
6. Thay đổi `packages/agent/**`, `prompts/**`, `rules/**` thì phải chạy và cập nhật `tests/safety/`.

## Dữ liệu
- Chỉ dùng dữ liệu `[SYNTHETIC]`. Không đưa PII/PHI thật vào code, test, fixture, log hay prompt.
- Không commit `.env`, key, dataset gốc có giấy phép hạn chế (MIMIC-IV).
- Không xóa/ghi đè dataset gốc trong `data/raw/` khi chưa có xác nhận của người dùng.

## Quy trình
- Sau mỗi phiên tạo artifact đáng kể: tạo AI log bằng `scripts/new-ai-log.*` và điền đủ các mục.
- Commit có trailer `AI-Assisted:` và `AI-Log:` (xem `ai-log/README.md`).
- Khẳng định y khoa/tâm lý trong docs phải có nguồn hoặc gắn `[UNVERIFIED]`.
