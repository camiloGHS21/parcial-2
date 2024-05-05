import pandas as pd
import re
csv = input("direcccion de csv :\n")
datos = pd.read_csv(csv, sep="|")



datos.columns = datos.columns.str.replace("|", "_")
name_table = csv.split(".", 1)
sql_insert = f"CREATE TABLE {name_table[0]}(\n"
sql_insert += f"{name_table[0]}_id NUMBER PRIMARY KEY ,\n"

for i in datos.columns:
    tipo  = input("cual es el tipo del dato "+i+" : \n")
    sql_insert = sql_insert + i +" "+tipo+" NOT NULL,\n"
    if re.search(r'\w+_id$', i) and i != f'{name_table[0]}_id':
        sql_insert = sql_insert + f"FOREIGN KEY ({i}) REFERENCES {i[0:-3]}({i}),\n"
    

sql_insert = sql_insert[0:-2]

sql_insert = sql_insert + "\n);"

# Crear el archivo SQL 
with open(f"{name_table[0]}.sql", "w", encoding="UTF-8") as f:
    f.write(sql_insert)
    
insert =""

# Iterar sobre cada fila del DataFrame
for index, row in datos.iterrows():
    insert +=  f"INSERT INTO {name_table[0]} ("
    insert += f"{name_table[0]}_id, "
    for column in datos.columns:
        # Reemplazar espacios y barras inclinadas con guiones bajos en los nombres de las columnas
        column_name = column.replace(" ", "_").replace("/", "_").replace("(", "_").replace(")", "_").replace(":", "_")
        insert += column_name + ", "
    insert = insert[:-2]  # Eliminar la coma y el espacio extra al final
    insert += ") VALUES ("
    insert += str(index+1)+", "
    # Iterar sobre cada columna de la fila actual
    for column in datos.columns:
        # Verificar si el valor es un número
        if pd.api.types.is_numeric_dtype(datos[column]):
            # Si el valor termina con ".0", lo tratamos como un entero
            if str(row[column]).endswith("0"):
                insert += str(int(row[column])) + ", "
            else:
                insert += str(row[column]) + ", "  # Si no termina con ".0", lo dejamos tal como está
        elif re.match(r'^\d{4}-\d{1,2}-\d{1,2}', str(row[column])):
            # Si la columna coincide con el formato '1960-A-B', la formateamos como TO_DATE
            fecha = str(row[column])
            insert += f"TO_DATE('{fecha}', 'YYYY-MM-DD'), "
        else:
            insert += "'" + str(row[column]) + "', "

    insert = insert[:-2]  # Eliminar la coma y el espacio extra al final
    insert += ");\n"

insert = insert[:-2]  # Eliminar la coma y el espacio extra al final
insert += ";\n"
with open(f"{name_table[0]}_insert.sql", "w", encoding="UTF-8") as f:
    f.write(insert)