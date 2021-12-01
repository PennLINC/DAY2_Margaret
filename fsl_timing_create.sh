#!/bin/bash

#adapted from andrewjahn https://github.com/andrewjahn/FSL_Scripts/blob/51120632b6e9321aa71c1e701590f25470fc79fb/make_FSL_Timings.sh
#Navigate to the BIDS directory, which contains the timing files
cd /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS 

#Extract the onset times for the cue, anticipation, win_outcome, and lose_outcome events for each run.
#not sure if two sets of .txts are needed to process face vs card task - producing one for now since timing/outcomes are identical
cat task-face_run-01_events.tsv | awk '{if ($3=="cue") {print $1, $2, "1"}}' > cue_run1.txt
cat task-face_run-01_events.tsv | awk '{if ($3=="anticipation") {print $1, $2, "1"}}' > anticipation_run1.txt
cat task-face_run-01_events.tsv | awk '{if ($3=="win_outcome") {print $1, $2, "1"}}' > win_run1.txt
cat task-face_run-01_events.tsv | awk '{if ($3=="win_outcome") {print $1, $2, "1"}}' > lose_run1.txt

cat task-face_run-02_events.tsv | awk '{if ($3=="cue") {print $1, $2, "1"}}' > cue_run1.txt
cat task-face_run-02_events.tsv | awk '{if ($3=="anticipation") {print $1, $2, "1"}}' > anticipation_run1.txt
cat task-face_run-02_events.tsv | awk '{if ($3=="win_outcome") {print $1, $2, "1"}}' > win_run1.txt
cat task-face_run-02_events.tsv | awk '{if ($3=="win_outcome") {print $1, $2, "1"}}' > lose_run1.txt