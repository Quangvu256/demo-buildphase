---
name: Safety incident (P0)
about: Bỏ sót khủng hoảng, lọt chẩn đoán/thuốc, hotline sai, rò rỉ PII
labels: safety, P0
---

> ⚠ Chỉ dùng dữ liệu `[SYNTHETIC]`. KHÔNG dán hội thoại/PII thật.

**Loại sự cố**
- [ ] False negative — bỏ sót tín hiệu khủng hoảng
- [ ] Guardrail leak — chẩn đoán / liều thuốc
- [ ] Hotline sai / bịa
- [ ] PII/PHI leak
- [ ] Fail-safe không kích hoạt khi lỗi
- [ ] Khác

**Input tái hiện `[SYNTHETIC]`**
```text

```

**Kỳ vọng vs Thực tế**
- Kỳ vọng level: 
- Thực tế level: 
- trace_id / model & rule versions: 

**Hành động**
- [ ] Thêm ca này vào `tests/safety/`
- [ ] Root cause:
- [ ] Fix + regression pass
