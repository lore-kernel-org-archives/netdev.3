Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2967551C34E;
	Fri,  4 Sep 2026 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560687; cv=none; b=KaTxBNBmpAwhW176Pb+J1JbOZcZsyGt2nFyAQ8rlnaYxk75L2w9oAsr5HF7dT1YbroZOyni/4vEeZ2HqpqoAIX9TCCXYpMX4GbLmPBOyz1815EBIUZgPxozpWFnV/njbLQzxyeg32LUkVClhCEXBnjmiQ9Phi3InjLb36uGy05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560687; c=relaxed/simple;
	bh=tTMHZ4FuoOhLqZFAf5pVaw5zQ59a6aZoTNWLzsGfKV0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ghYDP8g9+gJmYKwsmh+TouSo9bYL7DOFnSP9DReRH97iAMFSpnmr5eW3cZ/C3jtqkVnjc1cdPJdl4P9RHYnZnsFWMQszTX+u4CuPZlQNiyeKI/Rj1FXZnM4FEqvq5C4aUdxhQH5W44mRej5jfy64HuKtGfBHCiKNipwJdHk7JpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePLsWfZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePLsWfZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8993B1F00A3E;
	Fri,  4 Sep 2026 22:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560682;
	bh=Dlc5HEqeqW5ha2l+K2IZjg6dMaSI48BAK1XRN67A5WE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ePLsWfZ2tHbGzbVDCLbK8jhJDARCZ334Bc3OSmTe+JpO4/oKWamKfq154n6oYP2Ku
	 Yn06ykMjUBrC3jBiDoYFVYwZqmnReEgHr3ADsZ/BK7qr/5d29Xr0+SP8dZvns0ShGz
	 kkcl3Lddt3ve+ISjknnIuI+AH2Ct/yyQMdYglXTYyXf904OIapzC7Wy9q8zmHwXZRZ
	 EGbvmBxL1msir3U/7vHhJoL5hEAOrhnMxIrBwvg2/2isfnCFEdOFP2IQNFMcnJhD0Q
	 eVmrbNvfmFcXfBmzi0tXnLiO4oCKezh+ZL86WWtIeV9jenC9B5r545CaPBDfAKB0zf
	 rBUH4vlMFb7FQ==
Subject: Re: [PATCH net] net: wwan: qcom_bam_dmux: account network packets
From: netdev-bot+sashiko@kernel.org
To: sinyavin@gmail.com
Cc: stephan@gerhold.net, loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 04 Sep 2026 22:24:41 +0000
Message-ID: <178856068113.219967.2076451083879151620@kernel.org>
In-Reply-To: <20260830085400.2542956-1-sinyavin@gmail.com>
References: <20260830085400.2542956-1-sinyavin@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 (2) · Low: 0

- [High] Use-after-free write of the per-CPU netdev statistics from the
  BAM DMA completion tasklet.

Pre-existing issues:
- [Medium] Registered net_devices are never freed on driver removal.
- [Medium] bam_dmux_cmd_data() trims the RX skb to the modem-supplied
  hdr->len (skb_trim(skb, hdr->len), qcom_bam_dmux.c:529) after only…

--

net: wwan: qcom_bam_dmux: account network packets

The patch makes the BAM-DMUX driver maintain per-CPU software statistics
so that userspace no longer sees zero traffic.  TX bytes/packets are
accounted from the DMA completion callback and RX bytes/packets from the
data command handler, with dev_get_tstats64() wired up as
ndo_get_stats64.

A few questions below about the netdev lifetime in the new accounting
paths.

> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
> index cc6ace8d6437..40c40bc5645a 100644
> --- a/drivers/net/wwan/qcom_bam_dmux.c
> +++ b/drivers/net/wwan/qcom_bam_dmux.c
> @@ -177,8 +177,15 @@ static void bam_dmux_tx_callback(void *data)
>  {
>  	struct bam_dmux_skb_dma *skb_dma = data;
>  	struct sk_buff *skb = skb_dma->skb;
> +	struct net_device *netdev = skb->dev;
> +	unsigned int len = 0;
> +
> +	if (netdev)
> +		len = ((struct bam_dmux_hdr *)skb->data)->len;
>  
>  	bam_dmux_tx_done(skb_dma);
> +	if (netdev)
> +		dev_sw_netstats_tx_add(netdev, 1, len);
>  	dev_consume_skb_any(skb);
>  }

[Severity: High]
Can this write into freed per-CPU memory during driver removal?

skb->dev here is a borrowed pointer with no reference taken, and
dev_sw_netstats_tx_add() expands to this_cpu_ptr(dev->tstats) plus
u64_stats_add().  Once the netdev is unregistered, netdev_run_todo()
calls netdev_do_free_pcpu_stats(), which for NETDEV_PCPU_STAT_TSTATS
does:

net/core/dev.c:netdev_do_free_pcpu_stats() {
	case NETDEV_PCPU_STAT_TSTATS:
		free_percpu(dev->tstats);
		break;
}

dev->tstats is not set to NULL there, and this runs regardless of
needs_free_netdev.

In bam_dmux_remove() the unregistration completes well before the TX
DMA channel is stopped:

drivers/net/wwan/qcom_bam_dmux.c:bam_dmux_remove() {
	unregister_netdevice_many(&list);
	rtnl_unlock();			/* netdev_run_todo(): tstats freed */
	cancel_work_sync(&dmux->tx_wakeup_work);
	...
	if (!wait_event_timeout(dmux->pc_wait, !dmux->rx, BAM_DMUX_REMOTE_TIMEOUT))
	...
	bam_dmux_power_off(dmux);	/* dmaengine_terminate_sync(dmux->tx) */
	bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
}

Is any TX descriptor completing in that window (which includes a
wait_event_timeout() of up to BAM_DMUX_REMOTE_TIMEOUT) going to run
bam_dmux_tx_callback() with skb->dev pointing at the unregistered
netdev, and write through the already freed dev->tstats?

The presence of bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE) at the
end of bam_dmux_remove() suggests outstanding TX skbs are an expected
state at that point.  bam_dmux_netdev_stop() only stops the queue and
sends a CLOSE command, so netdev_wait_allrefs_any() has nothing to wait
on for in-flight descriptors.

There is also the deferred submit path: bam_dmux_netdev_start_xmit()
can hand work to bam_dmux_tx_wakeup_work(), which blocks in
pm_runtime_resume_and_get() (bam_dmux_runtime_resume() can wait
several seconds) and only afterwards calls bam_dmux_skb_dma_submit_tx()
and dma_async_issue_pending().  Can descriptors be submitted there
after the netdevs and their tstats are already gone?

Would accounting TX in bam_dmux_netdev_start_xmit(), where the netdev is
guaranteed live, or terminating the DMA channels and clearing
dmux->netdevs[] before unregistering, avoid this?

[ ... ]

> @@ -421,6 +429,7 @@ static void bam_dmux_netdev_setup(struct net_device *dev)
>  	dev->needed_headroom = sizeof(struct bam_dmux_hdr);
>  	dev->needed_tailroom = sizeof(u32); /* word-aligned */
>  	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
> +	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;

[Severity: High]
This is the line that makes register_netdevice() allocate dev->tstats and
netdev_run_todo() free it, so it is the other half of the question above.

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but while
looking at bam_dmux_netdev_setup() I noticed it sets neither
dev->needs_free_netdev nor a priv_destructor, and bam_dmux_remove() only
does unregister_netdevice_queue()/unregister_netdevice_many() with no
matching free_netdev().  The only free_netdev() in the driver is the
register_netdev() failure path in bam_dmux_register_netdev_work():

	ret = register_netdev(netdev);
	if (ret) {
		...
		free_netdev(netdev);
		return;
	}

Since netdev_run_todo() only frees the device when dev->needs_free_netdev
is set, does every successfully registered wwan%d interface (up to
BAM_DMUX_NUM_CH) leak its struct net_device on unbind or module unload?

> @@ -533,6 +542,7 @@ static void bam_dmux_cmd_data(struct bam_dmux_skb_dma *skb_dma)
>  		break;
>  	}
>  
> +	dev_sw_netstats_rx_add(netdev, skb->len);
>  	netif_receive_skb(skb);
>  }

[Severity: High]
On the RX side, netdev comes from dmux->netdevs[hdr->ch], which is never
cleared on unregister, and the only gate is:

	if (!netdev || !netif_running(netdev)) {
		dev_warn(dmux->dev, "Data for inactive channel %u\n", hdr->ch);
		return;
	}

Since this check runs on the DMA tasklet while dev_close() and
unregistration can proceed in parallel, can the check pass and
dev_sw_netstats_rx_add() then write through a dev->tstats that
netdev_run_todo() has already freed?  Before this patch the same stale
pointer was only dereferenced for reads on this path.

[Severity: Medium]
This isn't a bug introduced by this patch, but the length now being
counted as rx_bytes is entirely modem-supplied.  bam_dmux_cmd_data()
only bounds it against BAM_DMUX_MAX_DATA_SIZE and then trims to it:

	if (hdr->len > BAM_DMUX_MAX_DATA_SIZE) {
		...
		return;
	}
	...
	skb_pull(skb, sizeof(*hdr));
	skb_trim(skb, hdr->len);

The RX buffers come from bam_dmux_skb_dma_queue_rx() and are neither
zeroed nor sized to the actual transfer:

	if (!skb_dma->skb) {
		skb_dma->skb = __netdev_alloc_skb(NULL, BAM_DMUX_BUFFER_SIZE, gfp);
		if (!skb_dma->skb)
			return false;
		skb_put(skb_dma->skb, BAM_DMUX_BUFFER_SIZE);
	}

bam_dmux_rx_callback() never consults a transferred length or residue,
and the buffers are reused across receives.  If the modem declares
hdr->len larger than the payload it actually DMA'd, are the trailing
bytes of the reused 2 KB buffer (previous packet contents, or
uninitialized heap on first use) passed to netif_receive_skb() and now
also counted by dev_sw_netstats_rx_add(netdev, skb->len)?

I could not confirm from the BAM DMA driver whether a short transfer is
reportable at all, so this part may not be reachable in practice.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260830085400.2542956-1-sinyavin%40gmail.com
