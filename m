Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794097515;
	b=RPIBnTtg0YSKeW4su7tggFvEptrrW0YMnSQMDTe4aFMbGebU3jUSwaDEruFbvKoZSMEG
	 YBp2SNlrI3Qn33xfYtuvHAJtn8HrqVz8qfckQvA6dkPCGSIdqUWf28BpuLaGbGn6PSmv7
	 3VgYMpoOB/rU+UggjXfFKTj3x98Xuvcw3nqbhO2YvqkEMhRrMMzpwTGvLNL27jZFiYlxc
	 T77NeIw1+7CZnR3gMkwzN/ud33pjUCM6Dm6syIrRpDYsJPLpBGLPq+ZiyV1oOLj2XjOFA
	 SEzbZeP3UNCQ1KmGj3HWqnF8xaBSB76R4BCdY3D74UNOrRJ7/1hpZMunoEPLaJfgPHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794097515;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/a11q3+NusVj2sKXU+j/Kg+Xh+lpILswZYfl70jZRpo=;
	b=fWkfz31Dm5eCBsQfbJWh98nSUllzjk1UBjIn+U+LWJqBh6EZLYQiMBOU7x005vgFOfr8
	 10ZMVqIS4Chwg8MZ8AYk3LDgSSPdkW4ZmBbbej37sf3MHMltHhzutzshiC0TDL5BMn9G6
	 gHr3jZEKCYh9NtAfOTs7kQWGDVsneD6lgG9zVy4ORb9QvpJCJBu9tt0YSzWJVvCNTX72Y
	 xAZWa7yigu3HrY4SLtQV2egDXdgwhVoaqg5az0Vtvjam0Rl9kzzgebpjk9X+BKC/4IhW3
	 +KACN3M6hggmZCRCu2oFbPDv11YFTjleZp9mWD/ficeMYvi7Q/E2QlgDAvawmgVdiaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ET4fHFlg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042C2606A326;
	Sun,  8 Nov 2026 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ET4fHFlg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BA01F0089F;
	Sun,  8 Nov 2026 00:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794097514;
	bh=/a11q3+NusVj2sKXU+j/Kg+Xh+lpILswZYfl70jZRpo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ET4fHFlgMZpTA0oW47RAgmOvDe3QW0DRL7AFk6Cl+86yr0Uh+Ssb+9ibhd/ttiphQ
	 l7oIZi15FF+m+VULWv1uXYDHN7ISBS07M8FlI1LSOWO97V9wLscjFeM5qz0q3+xfvz
	 pHkU7l3v05KQYcrPhXsJ6KLkTbjlM6u4zQZ6cCOBBD5MwOqEFtbD/Onb7re43XVNxl
	 oFmoxSBpU5sH4w5OzFE4RM1qKycRWD9ZAuxGIbXe4v583BO755sm5KEQULAk09Ws5g
	 ZLXtBXw8GjrCaqLWiQ8vRqe0sQ2Bd0ldHqCTw9FGRJhaVFunbh39I1S1EpyVTGioQF
	 63NBTqcjSu9qA==
Subject: Re: [PATCH net 2/2] ionic: limit TSO segments to the Tx ring size
From: netdev-bot+sashiko@kernel.org
To: nikhil.rao@amd.com
Cc: brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 eric.joyner@amd.com, abhijit.gangurde@amd.com
Date: Sun, 08 Nov 2026 00:25:13 +0000
Message-ID: <179409751335.994134.13025633681477623446@kernel.org>
In-Reply-To: <20261107-b4-ionic-tso-max-segs-v1-2-67c248a5b681@amd.com>
References: <20261107-b4-ionic-tso-max-segs-v1-2-67c248a5b681@amd.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] A Tx ring shrink on a running interface can still permanently
  stall a Tx queue, which is the failure this fix is meant to remove.
- [Medium] The new tso_max_segs comes only from the regular Tx ring size
  (ntxq_descs - 1: 1023 by default, up to 8191).
- [Low] The commit message understates what the fix addresses.

--

ionic: limit TSO segments to the Tx ring size

This patch advertises the Tx ring size minus one as tso_max_segs, so the
stack stops building GSO skbs with more segments than the ring can hold.
The limit is updated on ring resize through a new
ionic_lif_set_ntxq_descs() helper and in ionic_cmb_reconfig(). A features
change event is sent after an ethtool Tx ring resize.

> The driver never tells the stack this limit, so such skbs are built
> and handed to it instead of being segmented in software.

[Severity: Low]
Could the changelog also describe what users see when this happens?

When gso_segs is larger than num_descs - 1, ionic_start_xmit() hits:

	if (!netif_txq_maybe_stop(q_to_ndq(netdev, q),
				  ionic_q_space_avail(q),
				  ndescs, ndescs))
		return NETDEV_TX_BUSY;

ionic_q_space_avail() can never reach ndescs. The queue stops, the qdisc
requeues the skb and keeps retrying it until dev_watchdog fires, and the
tx timeout recovery then replays the same skb.

This is easy to hit with a 64-entry ring (the kdump default
IONIC_MIN_TXRX_DESC, or ethtool -G tx 64) and a 64KB TSO skb with MSS
below about 1040, or with UDP GSO.

Would it help stable backporters if the message said this fixes a Tx
queue hang, rather than only a missed software segmentation?

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 7f0da2b0defdf..ce1e51f318e01 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c

[ ... ]

> @@ -3065,7 +3069,7 @@ int ionic_reconfigure_queues(struct ionic_lif *lif,
>  
>  	/* swap new desc_info and rings, keeping existing interrupt config */
>  	if (tx_qcqs) {
> -		lif->ntxq_descs = qparam->ntxq_descs;
> +		ionic_lif_set_ntxq_descs(lif, qparam->ntxq_descs);

[Severity: High]
Can shrinking the Tx ring on a running interface still stall a Tx queue
permanently?

The lower gso_max_segs only takes effect in validate_xmit_skb(), which
runs on skbs freshly dequeued from the qdisc. Skbs that were requeued
into q->gso_skb skip that check:

net/sched/sch_generic.c:dequeue_skb() {
    ...
		/* skb in gso_skb were already validated */
		*validate = false;
    ...
}

Here is one possible sequence:

1. The ring has 1024 entries, so gso_max_segs is 1023, and an skb with
   100 segments passes validation.

2. The ring is briefly full, so ionic_start_xmit() returns
   NETDEV_TX_BUSY and the skb is requeued into q->gso_skb. An skb can
   also end up there when sch_direct_xmit() finds the txq frozen after
   netif_device_detach().

3. The admin runs ethtool -G tx 64. Inside ionic_reconfigure_queues():
   - ionic_stop_queues_reconfig() detaches and stops the queues but
     never resets the qdisc.
   - The 64-entry rings are swapped in.
   - ionic_lif_set_ntxq_descs() lowers the limit to 63.
   - ionic_start_queues_reconfig()->netif_device_attach() wakes the
     queue.

4. The stale skb is dequeued without validation. ionic_tx_descs_needed()
   returns 100, but ionic_q_space_avail() can never be more than 63.
   ionic_start_xmit() stops the queue and returns NETDEV_TX_BUSY. The
   ring is empty, so no completion ever wakes the queue.

5. dev_watchdog fires, and ionic_tx_timeout_work() runs the stop/start
   reconfig again. That does not purge q->gso_skb either, so the same
   skb blocks the queue again. Only qdisc_reset() on ifdown clears it.

ionic_cmb_reconfig() appears to have the same window.

Is a driver-side check needed to fully close this? For example,
ionic_start_xmit() could drop or software-segment an skb whose ndescs is
more than q->num_descs - 1, instead of returning NETDEV_TX_BUSY.

>  		for (i = 0; i < qparam->nxqs; i++)
>  			ionic_swap_queues(lif->txqcqs[i], tx_qcqs[i]);
>  	}

[ ... ]

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> index e790f6b9441e2..14aaaeb360a27 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> @@ -290,6 +290,16 @@ static inline void ionic_init_queue_params(struct ionic_lif *lif,
>  	qparam->cmb_rx = test_bit(IONIC_LIF_F_CMB_RX_RINGS, lif->state);
>  }
>  
> +static inline void ionic_lif_set_ntxq_descs(struct ionic_lif *lif,
> +					    unsigned int descs)
> +{
> +	if (descs == lif->ntxq_descs)
> +		return;
> +
> +	lif->ntxq_descs = descs;
> +	netif_set_tso_max_segs(lif->netdev, descs - 1);

[Severity: Medium]
Does this limit also need to cover the hwstamp Tx ring?

With Tx hardware timestamping enabled, ionic_start_xmit() sends every
SKBTX_HW_TSTAMP skb to the hwstamp queue:

	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
		if (lif->hwstamp_txq && lif->phc->ts_config_tx_mode)
			return ionic_start_hwstamp_xmit(skb, netdev);

ionic_lif_create_hwstamp_txq() always creates that ring with:

	num_desc = IONIC_MIN_TXRX_DESC;

So at most 63 entries are usable there. The tso_max_segs set here is
ntxq_descs - 1, which is 1023 by default and can be up to 8191.

A timestamped TSO skb with 64 to ntxq_descs - 1 segments passes the core
gso_max_segs check. ionic_start_hwstamp_xmit() then drops it every time:

	if (unlikely(!ionic_q_has_space(q, ndescs)))
		goto err_out_drop;

The ionic_cmb_reconfig() hunk computes the limit the same way. Any
SO_TIMESTAMPING TX_HARDWARE user with MSS below about 1040 would hit
these drops, for example after setting TCP_MAXSEG or over a small path
MTU.

The commit message says the goal is to stop skbs that can never be
posted from reaching the driver. Doesn't the hwstamp ring, the smallest
Tx ring the driver posts to, still receive them?

> +}
> +

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107-b4-ionic-tso-max-segs-v1-0-67c248a5b681%40amd.com
