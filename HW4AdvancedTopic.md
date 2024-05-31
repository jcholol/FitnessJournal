# HW4 - Advanced Topics: Machine Learning in Mobile Computing (Federated Learning)

## Introduction
Machine Learning (ML) is becoming more and more essential for software development, powering everything from personalized recommendations to smart voice assistance and virtual/augmented reality applications. However, many challenges occur with the growing demands for more intuitive mobile experiences, such as protecting user privacy while leveraging vast amounts of data. This is where federated learning can be utilized. 

Federated learning is a privacy-preserving, machine-learning method first introduced by Google in 2017. It is a cutting-edge approach that lets artificial intelligence (AI) models train without anyone seeing or touching your data. Instead of pooling all of the data into one place, each device (phone or tablet) trains the model locally and sends the updates (not data) back to the central server. The server then aggregates these updates and refines the global model, which is then redistributed back to the devices. With federated learning, the model is allowed to learn from large amounts of data without having any access to the data ensuring that individual data is kept safe and secure.

The significance of federated learning in mobile computing is profound. Our mobile devices are treasure troves of personal information, from health and bank data to photos and text messages. Traditional ML methods, which rely on centralized data collection, raise serious privacy and security concerns. Federated learning addresses these issues head-on by ensuring that user data never leaves the device, thereby reducing the risk of data breaches and enhancing user trust. 

This paper will start by looking at the latest trends and industry needs that are driving the adoption of federated learning, then it’ll examine the current solutions and techniques being used, following that it’ll provide a critical analysis to weigh the pros and cons, and finally, it’ll suggest some solutions and future directions to overcome existing challenges and make federated learning even more effective. 

## Industry Trends and Needs
As mobile devices become a norm in our day-to-day lives, the industry faces several critical needs. Privacy and security are paramount, especially with regulations like the General Data Protection Regulation (GDPR) and the California Consumer Privacy Act (CCPA), federated learning addresses these by keeping data on the device and only sharing model updates. 

Federated Learning is increasingly being applied in various sectors of mobile computing, reflecting its growing importance and versatility. One significant area of application is mobile health (mHealth). In mHealth, healthcare-related data are typically collected from digital devices, such as biomedical sensors attached to the user’s body or portable devices with relevant applications installed. Traditionally, training ML models requires centralized datasets, where a central server has access to the data of all patients. This approach creates privacy concerns for patients who may not want to share their personal information, and the regulatory requirements within the healthcare industry also limit the sharing of sensitive information. Federated learning offers a potential solution for mitigating these challenges associated with sharing raw patient data in mHealth applications (Wang, et al.).

Smart devices such as phones, watches, and home assistants also benefit significantly from federated learning. By enabling these devices to learn from data locally, federated learning enhances their capabilities while ensuring data privacy. This is particularly useful for features like predictive text input, voice recognition, and personal assistant functionalities. For example, Google’s Gboard uses federated learning to improve its predictive typing model by learning from user interactions on their devices (Hard, et al.). 

Smart home devices are another area where federated learning is making a substantial impact. These devices use federated learning to learn from the user’s habits and preferences to provide better automation and control. For instance, personalized recommender systems can help homeowners in reducing electric bills, and recommend entertainment content, and healthcare-related tips (CWRU). 

There are many other mobile applications such as fitness apps and social media platforms that leverage federated learning to provide personalized recommendations and insights. With the use of federated learning (learning from local data), user data can be protected while providing personalized recommendations. 

## Current Solutions
Federated learning is implemented in various ways to address data privacy issues in the mobile computing industry. Google has been at the forefront of this effort with applications like Gboard (google’s keyboard app). Gboard uses federated learning to improve its predictive typing models by training the machine learning model on the user’s local data rather than sending individual keystrokes to a central server. Once the app trains the model locally, the model updates are sent to Google’s servers, aggregating updates from other users to enhance the global model. This approach allows for effective ML model training while ensuring user data privacy (Hard, et al.).

Although Apple does not explicitly brand its approach as federated learning, its Core ML framework operates similarly. Core ML is optimized for on-device performance, leveraging Apple hardware to minimize memory footprint and power consumption. This framework allows developers to integrate machine learning models into their apps, with these models running directly on the user’s device. This method keeps the app responsive and user data private, thereby addressing privacy concerns. 

Another noteworthy solution is Syft, an open-source stack from OpenMinded that implements federated learning and other privacy-preserving techniques. Syft decouples private data from model training by using federated learning, differential privacy, and encrypted computation. It provides a numpy-like interface and integrates with deep learning frameworks, allowing data scientists to maintain their current workflows while employing these new privacy-enhancing techniques (Github/OpenMinded/PySyft). 

In addition to federated learning, differential privacy techniques are used to ensure that the model updates sent from devices do not reveal sensitive user information. Companies like Google and Apple add noise to the data through differential privacy, making identifying users from the model updates difficult. This method enhances the privacy-preserving capabilities of federated learning by ensuring that even if updates are intercepted, they do not compromise user privacy. 

## Critical Analysis
### Pros
- Data remains local on the device, minimizing risks of data breaches and complying with regulations like GDPR and CCPA (enhanced privacy).
- Data is processed locally, reducing the need for data transfers, thus lowering latency and bandwidth for real-time applications (reduced resource usage).
- Learning is distributed among devices, preventing the central servers from being overwhelmed (scalability).
- Reduces legal risks as data processing is done locally (regulatory compliance).
### Cons 
- Frequent model updates can consume a significant amount of resources, especially if bandwidth is limited (communication overhead).
- Inconsistent data models could degrade the overall model quality (heterogeneous data quality).
- Doing a lot of data processing on local devices can eat up the battery and memory of the personal device (resource constraints).
- Model updates can be intercepted or messed with if properly secured (security concerns).

## Proposed Solution
To address the limitations of current federated learning solutions in mobile computing, I propose an innovative future concept called “Personalized Quantum Federated Learning”. This speculative solution envisions using personal quantum computers/servers, allowing users to compare their data with others without ever transmitting raw data. 
### Key Features
- Each user has a personal quantum server that uses quantum computing to process data locally.
- Data comparisons are made using quantum algorithms without sharing actual data
- Model updates are shared through secure quantum channels, maintaining data integrity, without the need for centralized servers.
- Data never leaves the device, quantum encryption ensures robust security
- Quantum processors enable efficient local training, preserving device resources
### Benefits 
- Utmost data security
- No communication overhead
- Scalable
- Resource Efficiency

## Citations and Examples

- https://www.jmir.org/2023/1/e43006 Wang T, Du Y, Gong Y, Choo KKR, Guo Y Applications of Federated Learning in Mobile Health: Scoping Review J Med Internet Res 2023;25:e43006
- https://research.google/pubs/federated-learning-for-mobile-keyboard-prediction-2/ (
- https://doi.org/10.48550/arXiv.1811.03604) @misc{47586, title	= {Federated Learning for Mobile Keyboard Prediction}, author	= {Andrew Hard and Chloé M Kiddon and Daniel Ramage and Francoise Beaufays and Hubert Eichner and Kanishka Rao and Rajiv Mathews and Sean Augenstein}, year	= {2018}, URL	= {https://arxiv.org/abs/1811.03604}}
- https://engineering.case.edu/research/labs/SPiD/projects/p4_smarthome
- https://developer.apple.com/machine-learning/core-ml/
- https://dl.acm.org/doi/10.1561/0400000042
- https://openmined.org/
- https://github.com/OpenMined/PySyft

