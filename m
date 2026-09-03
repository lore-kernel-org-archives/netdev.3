Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A034EF04;
	Thu,  3 Sep 2026 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468138; cv=none; b=TeGF+IQiq+CB8UXkhQguWnQrpR8NLhHf3nxU54lnBcO0mL1S5mFAmBwgl3sQQK2INyEpjuuGUCHcDsHiD8Wq8LvDhqErOmhRnp12fcGo3Yvf3tbDN46m3lvUy6tBpaic2V1U0prsizYJtI/Ec9B29PDc+qEwwtpb/hgp7xjnWNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468138; c=relaxed/simple;
	bh=jxTBZ5NSNVdnx+165EAFfpkSa86FVvGvcaIBInptWoE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dH3ng8/KyWDJhZrcSeR1JL4X34rILpVLSRbBz8CtEQwE2chIgjpP4YvzCF/d6csgQ74m1RFXni0PyATlq664HvFXTfcHgHP3GBitPni4s+0kaKzb4kIqQ07+p64mYdFySaz2dqt5d8teBVYbIkWFG3zYzkW9UuZ5PeS1HdeaJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kukw3i8t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kukw3i8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086B21F000E9;
	Thu,  3 Sep 2026 20:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788468122;
	bh=WKuCNYJ6gHOia0sf2myY5NEiYJzEh/EAOi+D38dku+I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kukw3i8tkq8qAG1z/liQl306SOqqRCPUkzmJD3v85Ih0mmn0eX46jm2vb5ViZs+yh
	 l+b3/25kZq5ALazvgKKpZXIP9/qi9PHHU+OaSnkITrJVDk076sPl4tD7tyB6xTKIbz
	 UJPpddXUMuISH+mKbfj2sXAycodE3/KvMLryZhallLdFfj7EjKrbRn+h4yB8FSbMLS
	 IIuOriTLE2OoyIhmU4zgurn1hVb+A5XwNxbzEuoOCYB5/2SsmzfmihuRwKXlIeLGfX
	 gGYVQJw1PkpIDONIRfksG/AwV+ewQhbpY1zTszRVa6lZ6J69E4Y7CGWnKS/gqMo0c3
	 /VS4pTIpCOnBQ==
Subject: Re: [net-next,v12,1/7] r8169: add support for multi irqs
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 20:42:01 +0000
Message-ID: <178846812155.3394541.6579774818900952909@kernel.org>
In-Reply-To: <20260831053940.620-2-javen_xu@realsil.com.cn>
References: <20260831053940.620-2-javen_xu@realsil.com.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 3

- [High] rtl8169_netpoll()
  (drivers/net/ethernet/realtek/r8169_main.c:5127-5133) resolves the…
- [Medium] Switching rtl_open() from request_irq() with explicitly
  computed flags to rtl8169_request_irq()/pci_request_irq() silently…
- [Low] Each NAPI instance created by r8169_init_napi()
  (drivers/net/ethernet/realtek/r8169_main.c:5675-5679) now owns a…
- [Low] The new log line in rtl_init_one()
  (drivers/net/ethernet/realtek/r8169_main.c:5894-5896) formats…
- [Low] Commit-message framing concern: the message says the patch "adds
  support for multi irqs and napi", while rtl_alloc_irq() still calls…

--

r8169: add support for multi irqs

This converts the single napi_struct in struct rtl8169_private into a
dynamically allocated array, replaces request_irq()/free_irq() with
per-vector pci_request_irq()/pci_free_irq() helpers, and passes the NAPI
instance as the IRQ cookie so rtl8169_poll() and rtl_rx() work per queue.

A few questions below.

> r8169: add support for multi irqs
>
> RSS uses multi rx queues to receive packets, and each rx queue needs one
> irq and napi. So this patch adds support for multi irqs and napi here.

[Severity: Low]
This isn't a bug, but could the changelog say that this patch only adds the
infrastructure and does not yet allow more than one vector?

rtl_alloc_irq() still asks for exactly one vector:

	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);

and rtl_setup_rx_params() hardcodes:

	tp->num_rx_rings = 1;

so no configuration produced by this patch has more than one IRQ, NAPI or
RX queue.  The wording "adds support for multi irqs and napi here" reads as
if multiple vectors are already possible.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index ec4fc21fa21f..87eb10616a0c 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -745,10 +744,12 @@ struct rtl8169_private {
>  	dma_addr_t RxPhyAddr;
>  	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
>  	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
> +	struct napi_struct *rtl8169_napi;
> +	unsigned int num_rx_rings;
>  	u16 cp_cmd;
>  	u16 tx_lpi_timer;
>  	u32 irq_mask;
> -	int irq;
> +	unsigned int irq_nvecs;
>  	struct clk *clk;

[ ... ]

> +static int rtl8169_request_irq(struct rtl8169_private *tp)
> +{
> +	struct net_device *dev = tp->dev;
> +	struct napi_struct *napi;
> +	int i, rc;
> +
> +	for (i = 0; i < tp->irq_nvecs; i++) {
> +		napi = &tp->rtl8169_napi[i];
> +		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
> +				     NULL, napi, "%s-%d", dev->name, i);
> +		if (rc)
> +			goto free_irq;
> +	}
> +	return 0;

[ ... ]

> @@ -5107,8 +5162,7 @@ static int rtl_open(struct net_device *dev)
>  
>  	rtl_request_firmware(tp);
>  
> -	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_NO_THREAD : IRQF_SHARED;
> -	retval = request_irq(tp->irq, rtl8169_interrupt, irqflags, dev->name, tp);
> +	retval = rtl8169_request_irq(tp);
>  	if (retval < 0)
>  		goto err_release_fw_2;

[Severity: Medium]
Does this drop the IRQF_NO_THREAD that commit 870f531e178e ("r8169: set
IRQF_NO_THREAD if MSI(X) is enabled") added?

pci_request_irq() hardcodes the flags and has no way to express
IRQF_NO_THREAD:

drivers/pci/irq.c:pci_request_irq() {
	unsigned long irqflags = IRQF_SHARED;

	if (!handler)
		irqflags |= IRQF_ONESHOT;
	...
	ret = request_threaded_irq(pci_irq_vector(dev, nr), handler, thread_fn,
				   irqflags, devname, dev_id);
}

With handler != NULL the flags are exactly IRQF_SHARED, so on a kernel
booted with threadirqs, or with CONFIG_PREEMPT_RT, __setup_irq() reaches:

kernel/irq/manage.c:irq_setup_forced_threading() {
	if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
		return 0;
	...
	new->flags |= IRQF_ONESHOT;
	...
	new->thread_fn = new->handler;
	new->handler = irq_default_primary_handler;
}

so rtl8169_interrupt() becomes force-threaded and the vector is masked
until the thread runs, which is what 870f531e178e set out to avoid.

Two related observations on the same change: MSI and MSI-X vectors are now
requested as IRQF_SHARED even though they are not shareable, and the name
registered in /proc/interrupts changes from "<ifname>" to "<ifname>-<N>".
Should the changelog mention the name change?

> @@ -5074,7 +5127,10 @@ static void rtl8169_netpoll(struct net_device *dev)
>  {
>  	struct rtl8169_private *tp = netdev_priv(dev);
>  
> -	rtl8169_interrupt(tp->irq, tp);
> +	for (int i = 0; i < tp->irq_nvecs; i++) {
> +		rtl8169_interrupt(pci_irq_vector(tp->pci_dev, i),
> +				  &tp->rtl8169_napi[i]);
> +	}
>  }
>  #endif

[Severity: High]
Can pci_irq_vector() be called here?  rtl8169_netpoll() is the
ndo_poll_controller callback and runs with interrupts disabled:

net/core/netpoll.c:netpoll_send_skb()
    local_irq_save(flags);
    __netpoll_send_skb()
        netpoll_poll_dev()
            WARN_ONCE(!irqs_disabled(), ...)
            ops->ndo_poll_controller()   /* rtl8169_netpoll() */

With MSI or MSI-X enabled, which rtl_alloc_irq() requests for everything
newer than RTL8169, the lookup takes a mutex:

kernel/irq/msi.c:msi_domain_get_virq() {
	guard(msi_descs_lock)(dev);   /* mutex_lock(&dev->msi.data->mutex) */
	...
}

This is the reason commit 1bd32771884187 ("r8169: don't use
pci_irq_vector() in atomic context") introduced the cached tp->irq, which
this patch removes.  Since rtl8169_interrupt() never looks at its irq
argument, would caching the per-vector number, or simply passing 0, work
here?

[ ... ]

> @@ -5344,7 +5410,14 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  		break;
>  	}
>  
> -	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
> +	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
> +
> +	if (nvecs < 0)
> +		return nvecs;
> +
> +	tp->irq_nvecs = nvecs;
> +
> +	return 0;
>  }

[ ... ]

> +static void r8169_init_napi(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->irq_nvecs; i++)
> +		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
> +}

[Severity: Low]
Should these NAPIs be associated with their IRQ vector?  Each instance now
owns one vector, since rtl8169_request_irq() passes &tp->rtl8169_napi[i] as
dev_id for vector i, but plain netif_napi_add() ends in:

net/core/dev.c:netif_napi_add_weight_locked() {
	...
	netif_napi_set_irq_locked(napi, -1);
	...
}

and there is no netif_napi_set_irq() call anywhere in the driver, so
napi->irq stays -1 for the netdev-genl per-NAPI reporting, the NAPI
config/index machinery and the IRQ affinity notifier.  The sibling driver
does the pairing in rtase_init_napi()
(drivers/net/ethernet/realtek/rtase/rtase_main.c) with
netif_napi_add_config() plus netif_napi_set_irq().

[ ... ]

> -	netdev_info(dev, "%s, %pM, %sXID %x, IRQ %d\n",
> -		    chip->name, dev->dev_addr, ext_xid_str, xid, tp->irq);
> +	netdev_info(dev, "%s, %pM, %sXID %x, IRQ %d (%d total)\n",
> +		    chip->name, dev->dev_addr, ext_xid_str, xid,
> +		    pci_irq_vector(pdev, 0), tp->irq_nvecs);

[Severity: Low]
tp->irq_nvecs is declared as unsigned int in struct rtl8169_private, so
should the second conversion be %u rather than %d?

thanks

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831053940.620-1-javen_xu%40realsil.com.cn
