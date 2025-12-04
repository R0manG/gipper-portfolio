<div align="center">

# 🦖 Left Handyman Website & AI Platform

Modernizing a small business website with  
**responsive UX, performance tuning, architecture design, and AI-powered customer workflows.**

![Phase](https://img.shields.io/badge/current%20phase-Website%20Modernization-blue)
![Tech](https://img.shields.io/badge/stack-HTML%20%7C%20CSS%20%7C%20AI%20%7C%20GCP-orange)
![Status](https://img.shields.io/badge/status-active-brightgreen)

https://lefthandyman.com
---

</div>


## Overview
Lefthandyman is a handyman services business based in Iowa. This project is my effort to modernize its digital presence and build a scalable, AI-augmented platform that helps the owner manage customer requests, quoting, scheduling, and follow-ups.

This portfolio project is being developed and deployed in phases:

### **Phase 1 – Website Modernization (Current Phase)**
Improve the existing production website (www.lefthandyman.com), which is self-hosted on a Raspberry Pi. The focus is responsive design, image optimization, and improved user experience across desktop and mobile.

### **Phase 2 – AI-Assisted Business Tools**
Introduce AI-driven workflows such as job intake, quoting, customer triage, and scheduling automation.

### **Phase 3 – Cloud Migration & Scaling**
Move from Raspberry Pi hosting to a cloud platform (GCP or Firebase), integrate data persistence, and develop an admin dashboard.

---

## Problem Statement (Phase 1 – Website UX Improvements)

The website currently functions but displays inconsistent layouts across devices. Images do not scale smoothly on mobile, visual hierarchy is unclear in some sections, and the overall UI does not yet reflect the professionalism required to build trust with customers.

**Pain Points:**
- Images stretch or crop incorrectly  
- Mobile layout issues reduce readability  
- No responsive image handling  
- Some spacing and typography inconsistencies  
- Raspberry Pi hosting requires careful performance optimization  

**Why it matters:**  
A handyman service business relies heavily on **first impressions**, visual clarity, and trust-building. A polished, responsive site significantly increases conversion and credibility.

---

## Goals (Phase 1 – UX + Responsiveness)

### **Primary Goals**
- Improve mobile and desktop user experience  
- Implement responsive image behavior  
- Add layout breakpoints for mobile, tablet, and desktop  
- Optimize images for faster load times  
- Improve visual consistency and alignment  
- Increase Lighthouse performance and accessibility scores  

### **Success Criteria**
- Images render cleanly on screens from 320px to full desktop  
- Bounce rate decreases (if analytics added later)  
- Owner feedback confirms improved usability  
- Clear before/after visual documentation  

---

## Future Enhancements (Phase 2+)

### **AI Features**
- AI assistant for customer intake  
- AI-based job quote helper  
- Image-based complexity estimation (upload → suggested time/materials)  
- Suggested follow-up messaging  

### **Business Tools**
- Request database  
- Admin dashboard  
- Scheduling engine  
- Automated customer notifications  

### **Cloud Improvements**
- Migrate hosting from Raspberry Pi to GCP  
- Add Cloud Run or Firebase backend  
- Add CDN and TLS automation  

---

## Current Architecture (Phase 1)
- **Hosting:** Raspberry Pi in home network  
- **Web Server:** Apache or Nginx  
- **Frontend:** HTML/CSS/JS static site  
- **Deployment:** Manual upload  
- **Network:** Port forwarding + external domain routing  

### Planned Architecture Evolution
- Containerize frontend/backend  
- Deploy to Cloud Run or Firebase Hosting  
- Add secure backend for customer record storage  
- Introduce AI microservices using Gemini  

---

## Roadmap

### **Phase 1 – Website Modernization**
- UX audit  
- Responsive image implementation  
- Breakpoints added for mobile/tablet/desktop  
- Typography + spacing improvements  
- Performance tuning  

### **Phase 2 – AI Augmentation**
- Intake form → backend storage  
- AI triage assistant  
- Quote helper (first real AI integration)  
- Image-based estimate prototype  

### **Phase 3 – Cloud Migration**
- Move to GCP  
- Add CDN + caching  
- Integrate dashboard and authentication  

---

## My Role
I serve as:
- **Product Owner** — requirements gathering, prioritization, and UX definition  
- **Technical Program Manager** — roadmap creation, documentation, and iteration planning  
- **Architect** — current and future-state design  
- **Developer** — implementing responsive UI changes and future AI/Cloud integrations  

This project demonstrates real-world problem solving, AI/Cloud implementation, and end-to-end TPM thinking.

---

## Project Management
All administrative documents, including the full project tracker, risks register, and dependencies matrix, are maintained internally in Google Drive.
Final public artifacts are published in this repository.

---

## Next Steps
- Document UX audit with screenshots  
- Implement responsive image scaling  
- Create architecture diagram for current + proposed state  
- Build backlog items + user stories  
- Begin AI quote helper prototype  
