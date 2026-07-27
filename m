Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3D53DB63C;
	Mon, 27 Jul 2026 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135328; cv=none; b=u4NT17PCgglsjSZLOpibVwtUjrlOTeHCluPh3cXiGHNUYZU4cVz/FqEuQLgGcxuHbKCzIQw4qbSSW0lbXwqxBUtLRZZa27145VAUASlEEhp0kg9MZLjNXBG3Lvz/PviIizki547Cr6+lTXZQFtvvfXolXmwb6MH4n0W43u2PeTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135328; c=relaxed/simple;
	bh=gCNf45kXXMEFvB1AkIRUfsnUnp/BHBAQVeTWs87Vovw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4bMJmJQENseU+Ic8bEOpyGEgiUimUHs+vwaogQbxD2yIbt0DrX5UegpnkdXQNAxkCz12494OPEyRd5rB0npoUJKsudSiciXkMJlawh4Q7MrNRHekv6kQfDDk0BhvfDOn0oZ2vYwxWyeQgIttu2b+u19zzVHzNoQswIjgPTKlok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XTVi89LX; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XTVi89LX"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qHUwMmx2x1+qWPEC7/1Ar7HFQDlgMfAus+CKwB+hJDg=;
	b=XTVi89LXJVfWpSWmRR4knuihWTSSJzM20kp9v22JI2/e/Hq5TXc/KLrizymZ5Ge5FVwyYplIv
	BP2Bb+D51YRf3ZvkUu/FaQIrqonUoCfGuHm0co7J7j0Fe0ixrgeHx+wBB/DhTIwVKJ1LIHuIe/S
	WWU/L6smHhEe9/L+SeZSiIM=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4h7pyX3RRfz1cyTD;
	Mon, 27 Jul 2026 14:45:56 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id B8BF440565;
	Mon, 27 Jul 2026 14:55:20 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 27 Jul 2026 14:55:19 +0800
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
Subject: [PATCH net-next v12 6/8] hinic3: Add ethtool coalesce ops
Date: Mon, 27 Jul 2026 14:54:57 +0800
Message-ID: <e34c01c323b46ded4a462548821677972a47c41e.1785120952.git.root@localhost.localdomain>
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

  Implement following ethtool callback function:
.get_coalesce
.set_coalesce

  These callbacks allow users to utilize ethtool for detailed
RX coalesce configuration and monitoring.

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 322 +++++++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |   2 +-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |   2 +-
 3 files changed, 322 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index b34af9b3ef9b..4177aed877ab 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -18,6 +18,11 @@
 #include "hinic3_nic_cfg.h"
 
 #define HINIC3_MGMT_VERSION_MAX_LEN     32
+/* Coalesce time properties in microseconds */
+#define COALESCE_PENDING_LIMIT_UNIT     8
+#define COALESCE_TIMER_CFG_UNIT         5
+#define COALESCE_MAX_PENDING_LIMIT      (255 * COALESCE_PENDING_LIMIT_UNIT)
+#define COALESCE_MAX_TIMER_CFG          (255 * COALESCE_TIMER_CFG_UNIT)
 
 static void hinic3_get_drvinfo(struct net_device *netdev,
 			       struct ethtool_drvinfo *info)
@@ -961,9 +966,320 @@ static void hinic3_get_pause_stats(struct net_device *netdev,
 	kfree(ps);
 }
 
+static int hinic3_set_queue_coalesce(struct net_device *netdev, u16 q_id,
+				     struct hinic3_intr_coal_info *coal,
+				     struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *intr_coal;
+	struct hinic3_interrupt_info info = {};
+	bool is_active;
+	int err;
+
+	mutex_lock(&nic_dev->state_lock);
+	is_active = test_bit(HINIC3_INTF_UP, &nic_dev->flags) &&
+		    (q_id < nic_dev->q_params.num_qps);
+
+	if (is_active) {
+		info.msix_index =
+			nic_dev->q_params.irq_cfg[q_id].msix_entry_idx;
+		info.resend_timer_cfg =
+			nic_dev->intr_coalesce[q_id].resend_timer_cfg;
+	}
+	mutex_unlock(&nic_dev->state_lock);
+
+	if (is_active) {
+		info.interrupt_coalesc_set = 1;
+		info.coalesc_timer_cfg = coal->coalesce_timer_cfg;
+		info.pending_limit = coal->pending_limit;
+
+		err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
+		if (err) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Failed to set queue%u coalesce",
+					       q_id);
+			return err;
+		}
+	}
+
+	mutex_lock(&nic_dev->state_lock);
+	intr_coal = &nic_dev->intr_coalesce[q_id];
+	intr_coal->coalesce_timer_cfg = coal->coalesce_timer_cfg;
+	intr_coal->pending_limit = coal->pending_limit;
+	intr_coal->rx_pending_limit_low = coal->rx_pending_limit_low;
+	intr_coal->rx_pending_limit_high = coal->rx_pending_limit_high;
+	mutex_unlock(&nic_dev->state_lock);
+
+	return 0;
+}
+
+static int is_coalesce_exceed_limit(const struct ethtool_coalesce *coal,
+				    struct netlink_ext_ack *extack)
+{
+	const struct {
+		const char *name;
+		u32 value;
+		u32 limit;
+	} coalesce_limits[] = {
+		{"rx_coalesce_usecs",
+		 coal->rx_coalesce_usecs,
+		 COALESCE_MAX_TIMER_CFG},
+		{"rx_max_coalesced_frames",
+		 coal->rx_max_coalesced_frames,
+		 COALESCE_MAX_PENDING_LIMIT},
+		{"rx_max_coalesced_frames_low",
+		 coal->rx_max_coalesced_frames_low,
+		 COALESCE_MAX_PENDING_LIMIT},
+		{"rx_max_coalesced_frames_high",
+		 coal->rx_max_coalesced_frames_high,
+		 COALESCE_MAX_PENDING_LIMIT},
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(coalesce_limits); i++) {
+		if (coalesce_limits[i].value > coalesce_limits[i].limit) {
+			NL_SET_ERR_MSG_FMT_MOD(extack, "%s out of range %d-%d",
+					       coalesce_limits[i].name, 0,
+					       coalesce_limits[i].limit);
+			return -ERANGE;
+		}
+	}
+	return 0;
+}
+
+static int hinic3_validate_coalesce(const struct ethtool_coalesce *coal,
+				    struct netlink_ext_ack *extack)
+{
+	int err;
+
+	err = is_coalesce_exceed_limit(coal, extack);
+	if (err)
+		return err;
+
+	if (coal->rx_max_coalesced_frames_low >
+	    coal->rx_max_coalesced_frames_high) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "invalid coalesce frame high %u, low %u",
+				       coal->rx_max_coalesced_frames_high,
+				       coal->rx_max_coalesced_frames_low);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+static void check_coalesce_align(struct net_device *netdev,
+				 u32 item, u32 unit, const char *str)
+{
+	if (item % unit)
+		netdev_warn(netdev, "%s in %d units, change to %u\n",
+			    str, unit, item - item % unit);
+}
+
+#define CHECK_COALESCE_ALIGN(member, unit) \
+	check_coalesce_align(netdev, member, unit, #member)
+
+static void check_coalesce_changed(struct net_device *netdev,
+				   u32 item, u32 unit, u32 ori_val,
+				   const char *obj_str, const char *str)
+{
+	if ((item / unit) != ori_val)
+		netdev_dbg(netdev, "Change %s from %d to %u %s\n",
+			   str, ori_val * unit, item - item % unit, obj_str);
+}
+
+#define CHECK_COALESCE_CHANGED(member, unit, ori_val, obj_str) \
+	check_coalesce_changed(netdev, member, unit, ori_val, obj_str, #member)
+
+static int hinic3_set_hw_coal_param(struct net_device *netdev,
+				    struct hinic3_intr_coal_info *intr_coal,
+				    struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *old_coal;
+	u16 i, j;
+	int err;
+
+	old_coal = kcalloc(nic_dev->max_qps, sizeof(*old_coal), GFP_KERNEL);
+	if (!old_coal)
+		return -ENOMEM;
+
+	mutex_lock(&nic_dev->state_lock);
+	for (i = 0; i < nic_dev->max_qps; i++)
+		old_coal[i] = nic_dev->intr_coalesce[i];
+	mutex_unlock(&nic_dev->state_lock);
+
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		err = hinic3_set_queue_coalesce(netdev, i, intr_coal, extack);
+		if (err)
+			goto rollback;
+	}
+
+	kfree(old_coal);
+	return 0;
+
+rollback:
+	for (j = 0; j < i; j++)
+		hinic3_set_queue_coalesce(netdev, j, &old_coal[j], NULL);
+
+	kfree(old_coal);
+	return err;
+}
+
+static int hinic3_get_coalesce(struct net_device *netdev,
+			       struct ethtool_coalesce *coal,
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *interrupt_info;
+
+	interrupt_info = &nic_dev->intr_coalesce[0];
+
+	coal->use_adaptive_rx_coalesce = READ_ONCE(nic_dev->adaptive_rx_coal);
+
+	mutex_lock(&nic_dev->state_lock);
+
+	coal->rx_max_coalesced_frames_low =
+		interrupt_info->rx_pending_limit_low *
+		COALESCE_PENDING_LIMIT_UNIT;
+
+	coal->rx_max_coalesced_frames_high =
+		interrupt_info->rx_pending_limit_high *
+		COALESCE_PENDING_LIMIT_UNIT;
+
+	/* TX/RX uses the same interrupt.
+	 * So we only declare RX ethtool_coalesce parameters.
+	 */
+	coal->rx_coalesce_usecs = interrupt_info->coalesce_timer_cfg *
+				  COALESCE_TIMER_CFG_UNIT;
+
+	coal->rx_max_coalesced_frames = interrupt_info->pending_limit *
+					COALESCE_PENDING_LIMIT_UNIT;
+
+	mutex_unlock(&nic_dev->state_lock);
+
+	return 0;
+}
+
+static int hinic3_set_coalesce(struct net_device *netdev,
+			       struct ethtool_coalesce *coal,
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *ori_intr_coal;
+	struct hinic3_intr_coal_info intr_coal = {};
+	const char *obj_str = "for netdev";
+	bool old_adaptive, new_adaptive;
+	struct hinic3_rxq *rxq = NULL;
+	bool dim_stopped = false;
+	int err;
+	int i;
+
+	err = hinic3_validate_coalesce(coal, extack);
+	if (err)
+		return err;
+
+	CHECK_COALESCE_ALIGN(coal->rx_coalesce_usecs, COALESCE_TIMER_CFG_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames,
+			     COALESCE_PENDING_LIMIT_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames_high,
+			     COALESCE_PENDING_LIMIT_UNIT);
+	CHECK_COALESCE_ALIGN(coal->rx_max_coalesced_frames_low,
+			     COALESCE_PENDING_LIMIT_UNIT);
+
+	ori_intr_coal = &nic_dev->intr_coalesce[0];
+
+	CHECK_COALESCE_CHANGED(coal->rx_coalesce_usecs, COALESCE_TIMER_CFG_UNIT,
+			       ori_intr_coal->coalesce_timer_cfg, obj_str);
+	CHECK_COALESCE_CHANGED(coal->rx_max_coalesced_frames,
+			       COALESCE_PENDING_LIMIT_UNIT,
+			       ori_intr_coal->pending_limit, obj_str);
+	CHECK_COALESCE_CHANGED(coal->rx_max_coalesced_frames_high,
+			       COALESCE_PENDING_LIMIT_UNIT,
+			       ori_intr_coal->rx_pending_limit_high, obj_str);
+	CHECK_COALESCE_CHANGED(coal->rx_max_coalesced_frames_low,
+			       COALESCE_PENDING_LIMIT_UNIT,
+			       ori_intr_coal->rx_pending_limit_low, obj_str);
+
+	old_adaptive = READ_ONCE(nic_dev->adaptive_rx_coal);
+	new_adaptive = !!coal->use_adaptive_rx_coalesce;
+
+	if (old_adaptive) {
+		bool is_up;
+
+		WRITE_ONCE(nic_dev->adaptive_rx_coal, false);
+
+		synchronize_net();
+
+		mutex_lock(&nic_dev->state_lock);
+		is_up = test_bit(HINIC3_INTF_UP, &nic_dev->flags);
+		mutex_unlock(&nic_dev->state_lock);
+
+		if (is_up) {
+			for (i = 0; i < nic_dev->q_params.num_qps; i++) {
+				if (!nic_dev->q_params.irq_cfg)
+					continue;
+
+				rxq = nic_dev->q_params.irq_cfg[i].rxq;
+				if (!rxq)
+					continue;
+
+				cancel_work_sync(&rxq->dim.work);
+
+				rxq->dim.state = DIM_START_MEASURE;
+				rxq->dim.profile_ix = 0;
+				rxq->dim.tune_state = 0;
+				rxq->dim.steps_right = 0;
+				rxq->dim.steps_left = 0;
+				rxq->dim.tired = 0;
+				memset(&rxq->dim.prev_stats, 0,
+				       sizeof(rxq->dim.prev_stats));
+			}
+
+			dim_stopped = true;
+		}
+	}
+
+	intr_coal.coalesce_timer_cfg =
+		(u8)(coal->rx_coalesce_usecs / COALESCE_TIMER_CFG_UNIT);
+
+	intr_coal.pending_limit =
+		(u8)(coal->rx_max_coalesced_frames /
+		     COALESCE_PENDING_LIMIT_UNIT);
+
+	intr_coal.rx_pending_limit_high =
+		(u8)(coal->rx_max_coalesced_frames_high /
+		     COALESCE_PENDING_LIMIT_UNIT);
+
+	intr_coal.rx_pending_limit_low =
+		(u8)(coal->rx_max_coalesced_frames_low /
+		     COALESCE_PENDING_LIMIT_UNIT);
+
+	/* coalesce timer or pending set to zero will disable coalesce */
+	if (!new_adaptive &&
+	    (!intr_coal.coalesce_timer_cfg || !intr_coal.pending_limit))
+		netdev_info(netdev, "Coalesce will be disabled\n");
+
+	err = hinic3_set_hw_coal_param(netdev, &intr_coal, extack);
+	if (err) {
+		if (dim_stopped)
+			WRITE_ONCE(nic_dev->adaptive_rx_coal, old_adaptive);
+
+		return err;
+	}
+
+	WRITE_ONCE(nic_dev->adaptive_rx_coal, new_adaptive);
+
+	return 0;
+}
+
 static const struct ethtool_ops hinic3_ethtool_ops = {
-	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
-					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
+	.supported_coalesce_params      = ETHTOOL_COALESCE_RX_USECS |
+					  ETHTOOL_COALESCE_RX_MAX_FRAMES |
+					  ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
+					  ETHTOOL_COALESCE_RX_MAX_FRAMES_LOW |
+					  ETHTOOL_COALESCE_RX_MAX_FRAMES_HIGH,
 	.get_link_ksettings             = hinic3_get_link_ksettings,
 	.get_drvinfo                    = hinic3_get_drvinfo,
 	.get_msglevel                   = hinic3_get_msglevel,
@@ -979,6 +1295,8 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
 	.get_eth_ctrl_stats             = hinic3_get_eth_ctrl_stats,
 	.get_rmon_stats                 = hinic3_get_rmon_stats,
 	.get_pause_stats                = hinic3_get_pause_stats,
+	.get_coalesce                   = hinic3_get_coalesce,
+	.set_coalesce                   = hinic3_set_coalesce,
 };
 
 void hinic3_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index e7d6c2033b45..b4e58d4c8ba8 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -20,7 +20,7 @@ static void hinic3_net_dim(struct hinic3_nic_dev *nic_dev,
 	struct dim_sample sample = {};
 
 	if (!test_bit(HINIC3_INTF_UP, &nic_dev->flags) ||
-	    !nic_dev->adaptive_rx_coal)
+	    !READ_ONCE(nic_dev->adaptive_rx_coal))
 		return;
 
 	dim_update_sample(irq_cfg->total_events, rxq->rxq_stats.packets,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 513dc02946c3..8c7492e15409 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -51,7 +51,7 @@ static void init_intr_coal_param(struct net_device *netdev)
 		info->rx_pending_limit_low = HINIC3_RX_PENDING_LIMIT_LOW;
 	}
 
-	nic_dev->adaptive_rx_coal = 1;
+	WRITE_ONCE(nic_dev->adaptive_rx_coal, 1);
 }
 
 static int hinic3_init_intr_coalesce(struct net_device *netdev)
-- 
2.54.0

