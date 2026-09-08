Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9623E4B4873
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906898; cv=none; b=EGZc/Ap3ThqvDGzBz55TF0nt+sTRtCYoOHAf+r7p7Gh4L/FJuKz4WJtSf2ITWPXHBvq4do5rjHtQobSsWkaGFF677aPNBu0rupohka+C9yLL1eN1gpMJfpFPy3vBj+d4ghnFqfqdkBO4aujKBDpQvJyii0nxVRI/Twtsm/Xc7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906898; c=relaxed/simple;
	bh=zmjh6vw7+ivOMZTssiWlFvMT6xovfJGJc9XySlyE5a0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BAEAZTPEBF6aL2mhzcOa5ITWwM6JH7hAzVAa2R0hGpMi1nW0kMolQkS+wWkljCI1J6wJWy1UdbYKSvnlAmCtzugkFyigpChx9zfEoqXfX80dXF4m2coNdaig+3w8XPqEn3Ra/k8MxLjeXIllaBn/yPlrgCJlzAoUUDXSwnMGXkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVdYIX9B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVdYIX9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475E71F00A3A;
	Tue,  8 Sep 2026 22:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788906897;
	bh=u3ve8nTY6p167n5PBV2AE/B2EPO6bS9/V3b8DAps+Eo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YVdYIX9B/ZPz+LioRx1wgIaVumNMsN9aYpN8EN4HtobTsWBqkat2voot7aYCHxPiM
	 LJSXRA4DULYnTyQCLnJ36IgewsmRRdh2u5qHon6U/6dCz6Tk8U/au2pcr3bYHqOCox
	 7zqGuGdFHDrDyJAH6ARXxo3piKP7paMBfUJnCh/NS+4vGxn/OZO4KgglcO7h47zCh4
	 qQGmoVcBoYxeEMSNwRMhxq63/Twqz3aJW7IS9s3Qcl0cTf2yTMC0lj0PPTuJZVpdFV
	 fPHXqKXUSlfu0j4Q4v10X0tjn4Wyd39jyg0NzEJJpzd43Tsl0Nk3fop6qWIgdBUkp4
	 F92xo51LP91pQ==
Subject: Re: [PATCH net] net: stmmac: initialize ptp_lock at probe time
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Tue, 08 Sep 2026 22:34:55 +0000
Message-ID: <178890689580.219967.13444061926951235815@kernel.org>
In-Reply-To:
 <20260904-stmmac-fix-ptp-clock-init-v1-1-df70eb1eb04d@oss.qualcomm.com>
References:
 <20260904-stmmac-fix-ptp-clock-init-v1-1-df70eb1eb04d@oss.qualcomm.com>
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

Critical: 0 · High: 1 · Medium: 0 (2) · Low: 0

- [High] Incomplete fix: the TAPRIO offload path that this commit
  legitimizes for a never-opened interface still performs MMIO on a…

Pre-existing issues:
- [Medium] EST state (priv->est->enable, priv->est->gcl[]) is accessed
  with inconsistent locking between the taprio offload path and the PTP…
- [Medium] An EST/taprio schedule programmed while the interface is down
  is silently discarded by the MAC/DMA software reset performed at open,…

--

net: stmmac: initialize ptp_lock at probe time

This moves rwlock_init(&priv->ptp_lock) from stmmac_ptp_register() to
__stmmac_dvr_probe() so that the lock is initialized even when the
interface has never been opened, which is the case when tc_taprio_configure()
calls the PTP gettime64() callback to compute the EST base time.

No Link: tags present in the commit header.

A few questions about the paths this touches.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 24656b35350b1..5fe7e95fdd345 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -8025,6 +8025,7 @@ static int __stmmac_dvr_probe(struct device *device,
>  	stmmac_napi_add(ndev);
>  
>  	mutex_init(&priv->lock);
> +	rwlock_init(&priv->ptp_lock);

[Severity: High]
The commit message describes the down-interface gettime64() call as a
legitimate use ("the lock is also used while the interface is down and has
never been opened").  Is that call safe once the lock is initialized?

__stmmac_dvr_probe() ends with pm_runtime_put(), and
stmmac_runtime_suspend() in stmmac_platform.c gates the CSR clocks:

	stmmac_bus_clks_config(priv, false);
	  clk_disable_unprepare(priv->plat->stmmac_clk);
	  clk_disable_unprepare(priv->plat->pclk);

So a probed-but-never-opened device is runtime suspended.  The taprio
offload path does not take a runtime-PM reference and does not check
netif_running():

  stmmac_setup_tc()  case TC_SETUP_QDISC_TAPRIO
    tc_setup_taprio()
      tc_taprio_configure()
        priv->ptp_clock_ops.gettime64()  ->  stmmac_get_time()
                                               stmmac_get_systime(priv->ptpaddr)
        stmmac_est_configure()           ->  writes/polls priv->estaddr

Every other register-touching ndo in this driver wraps the access in
pm_runtime_resume_and_get(), for example stmmac_set_mac_address(),
stmmac_vlan_rx_add_vid(), stmmac_vlan_rx_kill_vid() and __stmmac_open().
Can the MMIO in stmmac_get_systime() and est_configure() read/write a
clock-gated MAC/PTP block here, and on SoCs that actually gate pclk, can
that abort or stall?

There is a second aspect to the same call.  The PTP counter is only
programmed from the open path:

  __stmmac_open()
    stmmac_setup_ptp()
      stmmac_init_timestamping()
        stmmac_init_tstamp_counter()   /* TCR enable, SSINC, init systime */

If the interface was never opened, does gettime64() return a usable time
base, and does stmmac_calc_tas_basetime() then program priv->est->btr[]
from a meaningless value?

Would it make sense to gate TC_SETUP_QDISC_TAPRIO on netif_running() (or
on the PTP counter being started), and/or take a runtime-PM reference in
stmmac_setup_tc(), in addition to moving the rwlock_init()?  Reproducer
is "tc qdisc replace dev ethX root taprio ... flags 0x2" on an interface
that has never been brought up; taprio_enable_offload() in
net/sched/sch_taprio.c has no netif_running() gate.

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but since
the change makes the down-interface configuration sequence easier to
reach it seems worth mentioning.  Is an EST schedule programmed while the
interface is down preserved across open?

tc_taprio_configure() commits priv->est->enable, btr[]/ctr[] and
max_sdu[] and pushes them to hardware via stmmac_est_configure().  Then
open does:

  __stmmac_open()
    stmmac_hw_setup()
      /* DMA initialization and SW reset */
      stmmac_init_dma_engine(priv);

which asserts DMA SWR and resets the MAC/MTL registers, including
MTL_EST_CONTROL, the GCL RAM and BTR/CTR.  stmmac_est_configure() has no
call site in stmmac_main.c (only tc_taprio_configure() and the disable
label in stmmac_tc.c, plus stmmac_adjust_time() in stmmac_ptp.c), and
taprio_dev_notifier() in net/sched/sch_taprio.c only recomputes
picos_per_byte/max_sdu on NETDEV_UP rather than re-issuing the offload.

Does that leave priv->est->enable true with EST disabled in hardware,
while stmmac_xmit(), stmmac_xdp_xmit_back() and the XSK path keep
enforcing priv->est->max_sdu[] and the taprio dump reports an active
offloaded schedule?

>  
>  	stmmac_fpe_init(priv);
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 960249960004c..3bfcc9760dce7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -365,7 +365,6 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
>  	if (priv->plat->crosststamp)
>  		priv->ptp_clock_ops.getcrosststamp = stmmac_getcrosststamp;
>  
> -	rwlock_init(&priv->ptp_lock);

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but while
looking at the locking in this file: is the est_lock coverage of
priv->est consistent between the taprio path and the adjtime path?

In stmmac_adjust_time() the decision is taken with no lock held:

	/* If EST is enabled, disabled it before adjust ptp time. */
	if (priv->est && priv->est->enable) {

and it is acted upon later, after est_lock has been taken again, where
priv->est->enable is set back to true and stmmac_est_configure() is
called.

Meanwhile tc_taprio_configure() publishes the new size and enable flag
under the lock:

	mutex_lock(&priv->est_lock);
	priv->est->gcl_size = size;
	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
	mutex_unlock(&priv->est_lock);

but fills the entries with the lock dropped:

		priv->est->gcl[i] = delta_ns | (gates << wid);

tc_taprio_configure() runs under rtnl from ndo_setup_tc while
stmmac_adjust_time() runs from PTP_CLOCK_ADJTIME on /dev/ptpX without
rtnl, so the two can run concurrently.

Can an adjtime landing in that window make stmmac_est_configure()
program the hardware gate list from a partially written gcl[] with the
new gcl_size already visible?

And can a "tc qdisc del" that clears enable and takes the disable: path
be undone by a concurrent adjtime that re-enables EST from its stale
unlocked observation?

>  	mutex_init(&priv->aux_ts_lock);
>  
>  	priv->ptp_clock = ptp_clock_register(&priv->ptp_clock_ops,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-stmmac-fix-ptp-clock-init-v1-1-df70eb1eb04d%40oss.qualcomm.com
