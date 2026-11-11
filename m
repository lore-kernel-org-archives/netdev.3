Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404832;
	b=E1qUZqJ/ZtDtRl7zm48bxytJVQsxy9iKZEa5Nbryh915+107xYyfMEtKSuK0xlpxlOp0
	 HGeKZnnTrkpGkdgCeBiSO00aa2tUXt/WFtGToQ514TbklIKHInNHB+XPWrwcMhurPphpS
	 6GZRTJkIUOcjuEc3F0WGCQ4rurMGGIl/fPx1HzHclZoEtIFvJGyXSH0z6P+e2LxXmONW1
	 Kk+3RhmsjPtQt4t4W0k7nDL262ezgHckGsogcZ2VVJ+By3wxz4+b3+UJLbmXL3Y8VlgHi
	 FvvVMDLnHbaq3s/W/D/eZG1KeFjya3t6/wP4UYsR4GE1D9KwkZ87FrHRIB15ApaotUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404832;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5vF0BMk1tRSpraGRppdwIm7WTor6EeJ5JJdKAum4QCw=;
	b=FH1J3J7bc2KCkfugQsJ+LrMcDxec7b3Veqd7IXKm7ViWM0BA6Jpv5FH+SmmvXdNLT4RQ
	 h23nEqUSSg7a3kzFAX1Ik4HqFiRVbLcrErpEmkMc+Yd0Kvqjd3fsW55YAlEQJoHOVxfX1
	 usTook9JLVxMcSO/hoPTT2UZepnRwCJTwkrq12tJ4wTtTcLTU4D9f/7uiQQMmpWvguKyS
	 T0n3xj9Y+9DFhBmAYUcPEEgrmZBze/lL4foM7Yq7d9K7Q2D+on8m9ZFYIL7lIGs0rM90w
	 +gk8O+q6OPuFx7bORhLwDa5OG5IzyHik15Y0s/JVBve+PobsKPLxiELyEr/CiwM01Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gBk3A/QP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7165606A335;
	Wed, 11 Nov 2026 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBk3A/QP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729EA1F00A09;
	Wed, 11 Nov 2026 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404832;
	bh=5vF0BMk1tRSpraGRppdwIm7WTor6EeJ5JJdKAum4QCw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gBk3A/QPPASNlPvNbOfe7sfwuSbn9+HPxXociOsLJxxSc8AEpOUs0Xir/12lQYyQK
	 Gs1rhE+F3OleSOkEzG1MBnwMpJagdGZMHhiA9QSjpjDy6983LuqlTkF/lPXi4kQUJv
	 7mP5Zrk21y86f8g6Lfst6ETM3r6a1kM4ECnNEiItUJnMT6RXyVuPW8RI7WzL/GttW4
	 cxWtlXlaiFlwaia1LfG5JUEMmoVE27w8SkPwszDNYTWopZLAFp3k9xbTSkdNx0bMoD
	 kl4BA9Xfzgn3/L/m6znKoKTR7N+FhgNYA0H3PgrEaIh6w+s2VY/r35PD3rCtjuf2R+
	 jJrYCN5axv4AQ==
Subject: Re: [PATCH net-next v10 3/3] net: stmmac: dwxgmac2: add XGMAC
 timestamp interrupt support
From: netdev-bot+sashiko@kernel.org
To: zxyan0222@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, muhammad.nazim.amirul.nazle.asmade@altera.com,
 rohan.g.thomas@altera.com, rmk+kernel@armlinux.org.uk,
 o.rempel@pengutronix.de, wojciech.drewek@intel.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 11 Nov 2026 13:47:10 +0000
Message-ID: <179440483097.2199510.11602578563811617638@kernel.org>
In-Reply-To: <20261109134506.2794160-4-zxyan0222@gmail.com>
References: <20261109134506.2794160-4-zxyan0222@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 7 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The subject says "net: stmmac: dwxgmac2: add XGMAC timestamp
  interrupt support", but the patch also changes EXTTS and cross-…
- [Medium] The recorded EXTTS state (STMMAC_FLAG_EXT_SNAPSHOT_EN and
  plat->ext_snapshot_num) can survive resume after the hardware trigger…
- [Medium] stmmac_ptp_unregister() sets priv->ptp_clock to NULL and
  disarms the trigger under aux_ts_lock, "so a concurrent request cannot…
- [Medium] The patch adds a generic optional hook,
  stmmac_ops->timestamp_interrupt_cfg ("Arm or disarm the timestamp…
- [Medium] Who owns the auxiliary snapshot FIFO, the process-context
  cross-timestamp code (smtg_crosststamp, intel_crosststamp) or the…
- [Medium] net: stmmac: unlocked ptp_clock access in
  stmmac_ptp_register()
- [Medium] net: stmmac: dwxgmac2: concurrent FIFO pop in
  dwxgmac2_timestamp_interrupt()
- [Low] The commit message describes a user-visible bug.
- [Low] intel_crosststamp() takes aux_ts_lock at entry, returns -ENODEV
  if priv->ptp_clock is NULL, and holds the lock until it exits.
- [Low] stmmac_drop_extts_state() always clears the PTP_ACR/PTP_TCR
  trigger bits and logs netdev_err("Dropped the enabled auxiliary…

--

net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support

This patch adds a DWXGMAC2 timestamp interrupt handler. The handler
reports auxiliary snapshots as PTP_CLOCK_EXTTS events. XGMAC_TSIE is armed
on demand through a new stmmac_ops->timestamp_interrupt_cfg() callback.

The patch also reworks EXTTS channel bookkeeping and the use of aux_ts_lock
in the Intel and socfpga cross-timestamp paths. It also changes how
suspend, resume and unregister handle the auxiliary snapshot trigger.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> index 4308dccbf2570..3f0889c30a70c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c

[ ... ]

> @@ -424,11 +426,22 @@ static int intel_crosststamp(ktime_t *device,
>  	writel(gpio_value, ioaddr + GMAC_GPIO_STATUS);
>  
>  	/* Time sync done Indication - Interrupt method */
> -	if (!wait_event_interruptible_timeout(priv->tstamp_busy_wait,
> -					      stmmac_cross_ts_isr(priv),
> -					      HZ / 100)) {
> +	ret = wait_event_interruptible_timeout(priv->tstamp_busy_wait,
> +					       stmmac_cross_ts_isr(priv),
> +					       HZ / 100);
> +	if (ret <= 0) {
> +		/* Disarm the trigger on a timeout or an interrupted
> +		 * wait, but do not touch the hardware once the clock has
> +		 * been invalidated by an interface teardown.
> +		 */
> +		if (priv->ptp_clock) {

[Severity: Low]
Can priv->ptp_clock actually be NULL here? intel_crosststamp() now takes
aux_ts_lock on entry, returns -ENODEV if priv->ptp_clock is NULL, and holds
the lock until it returns.

The only runtime path that clears the pointer is stmmac_ptp_unregister(),
and it does that under the same lock:

	mutex_lock(&priv->aux_ts_lock);
	clock = priv->ptp_clock;
	priv->ptp_clock = NULL;

That means this check, and the one before the final PTP_ACR disarm, are
always true. Could these checks be dropped, along with the comment and the
"skips the disarm write afterwards" wording in the commit message?

> +			acr_value = readl(ptpaddr + PTP_ACR);
> +			acr_value &= ~PTP_ACR_MASK;
> +			writel(acr_value, ptpaddr + PTP_ACR);
> +		}

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 1a88cbaed70ca..ff2956bb89e62 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c

[ ... ]

> @@ -1154,6 +1160,60 @@ static int dwxgmac2_get_mac_tx_timestamp(struct mac_device_info *hw, u64 *ts)
>  	return 0;
>  }
>  
> +void dwxgmac2_timestamp_interrupt(struct stmmac_priv *priv)
> +{

[ ... ]

> +	/* Runs on every MAC interrupt: only touch the FIFO when the
> +	 * timestamp interrupt was armed, and leave it to the
> +	 * cross-timestamp path while that owns it.
> +	 */
> +	if (priv->plat->flags & STMMAC_FLAG_INT_SNAPSHOT_EN) {
> +		readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);
> +		return;
> +	}
> +
> +	if (!(readl(priv->ioaddr + XGMAC_INT_EN) & XGMAC_TSIE))
> +		return;

[Severity: Medium]
Can two instances of this handler drain the FIFO at the same time?
When priv->wol_irq is a separate line, stmmac_request_irq_single() and
stmmac_request_irq_multi_msi() install stmmac_interrupt() or
stmmac_mac_interrupt() on both dev->irq and wol_irq, and both end up
in stmmac_common_interrupt() and so in this function. That is why
stmmac_sync_timestamp_irq() has to sync both lines.

The handler deliberately doesn't gate on the read-to-clear TSIS bit,
and reading XGMAC_TIMESTAMP_STATUS doesn't change ATSNS. If the
timestamp interrupt on dev->irq and a PMT event on wol_irq are
handled on two CPUs at once, both see XGMAC_TSIE armed and read the
same non-zero pending_snapshots.

The drain loop only takes ptp_lock for reading, which doesn't exclude
another reader. get_ptptime() reads PTP_ATNR and then PTP_ATSR, and
the PTP_ATSR read pops the FIFO head. With two CPUs in the loop the
reads interleave across entries, so an event can pair the nanoseconds
of one snapshot with the seconds of another. The FIFO is also popped
2 * pending_snapshots times, and the extra pops read whatever an
empty FIFO returns, which is still reported to userspace as a
PTP_CLOCK_EXTTS event.

Should the count read and the pops be serialised with a spinlock, for
example a dedicated one or ptp_lock taken for writing? Re-reading
ATSNS before each pop would stop the loop at an empty FIFO, but it
wouldn't fix the torn ATNR/ATSR pairs on its own.

[Severity: Medium]
Is STMMAC_FLAG_INT_SNAPSHOT_EN being used as a lock here rather than as
state? smtg_crosststamp() now sets it on entry and clears it on every exit,
only to keep this hardirq handler away from the snapshot FIFO:

	priv->plat->flags |= STMMAC_FLAG_INT_SNAPSHOT_EN;
	/* Wait for a handler that is already past the flag check before
	 * taking over the snapshot FIFO.
	 */
	stmmac_sync_timestamp_irq(priv);
	...
	priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;

The handler reads plat->flags with plain loads, while process context does
non-atomic |= and &= on the same word. The handler also uses the XGMAC_TSIE
bit in XGMAC_INT_EN as a second gate.

Correctness then depends on ordering spread across stmmac_enable(),
stmmac_rearm_timestamp_irq(), stmmac_suspend(), stmmac_ptp_unregister()
and core_init. Lockdep can't check any of that.

intel_crosststamp() also sets the same flag but skips the
stmmac_sync_timestamp_irq() drain. So the scheme isn't applied the same way
in both cross-timestamp paths.

Would an IRQ-safe spinlock work better? It would cover the FIFO pop here
and the ATSFC/ATSEN programming in the process-context paths.

> +
> +	/* Reading XGMAC_TIMESTAMP_STATUS clears TSIS, so use the ATSNS
> +	 * count to see the pending snapshots.
> +	 */

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index 265671170bf6e..eba87410f985a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -258,7 +258,7 @@ static const struct stmmac_hwif_entry {
>  		.dma = &dwxgmac210_dma_ops,
>  		.mac = &dwxgmac210_ops,
>  		.vlan = &dwxgmac210_vlan_ops,
> -		.hwtimestamp = &stmmac_ptp,
> +		.hwtimestamp = &dwxgmac2_ptp,

[Severity: Low]
The commit message describes a bug that users can see. With .hwtimestamp =
&stmmac_ptp on DWXGMAC2/DWXLGMAC2, PTP_EXTTS_REQUEST succeeds but no
PTP_CLOCK_EXTTS event is ever delivered. Should this have a Fixes: tag?

The same question applies to the other fixes folded in here. One is the
channel exclusivity check in stmmac_enable(), which could never fire. The
other is the interrupted wait in intel_crosststamp(), which returned a
bogus cross-timestamp. Without Fixes: tags, stable backporters can't find
these fixes or tell how far back they apply.

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 8ae95e91a36ab..f077c1465a0c2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -317,6 +317,8 @@ struct stmmac_ops {
>  	void (*update_caps)(struct stmmac_priv *priv);
>  	/* Change the interrupt enable setting. Enable takes precedence. */
>  	void (*irq_modify)(struct mac_device_info *hw, u32 disable, u32 enable);
> +	/* Arm or disarm the timestamp interrupt on demand (optional) */
> +	void (*timestamp_interrupt_cfg)(struct stmmac_priv *priv, bool en);

[Severity: Medium]
Only dwxgmac210_ops and dwxlgmac2_ops implement this hook. MAC100/GMAC
already arm the timestamp interrupt on demand, through a static helper in
dwmac1000_core.c with the same signature:

static void dwmac1000_timestamp_interrupt_cfg(struct stmmac_priv *priv, bool en)
{
	...
	u32 intr_mask = readl(ioaddr + GMAC_INT_MASK);
	...
	writel(intr_mask, ioaddr + GMAC_INT_MASK);
}

That helper isn't wired into dwmac1000_ops, though. Doesn't that make the
new generic disarm calls no-ops on MAC100/GMAC?

In stmmac_ptp_unregister(), stmmac_mac_timestamp_interrupt_cfg(priv,
false) does nothing on those cores. Yet the stmmac_drop_hw_extts() call
right after it has a special case for them. ATSEN0 and the flag get
cleared, but GMAC_INT_DISABLE_TIMESTAMP stays cleared, so the interrupt
stays unmasked.

dwmac1000_ptp_enable() also sets STMMAC_FLAG_EXT_SNAPSHOT_EN, so the new
block in stmmac_suspend() runs on GMAC. But nothing actually gets disarmed
there before the clocks are gated.

The locking also differs. The XGMAC hook goes through irq_modify under
hw->irq_ctrl_lock. dwmac1000_timestamp_interrupt_cfg() does an unlocked
read-modify-write of GMAC_INT_MASK, a register that dwmac1000_irq_modify()
updates under that lock.

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a2177777727ef..1abc7c696cf7e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> +static void stmmac_drop_extts_state(struct stmmac_priv *priv)
> +{
> +	mutex_lock(&priv->aux_ts_lock);
> +	stmmac_drop_hw_extts(priv);
> +	priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
> +	priv->plat->ext_snapshot_num = -1;
> +	mutex_unlock(&priv->aux_ts_lock);
> +	netdev_err(priv->dev,
> +		   "Dropped the enabled auxiliary snapshot channel\n");
> +}

[Severity: Low]
Should this check STMMAC_FLAG_EXT_SNAPSHOT_EN or ext_snapshot_num first?
stmmac_resume() calls it whenever stmmac_init_ptp_clk_freq() or
stmmac_init_timestamping() fails. So the register write runs, and
netdev_err() says a channel was dropped, even when no EXTTS channel was
ever enabled.

stmmac_rearm_timestamp_irq() and stmmac_suspend() both check the flag
before doing anything.

> +
> +/**
> + * stmmac_rearm_timestamp_irq - re-arm the timestamp interrupt

[ ... ]

> +	/* Flush the FIFO, re-program the enabled auxiliary snapshot
> +	 * trigger and re-arm the interrupt only if the flush completed.
> +	 */
> +	if (priv->plat->core_type != DWMAC_CORE_XGMAC)
> +		return;

[Severity: Medium]
Can the recorded EXTTS state survive resume after the hardware trigger is
gone? The commit message says "so no stale channel survives". There seem
to be a few paths where it does.

On resume, stmmac_hw_setup()->stmmac_init_dma_engine()->stmmac_reset()
resets the core, and stmmac_init_timestamping() never restores PTP_ACR. On
GMAC, dwmac1000_core_init() also masks the timestamp interrupt again.

This early return affects GMAC4/dwmac5 (including Intel mGBE) and
MAC100/GMAC cores. On those cores the channel is neither restored nor
dropped. STMMAC_FLAG_EXT_SNAPSHOT_EN and ext_snapshot_num stay set, but
nothing is armed in hardware.

In stmmac_resume(), the stmmac_setup_est() failure branch skips both the
rearm and the drop:

		ret = stmmac_setup_est(priv);
		if (ret)
			goto error_stop_dma;

The two PTP failure branches just before it do call
stmmac_drop_extts_state(). The stmmac_hw_setup() failure path (goto
error_unlock) also leaves the state in place. On XGMAC, that leaves the
flag set while TSIE stays disarmed from stmmac_suspend().

The visible effects would be:

- The stmmac_ptp timestamp_interrupt() handler reads a zero channel from
  PTP_ACR and returns. The channel userspace thinks is enabled never
  delivers events.
- intel_crosststamp() and smtg_crosststamp() keep returning -EBUSY
  because of the stale flag.
- An enable for a different channel is accepted, because the PTP_ACR mask
  is empty. It then silently overwrites ext_snapshot_num.

Separately, dwmac1000_ptp_enable() sets and clears the flag but never
updates ext_snapshot_num.

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index a37405534bebf..4486c800fa71d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -201,35 +201,98 @@ static int stmmac_enable(struct ptp_clock_info *ptp,

[ ... ]

>  		acr_value = readl(ptpaddr + PTP_ACR);
> -		channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
> -		acr_value &= ~PTP_ACR_MASK;
> +		channel = FIELD_GET(PTP_ACR_MASK, acr_value);
>  
>  		if (on) {
> -			if (FIELD_GET(PTP_ACR_MASK, acr_value)) {
> +			if (channel && rq->extts.index != ilog2(channel)) {
>  				netdev_err(priv->dev,
>  					   "Cannot enable auxiliary snapshot %d as auxiliary snapshot %d is already enabled",
> -					rq->extts.index, channel);
> +					rq->extts.index, ilog2(channel));
>  				mutex_unlock(&priv->aux_ts_lock);
>  				return -EBUSY;
>  			}
>  
> +			if (rq->extts.index >= PTP_ACR_ATSEN_NUM) {
> +				mutex_unlock(&priv->aux_ts_lock);
> +				return -EINVAL;
> +			}

[Severity: Medium]
The subject says "dwxgmac2: add XGMAC timestamp interrupt support". But
this hunk changes EXTTS behaviour that userspace can see on every core
using stmmac_ptp_clock_ops. Should the commit message call these changes
out, or should they go in separate fixes?

The old code cleared the mask before testing it, so this -EBUSY check
could never fire. A second enable silently replaced the first channel.
After this patch, dwmac4/dwmac5 users start getting -EBUSY.

Other behaviour changes folded in:

- Disabling a channel that isn't the armed one is now a silent no-op.
  Before, any disable cleared the whole ATSEN mask.
- extts.index >= 4 is rejected with -EINVAL. stmmac_ptp_register() also
  clamps n_ext_ts to 4 on every core, including MAC100/GMAC. Userspace
  sees this through PTP_CLOCK_GETCAPS.
- intel_crosststamp() used to check only for a zero return from
  wait_event_interruptible_timeout(). An interrupted wait fell through
  with -ERESTARTSYS, read the FIFO, and returned 0 with a bogus device/ART
  pair to PTP_SYS_OFFSET_PRECISE callers. It now returns an error.
- intel_crosststamp() no longer leaves its internal trigger armed in
  PTP_ACR.
- aux_ts_lock init/destroy moves from PTP register/unregister to
  probe/remove.
- stmmac_ptp_unregister() now writes PTP_ACR on every core, or PTP_TCR on
  MAC100/GMAC.

The commit message presents these as design choices for the XGMAC handler.
It doesn't describe them as fixes, or as behaviour changes on dwmac4/5,
Intel mGBE, socfpga and MAC100/GMAC.

[ ... ]

> @@ -363,12 +422,24 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
>   */
>  void stmmac_ptp_unregister(struct stmmac_priv *priv)
>  {

[ ... ]

> +	/* Tear the hardware state down and invalidate the clock before
> +	 * releasing the lock, so a concurrent request cannot re-arm a
> +	 * clock that is going away.
> +	 */
> +	mutex_lock(&priv->aux_ts_lock);
> +	clock = priv->ptp_clock;
> +	priv->ptp_clock = NULL;
> +	stmmac_mac_timestamp_interrupt_cfg(priv, false);
> +	stmmac_drop_hw_extts(priv);
> +	priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
> +	priv->plat->ext_snapshot_num = -1;
> +	mutex_unlock(&priv->aux_ts_lock);
> +
> +	ptp_clock_unregister(clock);

[Severity: Medium]
Does this guarantee hold on MAC100/GMAC? EXTTS requests on those cores go
through dwmac1000_ptp_enable(). That function takes aux_ts_lock but never
checks priv->ptp_clock:

	case PTP_CLK_REQ_EXTTS:
		mutex_lock(&priv->aux_ts_lock);
		tcr_val = readl(ptpaddr + PTP_TCR);

		if (on) {
			tcr_val |= GMAC_PTP_TCR_ATSEN0;
			tcr_val |= GMAC_PTP_TCR_ATSFC;
			priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;
		...
		mutex_unlock(&priv->aux_ts_lock);

		dwmac1000_timestamp_interrupt_cfg(priv, on);

Suppose a PTP_EXTTS_REQUEST ioctl is already waiting on aux_ts_lock:

ioctl                               stmmac_ptp_unregister()
dwmac1000_ptp_enable()
  mutex_lock() blocks
                                    mutex_lock()
                                    priv->ptp_clock = NULL
                                    clear ATSEN0 and flag
                                    mutex_unlock()
  set ATSEN0|ATSFC and flag
  writel(PTP_TCR)
  mutex_unlock()
  dwmac1000_timestamp_interrupt_cfg(priv, 1)
                                    ptp_clock_unregister()
                                      waits for the ioctl here

ptp_clock_unregister() only waits for in-flight ioctls after aux_ts_lock
has been dropped. ptp_disable_all_events() doesn't undo this either.

Wouldn't that leave ATSEN0 re-armed, the GMAC timestamp interrupt unmasked
and STMMAC_FLAG_EXT_SNAPSHOT_EN set after the clock is gone? Should
dwmac1000_ptp_enable() get the same !priv->ptp_clock check that
stmmac_enable() now has?

> +	pr_debug("Removed PTP HW clock successfully on %s\n", priv->dev->name);
>  }

[ ... ]

> @@ -201,35 +201,98 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
>  		u8 channel;
>  
>  		mutex_lock(&priv->aux_ts_lock);
> +		/* Refuse to arm once the clock has been invalidated by
> +		 * unregister, or while an internal cross-timestamp owns the
> +		 * FIFO: the PTP_ACR programming below would disarm its
> +		 * trigger.
> +		 */
> +		if (!priv->ptp_clock) {
> +			mutex_unlock(&priv->aux_ts_lock);
> +			return -ENODEV;
> +		}
> +		if (priv->plat->flags & STMMAC_FLAG_INT_SNAPSHOT_EN) {
> +			mutex_unlock(&priv->aux_ts_lock);
> +			return -EBUSY;
> +		}
>  		acr_value = readl(ptpaddr + PTP_ACR);
> -		channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
> -		acr_value &= ~PTP_ACR_MASK;
> +		channel = FIELD_GET(PTP_ACR_MASK, acr_value);
>  
>  		if (on) {
> -			if (FIELD_GET(PTP_ACR_MASK, acr_value)) {
> +			if (channel && rq->extts.index != ilog2(channel)) {
>  				netdev_err(priv->dev,
>  					   "Cannot enable auxiliary snapshot %d as auxiliary snapshot %d is already enabled",
> -					rq->extts.index, channel);
> +					rq->extts.index, ilog2(channel));
>  				mutex_unlock(&priv->aux_ts_lock);
>  				return -EBUSY;
>  			}
>  
> +			if (rq->extts.index >= PTP_ACR_ATSEN_NUM) {
> +				mutex_unlock(&priv->aux_ts_lock);
> +				return -EINVAL;
> +			}
> +
> +			/* A re-enable of the armed channel re-arms the
> +			 * interrupt as well; disarm it across the FIFO
> +			 * clear below and drain the handler that is
> +			 * already past its checks, so no one touches the
> +			 * FIFO while it is flushed.
> +			 */
> +			if (channel) {
> +				stmmac_mac_timestamp_interrupt_cfg(priv, false);
> +				stmmac_sync_timestamp_irq(priv);
> +			}
> +
>  			priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;
> +			priv->plat->ext_snapshot_num = rq->extts.index;
>  
>  			/* Enable External snapshot trigger */
>  			acr_value |= PTP_ACR_ATSEN(rq->extts.index);
>  			acr_value |= PTP_ACR_ATSFC;
> +		} else if (channel) {
> +			/* A disable request for a channel that is not the
> +			 * armed one is a no-op: the requested channel is
> +			 * not armed.
> +			 */
> +			if (rq->extts.index != ilog2(channel)) {
> +				mutex_unlock(&priv->aux_ts_lock);
> +				return 0;
> +			}
> +
> +			acr_value &= ~PTP_ACR_MASK;
> +			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
> +			priv->plat->ext_snapshot_num = -1;
>  		} else {
>  			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
> +			priv->plat->ext_snapshot_num = -1;
>  		}
>  		netdev_dbg(priv->dev, "Auxiliary Snapshot %d %s.\n",
>  			   rq->extts.index, on ? "enabled" : "disabled");
>  		writel(acr_value, ptpaddr + PTP_ACR);
> -		mutex_unlock(&priv->aux_ts_lock);
> -		/* wait for auxts fifo clear to finish */
> +		/* Keep the lock across the FIFO clear so the arm below
> +		 * cannot interleave with a suspend.
> +		 */
>  		ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
>  					 !(acr_value & PTP_ACR_ATSFC),
>  					 10, 10000);
> +		if (ret && on) {
> +			/* Roll the failed enable back so no half-enabled
> +			 * channel is left.
> +			 */
> +			acr_value = readl(ptpaddr + PTP_ACR);
> +			acr_value &= ~PTP_ACR_ATSEN(rq->extts.index);
> +			writel(acr_value, ptpaddr + PTP_ACR);
> +			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
> +			priv->plat->ext_snapshot_num = -1;
> +		}
> +		/* Arm the timestamp interrupt only after the FIFO clear,
> +		 * so the handler cannot see a snapshot that is about to be
> +		 * discarded.
> +		 */
> +		stmmac_mac_timestamp_interrupt_cfg(priv, on && !ret);
> +		/* Drain an in-flight handler before the channel is freed. */
> +		if (!on)
> +			stmmac_sync_timestamp_irq(priv);
> +		mutex_unlock(&priv->aux_ts_lock);
>  		break;
>  	}
>  

[Severity: Medium]
Can these checks race with stmmac_ptp_register()? ptp_clock_register()
publishes /dev/ptpN through posix_clock_register() and
cdev_device_add() before it returns. stmmac_ptp_register() only stores
the result in priv->ptp_clock afterwards, and not under aux_ts_lock.

A consumer that opens the clock as soon as it appears, such as ptp4l
or ts2phc started from a udev rule, can issue PTP_EXTTS_REQUEST or
PTP_SYS_OFFSET_PRECISE inside that window. stmmac_enable(),
intel_crosststamp() and smtg_crosststamp() then see a NULL
priv->ptp_clock and fail with -ENODEV, even though the clock is being
registered rather than torn down. Before this patch those requests
worked in that window.

This is hit on every interface open, since stmmac_setup_ptp()
registers the clock again each time the interface comes up.

Would holding aux_ts_lock across ptp_clock_register() and assigning
priv->ptp_clock from a local variable before dropping it close this?

Separately, intel_crosststamp() and smtg_crosststamp() choose the
errno by reading priv->ptp_clock again after mutex_unlock(). A
concurrent stmmac_ptp_unregister() or stmmac_ptp_register() can change
it in between, so the errno need not match what was seen under the
lock, and the read itself is a data race. Could the errno be picked
before the lock is dropped, or the two checks split the way
stmmac_enable() does them?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109134506.2794160-1-zxyan0222%40gmail.com
