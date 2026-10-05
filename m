Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167F92DC331;
	Mon,  5 Oct 2026 01:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791162613; cv=none; b=Ra6PfEDd9FSCmLqCq7zN09jZ8n61WvsX5KfI28Fe86yljt6n6E2a/s1BL/LqJua6TWOhAUr/q1wp5Td6zKVFzlDNm64bqOwvIpvSCpp8KHhjfGGWLJ0U26r7BV8wJ+ZQH0687YBu26BDGgbqo2eYPPRQrSM/ZFeOVoJJOMngges=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791162613; c=relaxed/simple;
	bh=qYkKLjJYL+jOHWnEo+6fzD24LkjtHtW4j2EUIOou0Z8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rIRGyWCM4u//7qjAdE8hUcl2ZifavwtK2pmxdalSsIHg55Yr6p+rWxelV07OZnnVERcby03bNcEpYOgO//GVMn+4LEF4jUDLZyZTIUXsGMa91R9Zyq5iPODd02MtQMEyO0hn2I/keYZt9J1ghFLhMyxw+wYM8f5Qoxd6/HQE5Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFE18Rdj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFE18Rdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3327D1F000FF;
	Mon,  5 Oct 2026 01:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791162611;
	bh=yJac6bB2/RSUQt7vTaLq50zwkDeAFCjOH7s/jENmRqI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PFE18RdjoMIHg3R2chjK/9iOQ42G/OvvHhRJSWXPnJAGY9GQPq+VMljxUJz78X8QC
	 VWJ26D+6BPsWyL0FSgXnIbYLzp8ch2B5cyNGuk0T/pBPRhBO00WSwa73HgkUC2KkYI
	 MN2rUee7nSKcueDLLH273tCjNv0Sq0GF41t8mzp+lNaNZ3UThSE3QG0m/iostp44ko
	 RbK8++d9khNofu7iKdVcb5aABGZqubYdFPu1/Fvsv9OfpLw+d9YxKx7bLS+Agjz1uB
	 1Z/vklJNO6YjDcqvpzBNFvbCHuhAE8KqwG42IBpan9n8OzYYp6fZtryBUfP73i2GkF
	 gkwkHFUPIy9eg==
Subject: Re: [PATCH net-next v11 13/13] dpll: sit9531x: model the inter-PLL
 sync net as a pair of pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 01:10:09 +0000
Message-ID: <179116260977.434549.11247923823182031360@kernel.org>
In-Reply-To: <20260930233714.87679-14-arouhi@sitime.com>
References: <20260930233714.87679-14-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 5 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The INTSYNC destination pin reports operstate STANDBY even
  when no PLL drives the net.
- [Medium] sit9531x_dpll_intsync_src_state_on_dpll_set() never sends a
  pin-change notification when a request fails but the cached ownership,…
- [Medium] sit9531x_intsync_disable() jumps to restore_global on any
  failure and sets SIT9531X_INTSYNC_EN_BIT again, whichever step failed.
- [Medium] A failed enable followed by a failed rollback and a failed re-
  detect leaves the net marked unowned while it is configured.
- [Medium] restore_global in sit9531x_intsync_disable() writes
  SIT9531X_INTSYNC_EN_BIT back into page-0 reg 0x40 but does not issue…
- [Low] A partially configured source looks exactly like a fully
  connected one.
- [Low] INTSYNC ownership is not re-detected on resume.

--

dpll: sit9531x: model the inter-PLL sync net as a pair of pins

This commit models the internal INTSYNC net as two DPLL pins. The source
PLL gets an output pin that drives the net, and each destination PLL gets
an input pin that selects the net by priority. The commit also adds the
register sequences that enable and disable inter-PLL sync, and it detects
the current source at probe.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 45baa703aa45b..6b607f3d5fc31 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -2760,6 +2760,338 @@ int sit9531x_clear_notifications(struct sit9531x_dev *sitdev)

[ ... ]

> +int sit9531x_intsync_src_detect(struct sit9531x_dev *sitdev)
> +{

[ ... ]

> +		} else if (n_en && n_dis &&
> +			   n_en + n_dis == ARRAY_SIZE(intsync_config) &&
> +			   partial < 0) {
> +			/*
> +			 * Every register holds one of the two patterns and both
> +			 * occur: the residue of an enable or a disable that
> +			 * stopped part way, and nothing a profile writes.
> +			 */
> +			partial = pll;
> +		}
> +	}
> +
> +	/*
> +	 * A disable that stopped part way leaves a PLL holding a mix of the
> +	 * two patterns.  Treat it as the owner, so that a repeated disconnect
> +	 * on that PLL runs the disable again and another PLL cannot be
> +	 * enabled on top of the leftover configuration.
> +	 */
> +	if (src < 0 && partial >= 0) {
> +		dev_warn(sitdev->dev,
> +			 "PLL%c holds a partial INTSYNC source configuration\n",
> +			 'A' + partial);
> +		src = partial;
> +	}

[Severity: Low]
Once this runs, is there any way to tell a half-configured source from a
fully connected one?

Suppose a DISCONNECTED on the owning PLL writes the first dis_val and then
fails on a later write. restore_global sets the global bit again. This
code then sees the mixed pattern and records the PLL as intsync_src.

After that, sit9531x_dpll_intsync_src_state_on_dpll_get() reports
CONNECTED. But the page-0 small update earlier in the disable has already
latched the global enable off.

A later CONNECTED on the same PLL hits this check in
sit9531x_dpll_intsync_src_state_on_dpll_set():

	if (sitdev->intsync_src == sitdpll->id)
		break;

It returns success without running the enable sequence again. Does the
configuration ever get completed in that case?

Another DISCONNECTED does run the disable again, so this state can be
recovered from.

[ ... ]

> +err_disable:
> +	/*
> +	 * The global enable is already set at this point.  The caller only
> +	 * records the source PLL when this function succeeds, so nothing
> +	 * else will ever clear the bit: undo it here rather than leave the
> +	 * net asserted with a half-written EXT page.
> +	 */
> +	{
> +		int rollback_rc;
> +
> +		rollback_rc = sit9531x_intsync_disable(sitdev, src_pll_idx);
> +		if (rollback_rc)
> +			dev_warn(sitdev->dev,
> +				 "INTSYNC rollback failed after enable error: %d (original %d)\n",
> +				 rollback_rc, rc);
> +	}

[Severity: Medium]
What happens to the cached owner if this rollback also fails?

Start with intsync_src == -1. The enable latches the global bit, writes
all eight en_val registers, and then fails in sit9531x_pll_small_update().
The rollback disable returns at once if its first read fails:

	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);
	if (rc)
		return rc;

That leaves the global bit and the EXT enable pattern in place. The caller
does not update the cache because rc != 0. If
sit9531x_intsync_src_detect() then also fails its first read, intsync_src
stays at -1. Only probe and the setter call detect, so nothing corrects it
later.

When the bus recovers, a DISCONNECTED on this PLL returns 0 without any
cleanup, because intsync_src != id. A CONNECTED on another PLL passes the
intsync_src >= 0 check and programs a second source.

Isn't this the case the setter's comment says it has to prevent ("a cache
that wrongly says nobody drives the net would let a second PLL be
configured to drive it")?

[ ... ]

> +int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx)
> +{

[ ... ]

> +	/* Small update on source PLL */
> +	rc = sit9531x_pll_small_update(sitdev, src_pll_idx);
> +	if (rc)
> +		goto restore_global;

[Severity: Medium]
If only this last step fails, should restore_global still set the global
bit again?

By this point the page-0 small update has latched the cleared bit, and
all eight registers hold dis_val. restore_global below sets
SIT9531X_INTSYNC_EN_BIT again anyway.

sit9531x_dpll_intsync_src_state_on_dpll_set() leaves the cache alone
because rc != 0, but it then calls sit9531x_intsync_src_detect(). Since
the global bit is set, detect scans the EXT pages. This PLL shows
n_dis == 8 and n_en == 0. That matches neither the full pattern nor the
partial one, so intsync_src becomes -1.

A retried DISCONNECTED then hits this check:

	if (sitdev->intsync_src != sitdpll->id)
		break;

It returns 0 without touching hardware, even though the PLL small update
that applies the disable values never ran. A CONNECTED on another PLL
also gets past the -EBUSY check and enables INTSYNC on top of this state.

Doesn't that go against the restore_global comment, which says the state
stays "one the driver can describe and the request can be repeated"?

The same restore also seems to undo the rollback in
sit9531x_intsync_enable(). Suppose the enable fails at its page-0 small
update or at the EXT unlock, so err_disable calls
sit9531x_intsync_disable(). If that disable then fails at its global
write or its page-0 update, restore_global sets the bit err_disable was
meant to clear.

The EXT page then holds no enable pattern, so detect reports no owner.
The global enable stays asserted, and the driver has no owner on record
that would ever clear it.

> +
> +	goto relock;
> +
> +restore_global:
> +	/*
> +	 * The global enable was cleared first, so a failure here leaves the
> +	 * EXT page still holding the enable pattern with nothing pointing
> +	 * at it: the source detector keys on the global bit, would report
> +	 * the net as unowned, and a retry of the disable would then
> +	 * short-circuit.  Put the bit back so the state stays one the
> +	 * driver can describe and the request can be repeated.
> +	 */
> +	if (!sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val))
> +		sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,
> +				  val | BIT(SIT9531X_INTSYNC_EN_BIT));

[Severity: Medium]
Does this write need a page-0 small update after it?

The enable and disable sequences both follow their write to
SIT9531X_REG_INTSYNC_GLOBAL with this:

	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
			       SIT9531X_SMALL_UPDATE_CMD);

That suggests the bit only takes effect once the update runs.
restore_global writes the bit back without one.

Suppose the disable fails after its page-0 update has latched the cleared
bit, for example at the EXT unlock, at any dis_val write, or at the PLL
small update. The active configuration then has INTSYNC off, while the
register reads back as on.

sit9531x_intsync_src_detect() trusts that readback. With a mixed EXT
pattern it records this PLL as the owner, so the SYNCOUT pin reports
CONNECTED while nothing drives the net.

Later, an unrelated priority-table change on any PLL ends in
sit9531x_prio_prg_commit(), which also writes SIT9531X_REG_GLOBAL_UPDATE.
Could that latch the pending bit and turn inter-PLL sync back on over a
half-written EXT page, without anyone requesting it?

The enable rollback goes through the same restore path.

This assumes the global register is a shadow that the small update
latches. The driver's own sequences imply that, but I haven't checked it
against the datasheet.

[ ... ]

> @@ -3379,6 +3711,15 @@ static int sit9531x_dev_state_fetch(struct sit9531x_dev *sitdev)
>  		return rc;
>  	}
>  
> +	mutex_lock(&sitdev->multiop_lock);
> +	rc = sit9531x_intsync_src_detect(sitdev);
> +	mutex_unlock(&sitdev->multiop_lock);
> +	if (rc) {
> +		dev_err(sitdev->dev,
> +			"Failed to detect INTSYNC source: %d\n", rc);
> +		return rc;
> +	}

[Severity: Low]
Should INTSYNC ownership also be detected again on resume?

sit9531x_intsync_src_detect() has two callers: this probe-time call and
the SYNCOUT setter. The poll does not call it, and sit9531x_resume()
only does this:

	sit9531x_page_cache_drop(sitdev);
	if (sitdev->irq > 0)
		enable_irq(sitdev->irq);
	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);

The driver already allows for a part that loses power across suspend.
Suppose PLL A was the source, and the device reloads a profile with
INTSYNC disabled or sourced from another PLL. intsync_src stays A.

In that case:

- A's SYNCOUT pin still reports CONNECTED.
- A CONNECTED on A returns success without programming anything.
- A CONNECTED on another PLL fails with -EBUSY.
- A's INTSYNC destination pin is forced to DISCONNECTED.

A DISCONNECTED on A does run the disable and then detect, which refreshes
the cache.

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 6bf4efd3c6334..52d5b1a6e36f7 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c

[ ... ]

> @@ -772,8 +786,259 @@ sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,

[ ... ]

> +static int
> +sit9531x_dpll_intsync_src_state_on_dpll_set(const struct dpll_pin *pin,

[ ... ]

> +	if (changed && !rc)
> +		sitdev->intsync_src = state == DPLL_PIN_STATE_CONNECTED ?
> +				      sitdpll->id : -1;
> +
> +	/*
> +	 * Re-scan hardware after a transition so the cache follows a
> +	 * partially failed enable or disable as closely as possible.
> +	 */
> +	if (changed)
> +		detect_rc = sit9531x_intsync_src_detect(sitdev);

[ ... ]

> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	if (rc && rc != -EBUSY && rc != -EINVAL && rc != -EOPNOTSUPP)
> +		NL_SET_ERR_MSG(extack, "Failed to set INTSYNC source state");
> +
> +	return rc;
> +}

[Severity: Medium]
If the request fails but this re-scan moves intsync_src, what sends the
pin change notification?

The core only notifies after a successful set in dpll_pin_state_set().
sit9531x_dpll_changes_check() skips outputs, and that includes the
INTSYNC source:

	 * Outputs (incl. the INTSYNC source) change only through their
	 * own set callback and the XO is permanently connected.

On a failed request, the re-scan can still change what the getter
reports. Two examples:

- An enable fails and its rollback disable stops part way. That leaves a
  mixed pattern, so detect records this PLL as the partial owner. The pin
  goes from DISCONNECTED to CONNECTED.
- A disable fails at its final step. That leaves an all-dis pattern, so
  detect sets -1. The pin goes from CONNECTED to DISCONNECTED.

In both cases rc != 0, and no notification is sent.

sit9531x_dpll_output_pin_state_on_dpll_set() already handles this case:

	if (rc) {
		NL_SET_ERR_MSG(extack, "Failed to set output pin state");
		...
		if (changed)
			__dpll_pin_change_ntf(dpin->dpll_pin);
	}

Without the same handling here, won't subscribers keep the stale SYNCOUT
state?

[ ... ]

> +static int
> +sit9531x_dpll_intsync_dst_operstate_on_dpll_get(const struct dpll_pin *pin,
> +						void *pin_priv,
> +						const struct dpll_device *dpll,
> +						void *dpll_priv,
> +						enum dpll_pin_operstate *state,
> +						struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +
> +	mutex_lock(&sitdev->multiop_lock);
> +	sit9531x_dpll_selection_operstate_get(sitdev, sitdpll,
> +					      SIT9531X_INTSYNC_PIN_ID,
> +					      state);
> +	mutex_unlock(&sitdev->multiop_lock);

[Severity: Medium]
Will this report STANDBY even when no PLL drives the net?

sit9531x_dpll_selection_operstate_get() only returns NO_SIGNAL or
QUAL_FAILED for physical inputs:

	if (pin_id < sitdev->info->num_inputs) {
		ref = sit9531x_ref_state_get(sitdev, pin_id);
		if (ref->los) {
			*operstate = DPLL_PIN_OPERSTATE_NO_SIGNAL;
	...
	*operstate = DPLL_PIN_OPERSTATE_STANDBY;

So INTSYNC falls through to STANDBY whenever it is not ACTIVE. The driver
knows when the net is undriven (sitdev->intsync_src < 0), but this getter
doesn't check it.

The dpll uAPI defines standby as "pin is qualified but not actively used
by the DPLL". When the source PLL disconnects, every PLL that lists
INTSYNC loses that reference, yet its INTSYNC pin still reports STANDBY.
sit9531x_dpll_changes_check() uses the same helper, so no notification
goes out either.

The commit message says a destination pin "behaves like any other
selectable input". The state getter comment also compares an undriven net
to "a momentary LOS on an external reference", and for a physical input,
LOS gives NO_SIGNAL.

Should the destination pin report NO_SIGNAL when intsync_src < 0?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930233714.87679-1-arouhi%40sitime.com
