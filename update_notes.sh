# Add changes to git.
git add .

# Commit changes.
msg="update notes $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin main 
