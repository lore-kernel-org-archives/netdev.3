Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671939;
	b=z2pEupJE3xm8MT4/9/vWPeBMalWOijSdCsj/yI3I3D9Wa48AfPVh4FDV6qM+2ulCbL2W
	 q8Zh+aaCYyiXIGw3KyCYTseZStrlswd/Ztg+uUTf9u7GEgecyCllyWSJkqM2sSu1trcWR
	 OFrqmA7BlqvkIptKr+9vyNl2F4m9yN7hBBZaf+71CRvlhDCtSDQtWdYCSkzJN2vxG2HN5
	 HFWYNmHjLYrNhltCdscUPi+76Afz0ZAQCVv/tUQRS7EaS2gcSWJ2593XJYoDqCDJEuGJy
	 TQNaPkGIQdwyOTQmuWTwhItVubiXnHzsdZf5EFlof4GOvENfji6BzKx9f4xbneRc8qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671939;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=RNPTSo8RDiVDbODB01W1pjxaRMo5UYCWjuqX/wnkpY8=;
	b=Xl+LyDgLYnFRvFh7N74rN1rFDMmz+FzwdiGeDNfOOJ4PU3V3pXlvs1PhZCyCEfuu7mxO
	 4IHUV7ZIGXH0wz0ucWAIhzsy6qZ+YHiod9U1iqbkioxSRS4suRbzJswRf4HlsNXD/cMhd
	 dpU5g49YFDxYOtxVLSJi4lJ7CWmaHN/9KQ8HXbw4l3psdK0FK6IA9p8ObvgzVPAZdreOY
	 AUD+T5ZqIlFlA1blWPpMIu2W2AEBenaBLf98noYntq0X3shm8At8eSDxmcv/cIglDRUAe
	 KsYHSnpXrWpppj0h4dVWCzo7257GoFbvih51/kzIQ83h/X3Kzw2cFW2CC7Bu92do+eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=US8PydAp;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31896606A32E;
	Thu, 22 Oct 2026 12:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31896606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=US8PydAp
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RNPTSo8RDiVDbODB01W1pjxaRMo5UYCWjuqX/wnkpY8=;
	b=US8PydApqv8MPSaRI2O7CewN659NCZn/UIcejaklCso2ej8xfDkhzDcQujT2j7XMdcul5sIAk
	I+o68fV+eLX4l86XZKqwQhFWx1N+/yrlcat+p/S2f4JYqkklSCYVkLM/cy0iKRQfxaf4GLZ1OIj
	J/V8qVGoKFfKzighVUZaI24=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4j9QN55d1fz1T4GS;
	Thu, 22 Oct 2026 20:25:25 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F7B640579;
	Thu, 22 Oct 2026 20:25:27 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.38) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 22 Oct 2026 20:25:25 +0800
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
Subject: [PATCH net-next v18 1/4] hinic3: Add ethtool statistic ops part1
Date: Thu, 22 Oct 2026 20:25:15 +0800
Message-ID: <1b35942d45717da8896349eedc71ffc924a0e8f9.1792671176.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1792671176.git.gongfan1@huawei.com>
References: <cover.1792671176.git.gongfan1@huawei.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 257 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  11 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  37 +++
 .../huawei/hinic3/hinic3_netdev_ops.c         |  29 +-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  64 +++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   | 108 ++++++++
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  59 +++-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  10 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  67 ++++-
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |   4 +-
 10 files changed, 611 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index 90fc16288de9..43e0ba798cbf 100644
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
 
@@ -409,6 +412,257 @@ hinic3_get_link_ksettings(struct net_device *netdev,
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
+	HINIC3_FUNC_STAT(tx_broadcast_pkts_vport),
+	HINIC3_FUNC_STAT(tx_broadcast_bytes_vport),
+
+	HINIC3_FUNC_STAT(rx_unicast_pkts_vport),
+	HINIC3_FUNC_STAT(rx_unicast_bytes_vport),
+	HINIC3_FUNC_STAT(rx_broadcast_pkts_vport),
+	HINIC3_FUNC_STAT(rx_broadcast_bytes_vport),
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
+	HINIC3_PORT_STAT(mac_tx_fragment_pkts),
+	HINIC3_PORT_STAT(mac_tx_undersize_pkts),
+	HINIC3_PORT_STAT(mac_tx_undermin_pkts),
+	HINIC3_PORT_STAT(mac_tx_jumbo_bad_pkts),
+	HINIC3_PORT_STAT(mac_tx_jumbo_good_pkts),
+	HINIC3_PORT_STAT(mac_tx_oversize_pkts),
+	HINIC3_PORT_STAT(mac_tx_jabber_pkts),
+	HINIC3_PORT_STAT(mac_tx_bad_pkts),
+	HINIC3_PORT_STAT(mac_tx_bad_octs),
+	HINIC3_PORT_STAT(mac_tx_total_pkts),
+	HINIC3_PORT_STAT(mac_tx_uni_pkts),
+	HINIC3_PORT_STAT(mac_tx_err_all_pkts),
+	HINIC3_PORT_STAT(mac_tx_from_app_good_pkts),
+	HINIC3_PORT_STAT(mac_tx_from_app_bad_pkts),
+
+	HINIC3_PORT_STAT(mac_rx_undermin_pkts),
+	HINIC3_PORT_STAT(mac_rx_jumbo_bad_pkts),
+	HINIC3_PORT_STAT(mac_rx_jumbo_good_pkts),
+	HINIC3_PORT_STAT(mac_rx_bad_pkts),
+	HINIC3_PORT_STAT(mac_rx_bad_octs),
+	HINIC3_PORT_STAT(mac_rx_total_pkts),
+	HINIC3_PORT_STAT(mac_rx_uni_pkts),
+	HINIC3_PORT_STAT(mac_rx_send_app_good_pkts),
+	HINIC3_PORT_STAT(mac_rx_send_app_bad_pkts),
+	HINIC3_PORT_STAT(mac_rx_unfilter_pkts),
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
+	HINIC3_TXQ_STAT(skb_pad_err),
+	HINIC3_TXQ_STAT(offload_cow_skb_err),
+	HINIC3_TXQ_STAT(map_frag_err),
+	HINIC3_TXQ_STAT(unknown_tunnel_pkt),
+};
+
+static struct hinic3_stats hinic3_rx_queue_stats[] = {
+	HINIC3_RXQ_STAT(other_errors),
+	HINIC3_RXQ_STAT(rx_buf_empty),
+};
+
+static u16 hinic3_get_hw_stats_strings(struct hinic3_nic_dev *nic_dev, u8 *p)
+{
+	u16 i, cnt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(hinic3_function_stats); i++) {
+		ethtool_puts(&p, hinic3_function_stats[i].name);
+		cnt++;
+	}
+
+	if (!HINIC3_IS_VF(nic_dev->hwdev)) {
+		for (i = 0; i < ARRAY_SIZE(hinic3_port_stats); i++) {
+			ethtool_puts(&p, hinic3_port_stats[i].name);
+			cnt++;
+		}
+	}
+
+	return cnt;
+}
+
+static void hinic3_get_qp_stats_strings(struct hinic3_nic_dev *nic_dev, u8 *p)
+{
+	u16 i, j;
+
+	for (i = 0; i < nic_dev->q_params.num_qps; i++) {
+		for (j = 0; j < ARRAY_SIZE(hinic3_tx_queue_stats); j++)
+			ethtool_sprintf(&p,
+					hinic3_tx_queue_stats[j].name, i);
+	}
+
+	for (i = 0; i < nic_dev->q_params.num_qps; i++) {
+		for (j = 0; j < ARRAY_SIZE(hinic3_rx_queue_stats); j++)
+			ethtool_sprintf(&p,
+					hinic3_rx_queue_stats[j].name, i);
+	}
+}
+
+static void hinic3_get_strings(struct net_device *netdev,
+			       u32 stringset, u8 *data)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 offset;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		offset = hinic3_get_hw_stats_strings(nic_dev, data);
+		hinic3_get_qp_stats_strings(nic_dev,
+					    data + offset * ETH_GSTRING_LEN);
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
+		data[i] = le64_to_cpu(*(__le64 *)p);
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
+		data[i] = le64_to_cpu(*(__le64 *)p);
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
@@ -417,6 +671,9 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
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
index c5bca3c4af96..a2fe66a40b3f 100644
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
+	__le64 tx_unicast_pkts_vport;
+	__le64 tx_unicast_bytes_vport;
+	__le64 tx_multicast_pkts_vport;
+	__le64 tx_multicast_bytes_vport;
+	__le64 tx_broadcast_pkts_vport;
+	__le64 tx_broadcast_bytes_vport;
+
+	__le64 rx_unicast_pkts_vport;
+	__le64 rx_unicast_bytes_vport;
+	__le64 rx_multicast_pkts_vport;
+	__le64 rx_multicast_bytes_vport;
+	__le64 rx_broadcast_pkts_vport;
+	__le64 rx_broadcast_bytes_vport;
+
+	__le64 tx_discard_vport;
+	__le64 rx_discard_vport;
+	__le64 tx_err_vport;
+	__le64 rx_err_vport;
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
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index da73811641a9..c71bb3dff39c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -802,14 +802,14 @@ static void hinic3_get_stats64(struct net_device *netdev,
 		txq_stats = &txq->txq_stats;
 		do {
 			start = u64_stats_fetch_begin(&txq_stats->syncp);
-			bytes += txq_stats->bytes;
-			packets += txq_stats->packets;
-			dropped += txq_stats->dropped;
+			bytes = txq_stats->bytes;
+			packets = txq_stats->packets;
+			dropped = txq_stats->dropped;
 		} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
+		stats->tx_packets += packets;
+		stats->tx_bytes   += bytes;
+		stats->tx_dropped += dropped;
 	}
-	stats->tx_packets = packets;
-	stats->tx_bytes   = bytes;
-	stats->tx_dropped = dropped;
 
 	bytes = 0;
 	packets = 0;
@@ -823,17 +823,16 @@ static void hinic3_get_stats64(struct net_device *netdev,
 		rxq_stats = &rxq->rxq_stats;
 		do {
 			start = u64_stats_fetch_begin(&rxq_stats->syncp);
-			bytes += rxq_stats->bytes;
-			packets += rxq_stats->packets;
-			errors += rxq_stats->csum_errors +
-				rxq_stats->other_errors;
-			dropped += rxq_stats->dropped;
+			bytes = rxq_stats->bytes;
+			packets = rxq_stats->packets;
+			errors = rxq_stats->other_errors;
+			dropped = rxq_stats->dropped;
 		} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
+		stats->rx_packets += packets;
+		stats->rx_bytes   += bytes;
+		stats->rx_errors  += errors;
+		stats->rx_dropped += dropped;
 	}
-	stats->rx_packets = packets;
-	stats->rx_bytes   = bytes;
-	stats->rx_errors  = errors;
-	stats->rx_dropped = dropped;
 }
 
 static void hinic3_nic_set_rx_mode(struct net_device *netdev)
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
index 5d52202a8d4e..63382191446d 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -129,6 +129,110 @@ struct mag_cmd_get_xsfp_present {
 	u8                   rsvd[2];
 };
 
+struct mag_cmd_port_stats {
+	__le64 mac_tx_fragment_pkts;
+	__le64 mac_tx_undersize_pkts;
+	__le64 mac_tx_undermin_pkts;
+	__le64 mac_tx_64_oct_pkts;
+	__le64 mac_tx_65_127_oct_pkts;
+	__le64 mac_tx_128_255_oct_pkts;
+	__le64 mac_tx_256_511_oct_pkts;
+	__le64 mac_tx_512_1023_oct_pkts;
+	__le64 mac_tx_1024_1518_oct_pkts;
+	__le64 mac_tx_1519_2047_oct_pkts;
+	__le64 mac_tx_2048_4095_oct_pkts;
+	__le64 mac_tx_4096_8191_oct_pkts;
+	__le64 mac_tx_8192_9216_oct_pkts;
+	__le64 mac_tx_9217_12287_oct_pkts;
+	__le64 mac_tx_12288_16383_oct_pkts;
+	__le64 mac_tx_jumbo_bad_pkts;
+	__le64 mac_tx_jumbo_good_pkts;
+	__le64 mac_tx_oversize_pkts;
+	__le64 mac_tx_jabber_pkts;
+	__le64 mac_tx_bad_pkts;
+	__le64 mac_tx_bad_octs;
+	__le64 mac_tx_good_pkts;
+	__le64 mac_tx_good_octs;
+	__le64 mac_tx_total_pkts;
+	__le64 mac_tx_total_octs;
+	__le64 mac_tx_uni_pkts;
+	__le64 mac_tx_multi_pkts;
+	__le64 mac_tx_broad_pkts;
+	__le64 mac_tx_pause_pkts;
+	__le64 mac_tx_pfc_pkts;
+	__le64 mac_tx_pfc_pri0_pkts;
+	__le64 mac_tx_pfc_pri1_pkts;
+	__le64 mac_tx_pfc_pri2_pkts;
+	__le64 mac_tx_pfc_pri3_pkts;
+	__le64 mac_tx_pfc_pri4_pkts;
+	__le64 mac_tx_pfc_pri5_pkts;
+	__le64 mac_tx_pfc_pri6_pkts;
+	__le64 mac_tx_pfc_pri7_pkts;
+	__le64 mac_tx_control_pkts;
+	__le64 mac_tx_err_all_pkts;
+	__le64 mac_tx_from_app_good_pkts;
+	__le64 mac_tx_from_app_bad_pkts;
+
+	__le64 mac_rx_fragment_pkts;
+	__le64 mac_rx_undersize_pkts;
+	__le64 mac_rx_undermin_pkts;
+	__le64 mac_rx_64_oct_pkts;
+	__le64 mac_rx_65_127_oct_pkts;
+	__le64 mac_rx_128_255_oct_pkts;
+	__le64 mac_rx_256_511_oct_pkts;
+	__le64 mac_rx_512_1023_oct_pkts;
+	__le64 mac_rx_1024_1518_oct_pkts;
+	__le64 mac_rx_1519_2047_oct_pkts;
+	__le64 mac_rx_2048_4095_oct_pkts;
+	__le64 mac_rx_4096_8191_oct_pkts;
+	__le64 mac_rx_8192_9216_oct_pkts;
+	__le64 mac_rx_9217_12287_oct_pkts;
+	__le64 mac_rx_12288_16383_oct_pkts;
+	__le64 mac_rx_jumbo_bad_pkts;
+	__le64 mac_rx_jumbo_good_pkts;
+	__le64 mac_rx_oversize_pkts;
+	__le64 mac_rx_jabber_pkts;
+	__le64 mac_rx_bad_pkts;
+	__le64 mac_rx_bad_octs;
+	__le64 mac_rx_good_pkts;
+	__le64 mac_rx_good_octs;
+	__le64 mac_rx_total_pkts;
+	__le64 mac_rx_total_octs;
+	__le64 mac_rx_uni_pkts;
+	__le64 mac_rx_multi_pkts;
+	__le64 mac_rx_broad_pkts;
+	__le64 mac_rx_pause_pkts;
+	__le64 mac_rx_pfc_pkts;
+	__le64 mac_rx_pfc_pri0_pkts;
+	__le64 mac_rx_pfc_pri1_pkts;
+	__le64 mac_rx_pfc_pri2_pkts;
+	__le64 mac_rx_pfc_pri3_pkts;
+	__le64 mac_rx_pfc_pri4_pkts;
+	__le64 mac_rx_pfc_pri5_pkts;
+	__le64 mac_rx_pfc_pri6_pkts;
+	__le64 mac_rx_pfc_pri7_pkts;
+	__le64 mac_rx_control_pkts;
+	__le64 mac_rx_sym_err_pkts;
+	__le64 mac_rx_fcs_err_pkts;
+	__le64 mac_rx_send_app_good_pkts;
+	__le64 mac_rx_send_app_bad_pkts;
+	__le64 mac_rx_unfilter_pkts;
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
index 309ab5901379..ae4ccff4a09a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -43,10 +43,7 @@ static void hinic3_rxq_clean_stats(struct hinic3_rxq_stats *rxq_stats)
 	rxq_stats->other_errors = 0;
 	rxq_stats->dropped = 0;
 	rxq_stats->rx_buf_empty = 0;
-
-	rxq_stats->alloc_skb_err = 0;
-	rxq_stats->alloc_rx_buf_err = 0;
-	rxq_stats->restore_drop_sge = 0;
+	rxq_stats->alloc_fail = 0;
 	u64_stats_update_end(&rxq_stats->syncp);
 }
 
@@ -147,6 +144,8 @@ static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
 {
 	u32 i, free_wqebbs = rxq->delta - 1;
 	struct hinic3_rx_info *rx_info;
+	struct u64_stats_sync *syncp;
+	unsigned long flags;
 	dma_addr_t dma_addr;
 	int err;
 
@@ -155,8 +154,13 @@ static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
 
 		err = rx_alloc_mapped_page(rxq->page_pool, rx_info,
 					   rxq->buf_len);
-		if (unlikely(err))
+		if (unlikely(err)) {
+			syncp = &rxq->rxq_stats.syncp;
+			flags = u64_stats_update_begin_irqsave(syncp);
+			rxq->rxq_stats.alloc_fail++;
+			u64_stats_update_end_irqrestore(syncp, flags);
 			break;
+		}
 
 		dma_addr = page_pool_get_dma_addr(rx_info->page) +
 			rx_info->page_offset;
@@ -170,6 +174,11 @@ static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
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
@@ -330,10 +339,23 @@ static void hinic3_rx_csum(struct hinic3_rxq *rxq, u32 offload_type,
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
@@ -387,8 +409,12 @@ static int recv_one_pkt(struct hinic3_rxq *rxq, struct hinic3_rq_cqe *rx_cqe,
 	u16 num_lro;
 
 	skb = hinic3_fetch_rx_buffer(rxq, pkt_len);
-	if (unlikely(!skb))
+	if (unlikely(!skb)) {
+		u64_stats_update_begin(&rxq->rxq_stats.syncp);
+		rxq->rxq_stats.alloc_fail++;
+		u64_stats_update_end(&rxq->rxq_stats.syncp);
 		return -ENOMEM;
+	}
 
 	/* place header in linear portion of buffer */
 	if (skb_is_nonlinear(skb))
@@ -555,6 +581,7 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 	struct hinic3_nic_dev *nic_dev = netdev_priv(rxq->netdev);
 	u32 sw_ci, status, pkt_len, vlan_len;
 	struct hinic3_rq_cqe *rx_cqe;
+	u64 rx_bytes = 0;
 	u32 num_wqe = 0;
 	int nr_pkts = 0;
 	u16 num_lro;
@@ -575,6 +602,7 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 			break;
 
 		nr_pkts++;
+		rx_bytes += pkt_len;
 		num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
 		if (num_lro)
 			num_wqe += hinic3_get_sge_num(rxq, pkt_len);
@@ -588,5 +616,24 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 	if (rxq->delta >= HINIC3_RX_BUFFER_WRITE)
 		hinic3_rx_fill_buffers(rxq);
 
+	u64_stats_update_begin(&rxq->rxq_stats.syncp);
+	rxq->rxq_stats.packets += (u64)nr_pkts;
+	rxq->rxq_stats.bytes += rx_bytes;
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
+		stats->csum_errors = rxq_stats->csum_errors;
+		stats->other_errors = rxq_stats->other_errors;
+		stats->rx_buf_empty = rxq_stats->rx_buf_empty;
+		stats->alloc_fail = rxq_stats->alloc_fail;
+	} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index 06d1b3299e7c..a54184beedc9 100644
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
@@ -37,9 +41,7 @@ struct hinic3_rxq_stats {
 	u64                   other_errors;
 	u64                   dropped;
 	u64                   rx_buf_empty;
-	u64                   alloc_skb_err;
-	u64                   alloc_rx_buf_err;
-	u64                   restore_drop_sge;
+	u64                   alloc_fail;
 	struct u64_stats_sync syncp;
 };
 
@@ -125,4 +127,6 @@ int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
 			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res);
 int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget);
 
+void hinic3_rxq_get_stats(struct hinic3_rxq *rxq,
+			  struct hinic3_rxq_stats *stats);
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index f92568f0f00b..b0a0ffb1052b 100644
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
@@ -541,8 +549,12 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 	u32 offload;
 	int err;
 
-	if (skb_put_padto(skb, MIN_SKB_LEN))
+	if (skb_put_padto(skb, MIN_SKB_LEN)) {
+		u64_stats_update_begin(&txq->txq_stats.syncp);
+		txq->txq_stats.skb_pad_err++;
+		u64_stats_update_end(&txq->txq_stats.syncp);
 		goto err_out;
+	}
 
 	offload = hinic3_tx_offload(skb, &task, &queue_info, txq);
 	num_sge = skb_shinfo(skb)->nr_frags + 1;
@@ -557,10 +569,16 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
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
@@ -599,11 +617,19 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 	hinic3_write_db(txq->sq, 0, DB_CFLAG_DP_SQ,
 			hinic3_get_sq_local_pi(txq->sq));
 
+	u64_stats_update_begin(&txq->txq_stats.syncp);
+	txq->txq_stats.bytes += skb->len;
+	txq->txq_stats.packets += 1;
+	u64_stats_update_end(&txq->txq_stats.syncp);
+
 	return NETDEV_TX_OK;
 
 err_drop_pkt:
 	dev_kfree_skb_any(skb);
 err_out:
+	u64_stats_update_begin(&txq->txq_stats.syncp);
+	txq->txq_stats.dropped++;
+	u64_stats_update_end(&txq->txq_stats.syncp);
 	return NETDEV_TX_OK;
 }
 
@@ -611,18 +637,25 @@ netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 	u16 q_id = skb_get_queue_mapping(skb);
-
-	if (unlikely(!netif_carrier_ok(netdev)))
-		goto err_drop_pkt;
+	struct hinic3_txq *txq;
 
 	if (unlikely(q_id >= nic_dev->q_params.num_qps))
+		goto err_qid_out;
+
+	txq = &nic_dev->txqs[q_id];
+
+	if (unlikely(!netif_carrier_ok(netdev)))
 		goto err_drop_pkt;
 
-	return hinic3_send_one_skb(skb, netdev, &nic_dev->txqs[q_id]);
+	return hinic3_send_one_skb(skb, netdev, txq);
 
 err_drop_pkt:
-	dev_kfree_skb_any(skb);
+	u64_stats_update_begin(&txq->txq_stats.syncp);
+	txq->txq_stats.dropped++;
+	u64_stats_update_end(&txq->txq_stats.syncp);
 
+err_qid_out:
+	dev_kfree_skb_any(skb);
 	return NETDEV_TX_OK;
 }
 
@@ -795,3 +828,19 @@ bool hinic3_tx_poll(struct hinic3_txq *txq, int budget)
 
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
+		stats->busy = txq_stats->busy;
+		stats->skb_pad_err = txq_stats->skb_pad_err;
+		stats->offload_cow_skb_err = txq_stats->offload_cow_skb_err;
+		stats->map_frag_err = txq_stats->map_frag_err;
+		stats->unknown_tunnel_pkt = txq_stats->unknown_tunnel_pkt;
+	} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
index 00194f2a1bcc..9e429362b936 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
@@ -106,11 +106,9 @@ struct hinic3_txq_stats {
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
 
@@ -160,4 +158,6 @@ netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
 bool hinic3_tx_poll(struct hinic3_txq *txq, int budget);
 void hinic3_flush_txqs(struct net_device *netdev);
 
+void hinic3_txq_get_stats(struct hinic3_txq *txq,
+			  struct hinic3_txq_stats *stats);
 #endif
-- 
2.43.0

