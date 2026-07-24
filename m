Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AC23DA7E6
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888051; cv=none; b=FSEG9QS+0q91UN2W9s/H+ZQ+4JaeuvLwN13jZUlnNnLaJWkLKij8DKu6fHOmU5UwWBEa0icjMRl6Zqyp4iSf4MNe9AsyIcvLgumaLgbf5OS3Y4aj4vLkz4pKNHVdZnrYrsFjyj0wyiuOryI/nRACBeRWQkYYkO6xaue8QAgWK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888051; c=relaxed/simple;
	bh=ktBtyRLbmmCqdtrjrzJQzFQjwqKKmRJiee7PUO4YOPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kj+sBpgVOZgiangKSLHTjpJ+jkihyVwXZ7hGiHb5OSSWf4h1tFgobT5Kyu1cVptR91anTAZjofOnCKSP03CIXPTLQktoMBcrQuSU0PneH5rsqStvjKqeNDTZ1/kWzxKSf+kmHI5CRrLpbO93uWG+54MylWs8LLJSaS9+YSYXydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz18t1784888010t63c6a220
X-QQ-Originating-IP: CLMGNYZ18btPNmCdRaSpHWqGn7RUjFbNwur/eqxDqaU=
Received: from lap-jiawenwu.trustnetic.com ( [115.227.112.172])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jul 2026 18:13:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16862004499088915050
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v12 3/5] net: wangxun: add reinit parameter to wx->do_reset callback
Date: Fri, 24 Jul 2026 18:13:07 +0800
Message-Id: <20260724101309.23472-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260724101309.23472-1-jiawenwu@trustnetic.com>
References: <20260724101309.23472-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OST2d686M2k2dqpGIeUlDolyJ++vOghJiobW9adQhHjTg6TN6MbQEII5
	JpYJoxLmHia/1HkaGxv8jwGAki9glCV5KPn3RECufU31UtvY1wzi5EzLH5GTQpXJzEIVben
	Q7C2ZwWywyysx0T69qiywMzwU+05BeMlwDaocfoAO/bA22+ctV/LP0n4r8YTBWhp2ETfHRq
	AIGepyIF1I24PuqdBHUzIqfMECpKd48hcD0BWjgIU6gH1iaulyEaHy5kzJ9Z5apYx/vizp3
	Ge0EQQoRxgc9ScEEGvfKZbr/xgpUYftTT4w1GzGlv+/bNv1zTwRa55Tkh55mNgT07KgmjLy
	gh8ovAOSiwIZB83mUpZ0vXW4y8L2qQNTVFL6dBDIdiNJSCx9+BQWwj/5jvflI6c4RrsJMew
	EafFschBRPikh3pr8S+RDqDTInMTMsZ+txX56g1FxlG2CBWfXrKh9Ho55eWTo4Gq3J8whTY
	bpHqGMlOelyo0e03NX8YOEKQkNccPzmuOgvIVbHOszzoaM7O/xqfSBKZ8pMNJQ+nABBcLkc
	nB3ErORHQlBQvfXx5/GA8SPf0jr1QTk3anYB1u6ef2N9+FhE7xzvcNqynBhRVAd9HSuJoOv
	ctYJpA0Gkv/2GeZt7x68PnDtw4QaHjo87WpgkhxF2pGemSVnynZPJ/8CKlGIhSBsGRuyIZh
	HPvhzDPhD2z5pO2AN1i85+gamm/MobPbOuS5Qs61RCWh7VjHWw3E2rXU3Q38Nm+t2rnZ1Ut
	AdvIzWt78oBCY4Nw72wjzpeJ75341DG2Ty7dEUUMkKEW+CyfWLqmNXzgVbbyh1qgRTW0WXQ
	FcEBhj2iXtJSCBGI+VbQkUPaISQxyfSiMjxUZCuEbUgmpX4K+wywNCGnku8z+CfQ62drTo1
	KSuNIi33koJjRntdtCRUlvgtn11Nk0iu7FlDeS80YB9ePAQxmhQt/dSZvve7ZxdFBD8ixxA
	5X1cJRGieG/JeVFdOyPr5Udqu2vSnnJBVYS+RW5vswbMm2dM1ZSbKbxSxe+tWJdxLzIAfz5
	pN4qwzZcWeQIwCHL7I6Ua8x5mEQoW2VGC1uQ3fvLagNWdBkT1oFf0O3cQ4uf6D8MJpBNhV5
	ep3Qv2FY0Ej
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
index 2ea81d57f603..3373df34744c 100644
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

