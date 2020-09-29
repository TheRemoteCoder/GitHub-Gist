# ---------------------------------------------------------------------------------------------------------------------------------- General

# Recursively search through all folders and file contents.
# Note: It also searches in binary files. Change the command or limit it to code folders.
grep -lir 'example' .

# Limit search to PHP files only.
grep --include '*.php' -lir 'example' .


# Use regular expressions instead of substrings and placeholders.
grep -E

# Inverse search: Only show what you did NOT search for.
grep -vE

# Show line number of result.
grep -n


# ------------------------------------------------------------------------------------------------------------------------------ Server logs

# Search through all Magento server logs with focus on visited frontend pages.
# Exclude: Images, CSS, JS, XML (RSS); Admin panel calls

# .../magento/logs
grep -nvE '(\.jpg|\.gif|\.png|\.css|\.ico|\.js|/admin/|/rss/catalog)' access.log > result.log


# Search for certain dates and save the whole line in a new file.
grep '01/Jan' access.log > result.log


# Show all lines except those with specificied file extensions (exemplaric data here).
# The filtered result will mostly contain HTML and JS calls.
grep -nvE '(\.jpg|\.css)' access.log > result.log
