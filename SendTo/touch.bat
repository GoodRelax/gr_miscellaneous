REM copy %1 +
REM copy %2 +
REM copy %3 +
REM copy %4 +
REM copy %5 +


@echo off
setlocal enabledelayedexpansion

for %%A in (%*) do (
    copy %%A +
)
