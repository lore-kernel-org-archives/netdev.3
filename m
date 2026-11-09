Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244337;
	b=Kung/0Xma8oV7F4Yy6PkFuh4/Xrq1UDvJ6rJr/+lJLnVPriqo3gR5V09Z7iupXQ/idmS
	 sIlACSsq9ZyuSxxR6XuWZG1tYjkknHP7rAPDp+2uzTRO4/n46fCl/ZR3JhQpn2LX3adwY
	 izZVL1++hMemeLQCTjkYYPaw6mrZm1WzcHnEo4Iw+8k2tvBJKX/7EjZB/YhqOQetwHCj5
	 XB1vKtiQh/79wTxAC1f1EY/d4vVNpK8J0+Hp8k0A3ScNKLudHEnF8VrgrZ4sVx9CLs1kS
	 7+XwAW+Rc3i4fAO/qmArKu1r5ID5Ky0tiKVtFoutNWvEurzE0FzNEDsQQbN/B72rswQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244337;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hzZZMQ8fpl/iDvObtrAtE4+lTu94nFzniKzTb7/B3Ks=;
	b=UiG2VKa0mt5ivkTfcuuquCIbf3orLMkbPiGAxeHJHEOwX4Zzh3oDUMOQOSthTJT0+Hv5
	 EpVoUDKs/Dxk/M8mvYPwUoIW9Hc8Qrc2Dc1Dd20UvDAwIt3Av3URL3wLRtEPOeBCu3s6J
	 giBkV45QY6Y4bx/+atgHepUtMXMlBHxHgKLrh3YXs/x9wqoRLe4mxey6TK7hzH0f3NGyN
	 0ltrEoI63EHCXPSpLAGxdhPJsGYLHy5sINK90NRtjQjCfB/CjtEOBs+I9i8lXyMK9mP6d
	 4Wp5SIRASoE36K5xWzFW9pDTTM7br4IbFSx3LqaROdhfznBA1tfPts2BKRXkMNVDzUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FCeltfjD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909D1606A31C;
	Mon,  9 Nov 2026 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FCeltfjD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBE51F0089F;
	Mon,  9 Nov 2026 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794244337;
	bh=hzZZMQ8fpl/iDvObtrAtE4+lTu94nFzniKzTb7/B3Ks=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FCeltfjDSjW78XeaZCd5V4lxYvLkPlVIPIYw75BfO41aULF6gUm0AktNJ/2/yZFPv
	 jzA+MlXtYSpLzYd1h0GfzKC0XQCL3q568AF9KoBZWyyf9FbEy2Tef0WdmLEucyjEOp
	 wGQ/7lYU3Xql+8+Di+/tCYTLZ93Lcp7qsgmyL1jfiGY0Q2CH44d2pDk92ZZj/la9Dy
	 Pj6DWVttXPHrAHmS0ViXANeCSoosKIaryeWGuczJyy8NaCPwNOLRoJ6lNqqqmiLRhD
	 DpJM+Z38T24ZgzHco7KT75EAKSNVvIZtnlc93/q2T4UARXymmsiwxfeFF5xVr6EJui
	 L7IyLlOaQk81Q==
Subject:
 Re: [PATCH net] net: bcmgenet: cap the Tx queue threshold at the ring size
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 justin.chen@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 razor@blackwall.org, kerneljasonxing@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 17:12:15 +0000
Message-ID: <179424433591.994134.17565447879442853727@kernel.org>
In-Reply-To: <20261106-nb-genet-txq-thld-net-v1-1-53bbac647b71@tipi-net.de>
References: <20261106-nb-genet-txq-thld-net-v1-1-53bbac647b71@tipi-net.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch only partly fixes the Tx stall it targets.

--

net: bcmgenet: cap the Tx queue threshold at the ring size

This patch adds a per-ring stop_thld field, capped at size - 1. The field
replaces MAX_SKB_FRAGS + 1 as the threshold for stopping and waking Tx
queues in bcmgenet_xmit() and bcmgenet_tx_poll(). The goal is to stop the
32-descriptor priority rings from staying stopped forever when
CONFIG_MAX_SKB_FRAGS is 31 or larger.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 4d2be2a21ed1b..186d17781b890 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2742,6 +2742,8 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
>  	ring->index = index;
>  	ring->cbs = priv->tx_cbs + start_ptr;
>  	ring->size = size;
> +	/* A ring smaller than that would never wake */
> +	ring->stop_thld = min_t(unsigned int, MAX_SKB_FRAGS + 1, size - 1);

[Severity: High]

Does this fully fix the stall on queues 1 to 4 when CONFIG_MAX_SKB_FRAGS
is 31 or more? The wake threshold is now capped, but the per-skb admission
check at the top of bcmgenet_xmit() has not changed:

bcmgenet_xmit() {
    ...
	if (ring->free_bds <= (nr_frags + 1)) {
		if (!netif_tx_queue_stopped(txq))
			netif_tx_stop_queue(txq);
		ret = NETDEV_TX_BUSY;
		goto out;
	}
    ...
}

free_bds can never be larger than ring->size (32). So an skb with
nr_frags >= 31 gets rejected even when the ring is completely empty.

In that case nothing is in flight, so no Tx-done interrupt arrives and
bcmgenet_tx_poll() never wakes the queue. The watchdog is the only wake
source left:

dev_watchdog()
  bcmgenet_timeout()
    bcmgenet_tx_reclaim(dev, ring, true);
    BCMGENET_STATS64_INC((&ring->stats64), errors);
    netif_tx_wake_queue(txq);

The qdisc then retries the same requeued skb and gets NETDEV_TX_BUSY
again, so the queue stops again.

Wouldn't that leave the queue, and every flow hashed to it, stuck for
good? The "NETDEV WATCHDOG: transmit queue N timed out" message and the
error count from the commit message would then come back every
watchdog_timeo.

The core does not keep such skbs away from the driver. The driver
advertises NETIF_F_SG, and it has no ndo_features_check and no
skb_linearize() fallback. Highly fragmented skbs can come from
MSG_ZEROCOPY, from splice, or from forwarded traffic.

Should bcmgenet_xmit() also handle skbs where nr_frags + 1 >= ring->size?
It could linearize or drop them, or clear NETIF_F_SG for them in
ndo_features_check.

>  	ring->clean_ptr = start_ptr;
>  	ring->c_index = 0;
>  	ring->free_bds = size;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-nb-genet-txq-thld-net-v1-1-53bbac647b71%40tipi-net.de
