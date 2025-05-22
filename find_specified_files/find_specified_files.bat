@echo off
REM ### Find Specified Files ###
REM Usage: Copy and change the blocks 
REM Note: About extention of the files, there are 4 points to be changed including REM for each block.

REM dir
del target_files.txt
echo %~p0*\ > target_files.txt
echo date	size	file> dir.tsv
py find_specified_files.py -dir-only target_files.txt >> dir.tsv

REM mypy_cache
del target_files.txt
echo %~p0*\*mypy_cache > target_files.txt
echo date	size	file> mypy_cache.tsv
py find_specified_files.py -dir-only target_files.txt >> mypy_cache.tsv

REM .json
del target_files.txt
echo %~p0\*.json > target_files.txt
echo date	size	file> json.tsv
py find_specified_files.py target_files.txt >> json.tsv

REM .md
echo %~p0\*.md > target_files.txt
echo date	size	file> md.tsv
py find_specified_files.py target_files.txt >> md.tsv

REM .py
echo %~p0\*.py > target_files.txt
echo date	size	file> py.tsv
py find_specified_files.py target_files.txt >> py.tsv

REM .bat
echo %~p0\*.bat > target_files.txt
echo date	size	file> bat.tsv
py find_specified_files.py target_files.txt >> bat.tsv

REM .xlsx
echo %~p0\*.xlsx > target_files.txt
echo date	size	file> xlsx.tsv
py find_specified_files.py target_files.txt >> xlsx.tsv

REM .xlsm
echo %~p0\*.xlsm > target_files.txt
echo date	size	file> xlsm.tsv
py find_specified_files.py target_files.txt >> xlsm.tsv

REM .tla
echo %~p0\*.tla > target_files.txt
echo date	size	file> tla.tsv
py find_specified_files.py target_files.txt >> tla.tsv

REM .pdf
echo %~p0\*.pdf > target_files.txt
echo date	size	file> pdf.tsv
py find_specified_files.py target_files.txt >> pdf.tsv

REM .jar
echo %~p0\*.jar > target_files.txt
echo date	size	file> jar.tsv
py find_specified_files.py target_files.txt >> jar.tsv

REM sismic
echo %~p0\*sismic* > target_files.txt
echo date	size	file> sismic.tsv
py find_specified_files.py target_files.txt >> sismic.tsv

REM states
echo %~p0\*\states\ > target_files.txt
echo date	size	file> states.tsv
py find_specified_files.py target_files.txt >> states.tsv


del target_files.txt

