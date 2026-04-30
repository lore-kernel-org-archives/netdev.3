Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47638E106
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777537583; cv=none; b=sAsod5rj8yW+IpFaHB4hyzVV0qt0orLqN3bEGRaHsPe7CsIkAViDN4wxCpzgyi4VYOsNgMK7EoPwnw5Zzc3LVf5uerP3+u5eyjV/e3EJspw4tLyfEJVLr4kH13cQKgnJwD7IA11w8VZlVDhHD8nI1yda6rzZHhdcLxhHI4ivMGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777537583; c=relaxed/simple;
	bh=3ttgY54Y06n6a+E6TSpY2jtVULuvPfpeSWEMy2d5X34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qWoEIuetORmKA6Dj74aHe3NHMD4zwbT0zUtugcKTHvgBXsBLVzAd6rDu5F7CU0RgsFtNzDHIkXPqyqOOu92VNR4hLFXseAxxl4nmAE42ZMjixEdOEnWOiS7F5fQ2vTIiFjQrDCmb1fvcie/+t+dHDPkUShDD1+k4CblAddUGgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz3t1777537549t80fd85e8
X-QQ-Originating-IP: w+NiPAKrzKENjp0/owPX4iY9Jw1sTy+HTuvIYCxXfVY=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.155.141])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Apr 2026 16:25:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18398262836713543251
EX-QQ-RecipientCnt: 17
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
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Joe Damato <joe@dama.to>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 3/6] net: wangxun: add reinit parameter to wx->do_reset callback
Date: Thu, 30 Apr 2026 16:25:14 +0800
Message-Id: <20260430082517.19612-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260430082517.19612-1-jiawenwu@trustnetic.com>
References: <20260430082517.19612-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OVFdYp27KdlJiUtWu9ev3M+RznV4DvUBPYn0vNlrxKDoE5DCiZxF9GLA
	36vANcw9R9Zsrqa1Hf2at8wqOGqYjbtQjzRu+8rDGdPU6+WDq3qU9Tg0RxViJ/WnbmEpJQJ
	TAjELN5iED/KNFifzzFn5Cqs8FKWxuNd4hILoT5GjEd2GbCTskUxgWP/E9HEIXUpNP362eT
	YRNlY9PSZEu64x1DTSRBhc7Z8N+nY0tqYWx3avxzOXf6Ji3jFfIMOBf+WG6BtkqlJlEuHSb
	nkLH365ZNmQEXwLi1ruJNfQKiv0gaY/GKSFwwgU/xXMiJzsLqIZxYvFHOA9gASzeW7jdvej
	YKFc79EtokwfolH3osrTTTDNKV1w9KtH/Vago1GqSyZzFI5X87psm6yOUooGzHgCXG2qXQ6
	fkxoAWQU0wAIvW0DuTo6BpiAkQtLI9boTJtOM9LbGWGtTNQpt5+VWT2dhZrmkHkzi7JFfrI
	3iNsBD5zYQ9KHPNpUXVBSkwLH3kQS5tKjOcYmtyH9hwmvL/G7ahLMhfSqzl4dGO2ei+tkLA
	sVHJxvHz0Bylr5wANe12+hTsJF+6Vt2cMjhlgzYDhwdJm5cH8bLtOcqa2s5haz6k/8jwcXu
	/0YRuZtl0lJSC5MJTGec8zmv9fSYv5IHWOcq0JnMz96DKlwTxnQW0HTm3YahB24I1obaOGe
	U/a/EmFUQ8iiaoMSdZYR/bgC3AVAMATijtA6oFC1I1LR8FCDhFWZpdcmBF3Du1qdSh4PbyX
	Jwk47v0clCGZDhlGTiuR4ZBcEmRc0cty1RCNs4gD5Gd3r6px3cHUlokt1jr/oLh5Z+EfKJ2
	hpp2F9lsZGOqXT6lmTCTrHnw8xkksF+GwuW8TQLskGuwr49c55Vf4rbk2ABNK/TFh6wW5MM
	iS2ItOBoxw3TqQ+gmiE27EjkLVDlyQ57zgYMaOqZ5odGHmVZTrQbLBNXlktwRtLmBpmajzI
	Pyary37zP/sMxaPVoxXAA0GKzfWIHrSh1m/LYavHLPvtiz8O1HCL2PTr6CCF7LtOXLkrkwR
	t6aFyl/Ron7zr34nP5sVDP/YCLUfssDUViG7MjAptq6fpRXUSlT/yEEZqYZvil3zs6Zk6GX
	4xkxi9dowUd
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

To implement a simple hardware reset without tearing down the network
interface state, introduce a boolean 'reinit' parameter to wx->do_reset
callback.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
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
index ba5f23cefc0f..124011c3d5b1 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -23,7 +23,7 @@ static void wx_reset_subtask(struct wx *wx)
 
 	if (test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags)) {
 		if (wx->do_reset)
-			wx->do_reset(wx->netdev);
+			wx->do_reset(wx->netdev, true);
 	}
 
 out:
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
index 9e6167b43f75..3216dee778be 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3146,7 +3146,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 	netdev->features = features;
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_RX && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
 		wx_set_rx_mode(netdev);
 
@@ -3196,7 +3196,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 
 out:
 	if (need_reset && wx->do_reset)
-		wx->do_reset(netdev);
+		wx->do_reset(netdev, true);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index f65c2d7bae39..671ac0a19dee 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1402,7 +1402,7 @@ struct wx {
 	void (*atr)(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype);
 	void (*configure_fdir)(struct wx *wx);
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
-	void (*do_reset)(struct net_device *netdev);
+	void (*do_reset)(struct net_device *netdev, bool reinit);
 	int (*ptp_setup_sdp)(struct wx *wx);
 	void (*set_num_queues)(struct wx *wx);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index e9561996b970..ec14dd47cd42 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -629,11 +629,11 @@ static void ngbe_reinit_locked(struct wx *wx)
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
index 5793da5b7bab..9887638203cb 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -613,11 +613,11 @@ static void txgbe_reinit_locked(struct wx *wx)
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
index 6b05f32b4a01..1e373f7fd9b5 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -313,7 +313,7 @@ extern char txgbe_driver_name[];
 void txgbe_down(struct wx *wx);
 void txgbe_up(struct wx *wx);
 int txgbe_setup_tc(struct net_device *dev, u8 tc);
-void txgbe_do_reset(struct net_device *netdev);
+void txgbe_do_reset(struct net_device *netdev, bool reinit);
 
 #define TXGBE_LINK_SPEED_UNKNOWN        0
 #define TXGBE_LINK_SPEED_10GB_FULL      4
-- 
2.51.0

