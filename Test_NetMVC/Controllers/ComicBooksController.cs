using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Test_NetMVC.Data;
using Test_NetMVC.Models;

namespace Test_NetMVC.Controllers;

public class ComicBooksController : Controller
{
    private readonly ComicSystemContext _context;

    public ComicBooksController(ComicSystemContext context)
    {
        _context = context;
    }

    // READ - Index Page
    public async Task<IActionResult> Index()
    {
        var comicBooks = await _context.ComicBooks.ToListAsync();
        return View(comicBooks);
    }

    // CREATE - GET
    public IActionResult Create()
    {
        return View();
    }

    // CREATE - POST
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create(ComicBook comicBook)
    {
        if (ModelState.IsValid)
        {
            _context.Add(comicBook);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }
        return View(comicBook);
    }

    // UPDATE - GET
    public async Task<IActionResult> Edit(int? id)
    {
        if (id == null) return NotFound();

        var comicBook = await _context.ComicBooks.FindAsync(id);
        if (comicBook == null) return NotFound();

        return View(comicBook);
    }

    // UPDATE - POST
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Edit(int id, ComicBook comicBook)
    {
        if (id != comicBook.ComicBookId) return NotFound();

        if (ModelState.IsValid)
        {
            try
            {
                _context.Update(comicBook);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ComicBookExists(comicBook.ComicBookId))
                    return NotFound();
                else
                    throw;
            }
            return RedirectToAction(nameof(Index));
        }
        return View(comicBook);
    }

    // DELETE - GET
    public async Task<IActionResult> Delete(int? id)
    {
        if (id == null) return NotFound();

        var comicBook = await _context.ComicBooks.FindAsync(id);
        if (comicBook == null) return NotFound();

        return View(comicBook);
    }

    // DELETE - POST
    [HttpPost, ActionName("Delete")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DeleteConfirmed(int id)
    {
        var comicBook = await _context.ComicBooks.FindAsync(id);
        if (comicBook != null)
        {
            _context.ComicBooks.Remove(comicBook);
            await _context.SaveChangesAsync();
        }
        return RedirectToAction(nameof(Index));
    }

    private bool ComicBookExists(int id)
    {
        return _context.ComicBooks.Any(e => e.ComicBookId == id);
    }
}