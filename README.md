
## 🧬 BioForge

[![Conda Channel](https://img.shields.io/badge/conda-bioforge-blue)](#)
[![Build Status](https://github.com/bbeckley-hub/bioforge/actions/workflows/conda-build.yml/badge.svg)](https://github.com/bbeckley-hub/bioforge/actions)
[![License](https://img.shields.io/github/license/bbeckley-hub/bioforge)](LICENSE)
[![Stage](https://img.shields.io/badge/status-active-brightgreen)](#)
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)](#)

---

## 🚀 Overview

**BioForge** is a fast, community-driven Conda channel designed to accelerate the distribution of bioinformatics tools.

Unlike traditional ecosystems such as Bioconda, BioForge emphasizes **speed, accessibility, and early-stage innovation**, enabling developers to share tools without long review delays.

---

## ⚡ Why BioForge?

BioForge removes common bottlenecks in bioinformatics software distribution:

- ⚡ **Rapid recipe acceptance** – automated CI validation (no human review)
- 🧪 **Early-stage tool availability** – immediate testing and feedback
- 🤝 **Community-driven iteration** – no centralized gatekeeping
- 🛡️ **Automated trust** – license whitelist, build tests, security scanning

---

## 🌱 Vision

BioForge serves as a **pre-Bioconda ecosystem** — a staging ground where tools can:

- Be packaged and distributed quickly
- Gain real-world usage and feedback
- Mature into stable, reproducible software

Once validated, tools can transition to **Bioconda** for long-term maintenance and broader adoption.

---

## 🧩 Key Principles

- ⚡ **Fast** – minimal review bottlenecks through automation
- 🔬 **Reproducible** – enforced build and test requirements
- 🌱 **Progressive Trust** – packages evolve from *fast* → *verified*
- 🤝 **Open** – community contributions are central

---

## ⚙️ How It Works

### 🔹 Fast Lane (Default)
- Submit a recipe via Pull Request
- Automated CI builds and tests the package
- License whitelist check (MIT, BSD-3, Apache-2.0, GPL-3)
- Security scan (basic pattern checks)
- **If all checks pass → automatically merged and published**

### 🔹 Progressive Trust Labels
- `fast` label – newly added packages (use with caution)
- `main` label – after 100 downloads or 7 days without issues
- `verified` label (future) – community-approved stable tools

---

## 📦 Installation (for users)

Add the BioForge channel and install a tool:

```bash
conda config --add channels bioforge
conda config --add channels conda-forge   # recommended for dependencies
conda install kleboscope
```

Or install directly from the channel:

```bash
conda install -c bioforge kleboscope
```

---

## 🧑‍💻 Adding a Recipe (for developers)

1. **Fork** the repository
2. **Add your recipe** under `recipes/<tool-name>/` (copy `recipes/EXAMPLE/meta.yaml`)
3. **Submit a Pull Request**

Minimal requirements:
- Working `meta.yaml` (source, build, test sections)
- Successful build in CI
- Functional test command (`--help` or similar)
- License from the whitelist

### Example Recipe

```yaml
package:
  name: your-tool
  version: "1.0.0"

source:
  git: https://github.com/author/your-tool.git
  rev: v1.0.0

build:
  noarch: python
  script: {{ PYTHON }} -m pip install .

test:
  commands:
    - your-tool --help

about:
  license: MIT
```

### What happens after you submit?

- CI builds, tests, and scans your recipe.
- If all checks pass, the PR is **automatically merged**.
- Package is uploaded to `bioforge/label/fast`.
- After 100 downloads or 7 days, it’s promoted to the main channel.

---

## 🏗️ Repository Structure

```
bioforge/
├── .github/workflows/          # CI automation
│   └── conda-build.yml
├── recipes/
│   ├── EXAMPLE/                # Template recipe
│   │   └── meta.yaml
│   └── kleboscope/             # Your tool here
├── scripts/                    # Helper scripts
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

---

## 🤝 Contributing

We welcome all contributions:
- Add new tools
- Improve existing recipes
- Help test and validate packages
- Report issues or abusive packages

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

---

## 🛡️ Automated Trust Model (No Manual Review)

BioForge replaces human reviewers with automated checks:

| Check | Method | Action on failure |
|-------|--------|-------------------|
| License whitelist | `grep` on meta.yaml | Reject PR |
| Build & test | `conda build` + test commands | Reject PR |
| Security scan | `conda inspect objects` | Warn (does not block) |
| Dependency resolution | `conda create --dry-run` | Reject PR |
| Source integrity | Git commit SHA / tag | Reject if missing |

**No human approval required** – packages are published automatically if all critical checks pass.

---

## ⚠️ Status

✅ **Active** – BioForge is now operational.

- Initial recipes: `kleboscope` (available)
- CI pipeline: fully automated
- Channel: `bioforge` on Anaconda.org

---

## 📜 License

This project is licensed under the **MIT License** – see [LICENSE](LICENSE) for details.

---

## 💡 Long-Term Goal

BioForge is not a replacement for Bioconda.  
It is designed to complement it by becoming:

> **The fastest path from tool development → real-world usage → ecosystem adoption**

---

## 📬 Contact & Support

- Open an [issue](https://github.com/bbeckley-hub/bioforge/issues) for bugs or questions.
- For abusive packages, tag `[ABUSE]` in the issue title.

---

**Start using BioForge today – publish your tool in minutes, not months.**
