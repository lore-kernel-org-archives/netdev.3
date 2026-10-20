Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465795;
	b=TJVL3VkXhm+XP43Qj5p/JUdzrvKGNtHKlDNuL/aNmj943bpljLMyhEoaUS9uY5k2GraP
	 xrOQKMEq/uiKMgijrQpJE/VbJoytE4RapxUkjL0eX7jWjfEjrycx8XAb0mq78bdy4dBbh
	 es0RAVgEuZy/YKen/pEvepFuQHnJnbdgLHrGDr1EjtQLdTSAC7LRrkARwG0pXMIJstHH2
	 qR89UhHdYBCsD8NlE81azn6Lg7wSCzbN+fz+cUdIfiYdEZlzuf1t0ugzNPCYafATmBJIx
	 gWuOx9/kka1VdFYwfnI6MpTojzmzLhslE9VBpSCHix+1oHgZRJxE9K7WPMJpmsY6Gkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465795;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ckEOGKTTmQNwgB3mVk2a7yMj+m4IoK8Kk9iLnKpjqsE=;
	b=NQU79TQRFwzQJZPH/2U/79KomK8+EUaILMkgEJol6aU8+VelVdbOjb+GxJvFygkODmu1
	 EB32OZVvupKCiLLHiDeDEt5B76rbz6C6a7pox7EhUUAZ6VYUPvMWcg2R+2BABgDy1Md4Y
	 i31IqFtRvt1OB0v2W8Q6wSRC4s3GqAfzQ00zAu7Py8Qztjy5oD76W3bfPLvoetR9lI1YD
	 GJJd3ryKoru3UpIQFwiw9AjOprr+C1yQ4IfY0RhmAhtTRYVd9zxj9orh4iORiRtOgQON0
	 /LPHXR7MSAo6PH7a92u5J4DpwPGfoWG/gRkkgwV6uycSvmY8zQ5wqUgezq6UTwfPw6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DarHmhvd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615D606B54E;
	Tue, 20 Oct 2026 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DarHmhvd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8872F1F01574;
	Tue, 20 Oct 2026 03:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792465794;
	bh=ckEOGKTTmQNwgB3mVk2a7yMj+m4IoK8Kk9iLnKpjqsE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DarHmhvdW3XI8Nu/Rs9huuo2ZsZYiNrvk8Dy5FU9s3ucYd90ihomLTU41LtzvjUk3
	 RwlrVbY1kUm66O82zSoKeVYvcxks9zcfXq7+vb95VCEGYY8euXkJ90VF2CWz35N2Qu
	 eieZw7IPsyXd6jg5GfznfairJYYbfkwZCR3Z1KpKcwl63KDuehWxIVyICVfPqphnAR
	 o62sUMsR9O39bOiygtjNjREbdVqVTdpgsS3D6fN5R9fCv+v/QOGEUBeC83bxeOrRPm
	 S/VuV7Jp2INUz/poss7Wm39/5GBXuNhbHdzmhw4Awo3FTGUkG4fW9DbDjfQC3QxeLV
	 B8yTfurIkSWGQ==
Subject: Re: [PATCH net-next v14 11/12] dpll: sit9531x: add support to get
 phase offset on the connected input pin
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 03:09:53 +0000
Message-ID: <179246579306.3135.15038289860368046867@kernel.org>
In-Reply-To: <20261016005823.13690-12-arouhi@sitime.com>
References: <20261016005823.13690-12-arouhi@sitime.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] sit9531x_dpll_input_pin_phase_offset_get()
  (drivers/dpll/sit9531x/dpll.c:710) does bus I/O for every (input pin,…
- [Low] The kernel-doc 'Return:' section of sit9531x_phase_offset_read()
  (core.c:3070) lists 0, -ENODATA, or a register access error.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but reading the
  debug-status data register (0xD0) on a PLL page has a side effect: it…

--

dpll: sit9531x: add support to get phase offset on the connected input pin

This adds a phase_offset_get callback for sit9531x input pins. The value
is read from the on-chip TDC through the PLL debug window, and is scaled
by the VCO rate. Pins that are not the active reference report zero, so
one pin does not fail the whole pin dump.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index ffed2aaf8a345..10609d46a7e1a 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> @@ -3051,6 +3054,202 @@ static int sit9531x_clear_notifications(struct sit9531x_dev *sitdev)
>  	return 0;
>  }
>  
> +/**
> + * sit9531x_phase_offset_read - read phase difference via TDC
> + * @sitdev:	device pointer
> + * @pll_idx:	PLL index (0-3)
> + * @phase_offset:	phase difference in units of 1/DPLL_PHASE_OFFSET_DIVIDER
> + *		of a picosecond, as the DPLL subsystem carries it
> + *
> + * Reads the Time-to-Digital Converter (TDC) code from the PLL page
> + * registers -- a 35-bit magnitude with a separate sign bit -- then
> + * converts it using the VCO frequency: phase_diff = tdc_code / fvco.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + *
> + * Return: 0 on success, -ENODATA when the PLL has no known VCO rate
> + * (nothing is sampled then), or the register access error
> + */
> +int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			       s64 *phase_offset)
> +{

[ ... ]

> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (pll_idx >= SIT9531X_NUM_PLLS)
> +		return -EINVAL;

[Severity: Low]
This isn't a bug, but the Return: section above lists 0, -ENODATA, or a
register access error. It leaves out the -EINVAL returned here for an out
of range pll_idx.

The only caller passes sitdpll->id, so this can't be reached today. Could
the kernel-doc mention -EINVAL anyway?

[ ... ]

> +	/*
> +	 * Latch a sample by reading the debug status data register.  A
> +	 * single read returns the previous latch, so read it three times
> +	 * as the documented phase-difference procedure does.
> +	 */
> +	for (i = 0; i < SIT9531X_DBG_STATUS_READS; i++) {
> +		rc = sit9531x_read_pll_u8(sitdev, pll_idx,
> +					  SIT9531X_PLL_REG_DBG_STATUS_DATA,
> +					  &v);
> +		if (rc)
> +			goto relock;
> +	}
> +
> +	tdc_raw = 0;
> +
> +	rc = sit9531x_read_pll_u8(sitdev, pll_idx,
> +				  SIT9531X_PLL_REG_DBG_DATA_4, &v);

[Severity: Low]
This isn't a bug introduced by this patch, but reading
SIT9531X_PLL_REG_DBG_STATUS_DATA has a side effect, because it advances
the latch. sit9531x_regmap_config doesn't declare a precious_reg (or
readable_reg) callback:

static const struct regmap_config sit9531x_regmap_config = {
    ...
	.volatile_reg	= sit9531x_volatile_reg,
	.cache_type	= REGCACHE_MAPLE,
};

As a result, regmap_printable() treats this register on every PLL page as
printable, and a read of /sys/kernel/debug/regmap/<dev>/registers will
read it.

That debugfs read is serialized only by the regmap lock, not by
multiop_lock. Can it land between the three latch reads above and the
DATA_4..DATA_0 reads that follow? If it does, the driver would decode a
sample latched at a different time from the one this sequence selected.

The routed-source reader added earlier in the series already had this
exposure, and this patch adds a second user of the same latch. Would it
make sense to mark the latch register precious?

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index b3719370901eb..dc8d84133b72b 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c

[ ... ]

> +static int
> +sit9531x_dpll_input_pin_phase_offset_get(const struct dpll_pin *pin,
> +					 void *pin_priv,
> +					 const struct dpll_device *dpll,
> +					 void *dpll_priv, s64 *phase_offset,
> +					 struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	for (i = 0; i < sitdev->info->num_outputs; i++) {
> +		if (!sitdev->out[i].routed ||
> +		    sitdev->out[i].pll_idx != sitdpll->id)
> +			continue;
> +		if (sitdev->out[i].state_stale) {
> +			rc = sit9531x_output_state_refresh(sitdev, i);
> +			if (rc) {
> +				mutex_unlock(&sitdev->multiop_lock);
> +				NL_SET_ERR_MSG(extack,
> +					       "Output mute state could not be read back");
> +				return rc;
> +			}
> +		}
> +		if (sitdev->out[i].enabled)
> +			drives = true;
> +	}
> +
> +	/*
> +	 * The lane's signal is read live as well: a loss since the last poll
> +	 * makes the device fall back on its own, and a sample taken then
> +	 * would be credited to a pin the PLL is no longer on.
> +	 */
> +	rc = sit9531x_input_mon_fetch(sitdev);
> +	if (rc) {
> +		mutex_unlock(&sitdev->multiop_lock);
> +		NL_SET_ERR_MSG(extack,
> +			       "Failed to read the input clock monitors");
> +		return rc;
> +	}
> +
> +	if (!drives ||
> +	    !sit9531x_dpll_selection_active(sitdev, sitdpll, dpin->id)) {
> +		mutex_unlock(&sitdev->multiop_lock);
> +		*phase_offset = 0;
> +		return 0;
> +	}

[Severity: Medium]
Can a transient I2C error on a pin that has no phase offset fail the
whole pin dump here?

The output state refresh and sit9531x_input_mon_fetch() (four I2C reads)
both run before the selection check. For most pins, though, the first
test in sit9531x_dpll_selection_active() already returns false using
cached state only:

	if (chan->routed_ref != pin_id || !chan->locked || chan->mode ||
	    chan->ho_freeze)
		return false;

Any error from the earlier I/O is returned with an extack message, even
for standby or non-selected pins that would otherwise report 0.

dpll_msg_add_phase_offset() returns any non-zero ret. The dump loop in
dpll_nl_pin_get_dumpit() only skips -ENODEV:

dpll_nl_pin_get_dumpit()
  dpll_cmd_pin_get_one()
    dpll_msg_add_pin_dplls()
      dpll_msg_add_phase_offset()
        sit9531x_dpll_input_pin_phase_offset_get()
          sit9531x_input_mon_fetch() fails

The same path is used for the do request and for dpll_pin_change_ntf()
from the poll worker. A failure there would drop the notification.

The comment above the function says non-selected pins report 0 so that
one pin can't fail the dump. With this ordering, can any input pin still
fail it?

This also adds about four I2C reads per (pin, DPLL) pair to every dump.
Before this patch, the input pin getters answered from the cache.

Could the cached chan state check run first, with the output refresh and
monitor fetch done only for the pin that could be the active reference?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016005823.13690-1-arouhi%40sitime.com
