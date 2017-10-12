import MySQLdb
import ConfigParser
import os
import time


FIELD_TYPE = {}
cur_table = None
# cur_dbobj = None
connection_retry_counter = 1


class ConnectDB:
    def __init__(self):
        self.cur_table = None
        config = ConfigParser.ConfigParser()
        current_dir = '\\'.join(os.path.realpath(__file__).split('\\')[:-1])
        config.read(os.path.join(current_dir, "config.cfg"))
        # config.read(os.path.join(os.getcwd(), 'config.cfg'))
        self.dbUser = config.get('Database', 'username')
        self.dbPass = config.get('Database', 'password') if config.get('Database', 'password') else os.getenv("DB_PSW")
        self.dbConnectAttempt = config.get('Database', 'connect_attempt')
        self.dbHost = config.get('Database', 'host')
        self.dbDB = config.get('Database', 'db_name')
        # self.cursor = self.connect(self.dbHost, self.dbUser, self.dbPass, self.dbDB, self.dbConnectAttempt)

        for attempt in range(eval(self.dbConnectAttempt)):
            # print 'connection attempts: ', attempt
            try:
                # import pdb; pdb.set_trace()
                self.conn = MySQLdb.connect(self.dbHost, self.dbUser, self.dbPass, self.dbDB)
                self.cursor = self.conn.cursor()
            except MySQLdb.Error, e:
                print "MySQL Error %d: %s", e.args[0], e.args[1]
                self.conn.rollback()
                # time.sleep(5)
                # self.connect(self.dbHost, self.dbUser, self.dbPass, self.dbDB, self.dbConnectAttempt)
            finally:
                if self.conn:
                    break
        # return cursor

    # def connect(self, dbHost, dbUser, dbPass, dbDB, dbConnectAttempt):
    #     for attempt in range(eval(dbConnectAttempt)):
    #         # print 'connection attempts: ', attempt
    #         try:
    #             self.conn = MySQLdb.connect(dbHost, dbUser, dbPass, dbDB)
    #             cursor = self.conn.cursor()
    #         except MySQLdb.Error, e:
    #             print "MySQL Error %d: %s", e.args[0], e.args[1]
    #             self.conn.rollback()
    #             time.sleep(5)
    #             self.connect(self.dbHost, self.dbUser, self.dbPass, self.dbDB, self.dbConnectAttempt)
    #         finally:
    #             if self.conn:
    #                 break
    #     return cursor

# New SELECT FUNC --authored by Sid
    def NewSelect(self, table, dictionary=None):
        try:
            fetch_mult = True
            query = ""
            if dictionary == None and fetch_mult == True:
                query = "SELECT * FROM %s;" % table

            # WHERE clause
            if dictionary:
                # if len(dictionary) == 1:
                where_exp = self.prepWhereDict(dictionary)
                query = "SELECT * FROM %s WHERE %s;" % (table, where_exp)
                # print query

            # print query
            self.cursor.execute(query)
            result = self.cursor.fetchall()
            return result
        except MySQLdb.Error:
            print MySQLdb.Error
            return 'error'

    # we check that there is a non-zero length dictionary
    def prepWhereDict(self, dictionary):
        if len(dictionary):
            where_exp = []
            for key in dictionary:
                where_exp.append("%s = '%s'" % (key, dictionary[key]))
            # print where_exp
            return " AND ".join(where_exp)

# -- Ends Select --

# New Update func --authored by Sid
    def NewUpdate(self, table, dictionary):
        try:
            set_part = []
            for key in dictionary:
                set_part.append("%s = '%s'" % (key, dictionary[key]))

            where_part = set_part[-1]
            set_part = set_part[:-1]
            query = "UPDATE %s " \
                    "SET" \
                    " %s " \
                    "WHERE %s;" % (table, ", ".join(set_part), where_part)
            # print query
            self.cursor.execute(query)
            self.conn.commit()
            result = self.cursor.fetchall()
            return result
        except MySQLdb.Error:
            print MySQLdb.Error
            return 'error'

# -- Ends Update --

# New Insert func --authored by Sid
    def NewInsert(self, table, dictionary):
        try:
            cols_part = []
            vals_part = []
            for key in dictionary:
                cols_part.append(key)
                vals_part.append("'%s'" % dictionary[key])
            query = "INSERT INTO %s (%s) VALUES (%s);" % (table, ", ".join(cols_part), ", ".join(vals_part))
            print query
            self.cursor.execute(query)
            self.conn.commit()
            result = self.cursor.fetchall()
            return result
        except MySQLdb.Error:
            print MySQLdb.Error
            return 'error'
# -- Ends Insert --