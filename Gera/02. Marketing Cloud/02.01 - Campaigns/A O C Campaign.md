---
date: 2026-08-05
created: 2026-08-05
status: Draft
tags:
  - el-grupo
  - sfmc
  - lfc
  - el-grupo-one-rewards
  - governance
  - mrm
---

  

# A O C Campaign  

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[Anniversary Offer Completion Campaign]]
> WHERE file.path != this.file.path
> ```

  

La **A O C Campaign** es una campaña de **Lifecycle Marketing** dentro de **El Grupo #OR** diseñada para reconocer a los miembros que completaron exitosamente una oferta de aniversario y recibieron los puntos correspondientes. Su objetivo es incrementar la satisfacción del miembro, fortalecer la relación con el programa de lealtad y fomentar futuras interacciones con la marca. 【1-975f03】  

  

La campaña opera bajo un modelo **Always-On**, basado en triggers y automatizaciones dentro de Salesforce Marketing Cloud, formando parte de la estrategia continua de Lifecycle Marketing. 【1-975f03】【2-f1d96e】  

  

## Objetivo  

  

- Incrementar satisfacción del miembro.  

- Reforzar el valor percibido de El Grupo #OR.  

- Reconocer hitos importantes dentro del programa de lealtad.  

- Incentivar futuras reservaciones y participación en promociones. 【1-975f03】  

  

## Clasificación  

  

| Campo | Valor |  

|---------|---------|  

| Portfolio | Lifecycle Marketing |  

| Tipo | Offer Completion |  

| Canal | Email |  

| Mercado | Global |  

| Audiencia | Miembros que completaron la oferta y recibieron puntos |  

| Cadencia | Upon Completion |  

  

【1-975f03】  

  

## Audiencia  

  

La audiencia está compuesta por miembros que:  

  

- Completaron la oferta de aniversario.  

- Recibieron exitosamente los puntos asociados a dicha promoción. 【1-975f03】  

  

## Cadencia  

  

```text  

Upon Completion  

```  

  

La comunicación se envía inmediatamente después de completarse la oferta correspondiente. 【1-975f03】  

  

## Naming Convention  

  

### Formato  

  

```text  

Region_Category_CampaignName_MRMID_Version_Language  

```  

  

### Ejemplo  

  

```text  

GLB_Lifecycle_AnniversaryOfferCompletion_12290451_V1_EN  

```  

  

### Componentes  

  

- Region → Región o mercado.  

- Category → Tipo de campaña.  

- CampaignName → Nombre funcional de la campaña.  

- MRMID → Marketing Resource Management Identifier.  

- Version → Control de versiones.  

- Language → Idioma/localización.  

  

## MRM ID  

  

```text  

12290451  

```  

  

La documentación encontrada asocia el identificador **12290451** a campañas A O C dentro del programa Lifecycle. 【1-975f03】  

  

## Ejemplos de Campañas  

  

### A O  - Year 1  

  

Oferta:  

  

```text  

1,000 bonus points per night  

10,000 point cap  

```  

  

Subject Line:  

  

```text  

You've earned XX points!  

```  

  

Preheader:  

  

```text  

Start planning your next trip with El Grupo One Rewards.  

```  

  

【1-975f03】  

  

### A O - Year 25  

  

Oferta:  

  

```text  

4X bonus points per stay  

25,000 point cap  

```  

  

Misma lógica de Offer Completion basada en trigger posterior al cumplimiento de la promoción. 【1-975f03】  

  

## Relación con el Modelo Operativo de Guadalajara  

  

Dentro de la transición de operaciones de Atlanta hacia Guadalajara, este tipo de campañas sigue el flujo operativo estándar:  

  

1. Marketing define la iniciativa.  

2. Data genera la audiencia.  

3. Se entregan Data Extensions.  

4. Creative y Content generan materiales.  

5. Email Marketing desarrolla la pieza en SFMC.  

6. QA valida la implementación.  

7. Deployment.  

8. Seguimiento de resultados. 【3-f0a2b6】【2-f1d96e】  

  

## Consideraciones Técnicas  

  

### Salesforce Marketing Cloud  

  

Responsable de:  

  

- Desarrollo de emails.  

- Configuración de journeys.  

- Automatizaciones.  

- Deployment.  

- Ejecución de campañas Lifecycle. 【3-f0a2b6】  

  

### Buenas prácticas identificadas  

  

- Uso de Content Blocks reutilizables.  

- Arquitectura escalable.  

- Reutilización de componentes.  

- Apego a governance y naming conventions.  

- Estrategia de localización global. 【3-f0a2b6】【2-f1d96e】  

  

## Aprendizajes Relevantes para el Rol SFMC Technical Developer  

  

- Lifecycle Marketing es uno de los pilares principales de la operación.  

- Los MRM IDs son identificadores fundamentales para el rastreo de iniciativas.  

- Naming Conventions permiten gobernanza y mantenibilidad.  

- La calidad de desarrollo impacta directamente escalabilidad y velocidad de ejecución.  

- Los componentes reutilizables son una prioridad estratégica para reducir esfuerzo operativo.  

- El trabajo requiere coordinación continua con equipos de Data, Localization, Content Operations, Creative Services y Marketing Governance. 【3-f0a2b6】【2-f1d96e】  

  

# Relaciones  

  

## Core Knowledge Base  

  

- [[El Grupo Marketing Cloud Onboarding]]  

- [[Email Marketing Program Playbook]]  

- [[Email Marketing Team]]  

- [[Atlanta Transition]]  

- [[Guadalajara Email Marketing Team]]  

  

## Lifecycle Marketing  

  

- [[Lifecycle Marketing]]  

- [[Lifecycle Campaigns]]  

- [[Engage Portfolio]]  

- [[Loyalty Communications]]  

- [[El Grupo One Rewards]]  

  

## Salesforce Marketing Cloud  

  

- [[Salesforce Marketing Cloud]]  

- [[Journey Builder]]  

- [[Content Builder]]  

- [[Content Blocks]]  

- [[Shared Content]]  

- [[Data Extensions]]  

- [[Automation Studio]]  

  

## Marketing Governance  

  

- [[Marketing Governance]]  

- [[MRM ID]]  

- [[SFMC Naming Convention]]  

- [[Campaign Versioning]]  

- [[Localization Process]]  

- [[Content Governance]]  

  

## Delivery Process  

  

- [[Campaign Intake Process]]  

- [[Email Development Process]]  

- [[QA Process]]  

- [[Testing Process]]  

- [[Deployment Process]]  

  

## Teams  

  

- [[Data Team]]  

- [[Localization Team]]  

- [[Content Operations]]  

- [[Creative Services]]  

  

## Related Campaigns  

  

- [[Anniversary Offer Year 1]]  

- [[Anniversary Offer Year 25]]  

- [[Transactional Communications]]  

- [[Ad Hoc Campaigns]]  

- [[Loyalty Promotions]]  

  

# Relación Estratégica  

  

[[El Grupo Marketing Cloud Onboarding]]  

→ [[Email Marketing Team]]  

→ [[Lifecycle Marketing]]  

→ [[A O C Campaign]]  

→ [[Salesforce Marketing Cloud]]  

→ [[Content Blocks]]  

→ [[Reusable Components]]  

→ [[Marketing Governance]]  

→ [[SFMC Naming Convention]]  

→ [[MRM ID]]  

→ [[Scalable Campaign Development]]  

  

# Notas Personales  

  

Como SFMC Technical Developer, esta campaña representa un buen ejemplo de:  

  

- Uso de audiencias ya definidas por Data.  

- Consumo de Data Extensions