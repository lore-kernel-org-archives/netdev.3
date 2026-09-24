Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15DF47CA6E;
	Thu, 24 Sep 2026 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250682; cv=none; b=m+Y2RWr2qQHRlR2U6KcAXeI77gr1r3k/zBEX6H6tehxU9hChxqB46I37i7B50OHeAoY8cvAoq/66kGKevdOzjzOVLL6kZNgxOvq1lJ3xXJxBhRz7dJsiJfmKinA2uug6owlhA/03ItnbVX7zWX+IhXwNAmDTYV6y+njcm5MiyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250682; c=relaxed/simple;
	bh=rynHnzdO6HXrw99tOohZay+aEXWobPMKvTMBLAOwKuQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oQ0S8AqGsUm2pCMKBC+8FFmhGRGqCULXn6vHcTZjJFpyaLcWn1jtLooEodSnaA0TEpFAsi0f8Su9AUkDh+0ns69Qjib46CCtgEgla67W0lvPuWekDS3wuITSqAjLpmcFcdylHoDJ7mIdExxVC+hq0sgDYCw9aQEZ+2uAMraM7q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gL4hk6us; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gL4hk6us"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF21D1F000FF;
	Thu, 24 Sep 2026 11:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790250680;
	bh=Bca2QKu5nnLO68ZojSJtY64U3CoZgo+Ru+lWrvLI9qk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gL4hk6usOgmrhXSqAB4xGYsJYg5CO5U/Qi+10n1BRQDWZViVWlfoAw3vXPWCHdVM2
	 9speRTY4du+V9hsF9AYvFfb8pcELVZS14R/8r3hR+2fgXATW4kWC1Pu/3UDrqEjf8s
	 ZWNCK0HegKsajH6fNOsZNfqAqHUuXVe9RMo6zq1j6HPzB4WbwGHVoND7X3QcglVewM
	 K+AS1FHP325oy4jGt0Xx/hxdg9LtJlhmt64Au0LnePl1tdCrM3H3bYIKtj+Xp8h3uw
	 Fw7jtg++oJzhFKhNaeDJyr1SWEYloiIK4roWF84iRrehL5JGKRWp5afGz+p/5fsJDm
	 jEbLOoMMqvoxQ==
Subject: Re: [PATCH net-next v5 01/10] net: ethernet: ravb: Remove gPTP
 control from WoL setup and restore
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: paul@pbarker.dev, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Thu, 24 Sep 2026 11:51:19 +0000
Message-ID: <179025067927.2160803.2648038917450504349@kernel.org>
In-Reply-To: <20260921175037.4084310-2-niklas.soderlund+renesas@ragnatech.se>
References: <20260921175037.4084310-2-niklas.soderlund+renesas@ragnatech.se>
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

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message claims both removed calls are a "redundant"
  special case because "the ndev will always be closed and re-opened…
- [Medium] Removing `ravb_ptp_stop()` from ravb_wol_setup() also removes
  the gPTP interrupt quiescing that the WoL suspend path relied on:…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is High
  severity and lives in the function the patch edits.

--

net: ethernet: ravb: Remove gPTP control from WoL setup and restore

The patch removes the ravb_ptp_stop() call from ravb_wol_setup() and the
ravb_ptp_init() call from ravb_wol_restore(), on the grounds that gPTP is
already started and stopped by ndo_open/ndo_stop for ccc_gac platforms.
Two questions about the suspend side of that reasoning, plus one
pre-existing issue in the function being edited.

No Link: tags present in the commit header.

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

[Severity: Medium]
The commit message says:

    "This makes the special case to stop and start it when resuming from
    WoL redundant. As the ndev will always be closed and re-opened when
    resuming the system."

Is that accurate for the suspend side?  ravb_suspend() takes the WoL
branch and returns before ravb_close() is ever reached:

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

So the deleted "if (priv->info->ccc_gac) ravb_ptp_stop(ndev);" appears to
have been the only gPTP teardown performed before the system slept.  With
it gone, does the gPTP block stay armed and the PHC (/dev/ptpN) stay
registered for the whole WoL suspend window, with teardown happening only
later during resume, when ravb_wol_restore() reaches ravb_close() ->
ravb_ptp_stop()?

There is a second consequence in the resume error paths.
ravb_wol_restore() can return before ravb_close():

drivers/net/ethernet/renesas/ravb_main.c:ravb_wol_restore() {
	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
	if (error)
		return error;

	/* Set AVB config mode. */
	error = ravb_set_config_mode(ndev);
	if (error)
		return error;
	...
}

Since the clock is now still registered at that point, does a failed WoL
resume leave the PHC exposed to userspace while the gPTP block has just
been driven into reset with CCC_GAC/CSEL cleared?  Previously that state
could not occur because the clock had already been unregistered in
ravb_wol_setup().

ravb_resume() propagates the error and returns without calling
ravb_open(), so there is no gPTP rollback; the PM core logs the failed
resume callback and thaws userspace.  PHC ioctls such as
ravb_ptp_gettime64/settime64/adjtime can then run against the reset block
and each can burn the full ravb_wait() budget:

drivers/net/ethernet/renesas/ravb_main.c:ravb_wait() {
	for (i = 0; i < 10000; i++) {
		if ((ravb_read(ndev, reg) & mask) == value)
			return 0;
		udelay(10);
	}
	return -ETIMEDOUT;
}

that is up to 100 ms inside spin_lock_irqsave(&priv->lock).

Would it make sense either to keep the suspend-side stop, or to state in
the commit message that gPTP is deliberately left running across a WoL
suspend?

[Severity: Medium]
Removing ravb_ptp_stop() here also removes the gPTP interrupt quiescing
that this function relied on.  ravb_ptp_stop() was the only caller of:

drivers/net/ethernet/renesas/ravb_ptp.c:
static void ravb_ptp_disable(struct net_device *ndev)
{
	ravb_write(ndev, 0, GIC);
	ravb_write(ndev, 0, GIS);
}

static void ravb_ptp_sync_irqs(struct net_device *ndev)
{
	synchronize_irq(ndev->irq);
	if (priv->info->err_mgmt_irqs) {
		synchronize_irq(priv->err_irq);
		synchronize_irq(priv->mgmt_irq);
	}
}

The rest of ravb_wol_setup() still quiesces every other source under the
"Only allow ECI interrupts" comment (RIC0/RIC2/TIC cleared,
synchronize_irq(priv->emac_irq), napi_disable(), ECSIPR = ECSIPR_MPDIP),
but only emac_irq is now synchronized.

If userspace armed EXTTS or PEROUT through the PHC before suspending,
ravb_ptp_extts()/ravb_ptp_perout() leave the gPTP source enabled:

drivers/net/ethernet/renesas/ravb_ptp.c:ravb_ptp_perout() {
			/* Unmask interrupt */
			if (!info->irq_en_dis)
				ravb_modify(ndev, GIC, GIC_PTME, GIC_PTME);
			else
				ravb_write(ndev, GIE_PTMS0, GIE);
}

Does that source now stay enabled across the whole WoL suspend and early
resume interval, unflushed on the DMAC/err/mgmt lines?  A gPTP condition
latched while the IRQ core had the line suspended would be replayed in
the noirq resume phase, and further events can fire while
ravb_wol_restore() drives the block through ravb_set_opmode(ndev,
CCC_OPC_RESET) and ravb_set_config_mode() (register writes made without
priv->lock), before ravb_close() finally does the gPTP stop.

ravb_multi_interrupt() then dispatches into the PTP code in that window:

drivers/net/ethernet/renesas/ravb_main.c:ravb_multi_interrupt() {
	spin_lock(&priv->lock);
	iss = ravb_read(ndev, ISS);
	...
	/* gPTP interrupt status summary */
	if (iss & ISS_CGIS) {
		ravb_ptp_interrupt(ndev);
		result = IRQ_HANDLED;
	}
}

Can this deliver a PTP_CLOCK_EXTTS event with a timestamp read from a
gPTP block that has just been reset, or reprogram GPTC/GCCR on a block in
reset/config mode?

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

[Severity: High]
This isn't a bug introduced by this patch, but since the patch touches
the code right above these napi_enable() calls it seems worth raising.

If either ravb_set_opmode(ndev, CCC_OPC_RESET) or ravb_set_config_mode()
fails earlier in ravb_wol_restore(), the function returns before the
napi_enable() pair above, so the napi_disable() calls done by
ravb_wol_setup() during suspend are never balanced:

drivers/net/ethernet/renesas/ravb_main.c:ravb_wol_setup() {
	if (info->nc_queues)
		napi_disable(&priv->napi[RAVB_NC]);
	napi_disable(&priv->napi[RAVB_BE]);
}

ravb_resume() propagates the error and never calls ravb_open():

drivers/net/ethernet/renesas/ravb_main.c:ravb_resume() {
	if (priv->wol_enabled)
		ret = ravb_wol_restore(ndev);
	else
		ret = pm_runtime_force_resume(dev);
	if (ret) {
		rtnl_unlock();
		return ret;
	}
}

The netdev stays registered and IFF_UP, so the next ndo_stop ("ip link
set <dev> down", or dev_close() from unregister_netdev() in
ravb_remove()) reaches ravb_close(), which calls napi_disable() a second
time on the already-disabled instances.  Does that spin forever in
napi_disable_locked()?

net/core/dev.c:napi_disable_locked() {
	val = READ_ONCE(n->state);
	do {
		while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
			usleep_range(20, 200);
			val = READ_ONCE(n->state);
		}
	...
}

Both bits were left set by the first napi_disable() and only napi_enable()
clears them, so the caller would loop in process context while holding
RTNL and the netdev instance lock.

The concrete error source is the -ETIMEDOUT from ravb_wait() on the
CSR_OPS poll inside ravb_set_opmode().  Would moving the napi_enable()
pair before the opmode transitions, or adding error unwinding to the two
early returns, be preferable?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921175037.4084310-1-niklas.soderlund%2Brenesas%40ragnatech.se
