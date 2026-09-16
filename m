Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B824A6CC1;
	Wed, 16 Sep 2026 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551685; cv=none; b=G+qrkhYS9/2nJtwNEtYW+my8dDBLS5EHpVae8HXF6V32WigYDQW0tzkoyHL6+gF451ql8tGWjdTNWBbhAr6xF7W5gP4jmdDVxf5sGBiGveaSJkKOAagjm8EB4tD9FkMlaFxMUwGvNVpDU5GBL4F7jyT5LTRvNAxPLtuyqVjxFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551685; c=relaxed/simple;
	bh=2w7ACpCdwYnaZ4I4xvZ8Tj2vBn8yUy8LWiytd80jL4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE+AVPGJqxdiv4R+DUJ6VZMTBEX0o9aRL1fiKMbPzal8ezX7yOPPfTIBoBx1AGie6bBIyM7VVMKPV1gJ4SuFO3XeZnVpX4JxUDGXteUq7eNnEGD5R/HQP9zPABJksnjVq3nwO4DBdUXfNehh1sUdmeyhd6Ag0AJkmPyWPhy8QdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=nF15ywYj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pUT91mXy; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="nF15ywYj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pUT91mXy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 108CCEC0F1A;
	Wed, 16 Sep 2026 05:41:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 16 Sep 2026 05:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789551671;
	 x=1789638071; bh=/JcGtibZVIg1ugk9+a0Nc9vldI5Xgow89hIjICGjpv8=; b=
	nF15ywYj4CgVHjur5OHjiEVAJoPtNJa2t6soqzWdaanxxNFWbA5423lJN/hVppFS
	RJ/cdLAcvxqBpTGYFXro4Mwwmi1xQfZcS29XUJRezfFtb+aN/3RccYb9rFQYNdpU
	liyG1lzx7EfWMnR6QHQU3JwnKIdwze3cg5PFgaMmqNz4wypNwfHqdt8U7W/7fPKy
	dBE10RiNY+uKp6GIALucR/rrs+ObTvneSaz7lZwscYi3oV+DJLf1QCiDH6NHjypL
	hbEdSmTVqrgAQ4cy3hd0/USsqg0TCyPXq6hM2q3HfdPyeV8e2kEmfpGoys6K19uL
	jBMGgW/floBWFzi9Z+8qDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789551671; x=
	1789638071; bh=/JcGtibZVIg1ugk9+a0Nc9vldI5Xgow89hIjICGjpv8=; b=p
	UT91mXyElM45QTltR2+FpY3xsw84t1AtK4OusyaoxDP+2NLvT7zsPT5nGNydUNsv
	HV/lkR0jznlnnkYtutlgGW7BUAcWzVM7cIsX6IIys7j+Ub475I3TFoAnsGhJhsZt
	d0SULYtw7f+CzR2V24qwBNPMIOl8//ns8d0qaopNS5NjlTzqOGXMZ9jNa/hxz7Ft
	DD83RDUkQ+RdGwL36erSD6l7pA6x5XKvUqkIRGVyv1/ORpgay5tAhSNal/co7Fwn
	Tgp15fh4FZkabxPURl9vdw3E9SYi9Kr/zCzjxSLHSvOYtoSE0GKpgWN1aMdj1U4j
	xICpKXf0K3v8oxZ97VpUA==
X-ME-Sender: <xms:NmSqasB4KvQszZ7P7N4BeOzJWSpkrgtvWSkc2XpxlGQV2pT-3Bb3DQ>
    <xme:NmSqanSFuoyH5FLXBVkAHYxdG_57Dygpedq7Y2LwKz3YCKSgczam6NxyNMaZ8CzIc
    E418aJu1eZ9tvaRvzfCPw6MBfstSaJUVyy7ZUOP6HWgI5JKGqxQ1g3q>
X-ME-Received: <xmr:NmSqauQp4GiSACApeN1WX9hUxYsq8ZG5tolcYFLux7P30i2PhZKVhvxuIRZPrz9bYa3b9THJWy5J8Y_A60vQ5gJwZ51sacw>
X-ME-Proxy-Cause: dmFkZTFTX9n2XjUy1Cb0bi/GlIJNxYAMuC6ZgsLrLkxSquQom2bE8MUcubdZ8srtzL6VhW
    G/2q229ryeqHm3m4gZg81kwnacc9IOaFOKsnjKU3Pm6gEd7562lEMPyb2R/XxlXM52p/l9
    x+qXVjF9XU4/XJXQtr/dLymMs68zz6psN6zmJWvyqpimOFfj0WdJ9iJcdOPcqWUsKjfdKO
    x0P4bDrMNRzl01oalYb/whs4lBytohXiitybcHwSZqr+m/YVME/96lqNIHulWW7c5Tq5L/
    brC9LbQGtJhvNEDjmMql9gyoENR88Vm7t2w1H/7rKOYIaQfZRxcZBZkRB+eh4lHiMe4kda
    SYir4nfjwj8sUQMYbibLI3u/+1mi6H0Ey+rieQkqsABeX2GbuTrOUssa4+j5FviSzGKbFQ
    Plf6GGWBh6VG3t5QRlEqdT/36o7HirsOmwVNhWuxmkYqVG6pHKfhlROrUS9WA0PmDTxr77
    n5dPwHPvZfn7cfRES0HGcItp/ZkOWT21SttgnL1bI5MApXvbskDtzo1PYekxu8g6MQWO2j
    YVKkv6sdGSTMF6lQNSS59vbOQGxb2UPlbq1EFSHaT2igKEPEyaipNiboHXO92fPI78ojqh
    3ULR8pw4qQv89+uFQ+SZI54Mf+2lWGjvZyAnAcq7lbvmjcHeQrW/8CpTUpUA
X-ME-Proxy: <xmx:NmSqalJFX8Vj8-VBMWCR9zHVEOcC6y_R_52GxLozGc3gUDYIj4HMwA>
    <xmx:NmSqalHvJkGB1VfufMkladGYIKzywIOy2NbXWdPGpN1BBnYhyhJFyA>
    <xmx:NmSqaiRiOZnJnIQ-Wbgzqk5kiZz60eGv2p4YysMiQSXFOEc1J1kJvA>
    <xmx:NmSqauUqcZKXxmZM7Y_vRGeyNMXT8KYzYDQVfF4vUyBBhrmDlcUzfg>
    <xmx:N2SqapoIsLOg-OqhiJ3ovLotMSQX9bWX7ZfIJnW5CIEZPyOlhtKpXT_8>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 05:41:09 -0400 (EDT)
Date: Wed, 16 Sep 2026 11:41:07 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Jakub Kicinski <kuba@kernel.org>
Cc: paul@pbarker.dev, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, sergei.shtylyov@gmail.com,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 03/10] net: ethernet: ravb: Simplify gPTP
 start and stop
Message-ID: <20260916094107.GP1991210@fsdn.se>
References: <20260909173027.2201560-4-niklas.soderlund+renesas@ragnatech.se>
 <20260915015437.881154-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915015437.881154-1-kuba@kernel.org>

Hello Jakub,

On 2026-09-14 18:54:37 -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: ethernet: ravb: Simplify gPTP start and stop
> 
> The patch folds the gptp-flag ravb_ptp_init() and ravb_ptp_stop() calls into
> ravb_dmac_init() and ravb_stop_dma(), and drops the info->gptp part of the
> two combined gptp/ccc_gac call sites in ravb_open() and ravb_close().  It is
> described as having no functional change.
> 
> A few questions about the resulting start/stop balance below.
> 
> > diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> > index a89f6fe7866fe..2d0022a4f85c3 100644
> > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > @@ -707,7 +707,15 @@ static int ravb_dmac_init(struct net_device *ndev)
> >  		return error;
> >  
> >  	/* Setting the control will start the AVB-DMAC process. */
> > -	return ravb_set_opmode(ndev, CCC_OPC_OPERATION);
> > +	error = ravb_set_opmode(ndev, CCC_OPC_OPERATION);
> > +	if (error)
> > +		return error;
> > +
> > +	/* Initialise PTP Clock driver */
> > +	if (info->gptp)
> > +		ravb_ptp_init(ndev, priv->pdev);
> > +
> > +	return 0;
> >  }
> >  
> >  static void ravb_get_tx_tstamp(struct net_device *ndev)
> > @@ -1115,6 +1123,10 @@ static int ravb_stop_dma(struct net_device *ndev)
> >  			netdev_err(ndev, "failed to stop AXI BUS\n");
> >  	}
> >  
> > +	/* Stop PTP Clock driver */
> > +	if (info->gptp)
> > +		ravb_ptp_stop(ndev);
> > +
> 
> [Severity: High]
> Is the new stop reachable on all exits from ravb_stop_dma()?  It sits after
> three unconditional error returns earlier in the same function:
> 
> 	error = ravb_wait(ndev, TCCR, info->tccr_mask, 0);
> 	if (error)
> 		return error;
> 
> 	error = ravb_wait(ndev, CSR, CSR_TPO0 | CSR_TPO1 | CSR_TPO2 | CSR_TPO3,
> 			  0);
> 	if (error)
> 		return error;
> 	...
> 	error = ravb_wait(ndev, CSR, CSR_RPO, 0);
> 	if (error)
> 		return error;
> 
> Before this patch, ravb_close(), ravb_set_ringparam(),
> ravb_tx_timeout_work() and ravb_open()'s unwind all called ravb_ptp_stop()
> unconditionally before ravb_stop_dma(), so a wait timeout did not affect the
> unregister.
> 
> ravb_close() treats a ravb_stop_dma() failure as non-fatal:
> 
> 	/* Set the config mode to stop the AVB-DMAC's processes */
> 	if (ravb_stop_dma(ndev) < 0)
> 		netdev_err(ndev,
> 			   "device will be stopped after h/w processes are done.\n");
> 
> and then goes on to free the rings, program CCC_OPC_RESET and drop the
> runtime-PM reference.  For .gptp devices (ravb_gen2_hw_info,
> ravb_rzv2m_hw_info) does that leave the PHC registered after ndo_stop has
> returned success, with the gPTP interrupt enables still set because
> ravb_ptp_disable()/ravb_ptp_sync_irqs() in ravb_ptp_stop() were skipped?
> 
> A subsequent open then runs ravb_dmac_init() -> ravb_ptp_init(), whose
> 
> 	WRITE_ONCE(priv->ptp.clock, clock);
> 
> overwrites the only handle, while ravb_ptp_stop() only xchg()s the current
> pointer.  Since ravb_remove() has no independent PTP unregister and ends in
> free_netdev(), does the stranded registration leave ptp_clock_info pointing
> into freed netdev private memory, reachable through the surviving
> /dev/ptpN?
> 
> ravb_ptp_stop() looks idempotent (xchg of priv->ptp.clock), so would doing
> the stop before the fallible ravb_wait() calls, or on all exit paths, keep
> the old behaviour?

If any of the stop steps before the gPTP fail the device is borked. I 
guess the LLM would say the same thing if any other of the calls in the 
stop chain where reordered too.

> 
> >  	/* Stop AVB-DMAC process */
> >  	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
> >  }
> > @@ -1719,9 +1731,7 @@ static int ravb_set_ringparam(struct net_device *ndev,
> >  
> >  	if (netif_running(ndev)) {
> >  		netif_device_detach(ndev);
> > -		/* Stop PTP Clock driver */
> > -		if (info->gptp)
> > -			ravb_ptp_stop(ndev);
> > +
> >  		/* Wait for DMA stopping */
> >  		error = ravb_stop_dma(ndev);
> >  		if (error) {
> 
> [Severity: High]
> Same question for this call site: with the explicit pre-stop removed, does a
> ravb_stop_dma() timeout here return with the interface detached and the Gen2
> gPTP clock still registered?

Same reply.

> 
> [ ... ]
> 
> > @@ -1961,7 +1967,7 @@ static int ravb_open(struct net_device *ndev)
> >  	ravb_emac_init(ndev);
> >  
> >  	/* Initialise PTP Clock driver */
> > -	if (info->gptp || info->ccc_gac)
> > +	if (info->ccc_gac)
> >  		ravb_ptp_init(ndev, priv->pdev);
> >  
> >  	/* PHY control start */
> > @@ -1974,9 +1980,6 @@ static int ravb_open(struct net_device *ndev)
> >  	return 0;
> >  
> >  out_ptp_stop:
> > -	/* Stop PTP Clock driver */
> > -	if (info->gptp || info->ccc_gac)
> > -		ravb_ptp_stop(ndev);
> >  	ravb_stop_dma(ndev);
> >  out_set_reset:
> >  	ravb_set_opmode(ndev, CCC_OPC_RESET);
> 
> [Severity: High]
> Does this leak the registered PTP clock for info->ccc_gac devices when
> ravb_open() fails?

This seems to be a real find, nice. Will fix.

> 
> ravb_open() still calls ravb_ptp_init() for info->ccc_gac, but the
> counterpart at out_ptp_stop: is gone, and the relocated teardown in
> ravb_stop_dma() is gated on:
> 
> 	if (info->gptp)
> 		ravb_ptp_stop(ndev);
> 
> info->gptp and info->ccc_gac are mutually exclusive (.gptp in
> ravb_gen2_hw_info and ravb_rzv2m_hw_info, .ccc_gac in ravb_gen3_hw_info and
> ravb_gen4_hw_info), so nothing unregisters the clock on this path.
> 
> The failure right after the init is a plain software path, ravb_phy_start()
> -> ravb_phy_init() returns -ENOENT when of_phy_connect() fails, or
> propagates an of_phy_register_fixed_link() error:
> 
> 	error = ravb_phy_init(ndev);
> 	if (error)
> 		return error;
> 
> Since ndo_open failed, ndo_stop/ravb_close() is never called, so the
> if (info->ccc_gac) ravb_ptp_stop(ndev); in ravb_close() does not run either.
> Does that leave /dev/ptpN live on a block that ravb_open() then puts into
> CCC_OPC_RESET and runtime-suspends, so gettime64/settime64/adjfine perform
> MMIO with no runtime-PM reference held, and with GIC/GIS enables still set?
> 
> And on a later successful open, ravb_ptp_init()'s
> WRITE_ONCE(priv->ptp.clock, clock) replaces the handle, so the first
> registration can no longer be reached by ravb_ptp_stop().  With
> ravb_remove() calling free_netdev() without any PHC unregister, does that
> become a use-after-free through the surviving PTP chardev?
> 
> Would keeping if (info->ccc_gac) ravb_ptp_stop(ndev); at out_ptp_stop:
> restore the balance?
> 
> > @@ -2020,10 +2023,6 @@ static void ravb_tx_timeout_work(struct work_struct *work)
> >  
> >  	netif_tx_stop_all_queues(ndev);
> >  
> > -	/* Stop PTP Clock driver */
> > -	if (info->gptp)
> > -		ravb_ptp_stop(ndev);
> > -
> >  	/* Wait for DMA stopping */
> >  	if (ravb_stop_dma(ndev)) {
> >  		/* If ravb_stop_dma() fails, the hardware is still operating
> > @@ -2056,10 +2055,6 @@ static void ravb_tx_timeout_work(struct work_struct *work)
> >  	ravb_emac_init(ndev);
> >  
> >  out:
> > -	/* Initialise PTP Clock driver */
> > -	if (info->gptp)
> > -		ravb_ptp_init(ndev, priv->pdev);
> > -
> >  	netif_tx_start_all_queues(ndev);
> >  
> >  out_unlock:
> 
> [Severity: Medium]
> Can TX-timeout recovery now resume traffic with the Gen2 gPTP clock left
> unregistered?
> 
> In ravb_stop_dma() the new stop runs just before the fallible final
> transition:
> 
> 	/* Stop PTP Clock driver */
> 	if (info->gptp)
> 		ravb_ptp_stop(ndev);
> 
> 	/* Stop AVB-DMAC process */
> 	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
> 
> If that ravb_set_opmode() times out, ravb_tx_timeout_work() takes the
> "hardware is still operating" branch:
> 
> 	if (ravb_stop_dma(ndev)) {
> 		...
> 		ravb_rcv_snd_enable(ndev);
> 		goto out;
> 	}
> 	...
> out:
> 	netif_tx_start_all_queues(ndev);
> 
> With the ravb_ptp_init() at out: removed, RX/TX and the TX queues are
> re-enabled for .gptp devices while the PHC has been unregistered and the
> gPTP interrupts cleared.  Previously this path always re-registered the
> clock when resuming operation.  Does hardware timestamping and /dev/ptpN
> now stay gone until a full close/open cycle?
> 
> [ ... ]

-- 
Kind Regards,
Niklas Söderlund
