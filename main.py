"""
main.py
SRCC Student Domain Tracker — interactive CLI entry point.
"""

from rich.console import Console
from rich.panel import Panel
from rich.prompt import Prompt

from controllers.menu import (
    show_dashboard,
    list_students, view_profile, add_student,
    add_skill_to_student, mark_placed, delete_student, search_students,
    add_internship, add_certification,
    show_placement_stats, show_top_companies,
    show_cert_leaders, show_skills, show_competition_winners,
)
from database.connection import Database

console = Console()

MENU = {
    # ── Students
    "1":  ("List all students",          list_students),
    "2":  ("View full student profile",  view_profile),
    "3":  ("Search students",            search_students),
    "4":  ("Add new student",            add_student),
    "5":  ("Add skill to student",       add_skill_to_student),
    "6":  ("Mark student as placed",     mark_placed),
    "7":  ("Delete student",             delete_student),
    # ── Internships / Certs
    "8":  ("Add internship",             add_internship),
    "9":  ("Add certification",          add_certification),
    # ── Analytics
    "10": ("Placement statistics",       show_placement_stats),
    "11": ("Top hiring companies",       show_top_companies),
    "12": ("Certification leaderboard",  show_cert_leaders),
    "13": ("Top skills per domain",      show_skills),
    "14": ("Competition winners",        show_competition_winners),
    "0":  ("Exit",                       None),
}


def print_menu():
    lines = []
    sections = [
        ("👤 Students", ["1", "2", "3", "4", "5", "6", "7"]),
        ("📋 Internships & Certs", ["8", "9"]),
        ("📊 Analytics", ["10", "11", "12", "13", "14"]),
        ("", ["0"]),
    ]
    for heading, keys in sections:
        if heading:
            lines.append(f"\n[bold yellow]{heading}[/bold yellow]")
        for k in keys:
            label = MENU[k][0]
            lines.append(f"  [{k}] {label}")
    console.print(Panel("\n".join(lines), title="Main Menu", border_style="blue"))


def main():
    console.print(Panel(
        "[bold cyan]SRCC Student Domain Tracker[/bold cyan]\n"
        "[dim]Consulting · Finance · Marketing[/dim]",
        border_style="cyan"
    ))

    while True:
        show_dashboard()
        print_menu()
        choice = Prompt.ask("\nEnter option", default="0")

        if choice == "0":
            console.print("[bold green]Goodbye! 👋[/bold green]")
            break

        if choice not in MENU:
            console.print("[red]Invalid option.[/red]")
            continue

        try:
            MENU[choice][1]()
        except Exception as e:
            console.print(f"[red]Error: {e}[/red]")
            Database.rollback()

        Prompt.ask("\n[dim]Press Enter to continue[/dim]", default="")

    Database.close()


if __name__ == "__main__":
    main()
