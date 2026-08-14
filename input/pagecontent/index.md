<div markdown="1" class="dragon">

This is an experimental IG.

</div>

<div class="note-to-balloters">

Note to balloters

</div>

<div class="stu-note">

STU Note

</div>

This IG focuses on a use-case where the subject is a minor that has emancipated.

- Patient resource is used to identify the Patient
- Consent resource is used to document the Patient has legal status as emancipated.

### Consent profiling

As with any Consent, often there is paperwork that ultimately holds the legal details. This legal paperwork is critical to overall legal precedent, and represents the ceremony of the act of consent from the patient. These details should be captured by a DocumentReference and Binary. The Consent.sourceReference would then point at that DocumentReference. (Could use Consent.sourceAttachment, but I am not a fan of bloating the Consent with that detail).

The Consent then would need to be profiled. The main difference from the FHIR core [Consent](http://hl7.org/fhir/consent.html) I outlined in my [Consent article](https://healthcaresecprivacy.blogspot.com/2022/05/explaining-fhir-consent-examples.html) is that this would be a specific kind of Consent.

- status - would indicate active
- category - would indicate patient consent, specifically an emancipation
- patient - would indicate the Patient resource reference for the given patient
- dateTime - would indicate when the privacy policy was presented
- performer - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian
- organization - would indicate the Organization that legally recognizes the emancipation (e.g., the State)
- source - would point at the specific signed legal emancipation text
- policy.uri - would indicate the privacy policy that was presented. Usually, the url to the version-specific policy
- provision.type - permit - given there is no way to deny, this would be fixed at permit.
- provisions might have some limits in the emancipation expressed?

#### Contract resource

The Contract resource could also be used, but it is much less mature and is way too complex to simply carry a simple emancipation fact with paperwork.

#### using Consent to enable access control

One advantage of using a Consent resource as defined here is that there would be a natural set of provisions in a Consent that would be processable by an Access Control engine that understands Consent. This Access Control engine would not need to understand RelatedPerson, other than to know that a given user is a RelatedPerson (vs Patient, Person, Practitioner, etc). Thus the Consent.permit rules are used to mediate access to that Patient's data by that given user.

### TODO

Should there be some RelatedPerson indication for NOT relelationsips? That is to indicate that although this person can show they are a Father, the child has emancipated from their Father?

### Examples

- [Patient](Patient-ex-patient.html)
- [Consent from the Patient indicating emancipation](Consent-ex-consent.html)
