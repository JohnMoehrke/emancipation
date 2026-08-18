# Emancipation Consent

An experimental FHIR implementation guide for documenting and enforcing the healthcare access-control implications of a minor's legal emancipation.

## Scope

The guide addresses a patient who has been emancipated under the law of a particular jurisdiction. Emancipation may grant only limited independence, be subject to conditions, or be changed or revoked. The legal order, decree, or other recognized instrument remains the authoritative statement of that status; this guide does not infer emancipation from the patient's age or circumstances.

## Solution

The IG defines an `EmancipationConsent` profile and demonstrates a resource model that:

- uses `Patient` to identify the minor;
- records the legal instrument in `DocumentReference`, with `Binary` when needed for the document content;
- references that evidence from `Consent.sourceReference`;
- identifies parents or guardians with `RelatedPerson`; and
- expresses enforceable access rules through the single root FHIR R4 `Consent.provision` and nested exceptions that alternate between `deny` and `permit`.

The `Consent` represents the healthcare organization's actionable interpretation of the legal instrument. It is not a replacement for the legal document and should contain only access rules that the organization can enforce.

Formal publication: [johnmoehrke.github.io/emancipation](https://johnmoehrke.github.io/emancipation)

CI build: [build.fhir.org/ig/JohnMoehrke/emancipation](http://build.fhir.org/ig/JohnMoehrke/emancipation/branches/main/index.html)

[GitHub source repository](https://github.com/JohnMoehrke/emancipation)

## Related Consent Implementation Guides

- [Consent about AI use](https://github.com/JohnMoehrke/ConsentAboutAI)
- [Related Person Consent](https://github.com/JohnMoehrke/RelatedPersonConsent)
- [Consent with Segmentation](https://github.com/JohnMoehrke/ConsentWithSegmentation)
- [Consent with XACML encoded rules](https://github.com/JohnMoehrke/xacml-consent)

## Blog Article

### Modeling Legal Emancipation for Healthcare Access Control with FHIR Consent

Legal emancipation can change who may make healthcare decisions and who may access a minor's health information. It is not, however, a simple demographic attribute. Its meaning depends on the jurisdiction, the court order or other legal instrument, its effective period, and any conditions or exceptions contained in that instrument. A healthcare system should not infer emancipation from a patient's age, living situation, or an unsupported assertion.

The Emancipation Consent implementation guide explores a FHIR R4 pattern for representing the access-control consequences of a verified legal emancipation. The legal order, decree, or other recognized instrument remains the authoritative record. The FHIR resources make the organization's current interpretation of that evidence visible and enforceable.

The pattern uses `Patient` for the emancipated minor and `DocumentReference`, with `Binary` when appropriate, to retain the legal instrument and its metadata. The `Consent` references that source document through `Consent.sourceReference`, identifies the organization applying the policy, and carries only the rules that the organization can actually enforce.

Parents and guardians are represented as `RelatedPerson` resources. This matters because a relationship is still a positive fact even when the emancipation changes that person's access rights. The `Consent.provision.actor` references the relevant parent or guardian, while the provision expresses the resulting access rule. In FHIR R4, the single root provision establishes the overall `deny` or `permit` direction; nested provisions express exceptions by alternating that direction. This lets an implementation start with a baseline rule and then represent only the legally supported exceptions.

This approach does not claim that every emancipation denies every parent access, nor that it grants a minor unrestricted authority in every context. It creates a place to record the healthcare organization's actionable decision, trace it to the legal evidence, and apply it consistently in an access-control engine. Jurisdiction, legal authority, effective period, verification details, and restrictions should remain available in the source document or in well-defined extensions when they must be exchanged as structured data.

The guide is experimental and intended to encourage discussion. For the profile, examples, and implementation details, see:

- [GitHub source repository](https://github.com/JohnMoehrke/emancipation)
- [CI build](http://build.fhir.org/ig/JohnMoehrke/emancipation/branches/main/index.html)
- [Formal publication](https://johnmoehrke.github.io/emancipation)

The formal publication is the stable reference for this work; the CI build shows the current development state.

