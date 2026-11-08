Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794169589;
	b=ydjhomUxYFWWRpgTQk4baGqUBURtVRRaJTt1MlhO/pXfGvNSclGkIuLq+jocE1KDQ2Fw
	 Pl21ZfYF3+HCrrcBJB7Z0WzzQBOHpNMoJuFRLgEXBcqgVhZus98ljeEOSPLDnvmsAuhgD
	 lM5Xj1GrtE7yJFbIylfEcKF5OaRh1UBSJyzneKJ4f4LLWDTulHByDdG3baWmeCEbGtprg
	 R5ax1wcbt4SThecbiT4OJqNr8rw92FzQS1ZgtxiPlYskmzZoscws5pE7WlH4X+UxhTalq
	 Z7qVMotI3ctK2nC9OF5M72dilttcPT36Yw5JgevTi06Xq+3bVHVSOP64smvoSp4DYvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169589;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=KOnKoTtr0G+95E4kIHiWBdMZq2QsDidi9kYg1lWUExE=;
	b=gNfvwBCxqiR/L07HJzyJRdSofq4EOQvmt5+gYYvbW2uUzoRm689VH3Lo3vPkHID3AksG
	 0f27YmjXJth7cgsJldq37ilHPoZ8rbE9RnM4/lIV7uPFEDX3GWPPWzYJmqU3pQ9zI/ydg
	 rXPX0f2IkjJ++LBf+oYGYhtZsUYZJO2dJlDz6qCzCgW1uqboUk6aE0zqGp+23//ZWCghY
	 H+++xulKooPl3w4c+GwOKR8ldhaB79G1pZR1Dipl4vx7NEYpogq8KnlfGk1ECJiSl/omt
	 8uqikJciMB3hibTH3YHjjLiOvrtP5quOnJzo5GAusrLtr0GrtjMDeycwGuwpuXvWQ7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=machnikowski.net;
	spf=pass smtp.mailfrom=machnikowski.net;
	dkim=pass header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=d7kwtDtq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4F606BA4C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 20:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27E4F606BA4C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=d7kwtDtq
ARC-Seal: i=1; a=rsa-sha256; t=1794169554; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Fh5F9uA3pKYI/BGmpnkDpjqkQxE7i6bmoiy964mCfviv2MxOOmQoBJKkd2J4KjQrVzCRK+DwgLa8E19n/XbXVHRvNKe8Cgf+ioFodS8q4jFmKGRIB4Z1seBI44XeSx1iM/qKp3AQS+3y+5PKEagVbiU6C8Ho2jOG/+7rqiEmncg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794169554; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KOnKoTtr0G+95E4kIHiWBdMZq2QsDidi9kYg1lWUExE=; 
	b=jZJT6XA964wqaei5uwrP4nEdTokMT6oyB769GqSUcbdJxqTq0jUJbQBro2SWIQWSzTpRj6y6eKFXHwcYy50TH0p7Kf5UA+L5JxOCQ9+7HMNNL0iWHjROXk8AuLV/a5WbFSjlePZ6Bt0BITsoezzldC2mgtfeDuZSjr0V2O/lNQU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: a=rsa-sha256; b=d7kwtDtqWlTCbV0e5xySxI3BsVWoscozkeUmf5r/6lFxXOa0ekv7htzEiEwqj1A4ERGf9dQK/r87mdiBgT2qpPFSNM5W5i0Et1H+EOYQe5bzm4y+Yqmdfx1t/kJCEqPV7tv7wXbVTwlp8mKVuHos9Z6WjA6dFL5TJ44BfAJjZbLFCqHdZSabWYVvaIhgryhYmmhKUsLcQUOiDmxdmY4pLvoCRAcsW3fKrhm+Ikw1TOe1QqEPylhRoWF4KzWCu7vdE3FJqmL6YnWSALo9Igliu+OwVgblRaI7E7V7jZYAt2RRIOfJBiSAYoVacNK3Z4yS5pnhTowFY3SJ0y9vvethjA==; c=relaxed/relaxed; s=zoho; d=machnikowski.net; v=1; bh=KOnKoTtr0G+95E4kIHiWBdMZq2QsDidi9kYg1lWUExE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794169552409432.1850015187862;
	Sun, 8 Nov 2026 12:25:52 -0800 (PST)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	horms@kernel.org,
	almasrymina@google.com
Subject: [PATCH v12 net-next 2/3] netdevsim: Implement basic ptp support
Date: Sun,  8 Nov 2026 21:15:02 +0100
Message-ID: <20261108201503.85000-3-maciek@machnikowski.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108201503.85000-1-maciek@machnikowski.net>
References: <20261108201503.85000-1-maciek@machnikowski.net>
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
X-ZohoMailClient: External

Add support for virtual timestamping inside the netdevsim driver.
The implementation uses two attached ptp_mock clocks, reads the timestamps
of the ones attached either to the netdevsim or its peer and returns
timestamps using standard timestamps APIs.

This implementation enables running ptp4l on netdevsim adapters and
introduces a new ptp selftest.

skb_hwtstamps(skb)->hwtstamp aliases with skb_shinfo(skb)->xsk_meta in
the skb_shared_info union. For an AF_XDP generic-xmit skb forwarded to
a peer with RX timestamping enabled, writing the RX timestamp into
that union turns xsk_meta.tx_timestamp into a PHC-derived value that
the AF_XDP destructor (xsk_destruct_skb()) later dereferences as a
pointer, corrupting memory. Orphan the skb before writing the RX
timestamp so any pending destructor (e.g. the AF_XDP completion) runs
against the original, unmodified union contents first.

Co-developed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 drivers/net/netdevsim/ethtool.c   |  15 ++++
 drivers/net/netdevsim/netdev.c    | 124 ++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |   1 +
 3 files changed, 140 insertions(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index c3d2bc783d55..3f1f1510b6f8 100644
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
index 0372a9bd63bb..f098520bdb03 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -30,6 +30,8 @@
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
 #include <net/busy_poll.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/timecounter.h>
 
 #include "netdevsim.h"
 
@@ -122,7 +124,11 @@ static int nsim_forward_skb(struct net_device *tx_dev,
 
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct skb_shared_hwtstamps shhwtstamps = {};
+	struct ptp_clock_info *ptp_info_tx = NULL;
+	struct ptp_clock_info *ptp_info_rx = NULL;
 	struct netdevsim *ns = netdev_priv(dev);
+	struct timespec64 tx_ts, rx_ts;
 	struct skb_ext *psp_ext = NULL;
 	struct net_device *peer_dev;
 	unsigned int len = skb->len;
@@ -167,7 +173,53 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	      cfg->hds_thresh > len)))
 		skb_linearize(skb);
 
+	if (unlikely(READ_ONCE(peer_ns->tstamp_config.rx_filter) !=
+		     HWTSTAMP_FILTER_NONE))
+		ptp_info_rx = mock_phc_get_ptp_info(peer_ns->phc);
+
+	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
+	    READ_ONCE(ns->tstamp_config.tx_type) == HWTSTAMP_TX_ON) {
+		ptp_info_tx = mock_phc_get_ptp_info(ns->phc);
+		if (ptp_info_tx)
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+	}
+
 	skb_tx_timestamp(skb);
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
+			skb_tstamp_tx(skb, &shhwtstamps);
+		}
+
+		/* Clones (e.g. the TX timestamp errqueue skb) share shinfo */
+		if (unlikely(skb_unclone(skb, GFP_ATOMIC))) {
+			kfree_skb(skb);
+			if (psp_ext)
+				__skb_ext_put(psp_ext);
+			goto out_drop_cnt;
+		}
+
+		if (ptp_info_rx) {
+			/* hwtstamp aliases xsk_meta; orphan first so any
+			 * pending AF_XDP completion isn't corrupted.
+			 */
+			skb_orphan(skb);
+			skb_hwtstamps(skb)->hwtstamp =
+				timespec64_to_ktime(rx_ts);
+		} else {
+			/* Don't leak the TX timestamp as an RX timestamp */
+			skb_hwtstamps(skb)->hwtstamp = 0;
+		}
+	}
+
 	if (unlikely(nsim_forward_skb(dev, peer_dev,
 				      skb, rq, psp_ext) == NET_RX_DROP))
 		goto out_drop_cnt;
@@ -197,6 +249,76 @@ static netdev_tx_t nsim_start_xmit_vf(struct sk_buff *skb,
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
+	if (config->flags) {
+		NL_SET_ERR_MSG_MOD(extack, "Flags are not supported");
+		return -EINVAL;
+	}
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		rx_filter = HWTSTAMP_FILTER_NONE;
+		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
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
+	if (!ns->phc)
+		return -EOPNOTSUPP;
+
+	config->tx_type = READ_ONCE(ns->tstamp_config.tx_type);
+	config->rx_filter = READ_ONCE(ns->tstamp_config.rx_filter);
+
+	return 0;
+}
+
 static int nsim_set_rx_mode(struct net_device *dev,
 			    struct netdev_hw_addr_list *uc,
 			    struct netdev_hw_addr_list *mc)
@@ -668,6 +790,8 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_vlan_rx_add_vid	= nsim_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= nsim_vlan_rx_kill_vid,
 	.net_shaper_ops		= &nsim_shaper_ops,
+	.ndo_hwtstamp_get	= nsim_get_ts_config,
+	.ndo_hwtstamp_set	= nsim_set_ts_config,
 };
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 2aa7ea924396..68a7aff0384a 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -111,6 +111,7 @@ struct netdevsim {
 	struct net_device *netdev;
 	struct nsim_dev *nsim_dev;
 	struct nsim_dev_port *nsim_dev_port;
+	struct kernel_hwtstamp_config tstamp_config;
 	struct mock_phc *phc;
 	struct nsim_rq **rq;
 
-- 
2.56.0

