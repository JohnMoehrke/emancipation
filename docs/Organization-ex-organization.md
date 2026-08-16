# Example Organization holding the legal emancipation status - JohnMoehrke Emancipation v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Example Organization holding the legal emancipation status**

## Example Organization: Example Organization holding the legal emancipation status

Security Label: [test health data (Details: ActReason code HTEST = 'test health data')](http://terminology.hl7.org/7.3.0/CodeSystem-v3-ActReason.html)

**active**: true

**type**: Government

**name**: somewhere org



## Resource Content

```json
{
  "resourceType" : "Organization",
  "id" : "ex-organization",
  "meta" : {
    "security" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-ActReason",
      "code" : "HTEST"
    }]
  },
  "active" : true,
  "type" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/organization-type",
      "code" : "govt"
    }]
  }],
  "name" : "somewhere org"
}

```
