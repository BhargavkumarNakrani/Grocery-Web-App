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
import util.HibernateUtil;

/**
 *
 * @author Dell
 */
public class cartDAO {
    static Session session = null;
    
    public static List<Cart> viewCart(String email){
        String hql = "from Cart where customer.email='"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Cart> cart = query.list();
        session.close();
        return cart;
    }
}
