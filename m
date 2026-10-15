Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386B4968EF;
	Thu, 15 Oct 2026 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054535; cv=none; b=sN3J2xJ5q62IREtLEzZApffbG5OnqCDobml3mEqBQb97Q+3XYyR83R5Q3x57L4UGVRvITsMv+Gd8x82aP0DIVMtdrCTpgyMAqJG7aJEqkxrkdIytjbh8AK/2z5XF9HOOUb6IiHB/+YtVfRDyBbIfv1Ts2hg9eVOXgxUsJHxgACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054535; c=relaxed/simple;
	bh=Dq8hNNTdD+OCzU35HdaLKsYBRmRXoxYu/y1uvP4oatU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=l9Cs1cr88XkLc29VRFEAy1Ot+RSBHVBcMtwI0qQOerJYRMoz66kz8D8GEAzFeFnCOfhOj+4JyJRkLGA6c5yBliSn0SL7jVwAX3q2MROvl1bJ3qNdhOtHEfA3B2jkL6DQZq2AgmUaywjSyHbQ4a/DptSyxihfnY2evrFTxoWnTs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=KN0R6K0K; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="KN0R6K0K"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3BE9A1560;
	Thu, 15 Oct 2026 10:55:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792054530; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CiCejlKL6IOFzq5NQXFhwejWWOoTsftHyAMtOfjwKOc=;
	b=KN0R6K0KbUK2Y1HxUp2sdr304/2a0/McrhguJdcq+fq/+CfaC7fx3ZkLFvh9eVJ+d6gWma
	JkTftfH6twjzHBiSWLFBiIcGuerNRtHaiV1UARWDwIQLYHpMMO7Qdb+Z3BxTYDduRl/xE7
	AoTaVJpBxq6UOk5EVCAV7IRjK4TWEt+x4H2/1mbNmjrIyWo2bc6UK1SHSABINJ0diUvcws
	x4rb4Lqr+d2AzVns/YDVG1gA16mFk4ZqkQGKfdttvRmT1/EQDlREuVi0ahBS4LlW3I/X5c
	FtGKITa/KrnLAJAURJ2abcPfD/B5CPLXu/9qQaX+x/fI6w5NcMXMbtvSR805sA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Oct 2026 10:55:28 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com, f.fainelli@gmail.com
Subject: Re: [PATCH net-next v5 7/8] net: bcmgenet: allow the MTU to be
 changed
In-Reply-To: <179198777717.434549.10480959692013383148@kernel.org>
References: <20261013-nb-genet-mtu-nn-v2-v5-7-076b6fc240be@tipi-net.de>
 <179198777717.434549.10480959692013383148@kernel.org>
Message-ID: <c8c99d1dd1e07a2467bc334f08fe920e@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 14.10.2026 16:22, netdev-bot+sashiko@kernel.org wrote:

> [...]

> [Severity: Medium]
> This is a pre-existing issue that this patch did not introduce, but 
> this
> patch adds a new caller that reaches it.
> 
> bcmgenet_netif_stop() drops the return value of bcmgenet_dma_teardown()
> and then frees the RX pages anyway:
> 
> bcmgenet_netif_stop()
>     bcmgenet_dma_teardown(priv);   /* -ETIMEDOUT ignored */
>     ...
>     bcmgenet_fini_dma(priv)
>         bcmgenet_free_rx_buffers(priv);
>         bcmgenet_destroy_rx_page_pools(priv);
> 
> Suppose bcmgenet_rdma_disable() times out because DMA_STATUS never
> acknowledges the disable. Could the RDMA engine then keep writing into
> pages that have already gone back to the page pool?

In theory. bcmgenet_close() and suspend walk the same path today and I
have never seen the disable time out on a BCM2711, so I would rather not
rework the teardown on something I cannot trigger.

> [...]

> [Severity: Medium]
> Does this restart lose the user's TX interrupt coalescing setting?
> 
> bcmgenet_set_coalesce() writes ec->tx_max_coalesced_frames straight 
> into
> the DMA_MBUF_DONE_THRESH register of each TDMA ring and keeps no 
> software
> copy. bcmgenet_get_coalesce() reads the value back from ring 0.
> 
> This path rebuilds the TX rings with a hard-coded threshold:
> 
> bcmgenet_init_dma()
>     bcmgenet_init_tx_queues()
>         bcmgenet_init_tx_ring()
>             bcmgenet_tdma_ring_writel(priv, index, 1, 
> DMA_MBUF_DONE_THRESH);
> 
> bcmgenet_init_rx_coalesce() reapplies the RX coalescing, but nothing
> restores the TX value.
> 
> Take "ethtool -C ethX tx-frames N" followed by an MTU change across
> ETH_DATA_LEN, such as 1500 to 3000. Would ethtool -c then report
> tx-frames 1?

It would, but IMHO suspend and resume drop the setting the same way 
today,
so should be fixed in net rather than here.

> [...]

> [Severity: High]
> This isn't a bug introduced by this patch, but datapath_up now tracks
> exactly this state. Should bcmgenet_suspend() check it as well?
> 
> Suppose bcmgenet_init_dma() fails in bcmgenet_resume(). The interface
> then stays netif_running() and detached:
> 
> - the earlier bcmgenet_fini_dma() has already deleted the NAPIs
> - rx_cbs and tx_cbs are freed but not set to NULL
> - the clock is gated
> 
> bcmgenet_resume()
> 	ret = bcmgenet_init_dma(priv, false);
> 	if (ret) {
> 		netdev_err(dev, "failed to initialize DMA\n");
> 		goto out_clk_disable;
> 	}
> 	...
> out_clk_disable:
> 	if (priv->internal_phy)
> 		bcmgenet_power_down(priv, GENET_POWER_PASSIVE);
> 	clk_disable_unprepare(priv->clk);
> 
> On the next system suspend, bcmgenet_suspend() checks only
> netif_running(dev). Both of its branches reach 
> bcmgenet_disable_tx_napi():
> the WoL branch directly, the other branch through 
> bcmgenet_netif_stop().
> 
> The TX NAPIs were deleted with SCHED and NPSVC still set. Would
> napi_disable_locked() then wait here forever?
> 
> 	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
> 		usleep_range(20, 200);
> 		val = READ_ONCE(n->state);
> 	}
> 
> If suspend ever got past that point, bcmgenet_tx_reclaim_all() would 
> walk
> the freed tx_cbs. bcmgenet_fini_dma() would also kfree() rx_cbs and 
> tx_cbs
> a second time, with the block unclocked.
> 
> bcmgenet_change_mtu() already handles this state ("A datapath left down 
> by
> a failed resume has nothing to reprogram either"). bcmgenet_suspend() 
> only
> gets the assignment, not an early return.
> 
> If the interface is closed after the failed resume, the new guard skips
> bcmgenet_netif_stop(). bcmgenet_close() still calls 
> bcmgenet_power_down()
> and clk_disable_unprepare(priv->clk) unconditionally. The failed resume
> already balanced the clock, so does this underflow the clock's enable 
> and
> prepare counts?
> 
> Could bcmgenet_suspend() skip the teardown when !priv->datapath_up? 
> Could
> the driver also track that the failed resume already gated the clock, 
> so
> close and suspend_noirq do not disable it again?

Yes, still pre-existing as you say. It goes into the same net series as
the dangling rx_cbs/tx_cbs which make the second teardown a double free.
I will check the clock counts there too.
