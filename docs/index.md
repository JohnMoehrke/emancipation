# Emancipation Consent - JohnMoehrke Emancipation v0.1.0

* [**Table of Contents**](toc.md)
* **Emancipation Consent**

## Emancipation Consent

| | |
| :--- | :--- |
| *Official URL*:http://johnmoehrke.github.io/Emancipation/ImplementationGuide/johnmoehrke.emancipation.example | *Version*:0.1.0 |
| Draft as of 2026-08-16 | *Computable Name*:JohnMoehrkeEmancipation |
| *Other Identifiers:*OID:1.3.6.1.4.1.66281.17 | |

This is an experimental IG. The content is fully from the perspective of the author, and is not endorsed by HL7 or any other organization. It is intended to be a discussion starter, and to solicit feedback from the community.

### Scope

This IG focuses on a use-case where the subject is a minor who has been emancipated.

Emancipation is a legal status, established under the law of a particular jurisdiction, in which a minor gains some or all of the legal independence normally associated with adulthood. The exact meaning varies by jurisdiction and by the order or other legal instrument that establishes it. It can be limited in scope, effective only from a stated date, subject to conditions, or later modified or revoked. It should not be inferred solely from age, living situation, or the minor's assertion.

### Implementation

* Patient resource is used to identify the Patient
* Consent resource is used to document the Patient has legal status as emancipated.
* DocumentReference and Binary resources are used to capture the legal paperwork that documents the emancipation.

### Legal Attributes and FHIR Representation

The signed court order, decree, or other legally recognized instrument is the authoritative statement of emancipation. A FHIR Consent should not replace that instrument or imply that emancipation is universal or irrevocable. It records the healthcare organization's current, actionable interpretation of the legal status, particularly when it affects access to or control of the patient's information.

Typical attributes that should be available to an implementer or reviewer include:

* the governing jurisdiction and the legal authority that issued or recognized the status;
* the type of instrument, its identifier or case number, and the date it was issued;
* the effective date, expiration date if any, and current legal status;
* the scope of independence granted and any exceptions, restrictions, or retained parental or guardian rights;
* a reference to the signed or certified source document; and
* the organization that verified the instrument, the verification date, and a way to recognize a later amendment, replacement, or revocation.

The source document and its retention metadata belong in `DocumentReference` and, where appropriate, its `Binary` content. `DocumentReference.subject`, `author`, `custodian`, `date`, `identifier`, `type`, and `securityLabel` can carry document-level metadata. The issuing court, agency, or other authority should be represented by an `Organization` and referenced from the document or an extension when that relationship needs to be explicit.

`Consent` should contain the patient, current status, organization applying the policy, the `sourceReference` to the legal document, and only those `provision` rules that the organization can actually enforce. Its `dateTime` should identify the consent decision or policy presentation event, rather than stand in for the effective date of the legal emancipation. If jurisdiction, legal-authority identity, effective period, verification, or restriction details must be exchanged and processed as structured data, define and document extensions for those data elements. Do not use free text in a Consent provision when an access-control engine must reliably evaluate the restriction.

Emancipation can terminate, limit, or leave unchanged a parent's authority to access a minor's health information, depending on the governing law and the legal instrument. Therefore, a system must not assume either that every parent is forbidden access or that every emancipation grants unrestricted access. When a reviewed instrument requires the organization to deny parental or guardian access, represent each affected individual with a `RelatedPerson` resource that positively identifies the relationship to the patient. FHIR R4 has one root `Consent.provision`; its `type` establishes the overall direction. Use nested `provision` elements for exceptions, changing from `deny` to `permit`, or from `permit` to `deny`, at each level. Reference the relevant `RelatedPerson` in the nested `Consent.provision.actor` and constrain the rule to the data and purposes the organization must enforce. The `RelatedPerson` asserts the relationship; the referenced legal document supports the access decision.

```
classDiagram
class Patient {
emancipated minor
birthDate
}
class EmancipationConsent {
status: active
category: EmancipationConsent
dateTime
policy.uri
provision.type: deny
provision.period
provision.provision.type: permit
provision.provision.actor
provision.provision.purpose
provision.provision.provision.type: deny
provision.provision.provision.actor
provision.provision.provision.purpose
}
class DocumentReference {
legal emancipation instrument
status
type
date
identifier
securityLabel
content
}
class Binary {
signed legal content
contentType
data
}
class Organization {
legal authority 
Government
}
class RelatedPerson {
affected parent or guardian
relationship
patient
}

EmancipationConsent --> Patient : patient
EmancipationConsent --> DocumentReference : sourceReference
EmancipationConsent --> Organization : organization
DocumentReference --> Patient : subject
DocumentReference --> Organization : author or custodian
DocumentReference --> Binary : content
RelatedPerson --> Patient : patient
EmancipationConsent --> RelatedPerson : provision.actor

```

### Consent profiling

As with any Consent, often there is paperwork that ultimately holds the legal details. This legal paperwork is critical to overall legal precedent, and represents the ceremony of the act of consent from the patient. These details should be captured by a DocumentReference and Binary. The Consent.sourceReference would then point at that DocumentReference. (Could use Consent.sourceAttachment, but I am not a fan of bloating the Consent with that detail).

The Consent then would need to be profiled. The main difference from the FHIR core [Consent](http://hl7.org/fhir/consent.html) I outlined in my [Consent article](https://healthcaresecprivacy.blogspot.com/2022/05/explaining-fhir-consent-examples.html) is that this would be a specific kind of Consent.

* status - would indicate active
* category - would indicate patient consent, specifically an emancipation
* patient - would indicate the Patient resource reference for the given patient
* dateTime - would indicate when the privacy policy was presented
* performer - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian
* organization - would indicate the Organization that legally recognizes the emancipation (e.g., the State)
* source - would point at the specific signed legal emancipation text
* policy.uri - would indicate the privacy policy that was presented. Usually, the url to the version-specific policy
* provision.type - deny - is the single root provision and establishes the overall direction required by the applicable law and the legal emancipation instrument.
* provision.provision.type - permit - is an exception to the root denial, for access expressly retained by law or the legal instrument.
* provision.provision.provision.type - deny - is an exception to that permit. Each deeper provision alternates the prior provision's direction.
* provision.provision.actor.reference - would reference the `RelatedPerson` that identifies the affected parent or guardian.
* provision.provision.actor.role - would identify the parent's or guardian's relationship or authority.
* provision.provision.purpose - would constrain the access purposes to which the rule applies.

Profiled Consent for [Emancipation](StructureDefinition-EmancipationConsent.md) is included in this IG.

#### Contract resource

The Contract resource could also be used, but it is much less mature and is way too complex to simply carry a simple emancipation fact with paperwork. Therefore it is not included in this IG.

#### using Consent to enable access control

One advantage of using a Consent resource as defined here is that there would be a natural set of provisions in a Consent that would be processable by an Access Control engine that understands Consent. This Access Control engine would resolve the requesting person to the relevant RelatedPerson and apply the Consent deny or permit rules to mediate access to that Patient's data.

### Parents (other) access

A `RelatedPerson` is a positive statement that a person is related to the patient; it should not be used to assert that the relationship has been negated. The applicable access restriction belongs in a Consent provision that references that RelatedPerson, supported by the legal emancipation document.

### Examples

* [Patient](Patient-ex-patient.md)
* [Consent from the Patient indicating emancipation](Consent-ex-consent.md)
* [DocumentReference for the legal emancipation paperwork](DocumentReference-ex-documentreference.md)
* [RelatedPerson for Father](RelatedPerson-ex-father.md)
* [RelatedPerson for Mother](RelatedPerson-ex-mother.md)
* [Organization for the State that issued the emancipation](Organization-ex-organization.md)



## Resource Content

```json
{
  "resourceType" : "ImplementationGuide",
  "id" : "johnmoehrke.emancipation.example",
  "url" : "http://johnmoehrke.github.io/Emancipation/ImplementationGuide/johnmoehrke.emancipation.example",
  "version" : "0.1.0",
  "name" : "JohnMoehrkeEmancipation",
  "title" : "JohnMoehrke Emancipation",
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
  "description" : "This Implementation Guide addresses Emancipation legal rationale and authorization using a Consent resource.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "http://unstats.un.org/unsd/methods/m49/m49.htm",
      "code" : "001"
    }]
  }],
  "packageId" : "johnmoehrke.emancipation.example",
  "license" : "CC-BY-4.0",
  "fhirVersion" : ["4.0.1"],
  "dependsOn" : [{
    "id" : "hl7tx",
    "extension" : [{
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/implementationguide-dependency-comment",
      "valueMarkdown" : "Automatically added as a dependency - all IGs depend on HL7 Terminology"
    }],
    "uri" : "http://terminology.hl7.org/ImplementationGuide/hl7.terminology",
    "packageId" : "hl7.terminology.r4",
    "version" : "7.3.0"
  },
  {
    "id" : "hl7ext",
    "extension" : [{
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/implementationguide-dependency-comment",
      "valueMarkdown" : "Automatically added as a dependency - all IGs depend on the HL7 Extension Pack"
    }],
    "uri" : "http://hl7.org/fhir/extensions/ImplementationGuide/hl7.fhir.uv.extensions",
    "packageId" : "hl7.fhir.uv.extensions.r4",
    "version" : "5.3.0"
  }],
  "definition" : {
    "extension" : [{
      "extension" : [{
        "url" : "code",
        "valueString" : "copyrightyear"
      },
      {
        "url" : "value",
        "valueString" : "2022+"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "releaselabel"
      },
      {
        "url" : "value",
        "valueString" : "ci-build"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "show-inherited-invariants"
      },
      {
        "url" : "value",
        "valueString" : "false"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "usage-stats-opt-out"
      },
      {
        "url" : "value",
        "valueString" : "false"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "logging"
      },
      {
        "url" : "value",
        "valueString" : "progress"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "shownav"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "active-tables"
      },
      {
        "url" : "value",
        "valueString" : "false"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-contact"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-jurisdiction"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-publisher"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-version"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "auto-oid-root"
      },
      {
        "url" : "value",
        "valueString" : "1.3.6.1.4.1.66281.17"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "autoload-resources"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "template/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "input/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-qa"
      },
      {
        "url" : "value",
        "valueString" : "temp/qa"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-temp"
      },
      {
        "url" : "value",
        "valueString" : "temp/pages"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-output"
      },
      {
        "url" : "value",
        "valueString" : "output"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-suppressed-warnings"
      },
      {
        "url" : "value",
        "valueString" : "input/ignoreWarnings.txt"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-history"
      },
      {
        "url" : "value",
        "valueString" : "http://johnmoehrke.github.io/Emancipation/history.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "template-html"
      },
      {
        "url" : "value",
        "valueString" : "template-page.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "template-md"
      },
      {
        "url" : "value",
        "valueString" : "template-page-md.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-context"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-copyright"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-license"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-wg"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "fmm-definition"
      },
      {
        "url" : "value",
        "valueString" : "http://hl7.org/fhir/versions.html#maturity"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "propagate-status"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "excludelogbinaryformat"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "tabbed-snapshots"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-internal-dependency",
      "valueCode" : "hl7.fhir.uv.tools.r4#1.1.2"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "copyrightyear"
      },
      {
        "url" : "value",
        "valueString" : "2022+"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "releaselabel"
      },
      {
        "url" : "value",
        "valueString" : "ci-build"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "show-inherited-invariants"
      },
      {
        "url" : "value",
        "valueString" : "false"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "usage-stats-opt-out"
      },
      {
        "url" : "value",
        "valueString" : "false"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "logging"
      },
      {
        "url" : "value",
        "valueString" : "progress"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "shownav"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "active-tables"
      },
      {
        "url" : "value",
        "valueString" : "false"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-contact"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-jurisdiction"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-publisher"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-version"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "auto-oid-root"
      },
      {
        "url" : "value",
        "valueString" : "1.3.6.1.4.1.66281.17"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "autoload-resources"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "template/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "input/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-qa"
      },
      {
        "url" : "value",
        "valueString" : "temp/qa"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-temp"
      },
      {
        "url" : "value",
        "valueString" : "temp/pages"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-output"
      },
      {
        "url" : "value",
        "valueString" : "output"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-suppressed-warnings"
      },
      {
        "url" : "value",
        "valueString" : "input/ignoreWarnings.txt"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-history"
      },
      {
        "url" : "value",
        "valueString" : "http://johnmoehrke.github.io/Emancipation/history.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "template-html"
      },
      {
        "url" : "value",
        "valueString" : "template-page.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "template-md"
      },
      {
        "url" : "value",
        "valueString" : "template-page-md.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-context"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-copyright"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-license"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-wg"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "fmm-definition"
      },
      {
        "url" : "value",
        "valueString" : "http://hl7.org/fhir/versions.html#maturity"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "propagate-status"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "excludelogbinaryformat"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "tabbed-snapshots"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    }],
    "resource" : [{
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-AuthPurposesVS.html"
      }],
      "reference" : {
        "reference" : "ValueSet/AuthPurposesVS"
      },
      "name" : "Authorization purposes for delegation access valueset",
      "description" : "ValueSet of the Authorized purposesOfUse types",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-EmancipationConsent.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/EmancipationConsent"
      },
      "name" : "Consent profile indicating Emancipation",
      "description" : "This defines the constraints on a Consent to indicate that a Patient has emancipated. The Consent does not cover all aspects of emancipation, but is focused on the access control aspects of emancipation. The Consent is intended to be used in conjunction with a legal emancipation document that is captured in a DocumentReference. The Consent is intended to be used in conjunction with RelatedPerson resources that identify the parents or guardians who are affected by the emancipation.\n\n- status - would indicate active\n- category - would indicate patient consent specifically a delegation of authority\n- patient - would indicate the Patient resource reference for the given patient\n- dateTime - would indicate when the privacy policy was presented\n- performer - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian\n- organization - would indicate the Organization who presented the privacy policy, and which is going to enforce that privacy policy\n- source - would point at the specific signed consent by the patient\n- policy.uri - would indicate the privacy policy that was presented. Usually, the url to the version specific policy\n- provision.type - deny - is the single root provision and establishes the overall direction when required by the legal emancipation instrument and applicable law.\n- provision.provision.type - permit - is an exception to the root denial, such as access expressly retained by law or the legal instrument.\n- provision.provision.provision.type - deny - is an exception to that permit. Each deeper provision alternates the prior provision's direction.\n- provision.provision.actor.reference - would reference the RelatedPerson that identifies the affected parent or guardian.\n- provision.provision.actor.role - would identify the parent's or guardian's relationship or authority.\n- provision.provision.purpose - would indicate the access purposes to which the rule applies.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-AuthorizedCodes.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/AuthorizedCodes"
      },
      "name" : "Consent type that is indicating Emancipation.",
      "description" : "CodeSystem for Consent types indicating Emancipation",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "DocumentReference"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "DocumentReference-ex-documentreference.html"
      }],
      "reference" : {
        "reference" : "DocumentReference/ex-documentreference"
      },
      "name" : "DocumentReference Emancipation Paperwork example",
      "description" : "DocumentReference example of the paperwork of the Emancipation",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Organization"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Organization-ex-organization.html"
      }],
      "reference" : {
        "reference" : "Organization/ex-organization"
      },
      "name" : "Example Organization holding the legal emancipation status",
      "description" : "The Organization that holds the legal emancipation status. Usually legal counsel or a court.",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "RelatedPerson"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "RelatedPerson-ex-father.html"
      }],
      "reference" : {
        "reference" : "RelatedPerson/ex-father"
      },
      "name" : "Father - Related Person",
      "description" : "Related Father of the Patient authorized by a Consent",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "RelatedPerson"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "RelatedPerson-ex-mother.html"
      }],
      "reference" : {
        "reference" : "RelatedPerson/ex-mother"
      },
      "name" : "Mother - Related Person",
      "description" : "Related Mother of the Patient authorized by a Consent",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Patient"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Patient-ex-patient.html"
      }],
      "reference" : {
        "reference" : "Patient/ex-patient"
      },
      "name" : "Patient example",
      "description" : "Patient example for completeness sake.",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Practitioner"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Practitioner-ex-doctor.html"
      }],
      "reference" : {
        "reference" : "Practitioner/ex-doctor"
      },
      "name" : "Practitioner example doctor",
      "description" : "Practitioner example for the doctor.",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Consent"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Consent-ex-consent.html"
      }],
      "reference" : {
        "reference" : "Consent/ex-consent"
      },
      "name" : "Simple Emancipation Consent example",
      "description" : "Consent justifying Emancipation. This emancipation is defined for just a year, using provision.period to indicate expiration; this is shown as example of renewal need. \r\nWith this emancipation the father is allowed access to the Patient's data, but the mother is denied access to the Patient's data.",
      "exampleCanonical" : "http://johnmoehrke.github.io/Emancipation/StructureDefinition/EmancipationConsent"
    }],
    "page" : {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
        "valueUrl" : "toc.html"
      }],
      "nameUrl" : "toc.html",
      "title" : "Table of Contents",
      "generation" : "html",
      "page" : [{
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
          "valueCode" : "normative"
        },
        {
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "index.html"
        }],
        "nameUrl" : "index.html",
        "title" : "Emancipation Consent",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
          "valueCode" : "informative"
        },
        {
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "download.html"
        }],
        "nameUrl" : "download.html",
        "title" : "Downloads and Analysis",
        "generation" : "markdown"
      }]
    },
    "parameter" : [{
      "code" : "path-resource",
      "value" : "fsh-generated/resources"
    },
    {
      "code" : "path-resource",
      "value" : "input/capabilities"
    },
    {
      "code" : "path-resource",
      "value" : "input/examples"
    },
    {
      "code" : "path-resource",
      "value" : "input/extensions"
    },
    {
      "code" : "path-resource",
      "value" : "input/models"
    },
    {
      "code" : "path-resource",
      "value" : "input/operations"
    },
    {
      "code" : "path-resource",
      "value" : "input/profiles"
    },
    {
      "code" : "path-resource",
      "value" : "input/resources"
    },
    {
      "code" : "path-resource",
      "value" : "input/vocabulary"
    },
    {
      "code" : "path-resource",
      "value" : "input/testing"
    },
    {
      "code" : "path-resource",
      "value" : "input/history"
    },
    {
      "code" : "path-pages",
      "value" : "template/config"
    },
    {
      "code" : "path-pages",
      "value" : "input/images"
    },
    {
      "code" : "path-tx-cache",
      "value" : "input-cache/txcache"
    }]
  }
}

```
