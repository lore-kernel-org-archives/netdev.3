Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B5C254AFF;
	Fri,  4 Sep 2026 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788484641; cv=none; b=OnXix+i1aeAUIBzjJU9vEX6QNww22M3su7hbVdfFjvqzOgO7OBCRTDkBKZnn6RomT3oD/s94vdRO83fFskGfbSE+Ll/8GXiBMseVMCEdChXGNryQkVox2W8OUpEpGaVZClAII8eTTEkC2VUjwO94k66eeF4sNPO0dCvEq8LOlHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788484641; c=relaxed/simple;
	bh=Za9YOpn5USIQZTS6tZB+AkLZginFf1c5OKbIGGhDcs4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OPDG+/Qv4v1W7Cv9Db8WYRhvI7wuf5aPXtQkFSekc3+8+wqtztLARl5IDIQKAZUfbZL5H6KM82ZfBC/cNyLhHoh21UBTSn+CZ2ugYcCGPRD+qt9fOSswcrG5tQWsQ3qC5ktUsIzeE6NpGygNixtTDIoZu5y39+qX1AHj6u3+uLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYBuoSnL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYBuoSnL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0EE1F00A3D;
	Fri,  4 Sep 2026 01:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788484639;
	bh=iMGAqUaafWVSEvBLWUQ9JIuS3x4p9XcAnPtwqq453a8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DYBuoSnLeDL3ms98FhSmOWxhXgkfGzDaFnIMaT7eA7DJQDk7oMpVrCwij2nU5XIpl
	 PH0Cyz/1WpjZXg4T/dUsh9lsdd0dcNbj+tYCMsYU4QvXf1Rrg4TVCsPe4zM/nWDw+s
	 +ZeNZlb0PSRrNxJqIqyUnsdSoZrYCa5r5oPOQ+jsEocGIVXo7J54s9gLjH6LeVFalO
	 3+/j7+jDcv7djU1fEAXpnUY5FIRbPuc/tXDU5U03tx0Jzywyw+5QBGKRytQSgPFUeo
	 T415aoBssmXzlquiGSbIy+qgu21aGvcAUtt4vhpak7BCWTQk5ozYqeBzGl9N108OKc
	 r7F9LHaV5X8/g==
Subject: Re: [PATCH net-next v4 2/2] net: stmmac: dwmac-socfpga: mask
 XGMAC_TSIE during cross-timestamp
From: netdev-bot+sashiko@kernel.org
To: zxyan0222@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, richardcochran@gmail.com,
 maxime.chevallier@bootlin.com, muhammad.nazim.amirul.nazle.asmade@altera.com,
 rohan.g.thomas@altera.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 04 Sep 2026 01:17:18 +0000
Message-ID: <178848463816.4131868.6619682657776561531@kernel.org>
In-Reply-To: <20260902131441.322167-3-zxyan0222@gmail.com>
References: <20260902131441.322167-3-zxyan0222@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 0

- [High] The fix does not close the race it claims to close: masking
  XGMAC_INT_EN.TSIE does not prevent the destructive read of…
- [Medium] Series ordering leaves a knowingly broken intermediate commit
  and an undocumented backport dependency.
- [Medium] The new mask/unmask pair in smtg_crosststamp() is neither
  state-preserving nor nestable.

Pre-existing issues:
- [High] smtg_crosststamp() uses the aggregate TSIS bit as its completion
  condition without ever clearing it before arming the snapshot, and…

--

net: stmmac: dwmac-socfpga: mask XGMAC_TSIE during cross-timestamp

This masks the XGMAC timestamp interrupt enable bit (XGMAC_TSIE) around the
auxiliary snapshot trigger and FIFO read in smtg_crosststamp(), and restores
it on the -EINVAL, timeout and success return paths.  The stated goal is to
keep the DWXGMAC2 timestamp interrupt handler from clearing TSIS while the
poll loop in smtg_crosststamp() is waiting for it.

No Link: tags are present in the commit header.

Before the diff, a couple of notes about the commit message and the series
ordering.

[Severity: Medium]

The commit message says:

  "Once XGMAC_TSIE is unmasked (done by a companion change that enables it
  in XGMAC_INT_DEFAULT_EN)"

Could that companion change be named explicitly?  The preceding commit in
this series, f4fbb4b15db4 ("net: stmmac: dwxgmac2: add XGMAC timestamp
interrupt support"), is the one that adds XGMAC_TSIE to
XGMAC_INT_DEFAULT_EN (at the baseline the macro is only
(XGMAC_LPIIE | XGMAC_PMTIE)).

That ordering means a bisect that lands on f4fbb4b15db4 alone has Agilex5
PTP_SYS_OFFSET_PRECISE failing with the exact message quoted here.  Since
f4fbb4b15db4 fixes a user-visible problem on its own, it looks like a
plausible stable backport candidate, and neither commit carries a Fixes: or
dependency tag.

Reversing the order does not help either, because the exit paths added here
unconditionally set XGMAC_TSIE, which would enable it on trees where the
default mask deliberately omits it.  Would folding this masking into
f4fbb4b15db4 (or at minimum adding "Fixes: f4fbb4b15db4" and naming the
dependency) be preferable?

Separately, the driver already has a generic mechanism for this exact
problem: STMMAC_FLAG_INT_SNAPSHOT_EN together with priv->tstamp_busy_wait,
as used by intel_crosststamp() in dwmac-intel.c.  Could the commit message
explain why a second, platform-private mechanism is added instead of reusing
that one?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index 1d7f0a57d288..a4d00bf81423 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -310,6 +310,13 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
>  	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
>  		return -EBUSY;
>  
> +	/* The XGMAC timestamp interrupt handler clears TSIS by reading
> +	 * XGMAC_TIMESTAMP_STATUS, which would race with the TSIS poll
> +	 * below.  Mask XGMAC_TSIE for the duration of the cross-timestamp
> +	 * so the handler does not run while we own the snapshot FIFO.
> +	 */
> +	stmmac_mac_irq_modify(priv, XGMAC_TSIE, 0);
> +

[Severity: High]

Does masking XGMAC_TSIE actually stop the read that clears TSIS?

dwmac-socfpga does not set STMMAC_FLAG_MULTI_MSI_EN, so Agilex5 runs the
legacy shared handler, and the dispatch to the timestamp callback is not
gated on TSIS or on XGMAC_INT_EN:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_interrupt() {
	...
	stmmac_common_interrupt(priv);
	...
}

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_common_interrupt() {
	...
	stmmac_timestamp_interrupt(priv, priv);
	...
}

drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:dwxgmac2_timestamp_interrupt() {
	ts_status = readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);
	...
}

The clear-on-read of XGMAC_TIMESTAMP_STATUS is the first statement of
dwxgmac2_timestamp_interrupt(), before the STMMAC_FLAG_EXT_SNAPSHOT_EN early
return.  Since stmmac_common_interrupt() is reached on every device
interrupt, including ordinary RX/TX DMA completions, wouldn't any interrupt
during the up-to-10 ms readl_poll_timeout() window still clear TSIS and make
the poll return -ETIMEDOUT with the same "Wait for time sync operation
timeout" message?

There is a second consumer of the same clear-on-read register that no
interrupt mask can affect:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_get_tx_hwtstamp() {
	...
	} else if (!stmmac_get_mac_tx_timestamp(priv, priv->hw, &ns)) {
	...
}

drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:dwxgmac2_get_mac_tx_timestamp() {
	if (readl_poll_timeout_atomic(ioaddr + XGMAC_TIMESTAMP_STATUS,
				      value, value & XGMAC_TXTSC, 100, 10000))
	...
}

That runs from the TX completion path whenever TX hardware timestamping is
enabled, which is the configuration in which cross-timestamping is used.

Two smaller points on the same mechanism.  There is no synchronize_irq()
after the mask, so a handler already in flight on another CPU still performs
the destructive read.  And dwxgmac2_core_init() writes the whole enable mask
directly:

drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:dwxgmac2_core_init() {
	...
	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
	...
}

which now includes XGMAC_TSIE and bypasses hw->irq_ctrl_lock, so it can
re-enable TSIE inside the masked window.

Would gating the destructive read in software (an ownership flag, as the
Intel path does with STMMAC_FLAG_INT_SNAPSHOT_EN), or keying completion off
the persistent ATSNS count rather than the transient TSIS bit, replace this
approach rather than extend it?

>  	mutex_lock(&priv->aux_ts_lock);
>  	/* Enable Internal snapshot trigger */
>  	acr_value = readl(ptpaddr + PTP_ACR);
> @@ -329,6 +336,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
>  		break;
>  	default:
>  		mutex_unlock(&priv->aux_ts_lock);
> +		stmmac_mac_irq_modify(priv, 0, XGMAC_TSIE);
>  		return -EINVAL;
>  	}
>  	writel(acr_value, ptpaddr + PTP_ACR);

[Severity: Medium]

Is the restore actually a restore?  The acquire in smtg_crosststamp() does
not sample XGMAC_INT_EN, and dwxgmac2_irq_modify() in dwxgmac2_core.c is a
plain read-modify-write with no notion of a previous value or of nested
owners:

drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:dwxgmac2_irq_modify() {
	...
	value = readl(int_mask) & ~disable;
	value |= enable;
	...
}

All three release sites here (this -EINVAL path, the timeout path and the
success path) unconditionally set XGMAC_TSIE.  If TSIE was deliberately
masked when smtg_crosststamp() was entered, does this callback silently
force it back on, so dwxgmac2_timestamp_interrupt() starts running and
consuming XGMAC_TIMESTAMP_STATUS on a configuration that never asked for it?

>  	/* Clear FIFO */
>  	acr_value = readl(ptpaddr + PTP_ACR);
>  	acr_value |= PTP_ACR_ATSFC;
>  	writel(acr_value, ptpaddr + PTP_ACR);
>  	/* Release the mutex */
>  	mutex_unlock(&priv->aux_ts_lock);
> @@ -353,6 +361,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
>  	ret = readl_poll_timeout(priv->ioaddr + XGMAC_INT_STATUS, v,
>  				 (v & XGMAC_INT_TSIS), 100, 10000);
>  	if (ret) {
> +		stmmac_mac_irq_modify(priv, 0, XGMAC_TSIE);
>  		netdev_err(priv->dev, "%s: Wait for time sync operation timeout\n",
>  			   __func__);
>  		return ret;

[Severity: Medium]

Related to the point above: can a second concurrent caller end the first
caller's masked window here?

priv->aux_ts_lock is dropped right after the FIFO clear, well before this
poll, and the PTP chardev does not serialize the callback:

drivers/ptp/ptp_chardev.c:ptp_ioctl() {
	...
	case PTP_SYS_OFFSET_PRECISE:
	case PTP_SYS_OFFSET_PRECISE2:
		return ptp_sys_offset_precise(ptp, argptr,
					      ptp->info->getcrosststamp);
	...
}

ptp_sys_offset_precise() -> stmmac_getcrosststamp() ->
get_device_system_crosststamp() -> smtg_crosststamp(), and no FMODE_WRITE is
required.  If two threads issue PTP_SYS_OFFSET_PRECISE at the same time,
thread B's unconditional stmmac_mac_irq_modify(priv, 0, XGMAC_TSIE) on its
timeout or success path re-arms the interrupt while thread A is still inside
this poll.  Would sampling XGMAC_INT_EN and restoring exactly that value, or
serializing the whole cross-timestamp sequence, address both this and the
force-enable case?

>  	}
> @@ -375,6 +384,8 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
>  		read_unlock_irqrestore(&priv->ptp_lock, flags);
>  	}
>  
> +	stmmac_mac_irq_modify(priv, 0, XGMAC_TSIE);
> +
>  	get_smtgtime(priv->mii, SMTG_MDIO_ADDR, &smtg_time);
>  	system->cycles = smtg_time;
>  

[Severity: High]

This isn't a bug introduced by this patch, but while looking at the TSIS
poll: can smtg_crosststamp() return 0 without ever writing *device?

TSIS is set by any MAC timestamp-module event, as the new handler from the
preceding commit itself documents:

drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:dwxgmac2_timestamp_interrupt() {
	/* ... TX timestamp polling may have already cleared TSIS
	 * and AUXTSTRIG, so rely on ATSNS instead. */
	...
}

smtg_crosststamp() flushes only the aux snapshot FIFO via PTP_ACR_ATSFC and
never reads XGMAC_TIMESTAMP_STATUS to drain a stale or foreign TSIS.
readl_poll_timeout() evaluates its condition on the first read, so a TSIS
latched by an unrelated event satisfies the poll immediately, possibly
before the auxiliary snapshot is latched.  Then:

	num_snapshot = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK,
				 readl(ioaddr + XGMAC_TIMESTAMP_STATUS));

	for (i = 0; i < num_snapshot; i++) {
		read_lock_irqsave(&priv->ptp_lock, flags);
		stmmac_get_ptptime(priv, ptpaddr, &ptp_time);
		*device = ns_to_ktime(ptp_time);
		read_unlock_irqrestore(&priv->ptp_lock, flags);
	}
	...
	return 0;

With num_snapshot == 0 the loop body, which is the only writer of *device,
never runs, yet the function returns 0.  ptp_sys_offset_precise() zeroes its
crosststamp struct:

drivers/ptp/ptp_chardev.c:ptp_sys_offset_precise() {
	struct system_device_crosststamp xtstamp = { .clock_id = CLOCK_REALTIME };
	...
	ts = ktime_to_timespec64(xtstamp.device);
	...
}

so userspace gets a device timestamp of 0 paired with a real system time and
a success return.  The latched snapshot also stays in the FIFO with ATSEN
still set until the next invocation's FIFO clear.

Would reading XGMAC_TIMESTAMP_STATUS once before arming to clear a stale
TSIS, and treating num_snapshot == 0 as an error rather than success, be the
right shape here?  Note that the masking added by this patch removes one of
the consumers that would otherwise have drained a stale TSIS, and it keeps
TSIS rather than the persistent ATSNS count as the completion condition.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902131441.322167-1-zxyan0222%40gmail.com
