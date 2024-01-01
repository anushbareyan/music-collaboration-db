# Music Collaboration Database

This project aims to create a comprehensive database schema for managing music collaboration workspaces, subscriptions, projects, albums, tracks, recordings, and user interactions within a music production environment.

## Schema Overview

The database consists of the following tables:

- **User**: Stores user information including usernames, names, emails, dates of birth, and genders.
  
- **Subscription**: Contains details about subscription plans and intervals.
  
- **Workspace**: Manages workspaces, owners, subscription IDs, creation, and deletion dates.
  
- **Invoice**: Stores invoice information related to workspaces, including status, payment methods, amount, and currency.
  
- **User_Workspace_Mapping**: Manages the association between users and workspaces, including join/leave dates, status, and roles.
  
- **Project**: Contains project details like names, status, creation, update, deletion dates, and associated workspace IDs.
  
- **Album**: Stores album information including names, cover photos, publication statuses, and relevant dates.
  
- **Track**: Manages track details, including names, associated project and album IDs, cover photo URLs, publication statuses, and relevant dates.
  
- **Album_User_Mapping**: Establishes connections between albums and users.
  
- **Recording**: Stores recording information like names, status, URLs, associated project IDs, start/end times, and volume.
  
- **Effect**: Contains details about different effects available for use.
  
- **Recording_Effect_Mapping**: Manages the relationship between recordings and effects.

## Files Included:
- **Creation of DB SQL File**: Creating the Database

- **Use Cases SQL File**: Demonstrates various SQL operations, functions, and triggers showcasing the system's functionalities.
  
- **ERD (Entity-Relationship Diagram) File**: Visualizes entity relationships and the database structure.
  
- **Relational Diagram File**: Represents the relationships between different tables in a visual format.
  
- **3NF Decomposition File**: Demonstrates the schema's third normal form decomposition.
