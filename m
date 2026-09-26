Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B23F369D6E;
	Sat, 26 Sep 2026 02:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390095; cv=none; b=c7OyLQj+0w5EFRYWo1YyKVdyJqQqc79vqeyXKCGTDwnoUdoF/ktHHiyzAryNwPavwFS+DvyUeOvNiSdVYJox5Yozjws9YtacpCq6ykhHemtBiJM7Y323hm37Sb1DufGuq3j+XzEKVPGCAtT91BC8J20un252nWpxpchj63z/xbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390095; c=relaxed/simple;
	bh=LP/HcGuuG/sc7i12UhTs5NRfPLlnDGg6wiEcAbmI1zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exZm8Vt+4V2USrH7buOeaswWT6NMFFnLk6hHts++v3FyPimyIcTZMjjosmfmfkyaBLYE+Ax2/I317xA7lVjokeZzPbJHG+rJ4sFSllq2eqr0J9JFggoJIW/SXtKeAsVNIniEr4A5nFpwt43TyEzln1n1QOojNX8qDHRQ0WdvJ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoBs0LjT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoBs0LjT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253321F000FF;
	Sat, 26 Sep 2026 02:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790390090;
	bh=vDzV+BSqx/gcv6Qv6NAX83L7eKw0Np7mdvQYR2deVzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IoBs0LjTdVvOT79W1kctUXYL+QiP47V/8gR7FL/0o60zIFzhswLtgFm0F+g9AkXr0
	 QCMxXxoBGkAFPzygaZp7We9G0d/VS0ipugtBq8Stqp7Bxyt6OX0C42vxjpnIHjseV7
	 g0FoAnH9P4GjyC3d9YDpemW+Y5+aHLwZ3EsxmKHYjUbuSjlXvhFfNeWzJu+PZH2pO6
	 RkRndRIFNdEGPxERGtO3PO5vgkX6dtp/CyGerz6MCWyFMoWHfpiottcBW7WZcJMSk7
	 Ab85eRDnmOD3bItZf2uZqA0rrTkE/PZNWIpG+POEEBKiQMkmKvya2mEbtQxPnnxCpM
	 1hIdGJgAJItfw==
From: Jakub Kicinski <kuba@kernel.org>
To: arouhi@sitime.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	ivecera@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cjubran@nvidia.com,
	pabeni@redhat.com,
	Oleg.Zadorozhnyi@devoxsoftware.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	dev@kael-k.io,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 09/14] dpll: sit9531x: implement output pin state on a DPLL
Date: Fri, 25 Sep 2026 19:34:49 -0700
Message-ID: <20260926023449.1567870-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201108.42676-10-arouhi@sitime.com>
References: <20260921201108.42676-10-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dpll: sit9531x: implement output pin state on a DPLL

This adds state_on_dpll_get/set callbacks for sit9531x output pins. An
output is muted or un-muted by forcing its pad through the Hi-Z mask/state
register pairs, on both the differential and the single-ended pair. It
also starts registering output pins, which were previously filtered out.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 0687ad6de861c..8daf0fbf67720 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> @@ -539,6 +580,190 @@ static int sit9531x_prg_commit(struct sit9531x_dev *sitdev)
>  	return rc2 ? rc2 : rc3;
>  }
>  
> +/*
> + * sit9531x_output_hiz_write - mute or unmute an output
> + *
> + * Muting takes control of the pin (MASK=1) and drives it low (STATE=0) on
> + * both the differential and the single-ended register pair, because the
> + * output must go quiet whichever way it is wired; unmuting hands it back
> + * to the device's own state machine.  The caller must already be in the
> + * programming state.
> + */

[Severity: Low]
This isn't a bug, but the comments added here don't agree on what a mute
does. This comment, and the header of sit9531x_output_forced_hiz(), say
muting "drives it low (STATE=0)". The register block comment above
sit9531x_output_get_hiz_regs() says:

 * STATE bit = 0 -> output is forced to Hi-Z (muted)

sit9531x_output_disable() ("force Hi-Z"), the @enabled kerneldoc ("not
forced into Hi-Z") and sit9531x_dpll_output_pin_state_on_dpll_set()
("forces Hi-Z") also describe Hi-Z. Is the pad driven low or Hi-Z?

The comments also disagree on what un-muting restores.
sit9531x_output_enable() says releasing MASK returns the output "to whatever
the initial_config blob programmed". The set callback in dpll.c says "back
to factory default". If the blob set MASK itself, which the
sit9531x_output_forced_hiz() header allows for, clearing MASK doesn't
restore what the blob programmed.

In dpll.c, the set callback comment mentions "the Page 0x03 force/state
register pair" (singular), but the code writes both the DIFF and the SE
pairs. The get callback comment says DISCONNECTED means "muted via
sit9531x_output_disable()". However, sit9531x_out_state_fetch() also
reports DISCONNECTED for a mute that the blob set.

> +static int sit9531x_output_hiz_write(struct sit9531x_dev *sitdev, u8 slot,
> +				     bool mute)
> +{
> +	struct sit9531x_hiz_regs r;
> +	int rc, undo_rc;
> +
> +	sit9531x_output_get_hiz_regs(slot, &r);
> +
> +	if (!mute) {
> +		rc = sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, false);
> +		if (rc)
> +			return rc;
> +
> +		return sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, false);
> +	}
> +

[ ... ]

> +	rc = sit9531x_hiz_set_bit(sitdev, r.diff_state, r.bit, false);
> +	if (rc)
> +		return rc;
> +	rc = sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, true);
> +	if (rc)
> +		return rc;
> +	rc = sit9531x_hiz_set_bit(sitdev, r.se_state, r.bit, false);
> +	if (rc)
> +		goto undo_diff;
> +	rc = sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, true);
> +	if (rc)
> +		goto undo_diff;
> +
> +	return 0;
> +
> +undo_diff:
> +	/*
> +	 * Only one half of the pair reached the device.  Release the
> +	 * override that did: that leaves the pad on the state the loaded
> +	 * configuration gave it, which is where the request started, rather
> +	 * than driven by half a mute that nothing afterwards clears.
> +	 */
> +	undo_rc = sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, false);

[Severity: High]
Can this rollback un-mute an output that was already muted?

undo_diff always clears the DIFF MASK bit. It never saves the DIFF
MASK/STATE bits the slot held on entry, so it can't restore them.

Take a differential output (cmos=false) that is already muted, with DIFF
MASK=1 and STATE=0. The mute can come from an earlier DISCONNECTED request
or from the loaded configuration; sit9531x_out_state_fetch() reports either
as DISCONNECTED. A repeated DISCONNECTED request then does this:

dpll_pin_state_set()
  sit9531x_dpll_output_pin_state_on_dpll_set()
    sit9531x_output_disable()
      sit9531x_prg_enter()
      sit9531x_output_hiz_write()
        DIFF state/mask writes succeed (no change)
        SE state or mask read/write fails
        undo_diff clears DIFF MASK
      sit9531x_prg_commit()         <- applies MASK=0
      sit9531x_output_forced_hiz()  <- enabled = true

The request returns an error, but the pad has gone from muted to driving.

Nothing blocks this path. dpll_pin_state_set() forwards every request
without comparing it with the current state. Neither
sit9531x_dpll_output_pin_state_on_dpll_set() nor sit9531x_output_disable()
checks out[index].enabled first.

The same happens if the loaded configuration forced the pad driven (MASK=1,
STATE=1). The undo leaves MASK=0 and STATE=0, which is not where the
request started.

The comment above says the pad is left "where the request started". The v10
notes say this releases "the half that reached the device when the other did
not". Do either of these hold when MASK was already set on entry?

On a differential output the SE pair doesn't control the pad. Even so, a
failure on the SE pair releases the DIFF override that does control it.

Would it work to snapshot the original DIFF MASK/STATE bits before the
writes and restore them here, instead of clearing MASK unconditionally?

> +	if (undo_rc)
> +		dev_err(sitdev->dev,
> +			"slot%u: Hi-Z override left half applied (%d)\n",
> +			slot, undo_rc);
> +
> +	return rc;
> +}

[ ... ]

> +int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index)
> +{

[ ... ]

> +	rc = sit9531x_output_hiz_write(sitdev, slot, true);

[ ... ]

> +	ret = sit9531x_prg_commit(sitdev);
> +	if (ret && !rc)
> +		rc = ret;
> +
> +	/*
> +	 * Keep the software state aligned to what hardware now drives even
> +	 * when one write in the sequence failed. The commit above may have
> +	 * applied a partial mask/state combination.
> +	 */
> +	state_rc = sit9531x_output_forced_hiz(sitdev, index, &muted);

[Severity: Low]
This isn't a bug, but the header of sit9531x_output_forced_hiz(), which
this function and sit9531x_output_state_refresh() now use for their
read-back, still says:

 * it low (STATE bit clear).  Either register pair muting the slot counts,
 * mirroring what sit9531x_output_disable() programs.

The body reads only one pair, chosen by sitdev->out[out_idx].cmos. Its own
inline comment rejects the either-pair approach.

Take a differential output where the SE half of a mute landed and the DIFF
half did not. The header predicts muted, but the body returns not muted.

Could the header be updated to match the body?

[ ... ]

> +int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index)
> +{

[ ... ]

> +	rc = sit9531x_output_hiz_write(sitdev, slot, false);

[ ... ]

> +	ret = sit9531x_prg_commit(sitdev);
> +	if (ret && !rc)
> +		rc = ret;
> +
> +	/* See sit9531x_output_disable(): commit can apply part of it. */
> +	state_rc = sit9531x_output_forced_hiz(sitdev, index, &muted);
> +	if (!state_rc) {
> +		sitdev->out[index].enabled = !muted;
> +		sitdev->out[index].state_stale = false;
> +	} else {

[ ... ]

> +	}
> +
> +	return rc;
> +}

[Severity: Medium]
Is a state change that lands on the hardware during a failed request ever
announced to netlink subscribers?

Take a muted differential output. sit9531x_output_hiz_write() can clear
DIFF MASK and then fail on the SE mask read or write. prg_commit() still
runs, and the read-back above sets enabled = true and state_stale = false.
The original error is still returned.

dpll_pin_state_set() then returns before sending the notification:

	ret = ops->state_on_dpll_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
				     dpll, dpll_priv(dpll), state, extack);
	if (ret)
		return ret;
	__dpll_pin_change_ntf(pin);

The periodic sit9531x_dpll_changes_check() doesn't catch it later either,
because it skips output pins:

		if (!sit9531x_dpll_is_input_pin(pin) ||
		    sit9531x_dpll_is_xo_pin(pin))
			continue;

The same gap applies to the un-mute caused by the undo_diff rollback in
sit9531x_output_disable(). It also applies to a DISCONNECTED request whose
rollback write failed as well.

Wouldn't subscribers keep seeing the old pin state indefinitely, while the
hardware and the driver's own cache report the new one?
