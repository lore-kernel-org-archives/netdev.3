Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205AE5964F4;
	Thu, 17 Sep 2026 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657334; cv=none; b=LZgD0xatyiK+wgNS+xybKiQno1BcmgAvfcvgjs43k71ZXjzZgHdO7LqNYkEjpxB6CniOanswkKl5ic1/HlHtY0MOLkvHWGchFjGd0o0AJtRHDd+fMfnkTPfOcW2F9IHoV4Jn36LNlBuIbJFOCUrNMEQ5ZFd+hGf0iO3oxBk6RnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657334; c=relaxed/simple;
	bh=q+HzuFDSmJ3dylLN4PTb2XoZT2KRT2prQdvE869VAQg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nXIxBtNX091ie7Zo0QfKHwB6AT74HBhuDeuxZrwRMUyvW2ORQ4eh5FSYRuNLNjl8SeVTauxmVGXKAYK0JYsAD6ROxO+cvC2ONto4YNzPdf3m0R233Kdwsg2hCKEmGEZKZ33HZsuC7VeZvmIFHZu6JEiRlOAX/YGugzuoOW2Jy4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhD/SJOI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhD/SJOI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE041F008A4;
	Thu, 17 Sep 2026 15:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657319;
	bh=ZXktrLGW8PJtTIXqHoJDGmKUK43c1RymIAE5AD77r8c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mhD/SJOIGAy7DlESX+ym1HZ5e8N2GZJhCHi/4yB2IeXyJ7u104MMZtGAyLROGPn7K
	 xqjFi/M05z9CBjAs2vuGAS1BfAJED2fficSok6uV4Td1SdNMCfoP/NRCNYa+U49/mx
	 JCX3ELO6BVc+v6sBnouvM2Pwh7i4IsGlU2qnQoGGohiYXG3jmTtr4TMKS8n49PplHm
	 D/76cbb+lF6sf9vAwvU1TH7EJG65DoL+s27mN/j1zfBsHpzjYEHXA7i/pE2/niI8S3
	 /mRzF4pLMsdfRTS8yIqjezmXkafW3qXAWo11l0BNsBaxRk+FreN/y8qcJENw66R1q9
	 vkMXEoY7P8+mQ==
Subject: Re: [PATCH net-next v9 13/15] dpll: sit9531x: add support to get
 fractional frequency offset
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 pabeni@redhat.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 17 Sep 2026 15:01:57 +0000
Message-ID: <178965731792.22033.2638951654800775317@kernel.org>
In-Reply-To: <20260915000015.80480-14-arouhi@sitime.com>
References: <20260915000015.80480-14-arouhi@sitime.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 3

- [High] sit9531x_divn_runtime() feeds an unvalidated 48-bit sampled
  numerator and a raw sampled denominator (only checked for != 0) into…
- [Medium] sit9531x_dbg_sample() writes SIT9531X_PLL_DEBUG_UNLOCK (0xC3)
  to the per-PLL debug key register SIT9531X_PLL_REG_DEBUG (0xBD) but…
- [Low] The documentation block for sit9531x_dbg_sample() lists @sitdev,
  @pll_idx, @read_code, @buf and @len, but the implemented signature…
- [Low] SIT9531X_DIVN_RT_INT_HI_BIT is defined in regs.h under a comment
  that describes it as belonging to the integer part of the DIVN tap…
- [Low] The kernel-doc of sit9531x_pll_ffo_ppt() states 'Return: 0 on
  success, -ENODATA when DIVN is not programmed, <0 on error', but the…

--

dpll: sit9531x: add support to get fractional frequency offset

This adds a fractional frequency offset readback for the sit9531x DPLL
inputs, derived from the difference between the DIVN the digital loop is
running and the DIVN the configuration registers hold.  The running value
is sampled through the same latched debug window that the phase offset
readback uses.

A few questions on the new code below.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 356d1eac4ec54..88bfa63b29755 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -1224,6 +1224,76 @@ static int sit9531x_is_xo_doubler_enabled(struct sit9531x_dev *sitdev)
>  	return (~val >> SIT9531X_XO_DOUBLER_ENB_BIT) & 1u;
>  }
>  
> +/*
> + * sit9531x_dbg_sample - latch and read a signal pathway debug sample
> + * @sitdev:	device pointer
> + * @pll_idx:	PLL index (0-3)
> + * @read_code:	which tap of the pathway to sample
> + * @buf:	result, least significant byte first
> + * @len:	bytes to read, at most SIT9531X_DBG_DATA_BYTES
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int sit9531x_dbg_sample(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			       u8 read_code, bool low_freq_clk,
> +			       u8 *buf, unsigned int len)

[Severity: Low]
This isn't a bug, but the comment block for sit9531x_dbg_sample() documents
five parameters (sitdev, pll_idx, read_code, buf, len) while the function
takes six, with bool low_freq_clk sitting between read_code and buf.  Since
the clock-select argument is the one the block goes on to explain in prose,
should it get a @low_freq_clk entry too?

> +{
> +	unsigned int i;
> +	int rc;
> +	u8 v;
> +
> +	if (len > SIT9531X_DBG_DATA_BYTES)
> +		return -EINVAL;
> +
> +	rc = sit9531x_write_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_DEBUG,
> +				   SIT9531X_PLL_DEBUG_UNLOCK);
> +	if (rc)
> +		return rc;

[Severity: Medium]
Should this helper close the debug window before returning?

SIT9531X_PLL_REG_DEBUG is written with SIT9531X_PLL_DEBUG_UNLOCK here, and
none of the four error returns below, nor the final return 0, writes
SIT9531X_PLL_DEBUG_LOCK back.

The existing user of the same window, sit9531x_phase_offset_read(), funnels
every exit through a relock label and states what the open window means:

	relock:
		/*
		 * Close the debug window again.  The key register opens every debug
		 * register on this PLL while it holds the unlock value, and this read
		 * runs on every pin-get of a connected input, so leaving it open
		 * would mean normal monitoring permanently unlocks the block.
		 */
		lock_rc = sit9531x_write_pll_u8(sitdev, pll_idx,
						SIT9531X_PLL_REG_DEBUG,
						SIT9531X_PLL_DEBUG_LOCK);

The new path sit9531x_dpll_input_pin_ffo_get() ->
sit9531x_pll_ffo_ppt() -> sit9531x_divn_runtime() -> sit9531x_dbg_sample()
runs on every pin-get of a connected input and calls the helper twice, and
sit9531x_divn_runtime() returns straight out on the first error, so nothing
above it re-locks either.  Does that leave the PLL's debug block unlocked
after every frequency offset read?

> +
> +	/*
> +	 * Select the debug clock this tap needs.  The device never clears
> +	 * the bit, so a read that left it to whatever the previous one set
> +	 * would depend on the order the taps happened to be read in.  Taps
> +	 * below 200 kHz need the slow clock; the divider taps do not.
> +	 */

[ ... ]

> @@ -1291,6 +1361,130 @@ static int sit9531x_divn_static(struct sit9531x_dev *sitdev, u8 pll_idx,
>  	return 0;
>  }
>  

[ ... ]

> +static int sit9531x_divn_runtime(struct sit9531x_dev *sitdev, u8 pll_idx,
> +				 s64 *divn)
> +{
> +	u8 buf[SIT9531X_DBG_DATA_BYTES];
> +	u64 fracn_raw = 0, fracd = 0;
> +	u32 int_part;
> +	int rc, i;

[ ... ]

> +	for (i = 5; i >= 0; i--)
> +		fracd = (fracd << 8) | buf[i];
> +
> +	fracd |= (u64)(buf[6] & SIT9531X_DIVN_RT_INT_HI_BIT) << 48;
> +
> +	/*
> +	 * sit9531x_divn_fixed() drops the fractional part when the
> +	 * denominator is zero.  That is right for a configuration register
> +	 * that was never programmed, but a running loop reading zero means
> +	 * the sample is unusable, and returning the whole part alone would
> +	 * put a wrong DIVN into the frequency offset without saying so.
> +	 */
> +	if (!fracd)
> +		return -ENODATA;
> +
> +	*divn = sit9531x_divn_fixed(int_part,
> +				    sign_extend64(fracn_raw,
> +						  SIT9531X_DIVN_RT_NUM_BITS - 1),
> +				    fracd);

[Severity: High]
Can a small but nonzero denominator sample trap here?

The only check on the sampled pair is "if (!fracd) return -ENODATA;", so any
fracd in 1..2^49-1 is passed on together with a numerator of up to 2^47 in
magnitude after sign_extend64().  sit9531x_divn_fixed() then does:

	frac = mul_u64_u64_div_u64(abs(fracn), SIT9531X_DIVN_SCALE, fracd);

With SIT9531X_DIVN_SCALE at 1e12, abs(fracn) near 2^47 gives a product of
about 1.4e26, so the quotient exceeds U64_MAX for any fracd below roughly
7.6e6.  On x86-64 that is not a wrong value but a divide-error exception, per
arch/x86/include/asm/div64.h:

	/*
	 * Will generate an #DE when the result doesn't fit u64, could fix with an
	 * __ex_table[] entry when it becomes an issue.
	 */
	...
		asm ("divq %[div]" : "+a" (rax), "+d" (rdx) : [div] "rm" (div));

On architectures using the generic helper the result comes back as ~0 and is
reported to userspace as a frequency offset instead.

Both operands come from the I2C part through the latched debug window, and
the code already accepts that the tap may return something that is not a
running loop when it special-cases fracd == 0.  Would rejecting samples where
abs(fracn) >= fracd (or otherwise bounding the ratio) before calling
sit9531x_divn_fixed() be appropriate?  sit9531x_pll_ffo_ppt() adds exactly
this class of guard for the configured divider:

	if (configured < SIT9531X_DIVN_SCALE)
		return -ENODATA;

Note the pre-existing sit9531x_divn_static() path only supplies a 32-bit
numerator, so the runtime tap widens the range of inputs that can overflow
that division considerably.

> +
> +	return 0;
> +}
> +
> +/**
> + * sit9531x_pll_ffo_ppt - fractional frequency offset of a PLL's reference
> + * @sitdev:	device pointer
> + * @pll_idx:	PLL index (0-3)
> + * @ffo:	result in parts per trillion

[ ... ]

> + * Caller must hold sitdev->multiop_lock.
> + *
> + * Return: 0 on success, -ENODATA when DIVN is not programmed, <0 on
> + * error.
> + */

[Severity: Low]
This isn't a bug, but the documented return contract of
sit9531x_pll_ffo_ppt() lists -ENODATA only for an unprogrammed DIVN, while
two other paths return it as well:

sit9531x_divn_runtime() returns -ENODATA when the sampled runtime
denominator reads zero, which its own comment describes as "the sample is
unusable" rather than an unprogrammed divider.

sit9531x_pll_ffo_ppt() itself returns -ENODATA when the configured divider
is below one whole unit.

Could the Return: line cover those cases too?

[ ... ]

> diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h
> index 08eae8a2c279a..78e8a47e96ab0 100644
> --- a/drivers/dpll/sit9531x/regs.h
> +++ b/drivers/dpll/sit9531x/regs.h
> @@ -309,6 +309,18 @@
>  #define SIT9531X_TDC_SIGN_BIT		3
>  #define SIT9531X_TDC_MAG_HI_MASK	GENMASK(2, 0)
>  
> +/*
> + * Read codes of the running DIVN taps.  Unlike the configuration
> + * registers these report what the digital loop currently commands, so
> + * they carry the correction the loop applies to track its reference.
> + * The integer part and the numerator share one tap, the denominator
> + * has its own.
> + */
> +#define SIT9531X_DBG_READ_CODE_DIVN		0x57
> +#define SIT9531X_DBG_READ_CODE_DIVN_DEN	0x56
> +#define SIT9531X_DIVN_RT_NUM_BITS		48
> +#define SIT9531X_DIVN_RT_INT_HI_BIT		BIT(0)

[Severity: Low]
This isn't a bug, but SIT9531X_DIVN_RT_INT_HI_BIT is named and commented as
the high bit of the integer part of the DIVN tap, and it is used that way in
sit9531x_divn_runtime():

	int_part = buf[6] | ((u32)(buf[7] & SIT9531X_DIVN_RT_INT_HI_BIT) << 8);

The same macro is then reused as the bit-48 mask of the denominator, which
is a different byte of a different tap:

	fracd |= (u64)(buf[6] & SIT9531X_DIVN_RT_INT_HI_BIT) << 48;

Would a separate SIT9531X_DIVN_RT_DEN_HI_BIT make the two fields
distinguishable, so a later change to the integer field width does not also
change the denominator read?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915000015.80480-1-arouhi%40sitime.com
