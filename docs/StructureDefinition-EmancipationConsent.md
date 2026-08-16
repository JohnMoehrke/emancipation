# Consent profile indicating Emancipation - JohnMoehrke Emancipation v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Consent profile indicating Emancipation**

## Resource Profile: Consent profile indicating Emancipation 

| | |
| :--- | :--- |
| *Official URL*:http://johnmoehrke.github.io/Emancipation/StructureDefinition/EmancipationConsent | *Version*:0.1.0 |
| Draft as of 2026-08-16 | *Computable Name*:EmancipationConsent |
| *Other Identifiers:*OID:1.3.6.1.4.1.66281.17.42.1 | |

 
This defines the constraints on a Consent to indicate that a Patient has emancipated. The Consent does not cover all aspects of emancipation, but is focused on the access control aspects of emancipation. The Consent is intended to be used in conjunction with a legal emancipation document that is captured in a DocumentReference. The Consent is intended to be used in conjunction with RelatedPerson resources that identify the parents or guardians who are affected by the emancipation. 
* status - would indicate active
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
 

**Usages:**

* Examples for this Profile: [Consent/ex-consent](Consent-ex-consent.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/johnmoehrke.emancipation.example|current/StructureDefinition/StructureDefinition-EmancipationConsent.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-EmancipationConsent.csv), [Excel](StructureDefinition-EmancipationConsent.xlsx), [Schematron](StructureDefinition-EmancipationConsent.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "EmancipationConsent",
  "url" : "http://johnmoehrke.github.io/Emancipation/StructureDefinition/EmancipationConsent",
  "identifier" : [{
    "system" : "urn:ietf:rfc:3986",
    "value" : "urn:oid:1.3.6.1.4.1.66281.17.42.1"
  }],
  "version" : "0.1.0",
  "name" : "EmancipationConsent",
  "title" : "Consent profile indicating Emancipation",
  "status" : "draft",
  "date" : "2026-08-16T13:44:45-05:00",
  "publisher" : "John Moehrke (himself)",
  "contact" : [{
    "name" : "John Moehrke (himself)",
    "telecom" : [{
      "system" : "url",
      "value" : "http://healthcaresecprivacy.blogspot.com"
    },
    {
      "system" : "email",
      "value" : "JohnMoehrke@gmail.com"
    }]
  },
  {
    "name" : "John Moehrke (himself)",
    "telecom" : [{
      "system" : "email",
      "value" : "JohnMoehrke@gmail.com"
    }]
  }],
  "description" : "This defines the constraints on a Consent to indicate that a Patient has emancipated. The Consent does not cover all aspects of emancipation, but is focused on the access control aspects of emancipation. The Consent is intended to be used in conjunction with a legal emancipation document that is captured in a DocumentReference. The Consent is intended to be used in conjunction with RelatedPerson resources that identify the parents or guardians who are affected by the emancipation.\n\n- status - would indicate active\n- category - would indicate patient consent specifically a delegation of authority\n- patient - would indicate the Patient resource reference for the given patient\n- dateTime - would indicate when the privacy policy was presented\n- performer - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian\n- organization - would indicate the Organization who presented the privacy policy, and which is going to enforce that privacy policy\n- source - would point at the specific signed consent by the patient\n- policy.uri - would indicate the privacy policy that was presented. Usually, the url to the version specific policy\n- provision.type - deny - is the single root provision and establishes the overall direction when required by the legal emancipation instrument and applicable law.\n- provision.provision.type - permit - is an exception to the root denial, such as access expressly retained by law or the legal instrument.\n- provision.provision.provision.type - deny - is an exception to that permit. Each deeper provision alternates the prior provision's direction.\n- provision.provision.actor.reference - would reference the RelatedPerson that identifies the affected parent or guardian.\n- provision.provision.actor.role - would identify the parent's or guardian's relationship or authority.\n- provision.provision.purpose - would indicate the access purposes to which the rule applies.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "http://unstats.un.org/unsd/methods/m49/m49.htm",
      "code" : "001"
    }]
  }],
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Consent",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Consent",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Consent",
      "path" : "Consent"
    },
    {
      "id" : "Consent.modifierExtension",
      "path" : "Consent.modifierExtension",
      "max" : "0"
    },
    {
      "id" : "Consent.status",
      "path" : "Consent.status",
      "patternCode" : "active"
    },
    {
      "id" : "Consent.scope",
      "path" : "Consent.scope",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/consentscope",
          "code" : "patient-privacy"
        }]
      }
    },
    {
      "id" : "Consent.category",
      "path" : "Consent.category",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "$this"
        }],
        "rules" : "open"
      },
      "min" : 3
    },
    {
      "id" : "Consent.category:representative",
      "path" : "Consent.category",
      "sliceName" : "representative",
      "min" : 1,
      "max" : "1",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://johnmoehrke.github.io/Emancipation/CodeSystem/AuthorizedCodes",
          "code" : "EmancipationConsent"
        }]
      }
    },
    {
      "id" : "Consent.category:relInfo",
      "path" : "Consent.category",
      "sliceName" : "relInfo",
      "min" : 1,
      "max" : "1",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "64292-6",
          "display" : "Release of information consent"
        }]
      }
    },
    {
      "id" : "Consent.category:idscl",
      "path" : "Consent.category",
      "sliceName" : "idscl",
      "min" : 1,
      "max" : "1",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/v3-ActCode",
          "code" : "IDSCL"
        }]
      }
    },
    {
      "id" : "Consent.patient",
      "path" : "Consent.patient",
      "min" : 1
    },
    {
      "id" : "Consent.dateTime",
      "path" : "Consent.dateTime",
      "min" : 1
    },
    {
      "id" : "Consent.performer",
      "path" : "Consent.performer",
      "min" : 1
    },
    {
      "id" : "Consent.organization",
      "path" : "Consent.organization",
      "min" : 1
    },
    {
      "id" : "Consent.source[x]",
      "path" : "Consent.source[x]",
      "short" : "would point at the Consent paperwork signed by the Patient",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Consent",
        "http://hl7.org/fhir/StructureDefinition/DocumentReference",
        "http://hl7.org/fhir/StructureDefinition/Contract",
        "http://hl7.org/fhir/StructureDefinition/QuestionnaireResponse"]
      }]
    },
    {
      "id" : "Consent.provision",
      "path" : "Consent.provision",
      "mustSupport" : true
    },
    {
      "id" : "Consent.provision.type",
      "path" : "Consent.provision.type",
      "patternCode" : "deny"
    }]
  }
}

```
