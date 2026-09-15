Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2243C98BF;
	Tue, 15 Sep 2026 01:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437277; cv=none; b=F/jBkyvnIAf6NWADIuc5rd2yEKVtoT8kmWws2/fTpa5pNqg9QnSp2Upyws63hqI2w3YdVu7NaWIr1uJAHFdCj8gCu1T0PcV48sPGWaCHFhSNPJ96KQ5yXYNLuIqqsrSPioizw9hGMqQKHHRAyhqGx0XflgQlFVXTFGQyF1XS/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437277; c=relaxed/simple;
	bh=hAWBdyFIged2WbFjJHQtBeT+cyvV3JxCQAqrQeGXK2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cR1lfN2aszqyDYjvh+65+dxQXlNLOPT9Nd0CHmkOl7hngoY5oc6dp/pmxyOiu+QGaN0ioBwK/DUYJG0lHeYKjydsYEawLog03RtcKOiduiX35OY3ogph33/4Dod36sF3giQmMjxZXgg/PlJIqkGBhFoXs7tSYoNHTaVVyB9VWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irKpdCHf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irKpdCHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965C31F000FF;
	Tue, 15 Sep 2026 01:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437276;
	bh=yMVlm78ZfL4h+kikOX+d8CjDlFpBAG3Ecm3SFzaNsa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=irKpdCHfinkuYLC0rOPA/3uNYWIa6mf+lC+p/hvIl2+usRHCcSwPDlrM9O/mMpffI
	 vqPTLg+sntplmSD7JgmSWgYftL2HK7utJMoAqJvc9bUDyAH0cIxlpdHCfdmQDtUVJF
	 AufLy4Bgacmy702bowC6OwSiIPU6fDd7NziD+3YIU2p+/sqP06/OIFFkzcN8DX0Csb
	 eFd0L1TLu/ABxJc+EZBN/DbJ0uI9AojXd87IHSzJBghxZ46YJkhnANkfnR0ildU1M4
	 7Q8aH7HPw8IzfKf6/gmiz8LQFoco3Glo+t/BKZ+pXAItTz5RA9TGcu5/6ql1mzFdCW
	 cwNSlWK5Jrxhg==
From: Jakub Kicinski <kuba@kernel.org>
To: niklas.soderlund+renesas@ragnatech.se
Cc: Jakub Kicinski <kuba@kernel.org>,
	paul@pbarker.dev,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	sergei.shtylyov@gmail.com,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 01/10] net: ethernet: ravb: Remove gPTP control from WoL setup and restore
Date: Mon, 14 Sep 2026 18:54:33 -0700
Message-ID: <20260915015434.881057-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909173027.2201560-2-niklas.soderlund+renesas@ragnatech.se>
References: <20260909173027.2201560-2-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: ethernet: ravb: Remove gPTP control from WoL setup and restore

This removes the ccc_gac special case that stopped the gPTP clock in
ravb_wol_setup() and re-initialized it in ravb_wol_restore(), on the
grounds that ravb_open()/ravb_close() already handle gPTP start/stop.
A few questions about the suspend side of that reasoning below.

>     This makes the special case to stop and start it when resuming from WoL
>     redundant. As the ndev will always be closed and re-opened when
>     suspending and resuming the system.

[Severity: High]
Is the statement "the ndev will always be closed and re-opened when
suspending and resuming the system" accurate for the WoL path?  In
ravb_suspend() the WoL case returns before ravb_close() is reached:

	rtnl_lock();
	if (priv->wol_enabled) {
		ret = ravb_wol_setup(ndev);
		rtnl_unlock();
		return ret;
	}

	ret = ravb_close(ndev);

So on a WoL suspend, ravb_close() (and therefore its
"if (info->gptp || info->ccc_gac) ravb_ptp_stop(ndev);") does not run at
all during suspend; it only runs later, on the resume side, from the
ravb_close() call at the end of ravb_wol_restore().  Does that make the
suspend-side removal something other than a redundancy cleanup?

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index ea1c7e536791..36173a09e2fd 100644
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
Following on from the commit message question: was this call also doing
gPTP interrupt masking that nothing else on this path does?  ravb_ptp_stop()
does more than unregister the PHC:

drivers/net/ethernet/renesas/ravb_ptp.c:
static void ravb_ptp_disable(struct net_device *ndev)
{
	ravb_write(ndev, 0, GIC);
	ravb_write(ndev, 0, GIS);
}
...
void ravb_ptp_stop(struct net_device *ndev)
{
	...
	ravb_ptp_disable(ndev);
	ravb_ptp_sync_irqs(ndev);

ravb_wol_setup() clears RIC0/RIC2/TIC and writes ECSIPR, and only
synchronizes and wake-enables priv->emac_irq.  It never touches GIC/GIS,
and it does not synchronize ndev->irq/err_irq/mgmt_irq.  The GIC bits are
armed from userspace via ravb_ptp_extts() (GIC_PTCE) and ravb_ptp_perout()
(GIC_PTME) and are cleared only by ravb_ptp_disable().

Since the WoL path also skips pm_runtime_force_suspend() and
reset_control_assert(), the block stays powered while suspended, so a
programmed compare/capture can still fire on the now-suspended non-wake
line and be latched and replayed by resume_device_irqs().  ravb uses
SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume), so that replay happens
before ravb_resume() runs.

Can the replayed interrupt then reach ravb_ptp_interrupt() while
ravb_wol_restore() is resetting the block?

	ravb_interrupt()/ravb_multi_interrupt()
	  -> ravb_ptp_interrupt()
	       gis &= ravb_read(ndev, GIC);
	       if ((gis & GIS_PTCF) && clock) {
		       ...
		       event.timestamp = ravb_read(ndev, GCPT);
		       ptp_clock_event(clock, &event);

priv->ptp.clock is still non-NULL after this change, so would that push a
timestamp read from a just-reset GCPT to userspace, and RMW GIS/GCCR/GPTC
concurrently with the unlocked ravb_set_opmode()/ravb_set_config_mode() in
ravb_wol_restore()?

Also, does the remaining "/* Only allow ECI interrupts */" comment still
describe the code for ccc_gac parts, and is the PHC (/dev/ptpN) now meant
to stay registered for the whole suspended interval?

The restore-side removal of ravb_ptp_init() does look redundant; would it
make sense to keep the suspend-side masking and synchronization, or to
spell out in the commit message why dropping it is safe?

> @@ -3204,9 +3201,6 @@ static int ravb_wol_restore(struct net_device *ndev)
>  	if (error)
>  		return error;
>  
> -	if (priv->info->ccc_gac)
> -		ravb_ptp_init(ndev, priv->pdev);
> -

[Severity: Medium]
After this change, is ravb_wol_restore() the only place that drives the
AVB-DMAC through CCC_OPC_RESET while the gPTP PHC is still registered?
The reset and config-mode re-entry happen at the top of the function:

	/* Set reset mode to rearm the WoL logic. */
	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
	if (error)
		return error;

	/* Set AVB config mode. */
	error = ravb_set_config_mode(ndev);

The other opmode transition sites stop the PHC first.  ravb_close():

	/* Stop PTP Clock driver */
	if (info->gptp || info->ccc_gac)
		ravb_ptp_stop(ndev);

and the ravb_open() error path:

out_ptp_stop:
	/* Stop PTP Clock driver */
	if (info->gptp || info->ccc_gac)
		ravb_ptp_stop(ndev);
	ravb_stop_dma(ndev);
out_set_reset:
	ravb_set_opmode(ndev, CCC_OPC_RESET);

The reset drops the GCCR TCSS=ADJGPTP selection and GTI programming that
ravb_ptp_init() установ establishes, and priv->ptp.default_addend /
current_addend still describe the pre-reset hardware; the clock is
unregistered only later, by the ravb_close() at the end of the same
function.  Pre-patch the ccc_gac branch unregistered the PHC in
ravb_wol_setup() and re-created it here, so no registered PHC spanned the
reset.  Should ravb_wol_restore() follow the same ordering as its peers?

>  	if (info->nc_queues)
>  		napi_enable(&priv->napi[RAVB_NC]);
>  	napi_enable(&priv->napi[RAVB_BE]);

[Severity: High]
This isn't a bug introduced by this patch, but while both functions are
being touched: can the NAPI enable/disable counts get out of balance on
the WoL error paths, and hang in napi_disable()?

ravb_wol_setup() disables both NAPI instances and then returns the
enable_irq_wake() result without re-enabling them:

	if (info->nc_queues)
		napi_disable(&priv->napi[RAVB_NC]);
	napi_disable(&priv->napi[RAVB_BE]);
	ravb_write(ndev, ECSIPR_MPDIP, ECSIPR);
	...
	return enable_irq_wake(priv->emac_irq);

ravb_suspend() propagates that error directly.  On the restore side, the
two early returns above skip the napi_enable() calls when ravb_wait()
times out.

Since the WoL suspend path never closes the interface, the netdev stays
netif_running() with NAPI disabled, and a failed suspend callback leaves
dev->power.is_suspended clear so ravb_resume() is skipped.  The next
ravb_close() (from "ip link set dev X down" or unregister_netdev()), or a
retried suspend re-entering ravb_wol_setup(), calls napi_disable() again:

net/core/dev.c:napi_disable_locked() {
	...
		while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
			usleep_range(20, 200);
			val = READ_ONCE(n->state);
		}

		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
	...
}

A completed disable leaves SCHED|NPSVC set and only napi_enable() clears
them, so does the second disable spin here with no timeout while rtnl and
the netdev instance lock are held?
