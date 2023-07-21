beforeEach(() => {
  cy.visit("/");
});
describe("Add to Cart functionality", () => {
  it("Increases cart count when adding a product", () => {
    cy.get(".products article").first().click();
    // Get initial cart count before adding the product
    cy.get(".nav-link").should("contain", "My Cart (0)");

    // cy.get('.product-detail h1').should('have.text','Scented Blade')

    // Find the 'Add' button for a product and click on it
    cy.get(".price .btn").should("contain", "Add").click();

    // Verify that tha cart count increase by one after adding the product
    cy.get(".nav-link").should("contain", "My Cart (1)");
  });
});
