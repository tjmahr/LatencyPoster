Do orienting stimuli create additional task demands in the looking-while-listening paradigm?
============================================================================================

*Tristan Mahr and Jan Edwards*

Introduction and Rationale
--------------------------

-   The 2AFC looking-while-listening paradigm (LWL; Fernald, Zangl, Portillo, & Marchman, 2008) has become widely used to examine lexical processing in young children.
-   The speed at which children look to familiar objects when hearing the object-name at 18 months reliably predicts vocabulary size up to 8 years of age (Marchman & Fernald, 2008).
    -   However, these reaction time measures are not easily obtained.
    -   Reaction time provides a measure of how quickly a child looks to a picture when its object name is presented. Therefore, reaction time can be measured only on trials where the child is *not* looking at the target picture at the onset of the target word.
    -   In a 2AFC paradigm, only about 50% of trials provide reaction time data.
    -   Usually, even fewer trials provide reaction time data because there are always some trials where young children are not fixating on a picture at target word onset.
    -   This is a considerable problem, given the small number of trials in LWL studies (usually between 24 and 36).

-   Adults can be instructed to fixate on a central orienting stimuli, but young children cannot be similarly instructed.
-   This study used an animated centering stimulus in an attempt to increase the number of LWL trials with useable reaction times.

METHOD
------

### Conditions

Condition 1: No animated centering stimulus.

Condition 2: Animated centering stimulus.

-   Centering stimulus was an abstract geometric animation. It appeared onscreen after two images had been presented for 2000 ms.
-   The animation looped until the child had fixated on it for 300 ms or until 8000 ms had elapsed. Then the carrier phrase (*find the*) was played; at target-word onset, the centering stimulus disappeared.
-   Because carrier phrase and target-word presentation were triggered by fixation to the animation, these trials incorporated *gaze-contingency* into the LWL paradigm.

### Participants

-   N = 25 (12 female, 13 male) in condition 1 and N = 25 (11 female, 14 male) in condition 2.
-   Participants in the two groups closely matched on the basis of age, sex, and PPVT-4 standard score.

|** **|**Age (months)**|**EVT-2 standard score**|**PPVT-4 standard score**|
|:----|:---------------|:-----------------------|:------------------------|
|CS1|39.4 (30–46)|129.8 (111–149)|131.4 (108–159)|
|CS2|40.5 (31–48)|122.5 (92–146)|120.7 (94–146)|

### Methodology

-   Looking-while-listening mispronunciation paradigm (Swingley & Aslin, 2000; White & Morgan, 2008)
-   Experiment designed in E-Prime Professional 2.0, used to interface with Tobii T60 XL Eye-tracker.
-   Eye-tracking task presented to children as “watching a movie.”
-   Images presented onscreen: one familiar and one unfamiliar object.
-   Position counterbalanced (left-right).
-   Images normed for familiarity and unfamiliarity.

#### Three conditions

1.  CP: Correct pronunciation of real words
2.  MP: Mispronunciations of these real words, with a one-feature change of initial consonant
3.  NW: Nonwords trials presented with familiar objects not used in CP trials

-   Target words all CVC in the carrier phrases “See the \_\_\_\_!” or “Find the \_\_\_\_!”
-   (6 CP + 6 MP + 6 NW) \* 2 repetitions + 2 other real-word familiarization trials = 38 trials
-   2 blocks of 38 trials, eye-tracker calibrated before each block.
-   Brief animation played every 6–7 trials to keep child engaged in task.

![Figure 1. Example screens in experiment. An orienting stimulus is on the left.](images/mp_display.png)

![Figure 2. Figure 2. Timeline of a single trial](images/timeline.png)

### Calculation of Latency (reaction time)

-   Latency is the amount of time between target-word onset and the first look to target.
-   Latency calculated for CP and NW trials only.
-   On each trial, reaction time was calculated only if:
    1.  the child looked onscreen within the 50 ms after target-word onset
    2.  the child was not already looking at familiar object (CP trials) or at unfamiliar object (NW trials) during within 50 ms after target-word onset.

-   Latency = Time of first look to target − time of first tracked look during target-word onset (0 to 50 ms)
-   Reaction time trimming: We excluded latencies that were less than 250 ms or greater than 2SD above the group mean.

### Research Questions

-   Does the use of an animated centering stimulus result in more useable latencies?
    -   That is, are there more trials with useable latencies in condition 2 as compared to condition 1?

-   Does this animated centering stimulus create additional task demands?
    -   Do children take longer to look to the target in condition 2 relative to condition 1?
    -   Does the relationship between reaction time and vocabulary size reported in the literature continue to be observed when an animated centering stimulus is used?

RESULTS
-------

As expected, children looked to familiar object in CP trials and to unfamiliar object in NW trials.

### Latency Results

-   Condition 1:
    -   CP trials: Latencies available in 32.7% of trials (additional 4.8% trimmed)
    -   NW trials: Latencies available in 30.5% of trials (additional 5.8% trimmed)

-   Condition 2:
    -   CP trials: Latencies available in 63.9% of trials (additional 8% trimmed)
    -   NW trials: Latencies available in 61.3% of trials (additional 8.5% trimmed)

-   Mean latencies are very similar across the two conditions and the two trial types.
-   Distributions of latencies differs across the two conditions, with condition 2 (with the centering stimuli) having a more peaky and positively skewed distribution.

|** **|**Correct Productions (ms)**|**Nonwords (ms)**|
|:----|:---------------------------|:----------------|
|CS1|741 (289)|641 (257)|
|CS2|736 (367)|721 (376)|

![Figure 3. Histograms of latencies (ms) for condition 1 (top) and condition 2 (bottom) for CP trials (left) and NW trials (right).](figure/Histograms.png)

### Regression analyses

-   Do age, expressive vocabulary size or trial type predict latency in either conditions?
-   We ran two separate multiple regression analyses, one for each condition. The dependent variable was the mean latencies for each subject for each trial type (CP or NW).
-   Independent variables were age, trial type (CP or NW), and EVT-2 raw score (expressive vocabulary size).
-   The regression results were also checked against a mixed effects model that used by-subject random intercepts and random slopes for trial type rather than aggregating latencies into subject means.

![Figure 4. Relationship between EVT-2 and mean latencies for each subject by condition and trial](figure/Model_Plots.png)

#### Regression Results: Condition 1

-   Age, trial type, and EVT-2 were significant predictors of latency, *R*\^2 = 0.285, *F*(3, 46) = 6.11, *p* = 0.001.

|---|:--|:--|:--|:--|
||**Estimate**|**Std. Error**|***t***|***p***|
|Intercept|423.97|171.89|2.47|0.02|
|EVT|-6.65|2.15|-3.10|0.00|
|Age|18.70|5.41|3.46|0.00|
|Condition|-89.78|40.88|-2.20|0.03|

#### Regression Results: Condition 2

-   None of the independent variables were significant predictors of latency, *R*\^2 = 0.096, *F*(3, 46) = 1.62, *p* = 0.197.

|---|:--|:--|:--|:--|
||**Estimate**|**Std. Error**|***t***|***p***|
|Intercept|979.01|129.30|7.57|0.00|
|EVT|-1.39|1.24|-1.12|0.27|
|Age|-3.79|3.66|-1.04|0.31|
|Condition|-9.11|30.29|-0.30|0.76|

Discussion
----------

-   These results suggest that using an animated centering stimulus will yield more useable latency data.
    -   About 54.35% of trials had useable latencies when an animated centering stimulus was used, compared to 26.25% when it was not used.

-   The fact that reaction times were not significantly different across the two conditions suggests that the animated centering stimulus does not create additional task demands.
-   As in previous research, vocabulary size was a significant predictor of latency in condition 1 without the animated centering stimulus
-   This result suggests that the effect of age and vocabulary size on latency in this study may have been due, at least in part, to older children and children with larger vocabularies having better attention to task. When an animated centering stimulus was used to maintain attention, the effect of age and vocabulary size on latency was no longer observed.
-   This study examined the relationship between latency and vocabulary size in 30–48 month-old children. More research is needed to evaluate whether this relationship continues to be observed in younger children when an animated centering stimulus is used to maintain attention.
-   To conclude, the use of an animated centering stimulus does not create additional task demands. Instead, it results in more useable latency data and better attention to task.

### Acknowledgements

Thanks to Franzo Law II, Alissa Schneeberg, Danielle Lee, David Kaplan, Morgan Meredith, Erica Richmond, Nancy Wermuth, and other members of the [Learning To Talk](http://learningtotalk.org) Laboratory for help with many aspects of this study. We also thank the children who participated and their parents.

This research was supported by NIDCD Grant R01-02932 to Jan Edwards, Mary Beckman, and Benjamin Munson and NICHD Grant P30-HD03352 to the Waisman Center.

#### Reproducible Research!

Data-set and supporting `R` scripts available on `github.com/tjmahr/LatencyPoster`

![](images/qrcode_small.png)

### References

Fernald, A., Zangl, R., Portillo, A. L., & Marchman, V. A. (2008). Looking while listening: Using eye movements to monitor spoken language comprehension by infants and young children. In I. A. Sekerina, E. M. Fernández, & H. Clahsen (Eds.), *Developmental Psycholinguistics: On-line Methods in Children’s Language Processing* (pp. 97–135). Amsterdam: John Benjamins Publishing Company.

Marchman, V. A., & Fernald, A. (2008). Speed of word recognition and vocabulary knowledge in infancy predict cognitive and language outcomes in later childhood. *Developmental Science*, *11*(3), F9–F16. doi:10.1111/j.1467-7687.2008.00671.x

Swingley, D., & Aslin, R. N. (2000). Spoken word recognition and lexical representation in very young children. *Cognition*, *76*(2), 147–166. doi:10.1016/s0010-0277(00)00081-0

White, K. S., & Morgan, J. L. (2008). Sub-segmental detail in early lexical representations. *Journal of Memory and Language*, *59*(1), 114–132. doi:10.1016/j.jml.2008.03.001
