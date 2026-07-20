Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54438AC7D
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571268; cv=pass; b=ZudoVPhNuCNKWOL3jIcQP+tGQIA5jjDEq2MosOLDuD3ytprZQJhdf9zEkiespY3yz2uH///NMWDAd3CTxmWqnhVwNqtLMa7TP+DQiekcPh+f0lwtckVSiqq5qB0uUv3qQ2NtqWeIfuTljI1eC1L6Yc2sasmQM0R7WOkP6PnIyd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571268; c=relaxed/simple;
	bh=4IeYdtHES6R1DhNGaToysOlfujefHc5huxEoMN7BuXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWPXPAv/kojaZvWewJArzLO8kxqNVmXHouBh6lywU04dT01bRPjad6yH9EYseshE3wxHq842bofN8Kypv2rC4y2P0GRN8s/2yoO24f+HhKO8EaYmn77R+0qbQLYhughIq5dvXyFDy8g0VQDvzoE8bJwRVu+quhi2Boe0Sz7fF0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=F37kT0ke; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="F37kT0ke"
ARC-Seal: i=1; a=rsa-sha256; t=1784571234; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aexmLvYT1hHyLMCPV3W70FohVWPgOsrFC0YY8An3XTL4qIMkcY4JCOvRAPC/oI7582oh4GeiGqOweBRb0KC/8jQasT7hE9wa9RI6vWTDfLNFsYYIUC3VtA6mdxt1pm7UD4zvpz6iqMoY7LIUYoQuiadbHdcZJhUR8X9amw0JhVA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784571234; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZQL2wz45HgIfQMpsL436sxQg82GSLFRQm0pdzgiTzFk=; 
	b=NfGmS1NwP3eMoj7XxnwgY+DPD6vdrmbrSRY9tXsmAxOFhURPDIFjtgxIRMxn9FO9BMZTDX+WQwvsbl+ld627ErCJMWtNEfOwPxDN1EfojHDW0xtw2IluJc5nr4JVLqlsqVRWTAPPEy/kFs3elsjpfhB/zZ/gOo1l+G3ShydcPIw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784571234;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZQL2wz45HgIfQMpsL436sxQg82GSLFRQm0pdzgiTzFk=;
	b=F37kT0ker7X5uUZLwQL56Qz4815gl7h0CBwPVX9Q+uD6U58TCHWNNJx3KHUPAagc
	6T8Lsa7rbZq2HPSkW4IeXyOVD6I+vBh68sCufSrPL1YA4Vl+OztrHL8e6m6CDTF6tMk
	17pQ7xbxRiBsL5jcHzOett1I0vb5hdIirkcSo2N5gVhTqu3DGBkxn+B7F//K817Vl7U
	XhyT5fmG74wINZvXy/YiGVsxQL3P031jFMTBi50nHjsBlMLHN9l15qlaN0zUWTv1CUS
	btS4vBWQqfPKyqN/Pj3WKveS617y5R6I5eL97XGozj7ViFlDGgXI/gGI3iEbEEX1Bng
	RroPYfdlWQ==
Received: by mx.zohomail.com with SMTPS id 1784571232956115.55070817019543;
	Mon, 20 Jul 2026 11:13:52 -0700 (PDT)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Subject: [PATCH v7 net-next 2/3] netdevsim: Implement basic ptp support
Date: Mon, 20 Jul 2026 20:11:12 +0200
Message-ID: <20260720181113.3293-3-maciek@machnikowski.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720181113.3293-1-maciek@machnikowski.net>
References: <20260720181113.3293-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add support for virtual timestamping inside the netdevsim driver.
The implementation uses two attached ptp_mock clocks, reads the timestamps
of the ones attached either to the netdevsim or its peer and returns
timestamps using standard timestamps APIs.

This implementation enables running ptp4l on netdevsim adapters and
introduces a new ptp selftest.

Co-developed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 drivers/net/netdevsim/ethtool.c   | 11 ++++
 drivers/net/netdevsim/netdev.c    | 94 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  1 +
 3 files changed, 106 insertions(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 025ea79879f3..628878acd158 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -200,7 +200,18 @@ static int nsim_get_ts_info(struct net_device *dev,
 {
 	struct netdevsim *ns = netdev_priv(dev);
 
+	ethtool_op_get_ts_info(dev, info);
+
 	info->phc_index = mock_phc_index(ns->phc);
+	if (info->phc_index < 0)
+		return 0;
+
+	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
+				 SOF_TIMESTAMPING_RX_HARDWARE |
+				 SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
 
 	return 0;
 }
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 4e9d7e10b527..2e31c04adf78 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -30,6 +30,8 @@
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
 #include <net/busy_poll.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/timecounter.h>
 
 #include "netdevsim.h"
 
@@ -122,7 +124,12 @@ static int nsim_forward_skb(struct net_device *tx_dev,
 
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct skb_shared_hwtstamps shhwtstamps = {};
+	struct ptp_clock_info *ptp_info_tx = NULL;
+	struct ptp_clock_info *ptp_info_rx = NULL;
 	struct netdevsim *ns = netdev_priv(dev);
+	struct timespec64 tx_ts, rx_ts;
+	struct sk_buff *skb_orig = skb;
 	struct skb_ext *psp_ext = NULL;
 	struct net_device *peer_dev;
 	unsigned int len = skb->len;
@@ -164,6 +171,36 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb_linearize(skb);
 
 	skb_tx_timestamp(skb);
+
+	if (peer_ns->tstamp_config.rx_filter != HWTSTAMP_FILTER_NONE)
+		ptp_info_rx = mock_phc_get_ptp_info(peer_ns->phc);
+
+	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
+	    ns->tstamp_config.tx_type == HWTSTAMP_TX_ON)
+		ptp_info_tx = mock_phc_get_ptp_info(ns->phc);
+
+	/* If TX hardware timestamping is enabled, sample our PHC and report
+	 * the TX timestamp back.
+	 */
+	if (ptp_info_tx) {
+		ptp_info_tx->gettime64(ptp_info_tx, &tx_ts);
+		if (likely(ptp_info_rx))
+			ptp_info_rx->gettime64(ptp_info_rx, &rx_ts);
+		shhwtstamps.hwtstamp = timespec64_to_ktime(tx_ts);
+		skb_tstamp_tx(skb_orig, &shhwtstamps);
+
+		skb = skb_copy(skb_orig, GFP_ATOMIC);
+		if (skb)
+			consume_skb(skb_orig);
+		else
+			skb = skb_orig;
+	} else if (ptp_info_rx) {
+		ptp_info_rx->gettime64(ptp_info_rx, &rx_ts);
+	}
+
+	if (ptp_info_rx)
+		skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(rx_ts);
+
 	if (unlikely(nsim_forward_skb(dev, peer_dev,
 				      skb, rq, psp_ext) == NET_RX_DROP))
 		goto out_drop_cnt;
@@ -185,6 +222,61 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+static int nsim_set_ts_config(struct net_device *netdev,
+			      struct kernel_hwtstamp_config *config,
+			      struct netlink_ext_ack *extack)
+{
+	struct netdevsim *ns = netdev_priv(netdev);
+
+	if (!ns->phc)
+		return -EOPNOTSUPP;
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_OFF:
+		ns->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
+		break;
+	case HWTSTAMP_TX_ON:
+		ns->tstamp_config.tx_type = HWTSTAMP_TX_ON;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		ns->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_NTP_ALL:
+	case HWTSTAMP_FILTER_ALL:
+		ns->tstamp_config.rx_filter = HWTSTAMP_FILTER_ALL;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	config->rx_filter = ns->tstamp_config.rx_filter;
+
+	return 0;
+}
+
+static int nsim_get_ts_config(struct net_device *netdev,
+			      struct kernel_hwtstamp_config *config)
+{
+	struct netdevsim *ns = netdev_priv(netdev);
+
+	*config = ns->tstamp_config;
+	return 0;
+}
+
 static int nsim_set_rx_mode(struct net_device *dev,
 			    struct netdev_hw_addr_list *uc,
 			    struct netdev_hw_addr_list *mc)
@@ -647,6 +739,8 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_vlan_rx_add_vid	= nsim_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= nsim_vlan_rx_kill_vid,
 	.net_shaper_ops		= &nsim_shaper_ops,
+	.ndo_hwtstamp_get	= nsim_get_ts_config,
+	.ndo_hwtstamp_set	= nsim_set_ts_config,
 };
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 64f77f93d937..5cdd1e294446 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -108,6 +108,7 @@ struct netdevsim {
 	struct net_device *netdev;
 	struct nsim_dev *nsim_dev;
 	struct nsim_dev_port *nsim_dev_port;
+	struct kernel_hwtstamp_config tstamp_config;
 	struct mock_phc *phc;
 	struct nsim_rq **rq;
 
-- 
2.55.0

