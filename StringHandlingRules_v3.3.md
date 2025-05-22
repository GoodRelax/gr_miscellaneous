# String Handling Rules for Python Code Generation

Copyright (c) 2025 GoodRelax
MIT License

## ✨ Purpose and Goal

To achieve **zero bugs**, **structural stability**, and **full automation** in Python code generation, we define the following practical and strict rules.

These rules are designed to:

- 🔒 Prevent string-related coding errors
- 🔄 Maintain consistent structure across all generated code
- 🧪 Enable simple mechanical checks for code correctness

---

## ✅ Strict Rules Must Be Followed When Generating Python Code.

### 1. Predefined Constants (MUST Copy and Paste)

Paste this block at the top of every script you write:

```Python
REVERSE_SOLIDUS = "\\"
LINE_FEED = "\n"
CARRIAGE_RETURN = "\r"
NEWLINE_CRLF = CARRIAGE_RETURN + LINE_FEED
EMPTY_LINE = ""
QUOTATION_MARK = '"'
APOSTROPHE = "'"
GRAVE_ACCENT = "`"
HORIZONTAL_TAB = "\t"
BACKSPACE = "\b"
FORM_FEED = "\f"
VERTICAL_TAB = "\v"
NULL_CHAR = "\0"
SPACE = " "
COMMA = ","
DEF_EQ = " =="
AND_SYM = "/" + REVERSE_SOLIDUS
OR_SYM = REVERSE_SOLIDUS + "/" # use as a set of AND_SYM and OR_SYM to keep symmetry code.
IN_SYM = REVERSE_SOLIDUS + "in"  #  \\in
UNION_SYM = REVERSE_SOLIDUS + "union"        # \\union
SUBSETEQ_SYM = REVERSE_SOLIDUS + "subseteq"  # \\subseteq
IMPLIES_SYM = REVERSE_SOLIDUS + "implies"    # \\implies
IFF_SYM = REVERSE_SOLIDUS + "iff"             # \\iff

```

### 2. Escape-Sensitive Strings Must Be Declared as Constants

- Any string containing **escape sequences** must be defined as a constant at the top.
- Escape sequences include: `\\`, `\"`, `\'`, <code>\`</code>, `\n`, `\r`, `\t`, `\b`, `\f`, `\v`, `\0`, `\r\n`, `\e`.

### 3. f-strings or r-strings

- `f"..."` and `r"..."` literals are prohibited except when no appropriate alternative method is available.
- All string concatenation must be done using constants and variables with the `+` operator.
- If large string literals are necessary, `r"..."` may be used.
  - Examples: regular expressions, template strings
- When using `r"..."`, the last character must not be `\`.
- If f-strings are the only viable solution, they may be used with caution.
- The following usages are prohibited in `f"..."` literals:
  - Empty f-string : `f""` or `f''`
  - Empty `{}` : `f"{ }"`
  - Starting with `}` : `f"}text"`
  - Unclosed `{` : `f"{value"`
  - Trailing `\` : `f"text\"`
  - Unescaped `\` : `f"\unknown"`

### 4. Direct String Literals

- Only pure English words like `"Idle"`, `"Running"`, `"StartProcess"` may be directly written.
- Escape-sensitive content or symbols must **always** be defined as constants.

### 5. String Construction

- Use predefined constants for every string construction that involves escape sequences.
- Do not write string literals that contain escape sequences directly in the logic.

Correct Example:

```Python
print(AND_SYM + " state = " + IDLE_STATE)
```

Incorrect Example:

```Python
print("state = /\\")  # ❌ Forbidden!
```

### 6. Empty Strings Must Also Be Declared as Constant

- Use `EMPTY_LINE` for empty strings instead of `""`.

### 7. Special Escape Sequences and Symbolic Strings

- Any combination of characters involving escape sequences (such as \\in, \\/, /\\) must also be defined as a constant.
- Do not split these symbolic sequences into separate constants or literals during string assembly.
- Treat the whole sequence as a single logical unit and define it once at the top of the script.

---

## 📊 Code Review Checklist

- [ ] After the constant definition block, are there any raw appearances of:
  - Double Quote `"`
  - Single Quote `'`
  - Grave Accent <code>`</code>
  - Backslash `\`
- [ ] Are there any f-strings `f"..."` or r-strings `r"..."` used?
- [ ] Are all escape-sensitive and symbolic strings defined as constants?
- [ ] Is every output string assembled only with constants, variables, and escape-free literals?
- [ ] Are direct literals limited only to pure English word labels?

**Check each line against this checklist immediately after generating it.**
**If any violation is found, correct it using predefined constants.**  
**Review the code from bottom to top, then top to bottom, and repeat until every line passes the checklist.**

---

## 📊 Mantra

**Recite this mantra for every single line of code you generate.**

> ⚡ "If there’s an escape, define a constant!"
> ⚡ "Allow only direct English words without escapes!"
> ⚡ "Assemble output using only constants, variables, and escape-free literals!"
> ⚡ "f-strings and raw strings are strictly prohibited."
