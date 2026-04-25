-- ============================================================
-- 01_create_tables.sql
-- Crea todas las tablas del sistema de franquicias
-- Idempotente: usa CREATE TABLE IF NOT EXISTS
-- IDs de tipo UUID (CHAR(36))
-- ============================================================

USE franchise_db;

-- ------------------------------------------------------------
-- Franquicia
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Franquicia (
    IdFranquicia     CHAR(36)     NOT NULL DEFAULT (UUID()),
    Nombre           VARCHAR(150) NOT NULL,
    FechaCreacion    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaActualizacion DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP
                                           ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_franquicia PRIMARY KEY (IdFranquicia)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Sucursal
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Sucursal (
    IdSucursal       CHAR(36)     NOT NULL DEFAULT (UUID()),
    Nombre           VARCHAR(150) NOT NULL,
    FechaCreacion    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaActualizacion DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP
                                           ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_sucursal PRIMARY KEY (IdSucursal)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Afiliacion  (tabla relacion Franquicia <-> Sucursal)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Afiliacion (
    IdSucursal       CHAR(36)  NOT NULL,
    IdFranquicia     CHAR(36)  NOT NULL,
    FechaCreacion    DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaActualizacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
                                         ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_afiliacion        PRIMARY KEY (IdSucursal, IdFranquicia),
    CONSTRAINT fk_afil_sucursal     FOREIGN KEY (IdSucursal)
        REFERENCES Sucursal (IdSucursal)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_afil_franquicia   FOREIGN KEY (IdFranquicia)
        REFERENCES Franquicia (IdFranquicia)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- EstadoPago  (catalogo)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EstadoPago (
    IdEstado  CHAR(36)     NOT NULL DEFAULT (UUID()),
    Nombre    VARCHAR(80)  NOT NULL,
    CONSTRAINT pk_estadopago PRIMARY KEY (IdEstado)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Producto
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Producto (
    IdProducto       CHAR(36)     NOT NULL DEFAULT (UUID()),
    Nombre           VARCHAR(150) NOT NULL,
    Activo           TINYINT(1)   NOT NULL DEFAULT 1,
    FechaCreacion    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaActualizacion DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP
                                           ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_producto PRIMARY KEY (IdProducto)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Inventario  (tabla relacion Sucursal <-> Producto)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Inventario (
    IdSucursal       CHAR(36)  NOT NULL,
    IdProducto       CHAR(36)  NOT NULL,
    CantidadStock    INT       NOT NULL DEFAULT 0,
    IdEstadoPago     CHAR(36)  NOT NULL,
    FechaCreacion    DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaActualizacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
                                         ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_inventario        PRIMARY KEY (IdSucursal, IdProducto),
    CONSTRAINT fk_inv_sucursal      FOREIGN KEY (IdSucursal)
        REFERENCES Sucursal (IdSucursal)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_inv_producto      FOREIGN KEY (IdProducto)
        REFERENCES Producto (IdProducto)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_inv_estadopago    FOREIGN KEY (IdEstadoPago)
        REFERENCES EstadoPago (IdEstado)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;
