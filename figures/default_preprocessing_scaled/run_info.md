# Experiment Summary

**Run ID:** `default_preprocessing_scaled_TranAD`  
**Generated:** 2026-09-09 15:18:04  
**Seed:** 42

---
## Data

**Dataset:** spt_snr  
**Train shape:** `(12268, 113, 1)`  
**Val shape:** `(3813, 113, 1)`  
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
**Total parameters:** 5.94M (5,938,545)  
**Trainable parameters:** 5.94M (5,938,545)  
**Input dims:** 113  

### Architecture
```
TranAD(
  (input_projection): Linear(in_features=226, out_features=256, bias=True)
  (target_projection): Linear(in_features=226, out_features=256, bias=True)
  (pos_encoder): PositionalEncoding(
    (dropout): Dropout(p=0.1, inplace=False)
  )
  (transformer_encoder): TransformerEncoder(
    (layers): ModuleList(
      (0-1): 2 x EfficientEncoderLayer(
        (self_attn): SDPAMultiheadAttention(
          (q_proj): Linear(in_features=256, out_features=256, bias=True)
          (k_proj): Linear(in_features=256, out_features=256, bias=True)
          (v_proj): Linear(in_features=256, out_features=256, bias=True)
          (out_proj): Linear(in_features=256, out_features=256, bias=True)
        )
        (linear1): Linear(in_features=256, out_features=1024, bias=True)
        (dropout): Dropout(p=0.1, inplace=False)
        (linear2): Linear(in_features=1024, out_features=256, bias=True)
        (norm1): LayerNorm((256,), eps=1e-05, elementwise_affine=True)
        (norm2): LayerNorm((256,), eps=1e-05, elementwise_affine=True)
        (dropout1): Dropout(p=0.1, inplace=False)
        (dropout2): Dropout(p=0.1, inplace=False)
      )
    )
  )
  (transformer_decoder1): TransformerDecoder(
    (layers): ModuleList(
      (0-1): 2 x EfficientDecoderLayer(
        (self_attn): SDPAMultiheadAttention(
          (q_proj): Linear(in_features=256, out_features=256, bias=True)
          (k_proj): Linear(in_features=256, out_features=256, bias=True)
          (v_proj): Linear(in_features=256, out_features=256, bias=True)
          (out_proj): Linear(in_features=256, out_features=256, bias=True)
        )
        (multihead_attn): SDPAMultiheadAttention(
          (q_proj): Linear(in_features=256, out_features=256, bias=True)
          (k_proj): Linear(in_features=256, out_features=256, bias=True)
          (v_proj): Linear(in_features=256, out_features=256, bias=True)
          (out_proj): Linear(in_features=256, out_features=256, bias=True)
        )
        (linear1): Linear(in_features=256, out_features=1024, bias=True)
        (dropout): Dropout(p=0.1, inplace=False)
        (linear2): Linear(in_features=1024, out_features=256, bias=True)
        (norm1): LayerNorm((256,), eps=1e-05, elementwise_affine=True)
        (norm2): LayerNorm((256,), eps=1e-05, elementwise_affine=True)
        (norm3): LayerNorm((256,), eps=1e-05, elementwise_affine=True)
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
          (q_proj): Linear(in_features=256, out_features=256, bias=True)
          (k_proj): Linear(in_features=256, out_features=256, bias=True)
          (v_proj): Linear(in_features=256, out_features=256, bias=True)
          (out_proj): Linear(in_features=256, out_features=256, bias=True)
        )
        (multihead_attn): SDPAMultiheadAttention(
          (q_proj): Linear(in_features=256, out_features=256, bias=True)
          (k_proj): Linear(in_features=256, out_features=256, bias=True)
          (v_proj): Linear(in_features=256, out_features=256, bias=True)
          (out_proj): Linear(in_features=256, out_features=256, bias=True)
        )
        (linear1): Linear(in_features=256, out_features=1024, bias=True)
        (dropout): Dropout(p=0.1, inplace=False)
        (linear2): Linear(in_features=1024, out_features=256, bias=True)
        (norm1): LayerNorm((256,), eps=1e-05, elementwise_affine=True)
        (norm2): LayerNorm((256,), eps=1e-05, elementwise_affine=True)
        (norm3): LayerNorm((256,), eps=1e-05, elementwise_affine=True)
        (dropout1): Dropout(p=0.1, inplace=False)
        (dropout2): Dropout(p=0.1, inplace=False)
        (dropout3): Dropout(p=0.1, inplace=False)
      )
    )
  )
  (output_proj): Sequential(
    (0): Linear(in_features=256, out_features=113, bias=True)
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
**Final train loss:** 0.004764  
**Training time:** 00:14:36  
**training_started_at:** 2026-09-09 15:03:26  
**training_finished_at:** 2026-09-09 15:18:02  
**final_val_loss:** 0.002239262731745839  

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
