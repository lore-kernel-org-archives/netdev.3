Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D98B3E6DE7;
	Mon,  7 Sep 2026 02:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749312; cv=none; b=I22YHQ3TIAEWXT7JfOtEZ/fmLIMnM9PFUNKneo/Ml0NGbIQRWZz6A2NWa4NtsOa/+g/mttELR+kbVG+WOlPM7242k943KMPp7HceavevOMBJvgptNzVTSG3eOvVeZQTW/scQxD4Y2pxKQDddmIZ6+M21k1wIp00xmawhObLXxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749312; c=relaxed/simple;
	bh=jtUYZYgr0w/BlqJyZ5s+BuDknnxMpCLGV3JWsHOqrB4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JrhHrP0DYaxmcgRhQ69/OGpGm+40KdaB7b87qqwY4pc+CG0yNpHKA1pRI+zcT8IXWKHmC0n9zF6tnlsZ6481rqXF8bZDX2B1xegnadW5OtsjFCX9rQYHGkWs3RkuwZXSa1VHF4HK83H4MwXUZJrCWdVQGWabQYjDm/W7Zj8HX3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC5CxgMW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC5CxgMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908A01F00A3E;
	Mon,  7 Sep 2026 02:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788749311;
	bh=wBPDGP64+3usE5t5lksKJG89iMY9MpvAMijAJB+ie3c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cC5CxgMW6pY/5sZ03AD8cjScvkZKG/vGqxC54QCeyZpGq1u55LYk2wlZwTMeMORBI
	 jGE9gpWDI0Bj3b9wQ9mxVNMcqc9lRQjgIOAk3UJPL9FmAuWmaum5uI4zGEc+ilIsv4
	 QyuyxLZ0SfQOeFfZweSGP2YgUwdliMiTKn5S7R+pPEkzlvriHU9Wg59moWz3XwIV5w
	 dpIWcihZFno4eCrL7x2JhWdws4yjBr1/DsMdXZdXCGfbfA6rUMGWOTwV0PfqlKs1qj
	 5HZAS9zNf1wMqwsVGRkAO4J3ZpNI/qT7NZuM5dUUzOF+AuS5MkZhH3sW861ypU/Kms
	 1qza1mBTfrvlQ==
Subject: Re: [PATCH net-next v3 02/10] net: ethernet: ravb: Move programming
 of gPTP timer interval
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Mon, 07 Sep 2026 02:48:30 +0000
Message-ID: <178874931017.219967.14949916137032056889@kernel.org>
In-Reply-To: <20260902084703.3228504-3-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-3-niklas.soderlund+renesas@ragnatech.se>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 0

- [Medium] In ravb_ptp_init() (drivers/net/ethernet/renesas/ravb_ptp.c),
  the newly moved gPTP timer-interval programming polls the wrong GCCR…
- [Medium] The commit is presented as relocating existing programming
  ("moving the programming to the gPTP initialization function"), but it…

--

net: ethernet: ravb: Move programming of gPTP timer interval

This moves the gPTP timer interval programming out of ravb_set_gti() in
ravb_main.c and into ravb_ptp_init(), where it is now done under
priv->lock, and takes priv->ptp.default_addend from priv->gti_tiv instead
of reading GTI back from the hardware.

A couple of questions below about the wait that follows the load request,
and about the callers of ravb_ptp_init() other than ravb_open().

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

> diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
> index 43218bc15b151..157fb78209c78 100644
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

[Severity: Medium]

Before this patch ravb_set_gti() was called only from ravb_open(), so GTI
was programmed once per open.  ravb_ptp_init() has two other callers that
run on a live interface:

  ravb_set_ringparam()
      if (netif_running(ndev)) {
          ...
          if (info->gptp)
              ravb_ptp_init(ndev, priv->pdev);

  ravb_tx_timeout_work()
  out:
      /* Initialise PTP Clock driver */
      if (info->gptp)
          ravb_ptp_init(ndev, priv->pdev);

Both of those paths previously only read the live GTI back into
priv->ptp.default_addend and left the hardware increment alone.  With the
write moved here they now reprogram GTI with the nominal priv->gti_tiv and
assert GCCR_LTI.

Does that mean an ethtool -G ring resize, or a TX watchdog recovery, now
discards whatever frequency correction ravb_ptp_adjfine() had programmed?

  ravb_ptp_adjfine()
      addend = (u32)adjust_by_scaled_ppm(priv->ptp.default_addend,
                                        scaled_ppm);

The commit message describes this as moving the programming, so this extra
effect on the ringparam and tx-timeout paths is not visible from the
changelog.  Could it be mentioned there if it is intentional?

> +
> +	/* Request GTI loading. */
> +	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
> +
> +	/* Wait for GIT loading to complete. */
>  	ravb_wait(ndev, GCCR, GCCR_TCR, GCCR_TCR_NOREQ);
> +
>  	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
>  	spin_unlock_irqrestore(&priv->lock, flags);

[Severity: Medium]

Does this ravb_wait() actually observe the GTI load?  The fields in
ravb.h look disjoint:

  GCCR_TCR         = 0x00000003,
  GCCR_TCR_NOREQ   = 0x00000000, /* No request */
  GCCR_TCR_RESET   = 0x00000001, /* gPTP/AVTP presentation timer reset */
  GCCR_TCR_CAPTURE = 0x00000003, /* Capture value set in GCCR.TCSS */
  GCCR_LTO         = 0x00000004,
  GCCR_LTI         = 0x00000008,

GCCR_TCR is the timer capture/reset request field, while the increment load
request just asserted is GCCR_LTI.  So the wait returns immediately as long
as no capture or reset request is outstanding, and the load itself is never
confirmed.

The driver's own handling of the same register elsewhere treats LTI as the
load-pending bit:

  ravb_ptp_adjfine()
      gccr = ravb_read(ndev, GCCR);
      if (gccr & GCCR_LTI) {
          spin_unlock_irqrestore(&priv->lock, flags);
          return -EBUSY;
      }
      ravb_write(ndev, addend & GTI_TIV, GTI);
      ravb_write(ndev, gccr | GCCR_LTI, GCCR);

Would ravb_wait(ndev, GCCR, GCCR_LTI, 0) be the condition intended here?
As written, the following read-modify-write

  ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);

can read GCCR with LTI still set and write it back, re-arming a second load
while one is in flight, and the new GTI write is issued without the
LTI-pending check that ravb_ptp_adjfine() makes.

Note that the register sequence itself matches the pre-patch code, where
ravb_set_gti() wrote GTI plus GCCR_LTI and ravb_ptp_init() then did the same
TCR wait and TCSS read-modify-write, so the re-assertion window and the
ignored ravb_wait() return value are not new here.  What is new is the
comment, and the changelog sentence that the move is based on:

    Having split the two apart this can be improved further by moving the
    programming to the gPTP initialization function, as the first action of
    the gPTP init function is to wait for the timer interval programming to
    be acknowledge by the hardware.

Since the wait polls GCCR_TCR and not GCCR_LTI, is that rationale accurate?

Also in the same comment, GIT looks like a typo for GTI, and "acknowledge"
in the changelog should be "acknowledged".

This is still the same code at the end of the series
(941e688417745c4877c88108bd047381e5c6e533 keeps the identical
ravb_wait(ndev, GCCR, GCCR_TCR, GCCR_TCR_NOREQ) under the same comment), and
priv->ptp.default_addend = priv->gti_tiv followed by the GTI write and LTI
request is unchanged there too.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902084703.3228504-1-niklas.soderlund%2Brenesas%40ragnatech.se
