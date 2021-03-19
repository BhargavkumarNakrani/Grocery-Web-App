/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.DeliveryBoy;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author Dell
 */
public class DeliveryBoyDAO {
    static Session session = null;
    
    public static void insert(DeliveryBoy bean)
    {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        session.save(bean);
        t.commit();
        session.close();
    }
    
    public static List<DeliveryBoy> viewAll(){
        String hql = "from DeliveryBoy";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<DeliveryBoy> deliveryBoy = query.list();
        session.close();
        return deliveryBoy;
    }
    
    public static void update(DeliveryBoy bean)
    {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        session.update(bean);
        t.commit();
        session.close();
    }
    
    public static DeliveryBoy ViewSingle(String email){
        String hql = "from DeliveryBoy where email='"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<DeliveryBoy> deliveryBoy = query.list();
        session.close();
        DeliveryBoy obj=null;
        if(!deliveryBoy.isEmpty())
            obj = deliveryBoy.get(0);
        return obj;
    }
    
    public static DeliveryBoy viewSinglebyID(int Id){
        String hql = "from DeliveryBoy where dbId="+Id;
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<DeliveryBoy> deliveryBoy = query.list();
        session.close();
        DeliveryBoy obj=null;
        if(!deliveryBoy.isEmpty())
            obj = deliveryBoy.get(0);
        return obj;
    }
    
    public static int viewOrderTaken(int Id){
        String hql = "select orderTaken from DeliveryBoy where dbId="+Id;
        session = HibernateUtil.getSessionFactory().openSession();
        //session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        int i = (int) query.uniqueResult();
        //int I = (int)i;
        session.close();
        return i;
    }
    
    public static int updateDBorderTaken(String email){
        String hql = "UPDATE DeliveryBoy set orderTaken=orderTaken+1 where email ='"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t=session.beginTransaction();
        int updatedEntities = session.createQuery(hql).executeUpdate();
        t.commit();
        session.close();
        return updatedEntities;
    }
    
    
}
