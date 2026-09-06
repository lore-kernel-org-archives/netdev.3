Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763736194C;
	Sun,  6 Sep 2026 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788706820; cv=none; b=cdZnQRMPP9k+N3vRI8XjBYIR/zX99C9HZ7JlN4AeFroiHHFFaDEdR+IsrraPrw9rXgCltBsocdESvxwdIRh1uay7Vw8txZN0t3y26AEnnXlFemCO/8GwvQN5Jvq+f8dfnwkj7l8emw3fviL6OBv2zlgEKIIYwElqO6OyOiGPQnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788706820; c=relaxed/simple;
	bh=qkH5ZLYexfKdcJNsx80mxBTFbKJyccLqmJDtCZ3CIEE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rk1yB5X8teTcohsvNvoTIN9Kkn4X7+EM8Kg3eDHRD5ugpmyqF+0Qsd/lo5Jfy4JPXhiDWaNul7C+frrCT25v6RZGhNAxaBrdieuXmr5r1JONqcHJozU4XQfMz/j6qZf8Ko9TS81QaHwk8gwzcmYEAsvbJp1OxbxoRUCfPTRIobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbSf2AHB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbSf2AHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790CE1F00A3A;
	Sun,  6 Sep 2026 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788706818;
	bh=eXSsuSAzLI/VrVobKaxUE9hne+qRwLkijeVloyXvwJs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lbSf2AHBV73/eXZkb4Te8dNMAYWleLPyjpBkgOZNLgdaXgfiugjQuBbMDpnlokKk3
	 V9XOjQjLAdsnwrdoLNIY+MAdl4rVJx0GntcS8XyTz1P0lAlpCrWeP3pDc1ejGg669e
	 +FGU2xguylRv2RYg2aWJ99a1rLIW7W1xoPbQ71Xa2e+7I2YIjZxL8Tt1GuG1io/toj
	 Xwi994KA69rWpmD2DAHaM2IDOCIXXNuPohtNwFp+JkaFvsfGisk7TjZIgawxEvg9IL
	 7ZcCo0qHCLdkGFH2Ns6gWxxAzJbawZY8h3NR5D0lwbhfISGoLUtBv7WvO2x7WB9YFD
	 9Mg5PSIm1jfDA==
Subject: Re: [PATCH net v3] net: wwan: qcom_bam_dmux: account network packets
From: netdev-bot+sashiko@kernel.org
To: sinyavin@gmail.com
Cc: stephan@gerhold.net, stephan.gerhold@linaro.org,
 loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 06 Sep 2026 15:00:17 +0000
Message-ID: <178870681701.219967.5248698671156408999@kernel.org>
In-Reply-To: <20260902124506.363174-1-sinyavin@gmail.com>
References: <20260902124506.363174-1-sinyavin@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 1 (1) · Low: 0

- [High] Use-after-free write of freed per-CPU statistics memory from the
  TX DMA completion callback.
- [Medium] Asymmetric / incomplete drop accounting introduced with the
  new statistics plumbing.

Pre-existing issues:
- [High] Disclosure of uninitialized/stale kernel memory driven by the
  modem-supplied length field.
- [Medium] struct net_device leak on the driver removal path:
  bam_dmux_register_netdev_work() allocates each interface with…

--

net: wwan: qcom_bam_dmux: account network packets

The patch adds per-CPU software statistics to the BAM-DMUX data path by
setting NETDEV_PCPU_STAT_TSTATS, wiring up dev_get_tstats64() and
accounting TX packets from the DMA completion callback and RX packets after
the BAM-DMUX header is removed. It also counts packets discarded by the
transmit error path.

A few questions on the statistics plumbing below.

> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
> index cc6ace8d6437..ef3356200b3e 100644
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
Can this write through a freed per-CPU pointer when a TX descriptor
completes while the device is being removed?

dev_sw_netstats_tx_add() dereferences dev->tstats with no validity check:

include/linux/netdevice.h:
    static inline void dev_sw_netstats_tx_add(struct net_device *dev,
                                              unsigned int packets,
                                              unsigned int len)
    {
            struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
            ...

For NETDEV_PCPU_STAT_TSTATS that pointer is released by
netdev_run_todo() -> netdev_do_free_pcpu_stats():

net/core/dev.c:netdev_do_free_pcpu_stats() {
        case NETDEV_PCPU_STAT_TSTATS:
                free_percpu(dev->tstats);
                break;
}

and dev->tstats is not cleared afterwards.

In bam_dmux_remove() the todo list runs inside rtnl_unlock(), while the TX
DMA channel is only stopped much later:

    unregister_netdevice_many(&list);
    rtnl_unlock();                      /* netdev_run_todo(): tstats freed */
    cancel_work_sync(&dmux->tx_wakeup_work);
    ...
    if (!wait_event_timeout(dmux->pc_wait, !dmux->rx, BAM_DMUX_REMOTE_TIMEOUT))
            dev_err(dev, "Timed out waiting for remote side to suspend\n");
    disable_irq(dmux->pc_irq);
    bam_dmux_power_off(dmux);            /* dmaengine_terminate_sync(dmux->tx) */

Does anything prevent a descriptor still owned by the BAM hardware from
completing inside that window (which can include a BAM_DMUX_REMOTE_TIMEOUT
wait of up to two seconds) and running dev_sw_netstats_tx_add() on the
freed percpu chunk?

The deferred path looks similar: a packet queued through the "active <= 0"
branch of bam_dmux_netdev_start_xmit() is submitted by
bam_dmux_tx_wakeup_work(), which is only cancelled after rtnl_unlock(), and
cancel_work_sync() waits for the work function, not for the DMA it just
issued.

Can the "if (netdev)" test catch any of this?  skb->dev holds no reference,
bam_dmux_netdev_setup() never sets dev->needs_free_netdev and no
priv_destructor is installed, so the struct net_device body is still
readable and the pointer test passes even though tstats is gone.

The same exposure exists on receive: dmux->netdevs[] is never cleared in
bam_dmux_remove(), and bam_dmux_cmd_data() tests
"!netdev || !netif_running(netdev)" on entry but writes dev->tstats further
down, in tasklet context, while unregistration proceeds in process context.

> @@ -368,6 +372,7 @@ static netdev_tx_t bam_dmux_netdev_start_xmit(struct sk_buff *skb,
>  
>  drop:
>  	bam_dmux_tx_done(skb_dma);
> +	dev_core_stats_tx_dropped_inc(netdev);
>  	dev_kfree_skb_any(skb);
>  	return NETDEV_TX_OK;
>  }

[Severity: Medium]
With this increment the driver starts reporting the dropped fields of
rtnl_link_stats64, but two sibling discard sites are left uncounted.  Was
that intentional?

bam_dmux_tx_wakeup_work() finishes the deferred branch for skbs already
accepted with NETDEV_TX_OK, and neither of its failure paths reaches
bam_dmux_tx_callback():

    ret = pm_runtime_resume_and_get(dmux->dev);
    if (ret < 0) {
            dev_err(dmux->dev, "Failed to resume: %d\n", ret);
            return;
    }
    ...
    for_each_set_bit(i, &pending, BAM_DMUX_NUM_SKB) {
            bam_dmux_skb_dma_submit_tx(&dmux->tx_skbs[i]);
    }

The submit return value is discarded, and it can fail:

    if (!desc) {
            dev_err(dmux->dev, "Failed to prepare TX DMA buffer\n");
            return false;
    }

so such a packet moves neither tx_packets nor tx_dropped.  (The skb is also
leaked and its ring slot wedged there, which predates this patch, but it is
the reason no counter can move.)

On the receive side, bam_dmux_cmd_data() returns early for
"!netdev || !netif_running(netdev)" and for "hdr->len > BAM_DMUX_MAX_DATA_SIZE",
and bam_dmux_rx_callback() drops frames with a bad magic, all before the new
dev_sw_netstats_rx_add().  None of them touches rx_dropped or rx_errors, so
userspace now sees TX discards while RX discards stay at zero.  Could
dev_core_stats_rx_dropped_inc() be added on those paths, where a valid
netdev is already in hand?

[ ... ]

> @@ -421,6 +427,7 @@ static void bam_dmux_netdev_setup(struct net_device *dev)
>  	dev->needed_headroom = sizeof(struct bam_dmux_hdr);
>  	dev->needed_tailroom = sizeof(u32); /* word-aligned */
>  	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
> +	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;

[Severity: Medium]
This isn't a bug introduced by this patch, but does the driver leak every
registered struct net_device on unbind?  bam_dmux_netdev_setup() sets no
dev->needs_free_netdev here (and no priv_destructor is installed anywhere in
the file), and bam_dmux_remove() only unregisters:

    for (i = 0; i < BAM_DMUX_NUM_CH; ++i)
            if (dmux->netdevs[i])
                    unregister_netdevice_queue(dmux->netdevs[i], &list);
    unregister_netdevice_many(&list);
    rtnl_unlock();

with no matching free_netdev().  free_netdev() appears only on the
register_netdev() failure path in bam_dmux_register_netdev_work().
netdev_run_todo() frees the per-CPU stats unconditionally but only frees the
device when needs_free_netdev is set:

net/core/dev.c:netdev_run_todo() {
        netdev_do_free_pcpu_stats(dev);
        if (dev->priv_destructor)
                dev->priv_destructor(dev);
        if (dev->needs_free_netdev)
                free_netdev(dev);
}

so each wwan%d device and its private area stay allocated, and
dmux->netdevs[] keeps pointing at them.  This is also why the freed-tstats
write above does not fault and can pass casual testing.

> @@ -533,6 +540,7 @@ static void bam_dmux_cmd_data(struct bam_dmux_skb_dma *skb_dma)
>  		break;
>  	}
>  
> +	dev_sw_netstats_rx_add(netdev, skb->len);
>  	netif_receive_skb(skb);
>  }

[Severity: High]
This is a pre-existing issue, but does skb->len here describe bytes the modem
actually transferred?

bam_dmux_skb_dma_queue_rx() allocates a non-zeroed buffer and puts the whole
thing:

    skb_dma->skb = __netdev_alloc_skb(NULL, BAM_DMUX_BUFFER_SIZE, gfp);
    if (!skb_dma->skb)
            return false;
    skb_put(skb_dma->skb, BAM_DMUX_BUFFER_SIZE);

so skb->len is always BAM_DMUX_BUFFER_SIZE regardless of the transfer size,
and nothing in the driver queries the DMA residue (no dma_tx_status() call
anywhere).  bam_dmux_cmd_data() then only bounds the peer-supplied length:

    if (hdr->len > BAM_DMUX_MAX_DATA_SIZE) { ... return; }
    ...
    skb_pull(skb, sizeof(*hdr));
    skb_trim(skb, hdr->len);

Since skb_trim() can only shrink, a modem that writes a short frame but
declares hdr->len = BAM_DMUX_MAX_DATA_SIZE gets the stale contents of the
recycled page frag delivered to netif_receive_skb() as payload, and the new
dev_sw_netstats_rx_add(netdev, skb->len) counts those bytes as received
traffic.  Should hdr->len be clamped to the actually transferred length, or
the RX buffer zeroed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902124506.363174-1-sinyavin%40gmail.com
