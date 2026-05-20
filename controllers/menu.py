"""
controllers/menu.py
Rich-powered interactive CLI controller.
"""

from rich.console import Console
from rich.table import Table
from rich.panel import Panel
from rich.prompt import Prompt, Confirm
from rich import box

from models.student import StudentModel
from models.internship import InternshipModel
from models.certification import CertificationModel
from views.stats import StatsView

console = Console()

DOMAIN_CHOICES = ["Consulting", "Finance", "Marketing"]
PROGRAMME_CHOICES = ["B.Com(H)", "B.Com", "BA(H) Economics", "M.Com"]


# ── Helpers ───────────────────────────────────────────────────────────────────

def _table(title, columns, rows, col_styles=None):
    t = Table(title=title, box=box.ROUNDED, show_lines=True, title_style="bold cyan")
    for i, col in enumerate(columns):
        style = col_styles[i] if col_styles and i < len(col_styles) else "white"
        t.add_column(col, style=style, no_wrap=False)
    for row in rows:
        t.add_row(*[str(v) if v is not None else "-" for v in row])
    console.print(t)


def _prompt_choice(prompt_text, choices):
    console.print(f"\n[bold yellow]Options:[/bold yellow] {', '.join(choices)}")
    while True:
        val = Prompt.ask(prompt_text)
        if val in choices:
            return val
        console.print("[red]Invalid choice. Try again.[/red]")


# ── Dashboard ────────────────────────────────────────────────────────────────

def show_dashboard():
    ov = StatsView.overview_counts()
    console.print(Panel(
        f"[bold green]Total Students:[/] {ov['total_students']}   "
        f"[bold blue]Consulting:[/] {ov['consulting']}   "
        f"[bold magenta]Finance:[/] {ov['finance']}   "
        f"[bold yellow]Marketing:[/] {ov['marketing']}   "
        f"[bold cyan]Placed:[/] {ov['total_placed']}",
        title="🏛  SRCC Student Domain Tracker",
        border_style="cyan",
    ))

    rows = []
    for r in StatsView.domain_summary():
        rows.append((r["domain"], r["total_students"], r["placed_count"],
                     f"{r['avg_gpa']:.2f}"))
    _table("Domain Summary", ["Domain", "Total", "Placed", "Avg GPA"],
           rows, ["cyan", "white", "green", "yellow"])


# ── Student Screens ───────────────────────────────────────────────────────────

def list_students():
    students = StudentModel.get_all()
    rows = [(s["id"], s["name"], s["roll_no"], s["domain"],
             s["year"], s["programme"], s["gpa"],
             "✅" if s["placed"] else "❌") for s in students]
    _table("All Students", ["ID", "Name", "Roll No", "Domain",
                             "Year", "Programme", "GPA", "Placed"], rows)


def view_profile():
    sid = Prompt.ask("Enter Student ID")
    p = StudentModel.get_full_profile(int(sid))
    if not p:
        console.print("[red]Student not found.[/red]")
        return

    console.print(Panel(
        f"[bold]{p['name']}[/bold] ({p['roll_no']})\n"
        f"Programme: {p['programme']}  |  Year: {p['year']}\n"
        f"Domain: [cyan]{p['domain']}[/cyan]  |  GPA: {p['gpa']}\n"
        f"Email: {p['email']}  |  Phone: {p['phone'] or '-'}\n"
        f"LinkedIn: {p['linkedin_url'] or '-'}\n"
        f"Placed: {'✅  ' + str(p['placement_pkg']) + ' LPA' if p['placed'] else '❌'}\n"
        f"Skills: [yellow]{', '.join(p['skills']) or 'None'}[/yellow]",
        title=f"Profile — {p['name']}", border_style="green"
    ))

    if p["internships"]:
        rows = [(i["company_name"], i["role"], i["domain_type"],
                 str(i["start_date"]), str(i["end_date"] or "-"),
                 f"₹{i['stipend_pm']:,.0f}" if i["stipend_pm"] else "-",
                 "✅" if i["is_ppo"] else "❌")
                for i in p["internships"]]
        _table("Internships", ["Company", "Role", "Domain", "Start", "End",
                                "Stipend/mo", "PPO"], rows)

    if p["certifications"]:
        rows = [(c["cert_name"], c["issuing_body"] or "-",
                 str(c["issue_date"] or "-")) for c in p["certifications"]]
        _table("Certifications", ["Certificate", "Issuer", "Date"], rows)


def add_student():
    console.print("\n[bold cyan]➕  Add New Student[/bold cyan]")
    name       = Prompt.ask("Full name")
    roll_no    = Prompt.ask("Roll number")
    email      = Prompt.ask("Email")
    phone      = Prompt.ask("Phone (optional)", default="")
    year       = int(Prompt.ask("Year (1/2/3)"))
    programme  = _prompt_choice("Programme", PROGRAMME_CHOICES)
    domain     = _prompt_choice("Domain", DOMAIN_CHOICES)
    gpa_str    = Prompt.ask("GPA (optional)", default="")
    gpa        = float(gpa_str) if gpa_str else None
    linkedin   = Prompt.ask("LinkedIn URL (optional)", default="") or None

    sid = StudentModel.create(name, roll_no, email, phone or None,
                              year, programme, domain, gpa, linkedin)
    console.print(f"[green]✔ Student added with ID {sid}[/green]")


def add_skill_to_student():
    sid   = int(Prompt.ask("Student ID"))
    skill = Prompt.ask("Skill name")
    StudentModel.add_skill(sid, skill)
    console.print("[green]✔ Skill added.[/green]")


def mark_placed():
    sid = int(Prompt.ask("Student ID"))
    pkg = float(Prompt.ask("Package (LPA)"))
    StudentModel.mark_placed(sid, pkg)
    console.print("[green]✔ Placement recorded.[/green]")


def delete_student():
    sid = int(Prompt.ask("Student ID to delete"))
    if Confirm.ask(f"[red]Delete student {sid}? This removes all linked data.[/red]"):
        n = StudentModel.delete(sid)
        console.print(f"[green]✔ Deleted {n} record(s).[/green]")


def search_students():
    kw = Prompt.ask("Search (name / roll / email)")
    results = StudentModel.search(kw)
    if not results:
        console.print("[yellow]No results found.[/yellow]")
        return
    rows = [(s["id"], s["name"], s["roll_no"], s["domain"]) for s in results]
    _table("Search Results", ["ID", "Name", "Roll", "Domain"], rows)


# ── Internship Screens ────────────────────────────────────────────────────────

def add_internship():
    console.print("\n[bold cyan]➕  Add Internship[/bold cyan]")
    sid         = int(Prompt.ask("Student ID"))
    company     = Prompt.ask("Company name")
    role        = Prompt.ask("Role / Position")
    domain_type = _prompt_choice("Domain type", DOMAIN_CHOICES + ["Other"])
    start_date  = Prompt.ask("Start date (YYYY-MM-DD)")
    end_date    = Prompt.ask("End date (YYYY-MM-DD, optional)", default="") or None
    stipend     = Prompt.ask("Monthly stipend in ₹ (optional)", default="")
    stipend     = float(stipend) if stipend else None
    is_ppo      = Confirm.ask("PPO received?", default=False)

    InternshipModel.add(sid, company, role, domain_type,
                        start_date, end_date, stipend, is_ppo)
    console.print("[green]✔ Internship recorded.[/green]")


# ── Certification Screens ─────────────────────────────────────────────────────

def add_certification():
    console.print("\n[bold cyan]➕  Add Certification[/bold cyan]")
    sid    = int(Prompt.ask("Student ID"))
    cert   = Prompt.ask("Certification name")
    issuer = Prompt.ask("Issuing body (optional)", default="") or None
    date   = Prompt.ask("Issue date YYYY-MM-DD (optional)", default="") or None
    CertificationModel.add(sid, cert, issuer, date)
    console.print("[green]✔ Certification added.[/green]")


# ── Stats Screens ─────────────────────────────────────────────────────────────

def show_placement_stats():
    rows = [(r["domain"], r["total"], r["placed"],
             f"{r['pct']}%",
             f"₹{r['avg_pkg_lpa']} LPA" if r["avg_pkg_lpa"] else "-",
             f"₹{r['max_pkg_lpa']} LPA" if r["max_pkg_lpa"] else "-")
            for r in StatsView.placement_stats()]
    _table("Placement Statistics", ["Domain", "Total", "Placed", "%", "Avg Pkg", "Top Pkg"], rows)


def show_top_companies():
    rows = [(r["domain_type"], r["company_name"],
             r["intern_count"], r["ppo_count"]) for r in StatsView.top_companies()]
    _table("Top Hiring Companies", ["Domain", "Company", "Interns", "PPOs"], rows)


def show_cert_leaders():
    rows = [(r["name"], r["roll_no"], r["domain"],
             r["cert_count"]) for r in StatsView.cert_leaders()]
    _table("Certification Leaderboard", ["Name", "Roll No", "Domain", "Certs"], rows)


def show_skills():
    data = StatsView.top_skills_per_domain()
    for domain, skills in data.items():
        top = skills[:5]
        rows = [(s["skill"], s["count"]) for s in top]
        _table(f"Top Skills — {domain}", ["Skill", "# Students"], rows)


def show_competition_winners():
    rows = [(r["name"], r["domain"], r["comp_name"],
             r["organiser"] or "-", r["result"],
             str(r["comp_date"])) for r in StatsView.competition_winners()]
    _table("Competition Podium", ["Student", "Domain", "Competition",
                                   "Organiser", "Result", "Date"], rows)
