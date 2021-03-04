/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Accounts;
import entity.Shopkeeper;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import util.HibernateUtil;

/**
 *
 * @author Dell
 */
public class ShopkeeperDAO {
    static Session session = null;
    
    public static List<Shopkeeper> viewAll(){
        String hql = "from Shopkeeper";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Shopkeeper> shopkeeper = query.list();
        session.close();
        return shopkeeper;
    }
    
    public static Shopkeeper viewSingle(String email)
    {
        String hql = "from Shopkeeper where email='"+email+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Shopkeeper> shopkeeper = query.list();
        session.close();
        Shopkeeper obj=null;
        if(!shopkeeper.isEmpty())
            obj = shopkeeper.get(0);
        return obj;
    }

}
