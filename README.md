# 🚀 Live Search & Analytics

A tiny Rails & vanilla‑JS app that tracks **completed**, real‑time searches and shows the top queries.
Whether you’re on **macOS**, **Linux**, or **Windows**, this guide will walk you through getting up and running—from cloning the repo to launching the backend, wiring up the frontend, and running tests.

---
&nbsp;
<br><br>

## 🎯 What This Does

1. **Instant search** of your (dummy) articles.
2. **Per‑user analytics**:
   - Records only _final_ queries (no “pyramid problem”).
   - Shows the top 10 most popular searches in real time.
3. **Scalable** and fully tested with RSpec & SimpleCov.

---
&nbsp;
<br><br>


## 📋 Prerequisites

| Component        | macOS (Homebrew)                                                    | Ubuntu / Debian                                   | Windows (RubyInstaller / WSL2)                         |
| ---------------- | ------------------------------------------------------------------- | ------------------------------------------------- | ------------------------------------------------------ |
| **Ruby 3.2+**    | `brew install ruby`                                                 | `sudo apt install ruby-full`                      | Download & install from [rubyinstaller.org](https://rubyinstaller.org) or use WSL2 |
| **Rails 7**      | `gem install rails`                                                 | `gem install rails`                               | `gem install rails`                                    |
| **PostgreSQL**   | `brew install postgresql && brew services start postgresql`         | `sudo apt install postgresql postgresql-contrib`  | Download from [postgresql.org](https://www.postgresql.org/download/windows/) |
| **Node.js & Yarn** | `brew install node yarn`                                          | `sudo apt install nodejs npm && npm install -g yarn` | Download Node.js (+ npm), then `npm install -g yarn`    |
| **cURL**         | preinstalled                                                        | `sudo apt install curl`                           | preinstalled                                           |

> **Tip:** On Windows you can also use **WSL2** to follow the Linux instructions almost exactly.

&nbsp;
<br><br>


## 🛠️ Installation & Setup

```bash
# 1. Clone repo
git clone https://github.com/kivuvarosekivuvan/helpjuice_search.git
cd helpjuice_search

# 2. Install Ruby gems
bundle install

# 3. Install JS deps
yarn install

# 4. Database setup
rails db:create
rails db:migrate
```
---
&nbsp;
<br><br>


## ▶️ Running the Backend

```
rails server
```
By default, the app listens on port 3000.

---
&nbsp;
<br><br>

## 🎨 Serving the Frontend
Static files live in public/:

 - Open public/index.html directly in your browser

 - Or from the project root:
 ```
 cd public
python3 -m http.server 8000
# → visit http://localhost:8000
```


---
&nbsp;
<br><br>

## ✅ Testing
### 1.**RSpec (backend)**
```
bundle exec rspec
# View coverage at coverage/index.html (SimpleCov)

```
### 2.**Manual smoke tests**
- **Search endpoint**
 ```
curl -X POST http://localhost:3000/api/search \
  -H "Content-Type: application/json" \
  -d '{"q":"bob the builder"}'

 ```
 Expect:
```
{"results":[]}%
```

- **Popular queries**
```
curl http://localhost:3000/api/analytics/popular

```
Returns top 10 { query: "...", count: N } pairs.

- **Suggestions (bonus)**
```
curl "http://localhost:3000/api/analytics/suggest?q=bo"
```
Returns up to 5 completed queries starting with “bo”.


---
&nbsp;
<br><br>


## ⚙️ OS‑Specific Notes
- ### **macOS**
If `bundle install` fails, run:
```
sudo gem install bundler
```
or adjust your Ruby path via Homebrew’s Ruby.



- ### **Linux (Debian/Ubuntu)**
Ensure `libpq-dev` (or `postgresql-server-dev-all`) is installed for the `pg` gem:
```
sudo apt install libpq-dev
```

- ### **Windows**
Use the MSYS2 terminal (via RubyInstaller’s `ridk install`) to build native gems, e.g.:

```
ridk install
gem install pg -- --with-pg-config="C:/Program Files/PostgreSQL/<version>/bin/pg_config.exe"
```

---
&nbsp;
<br><br>

## 🎨 Styling & UX Tips

- CSS lives in public/styles.css. Tweak fonts, colors, layout!

- Enhance accessibility: arrow‑key navigation & Enter to select.




