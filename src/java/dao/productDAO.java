/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Products;
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
import org.hibernate.Transaction;
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
    
    public static List<Products> viewAll(int Start){
        String hql = "from Products";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        query.setFirstResult(Start).
                setMaxResults(12);
        List<Products> products = query.list();
        session.close();
        return products;
    }
    
    public static List<Products> viewAll(int Start, String search){
        String hql = "from Products where (category.name like :keyword"
                + " OR name like :keyword OR shopkeeper.shopName like :keyword)";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql).setString("keyword", "%"+search+"%");
        query.setFirstResult(Start).
                setMaxResults(12);
        List<Products> products = query.list();
        session.close();
        return products;
    }
    
    public static List<Products> viewAll(int Start, int categoryId){
        String hql = "from Products where category.categoryId="+categoryId;
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        query.setFirstResult(Start).
                setMaxResults(12);
        List<Products> products = query.list();
        session.close();
        return products;
    }
    
    public static List<Products> viewAll(int Start, int categoryId, String search) {
        String hql = "from Products where category.categoryId=" + categoryId+" and (category.name like :keyword"
                + " OR name like :keyword OR shopkeeper.shopName like :keyword)";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql).setString("keyword", "%"+search+"%");
        query.setFirstResult(Start).
                setMaxResults(12);
        List<Products> products = query.list();
        session.close();
        return products;
    }
    
    public static List<Products> viewByShop(int id){
        String hql = "from Products where shopkeeper.SId = "+id;
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
        String databaseURL = "jdbc:mysql://localhost:3306/grocerywebapp";
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

    public static long getCount(int categoryId){
        String hql = "SELECT count(*) from Products where category.categoryId="+categoryId;
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        long i = (long) query.uniqueResult();
        session.close();
        return i;
    }
    
    public static long getSearchCount(String search){
        String hql = "SELECT count(*) from Products where (category.name like :keyword"
                + " OR name like :keyword OR shopkeeper.shopName like :keyword)";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql).setString("keyword", "%"+search+"%");
        long i = (long) query.uniqueResult();
        session.close();
        return i;
    }
    
    public static long getSearchCount(String search, int categoryId){
        String hql = "SELECT count(*) from Products where category.categoryId="+categoryId+" and (category.name like :keyword"
                + " OR name like :keyword OR shopkeeper.shopName like :keyword)";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql).setString("keyword", "%"+search+"%");
        long i = (long) query.uniqueResult();
        session.close();
        return i;
    }
    
    public static long getSearchCount(String search, String email, int categoryId){
        String hql = "SELECT count(*) from Products where shopkeeper.email = '"+email+"' and category.categoryId="+categoryId+" and (category.name like :keyword"
                + " OR name like :keyword OR shopkeeper.shopName like :keyword)";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql).setString("keyword", "%"+search+"%");
        long i = (long) query.uniqueResult();
        session.close();
        return i;
    }
    
    public static long getSearchCount(String search, int categoryId,int shopId){
        String hql = "SELECT count(*) from Products where shopkeeper.SId="+shopId+" and category.categoryId="+categoryId+" and (category.name like :keyword"
                + " OR name like :keyword OR shopkeeper.shopName like :keyword)";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql).setString("keyword", "%"+search+"%");
        long i = (long) query.uniqueResult();
        session.close();
        return i;
    }
    
    public static long getCount(String email, int categoryId) {
        String hql = "SELECT count(*) from Products where shopkeeper.email = '"+email+"' and category.categoryId=" + categoryId;
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        long i = (long) query.uniqueResult();
        session.close();
        return i;
    }
    public static long getCount(int categoryId, int shopId){
        String hql = "";
        if(categoryId == 0){
            hql = "SELECT count(*) from Products where shopkeeper.SId="+shopId;
        } else {
            hql = "SELECT count(*) from Products where category.categoryId="+categoryId+" and shopkeeper.SId="+shopId;
        }
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        long i = (long) query.uniqueResult();
        session.close();
        return i;
    }
    public static long getCount(String email){
        String hql = "SELECT count(*) from Products where shopkeeper.email = '"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        long i = (long) query.uniqueResult();
        session.close();
        return i;
    }
    
    public static Products viewById(int id){
        String hql = "from Products where PId = "+id;
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Products> products = query.list();
        session.close();
        Products obj = null;
        if(!products.isEmpty()){
            obj = products.get(0);
        }
        return obj;
    }
    
    public static List<Products> viewByShopId(int id) {
        String hql = "from Products where shopkeeper.SId = "+id+"";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Products> products = query.list();
        session.close();
        return products;
    }
    public static List<Products> viewByShopId(int id, int Start) {
        String hql = "from Products where shopkeeper.SId = "+id;
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        query.setFirstResult(Start).
                setMaxResults(12);
        List<Products> products = query.list();
        session.close();
        return products;
    }
    public static List<Products> viewByShopId(int id, int Start, String search) {
        String hql = "from Products where shopkeeper.SId = "+id+" and (category.name like :keyword"
                + " OR name like :keyword OR shopkeeper.shopName like :keyword)";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql).setString("keyword", "%"+search+"%");
        query.setFirstResult(Start).
                setMaxResults(12);
        List<Products> products = query.list();
        session.close();
        return products;
    }
    
    public static List<Products> viewByShopId(int id, int Start, int categoryId) {
        String hql = "from Products where category.categoryId="+categoryId+" and shopkeeper.SId ="+id;
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        query.setFirstResult(Start).
                setMaxResults(12);
        List<Products> products = query.list();
        session.close();
        return products;
    }
    
    public static List<Products> viewByShopId(int id, int Start, int categoryId, String search) {
        String hql = "from Products where category.categoryId=" + categoryId + " and shopkeeper.SId =" + id+" "
                + "and (category.name like :keyword"
                + " OR name like :keyword OR shopkeeper.shopName like :keyword)";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql).setString("keyword", "%"+search+"%");
        query.setFirstResult(Start).
                setMaxResults(12);
        List<Products> products = query.list();
        session.close();
        return products;
    }
    
    public static List<Products> viewByShopEmail(String email, int Start) {
        String hql = "from Products where shopkeeper.email = '"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        query.setFirstResult(Start).
                setMaxResults(12);
        List<Products> products = query.list();
        session.close();
        return products;
    }
    
    public static List<Products> viewByShopEmail(String email, int Start, String search) {
        String hql = "from Products where shopkeeper.email = '"+email+"' and (category.name like :keyword"
                + " OR name like :keyword OR shopkeeper.shopName like :keyword)";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql).setString("keyword", "%"+search+"%");
        query.setFirstResult(Start).
                setMaxResults(12);
        List<Products> products = query.list();
        session.close();
        return products;
    }
    
    public static List<Products> viewByShopEmail(String email, int Start, int categoryId) {
        String hql = "from Products where shopkeeper.email = '"+email+"' and category.categoryId="+categoryId;
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        query.setFirstResult(Start).
                setMaxResults(12);
        List<Products> products = query.list();
        session.close();
        return products;
    }
    
    public static List<Products> viewByShopEmail(String email, int Start, int categoryId, String search) {
        String hql = "from Products where shopkeeper.email = '"+email+"' and category.categoryId="+categoryId+" and (category.name like :keyword"
                + " OR name like :keyword OR shopkeeper.shopName like :keyword)";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql).setString("keyword", "%"+search+"%");
        query.setFirstResult(Start).
                setMaxResults(12);
        List<Products> products = query.list();
        session.close();
        return products;
    }
    
    public static int deleteById(int id){
        String hql = "delete from Products where PId ="+id;
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        Query query = session.createQuery(hql);
        int i = query.executeUpdate();
        t.commit();
        session.close();
        if(i>0)
            cartDAO.deleteByProduct(id);
        return i;
    }
    
     public static void save(Products bean)
    {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        session.save(bean);
        t.commit();
        session.close();
    }
     
    public static void update(Products bean)
    {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        session.update(bean);
        t.commit();
        session.close();
    }
    
    public static void update(int id,int CategotyId, int SId,int uomId,String pname,int quantity ,int price)
    {
        String hql = "UPDATE Products set " +
          "category.categoryId = :CategotyId," +
          "shopkeeper.SId = :SId, " +
          "uom.uomId = :uomId, " +
          "name = :pname, " +
          "quantity = :quantity, " +
          "price = :price " +
    
          "where id = :id";
        //bean.setImage(viewImage(id));
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        int updatedEntities = session.createQuery(hql)
        .setInteger("CategotyId", CategotyId )
        .setInteger("SId", SId )
        .setInteger("uomId", uomId )
        .setString( "pname", pname )
        .setInteger("quantity", quantity )
        .setInteger("price", price )
        .setInteger("id", id)
        .executeUpdate();
        t.commit();
        session.close();
    }
   
}
