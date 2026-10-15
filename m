Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD850B432;
	Thu, 15 Oct 2026 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058168; cv=none; b=P8MCSxei2h9NkFc2c6/aiXk5SBwMcXs4pQrqrsCxNvMrN3hzzGuWKVdATg4AOMpBI26W/ByUyPwZGbwyfI8GzNv9TAMCyU2OZxj7O51ADfpnf7UDtFiPGS1VBEpZONUCrh5bAzZ6peTot8xMtK7i3ufN/upwLZo6IXxsZIntGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058168; c=relaxed/simple;
	bh=hEFM1DahbvihZnHWCsdgb/lthxGFP5esKqvdkZ7+vnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnJB0ggEddzaef8WcB1Ag8kP4jVoJZ6PFjsXWCTS6Er2Oj71wmclKJnUSy9zh644kLCQkCmlXVFwiagoVOa6ceBFQ58OFsaHXbLiOvDrogGPFNKFJKZrnXU4lEmyv84rhkcIQNbo/qdtM8UkEU7iZw44jhR3BfxzaYB5cv+Cr2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iaCRmO0r; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="iaCRmO0r"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=azdMBnXbCSmsyxOhR8EoyiwpYT9Jo6o8Nw7rl+LaDSU=;
	b=iaCRmO0r+7Xm0ismpDhITRxSoBWmJwBR3dvFmeGTj+sLZMaChR6fClGUaMd871zP44dZRcurS
	/PtH5psHq2X5BVVQu+HblaFZVUOHuQubXeb0fbRDdOgw/95K4vP67MAY37hVV/vsl4ETWPtFH9/
	XHVQdYFcQSrQC6izLDnaetI=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4j537n0Zc8z1cyPY;
	Thu, 15 Oct 2026 17:44:37 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 09FDA4057C;
	Thu, 15 Oct 2026 17:55:53 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.38) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 15 Oct 2026 17:55:51 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri Daskalakis
	<dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>
Subject: [PATCH net-next v15 1/2] hinic3: Add ethtool statistic ops part1
Date: Thu, 15 Oct 2026 17:55:43 +0800
Message-ID: <2b4a6fad842e0a2ea6c5ab7555916f970b78b599.1792053295.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1792053295.git.gongfan1@huawei.com>
References: <cover.1792053295.git.gongfan1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100013.china.huawei.com (7.202.181.12)

This commit adds per-queue TX/RX software counters and firmware-backed
vport and physical port statistics to the hinic3 driver. It implements
the .get_strings, .get_sset_count and .get_ethtool_stats callbacks so
these can be read with ethtool -S, and adds packet/byte accounting to
the RX and TX hot paths.

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 294 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  11 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  37 +++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  64 ++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   | 108 +++++++
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  63 +++-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |   8 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  68 +++-
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |   5 +-
 9 files changed, 646 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index 90fc16288de9..bb6094d61196 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -13,8 +13,11 @@
 
 #include "hinic3_lld.h"
 #include "hinic3_hw_comm.h"
+#include "hinic3_hwif.h"
 #include "hinic3_nic_dev.h"
 #include "hinic3_nic_cfg.h"
+#include "hinic3_tx.h"
+#include "hinic3_rx.h"
 
 #define HINIC3_MGMT_VERSION_MAX_LEN     32
 
@@ -409,6 +412,294 @@ hinic3_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
+struct hinic3_stats {
+	char name[ETH_GSTRING_LEN];
+	int  offset;
+};
+
+#define HINIC3_STAT_SIZE_CHECK(type, member) \
+	BUILD_BUG_ON_ZERO(sizeof_field(type, member) != sizeof(u64))
+
+#define HINIC3_FUNC_STAT(_stat_item) {	\
+	.name   = #_stat_item, \
+	.offset = offsetof(struct l2nic_vport_stats, _stat_item) \
+		  + 0 * HINIC3_STAT_SIZE_CHECK(struct l2nic_vport_stats, \
+					       _stat_item) \
+}
+
+static struct hinic3_stats hinic3_function_stats[] = {
+	HINIC3_FUNC_STAT(tx_unicast_pkts_vport),
+	HINIC3_FUNC_STAT(tx_unicast_bytes_vport),
+	HINIC3_FUNC_STAT(tx_multicast_pkts_vport),
+	HINIC3_FUNC_STAT(tx_multicast_bytes_vport),
+	HINIC3_FUNC_STAT(tx_broadcast_pkts_vport),
+	HINIC3_FUNC_STAT(tx_broadcast_bytes_vport),
+
+	HINIC3_FUNC_STAT(rx_unicast_pkts_vport),
+	HINIC3_FUNC_STAT(rx_unicast_bytes_vport),
+	HINIC3_FUNC_STAT(rx_multicast_pkts_vport),
+	HINIC3_FUNC_STAT(rx_multicast_bytes_vport),
+	HINIC3_FUNC_STAT(rx_broadcast_pkts_vport),
+	HINIC3_FUNC_STAT(rx_broadcast_bytes_vport),
+
+	HINIC3_FUNC_STAT(tx_discard_vport),
+	HINIC3_FUNC_STAT(rx_discard_vport),
+	HINIC3_FUNC_STAT(tx_err_vport),
+	HINIC3_FUNC_STAT(rx_err_vport),
+};
+
+#define HINIC3_PORT_STAT(_stat_item) { \
+	.name   = #_stat_item, \
+	.offset = offsetof(struct mag_cmd_port_stats, _stat_item) \
+		  + 0 * HINIC3_STAT_SIZE_CHECK(struct mag_cmd_port_stats, \
+					       _stat_item) \
+}
+
+static struct hinic3_stats hinic3_port_stats[] = {
+	HINIC3_PORT_STAT(mac_tx_fragment_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_undersize_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_undermin_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_1519_max_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_1519_max_good_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_oversize_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_jabber_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_bad_oct_num),
+	HINIC3_PORT_STAT(mac_tx_total_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_uni_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri0_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri1_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri2_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri3_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri4_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri5_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri6_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri7_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_err_all_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_from_app_good_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_from_app_bad_pkt_num),
+
+	HINIC3_PORT_STAT(mac_rx_undermin_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_1519_max_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_1519_max_good_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_bad_oct_num),
+	HINIC3_PORT_STAT(mac_rx_total_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_uni_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri0_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri1_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri2_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri3_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri4_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri5_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri6_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri7_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_send_app_good_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_send_app_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_unfilter_pkt_num),
+};
+
+#define HINIC3_TXQ_STAT(_stat_item) { \
+	.name   = "txq%d_"#_stat_item, \
+	.offset = offsetof(struct hinic3_txq_stats, _stat_item) \
+		  + 0 * HINIC3_STAT_SIZE_CHECK(struct hinic3_txq_stats, \
+					       _stat_item) \
+}
+
+#define HINIC3_RXQ_STAT(_stat_item) { \
+	.name   = "rxq%d_"#_stat_item, \
+	.offset = offsetof(struct hinic3_rxq_stats, _stat_item) \
+		  + 0 * HINIC3_STAT_SIZE_CHECK(struct hinic3_rxq_stats, \
+					       _stat_item) \
+}
+
+static struct hinic3_stats hinic3_tx_queue_stats[] = {
+	HINIC3_TXQ_STAT(gso_packets),
+	HINIC3_TXQ_STAT(busy),
+	HINIC3_TXQ_STAT(skb_pad_err),
+	HINIC3_TXQ_STAT(offload_cow_skb_err),
+	HINIC3_TXQ_STAT(map_frag_err),
+	HINIC3_TXQ_STAT(unknown_tunnel_pkt),
+};
+
+static struct hinic3_stats hinic3_rx_queue_stats[] = {
+	HINIC3_RXQ_STAT(lro_packets),
+	HINIC3_RXQ_STAT(csum_errors),
+	HINIC3_RXQ_STAT(other_errors),
+	HINIC3_RXQ_STAT(rx_buf_empty),
+	HINIC3_RXQ_STAT(alloc_skb_err),
+	HINIC3_RXQ_STAT(alloc_rx_buf_err),
+};
+
+static u16 hinic3_get_hw_stats_strings(struct hinic3_nic_dev *nic_dev, char *p)
+{
+	u16 i, cnt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(hinic3_function_stats); i++) {
+		memcpy(p, hinic3_function_stats[i].name, ETH_GSTRING_LEN);
+		p += ETH_GSTRING_LEN;
+		cnt++;
+	}
+
+	if (!HINIC3_IS_VF(nic_dev->hwdev)) {
+		for (i = 0; i < ARRAY_SIZE(hinic3_port_stats); i++) {
+			memcpy(p, hinic3_port_stats[i].name, ETH_GSTRING_LEN);
+			p += ETH_GSTRING_LEN;
+			cnt++;
+		}
+	}
+
+	return cnt;
+}
+
+static void hinic3_get_qp_stats_strings(struct hinic3_nic_dev *nic_dev, char *p)
+{
+	u8 *data = p;
+	u16 i, j;
+
+	for (i = 0; i < nic_dev->q_params.num_qps; i++) {
+		for (j = 0; j < ARRAY_SIZE(hinic3_tx_queue_stats); j++)
+			ethtool_sprintf(&data,
+					hinic3_tx_queue_stats[j].name, i);
+	}
+
+	for (i = 0; i < nic_dev->q_params.num_qps; i++) {
+		for (j = 0; j < ARRAY_SIZE(hinic3_rx_queue_stats); j++)
+			ethtool_sprintf(&data,
+					hinic3_rx_queue_stats[j].name, i);
+	}
+}
+
+static void hinic3_get_strings(struct net_device *netdev,
+			       u32 stringset, u8 *data)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	char *p = (char *)data;
+	u16 offset;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		offset = hinic3_get_hw_stats_strings(nic_dev, p);
+		hinic3_get_qp_stats_strings(nic_dev,
+					    p + offset * ETH_GSTRING_LEN);
+
+		break;
+	}
+}
+
+static int hinic3_get_sset_count(struct net_device *netdev, int sset)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int count, q_num;
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		q_num = nic_dev->q_params.num_qps;
+		count = ARRAY_SIZE(hinic3_function_stats) +
+			(ARRAY_SIZE(hinic3_tx_queue_stats) +
+			 ARRAY_SIZE(hinic3_rx_queue_stats)) *
+			q_num;
+
+		if (!HINIC3_IS_VF(nic_dev->hwdev))
+			count += ARRAY_SIZE(hinic3_port_stats);
+
+		return count;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static u16 hinic3_get_ethtool_port_stats(struct net_device *netdev, u64 *data)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct mag_cmd_port_stats *ps;
+	u16 i = 0, j;
+	char *p;
+	int err;
+
+	ps = kmalloc_obj(*ps);
+	if (!ps)
+		goto err_zero_stats;
+
+	err = hinic3_get_phy_port_stats(nic_dev->hwdev, ps);
+	if (err) {
+		kfree(ps);
+		netdev_err_once(netdev, "Failed to get port stats from fw\n");
+		goto err_zero_stats;
+	}
+
+	for (j = 0; j < ARRAY_SIZE(hinic3_port_stats); j++, i++) {
+		p = (char *)ps + hinic3_port_stats[j].offset;
+		data[i] = *(u64 *)p;
+	}
+
+	kfree(ps);
+
+	return i;
+
+err_zero_stats:
+	memset(&data[i], 0, ARRAY_SIZE(hinic3_port_stats) * sizeof(*data));
+
+	return i + ARRAY_SIZE(hinic3_port_stats);
+}
+
+static void hinic3_get_drv_queue_stats(struct net_device *netdev, u64 *data)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_txq_stats txq_stats = {};
+	struct hinic3_rxq_stats rxq_stats = {};
+	u16 i = 0, j, qid;
+	char *p;
+
+	for (qid = 0; qid < nic_dev->q_params.num_qps; qid++) {
+		hinic3_txq_get_stats(&nic_dev->txqs[qid], &txq_stats);
+		for (j = 0; j < ARRAY_SIZE(hinic3_tx_queue_stats); j++, i++) {
+			p = (char *)&txq_stats +
+			    hinic3_tx_queue_stats[j].offset;
+			data[i] = *(u64 *)p;
+		}
+	}
+
+	i = nic_dev->q_params.num_qps * ARRAY_SIZE(hinic3_tx_queue_stats);
+	for (qid = 0; qid < nic_dev->q_params.num_qps; qid++) {
+		hinic3_rxq_get_stats(&nic_dev->rxqs[qid], &rxq_stats);
+		for (j = 0; j < ARRAY_SIZE(hinic3_rx_queue_stats); j++, i++) {
+			p = (char *)&rxq_stats +
+			    hinic3_rx_queue_stats[j].offset;
+			data[i] = *(u64 *)p;
+		}
+	}
+}
+
+static void hinic3_get_ethtool_stats(struct net_device *netdev,
+				     struct ethtool_stats *stats, u64 *data)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct l2nic_vport_stats vport_stats = {};
+	u16 i = 0, j;
+	char *p;
+	int err;
+
+	err = hinic3_get_vport_stats(nic_dev->hwdev,
+				     hinic3_global_func_id(nic_dev->hwdev),
+				     &vport_stats);
+	if (err)
+		netdev_err_once(netdev,
+				"Failed to get function stats from fw\n");
+
+	for (j = 0; j < ARRAY_SIZE(hinic3_function_stats); j++, i++) {
+		p = (char *)&vport_stats + hinic3_function_stats[j].offset;
+		data[i] = *(u64 *)p;
+	}
+
+	if (!HINIC3_IS_VF(nic_dev->hwdev))
+		i += hinic3_get_ethtool_port_stats(netdev, data + i);
+
+	hinic3_get_drv_queue_stats(netdev, data + i);
+}
+
 static const struct ethtool_ops hinic3_ethtool_ops = {
 	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
 					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
@@ -417,6 +708,9 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
 	.get_msglevel                   = hinic3_get_msglevel,
 	.set_msglevel                   = hinic3_set_msglevel,
 	.get_link                       = ethtool_op_get_link,
+	.get_strings                    = hinic3_get_strings,
+	.get_sset_count                 = hinic3_get_sset_count,
+	.get_ethtool_stats              = hinic3_get_ethtool_stats,
 };
 
 void hinic3_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
index cfc9daa3034f..6b0f486ba590 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
@@ -53,6 +53,17 @@ static inline void mgmt_msg_params_init_default(struct mgmt_msg_params *msg_para
 	msg_params->timeout_ms = 0;
 }
 
+static inline void
+mgmt_msg_params_init_in_out(struct mgmt_msg_params *msg_params, void *in_buf,
+			    void *out_buf, u32 in_buf_size, u32 out_buf_size)
+{
+	msg_params->buf_in = in_buf;
+	msg_params->buf_out = out_buf;
+	msg_params->in_size = in_buf_size;
+	msg_params->expected_out_size = out_buf_size;
+	msg_params->timeout_ms = 0;
+}
+
 enum cfg_cmd {
 	CFG_CMD_GET_DEV_CAP = 0,
 };
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
index c5bca3c4af96..76c691f82703 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -143,6 +143,41 @@ struct l2nic_cmd_set_dcb_state {
 	u8                   rsvd[7];
 };
 
+struct l2nic_port_stats_info {
+	struct mgmt_msg_head msg_head;
+	u16                  func_id;
+	u16                  rsvd1;
+};
+
+struct l2nic_vport_stats {
+	u64 tx_unicast_pkts_vport;
+	u64 tx_unicast_bytes_vport;
+	u64 tx_multicast_pkts_vport;
+	u64 tx_multicast_bytes_vport;
+	u64 tx_broadcast_pkts_vport;
+	u64 tx_broadcast_bytes_vport;
+
+	u64 rx_unicast_pkts_vport;
+	u64 rx_unicast_bytes_vport;
+	u64 rx_multicast_pkts_vport;
+	u64 rx_multicast_bytes_vport;
+	u64 rx_broadcast_pkts_vport;
+	u64 rx_broadcast_bytes_vport;
+
+	u64 tx_discard_vport;
+	u64 rx_discard_vport;
+	u64 tx_err_vport;
+	u64 rx_err_vport;
+};
+
+struct l2nic_cmd_vport_stats {
+	struct mgmt_msg_head     msg_head;
+	u32                      stats_size;
+	u32                      rsvd1;
+	struct l2nic_vport_stats stats;
+	u64                      rsvd2[6];
+};
+
 struct l2nic_cmd_lro_config {
 	struct mgmt_msg_head msg_head;
 	u16                  func_id;
@@ -234,6 +269,7 @@ enum l2nic_cmd {
 	L2NIC_CMD_SET_VPORT_ENABLE    = 6,
 	L2NIC_CMD_SET_RX_MODE         = 7,
 	L2NIC_CMD_SET_SQ_CI_ATTR      = 8,
+	L2NIC_CMD_GET_VPORT_STAT      = 9,
 	L2NIC_CMD_CLEAR_QP_RESOURCE   = 11,
 	L2NIC_CMD_CFG_RX_LRO          = 13,
 	L2NIC_CMD_CFG_LRO_TIMER       = 14,
@@ -272,6 +308,7 @@ enum mag_cmd {
 	MAG_CMD_SET_PORT_ENABLE = 6,
 	MAG_CMD_GET_LINK_STATUS = 7,
 
+	MAG_CMD_GET_PORT_STAT   = 151,
 	MAG_CMD_GET_PORT_INFO   = 153,
 };
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index de5a7984d2cb..e4a3fa6fb8db 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -738,3 +738,67 @@ int hinic3_get_pause_info(struct hinic3_nic_dev *nic_dev,
 	return hinic3_cfg_hw_pause(nic_dev->hwdev, MGMT_MSG_CMD_OP_GET,
 				   nic_pause);
 }
+
+int hinic3_get_vport_stats(struct hinic3_hwdev *hwdev, u16 func_id,
+			   struct l2nic_vport_stats *stats)
+{
+	struct l2nic_cmd_vport_stats vport_stats = {};
+	struct l2nic_port_stats_info stats_info = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	stats_info.func_id = func_id;
+
+	mgmt_msg_params_init_in_out(&msg_params, &stats_info, &vport_stats,
+				    sizeof(stats_info), sizeof(vport_stats));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_GET_VPORT_STAT, &msg_params);
+
+	if (err || vport_stats.msg_head.status) {
+		dev_err_once(hwdev->dev,
+			     "Failed to get function statistics, err: %d, status: 0x%x\n",
+			     err, vport_stats.msg_head.status);
+		return -EFAULT;
+	}
+
+	memcpy(stats, &vport_stats.stats, sizeof(*stats));
+
+	return 0;
+}
+
+int hinic3_get_phy_port_stats(struct hinic3_hwdev *hwdev,
+			      struct mag_cmd_port_stats *stats)
+{
+	struct mag_cmd_get_port_stats_in ps_in = {};
+	struct mag_cmd_get_port_stats_out *ps_out;
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	ps_out = kzalloc_obj(*ps_out);
+	if (!ps_out)
+		return -ENOMEM;
+
+	ps_in.port_id = hinic3_physical_port_id(hwdev);
+
+	mgmt_msg_params_init_in_out(&msg_params, &ps_in, ps_out,
+				    sizeof(ps_in), sizeof(*ps_out));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_HILINK,
+				       MAG_CMD_GET_PORT_STAT, &msg_params);
+
+	if (err || ps_out->head.status) {
+		dev_err_once(hwdev->dev,
+			     "Failed to get port statistics, err: %d, status: 0x%x\n",
+			     err, ps_out->head.status);
+		err = -EFAULT;
+		goto out;
+	}
+
+	memcpy(stats, &ps_out->counter, sizeof(*stats));
+
+out:
+	kfree(ps_out);
+
+	return err;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index 5d52202a8d4e..3b8b595d7060 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -129,6 +129,110 @@ struct mag_cmd_get_xsfp_present {
 	u8                   rsvd[2];
 };
 
+struct mag_cmd_port_stats {
+	u64 mac_tx_fragment_pkt_num;
+	u64 mac_tx_undersize_pkt_num;
+	u64 mac_tx_undermin_pkt_num;
+	u64 mac_tx_64_oct_pkt_num;
+	u64 mac_tx_65_127_oct_pkt_num;
+	u64 mac_tx_128_255_oct_pkt_num;
+	u64 mac_tx_256_511_oct_pkt_num;
+	u64 mac_tx_512_1023_oct_pkt_num;
+	u64 mac_tx_1024_1518_oct_pkt_num;
+	u64 mac_tx_1519_2047_oct_pkt_num;
+	u64 mac_tx_2048_4095_oct_pkt_num;
+	u64 mac_tx_4096_8191_oct_pkt_num;
+	u64 mac_tx_8192_9216_oct_pkt_num;
+	u64 mac_tx_9217_12287_oct_pkt_num;
+	u64 mac_tx_12288_16383_oct_pkt_num;
+	u64 mac_tx_1519_max_bad_pkt_num;
+	u64 mac_tx_1519_max_good_pkt_num;
+	u64 mac_tx_oversize_pkt_num;
+	u64 mac_tx_jabber_pkt_num;
+	u64 mac_tx_bad_pkt_num;
+	u64 mac_tx_bad_oct_num;
+	u64 mac_tx_good_pkt_num;
+	u64 mac_tx_good_oct_num;
+	u64 mac_tx_total_pkt_num;
+	u64 mac_tx_total_oct_num;
+	u64 mac_tx_uni_pkt_num;
+	u64 mac_tx_multi_pkt_num;
+	u64 mac_tx_broad_pkt_num;
+	u64 mac_tx_pause_num;
+	u64 mac_tx_pfc_pkt_num;
+	u64 mac_tx_pfc_pri0_pkt_num;
+	u64 mac_tx_pfc_pri1_pkt_num;
+	u64 mac_tx_pfc_pri2_pkt_num;
+	u64 mac_tx_pfc_pri3_pkt_num;
+	u64 mac_tx_pfc_pri4_pkt_num;
+	u64 mac_tx_pfc_pri5_pkt_num;
+	u64 mac_tx_pfc_pri6_pkt_num;
+	u64 mac_tx_pfc_pri7_pkt_num;
+	u64 mac_tx_control_pkt_num;
+	u64 mac_tx_err_all_pkt_num;
+	u64 mac_tx_from_app_good_pkt_num;
+	u64 mac_tx_from_app_bad_pkt_num;
+
+	u64 mac_rx_fragment_pkt_num;
+	u64 mac_rx_undersize_pkt_num;
+	u64 mac_rx_undermin_pkt_num;
+	u64 mac_rx_64_oct_pkt_num;
+	u64 mac_rx_65_127_oct_pkt_num;
+	u64 mac_rx_128_255_oct_pkt_num;
+	u64 mac_rx_256_511_oct_pkt_num;
+	u64 mac_rx_512_1023_oct_pkt_num;
+	u64 mac_rx_1024_1518_oct_pkt_num;
+	u64 mac_rx_1519_2047_oct_pkt_num;
+	u64 mac_rx_2048_4095_oct_pkt_num;
+	u64 mac_rx_4096_8191_oct_pkt_num;
+	u64 mac_rx_8192_9216_oct_pkt_num;
+	u64 mac_rx_9217_12287_oct_pkt_num;
+	u64 mac_rx_12288_16383_oct_pkt_num;
+	u64 mac_rx_1519_max_bad_pkt_num;
+	u64 mac_rx_1519_max_good_pkt_num;
+	u64 mac_rx_oversize_pkt_num;
+	u64 mac_rx_jabber_pkt_num;
+	u64 mac_rx_bad_pkt_num;
+	u64 mac_rx_bad_oct_num;
+	u64 mac_rx_good_pkt_num;
+	u64 mac_rx_good_oct_num;
+	u64 mac_rx_total_pkt_num;
+	u64 mac_rx_total_oct_num;
+	u64 mac_rx_uni_pkt_num;
+	u64 mac_rx_multi_pkt_num;
+	u64 mac_rx_broad_pkt_num;
+	u64 mac_rx_pause_num;
+	u64 mac_rx_pfc_pkt_num;
+	u64 mac_rx_pfc_pri0_pkt_num;
+	u64 mac_rx_pfc_pri1_pkt_num;
+	u64 mac_rx_pfc_pri2_pkt_num;
+	u64 mac_rx_pfc_pri3_pkt_num;
+	u64 mac_rx_pfc_pri4_pkt_num;
+	u64 mac_rx_pfc_pri5_pkt_num;
+	u64 mac_rx_pfc_pri6_pkt_num;
+	u64 mac_rx_pfc_pri7_pkt_num;
+	u64 mac_rx_control_pkt_num;
+	u64 mac_rx_sym_err_pkt_num;
+	u64 mac_rx_fcs_err_pkt_num;
+	u64 mac_rx_send_app_good_pkt_num;
+	u64 mac_rx_send_app_bad_pkt_num;
+	u64 mac_rx_unfilter_pkt_num;
+};
+
+struct mag_cmd_get_port_stats_in {
+	struct mgmt_msg_head head;
+
+	u8                   port_id;
+	u8                   rsvd0[3];
+};
+
+struct mag_cmd_get_port_stats_out {
+	struct mgmt_msg_head      head;
+
+	struct mag_cmd_port_stats counter;
+	u64                       rsvd1[15];
+};
+
 enum link_err_type {
 	LINK_ERR_MODULE_UNRECOGENIZED,
 	LINK_ERR_NUM,
@@ -215,4 +319,8 @@ int hinic3_del_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id);
 int hinic3_get_pause_info(struct hinic3_nic_dev *nic_dev,
 			  struct hinic3_nic_pause_config *nic_pause);
 
+int hinic3_get_vport_stats(struct hinic3_hwdev *hwdev, u16 func_id,
+			   struct l2nic_vport_stats *stats);
+int hinic3_get_phy_port_stats(struct hinic3_hwdev *hwdev,
+			      struct mag_cmd_port_stats *stats);
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index 309ab5901379..233cc5523455 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -46,7 +46,6 @@ static void hinic3_rxq_clean_stats(struct hinic3_rxq_stats *rxq_stats)
 
 	rxq_stats->alloc_skb_err = 0;
 	rxq_stats->alloc_rx_buf_err = 0;
-	rxq_stats->restore_drop_sge = 0;
 	u64_stats_update_end(&rxq_stats->syncp);
 }
 
@@ -147,6 +146,8 @@ static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
 {
 	u32 i, free_wqebbs = rxq->delta - 1;
 	struct hinic3_rx_info *rx_info;
+	struct u64_stats_sync *syncp;
+	unsigned long flags;
 	dma_addr_t dma_addr;
 	int err;
 
@@ -155,8 +156,13 @@ static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
 
 		err = rx_alloc_mapped_page(rxq->page_pool, rx_info,
 					   rxq->buf_len);
-		if (unlikely(err))
+		if (unlikely(err)) {
+			syncp = &rxq->rxq_stats.syncp;
+			flags = u64_stats_update_begin_irqsave(syncp);
+			rxq->rxq_stats.alloc_rx_buf_err++;
+			u64_stats_update_end_irqrestore(syncp, flags);
 			break;
+		}
 
 		dma_addr = page_pool_get_dma_addr(rx_info->page) +
 			rx_info->page_offset;
@@ -170,6 +176,11 @@ static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
 				rxq->next_to_update << HINIC3_NORMAL_RQ_WQE);
 		rxq->delta -= i;
 		rxq->next_to_alloc = rxq->next_to_update;
+	} else if (free_wqebbs == rxq->q_depth - 1) {
+		syncp = &rxq->rxq_stats.syncp;
+		flags = u64_stats_update_begin_irqsave(syncp);
+		rxq->rxq_stats.rx_buf_empty++;
+		u64_stats_update_end_irqrestore(syncp, flags);
 	}
 
 	return i;
@@ -330,10 +341,23 @@ static void hinic3_rx_csum(struct hinic3_rxq *rxq, u32 offload_type,
 	struct net_device *netdev = rxq->netdev;
 	bool l2_tunnel;
 
+	/* HW ensures that only 1 bit is set in csum_err. */
+	if (unlikely(csum_err == HINIC3_RX_CSUM_IPSU_OTHER_ERR)) {
+		u64_stats_update_begin(&rxq->rxq_stats.syncp);
+		rxq->rxq_stats.other_errors++;
+		u64_stats_update_end(&rxq->rxq_stats.syncp);
+	}
+
 	if (!(netdev->features & NETIF_F_RXCSUM))
 		return;
 
 	if (unlikely(csum_err)) {
+		if (csum_err != HINIC3_RX_CSUM_HW_CHECK_NONE &&
+		    csum_err != HINIC3_RX_CSUM_IPSU_OTHER_ERR) {
+			u64_stats_update_begin(&rxq->rxq_stats.syncp);
+			rxq->rxq_stats.csum_errors++;
+			u64_stats_update_end(&rxq->rxq_stats.syncp);
+		}
 		/* pkt type is recognized by HW, and csum is wrong */
 		skb->ip_summed = CHECKSUM_NONE;
 		return;
@@ -387,8 +411,12 @@ static int recv_one_pkt(struct hinic3_rxq *rxq, struct hinic3_rq_cqe *rx_cqe,
 	u16 num_lro;
 
 	skb = hinic3_fetch_rx_buffer(rxq, pkt_len);
-	if (unlikely(!skb))
+	if (unlikely(!skb)) {
+		u64_stats_update_begin(&rxq->rxq_stats.syncp);
+		rxq->rxq_stats.alloc_skb_err++;
+		u64_stats_update_end(&rxq->rxq_stats.syncp);
 		return -ENOMEM;
+	}
 
 	/* place header in linear portion of buffer */
 	if (skb_is_nonlinear(skb))
@@ -555,6 +583,8 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 	struct hinic3_nic_dev *nic_dev = netdev_priv(rxq->netdev);
 	u32 sw_ci, status, pkt_len, vlan_len;
 	struct hinic3_rq_cqe *rx_cqe;
+	u64 lro_packets = 0;
+	u64 rx_bytes = 0;
 	u32 num_wqe = 0;
 	int nr_pkts = 0;
 	u16 num_lro;
@@ -575,9 +605,12 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 			break;
 
 		nr_pkts++;
+		rx_bytes += pkt_len;
 		num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
-		if (num_lro)
+		if (num_lro) {
 			num_wqe += hinic3_get_sge_num(rxq, pkt_len);
+			lro_packets = 1;
+		}
 
 		rx_cqe->status = 0;
 
@@ -588,5 +621,27 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 	if (rxq->delta >= HINIC3_RX_BUFFER_WRITE)
 		hinic3_rx_fill_buffers(rxq);
 
+	u64_stats_update_begin(&rxq->rxq_stats.syncp);
+	rxq->rxq_stats.packets += (u64)nr_pkts;
+	rxq->rxq_stats.bytes += rx_bytes;
+	rxq->rxq_stats.lro_packets += lro_packets;
+	u64_stats_update_end(&rxq->rxq_stats.syncp);
 	return nr_pkts;
 }
+
+void hinic3_rxq_get_stats(struct hinic3_rxq *rxq,
+			  struct hinic3_rxq_stats *stats)
+{
+	struct hinic3_rxq_stats *rxq_stats = &rxq->rxq_stats;
+	unsigned int start;
+
+	do {
+		start = u64_stats_fetch_begin(&rxq_stats->syncp);
+		stats->lro_packets = rxq_stats->lro_packets;
+		stats->csum_errors = rxq_stats->csum_errors;
+		stats->other_errors = rxq_stats->other_errors;
+		stats->rx_buf_empty = rxq_stats->rx_buf_empty;
+		stats->alloc_skb_err = rxq_stats->alloc_skb_err;
+		stats->alloc_rx_buf_err = rxq_stats->alloc_rx_buf_err;
+	} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index 06d1b3299e7c..9a87203f887e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -8,6 +8,10 @@
 #include <linux/dim.h>
 #include <linux/netdevice.h>
 
+/* rx cqe checksum err */
+#define HINIC3_RX_CSUM_HW_CHECK_NONE    BIT(7)
+#define HINIC3_RX_CSUM_IPSU_OTHER_ERR   BIT(8)
+
 #define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_MASK           GENMASK(4, 0)
 #define RQ_CQE_OFFOLAD_TYPE_IP_TYPE_MASK            GENMASK(6, 5)
 #define RQ_CQE_OFFOLAD_TYPE_TUNNEL_PKT_FORMAT_MASK  GENMASK(11, 8)
@@ -32,6 +36,7 @@
 struct hinic3_rxq_stats {
 	u64                   packets;
 	u64                   bytes;
+	u64                   lro_packets;
 	u64                   errors;
 	u64                   csum_errors;
 	u64                   other_errors;
@@ -39,7 +44,6 @@ struct hinic3_rxq_stats {
 	u64                   rx_buf_empty;
 	u64                   alloc_skb_err;
 	u64                   alloc_rx_buf_err;
-	u64                   restore_drop_sge;
 	struct u64_stats_sync syncp;
 };
 
@@ -125,4 +129,6 @@ int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
 			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res);
 int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget);
 
+void hinic3_rxq_get_stats(struct hinic3_rxq *rxq,
+			  struct hinic3_rxq_stats *stats);
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index d19cfbe3ed3b..3cfab74dc646 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -25,11 +25,9 @@ static void hinic3_txq_clean_stats(struct hinic3_txq_stats *txq_stats)
 	txq_stats->dropped = 0;
 
 	txq_stats->skb_pad_err = 0;
-	txq_stats->frag_len_overflow = 0;
 	txq_stats->offload_cow_skb_err = 0;
 	txq_stats->map_frag_err = 0;
 	txq_stats->unknown_tunnel_pkt = 0;
-	txq_stats->frag_size_err = 0;
 	u64_stats_update_end(&txq_stats->syncp);
 }
 
@@ -97,8 +95,12 @@ static int hinic3_tx_map_skb(struct net_device *netdev, struct sk_buff *skb,
 
 	dma_info[0].dma = dma_map_single(&pdev->dev, skb->data,
 					 skb_headlen(skb), DMA_TO_DEVICE);
-	if (dma_mapping_error(&pdev->dev, dma_info[0].dma))
+	if (dma_mapping_error(&pdev->dev, dma_info[0].dma)) {
+		u64_stats_update_begin(&txq->txq_stats.syncp);
+		txq->txq_stats.map_frag_err++;
+		u64_stats_update_end(&txq->txq_stats.syncp);
 		return -EFAULT;
+	}
 
 	dma_info[0].len = skb_headlen(skb);
 
@@ -117,6 +119,9 @@ static int hinic3_tx_map_skb(struct net_device *netdev, struct sk_buff *skb,
 						     skb_frag_size(frag),
 						     DMA_TO_DEVICE);
 		if (dma_mapping_error(&pdev->dev, dma_info[idx].dma)) {
+			u64_stats_update_begin(&txq->txq_stats.syncp);
+			txq->txq_stats.map_frag_err++;
+			u64_stats_update_end(&txq->txq_stats.syncp);
 			err = -EFAULT;
 			goto err_unmap_page;
 		}
@@ -260,6 +265,9 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
 		if (l4_proto != IPPROTO_UDP ||
 		    ((struct udphdr *)skb_transport_header(skb))->dest !=
 		    VXLAN_OFFLOAD_PORT_LE) {
+			u64_stats_update_begin(&txq->txq_stats.syncp);
+			txq->txq_stats.unknown_tunnel_pkt++;
+			u64_stats_update_end(&txq->txq_stats.syncp);
 			/* Unsupported tunnel packet, disable csum offload */
 			return skb_checksum_help(skb);
 		}
@@ -487,6 +495,20 @@ static u16 hinic3_set_wqe_combo(struct hinic3_txq *txq,
 					      num_sge + !!offload);
 }
 
+static void hinic3_get_pkt_stats(struct hinic3_txq *txq, struct sk_buff *skb)
+{
+	u64 gso_packets = 0;
+
+	if (skb_is_gso(skb))
+		gso_packets = 1;
+
+	u64_stats_update_begin(&txq->txq_stats.syncp);
+	txq->txq_stats.bytes += skb->len;
+	txq->txq_stats.packets += 1;
+	txq->txq_stats.gso_packets += gso_packets;
+	u64_stats_update_end(&txq->txq_stats.syncp);
+}
+
 static void hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,
 				   __le32 queue_info, int nr_descs, u16 owner)
 {
@@ -542,8 +564,12 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 	int err;
 
 	if (unlikely(skb->len < MIN_SKB_LEN)) {
-		if (skb_pad(skb, MIN_SKB_LEN - skb->len))
+		if (skb_pad(skb, MIN_SKB_LEN - skb->len)) {
+			u64_stats_update_begin(&txq->txq_stats.syncp);
+			txq->txq_stats.skb_pad_err++;
+			u64_stats_update_end(&txq->txq_stats.syncp);
 			goto err_out;
+		}
 
 		skb->len = MIN_SKB_LEN;
 	}
@@ -561,10 +587,16 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 					hinic3_wq_free_wqebbs(&txq->sq->wq),
 					txq->tx_start_thrs);
 
+		u64_stats_update_begin(&txq->txq_stats.syncp);
+		txq->txq_stats.busy++;
+		u64_stats_update_end(&txq->txq_stats.syncp);
 		return NETDEV_TX_BUSY;
 	}
 
 	if (unlikely(offload == HINIC3_TX_OFFLOAD_INVALID)) {
+		u64_stats_update_begin(&txq->txq_stats.syncp);
+		txq->txq_stats.offload_cow_skb_err++;
+		u64_stats_update_end(&txq->txq_stats.syncp);
 		goto err_drop_pkt;
 	} else if (!offload) {
 		wqebb_cnt -= 1;
@@ -599,6 +631,7 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 				  txq->tx_stop_thrs,
 				  txq->tx_start_thrs);
 
+	hinic3_get_pkt_stats(txq, skb);
 	hinic3_prepare_sq_ctrl(&wqe_combo, queue_info, num_sge, owner);
 	hinic3_write_db(txq->sq, 0, DB_CFLAG_DP_SQ,
 			hinic3_get_sq_local_pi(txq->sq));
@@ -608,6 +641,9 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 err_drop_pkt:
 	dev_kfree_skb_any(skb);
 err_out:
+	u64_stats_update_begin(&txq->txq_stats.syncp);
+	txq->txq_stats.dropped++;
+	u64_stats_update_end(&txq->txq_stats.syncp);
 	return NETDEV_TX_OK;
 }
 
@@ -615,6 +651,7 @@ netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 	u16 q_id = skb_get_queue_mapping(skb);
+	struct hinic3_txq *txq;
 
 	if (unlikely(!netif_carrier_ok(netdev)))
 		goto err_drop_pkt;
@@ -622,11 +659,15 @@ netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 	if (unlikely(q_id >= nic_dev->q_params.num_qps))
 		goto err_drop_pkt;
 
-	return hinic3_send_one_skb(skb, netdev, &nic_dev->txqs[q_id]);
+	txq = &nic_dev->txqs[q_id];
+	return hinic3_send_one_skb(skb, netdev, txq);
 
 err_drop_pkt:
 	dev_kfree_skb_any(skb);
 
+	u64_stats_update_begin(&txq->txq_stats.syncp);
+	txq->txq_stats.dropped++;
+	u64_stats_update_end(&txq->txq_stats.syncp);
 	return NETDEV_TX_OK;
 }
 
@@ -799,3 +840,20 @@ bool hinic3_tx_poll(struct hinic3_txq *txq, int budget)
 
 	return pkts == HINIC3_TX_POLL_WEIGHT;
 }
+
+void hinic3_txq_get_stats(struct hinic3_txq *txq,
+			  struct hinic3_txq_stats *stats)
+{
+	struct hinic3_txq_stats *txq_stats = &txq->txq_stats;
+	unsigned int start;
+
+	do {
+		start = u64_stats_fetch_begin(&txq_stats->syncp);
+		stats->gso_packets = txq_stats->gso_packets;
+		stats->busy = txq_stats->busy;
+		stats->skb_pad_err = txq_stats->skb_pad_err;
+		stats->offload_cow_skb_err = txq_stats->offload_cow_skb_err;
+		stats->map_frag_err = txq_stats->map_frag_err;
+		stats->unknown_tunnel_pkt = txq_stats->unknown_tunnel_pkt;
+	} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
index 00194f2a1bcc..a166e7aa3677 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
@@ -103,14 +103,13 @@ struct hinic3_sq_wqe_combo {
 struct hinic3_txq_stats {
 	u64                   packets;
 	u64                   bytes;
+	u64                   gso_packets;
 	u64                   busy;
 	u64                   dropped;
 	u64                   skb_pad_err;
-	u64                   frag_len_overflow;
 	u64                   offload_cow_skb_err;
 	u64                   map_frag_err;
 	u64                   unknown_tunnel_pkt;
-	u64                   frag_size_err;
 	struct u64_stats_sync syncp;
 };
 
@@ -160,4 +159,6 @@ netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
 bool hinic3_tx_poll(struct hinic3_txq *txq, int budget);
 void hinic3_flush_txqs(struct net_device *netdev);
 
+void hinic3_txq_get_stats(struct hinic3_txq *txq,
+			  struct hinic3_txq_stats *stats);
 #endif
-- 
2.43.0

