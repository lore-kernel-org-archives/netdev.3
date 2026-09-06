Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554CF1FD4;
	Sun,  6 Sep 2026 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700663; cv=none; b=UqkcvcJxqj8aaobXhVgKVnokl0G7eoPDAmh6puFKMULdURnL31zQZEE3MB2yILp/IGnbjO4QO0vGrzvNQXt5/djn/x3ezBPSh2ws+b2PUKZbudtilhEwkw3LQIRHMl0igHalb+dSrlu0KC3kWD2dV+eCf4UtX5O+zzFX4NDrDsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700663; c=relaxed/simple;
	bh=D+riJ0Sul8S6D6FpkS7ASrdGZkLZpDnzr86lSs63L3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+PrOckAGYT3LNThh1WD2dJ3BUcMKZj9ADO9Nc7VqKsiQfn+cukYGTEFCtgcgRRsxl7XJWYi0VoTMTDxrvxk3FcFTNPCBWP7myRWGou26klhq5UNWCDsWuwOnFnNF2pY5WPqnxwGvxFOL59o1g3MyR0XdB91BUOHfm3q5Il+slY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYGnlquv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYGnlquv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568F91F00A3A;
	Sun,  6 Sep 2026 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788700661;
	bh=WCE/9VZM99B8W32LfhgpdIXVvOZKjQFo9AGkwQcHIa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lYGnlquv6nQ08OFYgWH62Gul+FzC0S4nEKoXH3HYYrdIE6pd7tM+lCPwXO7aldLAN
	 Q4COUhQ62ye5l2wAPwxlmrYseQGW0pgj9/UYLoXbUVyXfmaKeMEbygwyEOMIFS5YTH
	 Z/b16mYpf+Irm/QqiCWkqbZ3bmbNc1pGVQnoH4D9/pocPMhbVh85VkWk8S9kXu2Mt0
	 Qo6GthoFrapafQq/aHn7shtUGOOtaJl01+KRhfdtu2P7EzARYGQza4SN6SNQuXyKK3
	 d5snKW14kE+FFBNbO7s3hTmC7/VdtCTdYZOfMF1YQIR8pburFUeDI2Tml4kaETUdTD
	 8GrmVhheX0ISg==
From: Simon Horman <horms@kernel.org>
To: phucduc.bui@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	wei.fang@nxp.com,
	frank.li@nxp.com,
	shenwei.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	swboyd@chromium.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v3] net: fec: Propagate PTP initialization errors
Date: Sun,  6 Sep 2026 14:17:11 +0100
Message-ID: <20260906131711.247708-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904105542.70540-1-phucduc.bui@gmail.com>
References: <20260904105542.70540-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260904105542.70540-1-phucduc.bui@gmail.com?part=1
---
net: fec: Propagate PTP initialization errors

Change fec_ptp_init() to return an error code instead of silently
ignoring failures during PTP initialization.

Link: https://lore.kernel.org/all/20260903092430.354186-1-phucduc.bui@gmail.com/

> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 794ec427b0ee6..a9a458703547d 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
[ ... ]
> @@ -5394,7 +5397,9 @@ fec_probe(struct platform_device *pdev)
>  	for (i = 0; i < irq_cnt; i++) {
>  		snprintf(irq_name, sizeof(irq_name), "int%d", i);
>  		irq = platform_get_irq_byname_optional(pdev, irq_name);
> -		if (irq < 0)
> +		if (irq < 0 && irq != -ENXIO)
> +			return irq;

[Severity: High]
Does this direct return bypass the error handling cleanup at the end of
fec_probe()?

By returning directly instead of jumping to the failed_irq label, the driver
bypasses fec_ptp_stop(). This leaves the fep->time_keep delayed work
(scheduled earlier in fec_ptp_init()) active.

It also bypasses free_netdev(ndev), which leaks the net_device structure.

When the driver core cleans up devres allocations on probe failure, it unmaps
fep->hwp. If the un-canceled delayed work subsequently fires, will it attempt
to access the unmapped memory at fep->hwp and cause a kernel panic?

[ ... ]
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> index 56801c2009d59..557a76797ebaa 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
[ ... ]
> @@ -779,26 +779,32 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
>  		      HRTIMER_MODE_REL);
>  
>  	irq = platform_get_irq_byname_optional(pdev, "pps");
[ ... ]
> +	if (irq > 0) {
>  		ret = devm_request_irq(&pdev->dev, irq, fec_pps_interrupt,
>  				       0, pdev->name, ndev);
>  		if (ret < 0)
> -			dev_warn(&pdev->dev, "request for pps irq failed(%d)\n",
> -				 ret);
> +			return ret;
>  	}
>  
>  	fep->ptp_clock = ptp_clock_register(&fep->ptp_caps, &pdev->dev);
>  	if (IS_ERR(fep->ptp_clock)) {
> +		ret = PTR_ERR(fep->ptp_clock);
>  		fep->ptp_clock = NULL;
>  		dev_err(&pdev->dev, "ptp_clock_register failed\n");
> +		return ret;

[Severity: High]
Does this error return leave the devm-managed IRQ active while propagating an
error back to the probe function?

If ptp_clock_register() fails, fec_ptp_init() returns an error which
propagates to fec_probe(), causing it to jump to failed_reset.

The error path in fec_probe() manually frees ndev via free_netdev(ndev).

However, the PPS interrupt was registered just prior using devm_request_irq(),
so it remains active until fec_probe() returns and devres tears it down.

If the PPS interrupt fires between the manual free of ndev and the devres
cleanup, will fec_pps_interrupt() cast dev_id to ndev and attempt to
dereference the already-freed ndev structure, causing a use-after-free crash?
