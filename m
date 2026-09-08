Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448B24B5CA2;
	Tue,  8 Sep 2026 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871523; cv=none; b=JoQ33seJ1qSq6Q/v5zZL/F6x2Q/2Jm1i8sk4gcNa+PAsDxgxK0oVxc1h2alhj6gzlv10ZHOR5ZxSkHFvBRea4rAvW1ZdyEM2mnJa7ENYds6KB9rCofCTwC8t55M/q6t+OybWvcnGMV2/zs/5/EgQk6Bv5gElgpnMLFZceduBJvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871523; c=relaxed/simple;
	bh=QYOWXz19o9E5ZhwYIRZHnj+UTpryOctRSpqLn6x2Qfw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxyFxn8AJIqB1dUkv6A3NXs0K97lxlMYNJUS43Bn8dvwHU3lP3aJp+tsT/zz0QNiiXY/vMES9DGmTt5YjkqbQ2G9gHwka1ExNHXSeiXqlw4Fo0Vi4axtu4QX/NIUe7u8YjhrswOnQYocQ//FzF4VRG+R+bLXSkJjIut/9K5OIHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJuDXXW4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJuDXXW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647081F00A3A;
	Tue,  8 Sep 2026 12:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871521;
	bh=0ZFyRXWQqOp7m0JjVb9Iy94cy0RvPUZKccfTTHE9SyA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UJuDXXW4GS4S0tH+3+cBOfr9dqd/ejfFnjq/U4Rb05Bysqq3YwYxo4E9bxynmVZzC
	 iFE/0qU7UPYbxYoh2BdcsmQyyGQZ0Tj1yqL4tcZ9IVo+ThruoyYe/AedD7NCkLHvT4
	 sJe8+nLCF0bH00t3AtppCWKmjM1hWvt2mJyxsyLw8FGVPkAg0w7RjFZ5QfCJ0l1fUD
	 d4YySlbW2ESDjtGrp5QLTiD2hMiMOYZCLQKkP5hhBQzjUl/bxmd6VN8vjZNBj/mVem
	 AQzGAxnG3+lxroelnoSpldgs0sC3xu+9h3/OaKGUacmanFOO0zthm3WO7nd7Aauhvc
	 dLHrtOpY6Yi5A==
Subject: Re: [PATCH net-next v8 09/15] dpll: sit9531x: implement output pin
 state on a DPLL
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 12:45:19 +0000
Message-ID: <178887151995.219967.3640152255355236600@kernel.org>
In-Reply-To: <20260902214030.20955-10-arouhi@sitime.com>
References: <20260902214030.20955-10-arouhi@sitime.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] The new `.state_on_dpll_get`/`.state_on_dpll_set` callbacks
  are installed into `sit9531x_dpll_output_pin_ops`, which…
- [Medium] `sit9531x_output_disable()` and `sit9531x_output_enable()`
  program the Page-0x03 Hi-Z force/state banks with a sequence of read-…
- [Low] The banner comment on `sit9531x_output_disable()`
  (drivers/dpll/sit9531x/core.c:409) states it "Sets MASK+STATE on BOTH…

--

dpll: sit9531x: implement output pin state on a DPLL

This adds .state_on_dpll_get / .state_on_dpll_set for output pins, mapping
CONNECTED and DISCONNECTED onto the Page 0x03 Hi-Z force/state register
pairs.  New core helpers sit9531x_output_enable() and
sit9531x_output_disable() wrap the register writes in the PRG_CMD / NVM
update / loop lock sequence and update the cached out[].enabled flag.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 721b2c451d59..0f886cfd1401 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> @@ -368,6 +402,115 @@ static int sit9531x_prg_commit(struct sit9531x_dev *sitdev)
>  	return rc ? rc : rc2;
>  }
>
> +/*
> + * sit9531x_output_disable - mute an output (force Hi-Z)
> + * @index:	logical output index (0..info->num_outputs-1)
> + *
> + * Sets MASK+STATE on BOTH the DIFF and SE register pairs so that the
> + * output is muted regardless of its electrical configuration.  The

[Severity: Low]
This isn't a bug, but does the banner describe the wrong polarity?  It says
MASK+STATE are set to mute, while the body sets MASK and clears STATE:

	/* Take control (MASK=1) and mute (STATE=0) on both DIFF and SE */
	rc = sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, true);
	...
	rc = sit9531x_hiz_set_bit(sitdev, r.diff_state, r.bit, false);

The register description above sit9531x_output_get_hiz_regs() agrees with the
body:

 * MASK bit = 1  -> driver takes control of that output's Hi-Z state
 * STATE bit = 0 -> output is forced to Hi-Z (muted)

and so does the reader sit9531x_output_forced_hiz():

	*muted = (mask & BIT(r.bit)) && !(state & BIT(r.bit));

Could the banner be reworded to say "sets MASK and clears STATE"?

> + * writes are wrapped in the PRG_CMD / NVM update / loop lock sequence
> + * so the new state is applied by the hardware.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
> +int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index)
> +{
> +	const struct sit9531x_chip_info *info = sitdev->info;
> +	struct sit9531x_hiz_regs r;
> +	u8 slot;
> +	int rc, ret;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (index >= info->num_outputs)
> +		return -EINVAL;
> +
> +	slot = info->clkout_map[index];
> +	sit9531x_output_get_hiz_regs(slot, &r);
> +
> +	rc = sit9531x_prg_enter(sitdev);
> +	if (rc)
> +		return rc;
> +
> +	/* Take control (MASK=1) and mute (STATE=0) on both DIFF and SE */
> +	rc = sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, true);
> +	if (rc)
> +		goto commit;
> +	rc = sit9531x_hiz_set_bit(sitdev, r.diff_state, r.bit, false);
> +	if (rc)
> +		goto commit;
> +	rc = sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, true);
> +	if (rc)
> +		goto commit;
> +	rc = sit9531x_hiz_set_bit(sitdev, r.se_state, r.bit, false);
> +
> +commit:
> +	/*
> +	 * Always leave the PRG_CMD programming state, even on a mid-sequence
> +	 * write failure: prg_enter() unlocked the output loops, so returning
> +	 * without prg_commit() would strand the chip in the programming state
> +	 * with the loops unlocked.  Best effort -- keep the first error.
> +	 */
> +	ret = sit9531x_prg_commit(sitdev);
> +	if (ret && !rc)
> +		rc = ret;
> +	if (!rc)
> +		sitdev->out[index].enabled = false;
> +
> +	return rc;
> +}

[Severity: Medium]
Can a partial register sequence here leave sitdev->out[index].enabled
permanently disagreeing with the hardware?

Suppose the diff_mask write succeeds and the diff_state write returns an I2C
error:

	rc = sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, true);	/* ok */
	if (rc)
		goto commit;
	rc = sit9531x_hiz_set_bit(sitdev, r.diff_state, r.bit, false);	/* -EIO */
	if (rc)
		goto commit;

MASK=1 with STATE still 0 from the loaded configuration is the muted encoding
per the register notes ("STATE bit = 0 -> output is forced to Hi-Z"), and
sit9531x_prg_commit() then issues UPDATE_NVM + LOOP_LOCK so the partial
programming is applied.  But rc is nonzero, so:

	if (!rc)
		sitdev->out[index].enabled = false;

is skipped and enabled stays true.

The mirror case in sit9531x_output_enable() is the same: if the diff_mask
clear succeeds and the se_mask clear fails, a DIFF-configured pad is already
released and driving while enabled stays false.

Is there anything that later reconciles the cache?  The hardware readback
sit9531x_output_forced_hiz() is reached only via sit9531x_out_state_fetch(),
whose only caller is sit9531x_dev_state_fetch() on the probe/start path:

	for (i = 0; i < sitdev->info->num_outputs; i++) {
		rc = sit9531x_out_state_fetch(sitdev, i);

The periodic worker refreshes only ref and chan state, and the new getter
reads only the cached flag, so the wrong state would be reported over netlink
for the life of the bound device.

Would it be better to record the intended state (or mark it unknown and
re-read the force/state registers) even when rc is nonzero?

> +
> +/*
> + * sit9531x_output_enable - un-mute an output (active state)
> + * @index:	logical output index (0..info->num_outputs-1)
> + *
> + * Releases MASK on BOTH register pairs so the output returns to
> + * whatever the initial_config blob programmed.  The writes are wrapped
> + * in the PRG_CMD / NVM update / loop lock sequence so the new state is
> + * applied by the hardware.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
> +int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index)
> +{

[ ... ]

> +	rc = sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, false);
> +	if (rc)
> +		goto commit;
> +	rc = sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, false);
> +
> +commit:

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index a7510ca721b6..6365a83e4c52 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -669,10 +669,79 @@ sit9531x_dpll_output_pin_frequency_set(const struct dpll_pin *pin,
>  	return rc;
>  }
>
> +/*
> + * sit9531x_dpll_output_pin_state_on_dpll_get - get output pin state
> + *
> + * reports CONNECTED when the output is driven and
> + * DISCONNECTED when it has been muted via sit9531x_output_disable().
> + */
> +static int
> +sit9531x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *pin,
> +					   void *pin_priv,
> +					   const struct dpll_device *dpll,
> +					   void *dpll_priv,
> +					   enum dpll_pin_state *state,
> +					   struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	const struct sit9531x_out *out;
> +
> +	out = sit9531x_out_state_get(sitdpll->dev, dpin->id);
> +	*state = out->enabled ? DPLL_PIN_STATE_CONNECTED
> +			      : DPLL_PIN_STATE_DISCONNECTED;
> +	return 0;
> +}

[Severity: Medium]
Does this read past sitdev->out[] for the internal INTSYNC source pin?

sit9531x_dpll_pin_ops_get() hands this ops table to every non-input pin, with
no id filtering:

	if (!sit9531x_dpll_is_input_pin(pin))
		return &sit9531x_dpll_output_pin_ops;

and sit9531x_dpll_pin_is_registrable() always registers a pin whose id is
SIT9531X_INTSYNC_OUT_PIN_ID:

	/* The internal INTSYNC source pin is always registrable */
	if (index == SIT9531X_INTSYNC_OUT_PIN_ID)
		return true;

core.h defines that id as the array size:

	#define SIT9531X_INTSYNC_OUT_PIN_ID	SIT9531X_MAX_OUTPUTS
	...
	struct sit9531x_out	out[SIT9531X_MAX_OUTPUTS];

so sit9531x_out_state_get(sitdev, 12) resolves to &sitdev->out[12], one
element past the end, and ->enabled is read from whatever follows in struct
sit9531x_dev (chan[0]).  That value is then reported to user space as the pin
state on every DPLL_CMD_PIN_GET dump.

> +
> +/*
> + * sit9531x_dpll_output_pin_state_on_dpll_set - mute/un-mute an output
> + *
> + * forces Hi-Z on the output pin via the Page 0x03
> + * force/state register pair.
> + *   CONNECTED    -> enable (release force, back to factory default)
> + *   DISCONNECTED -> disable (force Hi-Z)
> + */
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
> +	int rc;
> +
> +	mutex_lock(&sitdev->multiop_lock);
> +
> +	switch (state) {
> +	case DPLL_PIN_STATE_CONNECTED:
> +		rc = sit9531x_output_enable(sitdev, dpin->id);
> +		break;
> +	case DPLL_PIN_STATE_DISCONNECTED:
> +		rc = sit9531x_output_disable(sitdev, dpin->id);
> +		break;

The same pin reaches the setter with dpin->id == 12, which both helpers reject
because 12 >= info->num_outputs:

	if (index >= info->num_outputs)
		return -EINVAL;

yet sit9531x_pin_props_get() advertises that pin as changeable:

	} else if (dir == DPLL_PIN_DIRECTION_OUTPUT &&
		   index == SIT9531X_INTSYNC_OUT_PIN_ID) {
		...
		props->dpll_props.capabilities =
			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;

so user space is told the state can change but always gets -EINVAL.  Would it
make sense to route the INTSYNC source pin to its own ops table, or at least
bound-check dpin->id against info->num_outputs in the getter?

For what it is worth, a later patch in this series, "dpll: sit9531x: model the
inter-PLL sync net as a pair of pins", adds sit9531x_dpll_intsync_src_pin_ops
and dispatches the INTSYNC source pin to it in sit9531x_dpll_pin_ops_get(),
which removes both problems.  Could that dispatch be folded in here, or this
patch ordered after it, so no intermediate commit exposes the out-of-range
access?

> +	default:
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	if (rc)
> +		NL_SET_ERR_MSG(extack, "Failed to set output pin state");
> +
> +	return rc;
> +}
> +
>  static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops = {
>  	.direction_get		= sit9531x_dpll_output_pin_direction_get,
>  	.frequency_get		= sit9531x_dpll_output_pin_frequency_get,
>  	.frequency_set		= sit9531x_dpll_output_pin_frequency_set,
> +	.state_on_dpll_get	= sit9531x_dpll_output_pin_state_on_dpll_get,
> +	.state_on_dpll_set	= sit9531x_dpll_output_pin_state_on_dpll_set,
>  };

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902214030.20955-1-arouhi%40sitime.com
