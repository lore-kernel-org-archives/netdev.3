Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792633581;
	b=i0sXvHmPcLPUeKdReVwDH2gOoWC4di8hUUQenNbe5HppRmfulr4wrI0nwAmZaAQ+iC/J
	 StIJndw5ZwoqFb6EPCREX+h78hPZZgsPfvZqqUAYEirpU6qxH4sSAxZklaDNC3jg3Ik8A
	 1aPgdIb/DadTIRkKy2FhnvJrmF8xTmOIfaOb4ySJeSxIiScv2MQGd/rMVaJIz46EhPAna
	 RwS/CPywCvw1mMXGgB0wNozRJ52iXsHykfmNWSlWH3AQTyqqDBgAaPM62F6N2mHweBF/I
	 NHp5Wex1WVMOmG1pFmi2WM6933phpWA5udauizZBbkDVwcReXac97TcZCZpcDwGiE7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792633581;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3t/lhtMwUqFTKoF3uLxNOnCU7ZEEEAgxIpdnalajtQ8=;
	b=SVD/FJEuEomvenWrnLeKUlAWrMw6dsZzPwMZlSLK8CqZw8nuEuxtSGwGm9vsXsLJ2Lis
	 fZMSlbhJvIigYx8VLwGnFp2CqaIWZQLL7hZacgo+12bdSI25+HsW77fhpEOLwquM1s7pe
	 +eUadhaojmJgyOss+hBRERE7Rz/oIU40JH09IKZnm1nz+Fl9G7ypTls+Y228iV7uoeHJC
	 YdmGVHc1j4hiR9Yr+5vL1Vp+PKgCBnu/uRdfXXsKcMPFamdnzQI8apekWvbddY1LB0dwY
	 tqfVZHDAu9WjieubjmEUAzzVenxJFg3CBr3Qi3KHyXmfALIGwONM4nlr8hovtDQiTcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEZ06Np6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205D6606A319;
	Thu, 22 Oct 2026 01:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEZ06Np6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732E91F000C1;
	Thu, 22 Oct 2026 01:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792633581;
	bh=3t/lhtMwUqFTKoF3uLxNOnCU7ZEEEAgxIpdnalajtQ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lEZ06Np6OmQu82WP1TS+x1kPF57zJwSzvw4Oiz1T/hIDZ98jWutoeqkT6kW/cfm3o
	 xdQueKD8+6iZYiVPHj6ETY6IE/iBq43duTOIlLQflbLoGdBpYJpX+i4GpdvMs3bwFe
	 xtk30aKYHGDO+/fEI32SRWsr0A+CvOLJNboSNADnU0zDAFBqUgeDOp8VcZtu7+MAa3
	 gHpYsqA1tEktweRIfr5SIWiJVEj3XOQjJIK8ucz/jVRneL8E9acBA+0ETNj8MdrMx0
	 U9ix6fyhr2fBW8vPb8MR1VOdhwHV2Y/Qus7ZYKSh6nBRuVWdicopcZuswlBLS+IfQ3
	 E1k7z3ZvQBqtw==
Subject:
 Re: [PATCH net] net: ag71xx: reallocate rx buffers when changing the MTU
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, chris.snook@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 o.rempel@pengutronix.de, linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 01:46:20 +0000
Message-ID: <179263358000.3135.15720043539701773895@kernel.org>
In-Reply-To: <20261019014438.199718-1-rosenp@gmail.com>
References: <20261019014438.199718-1-rosenp@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ag71xx_change_mtu() does not handle a failed reopen.
- [High] ag71xx_change_mtu() calls ag71xx_stop() and ag71xx_open()
  directly while the netdev is still running and its qdisc and TX path…

--

net: ag71xx: reallocate rx buffers when changing the MTU

This patch makes ag71xx_change_mtu() stop and reopen a running interface.
The rx rings are then refilled with buffers sized for the new MTU before
the MAC frame length register is programmed. Before this, the new max frame
length was written straight to the MAC while the rings still held buffers
sized for the old MTU.

> diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
> index 4e4794c4dfdce..6db5ab8be6aef 100644
> --- a/drivers/net/ethernet/atheros/ag71xx.c
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -1766,11 +1766,19 @@ static irqreturn_t ag71xx_interrupt(int irq, void *dev_id)
>  
>  static int ag71xx_change_mtu(struct net_device *ndev, int new_mtu)
>  {
> -	struct ag71xx *ag = netdev_priv(ndev);
> +	bool running = netif_running(ndev);
> +
> +	/* The rx buffers are sized for the MTU at open time and the rx
> +	 * descriptors carry no buffer length, so a larger MTU must not
> +	 * reach the MAC before the rings have been refilled.
> +	 */
> +	if (running)
> +		ag71xx_stop(ndev);

[Severity: High]

Is it safe to call ag71xx_stop() here while the qdisc and tx path are
still live?

On the normal ndo_stop path, __dev_close_many() clears __LINK_STATE_START
and runs dev_deactivate_many() before it calls ndo_stop, so no xmit is in
flight. This path skips that step. ag71xx_hw_disable() only does this:

ag71xx_hw_disable() {
	netif_stop_queue(ag->ndev);

	ag71xx_hw_stop(ag);
	ag71xx_dma_reset(ag);

	napi_disable(&ag->napi);
	timer_delete_sync(&ag->oom_timer);

	ag71xx_rings_cleanup(ag);
}

netif_stop_queue() does not take the tx lock, so it doesn't wait for a CPU
that is already inside ag71xx_hard_start_xmit().

NAPI is also still enabled during ag71xx_hw_stop() and ag71xx_dma_reset(),
which can mdelay for several ms. A poll in that window can re-open the
queue:

ag71xx_poll()
  ag71xx_tx_packets()
    if ((ring->curr - ring->dirty) < (ring_size * 3) / 4)
        netif_wake_queue(ag->ndev);

ag71xx_hard_start_xmit() takes no driver lock. It writes
ring->buf[i].tx.skb and the descriptors, updates ring->curr and BQL, and
sets TX_CTRL_TXE. That restarts the tx DMA engine that ag71xx_dma_reset()
just stopped.

Could this let an xmit run at the same time as ag71xx_rings_cleanup() and
ag71xx_rings_free(), which kfree(tx->buf) and dma_free_coherent() the
descriptors?

If the queue was woken, an xmit after the rings are freed but before
ag71xx_open() would dereference tx->descs_cpu and tx->buf after they have
been set to NULL. An xmit that races with ag71xx_ring_tx_init() and
netdev_reset_queue() during the reopen could also corrupt curr/dirty and
the BQL state.

On DSA setups this can happen while other user ports are still
transmitting through the conduit, because dsa_user_change_mtu() calls
dev_set_mtu() on the conduit.

ag71xx_restart_work_func() already uses the same unquiesced
hw_disable/hw_enable pattern. This patch adds a new trigger for it that is
reached routinely.

>  
>  	WRITE_ONCE(ndev->mtu, new_mtu);
> -	ag71xx_wr(ag, AG71XX_REG_MAC_MFL,
> -		  ag71xx_max_frame_len(ndev->mtu));
> +
> +	if (running)
> +		return ag71xx_open(ndev);

[Severity: High]

What happens to the device if ag71xx_open() fails here?

ag71xx_open() can fail in two places:

- phylink_of_phy_connect()
- ag71xx_hw_enable()->ag71xx_rings_init(), which returns -ENOMEM if any
  rx buffer allocation fails. Those buffers are now sized for the new,
  possibly larger, MTU.

Both failure paths return before napi_enable():

ag71xx_hw_enable() {
	ret = ag71xx_rings_init(ag);
	if (ret)
		return ret;

	napi_enable(&ag->napi);
	...
}

netif_set_mtu_ext() just passes the error up and does not close the device.
So netif_running() stays true while NAPI is disabled, the rings are freed
and the PHY is detached.

Any later ag71xx_hw_disable() would then call napi_disable() a second time.
That can come from ifdown or unregister through ag71xx_stop(), from another
MTU change, or from a pending restart_work that ag71xx_stop() doesn't
cancel.

Wouldn't napi_disable_locked() then spin forever with RTNL held?

net/core/dev.c:napi_disable_locked() {
    ...
		while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
			usleep_range(20, 200);
			val = READ_ONCE(n->state);
		}
    ...
}

The device state is also left inconsistent. ndev->mtu is already set to
new_mtu even though an error is returned, and NETDEV_CHANGEMTU is never
sent. Retrying with the same MTU returns 0 right away because of this
check in netif_set_mtu_ext():

	if (new_mtu == dev->mtu)
		return 0;

After a NETDEV_CHANGEMTU veto, netif_set_mtu_ext() rolls back by calling
__netif_set_mtu(dev, orig_mtu) and ignores the result. A failed reopen on
that path would leave the device in the same state without any error being
reported.

Before this patch, the handler could not fail. Should the error path
restore the old MTU and bring the device back up? Or should it at least
leave NAPI and the rings in a state that a later ag71xx_stop() can handle?

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019014438.199718-1-rosenp%40gmail.com
