Frontend organizer framework
=========

Micro framework to organize JS code for frontend applications.

### Features:
* Organizes JS code to define page bahaviour
* Reduces modules cohesion by providing **subscribe/notify** pattern
* Allows to easily extend page functionality by adding new components
* Reduces amount of code you need to write
  
### Philosofy:
* Each page has it's own `.js` file (aka page module, `PageModule class`) that tie together your widgets (or components `PageComponent class`)
* Widgets/components are classes which are extended from `PageComponent class`. They can:
 * init DOM elements in one place
 * attach signals listeners (**subscribe/notify** implemened by`Observer class`)
 * attach **jQuery** events handlers
* You can write **as many components** as you need. Each component will **handle events** like button clicks and **notify subscribed objects** (if neccessary). That way your **components do not depend on another components** and can be **reused** on another pages. Just **compose you page** using **existing** components.

### Description
All frameworks classes are defined inside of *Rrs* object.

### Classes
* PageModule - base class for module that incapsulates page's code
* PageComponent - base class for page components. Extens your component from this class
* Observer - implements  **emmit/subscribe** functionality

### Usage

```js
TBD
```

 

    