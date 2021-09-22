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
* Goal is to curate in BIDS

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
* Are you using Datalad? If so, at which point did you check the data into datalad?
* Is the data backed up in a second location? If so, please provide the path to the backup location:
**copy prior**
Data was stored as nifti files in /cbica/projects/wolf_satterthwaite_reward/original_data/bidsdatasets/day2.
Data was copied to sub-project folder /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/original_data on 9/14/2021.

JSON's withi origial_data were updated using cubids-add-nifti-info.

Listing metadata fields using cubids-print-metadata-fields resulted:
Acknowledgements
AcquisitionMatrixPE
AcquisitionNumber
Authors
BIDSVersion
BandwidthPerPixelPhaseEncode
BaseResolution
CoilString
ConversionSoftware
ConversionSoftwareVersion
DatasetDOI
DeidentificationMethod
DerivedVendorReportedEchoSpacing
DeviceSerialNumber
Dim1Size
Dim2Size
Dim3Size
DwellTime
EchoNumber
EchoTime
EchoTime1
EchoTime2
EchoTrainLength
EffectiveEchoSpacing
FlipAngle
Funding
HowToAcknowledge
ImageOrientationPatientDICOM
ImageType
ImagingFrequency
InPlanePhaseEncodingDirectionDICOM
IntendedFor
InversionTime
License
MRAcquisitionType
MagneticFieldStrength
Manufacturer
ManufacturersModelName
Modality
Name
NumVolumes
Obliquity
ParallelReductionFactorInPlane
PartialFourier
PercentPhaseFOV
PhaseEncodingDirection
PhaseEncodingSteps
PhaseResolution
PixelBandwidth
ProcedureStepDescription
ProtocolName
PulseSequenceDetails
ReceiveCoilName
ReconMatrixPE
RefLinesPE
ReferencesAndLinks
RepetitionTime
SAR
ScanOptions
ScanningSequence
SequenceName
SequenceVariant
SeriesDescription
SeriesInstanceUID
SeriesNumber
ShimSetting
SliceThickness
SliceTiming
SoftwareVersions
SpacingBetweenSlices
TaskName
TotalReadoutTime
TxRefAmp
VoxelSizeDim1
VoxelSizeDim2
VoxelSizeDim3
template

Running cubids-remove-metadata-fields resulted no PHI fields for removal.

Data checked into DataLad (/cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation/BIDS (dataset)) via:

(margaret_reward) [wolfsatterthwaitereward@cubic-login3 curation]$ datalad save -m "add initial data" curation
[ERROR  ] NoDatasetFound(No dataset found at '/cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/curation' for the purpose 'save'.  Specify a dataset to work with by providing its path via the `dataset` option, or change the current working directory to be in a dataset.) (NoDatasetFound) 
usage: datalad save [-h] [-m MESSAGE] [-d DATASET] [-t ID] [-r] [-R LEVELS]
                    [-u] [-F MESSAGE_FILE] [--to-git] [-J NJOBS] [--amend]
                    [--version]
                    [PATH [PATH ...]]
(margaret_reward) [wolfsatterthwaitereward@cubic-login3 curation]$ cd ..(margaret_reward) [wolfsatterthwaitereward@cubic-login3 Day2]$ datalad save -m "add initial data" ./curation/BIDS
[ERROR  ] NoDatasetFound(No dataset found at '/cbica/projects/wolf_satterthwaite_reward/Margaret/Day2' for the purpose 'save'.  Specify a dataset to work with by providing its path via the `dataset` option, or change the current working directory to be in a dataset.) (NoDatasetFound) 
usage: datalad save [-h] [-m MESSAGE] [-d DATASET] [-t ID] [-r] [-R LEVELS]
                    [-u] [-F MESSAGE_FILE] [--to-git] [-J NJOBS] [--amend]
                    [--version]
                    [PATH [PATH ...]]
(margaret_reward) [wolfsatterthwaitereward@cubic-login3 Day2]$ datalad save -m "add initial data" -d ./curation/BIDS 

**modification to The Way, had to specify -d**

action summary:                                                               
  add (ok: 2448)
  save (ok: 1)
  
Skipping PMACS backup for now, will talk with Ted about getting an account

### Curation Process

* Data curation by Margaret Gardner for NGG rotation program.
* GitHub Link to curation scripts/heurstics: 
* GitHub Link to final CuBIDS csvs: 
BIDS Validation:
* Ran validate and group simultanously as per The WAY, outputs saved to sandbox/validator_outputs.
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
   
*counts using  [validator_err_counts.ipynb] (https://github.com/PennLINC/DAY2_Margaret/blob/e83eb697e7730f77ee4f702ec3b29ecb9165fe95/validator_err_counts.ipynb) *

* BIDs groups reviewed by Ted Satterthwaite and Tinashe Tapera
   * reviewed subject files for duplicates, no subj with more than one T1w or each type of fmap (phase1, phase2, magnitude1, magnitude2)
   * * 124 subj have phase1, 119 have phase2, 118 have magnitude1, 118 have magnitude2
   * identified 3 subjects who have T2 data (KeyParamGroup=datatype-anat_suffix-T2w__1) in addition to T1 that compromise AcqGroup 3

*counts using  [validator_err_counts.ipynb] (https://github.com/PennLINC/DAY2_Margaret/blob/e83eb697e7730f77ee4f702ec3b29ecb9165fe95/validator_err_counts.ipynb) *

* Describe additions, deletions, and metadata changes (if any).

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
