#!/bin/bash
set -e

cd "$(dirname "$0")"

echo "🚀 Building recovery practice environment..."
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if src/ directory already exists
if [ -d "src" ]; then
    echo -e "${YELLOW}⚠️  Warning: Practice environment already exists${NC}"
    read -p "Delete and rebuild? This will reset all practice work. (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborting. Run script again when ready to reset."
        exit 1
    fi
    
    echo -e "${BLUE}🧹 Cleaning up existing practice environment...${NC}"
    git reset --hard origin/master 2>/dev/null || git reset --hard HEAD~10 2>/dev/null || true
    git branch | grep -v "^\*" | grep -v "master" | grep -v "main" | xargs -r git branch -D 2>/dev/null || true
    rm -rf src/
    echo -e "${GREEN}✅ Cleanup complete${NC}"
    echo ""
fi

echo -e "${BLUE}📁 Creating project structure...${NC}"
mkdir -p src tests docs

# Data recovery scenario - Photo management app
export GIT_AUTHOR_NAME="Sam Taylor"
export GIT_AUTHOR_EMAIL="sam@photos.com"
export GIT_COMMITTER_NAME="Sam Taylor"
export GIT_COMMITTER_EMAIL="sam@photos.com"

# Create a series of commits building a photo app
for i in {1..40}; do
    export GIT_AUTHOR_DATE="2024-01-$(printf "%02d" $((i/2+1)))T$(printf "%02d" $((i%24))):00:00"
    export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
    
    case $i in
        1)
            cat > src/photo.js << 'EOF'
class PhotoManager {
    constructor() {
        this.photos = [];
    }
}
module.exports = PhotoManager;
EOF
            git add src/photo.js
            git commit -m "Initialize photo manager"
            ;;
        2)
            cat >> src/photo.js << 'EOF'

    addPhoto(photo) {
        this.photos.push(photo);
    }
};
module.exports = PhotoManager;
EOF
            git add src/photo.js
            git commit -m "Add photo upload"
            ;;
        3)
            cat > src/gallery.js << 'EOF'
class Gallery {
    render(photos) {
        return photos.map(p => '<div>' + p.title + '</div>').join('');
    }
}
module.exports = Gallery;
EOF
            git add src/gallery.js
            git commit -m "Add gallery view"
            ;;
        4|5|6|7|8)
            echo "// Feature $i" >> src/photo.js
            git add src/photo.js
            git commit -m "Add feature $i to photo manager"
            ;;
        9)
            cat > src/filters.js << 'EOF'
class PhotoFilters {
    applyFilter(photo, filter) {
        return { ...photo, filter };
    }
}
module.exports = PhotoFilters;
EOF
            git add src/filters.js
            git commit -m "Add photo filters"
            ;;
        10|11|12|13|14|15)
            echo "// Update $i" >> src/filters.js
            git add src/filters.js
            git commit -m "Enhance filters ($i)"
            ;;
        16)
            cat > src/albums.js << 'EOF'
class AlbumManager {
    constructor() {
        this.albums = [];
    }
    createAlbum(name) {
        this.albums.push({ name, photos: [] });
    }
}
module.exports = AlbumManager;
EOF
            git add src/albums.js
            git commit -m "Add album management"
            ;;
        17|18|19|20|21|22)
            echo "// Improvement $i" >> src/albums.js
            git add src/albums.js
            git commit -m "Album feature $i"
            ;;
        23)
            cat > src/sharing.js << 'EOF'
class SharingManager {
    shareAlbum(albumId, users) {
        return { shared: true };
    }
}
module.exports = SharingManager;
EOF
            git add src/sharing.js
            git commit -m "Add sharing functionality"
            ;;
        24|25|26|27|28)
            echo "// Enhancement $i" >> src/sharing.js
            git add src/sharing.js
            git commit -m "Sharing update $i"
            ;;
        29)
            cat > src/comments.js << 'EOF'
class CommentSystem {
    addComment(photoId, text) {
        return { photoId, text, timestamp: Date.now() };
    }
}
module.exports = CommentSystem;
EOF
            git add src/comments.js
            git commit -m "Add comment system"
            ;;
        30|31|32|33|34)
            echo "// Feature $i" >> src/comments.js
            git add src/comments.js
            git commit -m "Comment feature $i"
            ;;
        35)
            cat > tests/photo.test.js << 'EOF'
const PhotoManager = require('../src/photo');
describe('Photo Tests', () => {
    it('should work', () => {});
});
EOF
            git add tests/photo.test.js
            git commit -m "Add tests"
            ;;
        36|37|38)
            echo "// Test $i" >> tests/photo.test.js
            git add tests/photo.test.js
            git commit -m "Add test case $i"
            ;;
        39)
            cat > docs/README.md << 'EOF'
# Photo Manager

A comprehensive photo management application.

## Features
- Photo upload
- Albums
- Filters
- Sharing
- Comments
EOF
            git add docs/README.md
            git commit -m "Add documentation"
            ;;
        40)
            cat > package.json << 'EOF'
{
  "name": "photo-manager",
  "version": "1.0.0",
  "description": "Photo management app"
}
EOF
            git add package.json
            git commit -m "Add package.json"
            ;;
    esac
done

echo ""
echo -e "${GREEN}✅ Setup complete!${NC}"
echo ""
echo -e "${BLUE}📊 Created 40 commits ready for recovery practice${NC}"
echo ""
echo "Next steps:"
echo "  1. Verify: git log --oneline"
echo "  2. Start exercises: open EXERCISES.md"
echo ""
echo "To reset and start over, just run ./build-history.sh again"
