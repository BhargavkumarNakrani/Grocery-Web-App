/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import org.hibernate.Session;
import entity.Cart;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author Dell
 */
public class cartDAO {
    static Session session = null;
    
    public static int save(Cart bean)
    {   
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        int i = (int) session.save(bean);
        t.commit();
        session.close(); 
        return i;
    }
    
    public static List<Cart> viewCart(String email){
        String hql = "from Cart where customer.email='"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Cart> cart = query.list();
        session.close();
        return cart;
    }
    
    public static void delete(int id){
        String hql = "delete from Cart where id ="+id;
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        Query query = session.createQuery(hql);
        query.executeUpdate();
        t.commit();
        session.close();
        //return i;
    }
    
    public static long checkEmail(int id, String email){
        String hql = "select count(*) from Cart where id="+id+" and customer.email='"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        long i = (long) query.uniqueResult();
        session.close();
        return i;
    }
    public static int deleteByProduct(int PId){
        String hql = "delete from Cart where products.PId="+PId;
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        Query query = session.createQuery(hql);
        int i = query.executeUpdate();
        t.commit();
        session.close();
        return i;
    }
    
    public static long checkProductInCart(int PId, String email){
        String hql = "select count(*) from Cart where products.PId="+PId+" and customer.email='"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        long i = (long) query.uniqueResult();
        session.close();
        return i;
    }
   
    public static long CartItem(String email){
        String hql = "select count(*) from Cart where customer.email='"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        long i = (long) query.uniqueResult();
        session.close();
        return i;
    }
    
    public static long cartTotal(String email){
        String hql = "select SUM(amount) from Cart where customer.email='"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        long i = (long) query.uniqueResult();
        session.close();
        return i>=0 ? i : 0;
    }
    
    public static void updateQuntity(int id, int i){
        String hql = "update Cart set quantity = "+i+", amount = price*"+i+" where id="+id;
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        Query query = session.createQuery(hql);
        query.executeUpdate();
        t.commit();
        session.close();
    }
    
    public static long checkCartByProductId(int PId, String email){
        String hql = "select count(*) from Cart where products.PId="+PId+" and customer.email='"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        long i = (long) query.uniqueResult();
        System.out.print(i);
        session.close();
        return i;
    }
    
}
