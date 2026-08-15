Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807061C2324
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786775549; cv=pass; b=mixFIYY4NTZcQgiCBPUBSVy2RQhv4+Ku0XR1Z4ZvO1nBPQxkJveymjFJjmytSOrl119BN+QRSfXLs/gTV4VuEbfnoUupdUKD1Sx7XWRXrlal7ypLFjr8yUcUvR4ASxSkMDmcMb1hall+v1Ok1cyZqXeSwIGPufv66QaCKwjdWVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786775549; c=relaxed/simple;
	bh=t+4zdni4mh/bylAe1Ld++1a2HW3kg4t3fN6oYSr2css=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcpTYbVr6uXkyLdGcBJJJxd1xEsEnP5PDBe0+Gr0TMAA7gA3qUXXXGmvsgGD2sFqMW/MmxkBrkfn1M0RwdJsXV7DpKW8PmL7sba1bTdnrh9sMVzx2S91Otej/FglABBjFp3MWStS1WeAd9UE7cef+HyV4B7Dua7o8KAQgOpbK0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=LFzijZK7; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="LFzijZK7"
ARC-Seal: i=1; a=rsa-sha256; t=1786775518; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AbAmmVXBaAjFxheEa0iDHgc9D1pOD13s/hnFtbxqOiU2DxmQwf44stpXb1jFE52WZizo58kpmZ4uLnkWySlhUw493xj85a/WrWNdqqcvCXhJhXJYImMA/z049pkiIMnJWVA+HSEehjVjnS9K+Llvh00xe6ljvhWUDOBpQh/ojgs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786775518; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Jh0XbWs4QxU7qeTFmJu2oxwGLvLwdtDT+cgLM2gnBcg=; 
	b=XX8vdJTC415x90p4X/peuHxP3gMyDN/Dlw0DSuRfA75sle2efSWtC5oF8Jpu9SFJOm+f2th61fCYm2CnmWHEEZSIDhAz6l89MdCVH8oA20+T9MEczze0fsXZHXGVSFHqO9pUim4IofCjtT5Wd5nnlKjwXIboOJF+ZY2g2BTLTi4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786775518;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Jh0XbWs4QxU7qeTFmJu2oxwGLvLwdtDT+cgLM2gnBcg=;
	b=LFzijZK7bm9QSnHQBIvjUpVTOefNwuxpxgcGp7YddAulYl4FmlVcheYBrXchy50+
	CNdBq7Y+MggP9xSzVsVkFh1foZPIl5H6FdCTM/DBwtEQ/BLYB8KNsIM9Og/EBfaMpWS
	21n5Mr0p86Z+pJ/iuVuIr+x3s/68JpfJvD8uqSUH947hEiJn8LxSF6vWLx8cyL5tlg2
	14Lb7atKQWjh1jpKZfWIYdC2psHXrddd/mfyHlPIqXX9uJgOzyTOWyl8VhaY6NihDAi
	STFoiEew1IFZaPnqRvFsqCRooskbSJEvvg7ZB74c5ngeAT1KzhSeWP/DCjeLajQ2wRj
	YihRPfmQwA==
Received: by mx.zohomail.com with SMTPS id 1786775516972443.86848981972685;
	Fri, 14 Aug 2026 23:31:56 -0700 (PDT)
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
Subject: [PATCH v10 net-next 2/3] netdevsim: Implement basic ptp support
Date: Sat, 15 Aug 2026 08:31:47 +0200
Message-ID: <20260815063148.2952-3-maciek@machnikowski.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815063148.2952-1-maciek@machnikowski.net>
References: <20260815063148.2952-1-maciek@machnikowski.net>
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
 drivers/net/netdevsim/ethtool.c   |  15 +++++
 drivers/net/netdevsim/netdev.c    | 104 ++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |   1 +
 3 files changed, 120 insertions(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 025ea79879f3..24e7d5592e79 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -200,7 +200,22 @@ static int nsim_get_ts_info(struct net_device *dev,
 {
 	struct netdevsim *ns = netdev_priv(dev);
 
+	ethtool_op_get_ts_info(dev, info);
+	if (!ns->phc) {
+		info->phc_index = -1;
+		return 0;
+	}
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
index 4e9d7e10b527..e586fd8f3bc3 100644
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
@@ -164,6 +171,44 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb_linearize(skb);
 
 	skb_tx_timestamp(skb);
+
+	if (unlikely(READ_ONCE(peer_ns->tstamp_config.rx_filter) !=
+		     HWTSTAMP_FILTER_NONE))
+		ptp_info_rx = mock_phc_get_ptp_info(peer_ns->phc);
+
+	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
+	    READ_ONCE(ns->tstamp_config.tx_type) == HWTSTAMP_TX_ON)
+		ptp_info_tx = mock_phc_get_ptp_info(ns->phc);
+
+	if (unlikely(ptp_info_tx || ptp_info_rx)) {
+		/* Capture both timestamps closely */
+		if (ptp_info_tx)
+			ptp_info_tx->gettime64(ptp_info_tx, &tx_ts);
+		if (ptp_info_rx)
+			ptp_info_rx->gettime64(ptp_info_rx, &rx_ts);
+
+		/* If TX hardware timestamping is enabled report TX timestamp */
+		if (ptp_info_tx) {
+			shhwtstamps.hwtstamp = timespec64_to_ktime(tx_ts);
+			skb_tstamp_tx(skb_orig, &shhwtstamps);
+		}
+
+		/* Unshare the skb, stamping it must not corrupt cloned copies
+		 * and prevents returning single tstamp for Tx and Rx
+		 */
+		skb = skb_unshare(skb_orig, GFP_ATOMIC);
+		if (unlikely(!skb)) {
+			if (psp_ext)
+				__skb_ext_put(psp_ext);
+			goto out_drop_cnt;
+		}
+
+		/* If RX hardware timestamping is enabled report RX timestamp */
+		if (ptp_info_rx)
+			skb_hwtstamps(skb)->hwtstamp =
+				timespec64_to_ktime(rx_ts);
+	}
+
 	if (unlikely(nsim_forward_skb(dev, peer_dev,
 				      skb, rq, psp_ext) == NET_RX_DROP))
 		goto out_drop_cnt;
@@ -185,6 +230,63 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+static int nsim_set_ts_config(struct net_device *netdev,
+			      struct kernel_hwtstamp_config *config,
+			      struct netlink_ext_ack *extack)
+{
+	struct netdevsim *ns = netdev_priv(netdev);
+	int rx_filter;
+
+	if (!ns->phc)
+		return -EOPNOTSUPP;
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		rx_filter = HWTSTAMP_FILTER_NONE;
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
+		rx_filter = HWTSTAMP_FILTER_ALL;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_OFF:
+		WRITE_ONCE(ns->tstamp_config.tx_type, HWTSTAMP_TX_OFF);
+		break;
+	case HWTSTAMP_TX_ON:
+		WRITE_ONCE(ns->tstamp_config.tx_type, HWTSTAMP_TX_ON);
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	WRITE_ONCE(ns->tstamp_config.rx_filter, rx_filter);
+	config->rx_filter = rx_filter;
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
@@ -647,6 +749,8 @@ static const struct net_device_ops nsim_netdev_ops = {
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

