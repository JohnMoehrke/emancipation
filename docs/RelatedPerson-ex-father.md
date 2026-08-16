# Father - Related Person - JohnMoehrke Emancipation v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Father - Related Person**

## Example RelatedPerson: Father - Related Person

Security Label: [test health data (Details: ActReason code HTEST = 'test health data')](http://terminology.hl7.org/7.3.0/CodeSystem-v3-ActReason.html)

**active**: true

**patient**: [John Schmidt Other, DoB: 2009-07-25](Patient-ex-patient.md)

**relationship**: father

**name**: John Jacob Jingleheimer Schmidt (Official)

**gender**: Male



## Resource Content

```json
{
  "resourceType" : "RelatedPerson",
  "id" : "ex-father",
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
      "code" : "FTH",
      "display" : "father"
    }]
  }],
  "name" : [{
    "use" : "official",
    "family" : "Schmidt",
    "given" : ["John", "Jacob", "Jingleheimer"]
  }],
  "gender" : "male"
}

```
