package main

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type Product struct {
	Id          string `json:"id,omitempty"`
	Name        string `json:"name,omitempty"`
	Description string `json:"description,omitempty"`
	// capability to add URL's - image reference to product
	// ImageDescription []string
}

type ProductRequest struct {
	Name        string `json:"name"`
	Description string `json:"description"`
}

type ProductResponse struct {
	*Product `json:"product,omitempty"`
	Message  string `json:"message,omitempty"`
}

/*
// ***************************************************
//
// Global declarations
//
// ***************************************************
*/
var products map[string]Product

// ***************************************************

func init() {
	fmt.Println("Init method invoked in the application. Do all your initialization here")
	products = make(map[string]Product)
	fmt.Println("Product is now initialized!")
}

func generateNewProductId() string {
	id := uuid.New()
	return id.String()
}

func convertProductRequestToProduct(req ProductRequest, id string) Product {
	product := Product{Id: id, Name: req.Name, Description: req.Description}
	return product
}

// ****************************************************
// product REST handlers
// ****************************************************
func addProductHandler(c *gin.Context) {
	var addProduct ProductRequest
	if err := c.ShouldBindJSON(&addProduct); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "name and description are required fields. Please check your input JSON and try again!",
		})
		return
	}
	fmt.Println("new Product is valid")
	newProduct := convertProductRequestToProduct(addProduct, generateNewProductId())
	products[newProduct.Id] = newProduct
	fmt.Println("Added new Product to DB")
	productResponse := ProductResponse{Product: &newProduct, Message: "Successfully added new product!"}
	fmt.Println(productResponse)
	c.JSON(http.StatusOK, productResponse)
}

func listProductsHandler(c *gin.Context) {
	c.JSON(http.StatusOK, products)
}

func findProductById(id string) Product {
	return products[id]
}

func findProductByIdHandler(c *gin.Context) {
	productId := c.Param("productId")
	product := findProductById(productId)
	if product == (Product{}) {
		productResponse := ProductResponse{Product: nil, Message: "Item you are looking for is not found. Please try again later!"}
		c.JSON(http.StatusNotFound, productResponse)
		return
	}
	c.JSON(http.StatusOK, product)
}

func deleteProductByIdHandler(c *gin.Context) {
	productId := c.Param("productId")
	product := findProductById(productId)
	if product == (Product{}) {
		productResponse := ProductResponse{Product: nil, Message: "Item you are looking for is not found. Please try again later!"}
		c.JSON(http.StatusNotFound, productResponse)
		return
	}
	delete(products, product.Id)
	productResponse := ProductResponse{Product: &product, Message: "Deleted product successfully!"}
	c.JSON(http.StatusOK, productResponse)
}

func updateProductByIdHandler(c *gin.Context) {
	productId := c.Param("productId")
	modifyProduct := findProductById(productId)
	if modifyProduct == (Product{}) {
		productResponse := ProductResponse{Product: nil, Message: "Item you are looking for is not found. Please try again later!"}
		c.JSON(http.StatusNotFound, productResponse)
		return
	}
	var updateProductReq ProductRequest
	if err := c.ShouldBindJSON(&updateProductReq); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "name and description are required fields. Please check your input JSON and try again!",
		})
		return
	}
	modifyProduct.Name = updateProductReq.Name
	modifyProduct.Description = updateProductReq.Description
	products[productId] = modifyProduct
	fmt.Println("Updated Product to DB")
	productResponse := ProductResponse{Product: &modifyProduct, Message: "Successfully Updated product!"}
	fmt.Println(productResponse)
	c.JSON(http.StatusOK, productResponse)

}

// ****************************************************
// generic handlers
// ****************************************************

func endpointHandler(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{
		"message": fmt.Sprintf("%s, %s", c.Request.Method, c.Request.URL.Path),
	})
}

// ****************************************************
// MAIN
// ****************************************************
func main() {
	router := gin.Default()
	router.GET("/products", listProductsHandler)
	router.GET("/products/:productId", findProductByIdHandler)
	router.POST("/products", addProductHandler)
	router.PUT("/products/:productId", updateProductByIdHandler)
	router.DELETE("/products/:productId", deleteProductByIdHandler)
	router.Run(":8080")
}
