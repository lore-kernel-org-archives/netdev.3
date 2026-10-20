Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465790;
	b=jRZE6MdhteRncNnoRT9cK6dadj1cHKwMJ/vptvXebyxuUh9t8o5C9y9qWdIxXhVS52NK
	 K9ReyySmq6WJbzmgv4Hj/Hlnr0FSCK0TpDpeqikqc6ARia+/OZamcCn+d/FlWZiAlCcTl
	 i84HAetqJrqFadEnToGKoBG2mdQpQksaIGJoT8DXf8Fywj3alnZLjuu0Eak6ZuPraUd6w
	 OYYL8UDBTkXvU+q5pAcl3NZJDvY/5716LMevgGDSlJuXSJATS1vStaIR7L8h+6xPNhTi1
	 r6ZUlO9/TbixYAn8bhMmzItoLTNh1Vc5aZH7sMEcUi2XAJzHYC25Cw2BmM1XRLzfRrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465790;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SqaPP4ar6ZB2kUgK4FajkhNFBtEOy1od96h6P6b1+1c=;
	b=Km3CSl9/YWcSlL9xYMFJ7M2pTW9ER9ooCJRY/L/l2RyUp8+HeGBybaaf892H82AmvbnK
	 E88o/ihGBB2KAKxQcQDUuehnR0MfviurdMtDd7dwYrGn2QZnB/pAkTMljiKbwtj9Gu01e
	 Q2iiVmwNm/rsALIS6bfo/1HrkNzY2C35DTaD/wrIfKvr+KbXPjH8TASUlnTN+ur4rImLY
	 Q4HIm22N6gVZ76DYd07483FcCrQ15/ozd/Pkm/9MEDkzPtSFLO3Gd+NjME14n97/yv/jZ
	 8wQhYTF++vS9GiLEEHvgTDQdXpZFfsgZiuMjRt+90eMqWgD9gCWjrn8wq19R8JemJqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2lV5bA5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6B7606AF47;
	Tue, 20 Oct 2026 03:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2lV5bA5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B9A1F000C5;
	Tue, 20 Oct 2026 03:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792465789;
	bh=SqaPP4ar6ZB2kUgK4FajkhNFBtEOy1od96h6P6b1+1c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q2lV5bA5PRtjX0f6PhS5KHzMeRVnenO5VWkk7Zv6YFHaD2ZnB6T74Yb1UgIioOtsx
	 BfI+dQ0FK148LHnwe6ax/UmSuUa9UMubQywvzYKvMfnbw3Dv+LcP6r5waVdASHhX+H
	 nWGAccju2S5TSqSO0dv00wB2WQo4t8nnyvEnmFTY3n4Ukj/sSSJ42k5kqzCjtjk3Ih
	 s7ZOz7dEqY32Ub/A65RPbq5YaOZx8Q5jzbp9ZuKYy8AR8X+yyoPne6QYOVaA756aiL
	 xfTw542IxTTg7dUoNu2gY4sAE1AF8Mq32B5LUgtswtiuScVbrW1FyMQWBwEthLm4HU
	 1TaxEhOh8PlMQ==
Subject: Re: [PATCH net-next v14 08/12] dpll: sit9531x: add support to get and
 set frequency on pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 03:09:48 +0000
Message-ID: <179246578818.3135.12199681757250727245@kernel.org>
In-Reply-To: <20261016005823.13690-9-arouhi@sitime.com>
References: <20261016005823.13690-9-arouhi@sitime.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Concern: this patch adds frequency_get and frequency_set to
  sit9531x_dpll_output_pin_ops (drivers/dpll/sit9531x/dpll.c) and an…
- [Low] Concern: sit9531x_dpll_pin_ops_get() (dpll.c) does not special-
  case the INTSYNC pins.
- [Low] In sit9531x_output_phase_flush() (core.c), each restore write in
  the cleanup paths (GPIO_FUNC_CTRL1 trigger-source restore, target…
- [Low] A comment in sit9531x_pin_props_get() (prop.c) says the seeded
  rate is published only after the last fallible step, because 'a call…
- [Low] sit9531x_output_divo_calc() (core.c:1862-1869) justifies its
  `frequency > U32_MAX` rejection by saying the DPLL core 'validates the…
- [Low] Concern: sit9531x_prg_abort() (core.c:503) issues LOOP_LOCK after
  a failed PRG_CMD entry without the 100 ms settle that…
- [Low] The output read-back in sit9531x_pin_props_get() (prop.c:335-338)
  ignores every error from sit9531x_output_freq_get(), not just -ENODATA.
- [Low] In sit9531x_prg_enter() (core.c:534-537), if the first write
  (SIT9531X_DEBUG_UNLOCK_VAL to SIT9531X_REG_OUTSYS_DEBUG) reports an…

--

dpll: sit9531x: add support to get and set frequency on pins

This adds frequency_get for sit9531x input pins, which report the rate
from firmware, and frequency_get/frequency_set for output pins.  An
output's rate is computed as Fvco / DIVO from the chip registers.  A set
programs a new DIVO inside the output programming state and then runs a
per-PLL phase flush.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index f3dbe949f219b..875a5fe783d5c 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -488,6 +488,140 @@ static int sit9531x_output_forced_hiz(struct sit9531x_dev *sitdev,

[ ... ]

> +static void sit9531x_prg_abort(struct sit9531x_dev *sitdev)
> +{
> +	int rc = -EIO;
> +	u8 attempt;
> +
> +	for (attempt = 0; attempt < SIT9531X_LOOP_LOCK_TRIES; attempt++) {
> +		rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
> +				       SIT9531X_LOOP_LOCK);
> +		if (!rc)
> +			break;
> +		usleep_range(1000, 2000);
> +	}
> +	if (rc)
> +		dev_err(sitdev->dev,
> +			"output loops left unlocked after a failed entry: %d\n",
> +			rc);
> +
> +	sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,
> +			  SIT9531X_DEBUG_LOCK_VAL);
> +}

[Severity: Low]
sit9531x_prg_abort() issues SIT9531X_LOOP_LOCK but does not wait out
the msleep(100) settling time that sit9531x_prg_commit() does.  The
commit message says:

  "issuing the commit without waiting would let the next request
  program a part that has not settled."

After a failed PRG_CMD entry, could the next request then program a
part that has not settled?

This path can't be reached at this commit, because output pins are not
registered yet.  The next patch, "dpll: sit9531x: implement output pin
state on a DPLL", removes sit9531x_prg_abort() and makes
sit9531x_prg_enter() call sit9531x_prg_commit() on a failed PRG_CMD
write.  Would it make sense to fold that change into this patch?

> +static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)
> +{
> +	int rc;
> +
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,
> +			       SIT9531X_DEBUG_UNLOCK_VAL);
> +	if (rc)
> +		return rc;

[Severity: Low]
If this first write reports an error, the function returns without
writing SIT9531X_DEBUG_LOCK_VAL back.

Elsewhere the patch assumes that a transfer which reported an error may
still have reached the part.  The PRG_CMD failure path just below makes
that assumption, and so do the DIVO rollback and the phase flush
restore.  On the same reasoning, can this path leave the output-system
debug key at the unlock value?

When sit9531x_prg_enter() fails, sit9531x_output_freq_set() returns
without calling sit9531x_prg_commit().  So nothing writes the lock value
back until the next programming sequence.  This is still the case at
the end of the series.

> +
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
> +			       SIT9531X_PRG_CMD_STATE);

[ ... ]

> @@ -1342,6 +1481,675 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,

[ ... ]

> +static int sit9531x_output_phase_flush(struct sit9531x_dev *sitdev, u8 pll_idx)
> +{

[ ... ]

> +	ret = sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, orig);
> +	if (ret && !rc)
> +		rc = ret;
> +
> +disarm:

[ ... ]

> +	if (!(armed_mask & BIT(pll_idx))) {
> +		ret = sit9531x_update_pll_u8(sitdev, pll_idx,
> +					     SIT9531X_PLL_REG_PHFL_CTRL,
> +					     SIT9531X_PLL_PHFL_ON_DEMAND_EN, 0);
> +		if (!ret)
> +			ret = sit9531x_pll_small_update(sitdev, pll_idx);
> +		if (ret && !rc)
> +			rc = ret;
> +	}
> +
> +unpark:
> +	for (i = 0; i < SIT9531X_NUM_PLLS; i++) {
> +		if (!(parked & BIT(i)))
> +			continue;
> +		ret = sit9531x_update_pll_u8(sitdev, i,
> +					     SIT9531X_PLL_REG_PHFL_CTRL,
> +					     SIT9531X_PLL_PHFL_ON_DEMAND_EN,
> +					     SIT9531X_PLL_PHFL_ON_DEMAND_EN);
> +		if (!ret)
> +			ret = sit9531x_pll_small_update(sitdev, i);
> +		if (ret && !rc)
> +			rc = ret;
> +	}
> +
> +	return rc;
> +}

[Severity: Low]
The commit message says "The flush's own error paths restore what they
changed".  However, each restore write here is tried only once:

  - the SIT9531X_REG_GPIO_FUNC_CTRL1 trigger-source restore
  - the disarm of pll_idx
  - the unpark of each sibling

armed_mask and parked are locals, so they are lost when the function
returns.

Take a sibling that the profile armed.  If it is parked successfully and
then the re-arm write in the unpark loop fails, does that sibling stay
with SIT9531X_PLL_PHFL_ON_DEMAND_EN cleared?  A later flush re-reads
PHFL_CTRL from the hardware, sees the sibling as not armed, and never
restores it.

The other two cases are similar.  A failed disarm leaves pll_idx
answering later trigger pulses.  A failed trigger-source restore leaves
the chip-global source pinned to the in-register trigger.

sit9531x_output_freq_set() then reports any of these as success:

	rc = sit9531x_output_phase_flush(sitdev, pll_idx);
	if (rc) {
		dev_warn(sitdev->dev, ...);
		rc = 0;
	}

This is unchanged at the end of the series.  The later flush_pending
retry re-reads the enables, which have already been changed.

Could these restores be retried, the way sit9531x_prg_commit() retries
the loop lock?  Alternatively, could the original enables be kept
somewhere that outlives the call?

[ ... ]

> +static int sit9531x_output_divo_calc(struct sit9531x_dev *sitdev, u8 out_idx,
> +				     u8 pll_idx, u64 frequency, u64 *fvco_out,
> +				     u64 *divo_out)
> +{

[ ... ]

> +	/*
> +	 * The core validates the request against the supported ranges with
> +	 * the value narrowed to u32 but hands the full u64 down, so a value
> +	 * like U32_MAX + 1 Hz validates as 1 Hz.  Reject anything that does
> +	 * not fit the narrowed width the validation actually covered.
> +	 */
> +	if (frequency > U32_MAX)
> +		return -EINVAL;

[Severity: Low]
Is this comment accurate?  dpll_pin_freq_set() in
drivers/dpll/dpll_netlink.c does not narrow the value:

	u64 freq = nla_get_u64(a), old_freq;
	...
	if (!dpll_pin_is_freq_supported(pin, freq)) {

dpll_pin_is_freq_supported() takes a u64 and compares the full value
against freq_supported[].min and .max.

The check itself is harmless, since the advertised ranges stop at
1 GHz.  Could the comment be corrected so that it doesn't misdescribe
the core's validation?  The comment is unchanged at the end of the
series.

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 0400444d91a55..aa021b374c45c 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c

[ ... ]

> @@ -719,8 +763,78 @@ sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,

[ ... ]

>  static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops = {
>  	.direction_get		= sit9531x_dpll_output_pin_direction_get,
> +	.frequency_get		= sit9531x_dpll_output_pin_frequency_get,
> +	.frequency_set		= sit9531x_dpll_output_pin_frequency_set,
>  };

[Severity: Low]
This isn't a bug, but at this commit sit9531x_dpll_pin_is_registrable()
in core.c still rejects every output:

	if (dir != DPLL_PIN_DIRECTION_INPUT)
		return false;

So neither these output frequency callbacks nor the output read-back in
sit9531x_pin_props_get() can run yet.  Outputs are first registered in
the next patch, "dpll: sit9531x: implement output pin state on a DPLL",
and that patch's commit message explains this.

Could this commit message also say that the output side does nothing
until then?

>  const struct dpll_pin_ops *
> @@ -730,6 +844,12 @@ sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin)
>  		return &sit9531x_dpll_output_pin_ops;
>  	if (sit9531x_dpll_is_xo_pin(pin))
>  		return &sit9531x_dpll_xo_pin_ops;
> +	/*
> +	 * Seeded from the firmware node before the pin is registered and
> +	 * never written afterwards, so register and unregister agree.
> +	 */
> +	if (!sit9531x_ref_state_get(pin->dpll->dev, pin->id)->freq)
> +		return &sit9531x_dpll_input_pin_norate_ops;
>  	return &sit9531x_dpll_input_pin_ops;
>  }

[Severity: Low]
There is no INTSYNC case here.

For the INTSYNC destination input (SIT9531X_INTSYNC_PIN_ID, index 9),
wouldn't this read sitdev->ref[9].freq?  That is past the end of ref[]
and aliases out[0].freq, so register and unregister could pick
different ops tables.

The INTSYNC source output (SIT9531X_INTSYNC_OUT_PIN_ID) would get
sit9531x_dpll_output_pin_ops.  Its frequency_get would return -EINVAL
for that index and abort the pin dump.

Neither pin is reachable anywhere in the series:

  - At this commit, sit9531x_input_pin_is_registrable() returns false
    for index >= num_inputs, and no output is registered.
  - In "dpll: sit9531x: implement output pin state on a DPLL", both
    INTSYNC ids are still rejected.
  - "dpll: sit9531x: model the inter-PLL sync net as a pair of pins"
    adds sit9531x_dpll_intsync_src_pin_ops and
    sit9531x_dpll_intsync_dst_pin_ops, and returns them before any
    ref[] lookup.

Is it still worth guarding the lookup here, so this function is correct
without relying on the later patches?

> diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c
> index 16643f25f6b28..4ca92f4f17d15 100644
> --- a/drivers/dpll/sit9531x/prop.c
> +++ b/drivers/dpll/sit9531x/prop.c

[ ... ]

> @@ -313,6 +314,30 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,
>  	    index == SIT9531X_INTSYNC_OUT_PIN_ID)
>  		return props;
>  
> +	/*

[ ... ]

> +	 * that rate is published ahead of the fallback range below.  An
> +	 * output the configuration does not route has no rate to read,
> +	 * which is not an error.
> +	 */
> +	if (dir == DPLL_PIN_DIRECTION_OUTPUT &&
> +	    index < sitdev->info->num_outputs) {
> +		u64 hw_freq;
> +
> +		mutex_lock(&sitdev->multiop_lock);
> +		rc = sit9531x_output_freq_get(sitdev, index, &hw_freq);
> +		mutex_unlock(&sitdev->multiop_lock);
> +		if (!rc)
> +			curr_freq = hw_freq;
> +	}

[Severity: Low]
sit9531x_output_freq_get() updates the cache itself:

	*frequency = div64_u64(fvco, divo);
	sitdev->out[out_idx].freq = *frequency;

Further down in sit9531x_pin_props_get(), the existing comment says the
seeded rate is published only after the ranges kcalloc(), because "a
call that reports failure must not leave the device's cached rate
changed behind it."

If that kcalloc() fails, doesn't the function return -ENOMEM with
out[index].freq already changed?

The value written is the real hardware rate, so the effect is small.
Still, the comment and the code now disagree, and that is unchanged at
the end of the series.

[Severity: Low]
The comment above only explains why the unrouted case is ignored.  The
"if (!rc)" check, though, also drops I2C errors from
sit9531x_output_freq_get().

If the read-back fails during registration, the pin is built with only
the firmware list in freq_supported, or the 1 Hz to 1 GHz fallback when
there is no list.  The rate the output is actually running at is
missing.

The pin properties are never rebuilt.  dpll_pin_freq_set() checks
dpll_pin_is_freq_supported() before it calls the driver.  If the
firmware list doesn't include the running rate, would the core then
reject a later request for that rate, such as one restoring it after a
change?

Should only -ENODATA be ignored here?  This is unchanged at the end of
the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016005823.13690-1-arouhi%40sitime.com
