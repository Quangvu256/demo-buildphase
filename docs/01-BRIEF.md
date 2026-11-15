# 01 — PROJECT BRIEF: BÌNH AN (VMEC-20)

| Trường | Giá trị |
|---|---|
| Đề tài | AI Agent Trợ Lý Sức Khỏe Tinh Thần Với Cảnh Báo An Toàn & Khủng Hoảng |
| Mã đề | VMEC-20 |
| Phiên bản | v0.1 — Gate 1 |
| Ngày | 2026-11-15 |
| Owner | Project Manager |
| Trạng thái | Draft, chờ team review |
| Tài liệu liên quan | [PRD](02-PRD.md) · [Wireframe & UI Flow](03-WIREFRAME-UI-FLOW.md) |

---

## 1. Bối cảnh

- Nhu cầu hỗ trợ sức khỏe tinh thần (stress, lo âu, mất ngủ, trầm cảm nhẹ) đang tăng, rõ nhất ở **sinh viên và người mới đi làm (18–30 tuổi)**.
- Chuyên gia tâm lý ít, chi phí cao, và người dùng ngại tìm đến (sợ kỳ thị, không biết bắt đầu từ đâu).
- Hệ quả: người cần giúp không được hỗ trợ sớm. Nguy hiểm hơn, **các dấu hiệu khủng hoảng (ý định tự hại/tự tử) bị bỏ sót** vì không có ai lắng nghe đúng lúc.
- Các chatbot "tâm sự" phổ thông có ba vấn đề: tự đưa ra chẩn đoán, bịa nội dung, và không có quy trình chuyển ca cho người thật khi có nguy cơ.

## 2. Problem Statement

> Người trẻ 18–30 tuổi đang gặp căng thẳng tâm lý cần một **kênh hỗ trợ ban đầu ẩn danh, sẵn sàng 24/7 và an toàn**. Chuyên gia thì cần **được báo đúng ca, đúng lúc** để can thiệp khi có nguy cơ, thay vì bị quá tải bởi những ca nhẹ.

## 3. Người dùng mục tiêu

| Persona | Mô tả | Việc cần làm (JTBD) |
|---|---|---|
| **Minh, 20 tuổi, sinh viên** | Áp lực thi cử, mất ngủ, ngại nói với gia đình | "Khi tôi căng thẳng lúc 2 giờ sáng, tôi muốn có ai đó lắng nghe và chỉ tôi cách bình tĩnh lại, mà không bị phán xét." |
| **Lan, 24 tuổi, mới đi làm** | Lo âu công việc, burnout | "Tôi muốn theo dõi tâm trạng của mình và biết khi nào nên đi gặp chuyên gia." |
| **ThS. Hà, chuyên gia tâm lý** | Phụ trách tư vấn tại trường/tổ chức | "Tôi muốn biết ngay ca nào có nguy cơ cao, kèm bằng chứng và bối cảnh, để can thiệp kịp thời." |
| **Điều phối viên / Admin** | Vận hành hệ thống | "Tôi muốn đảm bảo không có cảnh báo nào bị bỏ quên, và danh bạ đường dây nóng luôn đúng." |

## 4. Giải pháp: 4 trụ cột

```
 LẮNG NGHE  ──►  SÀNG LỌC  ──►  TỰ CHĂM SÓC  ──►  ESCALATE (khi cần)
 (đồng cảm)     (PHQ-9/GAD-7)   (RAG có nguồn)    (HITL bắt buộc)
        ▲                                                │
        └──────── Lưới an toàn khủng hoảng chạy song song ┘
                  ở MỌI lượt hội thoại (ưu tiên cao nhất)
```

1. **Hội thoại đồng cảm:** trò chuyện theo kỹ thuật lắng nghe phản hồi (reflective listening), không phán xét.
2. **Sàng lọc định kỳ:** thang PHQ-9 / GAD-7 (mô phỏng). Kết quả chỉ báo **mức độ triệu chứng** và khuyến nghị, **không gắn nhãn bệnh**.
3. **Tự chăm sóc có kiểm chứng:** bài tập thở, CBT nền tảng (nhận diện suy nghĩ tự động), nhật ký cảm xúc. Mọi gợi ý **phải kèm nguồn** (RAG).
4. **Lưới an toàn khủng hoảng:** bộ phát hiện nhiều lớp. Khi có nguy cơ thì **ngay lập tức** hiện đường dây nóng, quy trình an toàn, và tạo ca cho chuyên gia (HITL).

Bổ sung (Nâng cao): bộ quy tắc y khoa xác định (triệu chứng cờ đỏ, tương tác thuốc) và chuẩn hóa đầu ra theo **HL7 FHIR R4** để bàn giao cho nhân viên y tế.

## 5. Nguyên tắc bất khả xâm phạm (Non-negotiables)

| # | Nguyên tắc | Cách thực thi |
|---|---|---|
| N1 | **AI không chẩn đoán, không kê thuốc** | Guardrail đầu ra chặn tên bệnh/ICD-10/liều thuốc. Test đối kháng (adversarial) trong CI. |
| N2 | **Khủng hoảng → hiện hotline NGAY** | Phản hồi khủng hoảng là **template cố định**, không để LLM tự sinh. Mục tiêu P95 < 2s. |
| N3 | **HITL bắt buộc** cho ca nguy cơ | Tạo case, báo realtime cho chuyên gia, có SLA. Quá SLA thì escalate lên điều phối viên. |
| N4 | **Fail-safe** | Nếu LLM hoặc classifier lỗi/timeout thì **mặc định hiện tài nguyên an toàn**, không im lặng. |
| N5 | **Grounded, chống bịa** | Bài tập và tài nguyên chỉ lấy từ KB đã duyệt. Số hotline chỉ lấy từ DB đã xác minh. |
| N6 | **Bảo mật PII/PHI** | Ẩn danh hóa, redact PII trước khi gửi LLM, mã hóa at-rest, có consent rõ ràng, người dùng xóa được dữ liệu. |
| N7 | **Minh bạch giới hạn** | Disclaimer hiện ở onboarding, footer chat và mọi kết quả sàng lọc. |

## 6. Phạm vi

| Hạng mục | MVP (Cơ bản) — bắt buộc | Nâng cao — nếu kịp | Ngoài phạm vi |
|---|---|---|---|
| Vai trò | User, Chuyên gia (+ Admin tối giản) | Điều phối viên đầy đủ | Bác sĩ kê đơn |
| Hội thoại | Chat đồng cảm + RAG bài tập có nguồn | Memory phiên (ẩn danh), cá nhân hóa thư viện | Trị liệu dài hạn |
| Sàng lọc | PHQ-9, GAD-7 định kỳ | Xu hướng theo thời gian | Chẩn đoán lâm sàng |
| Khủng hoảng | Phát hiện → hotline + quy trình an toàn | Đa lớp (keyword + classifier + LLM judge), HITL console realtime, liên hệ người thân (có đồng ý) | Tự động gọi 115 |
| Nhật ký | — | Nhật ký cảm xúc + biểu đồ xu hướng | Wearable |
| Y khoa | Disclaimer | Red-flag triage, tương tác thuốc, FHIR R4 export | Tích hợp HIS/EMR thật |
| QA | Safety test suite cơ bản | Log & báo cáo kiểm thử an toàn riêng | Thử nghiệm lâm sàng |
| Deploy | Cloud, demo được | Monitoring/tracing | Production thật với dữ liệu thật |

## 7. Chỉ số thành công

**North Star:** *% ca nguy cơ (L2–L3) có chuyên gia tiếp nhận trong SLA.*

| Nhóm | KPI | Mục tiêu demo |
|---|---|---|
| An toàn | Recall phát hiện khủng hoảng trên safety test set `[SYNTHETIC]` | ≥ 98%; **100% với L3** `[ESTIMATE]` |
| An toàn | Tỷ lệ lọt chẩn đoán/kê thuốc (adversarial set) | 0% |
| An toàn | Số hotline bị bịa (không có trong DB) | 0 |
| Tốc độ | Thời gian từ tin nhắn nguy cơ đến khi hiện Safety Card (P95) | < 2s `[ESTIMATE]` |
| HITL | Thời gian chuyên gia acknowledge case (demo) | < 5 phút |
| Chất lượng | % gợi ý bài tập có trích dẫn nguồn hợp lệ | 100% |
| Trải nghiệm | Điểm đồng cảm (rubric 1–5, chuyên gia chấm 50 hội thoại) | ≥ 4.0 |

## 8. Stakeholders

| Bên liên quan | Quan tâm chính |
|---|---|
| Người dùng cuối | An toàn, ẩn danh, được lắng nghe |
| Chuyên gia tâm lý | Cảnh báo chính xác, đủ bối cảnh, không bị quá tải báo động giả |
| Ban giám khảo / Mentor | Tính an toàn, HITL, khả thi kỹ thuật, demo chạy được |
| Cố vấn lâm sàng (cần tìm) | Nội dung CBT chuẩn, quy trình khủng hoảng đúng thực hành |

## 9. Lộ trình `[ASSUMPTION — chờ lịch Gate chính thức]`

| Mốc | Nội dung | Đầu ra |
|---|---|---|
| **Gate 1** (2026-11-15) | Brief, PRD, Wireframe, Repo + AI Log | Tài liệu này |
| Sprint 1 | Auth 2 vai trò, chat skeleton (LangGraph), crisis lớp 1 + Safety Card, danh bạ hotline, deploy skeleton | App chạy được end-to-end |
| Sprint 2 | RAG KB, PHQ-9/GAD-7, console chuyên gia realtime, crisis lớp 2–3, safety test suite v1 | MVP đủ yêu cầu Cơ bản |
| Sprint 3 | Nhật ký + xu hướng, memory, liên hệ người thân, red-flag/thuốc, FHIR export, hardening | Demo cuối, có phần Nâng cao |

## 10. Rủi ro hàng đầu

| Rủi ro | Mức | Giảm thiểu |
|---|---|---|
| Bỏ sót ca khủng hoảng (false negative) | 🔴 Nghiêm trọng | Phát hiện đa lớp, ưu tiên recall, template cố định, review mỗi ca bỏ sót |
| AI "chẩn đoán" hoặc đưa lời khuyên y khoa sai | 🔴 | Guardrail đầu ra + adversarial test trong CI |
| Lộ dữ liệu sức khỏe nhạy cảm | 🔴 | Redact PII, mã hóa, chỉ dùng dữ liệu `[SYNTHETIC]` cho demo |
| Tiếng Việt không dấu, teencode, nói vòng làm giảm recall | 🟠 | Chuẩn hóa văn bản, bộ test riêng cho không dấu/teencode |
| Thiếu cố vấn lâm sàng thẩm định nội dung | 🟠 | Chỉ dùng nguồn công khai uy tín, ghi rõ nguồn, tìm mentor y tế sớm |

## 11. Giả định & điểm chưa rõ

- `[ASSUMPTION]` Team 4–6 người: PM, Tech Lead/BE, AI Engineer, FE, QA/Safety (kiêm nhiệm).
- `[ASSUMPTION]` Chỉ dùng dữ liệu `[SYNTHETIC]` (Synthea, hội thoại tự tạo). Không dùng dữ liệu người dùng thật.
- `[UNKNOWN]` Lịch Gate 2/3 và tiêu chí chấm chi tiết.
- `[UNKNOWN]` Có cố vấn lâm sàng/chuyên gia tâm lý thật tham gia đóng vai "Chuyên gia" trong demo hay không.
- `[UNKNOWN]` Ngân sách API LLM và cloud.
