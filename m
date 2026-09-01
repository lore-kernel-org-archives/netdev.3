Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED61D35F182
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 07:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248869; cv=none; b=hZXWfaJkGXgpGk1JW9Ynz5zSGldTgikB6zbR39Ds1EmwQagKxJATorpsNmPkzKxbMSyqU/0W0Nje6S6hCaf1S+pbZmtSlRmKcNnTA1cvEnVD2aNLbiByncE4/2vF/y78c6on3/eSJDx8ZZBGNSyrNSlRS2oo+36Px9AMNYA/NYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248869; c=relaxed/simple;
	bh=Mz8vHOq6VpsOn8YvfFAUFk4Va+HuS1yGLYbjSiMlAxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5l3WQMyci0AMRnZAfaJvwjnbKgnpIRHriYo2LnINgfxcvzteE6a3KAliRX5G++BykXRtieISwMinyqAMnZiPZpQmtnMdVxR/wt6aBna1MXeCYqcLDXIqyagC8AlS4YQxCX4LyrHRNSbN8fhzmiamihc1BiAgBNTpdJWJndbju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=e10ntIdF; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="e10ntIdF"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260901074735f32ffdb74000020715
        for <netdev@vger.kernel.org>;
        Tue, 01 Sep 2026 09:47:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=wThQNV8uPxLIVWoWPnSS2CbZ3YB1FStmUxkalb/R6BE=;
 b=e10ntIdFkiPVUDkGgHAhSwLnbDkF0t8JNhqgUoljWX34PCdOf0Yce4BGFVLQZBFrRNeqMx
 ooTpplbZgtwLqZCFIdG0KJl7Nf8cvqiXfeZuJM3k2SmQy+9dMb5K2uzWCJ0mrBGiHJUd/clN
 JD0YzKyFSfsRsItBCF8+3R7WdGkMqD6piWO1W2/p541fMcBGeiH9bzKoTLszUcAgzBIhFac3
 bygfR6M3xcsCVWZn2sQP4B+gKGJmfCbO5VN7x3a79zoFmgz2sM7eodbhcZkc3EcCIFWSp6Vh
 HQ3LWMI/y0pftwE0E6bE7aOTPIIdl8GtS/BCJmmuQwVOjCEd1/YvRFTg==;
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
Subject: [PATCH net-next v2] net: fec: support RX flushing via an ethtool private flag
Date: Tue,  1 Sep 2026 09:47:29 +0200
Message-ID: <20260901074732.113791-1-alexander.sverdlin@siemens.com>
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

According to i.MX8QXP Reference Manual, "when both class 1 and class 2 are
disabled, RX flushing for these rings must also be disabled". Both RX and
TX QoS classes are enabled via DMA_CLASS_EN bit, currently tied to
num_tx_queues in the driver. Currently there are no constraints on
num_tx_queues == num_rx_queues, neither in DT nor in the code, even though
having different values doesn't make much sense even without RX flushing.
RX flushing code just takes min() of the both values for now.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v2:
- gate private flags on FEC_QUIRK_HAS_MULTI_QUEUES (avoid accessing
  non-existent HW register), as suggested by Sashiko
- use ethtool_sprintf()
- take min(num_rx_queues, num_tx_queues) as number of active queues
v1:
- https://lore.kernel.org/all/20260825091908.1362677-1-alexander.sverdlin@siemens.com/

Initial attempt to provide the same functionality has been DT-based:
https://lore.kernel.org/all/20260814090906.2225075-1-alexander.sverdlin@siemens.com/

 .../device_drivers/ethernet/freescale/fec.rst | 55 ++++++++++++
 .../device_drivers/ethernet/index.rst         |  1 +
 MAINTAINERS                                   |  1 +
 drivers/net/ethernet/freescale/fec.h          |  9 ++
 drivers/net/ethernet/freescale/fec_main.c     | 86 +++++++++++++++++++
 5 files changed, 152 insertions(+)
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
index 0b42e898f4d8e..8ad17f95be1b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10445,6 +10445,7 @@ L:	imx@lists.linux.dev
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
index 794ec427b0ee6..e5c1d04a665c4 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1072,6 +1072,23 @@ static void fec_enet_active_rxring(struct net_device *ndev)
 		writel(0, fep->rx_queue[i]->bd.reg_desc_active);
 }
 
+/* Program the per-queue RX flushing bits in FEC_QOS_SCHEME */
+static void fec_enet_set_rx_flush(struct fec_enet_private *fep)
+{
+#if !defined(CONFIG_M5272)
+	u32 val;
+
+	if (!(fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES))
+		return;
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
@@ -1090,6 +1107,8 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 			       fep->hwp + FEC_RCMR(i));
 	}
 
+	fec_enet_set_rx_flush(fep);
+
 	for (i = 0; i < fep->num_tx_queues; i++) {
 		txq = fep->tx_queue[i];
 		writel(txq->bd.dma, fep->hwp + FEC_X_DES_START(i));
@@ -3546,6 +3565,7 @@ static void fec_enet_get_ethtool_stats(struct net_device *dev,
 static void fec_enet_get_strings(struct net_device *netdev,
 	u32 stringset, u8 *data)
 {
+	struct fec_enet_private *fep = netdev_priv(netdev);
 	int i;
 	switch (stringset) {
 	case ETH_SS_STATS:
@@ -3561,11 +3581,18 @@ static void fec_enet_get_strings(struct net_device *netdev,
 	case ETH_SS_TEST:
 		net_selftest_get_strings(data);
 		break;
+	case ETH_SS_PRIV_FLAGS:
+		if (!(fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES))
+			break;
+		for (i = 0; i < min(fep->num_rx_queues, fep->num_tx_queues); i++)
+			ethtool_sprintf(&data, "rx-flush-q%d", i);
+		break;
 	}
 }
 
 static int fec_enet_get_sset_count(struct net_device *dev, int sset)
 {
+	struct fec_enet_private *fep = netdev_priv(dev);
 	int count;
 
 	switch (sset) {
@@ -3576,11 +3603,67 @@ static int fec_enet_get_sset_count(struct net_device *dev, int sset)
 
 	case ETH_SS_TEST:
 		return net_selftest_get_count();
+	case ETH_SS_PRIV_FLAGS:
+		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES)
+			return min(fep->num_rx_queues, fep->num_tx_queues);
+		return 0;
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
+	if (!(fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES))
+		return -EOPNOTSUPP;
+
+	/* According to i.MX8QXP Reference Manual, "when both class 1 and
+	 * class 2 are disabled, RX flushing for these rings must also be
+	 * disabled".
+	 */
+	if (flags & ~(BIT(min(fep->num_rx_queues, fep->num_tx_queues)) - 1))
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
@@ -3800,6 +3883,8 @@ static const struct ethtool_ops fec_enet_ethtool_ops = {
 	.get_strings		= fec_enet_get_strings,
 	.get_ethtool_stats	= fec_enet_get_ethtool_stats,
 	.get_sset_count		= fec_enet_get_sset_count,
+	.get_priv_flags		= fec_enet_get_priv_flags,
+	.set_priv_flags		= fec_enet_set_priv_flags,
 #endif
 	.get_ts_info		= fec_enet_get_ts_info,
 	.get_wol		= fec_enet_get_wol,
@@ -5323,6 +5408,7 @@ fec_probe(struct platform_device *pdev)
 
 	fep->ptp_clk_on = false;
 	mutex_init(&fep->ptp_clk_mutex);
+	spin_lock_init(&fep->qos_lock);
 
 	/* clk_ref is optional, depends on board */
 	fep->clk_ref = devm_clk_get_optional(&pdev->dev, "enet_clk_ref");
-- 
2.55.0

