-- ============================================================
-- 01_create_database.sql
-- Crea la base de datos del sistema de franquicias
-- Idempotente: no falla si ya existe
-- ============================================================

CREATE DATABASE IF NOT EXISTS franchisedb
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE franchisedb;
