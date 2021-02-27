import cn.leancloud.AVOSCloud;

public class FlutterApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();

        AVOSCloud.initialize(this, "{{1cIw2YEkzc9XnGewUjk8IWFs-gzGzoHsz}}", "{{dVv2tRIqPRRgObkWp0wbuQuu}}", "https://1ciw2yek.lc-cn-n1-shared.com");
    }
}