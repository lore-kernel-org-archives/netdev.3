Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC102D8385;
	Mon,  7 Sep 2026 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749315; cv=none; b=oxQBKazW5ZndMR83BCXuoCljjnoTriEDGcOOHwyW5vKooc23XItz1uq+ZvcKSkhlOzAU3WgF3NbX3nzY7kPEv9SUqS61X7NqvNggskiauRSqkJohmXdIU1264sE0NeeF20rj4iy0LRmpfLul2xesbn8e132nt0mK7RirxmODBvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749315; c=relaxed/simple;
	bh=xE7iCcQDu8jC76QvjFf1xVomy+/64KpowcBZsrtHvWo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kwz5m3AHiLNWcBcl5grrWzt+IXBGKC1z25uXmKm3msY5WoNu4Cho0tx/N9SqlwpsgL2AFBygzr7lAHSndWDtXVAL8pD5lEGgeBFZtj+kO/HziY4m2lSFg3G3+LI05ku4UYn4s4NPilne1Gxn8/lgVByjGJwsoMyDF71hZjunamk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl63M8EU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl63M8EU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BC31F00A3D;
	Mon,  7 Sep 2026 02:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788749310;
	bh=kaFoZ09Q/GQYhfFfEM0Mkm+WLW9Tg82Vt7wCS5hV4o0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nl63M8EUfJRkwWIaW+27Jkb546ewCqVT2Aru1X7jxZhV7JE2gdnzmy4OipbZ8ROmR
	 kcQECEhumbDgpUoygYJPRZTdnfmX/rKVmV1rPbhWdR+Yc85Nn/SYq81X8nXFZwegsE
	 6vbyzy2ni9N9+1IoYZE3M8/Ahby8BiMOebl+BQ8G1xqDKIgLFNo481+MMDZODS1Nba
	 y9bn5y984nCXOjnvefp5ijFGUfw3uJRS7LUfRC0EZDlbCVcUyD42AKfyGyTXco635u
	 afCs4JDFjM7mcQnoIPmXRXewH4ZYw/SXj/0sjIz2NvgtisM4ktZyuZyjtocSz3Mu+7
	 dF6jbdPskFajw==
Subject: Re: [PATCH net-next v3 01/10] net: ethernet: ravb: Remove gPTP
 control from WoL setup and restore
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Mon, 07 Sep 2026 02:48:28 +0000
Message-ID: <178874930868.219967.4558251177406504137@kernel.org>
In-Reply-To: <20260902084703.3228504-2-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-2-niklas.soderlund+renesas@ragnatech.se>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] The commit message's stated justification for the removal is
  factually wrong for the suspend leg, and the removal deletes the only…

--

net: ethernet: ravb: Remove gPTP control from WoL setup and restore

This drops the ccc_gac special case that called ravb_ptp_stop() from
ravb_wol_setup() and ravb_ptp_init() from ravb_wol_restore(), on the
grounds that ndo_open/ndo_close already start and stop the gPTP clock.

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index ea1c7e536791e..36173a09e2fdb 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -3182,9 +3182,6 @@ static int ravb_wol_setup(struct net_device *ndev)
>  	/* Enable MagicPacket */
>  	ravb_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
>  
> -	if (priv->info->ccc_gac)
> -		ravb_ptp_stop(ndev);
> -
>  	return enable_irq_wake(priv->emac_irq);
>  }

[Severity: High]

Is the ndev really closed on the suspend leg when WoL is enabled?
ravb_suspend() returns immediately after ravb_wol_setup() without ever
calling ravb_close():

drivers/net/ethernet/renesas/ravb_main.c:ravb_suspend() {
	rtnl_lock();
	if (priv->wol_enabled) {
		ret = ravb_wol_setup(ndev);
		rtnl_unlock();
		return ret;
	}

	ret = ravb_close(ndev);
	...
}

The only ravb_close() in the WoL flow is at the end of ravb_wol_restore(),
i.e. on the resume leg. So the commit message statement:

  "As the ndev will always be closed and re-opened when suspending and
  resuming the system."

does not appear to hold for the suspend direction. Should the message be
adjusted, or is the intent to change behaviour here?

With ravb_ptp_stop() gone from ravb_wol_setup(), doesn't the WoL suspend
path lose the gPTP masking and IRQ draining that ravb_ptp_stop() performed?

drivers/net/ethernet/renesas/ravb_ptp.c:ravb_ptp_stop() {
	ravb_ptp_disable(ndev);		/* GIC = 0, GIS = 0 */
	ravb_ptp_sync_irqs(ndev);	/* synchronize_irq(ndev->irq), err_irq, mgmt_irq */
	...
}

After this patch ravb_wol_setup() only clears RIC0/RIC2/TIC, narrows
ECSIPR, and synchronizes priv->emac_irq, so gPTP interrupt sources armed by
userspace (extts PTCE, perout PTME) stay enabled and the AVB-DMAC / err /
mgmt IRQ lines are never drained. Do the retained comments in
ravb_wol_setup() still describe the code?

	/* Disable interrupts by clearing the interrupt masks. */
	...
	/* Only allow ECI interrupts */
	synchronize_irq(priv->emac_irq);

Can a gPTP interrupt latched during the sleep then be replayed against a
block that ravb_wol_restore() is resetting? resume_device_irqs() runs in
the noirq phase, before the .resume callback, so:

ravb_interrupt()/ravb_multi_interrupt()
	if (iss & ISS_CGIS)
		ravb_ptp_interrupt(ndev);

drivers/net/ethernet/renesas/ravb_ptp.c:ravb_ptp_interrupt() {
	gis &= ravb_read(ndev, GIC);
	...
	if (gis & GIS_PTMF) {
		...
		ravb_ptp_update_compare(priv, perout->target);
	}
	ravb_write(ndev, ~(gis | GIS_RESERVED), GIS);
}

can run while ravb_wol_restore() is driving the block through
CCC_OPC_RESET and config mode:

drivers/net/ethernet/renesas/ravb_main.c:ravb_wol_restore() {
	/* Set reset mode to rearm the WoL logic. */
	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
	...
	error = ravb_set_config_mode(ndev);
	...
}

Neither ravb_set_opmode() nor ravb_set_config_mode() takes priv->lock, so
is there anything serializing that window? Related, does the PHC stay
registered across a sleep in which the block is subsequently reset?

This also looks like it reverses commit b07bc55cbb1c ("net: ravb: Simplify
ravb_suspend()"), which moved ravb_ptp_stop() into ravb_wol_setup()
specifically because the WoL branch bypasses ravb_close(). Checking the end
of this series (up to "net: ethernet: ravb: Add gPTP support for Gen4"),
ravb_wol_setup() still has no gPTP stop, so no later patch restores it.

Would it work to keep the gPTP masking and IRQ draining in
ravb_wol_setup()? Dropping the ravb_ptp_init() from ravb_wol_restore()
below looks fine on its own, since ravb_close() there already stops gPTP.

> @@ -3204,9 +3201,6 @@ static int ravb_wol_restore(struct net_device *ndev)
>  	if (error)
>  		return error;
>  
> -	if (priv->info->ccc_gac)
> -		ravb_ptp_init(ndev, priv->pdev);
> -
>  	if (info->nc_queues)
>  		napi_enable(&priv->napi[RAVB_NC]);
>  	napi_enable(&priv->napi[RAVB_BE]);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902084703.3228504-1-niklas.soderlund%2Brenesas%40ragnatech.se
