import java.util.Properties
import java.io.FileInputStream

import groovy.sql.Sql

props = new Properties()

props.load(new FileInputStream("TestSQL.properties"));

print props['database.url']

databaseUrl      = props['database.url']
databaseDriver   = props['database.driver']
databaseUser     = props['database.user']
databasePassword = props['database.password']

sql = Sql.newInstance(databaseUrl, databaseUser, databasePassword, databaseDriver)

sql.eachRow('select * from tab') {
  println it.name
}
