CREATE TABLE IF NOT EXISTS `calendar_events` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `citizenid` VARCHAR(50) NOT NULL,
    `date` DATE NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `is_global` TINYINT(1) NOT NULL DEFAULT 0
);
