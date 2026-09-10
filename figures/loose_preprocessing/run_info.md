# Experiment Summary

**Run ID:** `loose_preprocessing_TranAD`  
**Generated:** 2026-09-09 19:32:15  
**Seed:** 42

---
## Data

**Dataset:** spt_snr  
**Train shape:** `(19274, 2700, 1)`  
**Val shape:** `(6423, 2700, 1)`  
**Scaling:** type=robust | mode=per_dim | source=train_set_fit  
**baseline_enabled:** False  
**baseline_mode:** per_channel  
**baseline_stat:** mean  
**baseline_type:** constant  
**baseline_scope:** per_channel  
**masking:**
```json
{
  "time_mask_mode": "drop",
  "time_mask": null,
  "channel_mask_mode": "drop",
  "channel_mask": {
    "type": "list",
    "count": 0,
    "preview": []
  },
  "channel_drop": null,
  "feature_keep": null,
  "feature_drop": null
}
```

---
## Model

**Model:** TranAD  
**Total parameters:** 346.62M (346,618,508)  
**Trainable parameters:** 346.62M (346,618,508)  
**Input dims:** 2700  

### Architecture
```
TranAD(
  (input_projection): Linear(in_features=5400, out_features=2048, bias=True)
  (target_projection): Linear(in_features=5400, out_features=2048, bias=True)
  (pos_encoder): PositionalEncoding(
    (dropout): Dropout(p=0.1, inplace=False)
  )
  (transformer_encoder): TransformerEncoder(
    (layers): ModuleList(
      (0-1): 2 x EfficientEncoderLayer(
        (self_attn): SDPAMultiheadAttention(
          (q_proj): Linear(in_features=2048, out_features=2048, bias=True)
          (k_proj): Linear(in_features=2048, out_features=2048, bias=True)
          (v_proj): Linear(in_features=2048, out_features=2048, bias=True)
          (out_proj): Linear(in_features=2048, out_features=2048, bias=True)
        )
        (linear1): Linear(in_features=2048, out_features=6144, bias=True)
        (dropout): Dropout(p=0.1, inplace=False)
        (linear2): Linear(in_features=6144, out_features=2048, bias=True)
        (norm1): LayerNorm((2048,), eps=1e-05, elementwise_affine=True)
        (norm2): LayerNorm((2048,), eps=1e-05, elementwise_affine=True)
        (dropout1): Dropout(p=0.1, inplace=False)
        (dropout2): Dropout(p=0.1, inplace=False)
      )
    )
  )
  (transformer_decoder1): TransformerDecoder(
    (layers): ModuleList(
      (0-1): 2 x EfficientDecoderLayer(
        (self_attn): SDPAMultiheadAttention(
          (q_proj): Linear(in_features=2048, out_features=2048, bias=True)
          (k_proj): Linear(in_features=2048, out_features=2048, bias=True)
          (v_proj): Linear(in_features=2048, out_features=2048, bias=True)
          (out_proj): Linear(in_features=2048, out_features=2048, bias=True)
        )
        (multihead_attn): SDPAMultiheadAttention(
          (q_proj): Linear(in_features=2048, out_features=2048, bias=True)
          (k_proj): Linear(in_features=2048, out_features=2048, bias=True)
          (v_proj): Linear(in_features=2048, out_features=2048, bias=True)
          (out_proj): Linear(in_features=2048, out_features=2048, bias=True)
        )
        (linear1): Linear(in_features=2048, out_features=6144, bias=True)
        (dropout): Dropout(p=0.1, inplace=False)
        (linear2): Linear(in_features=6144, out_features=2048, bias=True)
        (norm1): LayerNorm((2048,), eps=1e-05, elementwise_affine=True)
        (norm2): LayerNorm((2048,), eps=1e-05, elementwise_affine=True)
        (norm3): LayerNorm((2048,), eps=1e-05, elementwise_affine=True)
        (dropout1): Dropout(p=0.1, inplace=False)
        (dropout2): Dropout(p=0.1, inplace=False)
        (dropout3): Dropout(p=0.1, inplace=False)
      )
    )
  )
  (transformer_decoder2): TransformerDecoder(
    (layers): ModuleList(
      (0-1): 2 x EfficientDecoderLayer(
        (self_attn): SDPAMultiheadAttention(
          (q_proj): Linear(in_features=2048, out_features=2048, bias=True)
          (k_proj): Linear(in_features=2048, out_features=2048, bias=True)
          (v_proj): Linear(in_features=2048, out_features=2048, bias=True)
          (out_proj): Linear(in_features=2048, out_features=2048, bias=True)
        )
        (multihead_attn): SDPAMultiheadAttention(
          (q_proj): Linear(in_features=2048, out_features=2048, bias=True)
          (k_proj): Linear(in_features=2048, out_features=2048, bias=True)
          (v_proj): Linear(in_features=2048, out_features=2048, bias=True)
          (out_proj): Linear(in_features=2048, out_features=2048, bias=True)
        )
        (linear1): Linear(in_features=2048, out_features=6144, bias=True)
        (dropout): Dropout(p=0.1, inplace=False)
        (linear2): Linear(in_features=6144, out_features=2048, bias=True)
        (norm1): LayerNorm((2048,), eps=1e-05, elementwise_affine=True)
        (norm2): LayerNorm((2048,), eps=1e-05, elementwise_affine=True)
        (norm3): LayerNorm((2048,), eps=1e-05, elementwise_affine=True)
        (dropout1): Dropout(p=0.1, inplace=False)
        (dropout2): Dropout(p=0.1, inplace=False)
        (dropout3): Dropout(p=0.1, inplace=False)
      )
    )
  )
  (output_proj): Sequential(
    (0): Linear(in_features=2048, out_features=2700, bias=True)
    (1): Identity()
  )
)
```

---
## Training Configuration

| Parameter | Value |
|-----------|-------|
| Learning rate | 0.0001 |
| Batch size | 256 |
| Epochs | 100 |
| Optimizer | AdamW |
| Weight decay | 1e-05 |
| Scheduler | CosineAnnealingLR |
| Device | cuda |
| Precision | float32 |
| Early stopping | False (patience=10) |
| Gradient clipping | norm=None, value=1.0 |

---
## Training Results

**Final epoch:** 99  
**Final train loss:** 0.074999  
**Training time:** 04:12:24  
**training_started_at:** 2026-09-09 15:19:44  
**training_finished_at:** 2026-09-09 19:32:09  
**final_val_loss:** 0.13276311611899963  

---
## Device information

**resolved_device:** cuda  
**amp_enabled:** True  
**cuda_device_name:** NVIDIA A100-SXM4-40GB  
**cuda_device_index:** 0  

---
## Output Files

- Checkpoints: `checkpoints/`
- Loss plot: `loss_curve.pdf`
- Loss data: `loss_curve.csv`
