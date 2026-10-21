@echo off
echo ===================================================
echo Running ReviewIQ AI Automated Test Suite...
echo ===================================================
cd backend
python -m pytest tests -v
pause
