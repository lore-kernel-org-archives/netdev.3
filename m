Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ACE3DB964;
	Mon, 27 Jul 2026 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135329; cv=none; b=gQ8wlWS1Jr51v3VSMa+01FJbr33svNd1AWcNnr54YBj/ALnBP9h4m+uNykVrIXyjiURd0/6tIKWZab/2SXs4lX4u7bTddrU0+XFK2Wgqcn+QNyPuaGUtP1r62VB6QING/9dhfyKu0EldM4LNTPR0rjJf50O2Wim7IzwjxL4NKuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135329; c=relaxed/simple;
	bh=CSJ/zf6ZYadL66yDFlytOm304QZZnlQp/8v32vytLP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RoqpwfvjqXzh05XZLcQfJkXIhhn/qWtBvmMBYIgjBVSH/BVnwz/FAfuyR7HSTXx5JYjRekZOXchcvK3Dqvuc4BPpeBMyPDEy17modvwbo1b9ms8ymaxnXrxxNHV7bVk3o4pGVz2OjjIUetLmbr8ItT2OJJKCReaDvBZKXajSbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QIs8TWdZ; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QIs8TWdZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dp3jqARcUUhP2fB+HBy0pIO1oL9JhNhgumWYqfb9w5U=;
	b=QIs8TWdZCmt/lAJpVtxgoIpwAeWdX+It5brxHs0N1suWeHXEusIQzAKWflIkGeJcgDzhUE2W0
	Wtq7r3mpGS3kWArS0MY6sGIT9XzvT4cceyNTvwyjck5LrJjTyDDbC4d2ERND5DQ3yZdLQEVCYru
	ZfEmlaGprnNIhI7eltr9opQ=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h7pyC1nnDzcb0W;
	Mon, 27 Jul 2026 14:45:39 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id EA51540579;
	Mon, 27 Jul 2026 14:55:16 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 27 Jul 2026 14:55:15 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri
 Daskalakis <dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Chen Anwen
	<chenanwen@huawei.com>, He Wei <august.hewei@huawei.com>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v12 4/8] hinic3: Add ethtool queue ops
Date: Mon, 27 Jul 2026 14:54:55 +0800
Message-ID: <883469097c9de10080b1f607d99764480354c4c8.1785120952.git.root@localhost.localdomain>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1785120952.git.root@localhost.localdomain>
References: <cover.1785120952.git.root@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

hinic3: Add ethtool queue ops

  Implement following ethtool callback function:
.get_ringparam
.set_ringparam

  These callbacks allow users to utilize ethtool for detailed
queue depth configuration and monitoring.

  Change port_state_mutex to state_lock as a unified mutex lock
in hinic3_nic_dev.

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 91 +++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |  2 +-
 .../huawei/hinic3/hinic3_netdev_ops.c         | 82 ++++++++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   | 11 ++-
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |  4 +
 5 files changed, 185 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index 90fc16288de9..e6dff46a0d00 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -9,6 +9,7 @@
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/ethtool.h>
 
 #include "hinic3_lld.h"
@@ -409,6 +410,94 @@ hinic3_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
+static void hinic3_get_ringparam(struct net_device *netdev,
+				 struct ethtool_ringparam *ring,
+				 struct kernel_ethtool_ringparam *kernel_ring,
+				 struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	ring->rx_max_pending = HINIC3_MAX_RX_QUEUE_DEPTH;
+	ring->tx_max_pending = HINIC3_MAX_TX_QUEUE_DEPTH;
+	ring->rx_pending = nic_dev->q_params.rq_depth;
+	ring->tx_pending = nic_dev->q_params.sq_depth;
+}
+
+static void hinic3_update_qp_depth(struct net_device *netdev,
+				   u32 sq_depth, u32 rq_depth)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 i;
+
+	nic_dev->q_params.sq_depth = sq_depth;
+	nic_dev->q_params.rq_depth = rq_depth;
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		nic_dev->txqs[i].q_depth = sq_depth;
+		nic_dev->txqs[i].q_mask = sq_depth - 1;
+		nic_dev->rxqs[i].q_depth = rq_depth;
+		nic_dev->rxqs[i].q_mask = rq_depth - 1;
+	}
+}
+
+static int hinic3_check_ringparam_valid(struct net_device *netdev,
+					const struct ethtool_ringparam *ring,
+					struct netlink_ext_ack *extack)
+{
+	if (ring->tx_pending < HINIC3_MIN_QUEUE_DEPTH ||
+	    ring->rx_pending < HINIC3_MIN_QUEUE_DEPTH) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Queue depth underflow[%d]: tx[%d], rx[%d]",
+				       HINIC3_MIN_QUEUE_DEPTH,
+				       ring->tx_pending, ring->rx_pending);
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_set_ringparam(struct net_device *netdev,
+				struct ethtool_ringparam *ring,
+				struct kernel_ethtool_ringparam *kernel_ring,
+				struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_txrxq_params q_params = {};
+	u32 new_sq_depth, new_rq_depth;
+	int err;
+
+	err = hinic3_check_ringparam_valid(netdev, ring, extack);
+	if (err)
+		return err;
+
+	new_sq_depth = rounddown_pow_of_two(ring->tx_pending);
+	new_rq_depth = rounddown_pow_of_two(ring->rx_pending);
+	if (new_sq_depth == nic_dev->q_params.sq_depth &&
+	    new_rq_depth == nic_dev->q_params.rq_depth)
+		return 0;
+
+	if (new_sq_depth != ring->tx_pending ||
+	    new_rq_depth != ring->rx_pending)
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Requested Tx/Rx ring depth %u/%u trimmed to %u/%u",
+				       ring->tx_pending, ring->rx_pending,
+				       new_sq_depth, new_rq_depth);
+
+	if (!netif_running(netdev)) {
+		hinic3_update_qp_depth(netdev, new_sq_depth, new_rq_depth);
+	} else {
+		q_params = nic_dev->q_params;
+		q_params.sq_depth = new_sq_depth;
+		q_params.rq_depth = new_rq_depth;
+
+		err = hinic3_change_channel_settings(netdev, &q_params);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static const struct ethtool_ops hinic3_ethtool_ops = {
 	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
 					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
@@ -417,6 +506,8 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
 	.get_msglevel                   = hinic3_get_msglevel,
 	.set_msglevel                   = hinic3_set_msglevel,
 	.get_link                       = ethtool_op_get_link,
+	.get_ringparam                  = hinic3_get_ringparam,
+	.set_ringparam                  = hinic3_set_ringparam,
 };
 
 void hinic3_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 0a888fe4c975..513dc02946c3 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -178,7 +178,7 @@ static int hinic3_sw_init(struct net_device *netdev)
 	u8 mac_addr[ETH_ALEN];
 	int err;
 
-	mutex_init(&nic_dev->port_state_mutex);
+	mutex_init(&nic_dev->state_lock);
 
 	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
 	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index def671abf064..c6af1983f08b 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -356,9 +356,7 @@ static int hinic3_maybe_set_port_state(struct net_device *netdev, bool enable)
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 	int err;
 
-	mutex_lock(&nic_dev->port_state_mutex);
 	err = hinic3_set_port_enable(nic_dev->hwdev, enable);
-	mutex_unlock(&nic_dev->port_state_mutex);
 
 	return err;
 }
@@ -443,6 +441,82 @@ static void hinic3_vport_down(struct net_device *netdev)
 	}
 }
 
+int hinic3_change_channel_settings(struct net_device *netdev,
+				   struct hinic3_dyna_txrxq_params *trxq_params)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_txrxq_params cur_trxq_params = {};
+	struct hinic3_dyna_qp_params new_qp_params = {};
+	struct hinic3_dyna_qp_params cur_qp_params = {};
+	int err;
+
+	mutex_lock(&nic_dev->state_lock);
+	cur_trxq_params = nic_dev->q_params;
+
+	hinic3_config_num_qps(netdev, trxq_params);
+
+	err = hinic3_alloc_channel_resources(netdev, &new_qp_params,
+					     trxq_params);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc channel resources\n");
+		if (trxq_params->num_qps > cur_trxq_params.num_qps)
+			hinic3_qp_irq_change(netdev, cur_trxq_params.num_qps);
+		hinic3_config_num_qps(netdev, &cur_trxq_params);
+		mutex_unlock(&nic_dev->state_lock);
+		return err;
+	}
+
+	hinic3_vport_down(netdev);
+	hinic3_close_channel(netdev);
+	hinic3_get_cur_qps(nic_dev, &cur_qp_params);
+
+	hinic3_init_qps(nic_dev, &new_qp_params);
+
+	err = hinic3_prepare_channel(netdev, trxq_params);
+	if (err)
+		goto err_uninit_qps;
+
+	err = hinic3_open_channel(netdev);
+	if (err)
+		goto err_open_channel;
+
+	err = hinic3_vport_up(netdev);
+	if (err)
+		goto err_vport_up;
+
+	if (nic_dev->num_qp_irq > trxq_params->num_qps)
+		hinic3_qp_irq_change(netdev, trxq_params->num_qps);
+
+	nic_dev->q_params = *trxq_params;
+
+	hinic3_free_channel_resources(netdev, &cur_qp_params, &cur_trxq_params);
+
+	mutex_unlock(&nic_dev->state_lock);
+
+	return 0;
+
+err_vport_up:
+	hinic3_close_channel(netdev);
+err_open_channel:
+	if (trxq_params->num_qps > cur_trxq_params.num_qps)
+		hinic3_qp_irq_change(netdev, cur_trxq_params.num_qps);
+err_uninit_qps:
+	hinic3_get_cur_qps(nic_dev, &new_qp_params);
+	hinic3_config_num_qps(netdev, &cur_trxq_params);
+	hinic3_init_qps(nic_dev, &cur_qp_params);
+
+	if (hinic3_prepare_channel(netdev, &cur_trxq_params) ||
+	    hinic3_open_channel(netdev) || hinic3_vport_up(netdev)) {
+		netdev_err(netdev, "Failed to restore old channel, interface is down\n");
+		clear_bit(HINIC3_INTF_UP, &nic_dev->flags);
+	}
+
+	hinic3_free_channel_resources(netdev, &new_qp_params, trxq_params);
+	mutex_unlock(&nic_dev->state_lock);
+
+	return err;
+}
+
 static int hinic3_open(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -512,10 +586,14 @@ static int hinic3_close(struct net_device *netdev)
 		return 0;
 	}
 
+	mutex_lock(&nic_dev->state_lock);
 	hinic3_vport_down(netdev);
 	hinic3_close_channel(netdev);
 	hinic3_get_cur_qps(nic_dev, &qp_params);
 	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
+	hinic3_free_nicio_res(nic_dev);
+	hinic3_destroy_num_qps(netdev);
+	mutex_unlock(&nic_dev->state_lock);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 9502293ff710..ccef82d57fdd 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -10,6 +10,9 @@
 #include "hinic3_hw_cfg.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_mgmt_interface.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_tx.h"
+#include "hinic3_rx.h"
 
 #define HINIC3_VLAN_BITMAP_BYTE_SIZE(nic_dev)  (sizeof(*(nic_dev)->vlan_bitmap))
 #define HINIC3_VLAN_BITMAP_SIZE(nic_dev)  \
@@ -127,8 +130,8 @@ struct hinic3_nic_dev {
 	struct workqueue_struct         *workq;
 	struct delayed_work             periodic_work;
 	struct work_struct              rx_mode_work;
-	/* lock for enable/disable port */
-	struct mutex                    port_state_mutex;
+	/* Protects Interface state */
+	struct mutex                    state_lock;
 
 	struct list_head                uc_filter_list;
 	struct list_head                mc_filter_list;
@@ -143,6 +146,10 @@ struct hinic3_nic_dev {
 
 void hinic3_set_netdev_ops(struct net_device *netdev);
 int hinic3_set_hw_features(struct net_device *netdev);
+int
+hinic3_change_channel_settings(struct net_device *netdev,
+			       struct hinic3_dyna_txrxq_params *trxq_params);
+
 int hinic3_qps_irq_init(struct net_device *netdev);
 void hinic3_qps_irq_uninit(struct net_device *netdev);
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
index cd33f197216f..571b34d63950 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
@@ -14,6 +14,10 @@ struct hinic3_nic_dev;
 #define HINIC3_RQ_WQEBB_SHIFT      3
 #define HINIC3_SQ_WQEBB_SIZE       BIT(HINIC3_SQ_WQEBB_SHIFT)
 
+#define HINIC3_MAX_TX_QUEUE_DEPTH  65536
+#define HINIC3_MAX_RX_QUEUE_DEPTH  16384
+#define HINIC3_MIN_QUEUE_DEPTH     128
+
 /* ******************** RQ_CTRL ******************** */
 enum hinic3_rq_wqe_type {
 	HINIC3_NORMAL_RQ_WQE = 1,
-- 
2.54.0

