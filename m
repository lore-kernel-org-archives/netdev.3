Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2E37FF68;
	Fri, 12 Jun 2026 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253353; cv=none; b=S9qahcDwmhLN6lFJRIHCB0BXLe41+/HBeb29+ZwypbEzNoRAZWdNiIBz3Dsbv9pXFZOuW41bUXFWpWu2zQF2B4sE0gUZUKTZvMk7XSsJpFBMo+KkmrjxwA3Qp1R6SlbxyGl5v3N1RP5mUmaDRRcQJ4E7DVYHELBvgeSmetHYKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253353; c=relaxed/simple;
	bh=5ju35ZUDPa0Xnai9JerulyTKE+bIKng2odo8zQ8B1KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHQUVIb9+f4YFJxTLhjdmOIl0CYyOrspvkH/drWwp9xz9Ueoh0ciYgh2J95ppNQvOZnXKAMcz0Be/qlvSRqyy8iZyN7qrEmZAtaqFb4/Dg3/MEUknwzc1a+G20PtLTy4SMyu7sa3gEZ5Lwmce04ODOXeHeZUjj6E9XFIGDBC8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWklRpTN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWklRpTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02081F00A3A;
	Fri, 12 Jun 2026 08:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781253350;
	bh=ueRikwt5jgb0wIzJPIG3SJaaiUd8KvxX1whxAWVj1LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PWklRpTN8wnD0ZjrcFfnRCS4IMmEs3wvHD9TigxIEOZIpk8gUGAaKJPcOuOZTuA3w
	 TSdJaybdBovLWqbfAWjAdtCckuIzfcZOR0KDR/xkagGn2qNXGuHExGvZ+77o4EjSyl
	 ZZXkqScsNX0xbsXuvdZT7ewsYMtFmdAzPS5k9HPSBl2FcIQ2cFieX+/6T2Tu+06boD
	 684tL1Bq05Ya9LYIkA09OSTteS/elm9W4hnOKPmvpyzc7nJvScrdVirJu9lFr+CUPK
	 xRG8vSymuoC7sCZKNn5TqENW8ly3UJDFIcinMo1nGTXcmE5l72aHHXkCuf853RzTYb
	 afknQxajwF9EQ==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	simon.schippers@tu-dortmund.de,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 3/5] veth: add tx_timeout watchdog as BQL safety net
Date: Fri, 12 Jun 2026 10:35:26 +0200
Message-ID: <20260612083530.1650245-4-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612083530.1650245-1-hawk@kernel.org>
References: <20260612083530.1650245-1-hawk@kernel.org>
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
 drivers/net/veth.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a3505627f49e..2473f730734b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -44,6 +44,13 @@
 #define VETH_XDP_TX_BULK_SIZE	16
 #define VETH_XDP_BATCH		16
 
+/* tx_timeout watchdog timeout. DRV_XOFF is only cleared at the end of a NAPI
+ * veth_poll() (netif_tx_wake_queue()), so the timeout must outlast a full
+ * worst-case poll: a 64-packet budget with a pessimistic 250 ms/pkt consumer
+ * delay => 64 * 250 ms = 16 s.
+ */
+#define VETH_WATCHDOG_TIMEOUT_MS	(64 * 250)
+
 struct veth_stats {
 	u64	rx_drops;
 	/* xdp */
@@ -1487,6 +1494,22 @@ static int veth_set_channels(struct net_device *dev,
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
@@ -1825,6 +1848,7 @@ static const struct net_device_ops veth_netdev_ops = {
 	.ndo_bpf		= veth_xdp,
 	.ndo_xdp_xmit		= veth_ndo_xdp_xmit,
 	.ndo_get_peer_dev	= veth_peer_dev,
+	.ndo_tx_timeout		= veth_tx_timeout,
 };
 
 static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
@@ -1864,6 +1888,7 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_destructor = veth_dev_free;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
+	dev->watchdog_timeo = msecs_to_jiffies(VETH_WATCHDOG_TIMEOUT_MS);
 
 	dev->hw_features = VETH_FEATURES;
 	dev->hw_enc_features = VETH_FEATURES;
-- 
2.43.0

