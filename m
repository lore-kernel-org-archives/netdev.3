Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B92D6E72;
	Mon,  5 Oct 2026 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791162603; cv=none; b=nb5kbrRae0uicz7mCEMCvyqglRapO2msE8T+QKMW+Hzgdvm27zq7YSTlM3jBCaBXhNNDQAhQoVVC74arcG5pcsgcM+agfkiowEFRv3WFCT4BHBGMbFmO69uqDaupjM7I+V9v4iiipWBMGAyXfb+ad8YJQ/m7Zqh0IWASccRftBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791162603; c=relaxed/simple;
	bh=ggc/BZ/42nuB0BOrbkociS/ti6FPHHV1iNAEJkTO3+A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ttqZipEtbJ1tzcNR4NoHW7m2MVLDc9ytWtNsO541rR07fJitHhStbz0NrcTVcFL8eqx56yvHqfH9+2TiMUVb05VV4+/kMHnhWTupqlkqV0+6GnlfrGFjMW5tyhUn6bpTaiGvkRqj6SuZGWQCIukHxNJh4tNV9qGBBZQdv3um0SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNkbd+bR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNkbd+bR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8963F1F00893;
	Mon,  5 Oct 2026 01:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791162600;
	bh=Q4Mo8AkEW4VsvK79EQt8cr82gpUgit+TVyHDLNZQvnc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JNkbd+bRqd6RcCthsrjgxrmRV52A/hXHe6r1lkISdUi68aQZm86VCkccE0zqhncc2
	 9xtnu3wco2EbiuLhQesE7JacoXCKDu2vf4Ev7pToILI9BD+l+x77L12NeC7yQRzohN
	 e8SA07hkTX2fQKBvK+qQMxea06i2ecf0flwAt2c8AW2wGeDdINzMN9fXoyhOoccnys
	 PL6OnLUJaU3lOO0jWuMh5rhQpdOEttcARQeKZMR4iSIyBqWVgbqCH7FJh9ObVOo7Gs
	 Mf3I/RlWL+tAmbrk5v4lhzMN0ZO5J+6ICtxQ7ubQ0JONuJJ6GCSWkFftOCnR8QEYKV
	 rzM0LnTSqDb6Q==
Subject:
 Re: [PATCH net-next v11 06/13] dpll: sit9531x: register DPLL devices and pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 01:09:59 +0000
Message-ID: <179116259911.434549.6587142199088743518@kernel.org>
In-Reply-To: <20260930233714.87679-7-arouhi@sitime.com>
References: <20260930233714.87679-7-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] sit9531x_dpll_mode_get() always returns DPLL_MODE_AUTOMATIC,
  and sit9531x_dpll_supported_modes_get() advertises only AUTOMATIC.
- [Medium] sit9531x_dpll_lock_status_get() tests chan->locked before
  chan->ho_freeze, so a PLL frozen in holdover whose outer-LOL bit is…
- [Low] sit9531x_dpll_changes_check() takes a first-poll baseline for
  pins (pin->seen) but not for the device lock status.
- [Low] Each 500 ms tick does roughly 100+ single-byte I2C transfers plus
  page-selector writes.

--

dpll: sit9531x: register DPLL devices and pins

This patch registers each of the four on-chip SiT9531x PLLs as a DPLL
device and adds the crystal as a permanently connected pin on each. The
lock status and mode callbacks read from a state cache that a kthread
worker refreshes every 500 ms; the INTRB interrupt can trigger a refresh
early, and the same worker sends the change notifications.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index c7c14442df922..bf6817b9d5656 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> +/*
> + * sit9531x_prio_table_read - read a PLL's priority-table source codes
> + * @srcs:	output array of SIT9531X_PRIO_MAX_SLOTS source codes
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
> +static int sit9531x_prio_table_read(struct sit9531x_dev *sitdev, u8 pll_idx,
> +				    u8 *srcs)
> +{
> +	u8 val, slot;
> +	int rc;
> +
> +	for (slot = 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {
> +		rc = sit9531x_read_u8(sitdev,
> +				      sit9531x_prio_reg(pll_idx, slot), &val);
> +		if (rc)
> +			return rc;
> +
> +		srcs[slot] = sit9531x_prio_slot_get(val, slot);
> +	}
> +
> +	return 0;
> +}

[Severity: Low]
Slots 2n and 2n+1 share one register, so sit9531x_prio_reg() returns the
same address on two consecutive iterations. Is it intended that 5 of the
6 priority registers are read twice, for every PLL, on every poll?

sit9531x_chan_state_fetch() calls this once per PLL from the 500 ms poll.
It also re-reads the chip-global page 0 bytes for each of the four PLLs:

    rc = sit9531x_read_u8(sitdev, SIT9531X_REG_OUTER_LOL_STATUS,
                          &outer_lol);
    ...
    rc = sit9531x_read_u8(sitdev, SIT9531X_REG_PLL_INNER_LOL_STATUS,
                          &inner_lol);
    ...
    rc = sit9531x_read_u8(sitdev, SIT9531X_REG_HO_FREEZE_STATUS,
                          &ho_freeze);

Add the per-input force/state reads and the 8 W1C writes in
sit9531x_clear_notifications(), and each tick comes to roughly 100 or
more single-byte transfers plus page-selector writes. These move between
the PLL page, page 0 and page 1.

At 100 kHz that keeps a bus, which may be shared, busy about 10% of the
time. The input-monitor reads added later in the series raise this
further.

Could each priority register be read once, and the global status bytes
once per tick? That would remove about 30 transfers per tick.

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> new file mode 100644
> index 0000000000000..924386aec4d88
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -0,0 +1,389 @@

[ ... ]

> +sit9531x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,

[ ... ]

> +	if (!chan->active) {

[ ... ]

> +	} else if (chan->inner_lol) {

[ ... ]

> +		*status = chan->ho_freeze ? DPLL_LOCK_STATUS_HOLDOVER :
> +					    DPLL_LOCK_STATUS_UNLOCKED;
> +	} else if (chan->mode) {

[ ... ]

> +		*status = DPLL_LOCK_STATUS_UNLOCKED;
> +	} else if (chan->locked) {
> +		/*
> +		 * HO_ACQ is locked *and* holdover memory acquired, so it needs
> +		 * the holdover-valid bit rather than following from the lock.
> +		 */
> +		if (chan->ho_valid)
> +			*status = DPLL_LOCK_STATUS_LOCKED_HO_ACQ;
> +		else
> +			*status = DPLL_LOCK_STATUS_LOCKED;
> +	} else if (chan->ho_freeze) {
> +		*status = DPLL_LOCK_STATUS_HOLDOVER;
> +	} else {
> +		*status = DPLL_LOCK_STATUS_UNLOCKED;
> +	}

[Severity: Medium]
Can a PLL that is frozen in holdover be reported as LOCKED here?

chan->locked is tested before chan->ho_freeze, and
sit9531x_chan_state_fetch() reads the two independently:

    chan->locked = active && !(outer_lol & BIT(pll_idx));
    ...
    chan->ho_freeze = !!(ho_freeze & BIT(pll_idx));

If the holdover freeze bit is set while the outer LOL bit is still
clear, this returns LOCKED or LOCKED_HO_ACQ instead of HOLDOVER.

The pin-state contract later in this file treats that combination as
possible: L is "chan->locked && !chan->mode && !chan->ho_freeze". The
inner_lol branch above also checks ho_freeze first, so the two branches
use different precedence.

Later in the series, sit9531x_prio_table_commit() forces holdover through
PLL reg 0x6F bit 4. The "implement input pin state on a DPLL" patch also
leaves a PLL in forced holdover indefinitely when its last input is
removed.

If outer LOL stays clear during forced holdover, would the device report
a lock while no pin reports ACTIVE? The ordering is still the same at the
end of the series.

Should the ho_freeze test come before the locked test?

> +static int
> +sit9531x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
> +		       enum dpll_mode *mode, struct netlink_ext_ack *extack)
> +{
> +	*mode = DPLL_MODE_AUTOMATIC;
> +
> +	return 0;
> +}
> +
> +static int
> +sit9531x_dpll_supported_modes_get(const struct dpll_device *dpll,
> +				  void *dpll_priv, unsigned long *modes,
> +				  struct netlink_ext_ack *extack)
> +{
> +	__set_bit(DPLL_MODE_AUTOMATIC, modes);
> +
> +	return 0;
> +}

[Severity: Medium]
Is DPLL_MODE_AUTOMATIC the right value for a PLL whose profile sets
manual active select? sit9531x_manual_sel_report() detects PLL_CONFIG1F
bit 6 at probe, but only warns:

    "PLL%c: the profile selects its reference manually, ... it is
    reported as automatic\n"

The uAPI defines the reported value as:

    * @DPLL_MODE_AUTOMATIC: highest prio input pin auto selected by dpll

On those boards userspace is told the PLL picks the highest-priority
input, but the PLL actually follows a fixed manual selection.

With no .mode_set, the core already refuses mode changes. For a PLL where
sit9531x_manual_sel_report() found bit 6 set, could mode_get report
DPLL_MODE_MANUAL and supported_modes_get list only MANUAL?

The commit message explains the choice but does not compare it with this
read-only option. The behaviour is the same at the end of the series.

[ ... ]

> +	if (sitdpll->lock_status != lock_status ||
> +	    sitdpll->lock_status_error != status_error) {
> +		sitdpll->lock_status = lock_status;
> +		sitdpll->lock_status_error = status_error;
> +		dpll_device_change_ntf(sitdpll->dpll_dev);
> +	}

[Severity: Low]
The pin loop below takes a first-poll baseline through pin->seen, but
this device-level comparison has no baseline. sit9531x_dpll_alloc()
starts the cached value as a placeholder:

    sitdpll->lock_status = DPLL_LOCK_STATUS_UNLOCKED;

sit9531x_dev_start() registers the DPLLs, so the create notification
already carries the real state from sit9531x_dev_state_fetch(). It then
queues the worker with delay 0.

Won't the first tick send a dpll_device_change_ntf() for every PLL that
is locked or in holdover, even though nothing changed? That seems to
contradict "the first tick takes the baseline" in the commit message.
This is the same at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930233714.87679-1-arouhi%40sitime.com
