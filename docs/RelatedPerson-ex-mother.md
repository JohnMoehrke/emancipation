# Mother - Related Person - JohnMoehrke Emancipation v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Mother - Related Person**

## Example RelatedPerson: Mother - Related Person

Security Label: [test health data (Details: ActReason code HTEST = 'test health data')](http://terminology.hl7.org/7.3.0/CodeSystem-v3-ActReason.html)

**active**: true

**patient**: [John Schmidt Other, DoB: 2009-07-25](Patient-ex-patient.md)

**relationship**: mother

**name**: Mary Ann Schmidt (Official)

**gender**: Female



## Resource Content

```json
{
  "resourceType" : "RelatedPerson",
  "id" : "ex-mother",
  "meta" : {
    "security" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-ActReason",
      "code" : "HTEST"
    }]
  },
  "active" : true,
  "patient" : {
    "reference" : "Patient/ex-patient"
  },
  "relationship" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-RoleCode",
      "code" : "MTH",
      "display" : "mother"
    }]
  }],
  "name" : [{
    "use" : "official",
    "family" : "Schmidt",
    "given" : ["Mary", "Ann"]
  }],
  "gender" : "female"
}

```
