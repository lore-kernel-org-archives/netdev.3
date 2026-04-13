Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B62770A;
	Mon, 13 Apr 2026 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073530; cv=none; b=SyvnyQqCkczrl8hFsiUEU64sQcWrM8tUKSm3C8ueZQpvF8IjZBdXIXItAgDlGsdC8++lmJbF2lba3D7QVdEEfpAQdQ1W7V/24UbP3u4Tan02FHboLuGqUbLT+9w7SujsNAflmv7MaWOMV3/Sig5v4FRft0cxN/vtr48adrIgd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073530; c=relaxed/simple;
	bh=pjopUZqbocG7BT/UYcHtL5CE4WwMGAOUPy2Z5SCAngs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBtGbM2DhEM1aqeSWGw2JF3I+jmPeCFBaDWgeZ9CZVWliwPYWpYkaQgu8MeSiR4CfPghPAUVmV88W7dm5R59zo6PiuI+JzZleLRoQ7RIizwaCV8PU5TeMaJXS2qUP5AkG/koIaqZ9Pjtw50NYV4cyx8pNwpi0T9/PoQqOCLj8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J65axTSf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J65axTSf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DF5C2BCB1;
	Mon, 13 Apr 2026 09:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776073530;
	bh=pjopUZqbocG7BT/UYcHtL5CE4WwMGAOUPy2Z5SCAngs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J65axTSfyYNGw182Le90KbptgzSIEn/goFzcxYd9aJK1begyY/qojhGwzHNk4AiQ1
	 AcAIEA24Q6mqhCggtXFu3DwfjiJiSRu1mR7kCdst0ocB5Jk3DFlDqm/ILqlp8E00tk
	 S1F3+Mkd8bzO8wPiyTpaHfkRMz6CFY7GZR0OgwTc7LUwCfTJRU0wsy2pD3lh7kPLCJ
	 4F4+kRr49RPyow/a5asGkS/EZ4txKeVCtBQQd0cFFezU2uMhgEu9tc/MuVAto1Uwya
	 KeAFqGxAvYLv532R8jwZ2ddNY+UNUl0F3025zDCDeifOndJSWOtfJ8fFeFPVHZGqmW
	 BPXV4nWrX1RiQ==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/5] veth: add tx_timeout watchdog as BQL safety net
Date: Mon, 13 Apr 2026 11:44:36 +0200
Message-ID: <20260413094442.1376022-4-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413094442.1376022-1-hawk@kernel.org>
References: <20260413094442.1376022-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jesper Dangaard Brouer <hawk@kernel.org>

With the introduction of BQL (Byte Queue Limits) for veth, there are
now two independent mechanisms that can stop a transmit queue:

 - DRV_XOFF: set by netif_tx_stop_queue() when the ptr_ring is full
 - STACK_XOFF: set by BQL when the byte-in-flight limit is reached

If either mechanism stalls without a corresponding wake/completion,
the queue stops permanently. Enable the net device watchdog timer and
implement ndo_tx_timeout as a failsafe recovery.

The timeout handler resets BQL state (clearing STACK_XOFF) and wakes
the queue (clearing DRV_XOFF), covering both stop mechanisms. The
watchdog fires after 16 seconds, which accommodates worst-case NAPI
processing (budget=64 packets x 250ms per-packet consumer delay)
without false positives under normal backpressure.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 drivers/net/veth.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 6431dc40f9b4..911e7e36e166 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1429,6 +1429,22 @@ static int veth_set_channels(struct net_device *dev,
 	goto out;
 }
 
+static void veth_tx_timeout(struct net_device *dev, unsigned int txqueue)
+{
+	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
+
+	netdev_err(dev,
+		   "veth backpressure(0x%lX) stalled(n:%ld) TXQ(%u) re-enable\n",
+		   txq->state, atomic_long_read(&txq->trans_timeout), txqueue);
+
+	/* Cannot call netdev_tx_reset_queue(): dql_reset() races with
+	 * peer NAPI calling dql_completed() concurrently.
+	 * Just clear the stop bits; the qdisc will re-stop if still stuck.
+	 */
+	clear_bit(__QUEUE_STATE_STACK_XOFF, &txq->state);
+	netif_tx_wake_queue(txq);
+}
+
 static int veth_open(struct net_device *dev)
 {
 	struct veth_priv *priv = netdev_priv(dev);
@@ -1767,6 +1783,7 @@ static const struct net_device_ops veth_netdev_ops = {
 	.ndo_bpf		= veth_xdp,
 	.ndo_xdp_xmit		= veth_ndo_xdp_xmit,
 	.ndo_get_peer_dev	= veth_peer_dev,
+	.ndo_tx_timeout		= veth_tx_timeout,
 };
 
 static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
@@ -1806,6 +1823,7 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_destructor = veth_dev_free;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
+	dev->watchdog_timeo = msecs_to_jiffies(16000);
 
 	dev->hw_features = VETH_FEATURES;
 	dev->hw_enc_features = VETH_FEATURES;
-- 
2.43.0

