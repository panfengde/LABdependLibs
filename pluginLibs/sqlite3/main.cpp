#include <iostream>
#include "sqlite3.h"


//    Abort on failure of creating or opening a database;
//    True if created a new database file
//    False if it reuses
int sqlq_has_to_be_init(const char* path, sqlite3** db)
{
    if (sqlite3_open_v2(path, db, SQLITE_OPEN_READWRITE, NULL))
    {
        if (sqlite3_open_v2(path, db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL))
        {
            fprintf(stderr, "%s:%d Can't open database: %s\n", __FILE__, __LINE__, sqlite3_errmsg(*db));
            sqlite3_close_v2(*db);
            exit(EXIT_FAILURE);
            //can't use the sqlite3* db object anymore, needs to be cleared in some way
            //can't bother for now
        }
        else
        {
            return 1;
        }
    }
    return 0;
}

int main(void)
{
    sqlite3 *db;
    char *err_msg = 0;

    //int rc = sqlite3_open(":memory:", &db);
    int rc = sqlite3_open("expenses.db", &db);

    if (rc != SQLITE_OK) {

        fprintf(stderr, "Cannot open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);

        return 1;
    }

    char *sql = "CREATE TABLE Friends(Id INTEGER PRIMARY KEY, Name TEXT);"
    "INSERT INTO Friends(Name) VALUES ('Tom');"
    "INSERT INTO Friends(Name) VALUES ('Rebecca');"
    "INSERT INTO Friends(Name) VALUES ('Jim');"
    "INSERT INTO Friends(Name) VALUES ('Roger');"
    "INSERT INTO Friends(Name) VALUES ('Robert');";

    rc = sqlite3_exec(db, sql, 0, 0, &err_msg);

    if (rc != SQLITE_OK ) {

        fprintf(stderr, "Failed to create table\n");
        fprintf(stderr, "SQL error: %s\n", err_msg);
        sqlite3_free(err_msg);

    } else {
        fprintf(stdout, "Table Friends created successfully\n");
    }

    int last_id = sqlite3_last_insert_rowid(db);
    printf("The last Id of the inserted row is %d\n", last_id);

    sqlite3_close(db);
    return 0;
}
