Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2353E6DF7;
	Wed,  2 Sep 2026 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788383485; cv=none; b=OAUs9CO1DseiyVCQ5BWsZEEov6TvTMhuaoGyZ8j3ZfDaSaC6jYMeLLCX/IcAWQCsjsg0t6WAIYNP6NIBtAIGEIgeSdbV1Idkv0lFHXbeHV4EIWENMHPVgj0D8godLe/K1RV85Hk1xqXsTvUpFJLQOcJT/1VaQ8ekVFI5z8DVjTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788383485; c=relaxed/simple;
	bh=1pkVeZoMJT8Hlv5Y2kTvQ9rQzv1D9wp5qa9D+tD5bdY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oEP0J4+C7L/XyLJqC78q/TsNG7ZnisTJbx4244Qe+gUlYoelSj+DxCxWpcDAuIefnRiwavabxPd6iA7DUUn9bf3vL9AyNptcyNIu/+NaLqLpBV719hgLSk82sPZPPa5jsdX/4pltg0IE2V6A8WoWz4nefitU+h1nkEX7v/Lmmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMuXbAsw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMuXbAsw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E0F1F000E9;
	Wed,  2 Sep 2026 21:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788383483;
	bh=pCZJHKeytEx9moXuPcXu+qxXE/yek+mRpLJWqTDgaDc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UMuXbAsw1NvK5+mJYeorWfGPFnI2sZp+K9aG1JqzuC8wdgCf8YXgTE2aRh0shOfEa
	 86JKLU7N4Qe3y1Qi79ma14bs2LQjlCjH9TyfpWEB0MLbpBft0x6tuwYgJhig3O/OM4
	 mLu3jcjsJyexng1/hpQnCmZge5gHBgmNfv2dyMXd1rWsK5m7zXz3E905Bs4ZO/32Ya
	 9ziOLQI5h8LK1ZMUwSsKaMUY09cPvJfbXqbYPtYo/tp6zgGjQz7P8mqxiCCm2vR3J0
	 tnSG8JQAAzunfiL+9lWtmSXbZQj/ETi5rDubaFbiYbkXgcSo6iHNJZia9DrhPcRXA1
	 d+52pM+NuLEFQ==
Subject: Re: [net,v2] net: wwan: qcom_bam_dmux: account network packets
From: netdev-bot+sashiko@kernel.org
To: sinyavin@gmail.com
Cc: stephan@gerhold.net, stephan.gerhold@linaro.org,
 loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 02 Sep 2026 21:11:22 +0000
Message-ID: <178838348238.3394541.9061693826070810058@kernel.org>
In-Reply-To: <20260831181006.1382372-1-sinyavin@gmail.com>
References: <20260831181006.1382372-1-sinyavin@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0 (1)

- [High] Use-after-free write of the netdevice's core-allocated per-CPU
  statistics from the asynchronous BAM TX completion callback.

Pre-existing issues:
- [Medium] The driver allocates netdevs with alloc_netdev() in
  bam_dmux_register_netdev_work() but bam_dmux_remove() only calls…
- [Low] Drop paths remain uncounted after the patch: the `drop:` label in
  bam_dmux_netdev_start_xmit() (drivers/net/wwan/qcom_bam_dmux.c,…

--

net: wwan: qcom_bam_dmux: account network packets

The patch makes the BAM-DMUX driver maintain rx/tx packet and byte counters
using the core per-CPU software statistics (NETDEV_PCPU_STAT_TSTATS plus
dev_get_tstats64()). TX is accounted in the DMA completion callback and RX
after the BAM-DMUX header and padding are stripped.

Link: https://lore.kernel.org/netdev/20260830085400.2542956-1-sinyavin@gmail.com/ (v1)

> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
> index cc6ace8d6437..5bcac2ccaabd 100644
> --- a/drivers/net/wwan/qcom_bam_dmux.c
> +++ b/drivers/net/wwan/qcom_bam_dmux.c
> @@ -177,8 +177,12 @@ static void bam_dmux_tx_callback(void *data)
>  {
>  	struct bam_dmux_skb_dma *skb_dma = data;
>  	struct sk_buff *skb = skb_dma->skb;
> +	struct net_device *netdev = skb->dev;
>  
>  	bam_dmux_tx_done(skb_dma);
> +	if (netdev)
> +		dev_sw_netstats_tx_add(netdev, 1,
> +				       ((struct bam_dmux_hdr *)skb->data)->len);
>  	dev_consume_skb_any(skb);
>  }

[Severity: High]
Can this write to freed per-CPU memory?  bam_dmux_tx_callback() runs from
the BAM dmaengine completion (vchan tasklet), and skb->dev is not a
counted reference.  dev_sw_netstats_tx_add() then does:

include/linux/netdevice.h:dev_sw_netstats_tx_add() {
	struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);

	u64_stats_update_begin(&tstats->syncp);
	u64_stats_add(&tstats->tx_bytes, len);
	...
}

With dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS, dev->tstats is
allocated by register_netdevice() and released at unregistration time,
independent of needs_free_netdev/free_netdev:

net/core/dev.c:netdev_run_todo() {
	...
		netdev_do_free_pcpu_stats(dev);
		if (dev->priv_destructor)
			dev->priv_destructor(dev);
		if (dev->needs_free_netdev)
			free_netdev(dev);
	...
}

In bam_dmux_remove() the TX channel is still armed when that happens:

drivers/net/wwan/qcom_bam_dmux.c:bam_dmux_remove() {
	...
	unregister_netdevice_many(&list);
	rtnl_unlock();			/* netdev_run_todo() frees tstats */
	cancel_work_sync(&dmux->tx_wakeup_work);
	...
	if (!wait_event_timeout(dmux->pc_wait, !dmux->rx, BAM_DMUX_REMOTE_TIMEOUT))
	...
	disable_irq(dmux->pc_irq);
	bam_dmux_power_off(dmux);	/* dmaengine_terminate_sync(dmux->tx) */
	bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
}

The only synchronous TX quiesce point is dmaengine_terminate_sync(dmux->tx)
inside bam_dmux_power_off(), which is reached after rtnl_unlock(),
cancel_work_sync(), the pm_runtime teardown and a wait_event_timeout() of
up to BAM_DMUX_REMOTE_TIMEOUT.  bam_dmux_netdev_stop() only does
netif_stop_queue() plus a CLOSE command, so it neither terminates nor
drains outstanding descriptors:

drivers/net/wwan/qcom_bam_dmux.c:bam_dmux_netdev_stop() {
	netif_stop_queue(netdev);
	bam_dmux_send_cmd(bndev, BAM_DMUX_CMD_CLOSE);
	return 0;
}

Does any TX descriptor still in flight during that window end up doing
this_cpu_ptr() on an already freed (possibly recycled) tstats pointer?

The "if (netdev)" test only filters the driver's own command skbs, which
come from alloc_skb() and leave skb->dev NULL, so it does not say anything
about registration state.

Would accounting TX in bam_dmux_netdev_start_xmit(), where the netdev is
provably live and hdr->len is already known, avoid this?  Alternatively,
would terminating/draining the DMA channels and clearing dmux->netdevs[]
before unregister_netdevice_many() close the window?

[ ... ]

> @@ -421,6 +426,7 @@ static void bam_dmux_netdev_setup(struct net_device *dev)
>  	dev->needed_headroom = sizeof(struct bam_dmux_hdr);
>  	dev->needed_tailroom = sizeof(u32); /* word-aligned */
>  	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
> +	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but it
interacts with the new stats memory, so it is worth mentioning here.
bam_dmux_register_netdev_work() allocates the netdev with alloc_netdev(),
bam_dmux_netdev_setup() never sets dev->needs_free_netdev, and
bam_dmux_remove() only calls unregister_netdevice_queue() /
unregister_netdevice_many() with no free_netdev().

net/core/dev.c:netdev_run_todo() {
	...
		if (dev->needs_free_netdev)
			free_netdev(dev);

		cnt++;

		/* Free network device */
		kobject_put(&dev->dev.kobj);
	...
}

The kobject_put() there only balances the kobject_get() taken in
netdev_unregister_kobject(), so the device_initialize() reference is never
dropped and netdev_release() (kvfree(dev)) never runs.  Does this leak the
struct net_device, its private data and its queue arrays on every driver
removal?

Would setting dev->needs_free_netdev = true here (next to the new
pcpu_stat_type assignment), or pairing the alloc_netdev() with an explicit
free_netdev() in bam_dmux_remove(), be the right fix?

Note also that the still-allocated, still-readable net_device is what makes
the freed dev->tstats access above silent rather than an obvious fault.

> @@ -533,6 +539,7 @@ static void bam_dmux_cmd_data(struct bam_dmux_skb_dma *skb_dma)
>  		break;
>  	}
>  
> +	dev_sw_netstats_rx_add(netdev, skb->len);
>  	netif_receive_skb(skb);
>  }

[Severity: Low]
This is a pre-existing gap rather than something this patch introduces, but
now that rx/tx counters become non-zero the missing drop counters are more
visible.

The TX error path frees the skb and reports success without any
tx_dropped/tx_errors accounting:

drivers/net/wwan/qcom_bam_dmux.c:bam_dmux_netdev_start_xmit() {
	...
drop:
	bam_dmux_tx_done(skb_dma);
	dev_kfree_skb_any(skb);
	return NETDEV_TX_OK;
}

and the RX early returns are not counted either:

drivers/net/wwan/qcom_bam_dmux.c:bam_dmux_cmd_data() {
	...
	if (!netdev || !netif_running(netdev)) {
		dev_warn(dmux->dev, "Data for inactive channel %u\n", hdr->ch);
		return;
	}

	if (hdr->len > BAM_DMUX_MAX_DATA_SIZE) {
		...
		return;
	}
	...
}

Would it make sense to also bump rx_dropped/tx_dropped on these paths, so
that ip -s link can explain the loss instead of showing traffic counters
with permanently zero drops?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831181006.1382372-1-sinyavin%40gmail.com
