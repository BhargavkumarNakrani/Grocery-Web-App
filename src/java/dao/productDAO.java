/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import static dao.ShopkeeperDAO.session;
import entity.Products;
import entity.Shopkeeper;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import util.HibernateUtil;

/**
 *
 * @author Dell
 */
public class productDAO {
    static Session session = null;
    
    public static List<Products> viewAll(){
        String hql = "from Products";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Products> products = query.list();
        session.close();
        return products;
    }
    
    public static List<Products> viewByShop(int id){
        String hql = "from Products where shopkeeper.SId = 4";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Products> products = query.list();
        session.close();
        for(Products product : products){
            System.out.print(product.getName());
            System.out.print(product.getImage());
        }
        return products;
    }
    
    public static String viewImage(int id) throws SQLException, IOException{
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(productDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        String databaseURL = "jdbc:mysql://localhost:3306/grocerywebapp?zeroDateTimeBehavior=CONVERT_TO_NULL";
        String user = "root";
        //String password = "pass";
        String sql = "SELECT * FROM products WHERE p_id = ?";
        String base64Image = null;
         
        try (Connection connection = DriverManager.getConnection(databaseURL, user, null)) {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet result = statement.executeQuery();
             
            if (result.next()) {
                //book = new Book();
                //String title = result.getString("title");
                //String author = result.getString("author");
                Blob blob = result.getBlob("image");
                 
                InputStream inputStream = blob.getBinaryStream();
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;
                 
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);                  
                }
                 
                byte[] imageBytes = outputStream.toByteArray();
                base64Image = Base64.getEncoder().encodeToString(imageBytes);
                 
                 
                inputStream.close();
                outputStream.close();
                 
                //book.setTitle(title);
                //book.setAuthor(author);
                //book.setBase64Image(base64Image);
            }          
             
        } catch (SQLException | IOException ex) {
            ex.printStackTrace();
            throw ex;
        }     
        return base64Image;
    }
    
    public static long getCount(){
        String hql = "SELECT count(*) from Products";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        long i = (long) query.uniqueResult();
        session.close();
        return i;
    }    
    
}
