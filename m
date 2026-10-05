Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C88F86341;
	Mon,  5 Oct 2026 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791162610; cv=none; b=nWww0gqSeX/pw6uEhTJAJfcwwh7pAyKcGv+c9IWh/IwHQ2ff/aY0RUEP4XF76aAQ/qzKYV6czgHAVR5gkNFv3I3sqOtc2Swome3bLE6Z0FjGIrchBPumace4/ywfD6QrCWmuM27L8eIs42ngXZ2UCCmkNUTcy+54rCFErc+Nkag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791162610; c=relaxed/simple;
	bh=a9vRoSfDoLAc96gkUFMiowur8QjndyDDdSB2V06rnP0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S5VjLUdRXzAbWtVecHOns3zp92hL+KMDBgyXq2y325d78l/BwO2CgZ2XyWaSSfqnkGymgZkdBDGEGZdqqY1hkjvPCLJsX7RaWCuR2pIpmXUUqYEK4QNBRI8z4bomLO1WnPXv8dMvZ2Y2sqz3CBFN4iAJRRiZ9Bv4yyepdD59FOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTQPchdI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTQPchdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1721F00893;
	Mon,  5 Oct 2026 01:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791162605;
	bh=gdJhy+e0MUiA+f8+eBKAoH176JeVs2mlZYY5fMDr8M8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QTQPchdI7q4KewspF4Tl6U0GjuvTN5XoYsGN7DDtF0v7WchQ4lNp5hscFLVciX0Qc
	 LhruxPRpdualbXSlLjNBcrOXiPdUHrEz5M5UKf06M5qzY/oiJsLBMLYgm5QWfof/4/
	 Jnv0sLy39w2MkOmsq/Jo7jY1+bfl8ZJHTlz1sGZGqsiGqoUyaZs2T9K47PeIuQMefH
	 Hngt1zwirgGpHUzxRUiFtNnxAu2aDVs+FxsW+65A8v4VvhC2SOz+56rwX9ggGO3uST
	 m5s6H0EbMesteA+FH54LfpjGIiRl+el4C5ddeVNuzIfTrrIeBDBqDwnTjCblj7HmzL
	 XTaZZPgGevUkw==
Subject: Re: [PATCH net-next v11 10/13] dpll: sit9531x: implement output pin
 state on a DPLL
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 01:10:04 +0000
Message-ID: <179116260402.434549.6445320171946602725@kernel.org>
In-Reply-To: <20260930233714.87679-11-arouhi@sitime.com>
References: <20260930233714.87679-11-arouhi@sitime.com>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Possible NULL pointer dereference during device teardown, in
  sit9531x_dpll_output_pin_state_on_dpll_set()…
- [Medium] sit9531x_dpll_output_pin_state_on_dpll_set() (dpll.c:822-831)
  has no short-circuit when the requested state is already in place.
- [Medium] A state change can go unannounced when the read-back fails.

--

dpll: sit9531x: implement output pin state on a DPLL

This commit adds state_on_dpll_get/set callbacks for output pins. Muting
forces the slot's Hi-Z override bits inside the PRG_CMD programming
sequence, and un-muting releases the override. It also starts registering
output pins that are routed to a given PLL.

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index a576d918e68db..ac2d977d36f7d 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -751,10 +751,112 @@ sit9531x_dpll_output_pin_frequency_set(const struct dpll_pin *pin,

[ ... ]

> +static int
> +sit9531x_dpll_output_pin_state_on_dpll_set(const struct dpll_pin *pin,
> +					   void *pin_priv,
> +					   const struct dpll_device *dpll,
> +					   void *dpll_priv,
> +					   enum dpll_pin_state state,
> +					   struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +	bool was_enabled, changed;
> +	int rc;
> +
> +	mutex_lock(&sitdev->multiop_lock);
> +
> +	was_enabled = sitdev->out[dpin->id].enabled;
> +
> +	switch (state) {
> +	case DPLL_PIN_STATE_CONNECTED:
> +		rc = sit9531x_output_enable(sitdev, dpin->id);
> +		break;
> +	case DPLL_PIN_STATE_DISCONNECTED:
> +		rc = sit9531x_output_disable(sitdev, dpin->id);
> +		break;

[Severity: Medium]
Should there be an early return when the request matches the current state?

dpll_pin_state_set() in drivers/dpll/dpll_netlink.c passes every request on
without checking it:

	ret = ops->state_on_dpll_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
				     dpll, dpll_priv(dpll), state, extack);

That means a CONNECTED request on an output that is already driving still
runs the whole sequence:

sit9531x_output_enable()
    sit9531x_prg_enter()       <- unlocks the output loops, enters PRG_CMD
    sit9531x_output_hiz_write() <- clears MASK on every Hi-Z pair
    sit9531x_prg_commit()      <- UPDATE_NVM, LOOP_LOCK, msleep(100)

All of this runs with multiop_lock and the core's dpll_lock held.

Other paths in this driver skip no-op requests. If the registers already
hold the value, sit9531x_output_phase_adjust_set() skips the rewrite. The
INTSYNC source setter added later in the series skips same-state requests,
with the comment "the core forwards a request for the state the pin is
already in". This output setter is still the same at the end of the
series.

Could this setter check sitdev->out[dpin->id].enabled and state_stale, and
return early when there is nothing to change?

Also, the commit message calls the mute a per-output control that "leaves
the divider alone". It doesn't mention that every request runs the
device-wide programming sequence above.

> +	default:
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +	changed = sitdev->out[dpin->id].enabled != was_enabled;

[Severity: Medium]
Can a state change go unannounced when the read-back fails?

Say the Hi-Z writes and sit9531x_prg_commit() succeed, but
sit9531x_output_forced_hiz() fails. Then sit9531x_output_disable() and
sit9531x_output_enable() leave enabled as it was and return the read
error:

	} else {
		sitdev->out[index].state_stale = true;
		if (!rc)
			rc = state_rc;
	}

Because changed is computed from enabled alone, it is false here and no
notification goes out. The core doesn't notify on error either, from
dpll_pin_state_set():

	if (ret)
		return ret;
	__dpll_pin_change_ntf(pin);

sit9531x_dpll_changes_check() skips output pins. The refresh in
sit9531x_dpll_output_pin_state_on_dpll_get() updates the cache but doesn't
notify anyone.

The comment below says a failed request that changed the output "still has
to be announced, or subscribers keep the old state for good". When
state_stale is set, the mute has most likely landed.

Should state_stale count as a possible change here? Alternatively, the
later refresh could announce the new state if it differs from the cached
one.

> +
> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	if (rc) {
> +		NL_SET_ERR_MSG(extack, "Failed to set output pin state");
> +		/*
> +		 * The core notifies only a request that succeeded, and the
> +		 * poll does not watch outputs.  A failed request whose
> +		 * read-back shows the output did change still has to be
> +		 * announced, or subscribers keep the old state for good.
> +		 * The core's lock is held here, as the helper requires.
> +		 */
> +		if (changed)
> +			__dpll_pin_change_ntf(dpin->dpll_pin);

[Severity: High]
Can dpin->dpll_pin be NULL here if the device is being torn down?

sit9531x_dpll_pin_unregister() clears the field before dpll_lock is taken.
Its comment says callbacks test this field to tell a pin on its way out
from a live one:

	pin->dpll_pin = NULL;

	dpll_pin_unregister(sitdpll->dpll_dev, dpll_pin, ops, pin);

dpll_pin_pre_doit() holds dpll_lock across this callback. Meanwhile,
sit9531x_output_enable() and sit9531x_output_disable() spend more than
100 ms in I2C transfers and the msleep(100) in sit9531x_prg_commit().
During that window the remove path can clear dpin->dpll_pin and then
block on dpll_lock.

Suppose the request then fails with changed set, for example because the
UPDATE_NVM write fails but the read-back shows the new Hi-Z bits. NULL is
then passed to __dpll_pin_change_ntf(), which dereferences it straight
away:

	dpll_pin_notify(pin, pin->clock_id, DPLL_PIN_CHANGED);

The oops would leave dpll_lock held. The blocked unregister and every
later DPLL netlink request would then hang.

Would it be safer to use the pin argument the core passes to this
callback, which stays valid until dpll_pin_unregister() returns? Another
option is to read dpin->dpll_pin once and skip the notification when it is
NULL.

> +	}
> +
> +	return rc;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930233714.87679-1-arouhi%40sitime.com
