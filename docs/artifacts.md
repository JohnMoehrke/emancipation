# Artifacts Summary - JohnMoehrke Emancipation v0.1.0

* [**Table of Contents**](toc.md)
* **Artifacts Summary**

## Artifacts Summary

This page provides a list of the FHIR artifacts defined as part of this implementation guide.

### Structures: Resource Profiles 

These define constraints on FHIR resources for systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [Consent profile indicating Emancipation](StructureDefinition-EmancipationConsent.md) | This defines the constraints on a Consent to indicate that a Patient has emancipated. The Consent does not cover all aspects of emancipation, but is focused on the access control aspects of emancipation. The Consent is intended to be used in conjunction with a legal emancipation document that is captured in a DocumentReference. The Consent is intended to be used in conjunction with RelatedPerson resources that identify the parents or guardians who are affected by the emancipation.* status - would indicate active
* category - would indicate patient consent specifically a delegation of authority
* patient - would indicate the Patient resource reference for the given patient
* dateTime - would indicate when the privacy policy was presented
* performer - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian
* organization - would indicate the Organization who presented the privacy policy, and which is going to enforce that privacy policy
* source - would point at the specific signed consent by the patient
* policy.uri - would indicate the privacy policy that was presented. Usually, the url to the version specific policy
* provision.type - deny - is the single root provision and establishes the overall direction when required by the legal emancipation instrument and applicable law.
* provision.provision.type - permit - is an exception to the root denial, such as access expressly retained by law or the legal instrument.
* provision.provision.provision.type - deny - is an exception to that permit. Each deeper provision alternates the prior provision's direction.
* provision.provision.actor.reference - would reference the RelatedPerson that identifies the affected parent or guardian.
* provision.provision.actor.role - would identify the parent's or guardian's relationship or authority.
* provision.provision.purpose - would indicate the access purposes to which the rule applies.
 |

### Terminology: Value Sets 

These define sets of codes used by systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [Authorization purposes for delegation access valueset](ValueSet-AuthPurposesVS.md) | ValueSet of the Authorized purposesOfUse types |

### Terminology: Code Systems 

These define new code systems used by systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [Consent type that is indicating Emancipation.](CodeSystem-AuthorizedCodes.md) | CodeSystem for Consent types indicating Emancipation |

### Example: Example Instances 

These are example instances that show what data produced and consumed by systems conforming with this implementation guide might look like.

| | |
| :--- | :--- |
| [DocumentReference Emancipation Paperwork example](DocumentReference-ex-documentreference.md) | DocumentReference example of the paperwork of the Emancipation |
| [Example Organization holding the legal emancipation status](Organization-ex-organization.md) | The Organization that holds the legal emancipation status. Usually legal counsel or a court. |
| [Father - Related Person](RelatedPerson-ex-father.md) | Related Father of the Patient authorized by a Consent |
| [Mother - Related Person](RelatedPerson-ex-mother.md) | Related Mother of the Patient authorized by a Consent |
| [Patient example](Patient-ex-patient.md) | Patient example for completeness sake. |
| [Practitioner example doctor](Practitioner-ex-doctor.md) | Practitioner example for the doctor. |
| [Simple Emancipation Consent example](Consent-ex-consent.md) | Consent justifying Emancipation. This emancipation is defined for just a year, using provision.period to indicate expiration; this is shown as example of renewal need. With this emancipation the father is allowed access to the Patient's data, but the mother is denied access to the Patient's data. |

