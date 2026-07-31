Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F1B35AC14
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478776; cv=none; b=RCZXr5Fh5RIZloXEltGw00ypjOzW5/jjqqLM8yetXtI/Diuu3C37MSkrNo6wDrtUIUgNhpzPJDItgBcibVAiDhapb0Q24wIVb71uIPA37bW6MX671y443IBy+wueT+UxH5wkgc+obNGWlm/juvXbKMyK++DLAfuumvmPEQ7T6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478776; c=relaxed/simple;
	bh=bI94Zgm8ZtFoWG9GNDGjhc7mWaZ3niLfjX8hb6+Bi7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hz9h/fsOtZj7rn1XNYpsDsCbwLmQnDhL/CSK4x745l7PsoNZe9AoHKjZcVrGIj3JU5nc0jg+J8rqJuWfPLzmPEfQHB7rluUNME6zro9uyKpMJRz2Nrhmb6SUFa61QXgNFouWNG0xrdRVmT2IjWynWVJzF87Ly/IsnTyMKHPYNgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1785478736te18d2437
X-QQ-Originating-IP: Y69KcTSQdig7/pMLY+lOr0f7JCXBF5Dsfu9CWqo/n8A=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 14:18:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16318063504315324444
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
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v13 3/5] net: wangxun: add reinit parameter to wx->do_reset callback
Date: Fri, 31 Jul 2026 14:18:35 +0800
Message-Id: <20260731061837.12672-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260731061837.12672-1-jiawenwu@trustnetic.com>
References: <20260731061837.12672-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MZ6Tfega+cDUmg3EOOS7xZNoDBY0MdNpBdBwJ0+6161zWVPyX2WzC+wV
	FEuHV5M03v363BI76vQwzrOw+5YyONqGnu0kZF4lrRC2T3za3Mw2/8r2QMmG+UZrOf8m/dN
	WESasskMXVUpCWsiI8UcqqVpp+vMqCBkSa7+CkgckcTw1/O/WSsYJXK0eJ/n98vciF0zeJw
	6IVNCaEvFWNbdxAVHyiXJanU/4+orbwtpWktNatw4+MQ9OttSU11Qozqn7oEiXgAab+JkC+
	bZqEs3DoXyAMKfGBH/JNMxz4BGBpv1Z1aURpcFdS0f6OeNVujvr2xgqaWxUMI0CKa3T2b1s
	46do3ZpwVQOHiNBOUqtlx6wrbMQOsrvRdxybjmObWH1FBsueKDe+bl17m18PPCkrP6oB/8e
	+hDgGLanSsCE+guxuMcYWdXh74sqvd2Hu7a9U5WfXxR33owmm8LuZWUQ+m29WzqfvOMvjhk
	R1WMNrX/S8cQf6pUromKxHzJH1iFgPPrB0LtIoSqTKqDYe5qG7KA3vYClYLQIRjdscdvey2
	uw8bamWaOdXEHPHLdbUGXvT+gCbj35C2vRsvv3d2Rv1ZuDcmeZSYKh4GuIRqE2s9KbZ+Ep4
	txiu5pbMghM4szy2W+t+8eioyG3sAP0DLHQtRbTRSv76yZd/sZvrK9qmGz0wIFfUwnUe2Qp
	D2Q6zj5I8/PEfDs9heJ6NSkP2olmN03lAlvXpgaV/0qbDRULxSshSKG6DOqXfhwHv+2mvS3
	PRg5j86TKzPyuziZz2OIxj/ZscAZXCSf2eDS5s2hK3SDvd5SZmF3+bUvq6X1h0h1YLgIqyQ
	ZeQ4uEy34+/WgxBt4YXkgqpmO/io7iPxmaglNLRV8z5RaWsnEgNrdJ7PH+oPn4dqfkU5/xi
	G/JHhiTbgiuhC9Qzb4726nfQhbRmsmRBr+Ksv5jQbDKAoDAkUBFlFvYsuknaUcFzHEnEt4s
	72KG9EJnY3ucMl2yWVygS8izLZmLCxXCzKNy+UbfLkOeJFn4OAezg1WmDJzyZXQlRcKmZ/Q
	GO5fWSxIaqpgF4DlagN2/hUCYOYovuMwkL9bnP1axlrRx3atw+hAmDgznqVI6alTWbT+gDz
	6SPW42PeISWxQWLe75joEWvlaMbsW7dFw==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
index 22037f015ded..940d2e59876c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -397,7 +397,7 @@ static void wx_update_rsc(struct wx *wx)
 
 	/* reset the device to apply the new RSC setting */
 	if (need_reset && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 }
 
 int wx_set_coalesce(struct net_device *netdev,
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 633ab5c61a05..67af8640a49e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3151,7 +3151,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 	netdev->features = features;
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_RX && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
 		wx_set_rx_mode(netdev);
 
@@ -3201,7 +3201,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 
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
index 158bf0b9637c..dea5506dc9d2 100644
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

