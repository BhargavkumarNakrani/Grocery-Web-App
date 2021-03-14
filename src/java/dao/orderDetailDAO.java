/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.OrderDetails;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.hibernate.Query;
import org.hibernate.Session;
import util.HibernateUtil;

/**
 *
 * @author Dell
 */
public class orderDetailDAO {
    static Session session = null;
    
    public static List<OrderDetails> viewByOrderId(int id){
        String hql = "from OrderDetails where orders.OId= "+id;
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<OrderDetails> orderDetails = query.list();
        session.close();
        return orderDetails;
    }
    
    public static List viewShopName(int id){
        String hql = "select shopkeeper.SId from OrderDetails where orders.OId= "+id;//+" and shopkeeper.SId ="+shopId;
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List orderDetails = query.list();
        Set set = new HashSet<>(orderDetails);
        orderDetails.clear();
        orderDetails.addAll(set);
        session.close();
        return orderDetails;
    }
    
    public static List<OrderDetails> viewByShopAndOId(int OId, int shop_id){
        String hql = "from OrderDetails where orders.OId= "+OId+" and shopkeeper.SId="+shop_id;
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<OrderDetails> orderDetails = query.list();
        session.close();
        return orderDetails;
    }
}
