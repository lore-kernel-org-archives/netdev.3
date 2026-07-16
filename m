Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2BE2E8897
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187576; cv=none; b=GZgGAAh1bKOxeeDK1AEYrcqeC7q8tN8/3OTgoC/8z470BQtDOiUQh4mPaEM3JHL9QOXnlLB7gpqHRd0bBrTLRSRwF4xfxtp8X7fJ86aNjhS5TaXkpdBClv/By8hOYwG71IgGuvEa4XNDGugZrC3YKAX1Qx38lJvNwshxRVVmkMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187576; c=relaxed/simple;
	bh=6I454hJx/ljgeAiUkN6h73UVw2kQr2wEeJ0aVNkphmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eBTzubIqVN+y29E2bQlAII4RKCe6JtaW6Ppiz+J8XngUGuR/4lAbqcnpOtpzKvIQlGCs4W6mlVAp4lZpyDUvaJSRj891KVfAt9sCFw3y0L+f48CB9qQ0Av4pe++bDaJdCdCEOxEKlBXRYnr2NAL89jOcQqYpMWt14AXvXQPRBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1784187521t87e9f9a1
X-QQ-Originating-IP: rkLaHkBW1f8GzPq7WjVuwdGas/6gYWlVKEhh73tkbhk=
Received: from lap-jiawenwu.trustnetic.com ( [115.200.247.46])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jul 2026 15:38:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9513721059499851573
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
Subject: [PATCH net-next v11 3/5] net: wangxun: add reinit parameter to wx->do_reset callback
Date: Thu, 16 Jul 2026 15:38:20 +0800
Message-Id: <20260716073822.24356-4-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NBny2gfrEg+1P+IsR3mJ8/dnHB0Q5QX8Dyh4gC+EItiSt5r0GRy86OEP
	jbzBht9cDHJIbZwX9m+TEafjikyh5U3zty+Oa3L0vkseXQyWdp0GRMxFA3KiaLauJx3s/aj
	pRFlxvzFnmJ9ZCft5otqFvH4jq0eh2oYYgqWXNiW7xTKlh4sRcIspgTZ85yzDmqUCiBG8x9
	/0HuUYerM9lT+e+w11XOzM/CrkIhNddC490v/R2S9L7S3O65OJmOz4aZGb2Vq3cP6w0nSWA
	6e8xphnx7fJObJcvK09hox/ClXa+BJryk74G5qTbQTbCyucWtdK0362V8RZTKoOzqyYzQ+M
	dsJFDGPB8QnBpQ4S8S4ZdFYv6nhXTo6OqwG7BzchR0Wr7TpL81JgGEbyrnX07jqJoSihQtF
	sxBzhHZ+j0GTv4j6Y+jQ5F462vjqqSvjnxKSFDHJf5UAchfrjigA8eut/G3gGdnIlSag4yt
	kEl215Ev00ZiENguluRyFVUHC+HIXUIaFeG5AS402eYjYdXaxFVbTYak/3KF0k0GGeRSGwT
	MT7/8+L7wvQ05uwN2pxc2C5NwNtqvjitBbrfLNS6JL+gor+5ZyVPZ521/rGiyDtXVZQ7Miy
	4IdbegfrKsD7WETg92CzYAg1bCSfnpdJDbVXxKVpIBsStPuvvbyzZBqCvwaIxVTCEytKjjT
	e6o3OsZIwFLIRxz/YnDFAg35g3xbNCUK8pH9+/9jUqLjOmiD4/H73PddT2NKt3E/qxuSqBY
	OhKj1s2AS/amgkvjdO3lsXPngFtPuch0YhDNA4dLHcqkXzfM7Dgcn0kSPaRL38uwrW5Z59V
	1AVLis+n2fFCWSB6Bo2zGcbgP7PKUA01/UuGMnkqj7DQ5FicK6TRoWpFphhKdJ3PNQYoDA3
	RZLwm/v7CC5gCXEIyqHg9viJmfA16afgRNnh6uzT3Fl0PcVcUfzYZjd0xwAArZ7pUO3rmzs
	hzyQmGT8gkNTx4dGWbTfgKXlb9IqvL638MRd1+ujFTDCdqjOz5yyPfXXz9Y3EUf8fU4NvMc
	3iUBog3jfLsibgvCQHdB/COxqsj9zPp3gFtnrdW8wtQ6pfZqQaEU6vrUBjCbaIrS0641BNZ
	9zgkKejgoro
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

To implement a simple hardware reset without tearing down the network
interface state, introduce a boolean 'reinit' parameter to wx->do_reset
callback.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_err.c     | 2 +-
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c | 2 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c     | 4 ++--
 drivers/net/ethernet/wangxun/libwx/wx_type.h    | 2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   | 4 ++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h   | 2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 4 ++--
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
index b6e2d16d4a16..ee27f96735dc 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -16,7 +16,7 @@ static void wx_pf_reset_subtask(struct wx *wx)
 
 	wx_warn(wx, "Reset adapter.\n");
 	if (wx->do_reset)
-		wx->do_reset(wx->netdev);
+		wx->do_reset(wx->netdev, true);
 }
 
 static void wx_reset_task(struct work_struct *work)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 5df971aca9e3..d1356ff5d69b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -395,7 +395,7 @@ static void wx_update_rsc(struct wx *wx)
 
 	/* reset the device to apply the new RSC setting */
 	if (need_reset && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 }
 
 int wx_set_coalesce(struct net_device *netdev,
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 3a6db657c685..c8a4822d3819 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3149,7 +3149,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 	netdev->features = features;
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_RX && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
 		wx_set_rx_mode(netdev);
 
@@ -3199,7 +3199,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 
 out:
 	if (need_reset && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index e12a59305193..edcb8d121b86 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1409,7 +1409,7 @@ struct wx {
 	void (*atr)(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype);
 	void (*configure_fdir)(struct wx *wx);
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
-	void (*do_reset)(struct net_device *netdev);
+	void (*do_reset)(struct net_device *netdev, bool reinit);
 	int (*ptp_setup_sdp)(struct wx *wx);
 	void (*set_num_queues)(struct wx *wx);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 996c48da52d7..92895f503511 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -633,11 +633,11 @@ static void ngbe_reinit_locked(struct wx *wx)
 	mutex_unlock(&wx->reset_lock);
 }
 
-void ngbe_do_reset(struct net_device *netdev)
+void ngbe_do_reset(struct net_device *netdev, bool reinit)
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (netif_running(netdev))
+	if (netif_running(netdev) && reinit)
 		ngbe_reinit_locked(wx);
 	else
 		ngbe_reset(wx);
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 4f648f272c08..c9233dc7ae50 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -125,6 +125,6 @@ extern char ngbe_driver_name[];
 void ngbe_down(struct wx *wx);
 void ngbe_up(struct wx *wx);
 int ngbe_setup_tc(struct net_device *dev, u8 tc);
-void ngbe_do_reset(struct net_device *netdev);
+void ngbe_do_reset(struct net_device *netdev, bool reinit);
 
 #endif /* _NGBE_TYPE_H_ */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index b1615f82a265..a8773712cff8 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -610,11 +610,11 @@ static void txgbe_reinit_locked(struct wx *wx)
 	mutex_unlock(&wx->reset_lock);
 }
 
-void txgbe_do_reset(struct net_device *netdev)
+void txgbe_do_reset(struct net_device *netdev, bool reinit)
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (netif_running(netdev))
+	if (netif_running(netdev) && reinit)
 		txgbe_reinit_locked(wx);
 	else
 		txgbe_reset(wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 877234e3fdc2..3e93a3f309c1 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -313,7 +313,7 @@ extern char txgbe_driver_name[];
 void txgbe_down(struct wx *wx);
 void txgbe_up(struct wx *wx);
 int txgbe_setup_tc(struct net_device *dev, u8 tc);
-void txgbe_do_reset(struct net_device *netdev);
+void txgbe_do_reset(struct net_device *netdev, bool reinit);
 
 #define DECLARE_PHY_INTERFACE_MASK_ZERO(name) \
 	unsigned long name[PHY_INTERFACE_MODE_MAX] = { 0, }
-- 
2.51.0

