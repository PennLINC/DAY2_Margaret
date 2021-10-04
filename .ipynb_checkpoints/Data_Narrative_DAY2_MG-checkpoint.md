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
**copy prior**

Data was stored as nifti files in /cbica/projects/wolf_satterthwaite_reward/original_data/bidsdatasets/day2.
Data was copied by Margaret to sub-project folder /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/original_data on 9/14/2021.

JSON's within origial_data were updated using cubids-add-nifti-info.

* Listing metadata fields using cubids-print-metadata-fields resulted:
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

* Data checked into DataLad (/cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS (dataset)) via:
    datalad save -m "add initial data" -d ./curation/BIDS 
    action summary:                                                               
      add (ok: 2448)
      save (ok: 1) 
  
* Skipping PMACS backup for now *

### Curation Process

* Data curation by Margaret Gardner for NGG rotation program.
* GitHub Link to curation scripts/heurstics: 
* GitHub Link to final CuBIDS csvs: 

####BIDS Validation:
* Ran validate and group simultanously as per The WAY, outputs saved to sandbox/validator_outputs/iteration1.

* Iteration 1:
    EVENTS_TSV_MISSING ( Task scans should have a corresponding events.tsv file. If this is a resting state scan you can ignore this warning or rename the task to include the word "rest". ) : 495 subjects

    INCONSISTENT_SUBJECTS ( Not all subjects contain the same files. Each subject should contain the same number of files with the same naming unless some files are known to be missing. ) : 806 subjects

    INCONSISTENT_PARAMETERS ( Not all subjects/sessions/runs have the same scanning parameters. ) : 24 subjects

    README_FILE_MISSING ( The recommended file /README is missing. See Section 03 (Modality agnostic files) of the BIDS specification. ) : 1 subjects

    NO_AUTHORS ( The Authors field of dataset_description.json should contain an array of fields - with one author per field. This was triggered because there are no authors, which will make DOI registration from dataset metadata impossible. ) : 1 subjects

* Iteration 1.2 (Reran validation with --ignore_nifti_headers and --ignore_subject_consistency, no modifications to datafiles:

    EVENTS_TSV_MISSING ( Task scans should have a corresponding events.tsv file. If this is a resting state scan you can ignore this warning or rename the task to include the word "rest". ) : 495 subjects
    
    README_FILE_MISSING ( The recommended file /README is missing. See Section 03 (Modality agnostic files) of the BIDS specification. ) : 1 subjects

    NO_AUTHORS ( The Authors field of dataset_description.json should contain an array of fields - with one author per field. This was triggered because there are no authors, which will make DOI registration from dataset metadata impossible. ) : 1 subjects
   
*counts using  [validator_err_counts.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/7691b7cb97d56dc9ddd864899c9fed82452a4a47/notebooks/validator_err_counts.ipynb) *

* BIDS curation approved by Ted Satterthwaite and Tinashe Tapera on 9/21/21, last validator output of original data available at /gpfs/fs001/cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/sandbox/validator_outputs/d2_r2_validation.csv. Data backed up to datalad. **backup to PMACS**

####BIDS Optimization:
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
   * T2 files to be removed written to code/sandbox/T2w.txt using [validator_err_counts.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/7691b7cb97d56dc9ddd864899c9fed82452a4a47/notebooks/validator_err_counts.ipynb), ran cubids-purge:
   cubids-purge --use-datalad /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/sandbox/T2w.txt
   * fmap files to be removed written to Margaret/Day2/curation/code/sandbox/validator_outputs/iteration1.2/fmap_to_rm.txt using [validator_err_counts.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/7691b7cb97d56dc9ddd864899c9fed82452a4a47/notebooks/validator_err_counts.ipynb), ran cubids-purge:
   cubids-purge --use-datalad /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/sandbox/validator_outputs/iteration1.2/fmap_to_rm.txt
   
   * Reran cubids-validator iter2 with --ignore_nifti_headers and --ignore_subject_consistency flags; outputs identical to Iteration 1.2 above (reviewed using [validator_parser.ipynb] (https://github.com/PennLINC/DAY2_Margaret/blob/a3708a7c5f8559cb67f8aea83c7e853aed9afea0/notebooks/validator_parser.ipynb)).
   * Reran cubids-group - still resulted in 23 acquisition groups, including addition of 4 new KeyParamGroups (reviewed using [group_compare.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/a3708a7c5f8559cb67f8aea83c7e853aed9afea0/notebooks/group_compare.ipynb)):
acquisition-VARIANTNoFmap_datatype-func_run-2_suffix-bold_task-card
acquisition-VARIANTNoFmap_datatype-func_run-2_suffix-bold_task-face
acquisition-VARIANTNoFmap_datatype-func_run-1_suffix-bold_task-face
acquisition-VARIANTObliquityNoFmap_datatype-func_suffix-bold_task-rest
acquisition-VARIANTNoFmap_datatype-func_suffix-bold_task-rest
   * Groupings approved by Ted and Tinashe, ran cubids-apply without modifications to iter2_summary or iter2_files:
   cubids-apply --use-datalad BIDS code/iterations/iteration2/iter2_summary.csv code/iterations/iteration2/iter2_files.csv code/iterations/apply1
   * *cubids-apply created apply1_full_cmd.sh (renamed to apply1a_full_cmd.sh) but unsuccessful in renaming files; internet disconnected and wasn't able to copy error from jupyter terminal, reran command and reproduced error:
    raise CommandError(
datalad.support.exceptions.CommandError: CommandError: 'bash code/iterations/apply1_full_cmd.sh' failed with exitcode 127 under /gpfs/fs001/cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS'
   * decided to edit iter2_summary.csv and rerun per Tinashe's request to rename lengthy T1w keygroups, then will try to solve cubids-apply error
        * renamed:
            * KeyParamGroup datatype-anat_suffix-T1w__3 to acquisition-VARIANTAllwithParallelReductionFactorInPlane_datatype-anat_suffix-T1w 
            * KeyParamGroup datatype-anat_suffix-T1w__4 to acquisition-VARIANTAll_datatype-anat_suffix-T1w
      
   Ran cubids-apply with above modifications to iter2_summary.csv:
   cubids-apply --use-datalad BIDS code/iterations/iteration2/iter2_summary.csv code/iterations/iteration2/iter2_files.csv code/iterations/apply2
   
* Iteration 3
   **recommend rerunning group using a FULL path to all arguments. Then the running apply with those new files/summary csvs**
    * per Sydney Covitz's recommendations, reran cubids-group using full paths:
    cubids-group --use-datalad /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/iterations/iteration3/iter3
   * resulted in 23 acquisition groups, including addition of 4 new KeyParamGroups (reviewed using [group_compare.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/a3708a7c5f8559cb67f8aea83c7e853aed9afea0/notebooks/group_compare.ipynb)):
acquisition-VARIANTNumVolumesNoFmap_datatype-func_run-2_suffix-bold_task-face
acquisition-VARIANTNumVolumesNoFmap_datatype-func_run-1_suffix-bold_task-face
acquisition-VARIANTNumVolumesNoFmap_datatype-func_suffix-bold_task-rest
acquisition-VARIANTNumVolumesNoFmap_datatype-func_suffix-bold_task-rest
   * reviewed with Sydney, discovered that prior cubids-apply attempts had succcessfully renamed IntendedFors field in fmap json's but exited before being able to rename the filenames (due to the fact that the files.csv had the /gpfs/fs001/ string in it because cubids-group was run using relative paths), resulting in "NoFmap" additions above. Per Sydney's recommendation running cubids-undo to un-rename IntendedFors; will rerun cubids-group and finally cubids-apply using abs. paths.
      * ran git clean -f -d to remove untracked changes in .ipynb_checkpoints
      * ran cubids-undo, used [intendedfor_rename.ipynb](https://github.com/PennLINC/DAY2_Margaret/blob/a3708a7c5f8559cb67f8aea83c7e853aed9afea0/notebooks/intendedfor_rename.ipynb) to verify once VARIANT renames had been cleared. Datalad executes undone tracked below:
          * HEAD is now at 69e473c Renamed IntendedFors
          * HEAD is now at 1ccd650 Renamed IntendedFors
          * HEAD is now at c8466c7 Renamed IntendedFors
          * HEAD is now at abc67c1 Renamed IntendedFors
          * HEAD is now at 26b23ee Renamed IntendedFors
          * HEAD is now at edfb983 updating .ipynb
 
 * Iteration 4  
   * successfully removed all VARIANT intendedfors, rerunning:
   cubids-group --use-datalad /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/code/iterations/iteration4/iter4
   * 
   * rerunning groupings per Tinashe's request to rename lengthy T1w keygroups 
   * to do: correct relative to abs. paths in The Way!
   rename task entity

### Preprocessing Pipelines 
* For each pipeline (e.g. QSIPrep, fMRIPrep, XCP, C-PAC), please fill out the following information:
   * Pipeline Name: 
   * Who is responsible for running preprocessing pipelines/audits on this data?
   * Where are you running these pipelines? CUBIC? PMACS? Somewhere else?
   * Did you implement exemplar testing? If so, please fill out the information below:
      * Path to exemplar dataset:
      * Path to exemplar outputs:
      * GitHub Link to exemplar audit:
    * For production testing, please fill out the information below:
      * Path to production inputs:
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
