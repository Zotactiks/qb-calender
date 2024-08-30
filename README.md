# `qb-calendar`

## Description

`qb-calendar` is a versatile and interactive calendar system built for QB-Core based FiveM servers. Developed by Zotactiks, this script allows players to manage personal events and reminders through an intuitive user interface. Server admins can add global events that are visible to all players, making it a powerful tool for community-wide announcements and scheduling.

### Features
- **Interactive User Interface**: Easily add, view, and manage events within the game.
- **Admin Global Events**: Admins can create events that are visible to all players, ideal for server-wide announcements.
- **Persistent Data**: Events are saved to a MySQL database, ensuring they persist across server restarts.
- **Dynamic Monthly Images**: Displays different images for each month to enhance the visual experience.
- **In-Game Notifications**: Players receive notifications when events are added, improving communication.

## Installation

### Prerequisites
- **QB-Core Framework**: Ensure your server is running the QB-Core framework.
- **MySQL**: `ghmattimysql` or `oxmysql` should be configured for database operations.

### Steps

1. **Clone or Download** the repository and place the `qb-calendar` folder into your server's `resources` directory.
   
2. **Add the resource** to your `server.cfg`:
   ```bash
   ensure qb-calendar
   ```

3. **Database Setup**:
   - Run the following SQL query to create the `calendar_events` table:
     ```sql
     CREATE TABLE IF NOT EXISTS `calendar_events` (
         `id` INT AUTO_INCREMENT PRIMARY KEY,
         `citizenid` VARCHAR(50) NOT NULL,
         `date` DATE NOT NULL,
         `title` VARCHAR(255) NOT NULL,
         `is_global` TINYINT(1) NOT NULL DEFAULT 0
     );
     ```

4. **Configure Images**:
   - Place your monthly images in the `html/images/` directory. The images should be named according to the months, e.g., `january.jpg`, `february.jpg`, etc.

5. **Restart your server** or use the command `/restart qb-calendar` to load the script.

## Usage

### Commands
- **/opencalendar**: Opens the calendar interface for players.
  
### Admin Functions
- Admins can create global events by checking the "Make Global Event" checkbox when adding a new event in the calendar.

## Contributions

Contributions to improve or extend `qb-calendar` are welcome! Feel free to fork this repository and submit pull requests with your enhancements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Developed by Zotactiks. Enjoy using `qb-calendar` to enhance your server's roleplay experience!
