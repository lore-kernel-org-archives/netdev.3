Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487ED3B14B4
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506292; cv=none; b=VG4i3B4pY3Oc62D0OT3qzW1KHt/QyQfzX5XZ2m2n1QFmLrkvK/JEPAfSOP3kRc543zPPCzxkvB4daodwtzRlzJeUx53ZUHClKgsP2pmVY+NFBj2L/9zMvQ26XP387gr7UamS2dGM/Wl9mbcVWgwHe5/N3Y6tBqn88f4hs7NTICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506292; c=relaxed/simple;
	bh=9r8CPdgcO0MMwaZXD+DCywGNBG1DTWI44SfCpZTaSDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nIQoyBRwE/wFcVQEJDtQvXGa11zniPtVt9d58cdN/et0aUrBvNOEkLpy8LOHtOCJtyW8gdCkur0e4tq58SlyIkqnLyK0IavqCz82RcJh+nNl7YdlDyRxotk7r4s1fJHScmj7MA906Ao8Q44eZbzZXlE0SWAYL1Rzc6VuaA5GzeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz11t1781506230t7e26aeb2
X-QQ-Originating-IP: ejpzVPLW7uExgsyy3U2UETZmCfT61TtXHxLniH0bgZg=
Received: from lap-jiawenwu.trustnetic.com ( [183.157.22.210])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jun 2026 14:50:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11548096370575589194
EX-QQ-RecipientCnt: 21
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
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v7 1/5] net: ngbe: implement libwx reset ops
Date: Mon, 15 Jun 2026 14:50:12 +0800
Message-Id: <20260615065016.21672-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260615065016.21672-1-jiawenwu@trustnetic.com>
References: <20260615065016.21672-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M5z4lLHHBhdaAAZDM0uOrrWFVzzna1bvHWL7jDOLdH/8nnDpVc5sqOd7
	UTXuZJiP1T4ceYJjBZWh/lPxLZ5RmDl+S4c+QhjYwLXgylidmB1M1rLP3/Ulp7QZtbpE3VR
	ycJ6SOSzZOWaTvn9GhD8NrNBXCbgcHmKpQGcHUZhrwJo2rJ6eXDvRGg9xO/OIBE8JScWfoK
	vW5Tk6gzDlQnG28xHL2V1PQQ94iiIKSihOqkhvIeZAwIuH9IltOV0sBFUPqOgHkKPjaBBPX
	lDdTjZUmlrkgKJ9WFz77sbEpQ6olHeuqVqU9ym5eGuotimdb3/CW1LR1uPWjBu2w/VH4n4Q
	0Oq1RbSiUCMgU3hsoKrfjqBk/zdOuJA3H0cphOb3EgQPvMGHOSZJYYq0sPTr/FPgcyp5p47
	aThn60frD/yfd3RLdceXGYTSvMybgsL1SbUbjHqkLzZSRK71UC/BFhJHz99SYq5+N8Q5IL6
	vEkgFuvZDXwc8rAad/t+VavNgN5FwSXFsPkij8LgH9wiOAVKU918t6+26SZKpj+mtIV/1G5
	Unn6mOh0IVQCW0efzagNZDkNaay9s9e31ICd58SBffosRmJF6JSW9jO2cC1Go3CbVb3yX5m
	83zEYABBAchNa99AsMikMjNXM0u24YsD7ss4olaiRK+5eGV8uqhuLklog+mPhb6pEqrJLQ+
	fCx39y/3JcESlkoVM7Ra8REgbeLCdjzplpwHRmi4xkqAlV4pW3b39khjPkZ2FYXOKt9rRbv
	mV8aoKZMsTeMhgxWP+YfMxLuZlpAsTSrDL8PmssoAlnY3i+C1gHApAVJf04G/VHU4MAdeli
	gxc/flEQIYnKtf2AGApRvyDJevFITrylAtO/oFxjO10u+9hjq8x9yCoKzjz/Ba3fcoYY5RA
	7DapYHmMT9ZV810Cd5nePlLAvyvGRJuepUlc3edt876iSIBAnmsjiByBLdFKCAVbvEU0eRo
	y4UGpvUzqnBNVKAkIjs2Lo3GN8Z4m/SwqlKYVsUt1YNx+jcqUVPjg/o5+nE7lN0aF4Ep0hc
	MEEQTnZzOsvY5vt/7n7kk2+V09RCRUhqKqDsN13qK8X9rm5GWS5X9PE3rAZzA6+ClHYAhLQ
	2JStPlCuImv
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
index 8678c49b892a..dea6dfb043f3 100644
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

