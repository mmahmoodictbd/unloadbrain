---
layout: post
title: How to manage grocery list in Home Assistant
date: 2021-03-07 02:50:00 +0100
excerpt: |
    We all know HA has a shopping list integration, but it's a simple todo list, not well suited for managing groceries. 
    Some people might suggest Grocy, but I didn't need that many functionalities.
categories: [tech]
tags: [home-assistant, shopping-list, home-automation]
---

![image](/assets/images/2021-03/ha-shopping-list.png)
<br/>
<br/>

### HA's Shopping List?
- We all know HA has a shopping list integration, but it's a simple todo list.
- You can add item and mark as checked. You can delete the checked items.
- If you need to add the same item again, you need to type it.
<br/>

### What I needed?
- My grocery items are pretty much constant, i.e. milk, cooking oil, stuff like that.
- Every week it's same item over and over.
- I didn't wanted to type to add same item to HA's shopping list again and again.
<br/>

### How did I solve?

- I created a Lovelace dashboard on HA.
- Added button cards that add the item to the HA's shopping list on click.
<br/>

### Technical
On `configurations.yaml`, added the following to add a dashboard that shows on the sidebar.
```
lovelace:
  mode: storage
  dashboards:
    addtoshoppinglist-dashboard-lovelace-yaml:
      mode: yaml
      title: Add to ShoppingList Dashboard
      show_in_sidebar: true
      filename: dashboards/AddToShoppingListDashboard-lovelace.yaml
```

Content of `dashboards/AddToShoppingListDashboard-lovelace.yaml` -
```
title: Add to ShoppingList Dashboard
views:
  - path: addtoshoppinglist_dashboard_view
    title: Add to ShoppingList Dashboard
    cards:
      - type: vertical-stack
        cards: !include ShoppingListVegetables.yaml
      - type: vertical-stack
        cards: !include ShoppingListSpices.yaml
      - type: vertical-stack
        cards: !include ShoppingListFruites.yaml
      - type: vertical-stack
        cards: !include ShoppingListOthers.yaml
      - type: vertical-stack
        cards: !include ShoppingListGrains.yaml
      - type: vertical-stack
        cards: !include ShoppingListWashroom.yaml
      - type: vertical-stack
        cards: !include ShoppingListSnacks.yaml
      - type: vertical-stack
        cards: !include ShoppingListBreakfast.yaml
      - type: vertical-stack
        cards: !include ShoppingListProtein.yaml
```

Content of `include ShoppingListBreakfast.yaml` -
```
- type: markdown
  content: >
    ## Breakfast
- type: horizontal-stack
  cards:
    - type: vertical-stack
      cards:
        - type: button
          name: Half Milk
          tap_action:
            action: call-service
            service: shopping_list.add_item
            service_data:
              name: Half Milk
        - type: button
          name: Oats/Cereal
          tap_action:
            action: call-service
            service: shopping_list.add_item
            service_data:
              name: Oats/Cereal
        - type: button
          name: Bread
          tap_action:
            action: call-service
            service: shopping_list.add_item
            service_data:
              name: Bread
    - type: vertical-stack
      cards:
        - type: button
          name: Egg
          tap_action:
            action: call-service
            service: shopping_list.add_item
            service_data:
              name: Egg
```
I added three items on the `vertical-stack` because on the mobile screen 3 button looks perfect.
<br/>


### Related Posts
- [Home Assistant in Docker hosts mode with Traefik 2 and Let's Encrypt]({% post_url 2020-12-08-home-assistant-in-docker-hosts-mode-with-traefik2-and-lets-encrypt-working-sample %})
- [Run deCONZ on Kubernetes]({% post_url 2020-01-29-run-deconz-on-kubernates %})
<br/>
<br/>

Live long and prosper! :vulcan_salute:

<br/>
<br/>

