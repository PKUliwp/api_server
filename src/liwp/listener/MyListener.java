package liwp.listener;

import reco_query.reco.Recommendation;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Created by liwp on 2017/5/9.
 */
public class MyListener implements ServletContextListener {
    public void contextDestroyed(ServletContextEvent event) {

    }

    public void contextInitialized(ServletContextEvent event) {
        Recommendation reco = new Recommendation();
        event.getServletContext().setAttribute("db", reco);
    }

}
