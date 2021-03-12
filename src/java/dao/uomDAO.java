/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import org.hibernate.Session;
import entity.Uom;
import java.util.List;
import org.hibernate.Query;
import util.HibernateUtil;
/**
 *
 * @author Dell
 */
public class uomDAO {
        static Session session = null;
        
        public static String getName(int id){
            String hql = "select uomName from Uom where uomId="+id;
            session = HibernateUtil.getSessionFactory().openSession();
            Query query = session.createQuery(hql);
            String i = (String) query.uniqueResult();
            session.close();
            return i;
        }
        
        public static List<Uom> view(){
            String hql = "from Uom";
            session = HibernateUtil.getSessionFactory().openSession();
            Query query = session.createQuery(hql);
            List<Uom> uom = query.list();
            session.close();
            return uom;
        }
        public static Uom viewSinglebyId(int id)
    {
        String hql = "from Uom where uomId='"+id+"'";
        session = HibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery(hql);
        List<Uom> uom = query.list();
        session.close();
        Uom obj=null;
        if(!uom.isEmpty())
            obj = uom.get(0);
        return obj;
    }
}
