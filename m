Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCE039CCF6;
	Fri, 25 Sep 2026 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363921; cv=none; b=tkeGlzHfszQCEbDsBNZgSmVdsWdj6JJ3IKSVWe+8AFJzmzE7j8W/e7bOGaa1Vf94p5QgI20Z7TqLlzWnOC3Agm71lDwtKsrIwqmf3aAa9oL7d6A7ey7ZwcuAtr5W2LF9I95WGrRtKPodQI1Up23PhYnjmtkZHdElXT1rbi9V/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363921; c=relaxed/simple;
	bh=Ym6T4mXW6r1/YfNmruhm3F545DWfvMHi2Lg/bixoWc4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UzMG9K16u71feWD/3NJ70pWI07j3CYw5lVzEem24Etw46+M8SuyVoZyHRMEmr5U88NtsAkWYKGap5UceO1TjZViRHMVnkFjGiDGkv6nqPCTK6TqcDljTWmi8RQPm+Hsk75Y8gXrAVcOyLK9QhvpF9/FytOiT6D4wbuELsy2s5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eb4GTqLr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eb4GTqLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0C61F000FF;
	Fri, 25 Sep 2026 19:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790363920;
	bh=K44xrJgi8PR+13IpF2jFQbUWePxlN4h6DZCWQnQTlOE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eb4GTqLruMwZvCPESyFGY/0dLV43gsjtJ1e3RyZqAZbutCZMaDwTD+58St9y4RkOB
	 vCaUoXA80df+O2iA1Y1Nw0CKRju25DG785/hq/CwjhnH//mZD4htcUboxTqAtlnRCU
	 J1Vm+/qQ3R1W50+zs9TNQNYEN8x/BTGXCTWFgeFQDN1TADw28cmW4CfwPcQseUM8VX
	 Md56+niuZEAUY1VSG3onLfrFF8tq3171I7ydqMdDacqsp+c7iP/TZkfyXJgYt27WpN
	 0yMt8LFH/Hg4iaI73alYwWF10cYwjJeKeehh5UGsIdPHSXePERI0JxYsWOrgGwiIQT
	 czu+g+4W8TM5g==
Subject: Re: [PATCH net v2] eth: fbnic: Keep real queue counts synchronized
From: netdev-bot+sashiko@kernel.org
To: bjorn@kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 mohsin.bashr@gmail.com, mike.marciniszyn@gmail.com, leitao@debian.org,
 horms@kernel.org, almasrymina@google.com, linux-kernel@vger.kernel.org,
 netdev-bot+sashiko@kernel.org
Date: Fri, 25 Sep 2026 19:18:38 +0000
Message-ID: <179036391870.2160803.457228716006507823@kernel.org>
In-Reply-To: <20260924191817.1843726-1-bjorn@kernel.org>
References: <20260924191817.1843726-1-bjorn@kernel.org>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds a hard `-ENOSPC` exit to `__fbnic_pm_resume()`
  (drivers/net/ethernet/meta/fbnic/fbnic_pci.c:523-529).

--

eth: fbnic: Keep real queue counts synchronized

The patch publishes the default channel counts, and the counts set while
the device is down, to the core with netif_set_real_num_queues() right
away. It adds num_napi_cfg so the configured NAPI count survives suspend.
Resume now fails with -ENOSPC if fewer vectors come back than that layout
needs.

Link: https://lore.kernel.org/netdev/178915061000.219967.7726187707862333281@kernel.org/

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> index c6698e3002a13..48279a5214c8a 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c

[ ... ]

> @@ -519,8 +520,16 @@ static int __fbnic_pm_resume(struct device *dev)
>  
>  	fbn = netdev_priv(netdev);
>  
> -	/* Reset the queues if needed */
> -	fbnic_reset_queues(fbn, fbn->num_tx_queues, fbn->num_rx_queues);
> +	max_napis = fbd->num_irqs - FBNIC_NON_NAPI_VECTORS;
> +	if (fbn->num_napi_cfg > max_napis) {
> +		netdev_err(netdev,
> +			   "Unable to restore channel configuration: %u NAPI vectors required, only %u available\n",
> +			   fbn->num_napi_cfg, max_napis);
> +		err = -ENOSPC;
> +		goto unlock;
> +	}

[Severity: High]
Can this leave the NIC unusable after a resume or an AER slot reset that
used to recover?

This patch does not change fbnic_alloc_irqs(). It still sizes the MSI-X
request from the CPUs online at resume time. It also accepts as few as
FBNIC_NON_NAPI_VECTORS + 1 vectors:

drivers/net/ethernet/meta/fbnic/fbnic_irq.c:fbnic_alloc_irqs() {
    ...
	wanted_irqs += min_t(unsigned int, num_online_cpus(), FBNIC_MAX_RXQS);
	num_irqs = pci_alloc_irq_vectors(pdev, FBNIC_NON_NAPI_VECTORS + 1,
					 wanted_irqs, PCI_IRQ_MSIX);
    ...
}

It never asks for num_napi_cfg vectors. Say CPUs are taken offline after
probe or after ethtool -L, for example the default 8 RSS queues with only
4 CPUs online. Wouldn't every resume then hit this check, even when the
hardware could supply enough vectors?

The check also runs before netif_running(). Is it intended that an
interface that is administratively down also fails resume, even though it
doesn't need any NAPI vectors yet?

On failure the code goes unlock -> err_free_mbx -> err_free_irqs ->
err_invalidate_uc_addr. That path disables the FW log and frees the
mailbox and all MSI-X vectors. It also clears uc_addr0 and uc_addr4.
fbnic_pm_resume() then skips __fbnic_pm_attach():

	err = __fbnic_pm_resume(dev);
	if (!err)
		__fbnic_pm_attach(dev);

The netdev stays detached, so netif_device_present() is false. Both
ethnl_ops_begin() and the ethtool ioctl path then return -ENODEV. Doesn't
that stop userspace from shrinking the channels to recover?

fbnic_err_slot_reset() calls the same function:

	err = __fbnic_pm_resume(&pdev->dev);

	return err ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;

So the new -ENOSPC turns a slot reset that used to recover into a
disconnect. Before this patch, fbnic_reset_queues() capped the rx and tx
counts at the available vectors, and both paths succeeded.

For sleep resume, the "later recovery" in the commit message seems to
mean another suspend. fbnic_pm_suspend() would then call ndo_stop() again,
on a netdev that is still marked running but has already been torn down:

	if (netif_running(netdev))
		netdev->netdev_ops->ndo_stop(netdev);

Combined layouts are rejected here too. fbnic_set_channels() already
accepts combined layouts with more rings than NAPIs, through
fbnic_set_queues() doing num_napi = min(..., max_napis). Could resume
spread those rings over fewer vectors instead of failing, so no queue is
dropped?

> +
> +	fbn->num_napi = fbn->num_napi_cfg;
>  
>  	if (netif_running(netdev)) {
>  		err = __fbnic_open(fbn);
> @@ -529,6 +538,7 @@ static int __fbnic_pm_resume(struct device *dev)
>  			fbn->num_napi = 0;
>  	}
>  
> +unlock:
>  	netdev_unlock(netdev);
>  	rtnl_unlock();
>  	if (err)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924191817.1843726-1-bjorn%40kernel.org
