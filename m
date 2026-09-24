Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA430479880;
	Thu, 24 Sep 2026 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250684; cv=none; b=jiBESqQB5NZ17Y2HNwvmMkPTe9eTBm/ZjIon5tWGq3yVBMakV+VCRB0SSe/R29ma7OjN8mTZHndgbaxr/HInwS2oJCc4VykD0D6chFAI8S/o+2ssVqGE0SlW7Az/3m3r7krdI2UQBb1LpUxLw+QPNevd0hM464irQkI5LUwZ8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250684; c=relaxed/simple;
	bh=Ki5m0oY3Wb2CGmBbMCPIwiJ5Y2QnRexdRHtHzRxmVOs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lSTkVRKpf1y+TF5odjDUArr1xUgrndBXj3rDxqkfV+C+KeZCmTph+oVVkf1X/uO8KuSqXbNDaEXq4hi/f/cdi4nYN3a0CkeYiMQrkv9UHVkZVUV7ezIRNCeD734uew+SFItqwfJQtZHeMRhnxgTXGGAY3x7vWgfXkwD3Tm0bYFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YT92UbTd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YT92UbTd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9931F00893;
	Thu, 24 Sep 2026 11:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790250682;
	bh=LngratqWAkxiwidl5JIHFDZRI22VyPOpymKHEEma3CA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YT92UbTdGjcgd2tChHqarEUVDXhJXqpv4uWynE9NamEwIL5EDlIaZPHrxfEGa/irJ
	 Ps3UmehaBd/KasbvFpRZSwl8XrCiuTNqVh2jEwB8hJ/xKdl7yo3AM9DxdP9Dd+lFFT
	 Cb9s8ojzH/9o5PQgi3OvNIo680Gzf6orMLwsQAZGlSA9/ZTcM5RaaS5kg1exItbFNq
	 IRIqEwGsmmCF2ouSvY68HuKhiQGuGuud7wPShPAvuhqT/5oI5ugj50juSv/fqayGQ/
	 8rf+ctgWPLdQj+JsC23cf5uDPEunUG8V6y+QsgU+Xv+29YfR0XMeMceaDxvZL8RI8V
	 AUiz7qTW0yhgg==
Subject: Re: [PATCH net-next v5 02/10] net: ethernet: ravb: Move programming
 of gPTP timer interval
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: paul@pbarker.dev, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Thu, 24 Sep 2026 11:51:20 +0000
Message-ID: <179025068097.2160803.10939525979746579631@kernel.org>
In-Reply-To: <20260921175037.4084310-3-niklas.soderlund+renesas@ragnatech.se>
References: <20260921175037.4084310-3-niklas.soderlund+renesas@ragnatech.se>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In ravb_ptp_init() (drivers/net/ethernet/renesas/ravb_ptp.c),
  the patch writes priv->gti_tiv to GTI, requests a timer-increment load…
- [Medium] The commit message presents the change as moving the GTI
  programming out of ravb_open() into ravb_ptp_init() (plus a locking…

Pre-existing issues:
- [Medium] ravb_ptp_init() discards the return value of ravb_wait(ndev,
  GCCR, GCCR_TCR, GCCR_TCR_NOREQ) and unconditionally continues: it…

--

net: ethernet: ravb: Move programming of gPTP timer interval

This removes ravb_set_gti() from ravb_main.c and moves the GTI write plus
the GCCR.LTI load request into ravb_ptp_init(), where it is now done under
priv->lock.  ravb_ptp_init() also stops seeding priv->ptp.default_addend
from the GTI register and uses the cached priv->gti_tiv instead.

A few questions below.

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 36173a09e2fdb..a89f6fe7866fe 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1846,20 +1846,6 @@ static int ravb_set_config_mode(struct net_device *ndev)
>  	return error;
>  }
>  
> -static void ravb_set_gti(struct net_device *ndev)
> -{
> -	struct ravb_private *priv = netdev_priv(ndev);
> -	const struct ravb_hw_info *info = priv->info;
> -
> -	if (!(info->gptp || info->ccc_gac))
> -		return;
> -
> -	ravb_write(ndev, priv->gti_tiv, GTI);
> -
> -	/* Request GTI loading */
> -	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
> -}
> -

[ ... ]

> @@ -1974,8 +1960,6 @@ static int ravb_open(struct net_device *ndev)
>  
>  	ravb_emac_init(ndev);
>  
> -	ravb_set_gti(ndev);
> -
>  	/* Initialise PTP Clock driver */
>  	if (info->gptp || info->ccc_gac)
>  		ravb_ptp_init(ndev, priv->pdev);

[Severity: Medium]
The commit message describes this as moving the programming out of the RAVB
main logic into the gPTP init function, but ravb_open() is not the only
caller of ravb_ptp_init().  ravb_set_ringparam() and ravb_tx_timeout_work()
also call it, and neither of those ever called ravb_set_gti() before, nor do
they reset the device (ravb_set_ringparam() only stops DMA, and
ravb_tx_timeout_work() can reach its "out:" label even after ravb_stop_dma()
failed):

drivers/net/ethernet/renesas/ravb_main.c:ravb_set_ringparam() {
	...
	/* Initialise PTP Clock driver */
	if (info->gptp)
		ravb_ptp_init(ndev, priv->pdev);

	netif_device_attach(ndev);
	...
}

On those paths GTI still holds whatever ravb_ptp_adjfine() last programmed:

drivers/net/ethernet/renesas/ravb_ptp.c:ravb_ptp_adjfine() {
	addend = (u32)adjust_by_scaled_ppm(priv->ptp.default_addend, scaled_ppm);
	...
	ravb_write(ndev, addend & GTI_TIV, GTI);
}

So does an "ethtool -G" ring reconfiguration, or a TX watchdog timeout, now
silently reset the PHC frequency back to nominal and discard the frequency
adjustment userspace applied?

The new behaviour may well be the more correct one, since the old code
re-seeded default_addend from an already adjusted register value and later
adjfine() scaling then compounded off a drifted base.  If that is the intent,
could the commit message mention the behaviour change, and should this carry
a Fixes tag?

> diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
> index 43218bc15b151..ac91a6813368d 100644
> --- a/drivers/net/ethernet/renesas/ravb_ptp.c
> +++ b/drivers/net/ethernet/renesas/ravb_ptp.c
> @@ -321,11 +321,20 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
>  
>  	priv->ptp.info = ravb_ptp_info;
>  
> -	priv->ptp.default_addend = ravb_read(ndev, GTI);
> +	priv->ptp.default_addend = priv->gti_tiv;
>  	priv->ptp.current_addend = priv->ptp.default_addend;
>  
>  	spin_lock_irqsave(&priv->lock, flags);
> +
> +	/* Set gPTP Timer Increment Value. */
> +	ravb_write(ndev, priv->ptp.default_addend, GTI);
> +
> +	/* Request GTI loading. */
> +	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
> +
> +	/* Wait for GIT loading to complete by checking there are no requests. */
>  	ravb_wait(ndev, GCCR, GCCR_TCR, GCCR_TCR_NOREQ);
> +
>  	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
>  	spin_unlock_irqrestore(&priv->lock, flags);

[Severity: Medium]
Does this ravb_wait() actually observe the load request that was just
issued?  The request is GCCR.LTI, but the poll masks GCCR.TCR, and the two
are disjoint fields in ravb.h:

	GCCR_TCR	= 0x00000003,
	GCCR_TCR_NOREQ	= 0x00000000, /* No request */
	GCCR_TCR_RESET	= 0x00000001, /* gPTP/AVTP presentation timer reset */
	GCCR_TCR_CAPTURE = 0x00000003, /* Capture value set in GCCR.TCSS */
	GCCR_LTO	= 0x00000004,
	GCCR_LTI	= 0x00000008,

and ravb_wait() only tests the mask it is handed:

drivers/net/ethernet/renesas/ravb_main.c:ravb_wait() {
	for (i = 0; i < 10000; i++) {
		if ((ravb_read(ndev, reg) & mask) == value)
			return 0;
		udelay(10);
	}
	return -ETIMEDOUT;
}

TCR is already NOREQ here, so the poll returns on its first read.  The
driver's own convention elsewhere in this file treats LTI as the pending
increment load indicator:

drivers/net/ethernet/renesas/ravb_ptp.c:ravb_ptp_adjfine() {
	gccr = ravb_read(ndev, GCCR);
	if (gccr & GCCR_LTI) {
		spin_unlock_irqrestore(&priv->lock, flags);
		return -EBUSY;
	}
	ravb_write(ndev, addend & GTI_TIV, GTI);
	ravb_write(ndev, gccr | GCCR_LTI, GCCR);
}

Given that, can the following read-modify-write read GCCR with LTI still
asserted and write that bit back, re-issuing an increment load that was not
intended?

	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);

And can TCSS end up switched to ADJGPTP before the increment value is known
to be latched, with a subsequent ravb_ptp_adjfine() then returning -EBUSY
because it does check GCCR_LTI?

Should the wait poll GCCR.LTI until the hardware clears it instead, and
should the new GTI write mask the value with GTI_TIV the way
ravb_ptp_adjfine() does?

Two related notes on the wording.  The new comment says "Wait for GIT
loading" - GIT should be GTI.  The commit message states:

    "as the first action of the gPTP init function is to wait for the timer
    interval programming to be acknowledge by the hardware"

With the poll looking at TCR rather than LTI, is that acknowledgement
actually happening?  There is also a typo, "acknowledge" should be
"acknowledged".

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but the return
value of ravb_wait() here is discarded, and ravb_ptp_init() returns void, so
GCCR.TCSS is programmed and ptp_clock_register() runs even when the poll
returned -ETIMEDOUT.  ravb_open() then calls
netif_tx_start_all_queues() and returns success with no indication that the
gPTP register sequence did not complete, and ravb_set_ringparam() and
ravb_tx_timeout_work() get no status either.

What makes this worth mentioning here is that the patch moves the GTI write
and the LTI load request into this same unchecked sequence, and newly exposes
that sequence to the ring-parameter and TX-timeout recovery paths.  Would it
make sense to check the ravb_wait() result while the code is being reworked?

For reference, the unchecked ravb_wait() is still unchecked at the end of the
series (02206b03b69a), even after the later patch "net: ethernet: ravb:
Propagate error from ptp_clock_register()" changes ravb_ptp_init() to return
int.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921175037.4084310-1-niklas.soderlund%2Brenesas%40ragnatech.se
