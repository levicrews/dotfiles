---
name: bib-add
description: Add a scholarly work to the user’s crewsbib.bib bibliography, matching its BibTeX, cite-key, JEL-keyword, PDF, and published-versus-working-paper conventions.
---

# Add bibliography entry

Use this skill when the user asks to add, cite, save, or download a work to the `crewsbib` bibliography. The repository root is the directory containing `crewsbib.bib` and `pdf/`.

For a weekly Feedly batch, the user only needs to provide the saved-item URLs, an exported/pasted list of Feedly items, or the local PDFs. Ideally each item includes its NBER URL; a title and author list is enough to begin a search. The user does not need to supply BibTeX, JEL codes, cite keys, or publication metadata. Ask for clarification only when a title/link is too ambiguous to identify confidently. A batch label or date is optional and should not become a bibliography field unless the source supports it.

Read [crewsbib-conventions.md](../bib-common/references/crewsbib-conventions.md) before editing. Treat the existing bibliography as the source of truth when a detail is not covered there; inspect nearby entries of the same type and recent entries by the same author.

Workflow:

1. Identify the exact work and search for its published version first. Prefer the final journal, book, book chapter, proceedings, thesis, or other published record when one exists. If no published version is available, use the NBER working-paper version when one exists. Do not add a working-paper record merely because a published record is gated.
2. Gather authoritative metadata: all authors/editors, exact title, publication year, journal or book, volume/issue/pages, publisher where appropriate, DOI, stable URL, NBER number or chapter URL, abstract, and JEL codes if available. Always try to obtain the full abstract. Check the DOI/Crossref record first, then the NBER, journal, publisher, or author page when the abstract is not included automatically with the DOI metadata. Use the publisher, DOI/Crossref, NBER, or author page as appropriate. If the best copy is gated and access is required, stop and ask the user to log in through their university VPN; do not invent metadata or silently substitute an inferior version.
3. Derive a cite key by concatenating author surnames in author order, preserving hyphens exactly (for example `Rossi-Hansberg`, `Mas-Colell`, or `Fernandez-Villaverde`), followed by the publication year. Add a lowercase `a`, `b`, etc. only when the same base key already exists; inspect collisions before choosing the suffix.
4. Choose the BibTeX entry type and fields from the actual publication. Keep only metadata supported by the source. Include JEL codes in `keywords` when available, comma-separated; do not add topical prose, search terms, or other non-JEL keywords for new entries. Preserve braces around capitalization-sensitive words and names as shown by local style.
5. If a PDF is obtained, copy it into `pdf/[citekey].pdf`. If there is a separate supplementary appendix, name it `pdf/[citekey]_Appendix.pdf`; use the exact same spelling and suffix in the `file` field. For other distinct files, follow the existing suffix patterns such as `_Comment`, `_Slides`, `_OldVersion`, or `_UpdatedVersion`. Do not claim a file exists until it is present locally.
6. Insert the new entry into `crewsbib.bib` with the repository’s aligned `field = {value},` formatting, preserving the file’s existing content and ordering conventions. Avoid duplicate records by searching cite keys, DOI, title, and NBER number first.
7. Validate the result: the cite key is unique, braces are balanced, the entry has the correct type and required bibliographic fields, every `file` path exists, keywords are JEL codes only, an abstract was included whenever an authoritative source exposed one, and the entry does not contain fabricated or unverified metadata. Report whether the published or NBER version was added and which files were attached; if an abstract could not be obtained, say so explicitly.

Adding an entry authorizes edits to the bibliography and copying the requested paper into its local `pdf/` directory, but does not authorize bypassing access controls. Ask for VPN login only when gated access is actually needed.

## Final report

At the end of every completed run, list every paper added in a compact table or bullet list by cite key, with the title and whether it was the published version or an NBER working paper. Also list any requested items that were skipped, ambiguous, duplicated, or blocked by gated access.
