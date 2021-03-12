/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Orders;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import util.HibernateUtil;

/**
 *
 * @author Dell
 */
public class ordersDAO {
    static Session session = null;
    
    public static Orders viewByOrderId(int id){
        String hql = "from Orders where OId= "+id;
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Orders> order = query.list();
        session.close();
        Orders obj = null;
        if(!order.isEmpty()){
            obj = order.get(0);
        }
        return obj;
    }
}
