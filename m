Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE7B10E3
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771510010; cv=pass; b=CmgL2SvHuCOpF/oLc5l54Q9Gnb+cV8mj3FRqnT/dRyVNof5UTqP3zZ1jHIAo6YJFba7x2lo0hu2YJpQDV8Ymdncs2WfPy1nXPAImKJyHCVSyjJ96SEaL4V4lp3Nc2VJLM8YwbpuFfJp+IMUjgb7qnQteR78d9rlH5sAMvFFgbIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771510010; c=relaxed/simple;
	bh=sjoE20zT4pnMtIR9PoInivKQVbr8JtJ/xWhagjbGUCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6noZgMm20/q43fww5xujXA8wYmeU8GcAiV/2STaPIRi7k3aA1GLmy+f3dVnJH41IIeWIKr50ap/OM7lbjxOIE/mNlk98hPHMkNcPT743GWomu3OCuY4ifM5S58cFpEuW66n0zSYPrpyPuvziFyrjlWawt+fMM9gkfiaxwMNKlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=e2xO5F01; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="e2xO5F01"
ARC-Seal: i=1; a=rsa-sha256; t=1771509938; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X4bB5OkoXYXu69Pp1fpoJAstD7fUY6yqv4qEC6LDC2qpk0NdEM3A4hiFZsKVx0JBWBYp1tqj+b9mFq7TZyZrNPHrVr9DL8ZiTE7axOw95DIABec8lW0dd5tDt1qsPqMK9DPA6qQGlNq2raeimNJiiOJISDi4m8YkwysrrO/0XE4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771509938; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Nt5BD38f4fdgLNDYdDvyo2kQMjOd0jRtMjgseOFlf64=; 
	b=dzP12TVtdBoI/WJicgek8aXY7LV7x/WS5rxUQsttYDnj/zOSlxLp8xE4Et+7/uxr0207dteVDCaumgBcVW/PbI00NyKVKIDVWUUHJbVpEtaHthOHDGhA8Wi8sHoThQwG51bDk55Z0hYf/niGAjCUK348CKSkbtgS2+vffPto88k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771509938;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Nt5BD38f4fdgLNDYdDvyo2kQMjOd0jRtMjgseOFlf64=;
	b=e2xO5F01qZKsUHsrgsHB9jg8Mkaf6dGBEUyecKOxk8CVeIDvT4nYrG2Byd6xLcr1
	YL3zfvjK4FYZurnmdX850xZBXvWFpT6V352QPSunZbkbDwtE2uP8Koc0xoBSRmzfOIA
	hzXjy+H5Pbh01dBnEUHvFsAnl520Sj7T3VnAMon6/F4ITVX3GDxk2Dtp9B/h7iBWmAR
	fLmufwDXpuB3rGGrNF0GiD81JYqbALgli0U3O56pFZQMUfYEC3FUt9V748y3YQDoUIa
	iJsQRN+gnHkUmrYq4twDVefhXgSEfwLl/z60ues9sb0+1hPY1bm7rlb9X/ATM/7aS1+
	Ad+5uR8Y1Q==
Received: by mx.zohomail.com with SMTPS id 1771509936237194.45849243689963;
	Thu, 19 Feb 2026 06:05:36 -0800 (PST)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: kuba@kernel.org
Cc: maciek@machnikowski.net,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	milena.olech@intel.com
Subject: [PATCH net-next 2/2] netdevsim: Implement basic ptp support
Date: Thu, 19 Feb 2026 15:05:30 +0100
Message-ID: <20260219140530.2148-3-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219140530.2148-1-maciek@machnikowski.net>
References: <20260219140530.2148-1-maciek@machnikowski.net>
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

This implementation enables running ptp4l on netdevsim adapters.

Co-developed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 drivers/net/netdevsim/ethtool.c   | 12 +++++
 drivers/net/netdevsim/netdev.c    | 90 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  1 +
 3 files changed, 103 insertions(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 36a201533..367c7ca8b 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -201,6 +201,18 @@ static int nsim_get_ts_info(struct net_device *dev,
 	struct netdevsim *ns = netdev_priv(dev);
 
 	info->phc_index = mock_phc_index(ns->phc);
+	if (info->phc_index < 0)
+		return 0;
+
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
+				SOF_TIMESTAMPING_RX_SOFTWARE |
+				SOF_TIMESTAMPING_SOFTWARE |
+				SOF_TIMESTAMPING_TX_HARDWARE |
+				SOF_TIMESTAMPING_RX_HARDWARE |
+				SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
 
 	return 0;
 }
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 6285fbefe..b1161c1ca 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -30,6 +30,8 @@
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
 #include <net/busy_poll.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/timecounter.h>
 
 #include "netdevsim.h"
 
@@ -119,12 +121,17 @@ static int nsim_forward_skb(struct net_device *tx_dev,
 
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct skb_shared_hwtstamps shhwtstamps = {};
 	struct netdevsim *ns = netdev_priv(dev);
+	struct ptp_clock_info *ptp_info;
+	struct timespec64 tx_ts, rx_ts;
+	struct sk_buff *skb_orig = skb;
 	struct skb_ext *psp_ext = NULL;
 	struct net_device *peer_dev;
 	unsigned int len = skb->len;
 	struct netdevsim *peer_ns;
 	struct netdev_config *cfg;
+	bool gen_tx_tstamp = false;
 	struct nsim_rq *rq;
 	int rxq;
 	int dr;
@@ -161,6 +168,27 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb_linearize(skb);
 
 	skb_tx_timestamp(skb);
+	gen_tx_tstamp = skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP;
+	if (gen_tx_tstamp) {
+		ptp_info = mock_phc_get_ptp_info(ns->phc);
+
+		/* Create a copy of tx skb to keep the tx reference */
+		skb_orig = skb;
+		skb = skb_copy(skb_orig, GFP_ATOMIC);
+		skb_shinfo(skb_orig)->tx_flags |= SKBTX_IN_PROGRESS;
+
+		/* Timestamp as late as possible */
+		if (ptp_info)
+			ptp_info->gettime64(ptp_info, &tx_ts);
+	}
+
+	/* Generate Rx tstamp based on the peer clock */
+	ptp_info = mock_phc_get_ptp_info(peer_ns->phc);
+	if (ptp_info) {
+		ptp_info->gettime64(ptp_info, &rx_ts);
+		skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(rx_ts);
+	}
+
 	if (unlikely(nsim_forward_skb(dev, peer_dev,
 				      skb, rq, psp_ext) == NET_RX_DROP))
 		goto out_drop_cnt;
@@ -168,6 +196,13 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (!hrtimer_active(&rq->napi_timer))
 		hrtimer_start(&rq->napi_timer, us_to_ktime(5), HRTIMER_MODE_REL);
 
+	/* only timestamp the outbound packet if user requested it */
+	if (gen_tx_tstamp) {
+		shhwtstamps.hwtstamp = timespec64_to_ktime(tx_ts);
+		skb_tstamp_tx(skb_orig, &shhwtstamps);
+		dev_kfree_skb_any(skb_orig);
+	}
+
 	rcu_read_unlock();
 	dev_dstats_tx_add(dev, len);
 	return NETDEV_TX_OK;
@@ -182,6 +217,59 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
 static void nsim_set_rx_mode(struct net_device *dev)
 {
 }
@@ -660,6 +748,8 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_open		= nsim_open,
 	.ndo_stop		= nsim_stop,
 	.net_shaper_ops		= &nsim_shaper_ops,
+	.ndo_hwtstamp_get	= nsim_get_ts_config,
+	.ndo_hwtstamp_set	= nsim_set_ts_config,
 };
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index f767fc8a7..6d3e8700c 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -103,6 +103,7 @@ struct netdevsim {
 	struct net_device *netdev;
 	struct nsim_dev *nsim_dev;
 	struct nsim_dev_port *nsim_dev_port;
+	struct kernel_hwtstamp_config tstamp_config;
 	struct mock_phc *phc;
 	struct nsim_rq **rq;
 
-- 
2.53.0

