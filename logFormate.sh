
# Problem Description:

# Scenario
# You are developing a billing audit script for a cloud environment. For every operation, the script must generate a specific "Audit Line" that captures the Timestamp, the User, the Server, and the Transaction Fee.

# The challenge is that the billing dashboard parses this line strictly. It requires:

# Dynamic values (Time, User, Server) to be expanded.
# The currency symbol ($) to be treated as literal text, NOT a variable.
# A previous attempt failed because the $ in the fee was interpreted as an empty variable, causing the cost to appear as 0.00 instead of $0.05.

# Task
# Create a script named audit_logger.sh in /home/user/.

# 1. Variable Definitions
# Define the following variables at the start of your script:

# SERVER_NAME: Set this to the string prod-db-01.
# TRANSACTION_FEE: Set this to the literal string $0.05. (Ensure the $ is safely stored as text).
# 2. Log Construction
# You must construct a single variable named AUDIT_ENTRY that combines all data into the following format:

# [<Timestamp>] User: <System_User> | Server: <Server_Name> | Fee: <Transaction_Fee>
# Requirements for AUDIT_ENTRY:

# <Timestamp>: Must be dynamically generated using the date command (Command Substitution).
# <System_User>: Must use the environment variable $USER.
# <Server_Name>: Must expand your SERVER_NAME variable.
# <Transaction_Fee>: Must include the literal $ symbol from your TRANSACTION_FEE variable.
# 3. Output
# Print the final AUDIT_ENTRY variable to the terminal.

# Expected Outcome
# When executed, the output should look similar to:

# [Tue Oct 24 10:00:00 UTC 2023] User: student | Server: prod-db-01 | Fee: $0.05
# (Note: The date and user will match your current system).




#!/bin/bash
SERVER_NAME="prod-db-01"
TRANSACTION_FEE="\$0.05"
timestamp="$(date)" 
SystemUser="$USER" 
AUDIT_ENTRY="[$timestamp] User: $SystemUser | Server: $SERVER_NAME | Fee: $TRANSACTION_FEE"
echo "$AUDIT_ENTRY" 