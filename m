Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21EE339708
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520586; cv=none; b=P5eiZujMZJ0NtKyHt/vXZ8KRzmdorinTZ1+kCcVNR4/wZ/8HpYCrg0jXwBW8kgvN2UaWxvyWNta7zM0rWj5nvu5Z+8B2GiffZl+1JYPQuFF0UmCKB4eC6wHzPczXkUQijGCxXBXI6m24igIqWQhTu/Mz9diyoud83xuL9Xyl5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520586; c=relaxed/simple;
	bh=JxnRAz7OtvaeNZPxtRVItUXeAAiiWPxZ+RD4Bm6JIG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXlC2GvI/GjiIePZOCuxLmy4QDet4fMxGLyNlvsr6H2DUC9JcA/nwLvyQIqQd2d0K8Wt3WWR/HPmP1lyruDHgNUOdRcvGMVw0EcYanM2aFjpFXbYRVTwCjHyVD7hMQxc6D2bMs2p0sIsHSonT2R0NT3/mzozPKMiE3T+gW4Jf5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz19t1781520535tfd0ebba6
X-QQ-Originating-IP: kNzVaWrdo9bINvgVuIgIhRDM2v9oDwb/JTv68U3la70=
Received: from localhost.localdomain ( [183.157.22.210])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jun 2026 18:48:54 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16052921178100567940
EX-QQ-RecipientCnt: 7
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v5 1/3] net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
Date: Mon, 15 Jun 2026 18:48:47 +0800
Message-Id: <20260615104849.60444-2-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260615104849.60444-1-mengyuanlou@net-swift.com>
References: <20260615104849.60444-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NmMZBlsNL+IVKrOROgNvMYwfUL/sVv+Vk4PBlBkL06nRCZXqWjQ15+PV
	Hl+TXkXsGhtHz422Sr6rXCoS+jdX/O2Nl11Cwv+2J6NrnEUNu83AG00hD59dmRxTsaTv6qM
	I+9wou01MrWgQR5hjInXMsrAfw8vpN6J4xF2l2W0yM9JDaxGMk3U3mrx6ZTW3r/au5dhs/5
	7fvIZiBO2v3Gks6C5e0fSBkGT1+jzGJiXFDE+IRSMgOS9VjnNhyoPKfYAWnMkA6mjcJpcG6
	W4u2SDj3hPfJlsM8i+l91o4r8JLtZGfWgta6gWf1/EFrqPiJD0HQlJJmCwoPD9H7OOXSoT4
	Y6bWGL6fMOwzn5JOycHasdPTgS6rO/QbWfKNrvWZbbaZpbleC2tirCe+nMcdZyL45RYBRja
	8jEaOeDWAvXP7FOn/wp6bQxbXMuXFhyHX4tVtXgRSZIPpMqwyUq4dra8r5TzKHEvo+MEn90
	TPIIbOuVmj0T/CSLY3VExb8p7yvSNapwwazYX12j6iuQ/EnR0T06rpID5CoR+IccJBwA+i0
	T3yS+3xRChZIDCRX7RDlSo35yjfQzt8CJNkKg9kEPuAeG77PPX/OuloCaYLYJK6NAm0NIab
	ha3ai+lSdHzluqbac5BgQ1PbE3UQzYH7ZFQud958WR6NkQx/ATcjBBCaj6nRnZshvjShpSm
	iQ39GshJLp3o1EHSsL991u0X340YL3blhqvq9ul1nTYavqLSbUOd2DqDBqGofVyAWZzQM6d
	ot7kzDikxutbAMwIA2sfeEJ+sWs+kmrjf/BqXur2oOXu6KknwHWnVaNdCiVFo49xuc/GC3V
	oa5IVn8kTOiqDhFfCw8V+mFrDUzVhdyNVOwAQpPX/tOLUh0/yFMhnP9cljJQdTtYvtmI1nY
	hZMpsmF9hc1h1aeRrp6LwymJVed0VKdGTnwW9HvCa8GkBLO5IK8wDUttPbfAXzuWy80NZ+w
	8Oa+BAP/BtRWZf3Vhr5USluo5mljakjd3lmYiDOdS0CP221C0ZtCI82bIGk/ZAUUsifBO/9
	lQ2D3YQG8yMBq6FICBIAKgZ0I6tUDN/NBQB2nxgkSVbAOVFN+3yKg6sjpJRx8iuYMLg710+
	LSgR+1PmXy+zIxW7s+xutFRnarvgNopI0QR+6tatIkrvmMWeph2VOZ9cpt0a48rDlRpa5ji
	hXAQUb50THEvTx62qeAT7jC8DA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Add support for the set_ringparam in wx_ethtool_ops_vf,
which is used to set ring sizes for ngbevf and txgbevf.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 60 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  9 +--
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  4 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  4 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |  2 +
 5 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 5df971aca9e3..6d8fcddde6fa 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -9,6 +9,7 @@
 #include "wx_ethtool.h"
 #include "wx_hw.h"
 #include "wx_lib.h"
+#include "wx_vf_common.h"
 
 struct wx_stats {
 	char stat_string[ETH_GSTRING_LEN];
@@ -775,6 +776,64 @@ static int wx_get_link_ksettings_vf(struct net_device *netdev,
 	return 0;
 }
 
+static int wx_set_ringparam_vf(struct net_device *netdev,
+			       struct ethtool_ringparam *ring,
+			       struct kernel_ethtool_ringparam *kernel_ring,
+			       struct netlink_ext_ack *extack)
+{
+	struct wx *wx = netdev_priv(netdev);
+	u32 new_rx_count, new_tx_count;
+	struct wx_ring *temp_ring;
+	int i, err = 0;
+
+	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
+	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
+
+	new_rx_count = clamp_t(u32, ring->rx_pending, WX_MIN_RXD, WX_MAX_RXD);
+	new_rx_count = ALIGN(new_rx_count, WX_REQ_RX_DESCRIPTOR_MULTIPLE);
+
+	if (new_tx_count == wx->tx_ring_count &&
+	    new_rx_count == wx->rx_ring_count)
+		return 0;
+
+	mutex_lock(&wx->reset_lock);
+	set_bit(WX_STATE_RESETTING, wx->state);
+
+	if (!netif_running(wx->netdev)) {
+		for (i = 0; i < wx->num_tx_queues; i++)
+			wx->tx_ring[i]->count = new_tx_count;
+		for (i = 0; i < wx->num_rx_queues; i++)
+			wx->rx_ring[i]->count = new_rx_count;
+		wx->tx_ring_count = new_tx_count;
+		wx->rx_ring_count = new_rx_count;
+
+		goto clear_reset;
+	}
+
+	/* allocate temporary buffer to store rings in */
+	i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
+	temp_ring = kvmalloc_objs(struct wx_ring, i);
+	if (!temp_ring) {
+		err = -ENOMEM;
+		goto clear_reset;
+	}
+
+	wxvf_down(wx);
+	/* When set_ring fails, the count will not be updated.
+	 * It merely notifies that there is an error in the setting.
+	 */
+	err = wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
+	if (err)
+		wx_err(wx, "failed to set ring parameters: %d", err);
+	wx_configure_vf(wx);
+	wxvf_up_complete(wx);
+	kvfree(temp_ring);
+clear_reset:
+	clear_bit(WX_STATE_RESETTING, wx->state);
+	mutex_unlock(&wx->reset_lock);
+	return err;
+}
+
 static const struct ethtool_ops wx_ethtool_ops_vf = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
@@ -782,6 +841,7 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
 	.get_drvinfo		= wx_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_ringparam		= wx_get_ringparam,
+	.set_ringparam		= wx_set_ringparam_vf,
 	.get_msglevel		= wx_get_msglevel,
 	.get_coalesce		= wx_get_coalesce,
 	.get_ts_info		= ethtool_op_get_ts_info,
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index d042567b8128..2e5dba88d04a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3248,8 +3248,8 @@ netdev_features_t wx_features_check(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(wx_features_check);
 
-void wx_set_ring(struct wx *wx, u32 new_tx_count,
-		 u32 new_rx_count, struct wx_ring *temp_ring)
+int wx_set_ring(struct wx *wx, u32 new_tx_count,
+		u32 new_rx_count, struct wx_ring *temp_ring)
 {
 	int i, err = 0;
 
@@ -3271,7 +3271,7 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
 					i--;
 					wx_free_tx_resources(&temp_ring[i]);
 				}
-				return;
+				return err;
 			}
 		}
 
@@ -3299,7 +3299,7 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
 					i--;
 					wx_free_rx_resources(&temp_ring[i]);
 				}
-				return;
+				return err;
 			}
 		}
 
@@ -3311,6 +3311,7 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
 
 		wx->rx_ring_count = new_rx_count;
 	}
+	return 0;
 }
 EXPORT_SYMBOL(wx_set_ring);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index aed6ea8cf0d6..bc671786978e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -36,8 +36,8 @@ netdev_features_t wx_fix_features(struct net_device *netdev,
 netdev_features_t wx_features_check(struct sk_buff *skb,
 				    struct net_device *netdev,
 				    netdev_features_t features);
-void wx_set_ring(struct wx *wx, u32 new_tx_count,
-		 u32 new_rx_count, struct wx_ring *temp_ring);
+int wx_set_ring(struct wx *wx, u32 new_tx_count,
+		u32 new_rx_count, struct wx_ring *temp_ring);
 void wx_service_event_schedule(struct wx *wx);
 void wx_service_event_complete(struct wx *wx);
 void wx_service_timer(struct timer_list *t);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 0d2db8d38cd5..26de78e9a69e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -269,7 +269,7 @@ static void wxvf_irq_enable(struct wx *wx)
 	wr32(wx, WX_VXIMC, wx->eims_enable_mask);
 }
 
-static void wxvf_up_complete(struct wx *wx)
+void wxvf_up_complete(struct wx *wx)
 {
 	/* Always set the carrier off */
 	netif_carrier_off(wx->netdev);
@@ -324,7 +324,7 @@ int wxvf_open(struct net_device *netdev)
 }
 EXPORT_SYMBOL(wxvf_open);
 
-static void wxvf_down(struct wx *wx)
+void wxvf_down(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
index cbbb1b178cb2..d45d5d8ac3ab 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
@@ -15,7 +15,9 @@ void wx_set_rx_mode_vf(struct net_device *netdev);
 void wx_configure_vf(struct wx *wx);
 int wx_set_mac_vf(struct net_device *netdev, void *p);
 void wxvf_watchdog_update_link(struct wx *wx);
+void wxvf_up_complete(struct wx *wx);
 int wxvf_open(struct net_device *netdev);
+void wxvf_down(struct wx *wx);
 int wxvf_close(struct net_device *netdev);
 void wxvf_init_service(struct wx *wx);
 
-- 
2.30.1

