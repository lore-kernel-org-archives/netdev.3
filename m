Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8543C3C16;
	Wed,  9 Sep 2026 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990026; cv=none; b=pwR83zqRgbvY3a4hDuwBydhw+PH7PAOzXUlSdtgoMk0r6XGn86pL61aZ9iBTL7Txv8rnO6v7IxT4LAjnMaXIE0S5KsQZ6QwalQg4A+elcZ6RNeB4TcJ6IypWqEywD4s5B5SwGD8WAA+EX8GrTzsjbXprhydxzj7E2xRwSqqp11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990026; c=relaxed/simple;
	bh=xfVJea4uY5edbVA/Kqv7Xt2stEqupQMgz6KCOci0o0g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RRCz0zXAhvmv91nn0Ff9pn7XguS1Ughb63OOpaEzc097NePUeAJE78G18SjMo7DrptzFPE11QgxTx/WH6deV9Tse85ZUQigzoGV5jcZaVSibISrQg1pxb7YwCWENesBojDB4VcTPQqAhaKVZq2Cp0aXwnoWsFror0ijOc2ESkj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkSeHm9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkSeHm9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F61F1F000FF;
	Wed,  9 Sep 2026 21:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788990013;
	bh=Q65d2+vKaeIvv1aFsZlNeZwHA/AqvMGseC0yWChkYPw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EkSeHm9NrHRF4EN0XUN3SyzkBkhH7n4ABKoVlOWsi3M9NiEqoKQkXqqZRuQiVYHff
	 d6zAdSXr3JeNlhG3Y0ea2feamIG1tXlNG9MW+YEIc5Es/vBnjDuL3sOFtIm0FRRkD0
	 uZh9XRm6rbRDEONCDe700aC8EVotLENpOF/Mw8qmjILDtELBqX532Gt9C+qUfOQv9H
	 Kw4tGt+mAGZzJXus6Yn0WGWc7itSMXNdSho94OElCwhll98YTE1rNHTC4WRNtTcvpu
	 0lDscfq8PUx96tphDiFuuQcAla0PEysd7OrusMSYayZhEpmcuk8Ddh0Kk0KBePdems
	 fn2ux5Z6gQnLg==
Subject: Re: [PATCH net v4] net: wwan: qcom_bam_dmux: account network packets
From: netdev-bot+sashiko@kernel.org
To: sinyavin@gmail.com
Cc: stephan@gerhold.net, stephan.gerhold@linaro.org,
 loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 21:40:11 +0000
Message-ID: <178899001185.219967.6678486297703743680@kernel.org>
In-Reply-To: <20260904183737.2994139-1-sinyavin@gmail.com>
References: <20260904183737.2994139-1-sinyavin@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] In `bam_dmux_netdev_start_xmit()` the new
  `dev_sw_netstats_tx_add(netdev, 1, len)`…

--

net: wwan: qcom_bam_dmux: account network packets

The BAM-DMUX data path did not update the netdev packet and byte counters,
so userspace saw zero traffic.  This adds per-CPU software statistics with
NETDEV_PCPU_STAT_TSTATS and dev_get_tstats64(), counting TX in
bam_dmux_netdev_start_xmit() and RX in bam_dmux_cmd_data().

> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
> index cc6ace8d64371..03360301c8ee5 100644
> --- a/drivers/net/wwan/qcom_bam_dmux.c
> +++ b/drivers/net/wwan/qcom_bam_dmux.c

[ ... ]

> @@ -357,17 +358,19 @@ static netdev_tx_t bam_dmux_netdev_start_xmit(struct sk_buff *skb,
>  		if (!atomic_long_fetch_or(BIT(skb_dma - dmux->tx_skbs),
>  					  &dmux->tx_deferred_skb))
>  			queue_pm_work(&dmux->tx_wakeup_work);
> -		return NETDEV_TX_OK;
> -	}
> +	} else {
> +		if (!bam_dmux_skb_dma_submit_tx(skb_dma))
> +			goto drop;
>  
> -	if (!bam_dmux_skb_dma_submit_tx(skb_dma))
> -		goto drop;
> +		dma_async_issue_pending(dmux->tx);
> +	}
>  
> -	dma_async_issue_pending(dmux->tx);
> +	dev_sw_netstats_tx_add(netdev, 1, len);
>  	return NETDEV_TX_OK;

[Severity: Medium]
Is it intended that dev_sw_netstats_tx_add() now also covers the deferred
branch, where nothing has been submitted to the DMA engine yet?

In the active <= 0 case the skb is only marked in dmux->tx_deferred_skb and
bam_dmux_tx_wakeup_work() is queued.  The descriptor is prepared later in
that worker, which can bail out before submitting anything:

drivers/net/wwan/qcom_bam_dmux.c:bam_dmux_tx_wakeup_work() {
	ret = pm_runtime_resume_and_get(dmux->dev);
	if (ret < 0) {
		dev_err(dmux->dev, "Failed to resume: %d\n", ret);
		return;
	}
	...
	for_each_set_bit(i, &pending, BAM_DMUX_NUM_SKB) {
		bam_dmux_skb_dma_submit_tx(&dmux->tx_skbs[i]);
	}
	...
}

bam_dmux_runtime_resume() can return -ETIMEDOUT from any of its three 2
second waits on the remote modem, or -ENXIO when the TX channel cannot be
requested, for example after a modem crash or power collapse.  In that case
the worker returns with the packet still sitting in dmux->tx_skbs[], while
tx_packets/tx_bytes have already been incremented for it and tx_dropped is
never touched.

The other failure mode is the return value of the same helper being ignored
in the worker:

drivers/net/wwan/qcom_bam_dmux.c:bam_dmux_skb_dma_submit_tx() {
	desc = dmaengine_prep_slave_single(dmux->tx, skb_dma->addr,
					   skb_dma->skb->len, DMA_MEM_TO_DEV,
					   DMA_PREP_INTERRUPT);
	if (!desc) {
		dev_err(dmux->dev, "Failed to prepare TX DMA buffer\n");
		return false;
	}
	...
}

So the two callers of bam_dmux_skb_dma_submit_tx() end up with opposite
accounting: start_xmit() counts a drop via dev_core_stats_tx_dropped_inc(),
the worker counts nothing at all.

The commit message says the counters are updated "after the driver has
prepared and accepted them", which explains counting at accept time, but
would it be better to account the deferred packets from
bam_dmux_tx_wakeup_work() once submission succeeds, and to increment
tx_dropped there when it does not?

> drop:
>  	bam_dmux_tx_done(skb_dma);
> +	dev_core_stats_tx_dropped_inc(netdev);
>  	dev_kfree_skb_any(skb);
>  	return NETDEV_TX_OK;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904183737.2994139-1-sinyavin%40gmail.com
