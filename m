Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C0B4AC150;
	Wed,  2 Sep 2026 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366433; cv=none; b=giXvYQ5ZOR0ERZL9WaBZLisVJIHBVtRRMyhxoQ2+1rBu279VotvFr+KxpbFCvHE6+muq3IMTIG3LQquT0UBi+pPJhi+YKCIDa4lvnZcI+VKZmXHWsi+/wIbutRUTzijmB8ZGH5zIQNXMqEZSoDpkw8IgAJO1I/MI0H7QsVGts2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366433; c=relaxed/simple;
	bh=oH3ncGb3JKNSx8H+K3qy/lJQKE04NDprQ8ln//ySUg0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F4clitjjV76ebDDvHHL+J2qKl2qyu+o5PMVibqs2WkzMYvfoe1BqWEDGrkVQXC+4ORXjIC2eXZ7Jw3RPT8j2NzZmp9OLy1fn2P/C0INfz1D+Nt1/1PpuWffHbTzKmgY220Vtgrk8OLz+D6rKRclRbDufRgRKR/RwLPIzdHithAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4Cnszf4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4Cnszf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4091F000E9;
	Wed,  2 Sep 2026 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788366429;
	bh=FXaZlsMK8JXBbZt1Z4P7VdCSZqpmr12M8FbqryJuAh0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g4Cnszf4/6CFr4c8nqSqWDNxAn+EvqFXEopqXb3r0p7hm4sFGIGB73S2YMO+URXir
	 K/VkbN92gnaBa5YNdL7zr2xMib1R48/Mf06lNIA0CQZLQW9w8USnw3/yPL3NVHoPfx
	 R7JsECM+dEQxudZNnzHUhleDDTbxZ++jifuQuKuH9w+CH9IC7PZ4PNMb1bvGc5ugw0
	 Hy54k25qoFz1BDxRAmCI/GxPNYBS4MrJf105AGT/HbmTeKrLQaB3Lv0WusuOEu709l
	 CdIAUrp/bm5fRirhxYt+yDLrVmTy6cSwhDmHhpNIKPECKNCnU/kN0vkw1a0hofDoMw
	 imWY2tIiJ2Hbg==
Subject: Re: [net-next,10/10] net: dsa: microchip: add periodic output support
 for the KSZ8463
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Sep 2026 16:27:08 +0000
Message-ID: <178836642875.3394541.921980791816644266@kernel.org>
In-Reply-To: <20260831-ksz-perout-v1-10-14202db763b3@bootlin.com>
References: <20260831-ksz-perout-v1-10-14202db763b3@bootlin.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 4 (1) · Low: 2

- [High] KSZ8463 advertises 12 periodic-output channels (.n_pins = 12 /
  .n_per_out = 12) but the driver keeps only one set of software state…
- [Medium] Nothing in the new KSZ8463 path ever clears the per-unit
  enable bit in KSZ8463_TOU_EN (0x206).
- [Medium] Build break with CONFIG_NET_DSA_MICROCHIP_KSZ_PTP=n:
  ksz8463_setup() (drivers/net/dsa/microchip/ksz8.c:2481) now calls…
- [Medium] ksz8463_ptp_enable_perout() performs destructive actions
  before validating the request and never reconciles state on failure.
- [Medium] ksz8463_ptp_configure_perout() (ksz_ptp.c:184) directly
  dereferences dev->ptp_data.pin_config[index], reading pin->chan to…
- [Low] Stale comment in the shared helper
  ksz_ptp_compute_perout_pulse(): 'Use a duty cycle of 50%.
- [Low] ksz8463_ptp_set_caps() (ksz_ptp.c:1335) does not set
  caps.supported_perout_flags, yet the KSZ8463 perout implementation…

Pre-existing issues:
- [High] A non-normalized periodic-output period is accepted and stored
  as zero nanoseconds, and the restart path then divides by it.
- [Medium] ksz_ptp_prepare_restart_perout() stores the 64-bit quotient
  div_u64(now_ns - first_ns, period_ns) in an 'unsigned int count'…

--

net: dsa: microchip: add periodic output support for the KSZ8463

This adds KSZ8463-specific periodic output support to the microchip DSA
driver, with per-unit trigger configuration register blocks, a smaller
maximum pulse width, and 12 advertised outputs instead of 2.

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
Does this build with CONFIG_NET_DSA_MICROCHIP_KSZ_PTP=n?

ksz8.o is built unconditionally, while the Makefile only adds ksz_ptp.o
inside "ifdef CONFIG_NET_DSA_MICROCHIP_KSZ_PTP".  In ksz_ptp.h, the new
declaration lives in the enabled branch:

  #if IS_ENABLED(CONFIG_NET_DSA_MICROCHIP_KSZ_PTP)
  ...
  void ksz8463_ptp_set_caps(struct dsa_switch *ds);

and the #else branch only provides the old stub:

  static inline void ksz_ptp_set_caps(struct dsa_switch *ds) { }

Every other KSZ8463-specific PTP entry point (ksz8463_ptp_irq_setup,
ksz8463_ptp_irq_free, ksz8463_get_ts_info, ksz8463_hwtstamp_set) does have
a stub or #define in the #else branch.  Should ksz8463_ptp_set_caps() get
one too, otherwise ksz8463_setup() is compiled with no declaration?

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 194c88cdd00bc..111f3014e5a97 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1161,6 +1161,8 @@ const struct ksz_chip_data ksz_switch_chips[] = {
>  		.supports_mii = {false, false, true},
>  		.supports_rmii = {false, false, true},
>  		.internal_phy = {true, true, false},
> +		.n_pins = 12,
> +		.n_per_out = 12,
>  	},

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 0a77b46cfad25..d33034892a8f6 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c

[ ... ]

> @@ -63,6 +64,17 @@ static int ksz_ptp_tou_gpio(struct ksz_device *dev)
>  			 LED_SRC_PTP_GPIO_1 | LED_SRC_PTP_GPIO_2);
>  }
>  
> +static int ksz8463_ptp_tou_reset(struct ksz_device *dev, u8 unit)
> +{
> +	int ret;
> +
> +	ret = ksz_rmw16(dev, KSZ8463_TOU_SW_RST, BIT(unit), BIT(unit));
> +	if (ret)
> +		return ret;
> +
> +	return ksz_rmw16(dev, KSZ8463_TOU_SW_RST, BIT(unit), 0);
> +}
> +

[Severity: Medium]
Should this also clear BIT(unit) in KSZ8463_TOU_EN?

The generic counterpart just below deliberately ends by clearing
TRIG_ENABLE (and write-1-clears the per-unit status bits):

  /* Clear reset and set GPIO direction */
  return ksz_rmw32(dev, REG_PTP_CTRL_STAT__4, (TRIG_RESET | TRIG_ENABLE),
                   0);

Here only KSZ8463_TOU_SW_RST is pulsed, and the disable path in
ksz8463_ptp_enable_perout() returns right after it:

  ret = ksz8463_ptp_tou_reset(dev, request->index);
  if (ret)
          return ret;

  if (!on) {
          ptp_data->tou_mode = KSZ_PTP_TOU_IDLE;
          return 0;
  }

If asserting the software reset bit does not itself clear TOU_EN, does the
unit keep driving the pin after userspace disabled it while the driver
reports KSZ_PTP_TOU_IDLE?

There is a second consequence on the re-arm path, see the note on
ksz8463_ptp_tou_start() below.

>  static int ksz_ptp_tou_reset(struct ksz_device *dev, u8 unit)
>  {
>  	u32 data;

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

[Severity: Medium]
Continuing the note above: if BIT(unit) is still set in KSZ8463_TOU_EN when
the restart path reaches here, does ksz_rmw16() actually emit a write?

The KSZ8463 regmap config uses .cache_type = REGCACHE_NONE with no
reg_update_bits, and _regmap_update_bits() only writes when the value
changes:

  drivers/base/regmap/regmap.c:_regmap_update_bits() {
          ...
          if (force_write || (tmp != orig) || map->force_write_field) {
                  ret = _regmap_write(map, reg, tmp);
          ...
  }

So no 0->1 edge would be generated to latch the freshly written
TARGET_SEC/TARGET_NSEC, and the KSZ8463_TOU_ACTIVE check right after would
pass on the stale ACTIVE bit, making
ksz8463_ptp_settime()/ksz8463_ptp_adjtime() return success while the unit
still runs against the pre-step target time.

Also on the -EIO exit here, BIT(unit) is left set in KSZ8463_TOU_EN while
tou_mode is never advanced to KSZ_PTP_TOU_PEROUT.  Should the enable bit be
cleared before returning the error?

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
Is pin_config[] safe to dereference here on the settime/adjtime path?

pin_config[] is owned by the PTP core and protected by
ptp_clock::pincfg_mux, which the core holds only around ->enable():

  drivers/ptp/ptp_chardev.c:ptp_perout_request() {
          ...
          scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &ptp->pincfg_mux)
                  return ops->enable(ops, &req, perout->period.sec || perout->period.nsec);
  }

The new path ksz8463_ptp_settime()/ksz8463_ptp_adjtime() ->
ksz8463_ptp_restart_perout() -> ksz8463_ptp_enable_perout() ->
ksz8463_ptp_configure_perout() only holds the driver-private
ptp_data->lock.  Can a concurrent PTP_PIN_SETFUNC change pin->chan
underneath, so that cfg_base points at a different trigger unit than
BIT(request->index) which ksz8463_ptp_tou_start() enables?

Note that simply taking pincfg_mux here would invert the order used by the
->enable() path (pincfg_mux then ptp_data->lock); caching pin/chan under
pincfg_mux at enable() time would avoid that.

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

[ ... ]

> +	return 0;
> +}
> +
>  static int ksz_ptp_configure_perout(struct ksz_device *dev,
>  				    u32 cycle_width_ns, u32 pulse_width_ns,
>  				    struct timespec64 const *target_time,

[ ... ]

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

[Severity: Medium]
Can a rejected request leave the driver and hardware out of sync here?

The unit is reset before any of the timing values are validated, and
ksz_ptp_compute_perout_cycle() stores the requested period before deciding
it is out of range:

  ptp_data->perout_period.tv_sec = request->period.sec;
  ptp_data->perout_period.tv_nsec = request->period.nsec;

  *cycle_width_ns = timespec64_to_ns(&ptp_data->perout_period);
  if ((*cycle_width_ns & TRIG_CYCLE_WIDTH_M) != *cycle_width_ns) {
          *cycle_width_ns = 0;
          return -EINVAL;
  }

So with a perout already active (tou_mode == KSZ_PTP_TOU_PEROUT), a
PTP_PEROUT_REQUEST with an out-of-range period stops the running unit,
overwrites perout_period with the rejected value, and returns while
tou_mode still says PEROUT.  Every later
ksz8463_ptp_settime()/ksz8463_ptp_adjtime() then rebuilds the request from
that stored period and fails again, after the RTC has already been
written.  An SPI error in one of the six writes in
ksz8463_ptp_configure_perout() gives the same half-programmed state.
Should validation happen before the unit reset and before the state is
committed?

> +	pulse_width_ns = ksz_ptp_compute_perout_pulse(dev, request,
> +						      KSZ8463_MAX_PULSE_WIDTH);

[Severity: Low]
This isn't a bug, but the comment in ksz_ptp_compute_perout_pulse() is now
stale for this caller:

  /* Use a duty cycle of 50%. Maximum pulse width supported by the
   * hardware is a little bit more than 125 ms.
   */

The maximum is a parameter now, and this call passes
KSZ8463_MAX_PULSE_WIDTH = 500000LL, i.e. 0.5 ms.  Could the comment be
made generic or moved to the callers?

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

[ ... ]

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
> +

[Severity: High]
Does this work for channels other than 0?

ksz_ptp_prepare_restart_perout() hardcodes the channel and drops the flags:

  request->index = 0;
  request->flags = 0;

but this chip now advertises .n_pins = 12 and .n_per_out = 12, and
struct ksz_ptp_data keeps a single tou_mode / perout_target_time_first /
perout_period for all of them.

With a perout armed on, say, channel 3 (PTP_PIN_SETFUNC accepts it,
ksz_ptp_verify_pin() only filters on func and the core only checks
chan < n_per_out), the restart path becomes:

  ksz8463_ptp_adjtime()
    ksz8463_ptp_restart_perout()
      ksz_ptp_prepare_restart_perout()   /* index = 0 */
        ksz8463_ptp_enable_perout()
          ksz_ptp_get_pin()
            ptp_find_pin(clock, PTP_PF_PEROUT, 0)   /* no such pin */

so -EINVAL is returned, and this happens after __ksz_ptp_adjtime() has
already stepped the RTC:

  ret = __ksz_ptp_adjtime(dev, delta);
  if (ret)
          goto unlock;
  ...
  case KSZ_PTP_TOU_PEROUT:
          ret = ksz8463_ptp_restart_perout(dev);
          if (ret)
                  goto unlock;

The "goto unlock" also skips the ptp_data->clock_time update.  Since
ptp4l/phc2sys call adjtime/adjfine continuously, would every PHC adjust
fail for 11 of the 12 channels the commit advertises?  And if some pin does
happen to be mapped to channel 0, unit 0 gets reprogrammed with whatever
timing is stored in the single set of fields while the genuinely active
unit keeps its pre-step target.

Related to the single set of state fields: units 1..11 are never re-armed,
"request->flags = 0" discards PTP_PEROUT_DUTY_CYCLE on every restart,
enabling a second channel overwrites the first channel's stored timing, and
disabling any one channel sets the global tou_mode to KSZ_PTP_TOU_IDLE
while the other units stay enabled in hardware.  Should the per-unit state
be tracked per channel, and should the restart carry the real index?

[Severity: High]
This isn't a bug introduced by this patch, but the new caller of
ksz_ptp_prepare_restart_perout() adds a second path to it, so it is worth
raising: can a stored period of zero nanoseconds divide by zero here?

struct ptp_clock_time has a signed sec and an unsigned nsec, and
ptp_perout_request() validates flags, reserved fields, duty
cycle/phase and "index < n_per_out", but never normalization or
positivity; it decides "on" from "period.sec || period.nsec".  A period of
{sec = -1, nsec = 1000000000} is therefore treated as an enable, while
timespec64_to_ns() evaluates it to 0, which passes both checks:

  *cycle_width_ns = timespec64_to_ns(&ptp_data->perout_period);
  if ((*cycle_width_ns & TRIG_CYCLE_WIDTH_M) != *cycle_width_ns) {

and ksz_ptp_tou_pulse_verify(0) passes too.  A later settime/adjtime then
reaches:

  period_ns = timespec64_to_ns(&ptp_data->perout_period);

  if (first_ns < now_ns) {
          count = div_u64(now_ns - first_ns, period_ns);
  ...
  while (next_ns < now_ns + 100000000)
          next_ns += period_ns;

which is either a divide-error with a zero divisor, or a loop that never
advances, both with ptp_data->lock held.  Should non-normalized times be
rejected and the converted period required to be strictly positive before
it is stored?

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but this new
function adds another caller: ksz_ptp_prepare_restart_perout() stores the
64-bit quotient in an unsigned int:

  unsigned int count;
  ...
  if (first_ns < now_ns) {
          count = div_u64(now_ns - first_ns, period_ns);
          next_ns = first_ns + count * period_ns;
  ...
  /* Ensure 100 ms guard time prior next event */
  while (next_ns < now_ns + 100000000)
          next_ns += period_ns;

Once more than UINT_MAX periods have elapsed (about 72 minutes with a 1 us
period, about 50 days with 1 ms), count truncates and the guard-time loop
has to catch up one period at a time, up to roughly 4.29e9 iterations with
ptp_data->lock held.  Would a u64 count avoid that stall?

>  static int __ksz_ptp_settime(struct ksz_device *dev,
>  			     const struct timespec64 *ts)
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
> +

[Severity: Low]
Should caps.supported_perout_flags be set to PTP_PEROUT_DUTY_CYCLE here?

The implementation accepts that flag:

  ksz_ptp_get_pin():
          if (request->flags & ~PTP_PEROUT_DUTY_CYCLE)
                  return -EOPNOTSUPP;

and ksz_ptp_compute_perout_pulse() consumes request->on when it is set, but
the core rejects it first:

  drivers/ptp/ptp_chardev.c:ptp_perout_request() {
          ...
          if (perout->flags & ~ops->supported_perout_flags)
                  return -EOPNOTSUPP;
  }

so with supported_perout_flags left at 0 the duty-cycle handling is
unreachable.  The same omission exists in ksz_ptp_set_caps().

>  void ksz_ptp_set_caps(struct dsa_switch *ds)
>  {
>  	struct ksz_device *dev = ds->priv;
> diff --git a/drivers/net/dsa/microchip/ksz_ptp.h b/drivers/net/dsa/microchip/ksz_ptp.h
> index 89716b31596b5..92589cf373ac2 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.h
> +++ b/drivers/net/dsa/microchip/ksz_ptp.h
> @@ -12,7 +12,7 @@
>  
>  #include <linux/ptp_clock_kernel.h>
>  
> -#define KSZ_PTP_N_GPIO		2
> +#define KSZ_PTP_N_GPIO		12
>  
>  enum ksz_ptp_tou_mode {
>  	KSZ_PTP_TOU_IDLE,
> @@ -34,6 +34,7 @@ struct ksz_ptp_data {
>  };
>  
>  void ksz_ptp_set_caps(struct dsa_switch *ds);
> +void ksz8463_ptp_set_caps(struct dsa_switch *ds);
>  int ksz_ptp_clock_register(struct dsa_switch *ds);
>  
>  void ksz_ptp_clock_unregister(struct dsa_switch *ds);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-ksz-perout-v1-0-14202db763b3%40bootlin.com
