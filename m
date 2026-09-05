Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC33321B1;
	Sat,  5 Sep 2026 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573327; cv=none; b=XlIpr4xpBWIzf3fIZbaOOIqShWpoBik+PzFDuQEBioJDtIIa3UzXsgu9HFKwKTcF78X1aGuK/XZYWjcg95JUfBcVQi0QjoKoWkKb0g0/yNgtndu2dVRo0j2npNaZZAfLUsgn/GgHY2ret2MAbrwhSPLcwdxKD3Ge2WOe/k8hI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573327; c=relaxed/simple;
	bh=LefL4B3xO+kLYBHfx4Qeefi0+Rxl7mtUaKXtzvjaXjw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vDMY3c2nt9mTsznSv9pS0pclruZv1EIozQUMVFW+291eplkxR2CJzFN9HLLHuP54pf+oSsWGwTgFyAGYK/9STrKp7te3COZg4kc3S/ZyspIvTvKxYrVG02CIqOD8ptVqm7pQCmyXeFRztl0vkAvsqHJOWWWIdtcbGbLWilUXJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBUFIwL6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBUFIwL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881121F00A3D;
	Sat,  5 Sep 2026 01:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573325;
	bh=Uc5pXWlFleVVffNgI5grdWqw3YR2OHOq+v52K0lx6W4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oBUFIwL6ZweZQ5l5e2EpR14VwS1xrEajW7YNqFFwls3xkLH5Gh+kcumeZEfQcltYV
	 XPDnSLTB7JAtPDjK9KwFSF/W9//UrYKE+N91TxzlDbB4suGqKTXM+YYSRgbxiSebJK
	 mh5Ls9atXfMXH9VVJfFcc2c6lgGxCxWVi9DW5/tuFzeKCzvI0PRVm8ti3P11/Mefh1
	 kCwGlhMv5P8WUrkReVetwZs7+yy/9VJ1RrriORh894+iRNVFcj+ls8cYbqBoLWTWOk
	 b1z0AlmcHRedYYHEuAykM3DZyZZ/6l4kSDmBu8ZYxDAQfsvKa1q6us92A/mVt9lHX/
	 veJbPAa5yyt1A==
Subject: Re: [PATCH net-next v2 10/10] net: dsa: microchip: add periodic
 output support for the KSZ8463
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 05 Sep 2026 01:55:24 +0000
Message-ID: <178857332410.219967.8963048354667407581@kernel.org>
In-Reply-To: <20260902-ksz-perout-v2-10-6f277fcc9e68@bootlin.com>
References: <20260902-ksz-perout-v2-10-6f277fcc9e68@bootlin.com>
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

Critical: 0 · High: 2 (1) · Medium: 3 · Low: 0 (2)

- [High] KSZ8463 periodic output is advertised as 12 independent channels
  (.n_pins = 12, .n_per_out = 12 in ksz_switch_chips[KSZ8463]) but the…
- [High] KSZ8463 periodic output (TOU) is not properly disabled in
  hardware (leaves EN bit).
- [Medium] Build failure when CONFIG_NET_DSA_MICROCHIP_KSZ_PTP=n:
  ksz8463_setup() in drivers/net/dsa/microchip/ksz8.c now calls…
- [Medium] The newly added ksz8463_ptp_configure_perout() dereferences
  dev->ptp_data.pin_config[index] (reading pin->chan to select the…
- [Medium] KSZ8463 TOU enable bit is left set in the hardware if the
  activation verification check fails.

Pre-existing issues:
- [High] A non-normalized periodic-output period whose nanosecond value
  converts to zero is accepted, stored as the global restart period, and…
- [Low] The KSZ periodic-output implementation accepts and processes
  PTP_PEROUT_DUTY_CYCLE (ksz_ptp_get_pin() returns -EOPNOTSUPP only for…
- [Low] ksz_ptp_clock_unregister() only calls ptp_clock_unregister(); it
  never disables the trigger units that the perout path enabled.

--

net: dsa: microchip: add periodic output support for the KSZ8463

This adds KSZ8463 specific periodic output handling, since the chip has one
configuration register block per trigger unit, a smaller maximum pulse
width and 12 outputs instead of 2.  It wires new ksz8463_ptp_* callbacks
into a dedicated ksz8463_ptp_set_caps() and advertises 12 pins / 12
periodic output channels for the KSZ8463.

A few questions on the new code below.

> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index f2a23e2e474ac..6b08bb8fed5b7 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c
> @@ -2478,7 +2478,7 @@ static int ksz8463_setup(struct dsa_switch *ds)
>  		if (ret)
>  			goto free_girq;
>  
> -		ksz_ptp_set_caps(ds);
> +		ksz8463_ptp_set_caps(ds);

[Severity: Medium]
Does this still build with CONFIG_NET_DSA_MICROCHIP_KSZ_PTP=n?

This call site is not inside any #ifdef (it is only guarded by
"if (dev->irq > 0)"), and ksz_ptp.h declares the new symbol only in the
PTP-enabled branch:

drivers/net/dsa/microchip/ksz_ptp.h
  #if IS_ENABLED(CONFIG_NET_DSA_MICROCHIP_KSZ_PTP)
  ...
  void ksz_ptp_set_caps(struct dsa_switch *ds);
  void ksz8463_ptp_set_caps(struct dsa_switch *ds);

The #else branch stubs every other PTP entry point that ksz8.c uses
(ksz_ptp_set_caps(), ksz_ptp_clock_register(), ksz_ptp_clock_unregister(),
ksz8463_ptp_irq_setup(), ksz8463_ptp_irq_free()) but has no stub for
ksz8463_ptp_set_caps():

  static inline void ksz_ptp_set_caps(struct dsa_switch *ds) { }

ksz_ptp.o is also not linked in that configuration, since the Makefile
guards it with "ifdef CONFIG_NET_DSA_MICROCHIP_KSZ_PTP".  Previously this
line called ksz_ptp_set_caps(), which does have a stub.  Would adding
"static inline void ksz8463_ptp_set_caps(struct dsa_switch *ds) { }" to the
#else branch be the intent?

>  		ret = ksz_ptp_clock_register(ds);
>  		if (ret) {
>  			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 041bb4f963659..9e234ad71b723 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1161,6 +1161,8 @@ const struct ksz_chip_data ksz_switch_chips[] = {
>  		.supports_mii = {false, false, true},
>  		.supports_rmii = {false, false, true},
>  		.internal_phy = {true, true, false},
> +		.n_pins = 12,
> +		.n_per_out = 12,
>  	},
>  
>  	[KSZ8563] = {
> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 0a77b46cfad25..d33034892a8f6 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c

[ ... ]

> @@ -120,6 +132,28 @@ static int ksz_ptp_tou_target_time_set(struct ksz_device *dev,
>  	return 0;
>  }
>  
> +static int ksz8463_ptp_tou_start(struct ksz_device *dev, u8 unit)
> +{
> +	u16 data;
> +	int ret;
> +
> +	ret = ksz_rmw16(dev, KSZ8463_TOU_EN, BIT(unit), BIT(unit));
> +	if (ret)
> +		return ret;

[Severity: High]
Does the software reset actually stop the pulse train, or does
KSZ8463_TOU_EN have to be cleared as well?

ksz8463_ptp_tou_reset() only pulses BIT(unit) in KSZ8463_TOU_SW_RST
and leaves KSZ8463_TOU_EN untouched, but that is the register
ksz8463_ptp_tou_start() writes to arm the unit.  Compare the generic
path: ksz_ptp_tou_reset() explicitly drops the enable bit as its last
step,

	/* Clear reset and set GPIO direction */
	return ksz_rmw32(dev, REG_PTP_CTRL_STAT__4, (TRIG_RESET | TRIG_ENABLE),
			 0);

while the KSZ8463 version has no equivalent for BIT(unit) in
KSZ8463_TOU_EN.

That matters for the disable path in ksz8463_ptp_enable_perout(),
which handles "on == 0" purely by calling ksz8463_ptp_tou_reset() and
then setting ptp_data->tou_mode to KSZ_PTP_TOU_IDLE.  If the enable
bit survives the reset, a PTP_PEROUT_REQUEST with a zero period keeps
the output toggling on the pin while software believes the unit is
idle, so settime/adjtime will no longer even realign it.  Reachable
from plain userspace: enable a perout on /dev/ptpN, then disable it.

Could you confirm against the datasheet whether writing SW_RST
self-clears TOU_EN?  If it does not, should the !on branch (or
ksz8463_ptp_tou_reset() itself, mirroring ksz_ptp_tou_reset()) also
clear BIT(unit) in KSZ8463_TOU_EN?

[Severity: Low]
This isn't an issue introduced by this patch, but once a unit has been
armed here via KSZ8463_TOU_EN, is anything expected to turn it off at
teardown?  ksz_ptp_clock_unregister() only does:

	ptp_data = &dev->ptp_data;

	if (ptp_data->clock)
		ptp_clock_unregister(ptp_data->clock);

so after unbinding the driver the enabled trigger units keep toggling the
pins with no owning software state.  The same gap already exists for the
ksz9477/lan937x trigger units, so this is only an observation about the new
users of that path.

> +
> +	ret = ksz_read16(dev, KSZ8463_TOU_ACTIVE, &data);
> +	if (ret)
> +		return ret;
> +
> +	if (!(data & BIT(unit))) {
> +		dev_err(dev->dev, "%s: Trigger unit%d error!\n", __func__,
> +			unit);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ksz_ptp_tou_start(struct ksz_device *dev, u8 unit)
>  {
>  	u32 data;
> @@ -147,6 +181,56 @@ static int ksz_ptp_tou_start(struct ksz_device *dev, u8 unit)
>  	return 0;
>  }
>  
> +static int ksz8463_ptp_configure_perout(struct ksz_device *dev,
> +					u32 cycle_width_ns, u32 pulse_width_ns,
> +					struct timespec64 const *target_time,
> +					u8 index)
> +{
> +	struct ptp_pin_desc *pin = &dev->ptp_data.pin_config[index];
> +	u16 cfg_base = KSZ8463_TRIG1_CFG + KSZ8463_TRIGN_CFG_SIZE * pin->chan;

[Severity: Medium]
Should this error path undo the KSZ8463_TOU_EN write that precedes
it?

ksz8463_ptp_tou_start() sets BIT(unit) in KSZ8463_TOU_EN and then
returns -EIO if the unit does not show up in KSZ8463_TOU_ACTIVE,
leaving the enable bit set in hardware.  The caller,
ksz8463_ptp_enable_perout(), propagates the error without setting
ptp_data->tou_mode, so the unit is left armed with no software state
claiming it.

The generic ksz_ptp_tou_start() can get away with a bare return
because of its "Unit will be reset on next access" assumption:
ksz_ptp_tou_reset() clears TRIG_ENABLE at the start of the next
enable.  As noted on ksz8463_ptp_tou_reset(), the KSZ8463 reset only
toggles KSZ8463_TOU_SW_RST and never touches KSZ8463_TOU_EN, so that
assumption does not carry over here and the stale enable bit is not
cleaned up on the next request either.

Would clearing BIT(unit) in KSZ8463_TOU_EN before returning -EIO be
the right thing, or is it preferable to make ksz8463_ptp_tou_reset()
clear the enable bit so the existing "reset on next access" pattern
holds for this chip too?

[Severity: Medium]
Which lock protects pin_config[] here?

pin_config is owned by the PTP core and documented as protected by
ptp_clock::pincfg_mux in drivers/ptp/ptp_private.h:

	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */

The core takes that mutex around the enable() callback, but the new restart
path reaches this function from clock_settime()/clock_adjtime() with only
ptp_data->lock held:

ksz8463_ptp_settime()/ksz8463_ptp_adjtime()
  -> ksz8463_ptp_restart_perout()
    -> ksz8463_ptp_enable_perout()
      -> ksz_ptp_get_pin()            /* calls ptp_find_pin() */
      -> ksz8463_ptp_configure_perout()

Meanwhile PTP_PIN_SETFUNC writes pin->func and pin->chan in
ptp_set_pinfunc() under pincfg_mux only.  If chan changes while this runs,
cfg_base can select a different trigger unit's register block than the one
ksz8463_ptp_tou_reset()/ksz8463_ptp_tou_start() operate on
(request->index), so one unit gets programmed while another gets reset and
enabled.

Note that simply switching to ptp_find_pin_unlocked() would invert the lock
order against the enable() path, which already holds pincfg_mux before
ptp_data->lock.  Would snapshotting pin index and chan under ptp_data->lock
at enable() time work better?

The bare ptp_find_pin() call from settime/adjtime predates this patch for
ksz9477/lan937x; the new part is deriving a register block address from
pin->chan on that path.

> +	u16 data;
> +	int ret;
> +
> +	/* Hardware has only 32 bit */
> +	if ((target_time->tv_sec & 0xffffffff) != target_time->tv_sec)
> +		return -EINVAL;
> +
> +	data = KSZ8463_NOTIFY_BIT |
> +	       FIELD_PREP(KSZ8463_PATTERN_M, TRIG_POS_PERIOD) |
> +	       pin->index;
> +	ret = ksz_write16(dev, cfg_base + KSZ8463_PATTERN_OFF, data);
> +	if (ret)
> +		return ret;
> +

[ ... ]

> +	return 0;
> +}
> +
>  static int ksz_ptp_configure_perout(struct ksz_device *dev,
>  				    u32 cycle_width_ns, u32 pulse_width_ns,
>  				    struct timespec64 const *target_time,
> @@ -241,6 +325,58 @@ static u64 ksz_ptp_compute_perout_pulse(struct ksz_device *dev,
>  	return min_t(u64, req_pulse_width_ns, max_pulse_width);
>  }
>  
> +static int ksz8463_ptp_enable_perout(struct ksz_device *dev,
> +				     struct ptp_perout_request const *request,
> +				     int on)
> +{
> +	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
> +	u64 cycle_width_ns;
> +	u64 pulse_width_ns;
> +	int pin;
> +	int ret;
> +
> +	pin = ksz_ptp_get_pin(dev, request);
> +	if (pin < 0)
> +		return pin;
> +
> +	ret = ksz8463_ptp_tou_reset(dev, request->index);
> +	if (ret)
> +		return ret;
> +
> +	if (!on) {
> +		ptp_data->tou_mode = KSZ_PTP_TOU_IDLE;
> +		return 0;
> +	}
> +	ret = ksz_ptp_compute_perout_cycle(dev, request, &cycle_width_ns);
> +	if (ret)
> +		return ret;

[Severity: High]
This isn't a bug introduced by this patch, but the new KSZ8463 path
inherits it, so it may be worth a look: can a period of 0 ns be stored and
later used as a divisor?

ksz_ptp_compute_perout_cycle() saves the request into ptp_data before
validating it, and only checks that the converted value fits the cycle
width mask:

	ptp_data->perout_period.tv_sec = request->period.sec;
	ptp_data->perout_period.tv_nsec = request->period.nsec;

	*cycle_width_ns = timespec64_to_ns(&ptp_data->perout_period);
	if ((*cycle_width_ns & TRIG_CYCLE_WIDTH_M) != *cycle_width_ns) {

A non-normalized request with period.sec = -1 and period.nsec = 1000000000
is treated as "enable" by the core (perout->period.sec || perout->period.nsec
is true) and converts to 0 ns, which passes the mask check.  The default
pulse width then also computes to 0 and passes ksz_ptp_tou_pulse_verify().

No error path in ksz8463_ptp_enable_perout() resets tou_mode, so after a
previous successful enable the state stays KSZ_PTP_TOU_PEROUT with
perout_period converting to 0.  The next clock_settime()/clock_adjtime()
then runs ksz_ptp_prepare_restart_perout() with period_ns == 0:

	count = div_u64(now_ns - first_ns, period_ns);
	...
	while (next_ns < now_ns + 100000000)
		next_ns += period_ns;

which is a divide-by-zero on x86-64, and on arm64 (where UDIV by zero
returns 0) the loop never terminates while ptp_data->lock is held.  Would
rejecting a period whose nanosecond conversion is zero, and only committing
perout_period after validation, be appropriate here?

> +	pulse_width_ns = ksz_ptp_compute_perout_pulse(dev, request,
> +						      KSZ8463_MAX_PULSE_WIDTH);
> +
> +	ret = ksz_ptp_tou_pulse_verify(pulse_width_ns,
> +				       KSZ8463_TRIG_PULSE_WIDTH_M);
> +	if (ret)
> +		return ret;
> +
> +	ret = ksz8463_ptp_configure_perout(dev, cycle_width_ns, pulse_width_ns,
> +					   &ptp_data->perout_target_time_first,
> +					   pin);
> +	if (ret)
> +		return ret;
> +
> +	ret = ksz_ptp_tou_gpio(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ksz8463_ptp_tou_start(dev, request->index);
> +	if (ret)
> +		return ret;
> +
> +	ptp_data->tou_mode = KSZ_PTP_TOU_PEROUT;
> +
> +	return 0;
> +}
> +
>  static int ksz_ptp_enable_perout(struct ksz_device *dev,
>  				 struct ptp_perout_request const *request,
>  				 int on)
> @@ -845,6 +981,18 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
>  	return ksz_ptp_enable_perout(dev, &request, 1);
>  }
>  
> +static int ksz8463_ptp_restart_perout(struct ksz_device *dev)
> +{
> +	struct ptp_perout_request request;
> +	int ret;
> +
> +	ret = ksz_ptp_prepare_restart_perout(dev, &request);
> +	if (ret)
> +		return ret;
> +
> +	return ksz8463_ptp_enable_perout(dev, &request, 1);
> +}

[Severity: High]
Can a periodic output on a channel other than 0 be restarted after a clock
step?  ksz_ptp_prepare_restart_perout() hardcodes the channel:

	request->index = 0;
	request->flags = 0;

So with an output running on, say, channel 5:

ksz8463_ptp_settime()
  -> ksz8463_ptp_restart_perout()
    -> ksz_ptp_prepare_restart_perout()   /* request->index = 0 */
      -> ksz8463_ptp_enable_perout()
        -> ksz_ptp_get_pin()
          -> ptp_find_pin(clock, PTP_PF_PEROUT, 0)   /* no match, -1 */

ksz_ptp_get_pin() then returns -EINVAL, which is propagated out of
ksz8463_ptp_settime()/ksz8463_ptp_adjtime() after
__ksz_ptp_settime()/__ksz_ptp_adjtime() already reprogrammed the hardware
RTC.  The output is never realigned, the ioctl reports failure although the
clock did change, and the "goto unlock" also skips the ptp_data->clock_time
update used by ksz_tstamp_reconstruct() (that mirror is otherwise only
re-synced from ksz_ptp_do_aux_work(), which runs only while a port has
hardware timestamping enabled).

The reachable sequence is a plain /dev/ptpN one: PTP_PIN_SETFUNC assigns
pin 5 to PTP_PF_PEROUT chan 5 (ksz_ptp_verify_pin() accepts PTP_PF_PEROUT
for any pin/chan and ptp_set_pinfunc() only requires chan < n_per_out = 12),
then PTP_PEROUT_REQUEST index 5 succeeds and sets tou_mode =
KSZ_PTP_TOU_PEROUT, then clock_settime() or clock_adjtime().

Two related points on the same singleton state, now that .n_per_out = 12 is
advertised for the KSZ8463:

If some pin does happen to be mapped to chan 0, the restart reprograms and
starts trigger unit 0 using the globally shared perout_period and
perout_target_time_first of whichever channel was configured last, so the
wrong unit is armed while the running unit keeps a stale target time.

Also, the !on branch of ksz8463_ptp_enable_perout() sets the single
tou_mode to KSZ_PTP_TOU_IDLE no matter which of the 12 units was disabled:

	if (!on) {
		ptp_data->tou_mode = KSZ_PTP_TOU_IDLE;
		return 0;
	}

after which settime/adjtime take the IDLE case and any still-enabled unit
is not restarted at all.

Should struct ksz_ptp_data keep tou_mode, perout_period and
perout_target_time_first per unit, with the channel index preserved in the
restart request?

> +
>  static int __ksz_ptp_settime(struct ksz_device *dev,
>  			     const struct timespec64 *ts)
>  {
> @@ -871,6 +1019,41 @@ static int __ksz_ptp_settime(struct ksz_device *dev,
>  	return 0;
>  }
>  
> +static int ksz8463_ptp_settime(struct ptp_clock_info *ptp,
> +			       const struct timespec64 *ts)
> +{
> +	struct ksz_ptp_data *ptp_data = ptp_caps_to_data(ptp);
> +	struct ksz_device *dev = ptp_data_to_ksz_dev(ptp_data);
> +	int ret;
> +
> +	mutex_lock(&ptp_data->lock);
> +
> +	ret = __ksz_ptp_settime(dev, ts);
> +	if (ret)
> +		goto unlock;
> +
> +	switch (ptp_data->tou_mode) {
> +	case KSZ_PTP_TOU_IDLE:
> +		break;
> +
> +	case KSZ_PTP_TOU_PEROUT:
> +		ret = ksz8463_ptp_restart_perout(dev);
> +		if (ret)
> +			goto unlock;
> +
> +		break;
> +	}
> +
> +	spin_lock_bh(&ptp_data->clock_lock);
> +	ptp_data->clock_time = *ts;
> +	spin_unlock_bh(&ptp_data->clock_lock);
> +
> +unlock:
> +	mutex_unlock(&ptp_data->lock);
> +
> +	return ret;
> +}
> +
>  static int ksz_ptp_settime(struct ptp_clock_info *ptp,
>  			   const struct timespec64 *ts)
>  {

[ ... ]

> @@ -1095,6 +1332,27 @@ static int ksz_ptp_start_clock(struct ksz_device *dev)
>  	return 0;
>  }
>  
> +void ksz8463_ptp_set_caps(struct dsa_switch *ds)
> +{
> +	struct ksz_device *dev = ds->priv;
> +	struct ksz_ptp_data *ptp_data;
> +
> +	ptp_data = &dev->ptp_data;
> +
> +	ptp_data->caps.owner		= THIS_MODULE;
> +	snprintf(ptp_data->caps.name, 16, "Microchip Clock");
> +	ptp_data->caps.max_adj		= KSZ_MAX_DRIFT_CORR;
> +	ptp_data->caps.gettime64	= ksz_ptp_gettime;
> +	ptp_data->caps.settime64	= ksz8463_ptp_settime;
> +	ptp_data->caps.adjfine		= ksz_ptp_adjfine;
> +	ptp_data->caps.adjtime		= ksz8463_ptp_adjtime;
> +	ptp_data->caps.do_aux_work	= ksz_ptp_do_aux_work;
> +	ptp_data->caps.enable		= ksz8463_ptp_enable;
> +	ptp_data->caps.verify		= ksz_ptp_verify_pin;
> +	ptp_data->caps.n_pins		= dev->info->n_pins;
> +	ptp_data->caps.n_per_out	= dev->info->n_per_out;
> +}

[Severity: Low]
This is a pre-existing omission rather than something this patch
introduces, but should supported_perout_flags be set here too?

The driver handles PTP_PEROUT_DUTY_CYCLE (ksz_ptp_get_pin() only rejects
"request->flags & ~PTP_PEROUT_DUTY_CYCLE", and
ksz_ptp_compute_perout_pulse() consumes request->on for it), yet
caps.supported_perout_flags is left at zero, and ptp_perout_request() does:

	if (perout->flags & ~ops->supported_perout_flags)
		return -EOPNOTSUPP;

so the duty-cycle branch cannot be reached from the UAPI.  For the KSZ8463
in particular the maximum pulse width is 500 us, so the default 50 % duty
cycle is always clamped and the pulse width cannot be chosen at all.  The
existing ksz_ptp_set_caps() has the same omission.

>  void ksz_ptp_set_caps(struct dsa_switch *ds)
>  {
>  	struct ksz_device *dev = ds->priv;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902-ksz-perout-v2-0-6f277fcc9e68%40bootlin.com
