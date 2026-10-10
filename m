Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F784499B0;
	Sat, 10 Oct 2026 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791630631; cv=none; b=mFEQEaaY6we+nPVKq0vZD2PtbjY0o3LF49+68ZfyqbSYcYXPex2+W9xzqlUVpbc3TCPz0GPDX5CBj7eYhheLsoohoxNNzfO/PjzBeUZEnnK3ro5cbqCpmiHN52Ehb9oujGzswfEWsNOzAcIA+s2ESeMeRwx6BSXFvOyKx6Vlr3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791630631; c=relaxed/simple;
	bh=rTigTA+TXOrSSMlYEvZpjU1jNY0paKo9G95Y5OZMkzM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nUSIn4ZkFPmVQmGEfALP6VWxzeVnslkxNXpXtIl3/qYfZ36ZA10oTuINVbcUpGXpPBgQOJzr6KoWDDo/0qyASE18vhJZeMdhMrgdD2l5e+MfUMMgqJtpi6dKqUeeCXsZ4y0djlmzQKJrkmfSI+g0Tf5Dj36EZ/D/cLSNgAAFEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzapVNJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzapVNJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7DB1F000FF;
	Sat, 10 Oct 2026 11:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791630629;
	bh=Bl8EQ0HDuwZrFWdMlAeqYGgCcRak8zmNT8lvOCoraA8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TzapVNJb8cL+QBbQt2HlXcLjnP2xtmcTws+NHgNxlt6nN9DtCe6ILPObgSKGdX47G
	 93avWH6SE/DkO5wUPAF12dVCUzyaCSFxYUtmJaXdmWUvosKma3uvlibiyffm5NDamq
	 cgxSOIKR1jqzAwab2BJ8stwJcdZGK4dAjPmnIe5TJgdcP9aw0AhDvldFTiR9fQCz77
	 NYFSuDHc5FJwjeA+d08bi7IqgHyoJqtYY10mocEQnourw4VCNoYXfOpZmVRknK0tyz
	 CZF8qOQn2U9b1RI7qC4vbPnhBsjq8wqgkeEvNL68T7+SsjpxOnilgKFHK6tI2fTML5
	 9JOikgyypOutg==
Subject: Re: [PATCH net] net: bcmgenet: unshare the skb before writing the
 control block
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 11:10:28 +0000
Message-ID: <179163062814.434549.7207251041859249341@kernel.org>
In-Reply-To: <20261009-nb-genet-shared-skb-net-v1-1-c6d0a841977d@tipi-net.de>
References: <20261009-nb-genet-shared-skb-net-v1-1-c6d0a841977d@tipi-net.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new skb_share_check() failure branch in bcmgenet_xmit()
  (drivers/net/ethernet/broadcom/genet/bcmgenet.c:2159-2164) jumps to…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  bcmgenet_timeout()…

--

net: bcmgenet: unshare the skb before writing the control block

bcmgenet_xmit() keeps first_cb, last_cb and bytes_sent in the skb control
block and reads them back when the transmit completes. A shared skb that
is resubmitted while it is still in the ring overwrites that state, and
BQL then stalls the queue. The patch calls skb_share_check() before the
control block is written, so each transmit works on its own skb.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index e8908916558b1..f4cfbff49a1b8 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -2153,6 +2153,16 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
>  		goto out;
>  	}
>  
> +	/* We store Tx state in the control block, so the skb must not be
> +	 * shared, but ether_setup() leaves IFF_TX_SKB_SHARING set.
> +	 */
> +	skb = skb_share_check(skb, GFP_ATOMIC);
> +	if (!skb) {
> +		BCMGENET_STATS64_INC((&ring->stats64), dropped);
> +		ret = NETDEV_TX_OK;
> +		goto out;

[Severity: Medium]
If the GFP_ATOMIC clone fails on the last skb of an xmit_more batch, do
the descriptors queued by the earlier calls in that batch get handed to
the hardware?

The only TDMA_PROD_INDEX doorbell write in bcmgenet_xmit() is on the
success path, and the out label comes right after it:

	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
		/* Packets are ready, update producer index */
		bcmgenet_tdma_ring_writel(priv, ring->index,
					  ring->prod_index, TDMA_PROD_INDEX);
out:
	spin_unlock(&ring->lock);

The earlier calls in the batch already advanced ring->prod_index and
called netdev_tx_sent_queue(), and they left the doorbell write to the
last packet. When that last packet takes this goto out, the skb is freed,
NETDEV_TX_OK is returned, and the hardware is never told about the
earlier descriptors.

pktgen_xmit() in M_START_XMIT mode with burst > 1 can hit this path. The
skb is always shared there, so every call goes through the clone:

	if (skb_shared)
		refcount_add(burst, &pkt_dev->skb->users);

xmit_more:
	ret = netdev_start_xmit(pkt_dev->skb, odev, txq, --burst > 0);

The final call runs with more == false. pktgen counts NETDEV_TX_OK as
done and does not retry it.

Those frames then sit unsent in the ring, and BQL inflight stays
nonzero, until a later transmit on the same ring writes the doorbell. The
queue is not stopped in that state, so dev_watchdog will not recover it
either.

The existing exits for a bcmgenet_add_tsb() failure and a DMA map failure
have the same pattern. Would it make sense to write the doorbell on the
drop paths when !netdev_xmit_more()?

> +	}
> +
>  	/* Retain how many bytes will be sent on the wire, without TSB inserted
>  	 * by transmit checksum offload
>  	 */

[Severity: High]
This is a pre-existing issue, not one introduced by this patch, but it
involves the same ring->stats64.syncp that the new dropped increment
uses.

bcmgenet_timeout() updates ring->stats64 without holding ring->lock:

drivers/net/ethernet/broadcom/genet/bcmgenet.c:bcmgenet_timeout() {
    ...
	bcmgenet_tx_reclaim(dev, ring, true);

	/* Re-enable the TX interrupt for this ring */
	bcmgenet_intrl2_1_writel(priv, 1 << txqueue, INTRL2_CPU_MASK_CLEAR);

	txq_trans_cond_update(txq);

	BCMGENET_STATS64_INC((&ring->stats64), errors);
    ...
}

By that point bcmgenet_tx_reclaim() has already taken and dropped
spin_lock_bh(&ring->lock), and the ring's TX interrupt is unmasked again.

All the other writers of this syncp run under ring->lock. That includes
__bcmgenet_tx_reclaim() called from bcmgenet_tx_poll():

	spin_lock(&ring->lock);
	work_done = __bcmgenet_tx_reclaim(ring->priv->dev, ring);

which does:

	u64_stats_update_begin(&stats->syncp);
	u64_stats_add(&stats->packets, pkts_compl);
	u64_stats_add(&stats->bytes, bytes_compl);
	u64_stats_update_end(&stats->syncp);

The watchdog holds netif_tx_lock, which keeps ndo_start_xmit out. It does
not keep TX NAPI out, and NAPI is not disabled here.

On 32-bit SMP kernels, u64_stats_update_begin() does a plain,
non-atomic seqcount increment. If bcmgenet_timeout() and
bcmgenet_tx_poll() interleave on two CPUs, one of the increments can be
lost and the sequence stays odd for good.

If that happens, bcmgenet_get_stats64() would spin forever in
u64_stats_fetch_begin(). Stats readers that hold RTNL, such as
rtnl_fill_ifinfo() callers, would hang with it.

Could the errors increment be done under ring->lock? Either wrap it in
spin_lock_bh(&ring->lock) or move it inside bcmgenet_tx_reclaim().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-nb-genet-shared-skb-net-v1-1-c6d0a841977d%40tipi-net.de
