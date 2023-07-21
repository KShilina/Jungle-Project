beforeEach(() => {
  cy.visit("/");
});

describe("Product details navigation", () => {
  it("Navigates to product detail page on click", () => {
    // Find the product partial on the home page and click on it
    cy.get(".products article").first().click();

    //Assert that the URL contains '/products/' (indicating navigation to the product detail page)
    cy.url().should("include", "/products/");
  });
});
