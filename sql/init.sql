DROP DATABASE IF EXISTS nursing_home_db;
CREATE DATABASE nursing_home_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE nursing_home_db;

CREATE TABLE sys_user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    real_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT '正常',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE bed_info (
    id INT PRIMARY KEY AUTO_INCREMENT,
    room_no VARCHAR(20) NOT NULL,
    bed_no VARCHAR(20) NOT NULL,
    bed_type VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT '空闲',
    remark VARCHAR(255),
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE elderly_profile (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    age INT NOT NULL,
    phone VARCHAR(20),
    family_contact VARCHAR(50),
    family_phone VARCHAR(20),
    health_condition VARCHAR(255),
    checkin_date DATE,
    bed_id INT,
    status VARCHAR(20) NOT NULL DEFAULT '已入住',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_elderly_bed FOREIGN KEY (bed_id) REFERENCES bed_info(id)
);

CREATE TABLE checkin_apply (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    elderly_name VARCHAR(50) NOT NULL,
    elderly_age INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    contact_phone VARCHAR(20) NOT NULL,
    health_desc VARCHAR(255),
    apply_reason VARCHAR(255),
    audit_status VARCHAR(20) NOT NULL DEFAULT '待审核',
    audit_remark VARCHAR(255),
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_apply_user FOREIGN KEY (user_id) REFERENCES sys_user(id)
);

CREATE TABLE care_record (
    id INT PRIMARY KEY AUTO_INCREMENT,
    elderly_id INT NOT NULL,
    staff_id INT NOT NULL,
    care_content VARCHAR(255) NOT NULL,
    body_condition VARCHAR(255),
    care_time DATETIME NOT NULL,
    remark VARCHAR(255),
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_care_elderly FOREIGN KEY (elderly_id) REFERENCES elderly_profile(id),
    CONSTRAINT fk_care_staff FOREIGN KEY (staff_id) REFERENCES sys_user(id)
);

CREATE TABLE notice (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    publish_time DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT '已发布',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO sys_user (username, password, real_name, phone, role, status) VALUES
('admin', '123456', '系统管理员', '13800000001', 'ADMIN', '正常'),
('staff', '123456', '护理工作人员', '13800000002', 'STAFF', '正常'),
('user', '123456', '普通用户', '13800000003', 'USER', '正常'),
('user02', '123456', '王丽华', '13800000004', 'USER', '正常');

INSERT INTO bed_info (room_no, bed_no, bed_type, status, remark) VALUES
('101', 'A床', '双人护理床', '已入住', '靠近护理站，便于日常观察'),
('101', 'B床', '双人护理床', '已入住', '采光较好，适合长期居住'),
('102', 'A床', '双人护理床', '已入住', '靠近公共活动区域'),
('102', 'B床', '双人护理床', '空闲', '便于家属探访'),
('201', 'A床', '单人护理床', '已入住', '环境安静，适合休养'),
('201', 'B床', '单人护理床', '空闲', '朝南房间，通风较好'),
('202', 'A床', '双人护理床', '维修中', '床体护栏维护中，暂不安排入住'),
('202', 'B床', '双人护理床', '空闲', '适合需要陪护的老人'),
('301', 'A床', '单人护理床', '已入住', '靠窗位置，采光明亮'),
('301', 'B床', '单人护理床', '空闲', '临近值班室，照护便利'),
('302', 'A床', '双人护理床', '空闲', '房间宽敞，出入方便'),
('302', 'B床', '双人护理床', '维修中', '床位地面正在保养，暂停使用');

INSERT INTO elderly_profile
(name, gender, age, phone, family_contact, family_phone, health_condition, checkin_date, bed_id, status)
VALUES
('王建国', '男', 78, '13910010001', '王丽', '13720020001', '血压偏高，需定期测量', '2025-11-15', 1, '已入住'),
('李桂兰', '女', 81, '13910010002', '李强', '13720020002', '行动稍有不便，需要日常搀扶', '2025-12-03', 2, '已入住'),
('张德明', '男', 76, '13910010003', '张敏', '13720020003', '身体状况稳定，需按时服药', '2026-01-10', 3, '已入住'),
('刘秀英', '女', 84, '13910010004', '刘伟', '13720020004', '睡眠质量一般，需关注夜间休息', '2026-02-08', 5, '已入住'),
('赵国强', '男', 79, '13910010005', '赵楠', '13720020005', '膝关节不适，活动时需适当协助', '2026-02-26', 9, '已入住'),
('陈淑芳', '女', 75, '13910010006', '陈静', '13720020006', '食欲较好，日常生活基本可自理', '2026-03-16', 11, '已入住');

INSERT INTO checkin_apply
(user_id, elderly_name, elderly_age, gender, contact_phone, health_desc, apply_reason, audit_status, audit_remark, create_time, update_time)
VALUES
(3, '孙玉梅', 82, '女', '13630030001', '老人日常行动较慢，需要协助起居与按时服药。', '希望为老人申请长期入住服务，便于获得稳定照护。', '待审核', '', '2026-04-20 09:15:00', '2026-04-20 09:15:00'),
(3, '周明', 74, '男', '13630030002', '身体状况稳定，但夜间休息质量一般，需要持续关注。', '老人日常生活需要一定协助，家属希望入住养老院统一照护。', '已通过', '资料完整，同意安排入住。', '2026-04-18 10:20:00', '2026-04-19 14:30:00'),
(3, '黄淑珍', 80, '女', '13630030003', '患有高血压，需每天监测血压并提醒按时服药。', '家属工作繁忙，希望为老人申请入住并接受规律护理。', '已拒绝', '联系方式不完整，请补充家属联系电话后重新提交。', '2026-04-15 11:10:00', '2026-04-16 16:45:00'),
(4, '吴德华', 77, '男', '13630030004', '行动较慢，需协助上下楼和日常活动。', '希望老人能够在统一管理环境中获得更稳定的生活照护。', '待审核', '', '2026-04-21 08:40:00', '2026-04-21 08:40:00'),
(4, '何秀兰', 79, '女', '13630030005', '身体情况总体平稳，需关注饮食营养与睡眠。', '家属希望老人入住后享受更规律的照护与作息安排。', '已通过', '符合入住条件，可由工作人员登记安排床位。', '2026-04-12 13:25:00', '2026-04-13 09:50:00');

INSERT INTO care_record
(elderly_id, staff_id, care_content, body_condition, care_time, remark)
VALUES
(1, 2, '协助老人完成晨间洗漱并整理床铺', '精神状态良好，血压略高，已提醒多休息。', '2026-04-22 08:10:00', '已向家属说明近期血压波动情况。'),
(2, 2, '提醒老人按时服药并观察精神状态', '行动较慢，需搀扶，服药后状态平稳。', '2026-04-22 09:30:00', '午间继续关注老人行走情况。'),
(3, 2, '陪同老人进行室内慢走活动', '身体情况稳定，无明显不适，心情较好。', '2026-04-22 15:00:00', '建议继续保持适量活动。'),
(4, 2, '测量血压并记录身体情况', '睡眠一般，上午精神状态尚可，血压处于正常范围。', '2026-04-23 08:45:00', '已建议晚间减少饮茶。'),
(5, 2, '协助老人整理房间并进行午间巡视', '膝关节不适，行走时需陪同，无其他明显不适。', '2026-04-23 13:40:00', '下午安排适度休息。'),
(6, 2, '提醒老人按时用餐并观察食欲情况', '食欲正常，精神状态平稳，能够配合护理安排。', '2026-04-24 11:20:00', '继续保持清淡饮食。');

INSERT INTO notice (title, content, publish_time, status) VALUES
('关于春季健康护理注意事项的通知', '近期气温变化较大，请家属提醒老人根据天气及时增减衣物，护理人员也将持续加强晨晚巡视。', '2026-04-10 09:00:00', '已发布'),
('养老院日常探访时间安排', '家属探访时间为工作日 09:00 至 17:00。为保证老人休息，请提前与工作人员沟通具体探访安排。', '2026-04-12 10:00:00', '已发布'),
('院内环境卫生维护公告', '为营造整洁舒适的居住环境，院内将于每周三上午开展公共区域卫生维护，请家属予以理解配合。', '2026-04-15 08:30:00', '已发布'),
('老年人饮食营养提示', '建议老人保持清淡均衡饮食，适量补充优质蛋白和新鲜蔬果，并按护理建议规律进餐。', '2026-04-18 14:00:00', '已发布'),
('夜间休息与安全巡查提醒', '工作人员将继续加强夜间巡查，提醒老人按时休息，减少夜间单独活动，保障居住安全。', '2026-04-21 19:00:00', '已发布');
