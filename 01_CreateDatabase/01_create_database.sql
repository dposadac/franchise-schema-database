-- ============================================================
-- 01_create_database.sql
-- Crea la base de datos del sistema de franquicias
-- Idempotente: no falla si ya existe
-- ============================================================

CREATE DATABASE IF NOT EXISTS franchise_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE franchise_db;
