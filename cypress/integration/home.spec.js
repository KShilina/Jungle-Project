// const { beforeEach, it } = require("mocha")

describe("Jungle App", () =>{
  beforeEach(()=>{
    cy.visit('/')
  })

  it('displays the home page correctly', () => {
    cy.get('.navbar').should('be.visible')
    // cy.get('.products').should('be.visible')
  }) 

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
  
})


