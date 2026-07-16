Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6DF3BCD16
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187577; cv=none; b=XNesn+mn1KUVa7FR/Sa3lJR3SUqqjLmpgl26DVrLTvOExDTQac7p3gvQvi1w9+/fixhJ45u2nxlmDV/hN0qQ5codfiEHheEdQpxpKG8kTB7+U3ejl9el327+5hdx3ApIzDOlcfhXOGZqwoHXmszMdKd2eCdwMlrpnDR9eyHBocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187577; c=relaxed/simple;
	bh=6AFo5vxslIwLJHmQAwxTHn5JObBYSyWZatqARdMMw2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AIYscJudiZtvUCsVOImJ2p8iVq/u1YXY+Xf9EFcCWMw2YOGBm6SO4fP1z6h0lkFK5lPaYnJT3H+sPGWLXeukQtkHE6IMzos7nWN2j08gQ2+GkKw4lOL3pUaxQpMV6pzV6hUNPZcXpvvXj8gWFU+JsI85BwGBnmm4h/Q/5o+Ngj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1784187515te1dfd77f
X-QQ-Originating-IP: jdjWLvlPMsSQc9XZsB5Hx1zaH8ClpCyjkq8NjzUch6s=
Received: from lap-jiawenwu.trustnetic.com ( [115.200.247.46])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jul 2026 15:38:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7628770884163919008
EX-QQ-RecipientCnt: 20
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Joe Damato <joe@dama.to>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v11 1/5] net: ngbe: implement libwx reset ops
Date: Thu, 16 Jul 2026 15:38:18 +0800
Message-Id: <20260716073822.24356-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260716073822.24356-1-jiawenwu@trustnetic.com>
References: <20260716073822.24356-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Odq46pC/ulzC6Afwc4jvArF22PlEh59PR5ZAR1YMx0Z+K71bFlpHM1ua
	iUNa1VjdmJqXQq21NjXuhc9MannXzj63bef7o+wPQZp4ekcMSe/+CUU+kXKOUySjxK2ji5G
	sN7vaYHGG+rcAxWnsCp1Pxvjt6WSikf6HaYQAswnfzqh+2V25rtBU84cmLoRL6PDwSpvvOJ
	0L84e8HNkPYaiYbBra5KRCHvQ+OsUDiDA0DSlqQFpm2U5AgURpJjTu09ShbvHqi5FZ7lkC6
	b+d6OpDzZnucFGlQjsnUfKpwZHiJys9uaI+LrWg4u0Pbokq+R8CkYfFJdf5a9vqvVRUJVRh
	eMfs8nb1+C5x0WsBYa4m2NO92BSTuXrLMCNzr5nZ++8hHknlsfW1zk7DnrfTL23kjiKxGPJ
	vwK0vDH6GWU1oAJdxluriKgwcBxl9yLDX4CoQGtMS9WkYYyXwfgreIsjll/MtQ5A5HIRuwX
	Y1eODGdWSuqdYnimyIZC0cduERmsVRqxlD+BFdNwRqp75RJDcLEK3OuLdIq5UInAqmA4HK1
	5poATynHWTMKUF2VfeTddcuS4t9NF9pKxWlH5UX8v6r5AD+uiUPep68gAogBKcp9cU1Q6wr
	6njZ3FKlDLqnKpJa+UTI7BHZ59iE+kEzeLAeVXcZqwXHjmKuWJrj1g3EsoYo48dPBK65olC
	05y3BqTcZSlDChn/8+k8XiWT38xQZUdygqQl/E0hFRX/Yx3bhUvGUC2lwouFb5Kh0yBxBHl
	PFS+fK7Zgn5q7ndoSDo66QzPIpeo4ftv+J/tuwLYQJWQWUdFxMKzMmsPPELlt+KykOcnILu
	Hzb57kRlBuGYGYh52CSKxh7XYmwx9xGrPJFUjlfHGMljo09boTn+EdqMO4LG6sQB6/WDts+
	74QN98qtuMV9zvSdCiLAPJhR85yCtihDW7b68KdTOjS8/c4P24dYK2tQyPc8XJTMp9GoNea
	mIUO0uruL+plcZQRT6AkGg5JF0BhTlObZ8wnmRkRQ62d3FJdOrkzPSGWB2qGdIvZrg/sg2I
	piokuvIA71kti7c7SDpVCoZlQYT7WLksxLoMQqLQsXxvoQ8o83H611lHwj3QaEaIgs2Bm6e
	65ERxidLzJmHJBz/kNnpCbv2XhAlq0tFRwwd8n1hVBU
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Implement wx->do_reset() for library module calling.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 37 ++++++++++++++++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  1 +
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index b2e191982803..1960f7154151 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -59,7 +59,6 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
 	kvfree(temp_ring);
 
-	wx_configure(wx);
 	ngbe_up(wx);
 
 clear_reset:
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index a16221995909..bbbec9b43bc2 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -133,6 +133,7 @@ static int ngbe_sw_init(struct wx *wx)
 
 	wx->mbx.size = WX_VXMAILBOX_SIZE;
 	wx->setup_tc = ngbe_setup_tc;
+	wx->do_reset = ngbe_do_reset;
 	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
@@ -423,7 +424,7 @@ void ngbe_down(struct wx *wx)
 	wx_clean_all_rx_rings(wx);
 }
 
-void ngbe_up(struct wx *wx)
+static void ngbe_up_complete(struct wx *wx)
 {
 	wx_configure_vectors(wx);
 
@@ -490,7 +491,7 @@ static int ngbe_open(struct net_device *netdev)
 
 	wx_ptp_init(wx);
 
-	ngbe_up(wx);
+	ngbe_up_complete(wx);
 
 	return 0;
 err_dis_phy:
@@ -503,6 +504,12 @@ static int ngbe_open(struct net_device *netdev)
 	return err;
 }
 
+void ngbe_up(struct wx *wx)
+{
+	wx_configure(wx);
+	ngbe_up_complete(wx);
+}
+
 /**
  * ngbe_close - Disables a network interface
  * @netdev: network interface device structure
@@ -590,6 +597,8 @@ int ngbe_setup_tc(struct net_device *dev, u8 tc)
 	 */
 	if (netif_running(dev))
 		ngbe_close(dev);
+	else
+		ngbe_reset(wx);
 
 	wx_clear_interrupt_scheme(wx);
 
@@ -606,6 +615,30 @@ int ngbe_setup_tc(struct net_device *dev, u8 tc)
 	return 0;
 }
 
+static void ngbe_reinit_locked(struct wx *wx)
+{
+	netif_trans_update(wx->netdev);
+
+	mutex_lock(&wx->reset_lock);
+	set_bit(WX_STATE_RESETTING, wx->state);
+
+	ngbe_down(wx);
+	ngbe_up(wx);
+
+	clear_bit(WX_STATE_RESETTING, wx->state);
+	mutex_unlock(&wx->reset_lock);
+}
+
+void ngbe_do_reset(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	if (netif_running(netdev))
+		ngbe_reinit_locked(wx);
+	else
+		ngbe_reset(wx);
+}
+
 static const struct net_device_ops ngbe_netdev_ops = {
 	.ndo_open               = ngbe_open,
 	.ndo_stop               = ngbe_close,
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 7077a0da4c98..4f648f272c08 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -125,5 +125,6 @@ extern char ngbe_driver_name[];
 void ngbe_down(struct wx *wx);
 void ngbe_up(struct wx *wx);
 int ngbe_setup_tc(struct net_device *dev, u8 tc);
+void ngbe_do_reset(struct net_device *netdev);
 
 #endif /* _NGBE_TYPE_H_ */
-- 
2.51.0

