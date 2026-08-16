
Instance: ex-organization
InstanceOf: Organization
Title: "Example Organization holding the legal emancipation status"
Description: "The Organization that holds the legal emancipation status. Usually legal counsel or a court."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* active = true
* name = "somewhere org"
* type = http://terminology.hl7.org/CodeSystem/organization-type#govt



Instance: ex-doctor
InstanceOf: Practitioner
Title: "Practitioner example doctor"
Description: "Practitioner example for the doctor."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* telecom.system = #email
* telecom.value = "JohnMoehrke@example.com"



// history - http://playgroundjungle.com/2018/02/origins-of-john-jacob-jingleheimer-schmidt.html
Instance:   ex-patient
InstanceOf: Patient
Title:      "Patient example"
Description: "Patient example for completeness sake."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* name[+].use = #usual
* name[=].family = "Schmidt"
* name[=].given = "John"
* name[+].use = #old
* name[=].family = "Schnidt"
* name[=].given[+] = "John"
* name[=].given[+] = "Jacob"
* name[=].given[+] = "Jingle"
* name[=].given[+] = "Heimer"
* name[=].period.end = "1960"
* name[+].use = #official
* name[=].family = "Schmidt"
* name[=].given[+] = "John"
* name[=].given[+] = "Jacob"
* name[=].given[+] = "Jingleheimer"
* name[=].period.start = "1960-01-01"
* name[+].use = #nickname
* name[=].family = "Schmidt"
* name[=].given = "Jack"
* gender = #other
* birthDate = "2009-07-25"
* address.state = "WI"
* address.country = "USA"



Instance: ex-documentreference
InstanceOf: DocumentReference
Title: "DocumentReference Emancipation Paperwork example"
Description: "DocumentReference example of the paperwork of the Emancipation"
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #current
* type = http://loinc.org#64292-6 "Release of information consent"
* date = "2026-08-16T23:11:33+10:00"
* subject = Reference(Patient/ex-patient)
* author = Reference(Organization/ex-organization)
* description = "The captured signed document"
* content.attachment.title = "Hello World"
* content.attachment.contentType = #text/plain
* content.attachment.data = "TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdCwgc2VkIGRvIGVpdXNtb2QgdGVtcG9yIGluY2lkaWR1bnQgdXQgbGFib3JlIGV0IGRvbG9yZSBtYWduYSBhbGlxdWEuIFV0IGVuaW0gYWQgbWluaW0gdmVuaWFtLCBxdWlzIG5vc3RydWQgZXhlcmNpdGF0aW9uIHVsbGFtY28gbGFib3JpcyBuaXNpIHV0IGFsaXF1aXAgZXggZWEgY29tbW9kbyBjb25zZXF1YXQuIER1aXMgYXV0ZSBpcnVyZSBkb2xvciBpbiByZXByZWhlbmRlcml0IGluIHZvbHVwdGF0ZSB2ZWxpdCBlc3NlIGNpbGx1bSBkb2xvcmUgZXUgZnVnaWF0IG51bGxhIHBhcmlhdHVyLiBFeGNlcHRldXIgc2ludCBvY2NhZWNhdCBjdXBpZGF0YXQgbm9uIHByb2lkZW50LCBzdW50IGluIGN1bHBhIHF1aSBvZmZpY2lhIGRlc2VydW50IG1vbGxpdCBhbmltIGlkIGVzdCBsYWJvcnVtLg=="
// Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.



Instance: ex-father
InstanceOf: RelatedPerson
Title: "Father - Related Person"
Description: "Related Father of the Patient authorized by a Consent"
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* active = true
* patient = Reference(Patient/ex-patient)
* relationship = 	http://terminology.hl7.org/CodeSystem/v3-RoleCode#FTH "father"
* name[+].use = #official
* name[=].family = "Schmidt"
* name[=].given[+] = "John"
* name[=].given[+] = "Jacob"
* name[=].given[+] = "Jingleheimer"
// after all, that is his name too
* gender = #male


Instance: ex-mother
InstanceOf: RelatedPerson
Title: "Mother - Related Person"
Description: "Related Mother of the Patient authorized by a Consent"
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* active = true
* patient = Reference(Patient/ex-patient)
* relationship = 	http://terminology.hl7.org/CodeSystem/v3-RoleCode#MTH "mother"
* name[+].use = #official
* name[=].family = "Schmidt"
* name[=].given[+] = "Mary"
* name[=].given[+] = "Ann"
* gender = #female



Instance: ex-consent
InstanceOf: EmancipationConsent
Title: "Simple Emancipation Consent example"
Description: "Consent justifying Emancipation. This emancipation is defined for just a year, using provision.period to indicate expiration; this is shown as example of renewal need. 
With this emancipation the father is allowed access to the Patient's data, but the mother is denied access to the Patient's data."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[representative] = AuthorizedCodes#EmancipationConsent
* category[relInfo] = http://loinc.org#64292-6 "Release of information consent"
* category[idscl] = http://terminology.hl7.org/CodeSystem/v3-ActCode#IDSCL
* patient = Reference(Patient/ex-patient)
* dateTime = "2026-08-23" // it is recorded here (Consent instance) a few days after the emancipation was granted (DocumentReference instance)
* performer = Reference(Patient/ex-patient)
* organization = Reference(Organization/ex-organization)
* sourceReference = Reference(DocumentReference/ex-documentreference)
* policy.uri = "http://example.org/policies/representative.xacml"
* provision.type = #deny // emancipation generally defaults to denying parental access.
* provision.period.start = "2026-08-16"
* provision.period.end = "2027-08-16" // in this case the emancipation is only for a year, after which it can be renewed at the legal level.
* provision.provision[+].type = #permit
* provision.provision[=].actor[+].role = 	http://terminology.hl7.org/CodeSystem/v3-RoleCode#FTH "father"
* provision.provision[=].actor[=].reference = Reference(RelatedPerson/ex-father)
* provision.provision[=].purpose = http://terminology.hl7.org/CodeSystem/v3-ActReason#FAMRQT "family requested"
* provision.provision[+].type = #permit // a permit placeholder so that another depth can be deny.
* provision.provision[=].provision[+].type = #deny
* provision.provision[=].provision[=].actor[+].role = 	http://terminology.hl7.org/CodeSystem/v3-RoleCode#MTH "mother"
* provision.provision[=].provision[=].actor[=].reference = Reference(RelatedPerson/ex-mother)









CodeSystem:  AuthorizedCodes 
Title: "Consent type that is indicating Emancipation."
Description:  "CodeSystem for Consent types indicating Emancipation"
* ^caseSensitive = true
* ^experimental = false
* ^status = #active
* #EmancipationConsent "Consent indicating Emancipation"


Profile: EmancipationConsent
Parent: Consent
Title: "Consent profile indicating Emancipation"
Description: """
This defines the constraints on a Consent to indicate that a Patient has emancipated. The Consent does not cover all aspects of emancipation, but is focused on the access control aspects of emancipation. The Consent is intended to be used in conjunction with a legal emancipation document that is captured in a DocumentReference. The Consent is intended to be used in conjunction with RelatedPerson resources that identify the parents or guardians who are affected by the emancipation.

- status - would indicate active
- category - would indicate patient consent specifically a delegation of authority
- patient - would indicate the Patient resource reference for the given patient
- dateTime - would indicate when the privacy policy was presented
- performer - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian
- organization - would indicate the Organization who presented the privacy policy, and which is going to enforce that privacy policy
- source - would point at the specific signed consent by the patient
- policy.uri - would indicate the privacy policy that was presented. Usually, the url to the version specific policy
- provision.type - deny - is the single root provision and establishes the overall direction when required by the legal emancipation instrument and applicable law.
- provision.provision.type - permit - is an exception to the root denial, such as access expressly retained by law or the legal instrument.
- provision.provision.provision.type - deny - is an exception to that permit. Each deeper provision alternates the prior provision's direction.
- provision.provision.actor.reference - would reference the RelatedPerson that identifies the affected parent or guardian.
- provision.provision.actor.role - would identify the parent's or guardian's relationship or authority.
- provision.provision.purpose - would indicate the access purposes to which the rule applies.
"""
* modifierExtension 0..0
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category ^slicing.discriminator.type = #value
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category 3..
* category contains
   representative 1..1 and
   relInfo 1..1 and
   idscl 1..1
* category[representative] = AuthorizedCodes#EmancipationConsent
* category[relInfo] = http://loinc.org#64292-6 "Release of information consent"
* category[idscl] = http://terminology.hl7.org/CodeSystem/v3-ActCode#IDSCL
* patient 1..1
* dateTime 1..1
* performer 1..
* organization 1..
* source[x] only Reference
* sourceReference ^short = "would point at the Consent paperwork signed by the Patient"
* provision MS
* provision.type = #deny




ValueSet: AuthPurposesVS
Title: "Authorization purposes for delegation access valueset"
Description: "ValueSet of the Authorized purposesOfUse types"
* ^experimental = false
* http://terminology.hl7.org/CodeSystem/v3-ActReason#FAMRQT
