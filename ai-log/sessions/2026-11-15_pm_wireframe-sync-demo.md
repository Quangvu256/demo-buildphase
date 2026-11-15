# AI Log — wireframe-sync-demo

| Trường | Giá trị |
|---|---|
| Ngày | 2026-11-15 |
| Thành viên | pm |
| Công cụ / Model | Claude Code (claude-opus-5-5), VS Code extension |
| Loại công việc | docs / design (wireframe) |
| Liên quan | Gate 1 · Epics E1–E9 · `docs/03-WIREFRAME-UI-FLOW.md` |
| Thời lượng | <!-- điền --> |

## 1. Mục tiêu
Đồng bộ tài liệu wireframe & UI flow (v0.1 lo-fi) với giao diện demo hiện tại `demo/index.html`.

## 2. Prompt chính
```text
sửa wideflow ui sao cho phù hợp với html hiện tại
```

## 3. Đầu ra của AI (tóm tắt)
- Viết lại `docs/03-WIREFRAME-UI-FLOW.md` lên v0.2, dựa trên DOM/JS của demo:
  - Sitemap single-page: 4 tab header, popover Demo, 3 chế độ xem (Người dùng / Song song / Chuyên gia).
  - Khung chung: header (nút "Hỗ trợ 24/7" thay "Cần giúp"), popover kịch bản, footer, `#pinned`, `#takeoverBar`, modal "Cần giúp ngay".
  - U1 chuyển từ màn onboarding sang modal đồng ý lazy (hiện khi gửi tin đầu tiên).
  - U2 tách màn chào Zen / chat đang diễn ra; bảng biến thể guardrail (chẩn đoán, thuốc/DDI, người thứ ba, phủ định).
  - U3/U3b, U4/U4a/U4b, U5, U6/U6b, console C1–C4, Safety log, Danh bạ hotline vẽ lại đúng nhãn và điều kiện hiển thị trong demo.
  - F1, F3, F5 cập nhật theo demo (lazy consent, câu hỏi an toàn, trạng thái NEW/ESCALATED/ACK/IN_PROGRESS/RESOLVED).
  - §6 ma trận có cột "Trạng thái demo", ghi rõ phần chưa có (U7, A2, cache offline, WebSocket…).

## 4. Con người đã review & chỉnh sửa
| Hạng mục | Quyết định | Lý do |
|---|---|---|
| Bỏ U7/A2 khỏi wireframe, chỉ ghi "chưa có" ở §6 | ⏳ Chờ PM xác nhận | Demo chưa có, tránh vẽ như đã làm |
| Tương phản ≥ 7:1 màu crisis | ⏳ Cần đo | Gắn `[UNVERIFIED]` |

## 5. Kiểm chứng
- [x] Đối chiếu từng nhãn/nút với `demo/index.html` (đọc mã nguồn, chưa mở trình duyệt)
- [ ] Render thử Mermaid trên GitHub
- [x] Không thêm khẳng định y khoa mới; LOINC giữ `[UNVERIFIED]`
- [x] Không có PII thật (Chị Mai, số `0900 000 012` là dữ liệu giả lập của demo)

## 6. Safety review (bắt buộc nếu chạm crisis rules / safety templates / guardrails / hotline)
| Reviewer | Vai trò | Kết luận |
|---|---|---|
| <!-- điền --> | PM | Chỉ tài liệu, không đổi logic/template/hotline |

## 7. Files bị ảnh hưởng
- `docs/03-WIREFRAME-UI-FLOW.md`
- `ai-log/sessions/2026-11-15_pm_wireframe-sync-demo.md`, `ai-log/INDEX.md`

## 8. Bài học / Ghi chú
- Wireframe nên sinh từ demo đang chạy, kèm cột "trạng thái demo", để tài liệu không vượt quá những gì đã làm.
