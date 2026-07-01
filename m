Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B973B52F0
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890725; cv=none; b=S354u/q5f1mYLu5DIUyx19z4xmEF+bVVOfIZC6LTOsSj79hTydrAUaUWCoZlU9b/wwkJpuq+8Cb/qeMMz4wRPXmMqUQ0/mEEcRW+3K/Qy27/fyZSY7bdI2BlPGSJUTRy1u7nJ0aU53DasWh44d0Ab0kPtktjGwQzbmNsDr/dFt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890725; c=relaxed/simple;
	bh=JFQg45+q3dw9svhIeTmg63aTk8xERABJHQz/CooYhdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BI+Z028nBDkoQPO9neQwEWNXSoQK4K8YWUcLULv7DIZMY+dSmdiPs9fEVP0TqQ7z9VWmXGxOC16q7LZofK3Z8SKqOxaC3OeU3bA8cUv/aPqmBbiGm3zrTX2LD3Kj5LQNqR9Chl5dXaloOlGXWCzVB6tqaMULbjMZMWj8Ca3rI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz18t1782890666tc52a5760
X-QQ-Originating-IP: q+DH+brFhDq9PiuT/lSvFwuL+dwILxzxZxTu584eMLU=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.190.76])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 01 Jul 2026 15:24:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18280180218110123531
EX-QQ-RecipientCnt: 22
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
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v9 3/5] net: wangxun: add reinit parameter to wx->do_reset callback
Date: Wed,  1 Jul 2026 15:23:55 +0800
Message-Id: <20260701072357.33984-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260701072357.33984-1-jiawenwu@trustnetic.com>
References: <20260701072357.33984-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NfsSXdiEmZi7Tccgv3yqUpBtwTHq3k6P6f7n216M1xa4w8pH8XbC+pSf
	dmWa3sdqI2z78zZO0fwSRNgq534ybT7if7criYxfAXmyVlboprDcMHmRv8i2g+Q3QSkcxoQ
	JX+eSZH/5Zs+p03adKnWdffJqIjfNfpx/o+6oj/kvCZbITPg9hDLk8qSHwv1EXJR04WiqN1
	ZFObl1D3uFp62hHrQSCQZCkn3LRwO8haOJXALMVvMu+wEua7tLOU5mJaI6qtlSWxfruXVIL
	wTfFXJ4OSj4CgyK4PszH9GHjPXPSQIe8JyVZzzjfFl+F//BdI+Rw97dwHof9DB9HCm5EZq2
	uW/CXEJ8ht/kArIxHANQMbnB7vRG02fibqKoD9UWFHP90DXADr25e6bpwKq2UJ/ebq3Tocw
	8aHnUY8OvEOtYFmHGWEESOpdVuBzeafV6Mg2v1LNDVOYVBK08/hqBSluoznnkk2fw0K/WRO
	TQxHMm9mcnsmSY8E2PKq1suCM3PTg7eh61zOFB+ADM6XML1UqjUw5ip31/3DBfJoaYvCQyZ
	DzQ+XeN4xqNFjYLdKWE96aarmCXjGw0zsJziqd0N6EVa2cSeETu9Gt483WbCWDBmEpx3ZrH
	5lTdAqQ30WCY42bwUTyFWJOLm2vb+XAKog555qzM0t2truj5TjFFhsRkVeHCy87r9ZA0YJj
	cZIvMfIY0Fnq0Vm5Y8bm0QpGBdYdj4CAfjCgS7HvqMwSBs3mjtZgTSSEHsxWJiBqY47VL6n
	XPSHKsNM5kvJPNGCfyLJtBSiZeRnKAXX42ADm3N8m0+pUZ2YC0O5Gs8AtCtCgX+8bVrgab4
	AfICKOISuFJUvYlsKn1Z6Y9wAHj51u2VI6FkD7J8fXiuX5yMnq+gKsMgoyfYoT+9clXEoZa
	qPlh75/DvVWcpRbkb+srbjyfTlBKKNhyOieXtByawKz9xf/4aBZdo3CyvKXXY+0f4aZy6R8
	ZKv7e35VAV8wfxqeo3nSPe8KJvE8xuzRMyjynUlWqnao6glrplKfCnUYIRP/Yqw6U21Y1r4
	3Dac/N4N4RE4LvUKRD8vrQmk3xfKCeOxruFg6Bfb66u924K296BJF0Sly0yUwwhhoW/RQdL
	qiKTr37kt9nYu7VSWHhIcgkmlmumSOwJ3AzMgOCCQfE2eKKuChirJnjKLS8f+t9Iw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
index da4d9e229c9e..e5a45356ba00 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3148,7 +3148,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 	netdev->features = features;
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_RX && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
 		wx_set_rx_mode(netdev);
 
@@ -3198,7 +3198,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 
 out:
 	if (need_reset && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 75d74ca2e259..a8b4e84787f4 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1408,7 +1408,7 @@ struct wx {
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

