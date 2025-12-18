
---

## 🧩 Implementation Breakdown

### **1️⃣ Relational OLTP Database (PostgreSQL)**

**Files:**
- `Table Creation queries.sql`
- `Table insertion queries.sql`

**Description:**
- Fully normalized relational schema
- Strong referential integrity using PK/FK constraints
- Captures:
  - Patients & demographics
  - Diseases & tests
  - Healthcare providers
  - Insurance & medication data
- Designed for **transactional workloads (OLTP)**

---

### **2️⃣ Operational Queries & DML**

**Files:**
- `operationalquery.sql`
- `dmloperation.sql`

**Includes:**
- Patient disease reports
- Medication effectiveness analysis
- Disease distribution by race and location
- INSERT, UPDATE, DELETE operations for live data scenarios

---

### **3️⃣ Dimensional Model (Star Schema)**

**Files:**
- `dimcreation.sql`
- `dimensiontablepopulate.sql`
- `updatedimtables.sql`

**Fact Table:**
- `fact_disease_event`

**Dimensions:**
- Patient
- Disease
- Provider
- Location
- Date
- Medicine
- Race
- Insurance

**Key Feature:**
- **Slowly Changing Dimension Type 2 (SCD2)** implemented on patient dimension to preserve historical accuracy.

---

### **4️⃣ Analytical Queries**

**File:**
- `analyticalqueriesstarschema.sql`

**Use Cases:**
- Disease prevalence trends
- Average severity over time
- Healthcare provider efficiency
- Insurance plan effectiveness
- Regional disease hotspot analysis

Optimized for **BI and decision support**.

---

### **5️⃣ Data Dictionary & Documentation**

**Files:**
- `Finaldatadictionary.html`
- `Datawarehousedictionary.html`
- `FinalProjectDocumentation.docx`
- `FinalProjectDocumentation.html`

**Purpose:**
- Detailed table definitions
- Attribute descriptions
- Key constraints and relationships
- Business context and design justification

---

### **6️⃣ Dashboard & Visualization**

**Files:**
- `DiseaseDashboard.pbix`
- `DiseaseDashboard.html`

**Dashboard Highlights:**
- Total disease cases
- Patients treated
- Disease severity averages
- Gender-based analysis
- Insurance plan utilization
- Yearly disease trends
- Global disease distribution map

Designed to support **healthcare policy and planning decisions**.

---

### **7️⃣ Cloud Architecture (Conceptual)**

**Documented in:**
- `FinalProjectDocumentation.*`

**Architecture Style:**
- AWS Lambda Architecture
  - Batch Layer (S3, Glue, Athena)
  - Speed Layer (Kinesis, Lambda)
  - Serving Layer (EMR, Redshift/RDS)

**Focus:**
- Scalability
- Real-time insights
- Security and fault tolerance

---

### **8️⃣ NoSQL & Snowflake Comparison**

**Included in Documentation**
- MongoDB (Document model)
- Neo4j (Graph model)
- Snowflake advantages for analytics

**Conclusion:**
Relational + dimensional modeling remains optimal for structured healthcare analytics, with NoSQL and Snowflake enhancing specific use cases.

---

## 🔐 Technologies Used

- PostgreSQL
- SQL
- Dimensional Modeling (Star Schema)
- SCD Type 2
- Power BI
- AWS Architecture (conceptual)
- Snowflake (conceptual)


---

## 📚 Academic Disclaimer

This project was developed **for academic purposes only** as part of a graduate-level Structured Data Management course.  
All data is simulated and does not represent real patients.

---

## 🏁 Conclusion

This project demonstrates:
- Strong database design fundamentals
- End-to-end analytical workflow
- Industry-aligned healthcare analytics architecture
- Business-ready insights through BI dashboards

It serves as a **complete blueprint for scalable public health data analytics**.

---
