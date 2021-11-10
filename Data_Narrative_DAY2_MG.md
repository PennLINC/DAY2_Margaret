## Data Narrative for DAY2 - Margaret's Curation

### Important Links (should all be on GitHub):
* Data Processing Flow Diagram:
   * Flow diagram that describes the lifecycle of this dataset 
* DSR GitHub Project Page(Curation/Validation and Processing Queue Status):
   * Cards for tracking the curation and validation portion of the dataset. This page should be updated every time you perform an action on the data. 
   * Cards for tracking the progress of containerized pipeline runs on the data. 
   
### Plan for the Data 

* Why does PennLINC need this data?
* For which project(s) is it intended? Please link to project pages below:
* Goal is to curate and preprocess data

### Data Acquisition

* Who is responsible for acquiring this data?
* Do you have a DUA? Who is allowed to access the data?
* Where was the data acquired? 
* Describe the data. What type of information do we have? Things to specify include:
   * number of subjects = 125
   * types of images = bold (2 runs task-face, 2 runs task-card, rest), T1, 
   * demographic data
   * clinical/cognitive data
   * any canned QC data
   * any preprocessed or derived data

### Download and Storage 

* Who is responsible for downloading this data?
* From where was the data downloaded?
* Where is it currently being stored?
* What form is the data in upon intial download (DICOMS, NIFTIS, something else?)
* Is the data backed up in a second location? If so, please provide the path to the backup location:

* Data was stored as nifti files in `/cbica/projects/wolf_satterthwaite_reward/original_data/bidsdatasets/day2`.
* Data was copied by Margaret to sub-project folder `/cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/original_data on 9/14/2021`.

* JSON's within origial_data were updated using `cubids-add-nifti-info`.

* Listing metadata fields using `cubids-print-metadata-fields` resulted:
    * Acknowledgements
    * AcquisitionMatrixPE
    * AcquisitionNumber
    * Authors
    * BIDSVersion
    * BandwidthPerPixelPhaseEncode
    * BaseResolution
    * CoilString
    * ConversionSoftware
    * ConversionSoftwareVersion
    * DatasetDOI
    * DeidentificationMethod
    * DerivedVendorReportedEchoSpacing
    * DeviceSerialNumber
    * Dim1Size
    * Dim2Size
    * Dim3Size
    * DwellTime
    * EchoNumber
    * EchoTime
    * EchoTime1
    * EchoTime2
    * EchoTrainLength
    * EffectiveEchoSpacing
    * FlipAngle
    * Funding
    * HowToAcknowledge
    * ImageOrientationPatientDICOM
    * ImageType
    * ImagingFrequency
    * InPlanePhaseEncodingDirectionDICOM
    * IntendedFor
    * InversionTime
    * License
    * MRAcquisitionType
    * MagneticFieldStrength
    * Manufacturer
    * ManufacturersModelName
    * Modality
    * Name
    * NumVolumes
    * Obliquity
    * ParallelReductionFactorInPlane
    * PartialFourier
    * PercentPhaseFOV
    * PhaseEncodingDirection
    * PhaseEncodingSteps
    * PhaseResolution
    * PixelBandwidth
    * ProcedureStepDescription
    * ProtocolName
    * PulseSequenceDetails
    * ReceiveCoilName
    * ReconMatrixPE
    * RefLinesPE
    * ReferencesAndLinks
    * RepetitionTime
    * SAR
    * ScanOptions
    * ScanningSequence
    * SequenceName
    * SequenceVariant
    * SeriesDescription
    * SeriesInstanceUID
    * SeriesNumber
    * ShimSetting
    * SliceThickness
    * SliceTiming
    * SoftwareVersions
    * SpacingBetweenSlices
    * TaskName
    * TotalReadoutTime
    * TxRefAmp
    * VoxelSizeDim1
    * VoxelSizeDim2
    * VoxelSizeDim3
    * template

    Running cubids-remove-metadata-fields resulted no PHI fields for removal.

* Data checked into DataLad `/cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS (dataset)` via `datalad save -m "add initial data" -d ./curation/BIDS` 
    `action summary:                                                               
      add (ok: 2448)
      save (ok: 1)` 
  
*Skipping PMACS backup for now*

### Curation Process

* Data curation by Margaret Gardner for NGG rotation program.
* GitHub Link to curation scripts/heurstics: 
* GitHub Link to final CuBIDS csvs: 

#### BIDS Validation:

* Ran `cubids-validate` and `cubids-group` simultanously as per The WAY, outputs saved to `sandbox/validator_outputs/iteration1`.

* Iteration 1:
    EVENTS_TSV_MISSING ( Task scans should have a corresponding events.tsv file. If this is a resting state scan you can ignore this warning or rename the task to include the word "rest". ) : 495 counts

    INCONSISTENT_SUBJECTS ( Not all subjects contain the same files. Each subject should contain the same number of files with the same naming unless some files are known to be missing. ) : 806 counts

    INCONSISTENT_PARAMETERS ( Not all subjects/sessions/runs have the same scanning parameters. ) : 24 subjects

    README_FILE_MISSING ( The recommended file /README is missing. See Section 03 (Modality agnostic files) of the BIDS specification. ) : 1 subjects

    NO_AUTHORS ( The Authors field of dataset_description.json should contain an array of fields - with one author per field. This was triggered because there are no authors, which will make DOI registration from dataset metadata impossible. ) : 1 subjects

* Iteration 1.2 (Reran `cubids-validate` with `--ignore_nifti_headers` and `--ignore_subject_consistency`, no modifications to datafiles:

    EVENTS_TSV_MISSING ( Task scans should have a corresponding events.tsv file. If this is a resting state scan you can ignore this warning or rename the task to include the word "rest". ) : 495 scans
    
    README_FILE_MISSING ( The recommended file /README is missing. See Section 03 (Modality agnostic files) of the BIDS specification. ) : 1 count

    NO_AUTHORS ( The Authors field of dataset_description.json should contain an array of fields - with one author per field. This was triggered because there are no authors, which will make DOI registration from dataset metadata impossible. ) : 1 count
   
*counts using  [validator_err_counts.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/7691b7cb97d56dc9ddd864899c9fed82452a4a47/notebooks/validator_err_counts.ipynb) *

* BIDS curation approved by Ted Satterthwaite and Tinashe Tapera on 9/21/21, last validator output of original data available at `/gpfs/fs001/cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/sandbox/validator_outputs/d2_r2_validation.csv`. Data backed up to datalad. **backup to PMACS**

#### BIDS Optimization:
* BIDs groups from Iteration 1.2 reviewed by Ted and Tinashe 
   * reviewed subject files for duplicates, no subj with more than one T1w or each type of fmap (phase1, phase2, magnitude1, magnitude2)
   * * 118 subj have full set of phase1&2, magnitude1&2 files
   * * 5 subj have only phasediff files (mislabeled phase1) but no magnitude files
   * * 1 subj has only phase1 & phase2 files but no magnitude files
   * identified 3 subjects who have T2 data (KeyParamGroup=datatype-anat_suffix-T2w__1) in addition to T1 that compromise AcqGroup 3
   * Plan to add A/B designation task entity for files to disambiguate task version (cardA,cardB, faceA, or faceB) performed during each run. Data currently contained in SeriesDescription, see [task-match.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/f35fb7bdb2422b72d42d9328dd5644e7b5ddba12/notebooks/task-match.ipynb)

*counts using  [validator_err_counts.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/7691b7cb97d56dc9ddd864899c9fed82452a4a47/notebooks/validator_err_counts.ipynb) *

* Iteration 2
   * made sure all files in curation/BIDS checked into datalad
   * T2 files to be removed written to code/sandbox/T2w.txt using [validator_err_counts.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/7691b7cb97d56dc9ddd864899c9fed82452a4a47/notebooks/validator_err_counts.ipynb), ran `cubids-purge`:
   `cubids-purge --use-datalad /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/sandbox/T2w.txt`
   * fmap files to be removed written to Margaret/Day2/curation/code/sandbox/validator_outputs/iteration1.2/fmap_to_rm.txt using [validator_err_counts.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/7691b7cb97d56dc9ddd864899c9fed82452a4a47/notebooks/validator_err_counts.ipynb), ran `cubids-purge`:
   `cubids-purge --use-datalad /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/sandbox/validator_outputs/iteration1.2/fmap_to_rm.txt`
   
   * Reran `cubids-validator` iter2 with `--ignore_nifti_headers` and `--ignore_subject_consistency` flags; outputs identical to Iteration 1.2 above (reviewed using [validator_parser.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/a3708a7c5f8559cb67f8aea83c7e853aed9afea0/notebooks/validator_parser.ipynb)).
   * Reran `cubids-group` - still resulted in 23 acquisition groups, including addition of 4 new KeyParamGroups (reviewed using [group_compare.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/a3708a7c5f8559cb67f8aea83c7e853aed9afea0/notebooks/group_compare.ipynb)):
acquisition-VARIANTNoFmap_datatype-func_run-2_suffix-bold_task-card
acquisition-VARIANTNoFmap_datatype-func_run-2_suffix-bold_task-face
acquisition-VARIANTNoFmap_datatype-func_run-1_suffix-bold_task-face
acquisition-VARIANTObliquityNoFmap_datatype-func_suffix-bold_task-rest
acquisition-VARIANTNoFmap_datatype-func_suffix-bold_task-rest
   * Groupings approved by Ted and Tinashe, ran `cubids-apply` without modifications to iter2_summary or iter2_files:
   `cubids-apply --use-datalad BIDS code/iterations/iteration2/iter2_summary.csv code/iterations/iteration2/iter2_files.csv code/iterations/apply1`
   * `cubids-apply` created apply1_full_cmd.sh (renamed to apply1a_full_cmd.sh) but unsuccessful in renaming files; internet disconnected and wasn't able to copy error from jupyter terminal, reran command and reproduced error:
    `raise CommandError(
datalad.support.exceptions.CommandError: CommandError: 'bash code/iterations/apply1_full_cmd.sh' failed with exitcode 127 under /gpfs/fs001/cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS'`
   * decided to edit iter2_summary.csv and rerun per Tinashe's request to rename lengthy T1w keygroups, then will try to solve cubids-apply error
        * renamed:
            * KeyParamGroup datatype-anat_suffix-T1w__3 to acquisition-VARIANTAllwithParallelReductionFactorInPlane_datatype-anat_suffix-T1w 
            * KeyParamGroup datatype-anat_suffix-T1w__4 to acquisition-VARIANTAll_datatype-anat_suffix-T1w
      
   Ran `cubids-apply` with above modifications to iter2_summary.csv:
   `cubids-apply --use-datalad BIDS code/iterations/iteration2/iter2_summary.csv code/iterations/iteration2/iter2_files.csv code/iterations/apply2`
   
* Iteration 3
    * per Sydney Covitz's recommendations, reran `cubids-group using` full paths:
    `cubids-group --use-datalad /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/iterations/iteration3/iter3`
   * resulted in 23 acquisition groups, including addition of 4 new KeyParamGroups (reviewed using [group_compare.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/a3708a7c5f8559cb67f8aea83c7e853aed9afea0/notebooks/group_compare.ipynb)):
acquisition-VARIANTNumVolumesNoFmap_datatype-func_run-2_suffix-bold_task-face
acquisition-VARIANTNumVolumesNoFmap_datatype-func_run-1_suffix-bold_task-face
acquisition-VARIANTNumVolumesNoFmap_datatype-func_suffix-bold_task-rest
acquisition-VARIANTNumVolumesNoFmap_datatype-func_suffix-bold_task-rest
   * reviewed with Sydney, discovered that prior `cubids-apply` attempts had succcessfully renamed IntendedFors field in fmap json's but exited before being able to rename the filenames (due to the fact that the files.csv had the /gpfs/fs001/ string in it because cubids-group was run using relative paths), resulting in "NoFmap" additions above. Per Sydney's recommendation running `cubids-undo` to un-rename IntendedFors; reran `cubids-group` and finally `cubids-apply` using abs. paths.
      * ran `git clean -f -d` to remove untracked changes in .ipynb_checkpoints
      * ran `cubids-undo`, used [intendedfor_rename.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/a3708a7c5f8559cb67f8aea83c7e853aed9afea0/notebooks/intendedfor_rename.ipynb) to verify once VARIANT renames had been cleared. Datalad executes undone tracked below:
          * HEAD is now at 69e473c Renamed IntendedFors
          * HEAD is now at 1ccd650 Renamed IntendedFors
          * HEAD is now at c8466c7 Renamed IntendedFors
          * HEAD is now at abc67c1 Renamed IntendedFors
          * HEAD is now at 26b23ee Renamed IntendedFors
          * HEAD is now at edfb983 updating .ipynb
 
 * Iteration 4  
   * successfully removed all VARIANT intendedfors, rerunning:
   `cubids-group --use-datalad /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/iterations/iteration4/iter4`
   * reviewed groupings against iter2 using [group_compare.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/a3708a7c5f8559cb67f8aea83c7e853aed9afea0/notebooks/group_compare.ipynb), no changes. Renamed the lengthy T1w keygroups per Tinashe's request: 
     * datatype-anat_suffix-T1w__3 : acquisition-VARIANTAllwithParallelReductionFactorInPlane_datatype-anat_suffix-T1w
     * datatype-anat_suffix-T1w__4 : acquisition-VARIANTAll_datatype-anat_suffix-T1w
   * ran: `cubids-apply --use-datalad /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/iterations/iteration4/iter4_summary.csv /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/iterations/iteration4/iter4_files.csv /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/iterations/apply2`
   * `cubids-apply` successful 
   * ran `cubids-validate`, no new errors or warnings:
    EVENTS_TSV_MISSING : 495 scans
    README_FILE_MISSING : 1 count
    NO_AUTHORS : 1 count

 * Iteration 5 
   * 3 exemplar subjects (sub-15546, sub-16181, & sub-12235) failed running fmriprep due to abberant image shape (64, 64, 43) in fmap images. Each subject compromised a unique Acquisition group. Deleting all fmap images (listed using Dim3_err_fmaps.ipynb):
   `cubids-purge --use-datalad /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/sandbox/fmap_to_rm2.txt`
   * ran `cubids-group`, new groups ID'd for above subj (NoFMap) that will be merged into existing NoFMap groups with `cubids-apply`
   * ran `cubids-apply` without changes with prefix apply3, successful
   * ran `cubids-validate`, parsed using [validator_parser.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/a3708a7c5f8559cb67f8aea83c7e853aed9afea0/notebooks/validator_parser.ipynb), no new errors or warnings:
    EVENTS_TSV_MISSING : 495 scans
    README_FILE_MISSING : 1 count
    NO_AUTHORS : 1 count

* Iteration 6
   * 3 subjects (sub-13373, sub-14858, sub-15709) failed fmriprep due to CRC error, deleting nifti files identified in log outputs:
   `cubids-purge --use-datalad /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/sandbox/CRC_err_to_rm.txt`
    * ran `cubids-group`, no new variants (no RenameKeyGroups for non-fmap KeyGroups) - Tinashe reviewed, no need for cubids-apply/validate
    
### Preprocessing Pipelines 
* For each pipeline (e.g. QSIPrep, fMRIPrep, XCP, C-PAC), please fill out the following information:
* fMRIPrep
   * Margaret Gardner is responsible for running preprocessing pipelines/audits on CUBIC
   * Exemplar Testing:
     * ran `cubids-copy-exemplars --use-datalad /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/testing/exemplars_dir /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/iterations/apply2_AcqGrouping.csv`
      * Path to exemplar dataset (annexed to datalad): /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/testing/exemplars_dir 
      * Path to fmriprep container (.sif copied from dropbox, annexed to datalad): /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/testing/exemplars_test/fmriprep-container
       ** ran `$(tail -n 1 code/qsub_calls.sh)` w/out modifications to participant_job.sh or fmriprep_zip.sh but no output branch created and didn't save job number
       ** reran `$(tail -n 1 code/qsub_calls.sh)` w/out modifications to participant_job.sh or fmriprep_zip.sh
        * Your job 1396175 ("fpsub-12583") has been submitted
        * job writing to analysis/logs but seems unable to create new datalad branch (pushingitremote... line 32: datalad: command not found); 
       ** edited `participant_job.sh` to correct conda environment (from base to margaret_reward) and run job in /cbica/comp_space; failed b/c had comments in-line on fmriprep_zip.sh
       ** reviewed with Tinashe and edited fmriprep_zip.sh; reran job 1424461 ("fpsub-12583") has been submitted - completed successfully
       ** ran `bash code/qsub_calls.sh`, submitted jobs 1679260 through 1679282 & merged to merge_ds (with helo from Sydney & Matt - issues with merge failing since test sub-12583 had already been merged, followed their instruction to delete both sub-12583 branches since .zip files already present in merge_ds)
        * error in sub-15546, sub-16181, & sub-12235 (fmap images with Dim3Size=43, unable to construct fmaps - removing all fmap images for these subjects, see **Iteration 5** above)
     * sub-12583 (test sub) doesn't have branch in output_ria but is fine in audit
       * Path to exemplar outputs: /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/testing/fmriprep/output_ria
   * Production Testing:
      * ran qsub_calls.sh, submitted jobs 1831777 through 1831903
      * only 84 files in logfile, 123 branches created under output_ria
          * running `merge_outputs.sh` and audit to identify failed subj
          * edited `concat_outputs.sh`(still old version on github) to pull tinashe's new [`concatenator.py` edits](https://raw.githubusercontent.com/PennLINC/RBC/TinasheMTapera-fix-concatenator/PennLINC/Generic/concatenator.py) and edited line 12 'concat_ds/csvs' to 'csvs'
      * reviewed `FMRIPREP_AUDIT.csv`, 4 subj failed:
          * sub-13373 - nipype.workflow ERROR: Node bold_to_std_transform.a0 failed to run on host 2119fmn002... File "indexed_gzip/indexed_gzip.pyx", line 635, in indexed_gzip.indexed_gzip._IndexedGzipFile.seek indexed_gzip.indexed_gzip.CrcError: CRC/size validation failed - the GZIP data might be corrupt
              * used `gzip -t -v` to validate CRC size for sub-13373_ses-day2_task-face_run-01_bold.nii.gz, OK
          * sub-14858 - same as above, err on sub-14858_ses-day2_task-card_acq-VARIANTNoFmap_run-02_bold.nii.gz
          * sub-15709 - same as above, err on sub-15709_ses-day2_task-rest_bold.nii.gz
          * sub-17113 - no error message, log o and e incomplete - to rerun
          * removing scans with CRC error, see **Iteration 6** above - pushed BIDS updates to input_ria, rerunning qsub calls for sub-13373 (job 1974456), sub-14858 (job 1974459), sub-15709 (job 1974460), and sub-17113 (job 1974462)
      * Path to production inputs: /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS
      * GitHub Link to production outputs:
      * GitHub Link to production audit: 

### Post Processing 

* Who is using the data/for which projects are people in the lab using this data?
   * Link to project page(s) here  
* For each post-processing analysis that has been run on this data, fill out the following
   * Who performed the analysis?
   * Where it was performed (CUBIC, PMACS, somewhere else)?
   * GitHub Link(s) to result(s)
   * Did you use pennlinckit?  
      * https://github.com/PennLINC/PennLINC-Kit/tree/main/pennlinckit  


### To Do 
   * backup to PMACS
   * rename task entity
   * get timing files
   * run fmriprep from command line
