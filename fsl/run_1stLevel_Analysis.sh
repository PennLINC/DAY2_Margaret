#!/bin/bash

#make sure fsl is outputting niftis correcly
FSLOUTPUTTYPE=NIFTI_GZ

#navigate to fsl BIDS directory
cd /cbica/projects/wolf_satterthwaite_reward/Margaret/Day2/fsl_sandbox

#list subjects
SUBJECTS=$(find BIDS -type d -name 'sub-*' | cut -d '/' -f 2 )
if [ -z "${SUBJECTS}" ]
then
    echo "No subjects found in input data"
    # exit 1
fi

#run each subject through first level analyses 

for subj in ${SUBJECTS}; do
    echo "===> Starting processing of $subj"
    echo
    cd BIDS/$subj
        # If the brain mask doesn’t exist, create it
        if [ ! -f ses-day2/anat/${subj}_ses-day2_T1w_brain.nii.gz ]; then
            echo "Skull-stripped brain not found, using bet with a fractional intensity threshold of 0.5"
            bet2 ses-day2/anat/${subj}_ses-day2_T1w.nii.gz \
                ses-day2/anat/${subj}_ses-day2_T1w_brain.nii.gz -f 0.5
        fi

        # Copy the design files from git dir into the subject directory, and then
        # change “SUBJ” to the current subject number
        cp ../../../curation/code/Day2MG_GitHub/fsl/design_card1.fsf .
        cp ../../../curation/code/Day2MG_GitHub/fsl/design_card2.fsf .
        cp ../../../curation/code/Day2MG_GitHub/fsl/design_face1.fsf .
        cp ../../../curation/code/Day2MG_GitHub/fsl/design_face2.fsf .

        # Note that we are using the | character to delimit the patterns
        # instead of the usual / character because there are / characters
        # in the pattern.
        sed -i "s|SUBJ|${subj}|g" \
            design_card1.fsf
        sed -i "s|SUBJ|${subj}|g" \
            design_card2.fsf
        sed -i "s|SUBJ|${subj}|g" \
            design_face1.fsf
        sed -i "s|SUBJ|${subj}|g" \
            design_face2.fsf

        # Now everything is set up to run feat
        echo "===> Starting feat for card run 1"
        feat design_card1.fsf
        echo "===> Starting feat for card run 2"
        feat design_card2.fsf
        echo "===> Starting feat for face run 1"
        feat design_face1.fsf
        echo "===> Starting feat for face run 2"
        feat design_face2.fsf

    # Go back to fsl_sandbox and repeat the loop
    cd ../..

done

echo
