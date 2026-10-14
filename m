Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4CB6AD4;
	Wed, 14 Oct 2026 04:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791950631; cv=none; b=YFWReT3/UOOpCMpwXE9nBZJMEUJVs5/hXFwTjOBtHzRJvW3ngfzEk4l/+LfzifenEKV9Xkw4AmYeF8b36IFrPFZFG5Ks2aLeZ1phP0OAJTwc4SdXvCsP32C2V+NqmN15kdB66vbZwtkVoM0HuvbWompCb8U/eT/+QDaz2Ou4c5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791950631; c=relaxed/simple;
	bh=ndg1LolXcq5l5x8/yfy1msbnqLW3/XXY6IXQxjjXY4w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iy0GA26j04d7vG12QJ4yQfVBGkxwPSW9iv03UR9ytXsx/5Dwv/MJV1lRObM3T4n6AhqbEC7ghlucpp8uLTUUrXMi20AozLHMlTU/40Abl1iHxs36PwVN8p2s7g4HvsAI4hg5GtkAfxbGCJRvP/tp3kVU5rmh9VsUx/hHaKr76vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1mVejlx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1mVejlx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC22B1F000FF;
	Wed, 14 Oct 2026 04:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791950629;
	bh=hZ27OHOWlIzHI+9Uvx4Rt+Z3ThNOr+Qo/L+OypEz41g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I1mVejlxP9G+exIkBndzljRD+Fg5+7uMvZ2/SsTNKoiP96jFP9+xU8cWuQt+11qEz
	 0ZbuCEgu3K0elL575rymee8qksUnebiTVwmxKmMPQknAIa4Ryjxs3VsfOuLLxCsnnd
	 7V2xeETW6EQTqrmHUbh3jLFX+Ge/NOg8gXoOF43e1N0yvfI9R8CZPlkgaDA+yLpEsQ
	 Pj5NJiXENMogpbJBxz+CYjz2/4/3376HJBROO9JoEVpGxn2LkNZgqV1JeozYXP2ZrC
	 FBihYS8cxHCQqjf1UKYdIJUSIkwfAlXiY0adLvnfXNY6helDa6W3cxykzYtqWn+2Le
	 huKsinPCCLHzQ==
Subject: Re: [PATCH net-next v8 1/3] net: stmmac: dwmac-socfpga: complete
 cross-timestamp on ATSNS
From: netdev-bot+sashiko@kernel.org
To: zxyan0222@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, muhammad.nazim.amirul.nazle.asmade@altera.com,
 rohan.g.thomas@altera.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 04:03:48 +0000
Message-ID: <179195062830.434549.9772327824261353098@kernel.org>
In-Reply-To: <20261013033207.1684328-2-zxyan0222@gmail.com>
References: <20261013033207.1684328-2-zxyan0222@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 2 · Medium: 0 (4) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: stmmac: TOCTOU race on STMMAC_FLAG_EXT_SNAPSHOT_EN check
- [High] net: stmmac: race condition in smtg_crosststamp leaves SMTG
  reads unprotected

Pre-existing issues:
- [Medium] intel_crosststamp() in
  drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c has the same…
- [Medium] smtg_crosststamp() (drivers/net/ethernet/stmicro/stmmac/dwmac-
  socfpga.c:310) tests STMMAC_FLAG_EXT_SNAPSHOT_EN before…
- [Medium] At this commit, the XGMAC/XLGMAC hwif entries use .hwtimestamp
  = &stmmac_ptp.
- [Medium] smtg_crosststamp() releases aux_ts_lock (dwmac-socfpga.c:391)
  before get_smtgtime() reads the system-counter half of the cross-…

--

net: stmmac: dwmac-socfpga: complete cross-timestamp on ATSNS

This patch changes smtg_crosststamp() so that it first waits for the
PTP_ACR_ATSFC FIFO clear to finish, then polls the ATSNS count in
XGMAC_TIMESTAMP_STATUS instead of the transient TSIS bit. It also holds
aux_ts_lock across the whole clear, trigger, poll and drain sequence.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index 6d4bc1fe8f751..ee79b74bf21b6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -337,8 +337,18 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
>  	acr_value = readl(ptpaddr + PTP_ACR);
>  	acr_value |= PTP_ACR_ATSFC;
>  	writel(acr_value, ptpaddr + PTP_ACR);

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. In
smtg_crosststamp(), the STMMAC_FLAG_EXT_SNAPSHOT_EN check runs before
aux_ts_lock is taken, and it is not checked again once the lock is held:

	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
		return -EBUSY;

	mutex_lock(&priv->aux_ts_lock);

stmmac_enable() sets that flag and programs PTP_ACR under aux_ts_lock:

	priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;

	/* Enable External snapshot trigger */
	acr_value |= PTP_ACR_ATSEN(rq->extts.index);
	acr_value |= PTP_ACR_ATSFC;

A PTP_CLK_REQ_EXTTS enable can finish between the unlocked check and
mutex_lock(). One way this happens is when both callers are blocked on
the mutex behind another crosststamp. smtg_crosststamp() then goes on to
do:

	acr_value &= ~PTP_ACR_MASK;

Does this clear the external ATSEN bit? And does the ATSFC write that
follows then flush any external snapshots already latched?

If so, EXT_SNAPSHOT_EN stays set and the EXTTS request has already
returned success, but external events are no longer latched and no error
is reported. Could the EXT_SNAPSHOT_EN check be moved under aux_ts_lock?

Also, at this commit smtg_crosststamp() does not set
STMMAC_FLAG_INT_SNAPSHOT_EN, so the shared timestamp_interrupt() could
drain the FIFO during this window. A later patch in the series, "net:
stmmac: dwxgmac2: add XGMAC timestamp interrupt support", fixes that
part. The unlocked EXT_SNAPSHOT_EN check is still there at the end of
the series.

> -	/* Release the mutex */
> -	mutex_unlock(&priv->aux_ts_lock);

[Severity: High]
This isn't introduced by this patch, and the window is narrower than
before. Still, the system counter half of the cross-timestamp is read
after aux_ts_lock has been dropped.

The SMTG block latches the ARM arch counter on the GPO0 rising edge
that smtg_crosststamp() generates. get_smtgtime() then fetches that
latched value with four separate mdiobus_read() calls, from
SMTG_TSC_WORD3 down to SMTG_TSC_WORD0. Each MDIO read is serialized
on its own, but nothing ties the four reads to the trigger that
produced the value.

Neither ptp_sys_offset_precise() nor get_device_system_crosststamp()
serializes calls into the getcrosststamp path. Two processes issuing
PTP_SYS_OFFSET_PRECISE on the same /dev/ptpX, for example phc2sys and
chronyd, can therefore run smtg_crosststamp() concurrently.

Suppose the first caller has dropped aux_ts_lock but has not finished
get_smtgtime(). The second caller can take aux_ts_lock, clear the FIFO
and toggle GPO0 in that window, which relatches the SMTG registers
under the first caller. The first caller then pairs its PTP device
time with the second capture, or with words torn across the two
captures, and still reports success.

That silently breaks the precision PTP_SYS_OFFSET_PRECISE is meant to
provide. Would it work to move this mutex_unlock() after
get_smtgtime()? Then the trigger, the FIFO drain and the SMTG read
would all happen under aux_ts_lock. Holding the mutex across the MDIO
accesses should be fine, since this path can already sleep. Is there
any path that takes aux_ts_lock with the MDIO bus lock held?

[Severity: Medium]
This isn't a bug introduced by this patch, but intel_crosststamp() in
drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c still has the pattern
that this patch removes from the socfpga version:

dwmac-intel.c:intel_crosststamp() {
    ...
	acr_value |= PTP_ACR_ATSFC;
	writel(acr_value, ptpaddr + PTP_ACR);
	/* Release the mutex */
	mutex_unlock(&priv->aux_ts_lock);
    ...
}

It never waits for the ATSFC clear to complete. It also waits on the
transient TSIE bit through stmmac_cross_ts_isr():

	return (readl(priv->ioaddr + GMAC_INT_STATUS) & GMAC_INT_TSIE);

After that it reads ATSNS from GMAC_TIMESTAMP_STATUS and drains the aux
FIFO without holding aux_ts_lock:

	num_snapshot = (readl(ioaddr + GMAC_TIMESTAMP_STATUS) &
			GMAC_TIMESTAMP_ATSNS_MASK) >>
			GMAC_TIMESTAMP_ATSNS_SHIFT;

stmmac_enable() handles PTP_CLK_REQ_EXTTS by taking aux_ts_lock,
rewriting PTP_ACR and setting ATSFC. Can that flush or re-arm the FIFO
between the TSIE wait and the drain loop? A stale TSIE, or a FIFO clear
that is still in progress, could also produce a stale or missing device
sample.

If num_snapshot ends up as 0, system->cycles stays 0 and
get_device_system_crosststamp() returns -EINVAL. So the result is a
mismatched sample or a spurious error, not uninitialized data.

Would it make sense to apply the same fix to intel_crosststamp() in a
follow-up?

> +
> +	/* Wait for the FIFO clear, so the poll only sees snapshots from
> +	 * this trigger.
> +	 */

[ ... ]

> @@ -349,10 +359,14 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
>  	gpio_value |= XGMAC_GPIO_GPO0;
>  	writel(gpio_value, ioaddr + XGMAC_GPIO_STATUS);
>  
> -	/* Poll for time sync operation done */
> -	ret = readl_poll_timeout(priv->ioaddr + XGMAC_INT_STATUS, v,
> -				 (v & XGMAC_INT_TSIS), 100, 10000);
> +	/* Poll ATSNS instead of the transient TSIS: the ATSNS count is
> +	 * the FIFO level and is not cleared by reading the register.
> +	 */
> +	ret = readl_poll_timeout(ioaddr + XGMAC_TIMESTAMP_STATUS, v,
> +				 FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v),
> +				 100, 10000);

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. At
this commit, the shared timestamp ISR does not use this register on
XGMAC. The XGMAC and XLGMAC entries in hwif.c use:

		.hwtimestamp = &stmmac_ptp,

and timestamp_interrupt() in stmmac_hwtstamp.c reads the dwmac4 offset:

	ts_status = readl(priv->ioaddr + GMAC_TIMESTAMP_STATUS);

GMAC_TIMESTAMP_STATUS is 0xb20, while XGMAC_TIMESTAMP_STATUS is 0xd20
with ATSNS at GENMASK(29, 25). On XGMAC cores, does the EXTTS ISR read
an unrelated register both to clear the timestamp status and to get the
aux FIFO level? That would give wrong or missing EXTTS events.

This looks like it is fixed later in the series by "net: stmmac:
dwxgmac2: add XGMAC timestamp interrupt support". That patch adds
dwxgmac2_ptp, whose dwxgmac2_timestamp_interrupt() reads
XGMAC_TIMESTAMP_STATUS, and switches both XGMAC hwif entries to
&dwxgmac2_ptp.

[ ... ]

> @@ -375,6 +388,8 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
>  		read_unlock_irqrestore(&priv->ptp_lock, flags);
>  	}
>  
> +	mutex_unlock(&priv->aux_ts_lock);
> +
>  	get_smtgtime(priv->mii, SMTG_MDIO_ADDR, &smtg_time);
>  	system->cycles = smtg_time;

[Severity: Medium]
This isn't a bug introduced by this patch, but the system counter half
of the cross-timestamp is still read after aux_ts_lock is dropped. The
SMTG IP latches the ARM arch counter on the GPO0 trigger. get_smtgtime()
then reads it with four separate MDIO reads:

	ns = mdiobus_read(mii, smtg_addr, SMTG_TSC_WORD3);
	...
	ns |= mdiobus_read(mii, smtg_addr, SMTG_TSC_WORD0);

ptp_sys_offset_precise() does not take pincfg_mux, and
get_device_system_crosststamp() does not serialize get_time_fn. With two
concurrent PTP_SYS_OFFSET_PRECISE callers, can the second caller take
aux_ts_lock and toggle GPO0 again before or during the first caller's
MDIO reads?

In that case the first caller pairs its device timestamp with the second
capture, or with words torn across the two captures, and still returns
success.

Before this patch the mutex was dropped even before the GPO0 trigger, so
the window was wider then. Would moving mutex_unlock() after
get_smtgtime() close the remaining window?

[ ... ]

> @@ -337,8 +337,18 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
>  	acr_value = readl(ptpaddr + PTP_ACR);
>  	acr_value |= PTP_ACR_ATSFC;
>  	writel(acr_value, ptpaddr + PTP_ACR);
> -	/* Release the mutex */
> -	mutex_unlock(&priv->aux_ts_lock);
> +
> +	/* Wait for the FIFO clear, so the poll only sees snapshots from
> +	 * this trigger.
> +	 */
> +	ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
> +				 !(acr_value & PTP_ACR_ATSFC), 10, 10000);
> +	if (ret) {
> +		mutex_unlock(&priv->aux_ts_lock);
> +		netdev_err(priv->dev, "%s: Failed to clear snapshot FIFO\n",
> +			   __func__);
> +		return ret;
> +	}
>  
>  	/* Trigger Internal snapshot signal. Create a rising edge by just toggle
>  	 * the GPO0 to low and back to high.

[Severity: High]
This isn't introduced by this patch, but there is still a hole at the
top of smtg_crosststamp(). The commit message says aux_ts_lock is now
held across the whole sequence so a concurrent PTP_CLK_REQ_EXTTS
request cannot interfere. However, the STMMAC_FLAG_EXT_SNAPSHOT_EN test
that returns -EBUSY runs before mutex_lock(&priv->aux_ts_lock), and it
is not repeated once the lock is held.

stmmac_enable() sets STMMAC_FLAG_EXT_SNAPSHOT_EN and writes
PTP_ACR_ATSEN(rq->extts.index) | PTP_ACR_ATSFC into PTP_ACR under
aux_ts_lock. So this interleaving looks possible:

  smtg_crosststamp()           stmmac_enable(EXTTS, on)
  flag check passes
                               mutex_lock(aux_ts_lock)
                               set EXT_SNAPSHOT_EN
                               set ATSEN(n) | ATSFC in PTP_ACR
                               mutex_unlock(aux_ts_lock)
                               return 0
  mutex_lock(aux_ts_lock)
  acr_value &= ~PTP_ACR_MASK
  set ATSEN(int_snapshot_num)
  set ATSFC

Doesn't that drop the external ATSEN bit? And doesn't the ATSFC write
that follows flush any external snapshots already latched? Nothing
restores the external trigger afterwards. EXT_SNAPSHOT_EN stays set,
so later crosststamp calls return -EBUSY. Meanwhile the EXTTS request,
which already returned success, silently stops producing events.

Could the EXT_SNAPSHOT_EN check be moved after mutex_lock(), with an
unlock on the -EBUSY path? Then the check and the PTP_ACR update would
be done under the same lock.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013033207.1684328-1-zxyan0222%40gmail.com
