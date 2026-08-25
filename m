Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAAE39446D
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649566; cv=none; b=lWYz4hsHhxb8XvGL3rESS+zPly3uaEtcZfGgIE8MZx4mPP1hnSj/g/RpjIuRgzLH2oUqp2lWpwEpXaz0dwUOPCErl8tJQzJ/VssfpJQkXv7QsW9L87yf5CeCYrLqIMEuSwIPV48wlSHFeGwtQsR8n6OIVzdFklnsrxcBqCO6qkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649566; c=relaxed/simple;
	bh=Vn3AKbB8ZvbzsvjI/cHUjpWdEhpZxCDoaRUSFh7u5PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDql4h7dbUvd4lLhv7yd2vgl0ejD2ahjwCXT6Pd5C4PZUuuRUJiEgKYAFWVTrwFKl6Pr6kUnv4PAywfW5IiIpK2o38A036nTunBq5s9TraQtmx+X0SRO2eP1bY6pfvPjUx/RaoPCTHbIVqMB58mylOY9F+GAFDBcOx06e995IoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=XV4Oc1qK; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="XV4Oc1qK"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202608250919132599736b0e00020705
        for <netdev@vger.kernel.org>;
        Tue, 25 Aug 2026 11:19:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=u3r/oMrLHrFnt131fALCYPtJfXT5iOrA4SwySm4Z15A=;
 b=XV4Oc1qKGpKnTsoiE85NG/Ub+XAvD6aaBDzvVgqtaUYEfaa+w3fMnqhibFfrMeQVem2jey
 +XBxKbilCNhqQ9n85Epc11342Um0IIsE3YAE8QLEBzvRfX9qbGj6RQa2NANC5lG9f7/vY93k
 G+sHvy6BZLiPcn9oS9CdtZNSUeZmwl50eHA3lWbOa3XWVERwBBqdLmE0PV+uC5+zmwm02u45
 6/YL/5O6opoDvlPNt5g4McVwTKpEcfqyvD55B9XAXS3ddN36nJ3EEXfibEWU2b65IbxTCjrK
 R8pcaafqOxLsEk4hdaXH1De75OZM4HLq+HdT6Lh/BUw6bZHqzTnoU2JA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Wei Fang <wei.fang@nxp.com>,
	Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: fec: support RX flushing via an ethtool private flag
Date: Tue, 25 Aug 2026 11:19:06 +0200
Message-ID: <20260825091908.1362677-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

The FEC controller can flush the RX FIFO of an individual receive queue
through the RX_FLUSHn bits of the FEC_QOS_SCHEME (ENET_QOS) register.

RX flushing prevents frames in the RX FIFO from being blocked. Blocking
can occur when the frame at the head of the RX FIFO cannot be forwarded
because the ring it is associated with cannot accept it, i.e. when the
ring's RxBD[EMPTY] is not set or ENET_RDARn is not set. When RX flushing
is enabled for a ring, such a blocking frame is flushed (discarded)
instead of stalling the FIFO and holding up the other rings.

Expose this per-queue capability as a runtime ethtool private flag
("rx-flush-qN").

Due to erratum ERR050395 (observed e.g. on i.MX8QXP), enabling RX flushing
on more than one queue at a time can lock up the receive path, so only a
single queue may have flushing enabled.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Initial attempt to provide the same functionality has been DT-based (and
can be considered a v1):
https://lore.kernel.org/all/20260814090906.2225075-1-alexander.sverdlin@siemens.com/

 .../device_drivers/ethernet/freescale/fec.rst | 55 ++++++++++++++
 .../device_drivers/ethernet/index.rst         |  1 +
 MAINTAINERS                                   |  1 +
 drivers/net/ethernet/freescale/fec.h          |  9 +++
 drivers/net/ethernet/freescale/fec_main.c     | 74 +++++++++++++++++++
 5 files changed, 140 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/freescale/fec.rst

diff --git a/Documentation/networking/device_drivers/ethernet/freescale/fec.rst b/Documentation/networking/device_drivers/ethernet/freescale/fec.rst
new file mode 100644
index 0000000000000..502261f517e05
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/freescale/fec.rst
@@ -0,0 +1,55 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+Freescale Fast Ethernet Controller (FEC)
+========================================
+
+The Fast Ethernet Controller (FEC), also known as ENET, is the Ethernet MAC
+found on many Freescale/NXP SoCs, including the i.MX and Vybrid families. This
+document describes driver-specific configuration that is not covered by the
+generic networking documentation.
+
+Ethtool private flags
+======================
+
+Some hardware features that are specific to the FEC and have no generic ethtool
+control are exposed as ethtool private flags. The set of available flags depends
+on the SoC and on the driver configuration (for example, the number of receive
+queues), so the flags are enumerated at runtime::
+
+	$ ethtool --show-priv-flags ethX
+
+	$ ethtool --set-priv-flags ethX <flag> on|off
+
+rx-flush-qN
+-----------
+
+On multi-queue capable controllers the driver exposes one ``rx-flush-qN``
+private flag per receive queue (``rx-flush-q0``, ``rx-flush-q1``, ...), which
+enables RX flushing for that queue. RX flushing is disabled by default.
+
+The controller uses a single RX FIFO that is shared by all receive queues. A
+received frame is only removed from the head of the FIFO once it has been
+copied into the buffer descriptor ring of the queue it is destined for. If that
+ring cannot currently accept the frame - i.e. its next buffer descriptor is not
+marked empty (``RxBD[EMPTY]`` is clear) or the ring has not been (re)activated
+(``ENET_RDARn`` is clear) - the frame stays at the head of the FIFO and blocks
+all subsequent frames, including those destined for other, non-congested queues.
+
+When RX flushing is enabled for a queue, a frame that would otherwise block the
+FIFO in this way is instead discarded (flushed), so that frames for the other
+queues can keep flowing. This is controlled through the ``RX_FLUSHn`` bits of
+the ``FEC_QOS_SCHEME`` (``ENET_QOS``) register; see the "Receive flush" and
+"ENET_QOS field descriptions" sections of the SoC reference manual (for example
+the i.MX 8DualX/8DualXPlus/8QuadXPlus Applications Processor Reference Manual,
+IMX8DQXPRM).
+
+.. note::
+
+   Due to erratum ERR050395 (see the applicable Mask Set Errata document, e.g.
+   IMX8X_0N99Z for the i.MX 8QuadXPlus), enabling RX flushing on more than one
+   receive queue at a time can, under certain traffic conditions, lock up the
+   receive path instead of flushing the blocking frame. To avoid triggering the
+   erratum the driver rejects (with ``-EINVAL``) any attempt to enable
+   ``rx-flush-qN`` on more than one queue simultaneously; only a single queue
+   may have RX flushing enabled.
diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index d9980c84487a5..0a304b158ef70 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -24,6 +24,7 @@ Contents:
    dec/dmfe
    freescale/dpaa
    freescale/dpaa2/index
+   freescale/fec
    freescale/gianfar
    google/gve
    huawei/hinic
diff --git a/MAINTAINERS b/MAINTAINERS
index 460cb72688450..80e412c1283c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10375,6 +10375,7 @@ L:	imx@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/fsl,fec.yaml
+F:	Documentation/networking/device_drivers/ethernet/freescale/fec.rst
 F:	drivers/net/ethernet/freescale/fec.h
 F:	drivers/net/ethernet/freescale/fec_main.c
 F:	drivers/net/ethernet/freescale/fec_ptp.c
diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 7176803146f3d..f3dbad8db769f 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -322,6 +322,10 @@ struct bufdesc_ex {
 #define RCMR_CMP(X)		(((X) == 1) ? RCMR_CMP_1 : RCMR_CMP_2)
 #define FEC_TX_BD_FTYPE(X)	(((X) & 0xf) << 20)
 
+/* FEC_QOS_SCHEME bits */
+#define QOS_RX_FLUSH(X)		BIT(3 + (X))
+#define QOS_RX_FLUSH_MASK	(QOS_RX_FLUSH(0) | QOS_RX_FLUSH(1) | QOS_RX_FLUSH(2))
+
 /* The number of Tx and Rx buffers.  These are allocated from the page
  * pool.  The code may assume these are power of two, so it is best
  * to keep them that size.
@@ -604,6 +608,11 @@ struct fec_enet_private {
 	unsigned int num_tx_queues;
 	unsigned int num_rx_queues;
 
+	/* Bitmask of RX queues with receive flushing enabled */
+	u32 rx_flush_mask;
+	/* Serializes the FEC_QOS_SCHEME read-modify-write */
+	spinlock_t qos_lock;
+
 	struct fec_enet_priv_tx_q *tx_queue[FEC_ENET_MAX_TX_QS];
 	struct fec_enet_priv_rx_q *rx_queue[FEC_ENET_MAX_RX_QS];
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index ced4dbf8cd90f..c45282defb0c3 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1072,6 +1072,20 @@ static void fec_enet_active_rxring(struct net_device *ndev)
 		writel(0, fep->rx_queue[i]->bd.reg_desc_active);
 }
 
+/* Program the per-queue RX flushing bits in FEC_QOS_SCHEME */
+static void fec_enet_set_rx_flush(struct fec_enet_private *fep)
+{
+#if !defined(CONFIG_M5272)
+	u32 val;
+
+	/* ethtool can race with fec_enet_adjust_link() (no RTNL) */
+	guard(spinlock)(&fep->qos_lock);
+	val = readl(fep->hwp + FEC_QOS_SCHEME);
+	val &= ~QOS_RX_FLUSH_MASK;
+	writel(val | fep->rx_flush_mask, fep->hwp + FEC_QOS_SCHEME);
+#endif
+}
+
 static void fec_enet_enable_ring(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -1090,6 +1104,8 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 			       fep->hwp + FEC_RCMR(i));
 	}
 
+	fec_enet_set_rx_flush(fep);
+
 	for (i = 0; i < fep->num_tx_queues; i++) {
 		txq = fep->tx_queue[i];
 		writel(txq->bd.dma, fep->hwp + FEC_X_DES_START(i));
@@ -3546,6 +3562,7 @@ static void fec_enet_get_ethtool_stats(struct net_device *dev,
 static void fec_enet_get_strings(struct net_device *netdev,
 	u32 stringset, u8 *data)
 {
+	struct fec_enet_private *fep = netdev_priv(netdev);
 	int i;
 	switch (stringset) {
 	case ETH_SS_STATS:
@@ -3561,11 +3578,18 @@ static void fec_enet_get_strings(struct net_device *netdev,
 	case ETH_SS_TEST:
 		net_selftest_get_strings(data);
 		break;
+	case ETH_SS_PRIV_FLAGS:
+		for (i = 0; i < fep->num_rx_queues; i++) {
+			snprintf(data, ETH_GSTRING_LEN, "rx-flush-q%d", i);
+			data += ETH_GSTRING_LEN;
+		}
+		break;
 	}
 }
 
 static int fec_enet_get_sset_count(struct net_device *dev, int sset)
 {
+	struct fec_enet_private *fep = netdev_priv(dev);
 	int count;
 
 	switch (sset) {
@@ -3576,11 +3600,58 @@ static int fec_enet_get_sset_count(struct net_device *dev, int sset)
 
 	case ETH_SS_TEST:
 		return net_selftest_get_count();
+	case ETH_SS_PRIV_FLAGS:
+		return fep->num_rx_queues;
 	default:
 		return -EOPNOTSUPP;
 	}
 }
 
+static u32 fec_enet_get_priv_flags(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	u32 flags = 0;
+	int i;
+
+	for (i = 0; i < fep->num_rx_queues; i++)
+		if (fep->rx_flush_mask & QOS_RX_FLUSH(i))
+			flags |= BIT(i);
+
+	return flags;
+}
+
+static int fec_enet_set_priv_flags(struct net_device *ndev, u32 flags)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	u32 mask = 0;
+	int i;
+
+	if (flags & ~(BIT(fep->num_rx_queues) - 1))
+		return -EINVAL;
+
+	/* Erratum ERR050395 */
+	if (hweight32(flags) > 1) {
+		netdev_err(ndev, "RX flush is supported on a single queue only\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < fep->num_rx_queues; i++)
+		if (flags & BIT(i))
+			mask |= QOS_RX_FLUSH(i);
+
+	if (mask == fep->rx_flush_mask)
+		return 0;
+
+	fep->rx_flush_mask = mask;
+
+	if (!netif_running(ndev))
+		return 0;
+
+	fec_enet_set_rx_flush(fep);
+
+	return 0;
+}
+
 static void fec_enet_clear_ethtool_stats(struct net_device *dev)
 {
 	struct fec_enet_private *fep = netdev_priv(dev);
@@ -3800,6 +3871,8 @@ static const struct ethtool_ops fec_enet_ethtool_ops = {
 	.get_strings		= fec_enet_get_strings,
 	.get_ethtool_stats	= fec_enet_get_ethtool_stats,
 	.get_sset_count		= fec_enet_get_sset_count,
+	.get_priv_flags		= fec_enet_get_priv_flags,
+	.set_priv_flags		= fec_enet_set_priv_flags,
 #endif
 	.get_ts_info		= fec_enet_get_ts_info,
 	.get_wol		= fec_enet_get_wol,
@@ -5323,6 +5396,7 @@ fec_probe(struct platform_device *pdev)
 
 	fep->ptp_clk_on = false;
 	mutex_init(&fep->ptp_clk_mutex);
+	spin_lock_init(&fep->qos_lock);
 
 	/* clk_ref is optional, depends on board */
 	fep->clk_ref = devm_clk_get_optional(&pdev->dev, "enet_clk_ref");
-- 
2.55.0

