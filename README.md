# franchise-schema-database

Repositorio con los scripts SQL para la creación y gestión de la base de datos del sistema de franquicias.

## Estructura del repositorio

```
franchise-schema-database/
├── 01_CreateDatabase/
│   └── 01_create_database.sql   # Crea la base de datos franchise_db
├── 02_CreateTable/
│   └── 01_create_tables.sql     # Crea todas las tablas y relaciones
└── 03_ScriptCargas/             # Scripts de carga de datos iniciales
```

## Modelo de datos

### Tablas catálogo

| Tabla | Descripción |
|---|---|
| `Franquicia` | Registro de franquicias del sistema |
| `Sucursal` | Sucursales asociadas a las franquicias |
| `Producto` | Catálogo de productos disponibles |
| `EstadoPago` | Estados posibles de pago en inventario |

### Tablas de relación

| Tabla | Relación | Descripción |
|---|---|---|
| `Afiliacion` | Franquicia ↔ Sucursal | Vincula sucursales con franquicias |
| `Inventario` | Sucursal ↔ Producto | Stock de productos por sucursal |

## Convenciones

- **Idempotencia**: todos los scripts usan `CREATE DATABASE/TABLE IF NOT EXISTS`, por lo que pueden ejecutarse múltiples veces sin error.
- **Identificadores**: tipo `CHAR(36)` con valor por defecto `UUID()`, generado automáticamente por el motor.
- **Timestamps**: `FechaCreacion` se establece al insertar; `FechaActualizacion` se actualiza automáticamente con `ON UPDATE CURRENT_TIMESTAMP`.
- **Integridad referencial**: todas las claves foráneas usan `ON DELETE RESTRICT / ON UPDATE CASCADE`.
- **Motor**: `InnoDB` en todas las tablas para soporte de transacciones y FK.

## Orden de ejecución

Ejecutar los scripts en el siguiente orden:

```bash
# 1. Crear la base de datos
mysql -u <usuario> -p < 01_CreateDatabase/01_create_database.sql

# 2. Crear tablas y relaciones
mysql -u <usuario> -p franchise_db < 02_CreateTable/01_create_tables.sql
```

## Requisitos

- MySQL 8.0 o superior (requerido para `DEFAULT (UUID())` en columnas).
