# SPT preprocessing timestep-drop threshold study

This document summarizes the recent SPT preprocessing threshold scans and plot outputs so another agent can quickly pick up the work.

## Objective

We are studying how SPT preprocessing behaves when varying the timestep-drop threshold in `spt_timestep_trim.yml`.

The goal is to understand:

- how many samples are kept or trimmed at each threshold;
- how lower-tail pre-scale signal statistics change as the threshold is relaxed;
- whether there is a useful cutoff before lower-tail quality noticeably degrades.

## Main scripts

### Audit scan runner

```text
scripts/spt/run_preprocessing_audits.sh
```

Purpose:

- Runs preprocessing-only audits for SPT configs.
- Uses:

```bash
python scripts/spt/run_spt.py --no-train --no-plot --print-preprocessing-audit
```

- Generates temporary YAML configs for threshold scans.
- Does **not** permanently modify tracked YAML configs.
- Temp configs are written under:

```text
${TMPDIR:-/tmp}/anldq_spt_timestep_scan
```

Thresholds scanned:

```text
1%, 2%, 3%, 4%, 5%, 10%, 50%, 100%
```

Tag convention:

```text
spt_timestep_trim_drop001
spt_timestep_trim_drop002
spt_timestep_trim_drop003
spt_timestep_trim_drop004
spt_timestep_trim_drop005
spt_timestep_trim_drop010
spt_timestep_trim_drop050
spt_timestep_trim_drop100
```

`100%` is the no-cut baseline.

There is also an older/existing `20%` scan result:

```text
spt_timestep_trim_drop020
```

### Scan plotting script

```text
scripts/spt/plot_preprocessing_scan.py
```

Purpose:

- Reads existing per-threshold audit CSVs.
- Produces a compact threshold scan summary CSV and plots.
- Uses categorical/even spacing for threshold labels.
- Writes outputs either to the SPT output directory by default or to a chosen `--output-dir`.

Typical command used:

```bash
python scripts/spt/plot_preprocessing_scan.py \
  --spt-dir /lcrc/project/AIDQ/users/lvaughan/run/spt \
  --output-dir /home/lvaughan/Work/Slides/spt_preprocessing_study/figures
```

The stats plot was intentionally revised to focus only on lower-tail statistics:

```text
min, q01, q05
```

Mean, median, and upper quantiles were removed from that plot because they made the figure less useful visually.

## Output locations

### Main SPT output tree

```text
/lcrc/project/AIDQ/users/lvaughan/run/spt
```

Per-threshold audit CSVs live under directories like:

```text
/lcrc/project/AIDQ/users/lvaughan/run/spt/spt_timestep_trim_drop001/preprocessing_audit.csv
/lcrc/project/AIDQ/users/lvaughan/run/spt/spt_timestep_trim_drop002/preprocessing_audit.csv
...
/lcrc/project/AIDQ/users/lvaughan/run/spt/spt_timestep_trim_drop100/preprocessing_audit.csv
```

Generated summary outputs in the SPT output tree:

```text
/lcrc/project/AIDQ/users/lvaughan/run/spt/spt_timestep_trim_threshold_scan_summary.csv
/lcrc/project/AIDQ/users/lvaughan/run/spt/spt_timestep_trim_threshold_scan_timesteps.png
/lcrc/project/AIDQ/users/lvaughan/run/spt/spt_timestep_trim_threshold_scan_stats.png
```

### Slides figures directory

Everything important has also been copied/written here:

```text
/home/lvaughan/Work/Slides/spt_preprocessing_study/figures
```

Current relevant files there:

```text
spt_timestep_trim_threshold_scan_summary.csv
spt_timestep_trim_threshold_scan_timesteps.png
spt_timestep_trim_threshold_scan_stats.png

spt_configured_preprocessing_audit.csv
spt_timestep_trim_drop001_preprocessing_audit.csv
spt_timestep_trim_drop002_preprocessing_audit.csv
spt_timestep_trim_drop003_preprocessing_audit.csv
spt_timestep_trim_drop004_preprocessing_audit.csv
spt_timestep_trim_drop005_preprocessing_audit.csv
spt_timestep_trim_drop010_preprocessing_audit.csv
spt_timestep_trim_drop020_preprocessing_audit.csv
spt_timestep_trim_drop050_preprocessing_audit.csv
spt_timestep_trim_drop100_preprocessing_audit.csv
```

There are also older PNG audit plots in the slides folder for selected thresholds.

## Main summary CSV

The main summary file is:

```text
/home/lvaughan/Work/Slides/spt_preprocessing_study/figures/spt_timestep_trim_threshold_scan_summary.csv
```

Columns include:

```text
threshold
tag
train_kept
train_trimmed
train_trimmed_frac
val_kept
val_trimmed
val_trimmed_frac
train_min
train_mean
train_median
train_q01
train_q05
train_q95
train_q99
val_min
val_mean
val_median
val_q01
val_q05
val_q95
val_q99
```

Kept sample counts from the latest scan:

| threshold | train kept | val kept |
|---:|---:|---:|
| 1% | 10,740 | 3,430 |
| 2% | 14,665 | 4,913 |
| 3% | 14,988 | 5,000 |
| 4% | 15,550 | 5,186 |
| 5% | 18,115 | 6,095 |
| 10% | 18,981 | 6,386 |
| 50% | 19,245 | 6,418 |
| 100% | 19,274 | 6,423 |

The `100%` baseline confirms:

```text
train = 19,274
val = 6,423
channels = 2700
```

## Important observation

There is a noticeable lower-tail degradation between the `4%` and `5%` thresholds.

From the summary CSV:

### Train split

| threshold | q01 | q05 |
|---:|---:|---:|
| 4% | 36.824 | 54.492 |
| 5% | 29.507 | 49.971 |

Change from `4%` to `5%`:

```text
train q01 drops by ~7.317
train q05 drops by ~4.520
```

### Validation split

| threshold | q01 | q05 |
|---:|---:|---:|
| 4% | 37.043 | 54.471 |
| 5% | 29.575 | 49.992 |

Change from `4%` to `5%`:

```text
val q01 drops by ~7.468
val q05 drops by ~4.480
```

This coincides with a large jump in kept samples:

| threshold | train kept | val kept |
|---:|---:|---:|
| 4% | 15,550 | 5,186 |
| 5% | 18,115 | 6,095 |

So moving from `4%` to `5%` keeps:

```text
+2,565 train samples
+909 validation samples
```

but those added samples appear to substantially worsen the lower-tail pre-scale distribution.

## Interpretation so far

The threshold scan suggests a tradeoff:

- Very strict thresholds such as `1%` remove many samples.
- Looser thresholds retain many more samples.
- The most visually and quantitatively interesting transition is between `4%` and `5%`.
- `4%` appears to be a potential cleaner cutoff before a noticeable lower-tail quality drop.
- `5%` and above preserve more data but include more low-tail / possibly poorer-quality samples.
- `100%` is the no-cut baseline and keeps everything.

For plots/slides, focus on:

```text
spt_timestep_trim_threshold_scan_timesteps.png
spt_timestep_trim_threshold_scan_stats.png
spt_timestep_trim_threshold_scan_summary.csv
```

The stats plot intentionally emphasizes:

```text
min, q01, q05
```

because those reveal the relevant lower-tail quality drop.
