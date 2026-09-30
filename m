Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A66C449B26;
	Wed, 30 Sep 2026 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751447; cv=none; b=LWLhJm6fQKOAu8C6fY/nFubz+FeDNxXa/qmC72y646iOV6u62nm4JVeq6Yoxou2eKrIDlXjhi8o8TMesfOYu6mPdmoeJ+gQY25CamtTBt/E/QmTuVcYvCUf8NmUS2JvymtbFe8SMMiwOEsfSFvgc18Gd2wDQZ/HV2oASCJm0EoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751447; c=relaxed/simple;
	bh=7rf6poE9JRRqaXxdef6UYxtzI4ptFTdwXjDk6N62Q8w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gW8Ipge5PIrgeXMnzVPbM9XEOQJrgER6jRLX6GU9W7sUM1UbCDaXtzQ6jArqM7PjpD3EpjR9bVA5Jl4wYKTyDEz5nFd99O5kQMr4osW4h6+8VEcHg8inHfXe4rXaqgdddmyxJ9Qu0cwRir9rdOj6xvrq2fTFs6C7SqQR/ObPDFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhIMrxw1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhIMrxw1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0E41F0089A;
	Wed, 30 Sep 2026 06:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751436;
	bh=yAq7aPHs7ijEhYz/lAfzl4lkZubSQIrVP3ZaHnN5y0U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HhIMrxw1yjJr0Ik3Z+cCfVKJ+pw2mleFdbe+jFaEZHGZlSFFRyjDSsClbPqVTym0V
	 L1IbnkLIw+HLVOJ2PZhsNqkSIFqeC8IWrJY8Jp3pnpgdkGvcGdt6Jp98dL0D/TG4lq
	 7ZQuaHRxuDKlt5nBdSw1tGLE6Pz4mb8UPHMUl8q2fWqi/a4sr/nffauGMHBjOLy5Uv
	 Cb8x5NhOt82Cc+IGl+4CzPMUU4LDYomh8fR3TS6s6lclsYuDwbr60JPnvOGDPlJBFU
	 LaGqEHvBmV+zH7EVVelKK7jpPowIx6fpjj+Bd0ytd9jqBgA7gknNhlhkfUmNSoHaMg
	 owDx9B8pGoeZw==
Subject:
 Re: [PATCH net-next 6/6] dpll: zl3073x: add PTP periodic output support
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, Chris.duQuesnay@microchip.com,
 arkadiusz.kubalewski@intel.com, kuba@kernel.org, jiri@resnulli.us,
 min.li@microchip.com, pabeni@redhat.com, poros@redhat.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 06:57:15 +0000
Message-ID: <179075143589.434549.11966375891495900992@kernel.org>
In-Reply-To: <20260928185552.1103515-7-ivecera@redhat.com>
References: <20260928185552.1103515-7-ivecera@redhat.com>
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

Critical: 0 · High: 0 · Medium: 4 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In zl3073x_dpll_ptp_register()
  (drivers/dpll/zl3073x/dpll.c:3045-3054), any perout-capable output pin…
- [Medium] zl3073x_dpll_perout_enable()
  (drivers/dpll/zl3073x/dpll.c:2887-2904) checks only perout->period ==…
- [Medium] For single-ended outputs that are not N-divided, both pins of
  the pair (OUTxP/OUTxN) share the div and width registers.
- [Medium] zl3073x_dpll_ptp_enable() passes zldpll->ptp_clock to
  ptp_find_pin() (dpll.c:2959).
- [Low] zl3073x_dpll_perout_enable() writes the new 1 Hz divider to
  hardware first (zl3073x_out_state_set() at dpll.c:2897, which also…
- [Low] zl3073x_dpll_ptp_register() reads the zldev->out[] cache through
  zl3073x_dev_output_pin_state_get() (dpll.c:3049) without zldpll->lock,…
- [Low] On a non-N-divided output, zl3073x_dpll_perout_enable() relies on
  zl3073x_dpll_output_pin_freq_set(), which only rewrites div and width…

--

dpll: zl3073x: add PTP periodic output support

This commit registers a PTP periodic output pin for each zl3073x DPLL
output pin that supports step-time and declares 1 Hz support in firmware.
Enabling a perout channel programs the assigned pin for 1 PPS and
connects it. Disabling the channel disconnects the pin.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 0a36a2acf15b..f406d1e72530 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c

[ ... ]

> @@ -2823,6 +2840,159 @@ zl3073x_dpll_ptp_getmaxphase(struct ptp_clock_info *info __always_unused)

[ ... ]

> +static int
> +zl3073x_dpll_perout_enable(struct zl3073x_dpll_pin *pin,
> +			   struct ptp_perout_request *perout)
> +{
> +	u8 out_id = zl3073x_output_pin_out_get(pin->id);
> +	struct zl3073x_dev *zldev = pin->dpll->dev;
> +	struct zl3073x_out out;
> +	int rc;
> +
> +	/* Only 1 PPS (1 Hz) periodic output is supported */
> +	if (perout->period.sec != 1 || perout->period.nsec)
> +		return -EINVAL;

[Severity: Medium]
Should perout->start be checked here too?

supported_perout_flags is left at 0, so ptp_perout_request() rejects
PTP_PEROUT_PHASE. That means every request reaching this driver uses the
absolute start time semantics from include/uapi/linux/ptp_clock.h:

	/*
	 * Absolute start time.
	 * Valid only if (flags & PTP_PEROUT_PHASE) is unset.
	 */
	struct ptp_clock_time start;

start is never read. The divider is programmed, the pin is connected
right away, and success is returned. A request with a future start time
or a non-zero start.nsec is accepted, but the edge is not aligned to it.
If the pin is already connected, the only hardware change is a divider
rewrite on the running output.

Could requests whose start time cannot be honoured be rejected? At a
minimum, could the commit message mention this limitation?

> +
> +	out = *zl3073x_out_state_get(zldev, out_id);
> +
> +	rc = zl3073x_dpll_output_pin_freq_set(pin, &out, 1);

[Severity: Medium]
On single-ended outputs that are not N-divided, both pins of the pair
share div and width. zl3073x_dpll_output_pin_freq_set() just overwrites
them in that case:

	if (!zl3073x_out_is_ndiv(out)) {
		...
		out->div = new_div;
		...
		out->width = new_div;

		return 0;
	}

OUTxP and OUTxN can both be advertised as independent PTP perout pins.
Enabling a channel on OUT5P would therefore also retune OUT5N to 1 Hz,
even if OUT5N is connected and driving something like 10 MHz. The
sibling dpll_pin_change_ntf() only reports this after the fact.

Should this path refuse when the sibling is connected at a different
frequency?

zl3073x_dpll_perout_disable() also only disconnects the pin. It does not
restore the previous divider, so a sibling that is still connected stays
at 1 Hz after the PTP channel is turned off. Is that intended?

[Severity: Low]
On a non-N-divided output, the same helper leaves the output mode clock
type and esync_n_period/esync_n_width unchanged. If the output was in
ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC, does it stay in ESYNC mode after the
switch to 1 Hz? esync_n_period and esync_n_width would still be the
values computed for the old carrier.

Once out_freq is 1, zl3073x_dpll_output_pin_esync_get() hides this
state:

	if (!(pin->caps & ZL3073X_DPLL_PIN_CAP_ESYNC) || out_freq <= 1)
		return -EOPNOTSUPP;

Userspace can then no longer see or clear the ESYNC mode that is still
set in hardware.

Should the perout path force CLOCK_TYPE_NORMAL, or reject outputs that
are in ESYNC mode? The existing DPLL frequency_set path appears to have
the same gap.

> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_out_state_set(zldev, out_id, &out);
> +	if (rc)
> +		return rc;
> +
> +	if (zl3073x_dev_output_pin_state_get(zldev, pin->id))
> +		return 0;
> +
> +	return zl3073x_dev_output_pin_state_set(zldev, pin->id, true);

[Severity: Low]
What happens if zl3073x_dev_output_pin_state_set() fails here? By then
the new 1 Hz divider has already been committed by the
zl3073x_out_state_set() call above, and the cache has been updated.

The connect sequence can fail early. For example, the first stop write
in zl3073x_dev_output_pin_state_set() returns immediately:

	zl3073x_out_stop(&out);
	rc = zl3073x_out_state_set(zldev, out_id, &out);
	if (rc)
		return rc;

The old div/width and esync_n_period/width are not restored. The output
is left at 1 Hz and disconnected, and so is the sibling for non-N-div
formats.

zl3073x_dpll_ptp_enable() then returns before either notification:

	if (rc)
		return rc;

zl3073x_dpll_changes_check() only sends notifications for input pins.
Would DPLL userspace ever learn that the frequency of this pin or its
sibling changed?

> +}

[ ... ]

> +static int zl3073x_dpll_ptp_enable(struct ptp_clock_info *info,
> +				   struct ptp_clock_request *rq, int on)
> +{

[ ... ]

> +	pin_idx = ptp_find_pin(zldpll->ptp_clock, PTP_PF_PEROUT,
> +			       rq->perout.index);

[Severity: Medium]
Can zldpll->ptp_clock still be NULL here? zl3073x_dpll_ptp_register()
only assigns it after ptp_clock_register() returns:

	ptp_clock = ptp_clock_register(&zldpll->ptp_info, zldev->dev);
	...
	zldpll->ptp_clock = ptp_clock;

Inside ptp_clock_register(), posix_clock_register() has already made
/dev/ptpN and the sysfs pin and period attributes live. Any of these,
issued in that window, would reach this call with a NULL clock:

  - PTP_PEROUT_REQUEST
  - PTP_PIN_SETFUNC, via ptp_set_pinfunc()->ptp_disable_pinfunc()->
    enable(on=0), which is reachable because pins can be seeded as
    PEROUT at probe
  - a write to the sysfs period attribute

ptp_find_pin() dereferences ptp->info->n_pins without a NULL check.

The callback already receives info. Could it scan info->pin_config
directly rather than depend on the pointer that is published later?

> +	if (pin_idx < 0)
> +		return -EINVAL;

[ ... ]

> @@ -2843,16 +3015,53 @@ static const struct ptp_clock_info zl3073x_dpll_ptp_clock_info = {
>  static int zl3073x_dpll_ptp_register(struct zl3073x_dpll *zldpll)
>  {

[ ... ]

> +	i = 0;
> +	for_each_set_bit(id, zldpll->perout_map, ZL3073X_NUM_OUTPUT_PINS) {
> +		pin = zl3073x_dpll_output_pin_get_by_id(zldpll, id);
> +		strscpy(pin_config[i].name, pin->label);
> +		pin_config[i].index = i;
> +		if (zl3073x_dev_output_pin_state_get(zldev, id)) {
> +			pin_config[i].func = PTP_PF_PEROUT;
> +			pin_config[i].chan = i;
> +		}

[Severity: Medium]
Should this also check that the output runs at 1 Hz? Any perout-capable
pin that is connected at probe is reported as holding PEROUT channel i.
That includes a pin that firmware or DPLL netlink set up as, say, a
10 MHz clock.

Normal PTP pin management would then turn that output off. Each of
these triggers it:

  - PTP_PIN_SETFUNC moving channel i to another pin
  - setting the pin to PTP_PF_NONE
  - PTP_PEROUT_REQUEST with period 0 on channel i

They all end up in:

ptp_set_pinfunc() or ptp_perout_request()
  zl3073x_dpll_ptp_enable(on = 0)
    zl3073x_dpll_perout_disable()
      zl3073x_dev_output_pin_state_set(zldev, pin->id, false)

This disconnects an output that was never enabled through PTP. The
commit message does not mention that existing outputs are adopted this
way.

Would it be better to seed only pins that are connected and running at
1 Hz as PTP_PF_PEROUT, and leave the rest as PTP_PF_NONE?

[Severity: Low]
This reads the zldev->out[] cache through
zl3073x_dev_output_pin_state_get() without holding zldpll->lock.

zl3073x_dpll_register() has already registered the DPLL device and pins
before zl3073x_dpll_ptp_register() runs. DPLL netlink ops such as
zl3073x_dpll_output_pin_state_on_dpll_set() can therefore update the
same cache concurrently under zldpll->lock.

zl3073x_dev_output_pin_state_set() also briefly stops the whole output
pair around an fsleep(). An unlocked read in that window could see a
connected pin as stopped and seed it as PTP_PF_NONE.

Would holding zldpll->lock around this seeding loop fix it?

> +		i++;
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928185552.1103515-1-ivecera%40redhat.com
