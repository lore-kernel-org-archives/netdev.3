Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920988;
	b=jPAjWgiIlGhXlTROfPjtMu4ZdMIfEm+gSc+qYRAtyBc8XUusAMvw7JvDNN1+yb7V/p6K
	 XGuXe3RkRbazt+3USNIrEc5lymbbN/EVo4MXLs/U63Faxgi3ADsPr8MBU6aRiaVCI10wy
	 +JzJuCNnVHQFezf7NaGh7aCeST7ktFSmeeDGZO/1WtPxHvlcCJhQuwWr6neVr4qORi5HJ
	 5gRCeQVKxXiLukxrqxoLn/GEf15ckmaOrq/0nVQIZ4DyVfu9V0cKWRcQ35upAj9+Es085
	 m0qOGW7x/wyE1g9ya34+H56vgOmTw1Zc6dEgpwcfKpgOGMoBTE8vFHi0jIAGKZKDwVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hdZX/lhhja06z68wQ4sSaToxfRYK5ymJ8VrwhT8hsAw=;
	b=p4y6Gl/FcjXZDvIYjyaKsPnI3tFw22w4q7auFjzitxjWeyU8CaY6759B7gxCsmzwWL92
	 VVYHkllbRSKR6IeENQ+QCC1uw9FZo48FVc8p0xz+nnL7ll3sAfYQm6NKtSadaQef07mfN
	 80vNpsjifRPsLO6oUaXHvsuW8HI/Xqq2snD6pJpIiFJLpwrf94XRT1/rlbirbtduIFm6w
	 JXCOdbfbJ/qdbibMLtRAhiK6R83y3yhLdn5G1io6yF18m/tVgHAEa20Rpyb3DWFQAC0l/
	 KxpjwbrrE54Mbpc82TbYKDRM/DeaCEdD6pwlZmhbnsqDxMeb8nIuCCvAnWUoEZ2kwPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=D+UH+HR2;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DBF606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 23:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9DBF606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=D+UH+HR2
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35c76e9614aso68195eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 15:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1793920986; x=1794525786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hdZX/lhhja06z68wQ4sSaToxfRYK5ymJ8VrwhT8hsAw=;
        b=D+UH+HR23oXV1WTudae9bz4Vwp+VnfSXVaOhalZsc+eGOFj0hgCWDz2RSdHajmk7E6
         3C6gkrka/qy2yLNZ2JXnfs3S23si9nO32bOvkZaSwpjf2bHnSAlxvNPd1urcCRbY+r2S
         3xNZQeit3gWeV4JRzIJEdD8vWqB9990r0Tg4rsbE6390HOOgxSkPFGTPDK+I5/WgHISP
         wBUYlHhdnpk//qXCJB1pEPB4RGrK+iMpGO9lf4uj3OJMBvLelSU80H7PDN0hzStjiNnP
         pwNTlnUeViP2+bQtTvimgUNSTPnZCPqq/QP/WpdYJMJVIyJ96AuDnEYdAMErd8NucKli
         sgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920986; x=1794525786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hdZX/lhhja06z68wQ4sSaToxfRYK5ymJ8VrwhT8hsAw=;
        b=UjiXrjy1o/UaqGXPuqZnXKGCkZgNmb4LcGaiIDlurHrMw7hCUQr3eqte+dFL+ofsRS
         dK4m8OE3pU14gQqrsZ9S+FyVjTJ1uo+cVbz0ojOi4NmgH4khSgTzh16spLX/JITCSS79
         IZcBaLKkoG5ZiKBWvp/JU8QY4RPTvQKqKuExP1dZaXoogzo3KDKwjPeIui9dPnGgvERW
         hUri03+BlkBte5sgoEMIRu5kXU+1k7KaC4dF6fvKVr8QHvjUU0vzwhSbfxpY6nm+7nHS
         IhCHZwBaPR34J/GSyXJWc8R/suzAwB9lCLd1a+T0UE61Wfy9vrJXSpLcwAsxgHePh0lj
         vPzw==
X-Gm-Message-State: APuU4Z/RC/mGmpx7bW2m9fvSxMdeJppdMO1A4eYS0zxLbPe6WzCbZdSu
	6o0VIEJHt3VVnuaUWR+Xv9ObST68qnyLoKpUsvQq+/n1JQRpKzIin9x8Oa7K2QlkfTI=
X-Gm-Gg: AYBFou0odv9nSqqmwWpn0R+sy3MGnkwGUPLGVmodXIkGO2/OkHheSde31FUSN8m6gAQ
	CtXo0hR7aUa/FKMCeSs8kPJhgCpLZhfKsOMRuX+Pu+d5Shm7u6+v/hdvgEHiX5SeCePJQIkp8hP
	dO4Vj3+cTB3fNT0NkO7Vomqh2GZoq1osrlyHEZRRFfRau9es3iIOBqVZSHhHqHxXYRGAdVRAb6W
	jJK8NCYKl4bGkTxxkGewe3F12rIc5jcVpcRL0W9ZAE8m1zkGvsVVmkHpTcRHfTEr4JW1jjeJZPu
	JSH1S2MMlFcCWM0dGLsdaynPM+A8+jxMSok8KxUFy7Whl2pqJ6Zq3RjHh1tRW7BEa9s7WKle9Hs
	2MZw+2LigTg099wO1ihVnuoZfPZOINq9GIP1nrmTu7cQPbAj2K1O6wdF0TqHTFlWqbmS3tl/Zvk
	nfDck7lO76B+HXNtNcu+f0HUrQWAkiXM930o8q6F+z8CYlYO4DYopGRSt6EaOhndJLddSZNelnL
	BsO9u5D+XbPjO58UhCYDt6QaZZdE4JCJANXaGtI1GWN3WLGLomItg09Ya2v0P5lzJB67kFkBZ6S
	NqjuyGYLi7Q/ETtxBAcxknLf1PmGQ5SbXI+nyFiPJSi2hYAWoIgXIj7JEoL6kjqQXv8qr+nE
X-Received: by 2002:a05:693c:2a07:b0:36d:4135:cd7 with SMTP id 5a478bee46e88-36f75a27e38mr787867eec.18.1793920985675;
        Thu, 05 Nov 2026 15:23:05 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa6a649csm369777eec.26.2026.11.05.15.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 15:23:04 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] amt: tear down every amt device on an unregistering lower
Date: Thu,  5 Nov 2026 23:23:02 +0000
Message-ID: <20261105232302.494171-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amt_device_event() acts only on the amt device that
amt_lookup_upper_dev() returns, which is the first amt device bound to
the event's lower. Several amt devices can share one lower, for
example two gateways.

On NETDEV_UNREGISTER, only the first device is unlinked and
unregistered. The others stay upper-linked to the lower, and
unregister_netdevice_many_notify() warns, because the notifier chain
must detach every upper device. They also still hold a reference on
the lower, so each is torn down only when netdev_wait_allrefs_any(),
called from netdev_run_todo(), rebroadcasts NETDEV_UNREGISTER. By then
the lower's sysfs directory is gone, so unlinking it trips a kernfs
WARN, and unregistering it from inside the rebroadcast trips the WARN
in __rtnl_unlock(). On NETDEV_CHANGEMTU, only the first device is
resized.

Walk every amt device in the lower's netns and act on each one bound
to the lower. On NETDEV_UNREGISTER, queue them all and unregister them
in one batch. amt_dellink() unlinks each device but leaves it on the
netns device list until unregister_netdevice_many(), so the walk stays
valid under RTNL.

To reproduce:

  ip link add lower0 type dummy
  ip link add amtg1 type amt mode gateway local 192.0.2.1 \
          discovery 192.0.2.2 dev lower0
  ip link add amtg2 type amt mode gateway local 192.0.2.1 \
          discovery 192.0.2.2 dev lower0
  ip link del lower0

Without this patch, the last command logs:

  WARNING: net/core/dev.c:12773 at unregister_netdevice_many_notify+0x13e5/0x1940, CPU#3: ip/216
  kernfs: can not remove 'upper_amtg2', no directory
  WARNING: fs/kernfs/dir.c:1784 at kernfs_remove_by_name_ns+0xc9/0xd0, CPU#0: ip/216
  WARNING: net/core/rtnetlink.c:141 at __rtnl_unlock+0xb2/0xf0, CPU#0: ip/216
  WARNING: net/core/rtnetlink.c:141 at __rtnl_unlock+0xb2/0xf0, CPU#0: ip/216

With it, the commands log nothing and remove both amt devices, and
tools/testing/selftests/net/amt.sh passes on a KASAN and lockdep
kernel.

Found by a selftest for our upcoming AMT offload RFC, which deletes a
lower carrying two amt gateways, on our 6.18-based driver. The
commands above reproduce it on net.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 56 ++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 81d26ef82..e7fa09e36 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3404,22 +3404,6 @@ static struct rtnl_link_ops amt_link_ops __read_mostly = {
 	.fill_info      = amt_fill_info,
 };
 
-static struct net_device *amt_lookup_upper_dev(struct net_device *dev)
-{
-	struct net_device *upper_dev;
-	struct amt_dev *amt;
-
-	for_each_netdev(dev_net(dev), upper_dev) {
-		if (netif_is_amt(upper_dev)) {
-			amt = netdev_priv(upper_dev);
-			if (amt->stream_dev == dev)
-				return upper_dev;
-		}
-	}
-
-	return NULL;
-}
-
 static int amt_device_event(struct notifier_block *unused,
 			    unsigned long event, void *ptr)
 {
@@ -3429,26 +3413,34 @@ static int amt_device_event(struct notifier_block *unused,
 	LIST_HEAD(list);
 	int new_mtu;
 
-	upper_dev = amt_lookup_upper_dev(dev);
-	if (!upper_dev)
-		return NOTIFY_DONE;
-	amt = netdev_priv(upper_dev);
+	/* amt_dellink() leaves each device on the netns device list until
+	 * unregister_netdevice_many(), so the walk stays valid.
+	 */
+	for_each_netdev(dev_net(dev), upper_dev) {
+		if (!netif_is_amt(upper_dev))
+			continue;
+		amt = netdev_priv(upper_dev);
+		if (amt->stream_dev != dev)
+			continue;
 
-	switch (event) {
-	case NETDEV_UNREGISTER:
-		amt_dellink(amt->dev, &list);
-		unregister_netdevice_many(&list);
-		break;
-	case NETDEV_CHANGEMTU:
-		if (amt->mode == AMT_MODE_RELAY)
-			new_mtu = dev->mtu - AMT_RELAY_HLEN;
-		else
-			new_mtu = dev->mtu - AMT_GW_HLEN;
+		switch (event) {
+		case NETDEV_UNREGISTER:
+			amt_dellink(amt->dev, &list);
+			break;
+		case NETDEV_CHANGEMTU:
+			if (amt->mode == AMT_MODE_RELAY)
+				new_mtu = dev->mtu - AMT_RELAY_HLEN;
+			else
+				new_mtu = dev->mtu - AMT_GW_HLEN;
 
-		dev_set_mtu(amt->dev, new_mtu);
-		break;
+			dev_set_mtu(amt->dev, new_mtu);
+			break;
+		}
 	}
 
+	if (event == NETDEV_UNREGISTER)
+		unregister_netdevice_many(&list);
+
 	return NOTIFY_DONE;
 }
 

base-commit: fafbc4051123d5459ea6950899cec08ed946e278
-- 
2.43.0

