Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465797;
	b=vL0zIXcgknCFgBDnvCWdfpP26vZ9Jc7nnlOhZMUdxFEOkct2K7cPL87jPG2cuJ1OJOAX
	 zhgllkXnBr7mm4uuaf+CoE6BTWFVdBZ2yx7d02XKhe2ttxr9nw4Eo2NU1fAzeRDYIyv3Z
	 3/XV7DDVVQDhn7zhjc/q9VIUz2taF4VSudY+C3qod9scQmx5DW2oQ2s2XcnMte3qZcuzc
	 Hhw0VVFSwC2iba1StC3Txswzo2Gt9JMqFjlveuKeEqy5rwaMq2Dd0qO8hbIeLH7YSfr5o
	 1NnQiywxe0pkztMwuw/axEbdj1Yx7BS2iqwLz0sxfFCzsgwn9FLyvbaburYnVKoAb+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465797;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XR8fieUdSHu2uzkq6NIVdkHb1+L3O7crv85PsrzZ8Kc=;
	b=xqyx7/l3UwZjdLGYsmL/fzU17j4DZxugYC7fwbx7JBvD5pARjfU1uf2Xy8+1bALFgd6h
	 OiScZXwLHpnww6+lxZpq8+z61kE523xkj6xfK8B5mlLhdaUZ0bIb76QQKMIiilF/w4cgi
	 bRnv9Gvl55yuXTMU22Z6KZXNsi5S3QKEdx8lB4hyl+EZ0zKCqw4BF0fYbUF9zR6eBBjC4
	 1kpQYK9g0TmoYWJnRXntQzmnon3uBi65jfS3ejeBkCCyqMVAMUw3gigIuXfSILengr2vT
	 mi0GmcuxOhYRz47evA1qxnVGre7sW2tSEaz3UIJdhaS1TVFbNAsG0f1EO68bt0kfnIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1vjVUdt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BC6606B560;
	Tue, 20 Oct 2026 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1vjVUdt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287FD1F000CF;
	Tue, 20 Oct 2026 03:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792465796;
	bh=XR8fieUdSHu2uzkq6NIVdkHb1+L3O7crv85PsrzZ8Kc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B1vjVUdty1PrPTCgVV7a5T+s4mj/nlmt1leDEgOUa2+/Sd4fAAxyFru+zmCGzMS9a
	 rL2GYSEC20nis6KEXaxhh70CfT7kj9TeSZ5EL9N9sF8HbzejPp7cVzyxN8BWlA5CQs
	 tXrji2mkuJ7BBOnusQoweAwiF+eeyLrY741SjE9E7DwOyUcwltQYk16RxrM3EQXNhv
	 xVpfV9BNXyu7PtslHqqt9XYubmN0y+XQHol3UDqVabqi4i+v4UyTAPPy2JWaEclyHl
	 jRkYgxyPZ4/OLyS/e4oVPSeBBxzlC5jwRitT5KAfqvbXSqPWtDfpbyUP6N0Rqh3PQn
	 dRwzCdCffYH1g==
Subject: Re: [PATCH net-next v14 12/12] dpll: sit9531x: model the inter-PLL
 sync net as a pair of pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 03:09:54 +0000
Message-ID: <179246579471.3135.7046906484988525421@kernel.org>
In-Reply-To: <20261016005823.13690-13-arouhi@sitime.com>
References: <20261016005823.13690-13-arouhi@sitime.com>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 5 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In sit9531x_intsync_src_detect()
  (drivers/dpll/sit9531x/core.c), the global INTSYNC enable (page 0 reg…
- [Medium] sit9531x_resume() (drivers/dpll/sit9531x/core.c) re-reads
  INTSYNC ownership (intsync_src/intsync_partial) and every output's…
- [Medium] This patch defines an undriven INTSYNC net as having no
  signal: sit9531x_dpll_selection_no_signal() makes the destination pin…
- [Medium] sit9531x_intsync_src_detect() returns 'no owner'
  (intsync_src=-1, partial=false) as soon as the global INTSYNC bit…
- [Medium] sit9531x_dpll_intsync_src_state_on_dpll_set() forces a
  partial-owner record only after a failed CONNECTED.
- [Low] If sit9531x_intsync_src_detect() fails during sit9531x_resume(),
  intsync_src and intsync_partial keep their pre-suspend values and…
- [Low] The pin-state contract comment in drivers/dpll/sit9531x/dpll.c
  defines predicate N as 'the input lane's clock monitor reports loss of…

--

dpll: sit9531x: model the inter-PLL sync net as a pair of pins

This patch models the INTSYNC net as two pins: an output (source) pin on
the PLL that drives the net, and an input (destination) pin on each PLL
that can select it. It adds enable and disable sequences for the source
configuration and a scan that detects the current owner, including a
partial one. On resume it reads INTSYNC ownership and the output mutes
back from the part.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 10609d46a7e1a..7de6584acea96 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> +int sit9531x_intsync_src_detect(struct sit9531x_dev *sitdev)
> +{

[ ... ]

> +	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &global);
> +	if (rc)
> +		return rc;
> +
> +	if (!(global & BIT(SIT9531X_INTSYNC_EN_BIT))) {
> +		sitdev->intsync_src = -1;
> +		sitdev->intsync_partial = false;
> +		return 0;
> +	}

[Severity: Medium]
Can this early return hide a source configuration that the new error
paths leave behind?

Say sit9531x_intsync_enable(X) writes every en_val byte and then
sit9531x_pll_small_update() fails. The rollback runs
__sit9531x_intsync_disable(X, false), which clears and latches the global
bit. If the EXT unlock or the first dis_val write then fails, it jumps to
restore_global, which does nothing when restore is false. X's EXT page
still holds the enable pattern, but the global bit is clear.

A disconnect can end in the same state: its dis_val write fails, and then
the restore read or write fails too.

The re-scan in sit9531x_dpll_intsync_src_state_on_dpll_set() then
succeeds and returns intsync_src = -1, so the partial-owner fallback does
not fire:

	if (changed && rc && state == DPLL_PIN_STATE_CONNECTED &&
	    (detect_rc || sitdev->intsync_src == sitdpll->id)) {

A later CONNECTED on PLL Z passes the -EBUSY check. Its
sit9531x_intsync_enable(Z) sets the global bit, which also re-activates
the leftover pattern on X.

The next scan matches both PLLs and keeps the lower index, with only a
warning. If X < Z, intsync_src becomes X even though Z's request
succeeded.

After that, Z's source pin reads DISCONNECTED and a DISCONNECTED on Z is
a no-op. SELECTABLE on Z's own INTSYNC destination is no longer refused
either. Would that let Z select the net it drives?

This also seems to contradict the commit message:

  "A source that failed to take the net over ... is recorded as a
  partial owner"

A profile that leaves the global bit clear with an enable pattern in an
EXT page would hit the same case at probe or resume.

[ ... ]

> +	rc = sit9531x_pll_small_update(sitdev, src_pll_idx);
> +
> +	goto relock;
> +
> +restore_global:

[ ... ]

> +	if (restore &&
> +	    !sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val) &&
> +	    !sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,
> +			       val | BIT(SIT9531X_INTSYNC_EN_BIT))) {
> +		/*
> +		 * Every write of the global enable, here and in SiTime's
> +		 * sequences, is followed by the page-0 small update that
> +		 * applies it.  Without it the bit would sit pending until
> +		 * an unrelated commit through the same update register
> +		 * applied it, re-asserting the net over a half-written
> +		 * EXT page with nobody having asked.
> +		 */
> +		sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
> +				  SIT9531X_SMALL_UPDATE_CMD);
> +		usleep_range(1000, 2000);
> +	}

[Severity: Medium]
What happens if this GLOBAL_UPDATE write fails? Its return value is
ignored, so the enable bit can stay pending. The comment above says that
state re-asserts the net when some unrelated commit goes through the same
update register.

In that case the re-scan in sit9531x_dpll_intsync_src_state_on_dpll_set()
reads the pending global bit and the untouched EXT pattern. It records a
complete owner even though the gate is off.

The commit message says "the restore is latched as every other write to
that register is", but a failure of that latch is not checked.

The final step has a similar problem. Suppose the disable writes every
dis_val byte and only sit9531x_pll_small_update() fails, and the re-scan
then also hits a read error. The cache still holds intsync_src == this
PLL with intsync_partial == false, so the source pin reports CONNECTED
while the net is off.

The partial-owner handling in the setter only covers failed connects:

	if (changed && rc && state == DPLL_PIN_STATE_CONNECTED &&

In both cases, would a later CONNECTED on this PLL take this path and
return success without running the enable?

		if (was_connected)
			break;

The periodic poll does not refresh ownership either.

[ ... ]

> @@ -4894,8 +5278,35 @@ static int sit9531x_suspend(struct device *dev)
>  static int sit9531x_resume(struct device *dev)
>  {
>  	struct sit9531x_dev *sitdev = dev_get_drvdata(dev);
> +	int rc;
> +	u8 i;
>  
>  	sit9531x_page_cache_drop(sitdev);

[ ... ]

> +	mutex_lock(&sitdev->multiop_lock);
> +	rc = sit9531x_intsync_src_detect(sitdev);
> +	if (rc)
> +		dev_warn(sitdev->dev,
> +			 "INTSYNC source not re-detected on resume: %d\n", rc);
> +	sitdev->intsync_stale = rc != 0;
> +	for (i = 0; i < sitdev->info->num_outputs; i++) {
> +		rc = sit9531x_output_state_refresh(sitdev, i);
> +		if (rc) {
> +			dev_warn(sitdev->dev,
> +				 "Output %u mute state not read on resume: %d\n",
> +				 i, rc);
> +			sitdev->out[i].state_stale = true;
> +		}
> +	}
> +	mutex_unlock(&sitdev->multiop_lock);

[Severity: Medium]
Are pin-change notifications needed here? This rewrites intsync_src,
intsync_partial and out[].enabled from the hardware. It does not compare
them with the previous values and does not notify anyone.

The poll won't catch the change either, because
sit9531x_dpll_changes_check() skips all but the selection pins:

		if (!sit9531x_dpll_is_selection_pin(pin))
			continue;

The comment on sit9531x_dpll_is_selection_pin() says outputs, including
the INTSYNC source, "change only through their own set callback". The
new source setter also says "the poll does not watch this pin".

The part may lose power across suspend and come back with a different
INTSYNC owner or different output mutes. PIN_GET would then report the
new state, while netlink subscribers keep the pre-suspend state.

> +
>  	if (sitdev->irq > 0)
>  		enable_irq(sitdev->irq);
>  	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);

[Severity: Low]
If sit9531x_intsync_src_detect() failed above, intsync_src and
intsync_partial keep their pre-suspend values and only intsync_stale is
set.

The poll queued here does not call sit9531x_dpll_intsync_refresh(), but
it still reads those fields:

sit9531x_dpll_changes_check()
  sit9531x_dpll_pin_snapshot()
    if (id == SIT9531X_INTSYNC_PIN_ID && sitdev->intsync_src == sitdpll->id)
    sit9531x_dpll_selection_operstate_get()
      sit9531x_dpll_selection_no_signal()

Would the poll then compute and store the destination pin state and
operstate from the stale owner?

If the stale result matches the baseline, no notification goes out. Once
a netlink GET refreshes the cache, the next tick would send a
notification that contradicts the earlier state.

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index dc8d84133b72b..9826adb353c95 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c

[ ... ]

> +static bool
> +sit9531x_dpll_selection_no_signal(struct sit9531x_dev *sitdev, u8 pin_id)
> +{
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (pin_id == SIT9531X_INTSYNC_PIN_ID) {
> +		/*
> +		 * The driver knows the net is driven when it enabled the
> +		 * source itself or found the configuration it would have
> +		 * written.  A profile can drive the net with a configuration
> +		 * of its own; then a PLL the device feeds from the net and
> +		 * holds locked is the evidence that the net carries a signal.
> +		 */
> +		if (sitdev->intsync_src >= 0 && !sitdev->intsync_partial)
> +			return false;
> +		return !sit9531x_dpll_intsync_tracked(sitdev);
> +	}

[Severity: Low]
This isn't a bug, but the pin-state contract comment earlier in dpll.c
still says:

 *   ...  The INTSYNC destination
 *   has no monitor, so N and Q never hold for it.

With this change N can hold for INTSYNC. In that case
sit9531x_dpll_selection_operstate_get() reports
DPLL_PIN_OPERSTATE_NO_SIGNAL where the contract predicts STANDBY. Should
the comment be updated?

[ ... ]

> +	switch (state) {
> +	case DPLL_PIN_STATE_CONNECTED:

[ ... ]

> +		if (was_connected)
> +			break;
> +		if (sitdev->intsync_src >= 0 &&
> +		    sitdev->intsync_src != sitdpll->id) {
> +			NL_SET_ERR_MSG(extack,
> +				       "INTSYNC is already sourced by another PLL");
> +			rc = -EBUSY;
> +			break;
> +		}

[ ... ]

> +		rc = sit9531x_intsync_enable(sitdev, sitdpll->id);
> +		changed = true;
> +		break;
> +	case DPLL_PIN_STATE_DISCONNECTED:
> +		if (sitdev->intsync_src != sitdpll->id)
> +			break;
> +		rc = sit9531x_intsync_disable(sitdev, sitdpll->id);
> +		changed = true;
> +		break;

[Severity: Medium]
How does this handle a net that a profile drives with its own EXT page
values? sit9531x_dpll_selection_no_signal() above says that can happen.

In that case sit9531x_intsync_src_detect() finds the global bit set but
no PLL matching intsync_config, and it ends with:

	sitdev->intsync_src = src;

where src is still -1. Every source pin then reports DISCONNECTED while
the net is driven.

A CONNECTED on any PLL passes the -EBUSY check above, because the check
only looks at intsync_src >= 0. sit9531x_intsync_enable() then writes a
second source configuration on top of the profile's.

A DISCONNECTED on any PLL takes the intsync_src != sitdpll->id break and
returns 0 without touching the hardware. dpll_pin_state_set() still
sends a change notification for the success.

If the PLL the driver enabled is disconnected later, the shared global
bit is cleared. That also cuts off the profile's source.

The commit message says setting the source pin "takes the net over or
gives it up", but for a profile-driven net it seems to do neither.
Should a set global bit with no recognised pattern be treated as busy, or
as an unknown owner?

[ ... ]

> +	case DPLL_PIN_STATE_SELECTABLE:
> +		if (sitdev->intsync_src == sitdpll->id) {
> +			NL_SET_ERR_MSG(extack,
> +				       "PLL cannot lock to the INTSYNC it drives");
> +			rc = -EINVAL;
> +			break;
> +		}
> +		rc = sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);
> +		break;

[Severity: Medium]
Can this move a PLL onto an undriven INTSYNC net? For reporting, this
patch treats an undriven net as having no signal. The selector that
writes the active reference still treats INTSYNC as always live:

drivers/dpll/sit9531x/core.c:sit9531x_prio_src_live() {
	u8 index = sit9531x_hw_src_input(src);

	if (index >= sitdev->info->num_inputs)
		return true;
	...
}

Nothing here checks that any PLL drives the net. With no source pin
connected, a user can give INTSYNC a higher priority than a healthy
external input and set it SELECTABLE. Then:

sit9531x_input_prio_add()
  sit9531x_prio_table_apply()
    sit9531x_prio_table_commit()
      sit9531x_prio_activesel_pick()
        sit9531x_prio_top_live()

picks INTSYNC as the active selection. The comment on
sit9531x_prio_activesel_pick() says that a selection naming a dead source
means the next table write "sends the PLL back to it and it unlocks".
Would the PLL lose lock here?

This path was not reachable before, because the INTSYNC destination pin
was not registrable.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016005823.13690-1-arouhi%40sitime.com
