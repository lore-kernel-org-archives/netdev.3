Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6120840FDAD;
	Wed, 29 Apr 2026 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777483288; cv=none; b=NmzgbEVZ5aKxgaHnh8O+7TDcVYG+mQK7HgZvIupGRPUvmNAc3tQrkXHnAlvmY+C57w8Nx77wf+2hiM1BE5vgm8izFJjP/Kjwh/ivOij915kXnuMgaVVJTuSX7wnWzaxwCJET20labH1tFBzPhdYsk8LluSbLNi+OLJ8SKiod15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777483288; c=relaxed/simple;
	bh=gb8XJrhOM7OyaOgd25hPYdSzkbBzhMyrw+KarXVSWas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTrwtx8bnsTy8rbiMYNLvikZT1k14U8FkOLgaJ2p0zgtT5b4CBE9X1GJ5H39vtGonAl36PksMtqdcoIlb1p0JJX0BK+dieFpseFYAYuk7NaMewPchLv34P9d5kTElnLbPFQHmgfmhPupW0UCmGVqq8eJpm1EeYztBvAMxhKpYRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6AROYrr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6AROYrr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29485C2BCB8;
	Wed, 29 Apr 2026 17:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777483288;
	bh=gb8XJrhOM7OyaOgd25hPYdSzkbBzhMyrw+KarXVSWas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t6AROYrrEC8WYQK7q5MEgFPqxh5OfU7Quppx2hbSMZHonkGmbcdUnBV+NsWyF7kfW
	 uMOWxOAaEk407f983AC9x4wx7azewxwdaj/oFdEcffxLUwo/phc76U2riZxXa3NkW9
	 B5HXLUqU4c9Pvhjr1+WO+Nb0Na7yuVfQqEkGmp0RazVY05TkhFqbpRB1VtoOeiapdT
	 lrNwQrTw01ufd6dPRQYh/etCZNRx+yrzbisxvIA70LH1AUnsfrWT9jTVvroRoX9v8u
	 Log6p81e7SYF63SeFkhEv+Bf/38+TwhxQMIozbZtwYFM792aBT/WwCtuagIsgwNzER
	 6y1kOh3b3u2/g==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	kernel-team@cloudflare.com,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/5] veth: add tx_timeout watchdog as BQL safety net
Date: Wed, 29 Apr 2026 19:20:30 +0200
Message-ID: <20260429172036.1028526-4-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429172036.1028526-1-hawk@kernel.org>
References: <20260429172036.1028526-1-hawk@kernel.org>
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
index 3de25ba34a90..9d7b085c9548 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1431,6 +1431,22 @@ static int veth_set_channels(struct net_device *dev,
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
@@ -1769,6 +1785,7 @@ static const struct net_device_ops veth_netdev_ops = {
 	.ndo_bpf		= veth_xdp,
 	.ndo_xdp_xmit		= veth_ndo_xdp_xmit,
 	.ndo_get_peer_dev	= veth_peer_dev,
+	.ndo_tx_timeout		= veth_tx_timeout,
 };
 
 static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
@@ -1808,6 +1825,7 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_destructor = veth_dev_free;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
+	dev->watchdog_timeo = msecs_to_jiffies(16000);
 
 	dev->hw_features = VETH_FEATURES;
 	dev->hw_enc_features = VETH_FEATURES;
-- 
2.43.0

