Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348284;
	b=OE58IQg2pn/2JMPwAHzey532CpANEsZyJugi+tmvOozxg3NnJNTvI8ljkiC3CRbCQM6V
	 KEz+YcbFi73Yt2H0S8hVfxyKf4qJtqAXRH0PnyPgvLSmpUNSvPz94lKswJaaJ/3sOrWDe
	 Yr+J94qpJYA2hk+rT+ntjcyH7jLeCvNoMmnAPX5DR7rzTgb3v23Y2vxcY3k6GgB9mOHcu
	 WQClO1ukHayC7kmaEMqYy78DNMTL9CU2lXazIeQytWDphzET0C3cg6IM0VC2x95cq2KQr
	 fUqkudEGavJOxtY9XcRO/yAjRPyeGVm7IftP6v2Ir0eRCMLCX/sENF6ucg8rtNh47MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348284;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o0i4oyCwffwHnb1Hbunl09TTvBsz1nY/gcpYVs3Sr/w=;
	b=udV+UKlLb+J9bczCRZrZA+nS/OgpDmv9bl0GKcCCK2vWJPfgLp7qRKdsX1nto02kHvXp
	 VVzF7F7GIbNm3OqohXVxQOAqu7DjgSS5YYSL2FGoT2S8ujMy87PQ6nOBUPY9aGGBnsKBs
	 DOulgSUeuHoNQFfTWk1TiVnHaNqSyyyIakcXpmws24Gw99AoguMC/E1MkzDcTE2QR6D3H
	 2J8KQk6MluwXUPliQJaQ4kug+QZBCoxx+hZivrkS6PaqRepwEQ4vA2/DrJ2l2XqwDeU/K
	 LH1DCGZ9S6Z1MtqdTBC1XvnY3H0eGo9KsOig2SEN22rOC0htENrnhQG47T18MqptWjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P2Wn0VSt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD44060A2605;
	Tue, 10 Nov 2026 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P2Wn0VSt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F67F1F0089F;
	Tue, 10 Nov 2026 22:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348283;
	bh=o0i4oyCwffwHnb1Hbunl09TTvBsz1nY/gcpYVs3Sr/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P2Wn0VStsa8vd0oCMqniGgBvPTYWX9nFN5ZTqrv5+e7u1ANUIG/fGzNuxP1HlN6vQ
	 fPeD88YAOfUvfzDSc8EdOvgAUoytW6X4kZAt9ZhGnRFaNxIJT+dwyefQMC1jyUejLM
	 pZoKpsgfpSRW9d9ZAEs7KDXr2T3A/+rl6OW6t0djiyTRq36z82I2oB+o+FhsRwjjoB
	 VA5uLSw8I1GJ85unSiRtpxah0e/z2BPhEMV5/uwz0Ck5PX+ZBjbTrWyzKtpXniFAJI
	 Y2ASc/x20VKsNEYSeGPqMZ/xXBmu/F25gOLGQFrVXhAYcYUtnaDUt5lK4OZ2Ukbi8J
	 aqzaCLN+rL4vQ==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel.machon@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	UNGLinuxDriver@microchip.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robert.marko@sartura.hr
Subject: Re: [PATCH net-next 5/9] net: sparx5/lan969x: size the FDMA buffers from the port MTUs
Date: Tue, 10 Nov 2026 14:04:42 -0800
Message-ID: <20261110220442.2337208-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105-sparx5-mtu-change-v1-5-f27bab580463@microchip.com>
References: <20261105-sparx5-mtu-change-v1-5-f27bab580463@microchip.com>
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: sparx5/lan969x: size the FDMA buffers from the port MTUs

This commit stops using a fixed single page for the Sparx5 and lan969x
FDMA buffers. They are now sized from the largest port MTU plus the
Ethernet header, FCS, IFH and two VLAN tags. On Sparx5 the TX buffers can
now be smaller than a page, so sparx5_fdma_xmit() drops frames that do
not fit; on lan969x the page_pool page order comes from the max frame
size.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> index 7ac5887abe6ee..3a74a305d55d4 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c

[ ... ]

> @@ -218,6 +217,10 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
>  	struct fdma *fdma = &tx->fdma;
>  	void *virt_addr;
>  
> +	/* Drop frames that do not fit in the TX buffers */
> +	if (unlikely(IFH_LEN * 4 + skb->len + ETH_FCS_LEN > fdma->db_size))
> +		return -EMSGSIZE;
> +

[Severity: High]
This is a pre-existing issue, but this new -EMSGSIZE return gives it a new
trigger. What happens to a two-step PTP skb that gets dropped here?

By the time sparx5_fdma_xmit() runs, sparx5_port_xmit_impl() has already
called sparx5_ptp_txtstamp_request(). That function puts the skb on
port->tx_skbs without taking a reference and increments ptp_skbs:

sparx5_ptp_txtstamp_request() {
    ...
	skb_queue_tail(&port->tx_skbs, skb);
	SPARX5_SKB_CB(skb)->ts_id = port->ts_id;
	SPARX5_SKB_CB(skb)->jiffies = jiffies;

	sparx5->ptp_skbs++;
    ...
}

Any negative return other than -EBUSY goes to the drop label. The drop
label frees the skb but does not do the cleanup that the busy label does:

sparx5_port_xmit_impl() {
    ...
	if (ret == -EBUSY)
		goto busy;
	if (ret < 0)
		goto drop;
    ...
drop:
	stats->tx_dropped++;
	sparx5->tx.dropped++;
	dev_kfree_skb_any(skb);
	return NETDEV_TX_OK;
busy:
	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
	    SPARX5_SKB_CB(skb)->rew_op == IFH_REW_OP_TWO_STEP_PTP)
		sparx5_ptp_txtstamp_release(port, skb);
	return NETDEV_TX_BUSY;
}

Doesn't this leave a freed skb linked on port->tx_skbs? Three later
accesses would touch it:

- On the next two-step TX, sparx5_ptp_txtstamp_old_release() reads
  SPARX5_SKB_CB(skb)->jiffies from it, then calls __skb_unlink() and
  dev_kfree_skb_any() on it a second time.

- The two-step timestamp IRQ handler walks the same list and reads
  SPARX5_SKB_CB(skb)->ts_id from it.

- Unlinking a neighbouring skb writes into the freed skb's next/prev
  pointers.

Each of these drops also seems to leak one ptp_skbs slot. After
SPARX5_MAX_PTP_ID leaked slots, sparx5_ptp_txtstamp_request() returns
-EBUSY for every request, and two-step PTP TX stalls with NETDEV_TX_BUSY.

The broken drop-path cleanup is older than this patch. The existing
-EINVAL return just below (TX DB not done) and errors from
sparx5_inject() already reach the same drop label.

What this patch changes is the frame size that triggers it. At MTU 1500
the TX DB shrinks from 4096 bytes to ALIGN(1562, 128) = 1664. A two-step
PTP skb longer than 1624 bytes now takes this path. Before the patch,
frames up to about 4060 bytes were sent normally.

The later commit "net: sparx5/lan969x: add support for changing the MTU"
leaves sparx5_port_xmit_impl() and sparx5_fdma_xmit() as they are. In that
commit, lowering the MTU shrinks db_size through sparx5_fdma_resize(),
while skbs sized for the old MTU may still be queued.

Would it make sense to do the size check before
sparx5_ptp_txtstamp_request() is called? Another option is to call
sparx5_ptp_txtstamp_release() for two-step skbs on the drop path, as the
busy path already does.

>  	if (!fdma_db_is_done(fdma_db_get(fdma, fdma->dcb_index, 0)))
>  		return -EINVAL;
>  

[ ... ]
