Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045CA457E78;
	Sun, 11 Oct 2026 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747901; cv=none; b=MXt7kXqxidu88wNYd8+IIdladUdlXYTMk5BjURxE9mjUqHMvtvvv4VKH6t6GnGP5mxtkhduQNaCehVtfYBD/vT9S3Uz/65ESzKwrOkHwqLrv6JEE6d+jqIjt5NPxxyR8b77cOTTP4gVWH9vBIXMwdt2Vy3zSvtuFio3J0i+bdu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747901; c=relaxed/simple;
	bh=kMH9blGCbs9f29kdy7fDGyKQPLiiCoH0esaZT2koz24=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qwlZaEQki72TIrh5scbbSjOcuqaYK+6+FLuZqks4/hFv5XAe8TbwwvoR+nA/Zxcdpihv/yAZydDhCe3+fOloo9pjU0DBws3ThJqq9K+wbpzVawcwSbIAU2n8yrgH14f5HHRE6/Obi4fHUYt1XUfm8JpLWOUGRZPhQAr9E0DAySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcTmaoSC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcTmaoSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B22E1F0089C;
	Sun, 11 Oct 2026 19:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791747899;
	bh=U0flNiJ7v3o97EKj/n2LpfXNiNXeicHoX7QQhY5reqg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OcTmaoSCOiQEcP4ZqqmeIm82DWRn6iRDCmbxLC7ntYBAtTVyRMM8F0TdPZc3LjqCy
	 bi6XhD0q+8cacxndL3Zydw15FZfMqVxtdSupofFyoyUqmSbfDOrzABg4S9y0XEmxI6
	 VZImlXcYX8v0ayVoMBUATtfugpmDE3Tftf12G1J+CP3rJkpf+5fq9bLRaA2TELPQY0
	 yFlzjEgne68LGwiSKUOJZtyyimx6QWXZwpgOtLFmFvDUWT2e4ftcHCSUfMKZgJp+Hg
	 +VpGmgZbG+1oWvgw7lDedOw53d98RERE2R9lVP15jfvHHbCi60foSVXOcrwNKWar8D
	 BoqrCfzqiQkRw==
Subject: Re: [PATCH net-next v7 2/3] ptp: Add driver for R-Car Gen4
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Sun, 11 Oct 2026 19:44:58 +0000
Message-ID: <179174789811.434549.12601708007184507869@kernel.org>
In-Reply-To: <20261007185920.4042783-3-niklas.soderlund+renesas@ragnatech.se>
References: <20261007185920.4042783-3-niklas.soderlund+renesas@ragnatech.se>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new standalone driver drives the same gPTP register block
  that drivers/net/ethernet/renesas/rcar_gen4_ptp.c already drives on…
- [Medium] ptp_rcar_gen4_probe() ignores the return value of
  pm_runtime_resume_and_get(dev) at line 179.
- [Medium] ptp: torn hardware state exposed during
  _ptp_rcar_gen4_settime()
- [Medium] ptp: potential time tearing in gettime due to unlatched
  sequential reads
- [Low] The binding (renesas,rcar-gen4-gptp.yaml) lists `resets` as
  required, and the V4H DTS node sets resets = <&cpg 2723>.
- [Low] The commit message for "ptp: Add driver for R-Car Gen4" has
  several typos and grammar errors in the only explanation of the…
- [Low] The PTPTIVC0 comment in ptp_rcar_gen4_probe() (lines 170-174) has
  'perid' for 'period' and calls bits[26:0] 'decimal' when they are a…
- [Low] In ptp_rcar_gen4_probe(), the timer is enabled (iowrite32(1,
  PTPTMEC_REG), line 182) before the fallible ptp_clock_register() call.

--

ptp: Add driver for R-Car Gen4

This commit adds a standalone platform driver for the gPTP timer block
found on R-Car Gen4 SoCs (S4, V4H and V4M). The driver maps the timer
registers, programs the default increment from the module clock rate, and
registers a PTP clock with adjfine, adjtime, gettime64 and settime64 ops.

> Add driver for the gPTP timer found on R-Car Gen4 devices. The timer is
> system-wide and shared by different Ethernet devices on each Gen4
> platform. The operation of the timer is however not completely in
> depended of the systems Ethernet devices.
>
>   - On R-Car S4 is gated by the RSWITCH Ethernet module clock.
>
>   - On R-Car V4H is gated by the RTSN Ethernet module clock.
>
>   - On R-Car V4M is gated by its own module clock, the system have
>     neither RTSN or RSWITCH device. But the module clock is the same as
>     RTSN on V4H and the documentation referees to it as tsn (EtherTSN).
>
> The gPTP device do have its own register space on all three platforms.

[Severity: Low]
This isn't a bug, but there are a few typos and grammar errors in the
commit message:

  "not completely in depended of" -> "not completely independent of"
  "On R-Car S4 is gated" -> "On R-Car S4 it is gated"
  "On R-Car V4H is gated" -> "On R-Car V4H it is gated"
  "the system have" -> "the system has"
  "the documentation referees to it" -> "the documentation refers to it"
  "The gPTP device do have" -> "The gPTP device does have"

> diff --git a/drivers/ptp/ptp_rcar_gen4.c b/drivers/ptp/ptp_rcar_gen4.c
> new file mode 100644
> index 0000000000000..e82b6c5abc306
> --- /dev/null
> +++ b/drivers/ptp/ptp_rcar_gen4.c
> @@ -0,0 +1,225 @@

[ ... ]

> +static int ptp_rcar_gen4_probe(struct platform_device *pdev)
> +{
> +	struct ptp_rcar_gen4_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	unsigned long rate;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);

[Severity: Medium]
Is this the same register block that
drivers/net/ethernet/renesas/rcar_gen4_ptp.c already drives for RTSN (V4H)
and RSWITCH (S4)? The register offsets, the adjfine, gettime, settime and
adjtime bodies, the addend formula and max_adj all look like a copy of that
code. The commit message doesn't mention the existing implementation or
explain how the two are meant to coexist.

On V4H, the gptp node added in this series and the existing tsn0 node in
r8a779g0.dtsi describe the same range:

    gptp: ptp@e6449000 { ... reg = <0 0xe6449000 0 0x500>; ... }
    tsn0: ethernet@e6460000 {
        reg = <0 0xe6460000 0 0x7000>, <0 0xe6449000 0 0x500>;
        reg-names = "tsnes", "gptp";
        ...
    }

rtsn_probe() requests the "gptp" region with devm_ioremap_resource() and
registers its own PHC through rcar_gen4_ptp_register(). Here,
ptp_rcar_gen4_probe() requests the same region again through
devm_platform_ioremap_resource().

If a board enables both &gptp (so RAVB can use it through "ptp-timer") and
&tsn0, does whichever device probes second fail with -EBUSY? That would
lose either the RTSN network interface or the standalone PHC.

The DTS commit in this series says the module "is shared between the RAVB
and RTSN Ethernet devices", but rtsn and rswitch are left unchanged. Is
there a plan to move them over to this driver?

> +
> +	priv->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);

[Severity: Low]
The renesas,rcar-gen4-gptp.yaml binding lists resets as required, and the
V4H node uses resets = <&cpg 2723>. Should probe also get and deassert
the reset? ptp_rcar_gen4_probe() gets only the register range and the
clock, and ptp_rcar_gen4_remove() never asserts a reset.

Suppose the module reset is still asserted at boot, for example on V4M
where the gPTP block has its own reset. Would the PTPTIVC0 and PTPTMEC
writes later in probe have any effect? A PHC would still be registered.

The commit message also says the reset is shared with RTSN on V4H, and
rtsn_reset() pulses it with reset_control_reset(). Without a reset handle,
how would this driver coordinate with that, or reprogram the timer after
the pulse?

[ ... ]

> +	/* Default timer increment in ns.
> +	 * bit[31:27] - integer
> +	 * bit[26:0]  - decimal
> +	 * increment[ns] = perid[ns] * 2^27 => (1ns * 2^27) / rate[hz]
> +	 */
> +
> +	priv->default_addend = div_s64(1000000000LL << 27, rate);

[Severity: Low]
This isn't a bug, but the comment has a typo (perid -> period). Also,
bits [26:0] are a binary fraction rather than decimal.

The formula in the comment doesn't match the code either. The code
computes period[ns] * 2^27 = (1e9 * 2^27) / rate[Hz], not
(1ns * 2^27) / rate[hz].

The comment looks like it was copied from
rcar_gen4_ptp_rate_to_increment() in
drivers/net/ethernet/renesas/rcar_gen4_ptp.c.

> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_resume_and_get(dev);

[Severity: Medium]
Should the return value of pm_runtime_resume_and_get() be checked here?
The v6 changelog says pm_runtime_get_sync() was replaced so that failures
could be handled, but the result is still ignored.

When pm_runtime_resume_and_get() fails, it drops the usage count itself
and returns the error. The device is not resumed and no reference is held.
Probe then goes on to do this:

    iowrite32(priv->default_addend, priv->base + PTPTIVC0_REG);
    iowrite32(1, priv->base + PTPTMEC_REG);

The driver never calls clk_prepare_enable(). The module clock is only
turned on by the runtime PM resume, so these writes may go to an unclocked
block.

ptp_clock_register() can still succeed after that. Userspace would then
get a PHC whose gettime, settime and adjtime access unclocked MMIO.

The later puts would also be unbalanced: the pm_runtime_put_sync() in the
ptp_clock_register() error path below, and the one in
ptp_rcar_gen4_remove():

    iowrite32(1, priv->base + PTPTMDC_REG);

    pm_runtime_put_sync(dev);
    pm_runtime_disable(dev);

Wouldn't rpm_drop_usage_count() then warn "Runtime PM usage count
underflow!"?

> +
> +	iowrite32(priv->default_addend, priv->base + PTPTIVC0_REG);
> +	iowrite32(1, priv->base + PTPTMEC_REG);
> +
> +	priv->clock = ptp_clock_register(&priv->info, dev);
> +	if (IS_ERR(priv->clock)) {
> +		pm_runtime_put_sync(dev);
> +		pm_runtime_disable(dev);
> +		return PTR_ERR(priv->clock);
> +	}

[Severity: Medium]
_ptp_rcar_gen4_settime() first stops the timer and clears the three
PTPTOVC offset registers. It then writes PTPTMEC to start the timer
again, and only after that programs the new offset. Between the
PTPTMEC write and the final PTPTOVC00 write, the counter runs with a
zero or partially written offset.

This timer is the time base shared by the Ethernet MACs on these SoCs
(RSWITCH, RTSN, and RAVB through ptp-timer). Could a packet that is
timestamped inside that window get a time near zero? Could it get the
new upper seconds word combined with a stale lower word?

The same window opens on every ptp_rcar_gen4_adjtime() call, since it
goes through this helper. So this is not limited to an initial
settime.

Is there a reason the timer has to be enabled before the offset is
loaded? If the hardware allows it, writing PTPTOVC20, PTPTOVC10 and
PTPTOVC00 while the timer is still stopped, and only then writing
PTPTMEC, would close the window.

If the hardware instead applies the offset atomically on the PTPTOVC00
write, could a comment say so? In that case, is the intermediate
zeroing of the offset registers needed at all?

[Severity: Low]
The PTPTMEC write above starts the timer before ptp_clock_register(),
which can fail. Should this error path also stop the timer, the way
ptp_rcar_gen4_remove() does before it drops runtime PM?

    iowrite32(1, priv->base + PTPTMDC_REG);

On S4 and V4H the gating clock belongs to RSWITCH or RTSN and may stay
on. Could the counter then keep running with no driver bound?

> +
> +	return 0;
> +}

[ ... ]

> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Renesas R-Car Gen4 gPTP device driver
> + *
> + * Copyright (C) 2026 Renesas Electronics Corporation
> + * Copyright (C) 2026 Niklas Söderlund <niklas.soderlund@ragnatech.se>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/ptp_clock_kernel.h>
> +#include <linux/types.h>
> +
> +#define PTPTMEC_REG		0x0010
> +#define PTPTMDC_REG		0x0014
> +#define PTPTIVC0_REG		0x0020
> +#define PTPTOVC00_REG		0x0030
> +#define PTPTOVC10_REG		0x0034
> +#define PTPTOVC20_REG		0x0038
> +#define PTPGPTPTM00_REG		0x0050
> +#define PTPGPTPTM10_REG		0x0054
> +#define PTPGPTPTM20_REG		0x0058
> +
> +struct ptp_rcar_gen4_priv {
> +	void __iomem *base;
> +	struct clk *clk;
> +
> +	struct ptp_clock *clock;
> +	struct ptp_clock_info info;
> +
> +	spinlock_t lock;	/* Registers access. */
> +	s64 default_addend;
> +};
> +
> +#define ptp_to_priv(ptp) container_of(ptp, struct ptp_rcar_gen4_priv, info)
> +
> +static int ptp_rcar_gen4_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> +{
> +	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
> +	s64 addend = priv->default_addend;
> +	bool neg_adj = scaled_ppm < 0;
> +	unsigned long flags;
> +	s64 diff;
> +
> +	if (neg_adj)
> +		scaled_ppm = -scaled_ppm;
> +	diff = div_s64(addend * scaled_ppm_to_ppb(scaled_ppm), NSEC_PER_SEC);
> +	addend = neg_adj ? addend - diff : addend + diff;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	iowrite32(addend, priv->base + PTPTIVC0_REG);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static void _ptp_rcar_gen4_gettime(struct ptp_clock_info *ptp,
> +				   struct timespec64 *ts)
> +{
> +	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
> +
> +	lockdep_assert_held(&priv->lock);
> +
> +	ts->tv_nsec = ioread32(priv->base + PTPGPTPTM00_REG);
> +	ts->tv_sec = ioread32(priv->base + PTPGPTPTM10_REG) |
> +		((s64)ioread32(priv->base + PTPGPTPTM20_REG) << 32);
> +}
> +
> +static int ptp_rcar_gen4_gettime(struct ptp_clock_info *ptp,
> +				 struct timespec64 *ts)
> +{
> +	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	_ptp_rcar_gen4_gettime(ptp, ts);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static void _ptp_rcar_gen4_settime(struct ptp_clock_info *ptp,
> +				   const struct timespec64 *ts)
> +{
> +	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
> +
> +	lockdep_assert_held(&priv->lock);
> +
> +	iowrite32(1, priv->base + PTPTMDC_REG);
> +	iowrite32(0, priv->base + PTPTOVC20_REG);
> +	iowrite32(0, priv->base + PTPTOVC10_REG);
> +	iowrite32(0, priv->base + PTPTOVC00_REG);
> +	iowrite32(1, priv->base + PTPTMEC_REG);
> +	iowrite32(ts->tv_sec >> 32, priv->base + PTPTOVC20_REG);
> +	iowrite32(ts->tv_sec, priv->base + PTPTOVC10_REG);
> +	iowrite32(ts->tv_nsec, priv->base + PTPTOVC00_REG);
> +}
> +
> +static int ptp_rcar_gen4_settime(struct ptp_clock_info *ptp,
> +				 const struct timespec64 *ts)
> +{
> +	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	_ptp_rcar_gen4_settime(ptp, ts);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int ptp_rcar_gen4_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +{
> +	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
> +	struct timespec64 ts;
> +	unsigned long flags;
> +	s64 now;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	_ptp_rcar_gen4_gettime(ptp, &ts);
> +	now = ktime_to_ns(timespec64_to_ktime(ts));
> +	ts = ns_to_timespec64(now + delta);
> +	_ptp_rcar_gen4_settime(ptp, &ts);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static struct ptp_clock_info ptp_rcar_gen4_info = {
> +	.owner = THIS_MODULE,
> +	.name = "R-Car Gen4 gPTP",
> +	.max_adj = 50000000,
> +	.adjfine = ptp_rcar_gen4_adjfine,
> +	.adjtime = ptp_rcar_gen4_adjtime,
> +	.gettime64 = ptp_rcar_gen4_gettime,
> +	.settime64 = ptp_rcar_gen4_settime,
> +};
> +
> +static int ptp_rcar_gen4_probe(struct platform_device *pdev)
> +{
> +	struct ptp_rcar_gen4_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	unsigned long rate;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
> +	rate = clk_get_rate(priv->clk);
> +	if (!rate)
> +		return -ENODEV;
> +
> +	spin_lock_init(&priv->lock);
> +
> +	priv->info = ptp_rcar_gen4_info;
> +
> +	/* Default timer increment in ns.
> +	 * bit[31:27] - integer
> +	 * bit[26:0]  - decimal
> +	 * increment[ns] = perid[ns] * 2^27 => (1ns * 2^27) / rate[hz]
> +	 */
> +
> +	priv->default_addend = div_s64(1000000000LL << 27, rate);
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_resume_and_get(dev);
> +
> +	iowrite32(priv->default_addend, priv->base + PTPTIVC0_REG);
> +	iowrite32(1, priv->base + PTPTMEC_REG);
> +
> +	priv->clock = ptp_clock_register(&priv->info, dev);
> +	if (IS_ERR(priv->clock)) {
> +		pm_runtime_put_sync(dev);
> +		pm_runtime_disable(dev);
> +		return PTR_ERR(priv->clock);
> +	}
> +
> +	return 0;
> +}
> +
> +static void ptp_rcar_gen4_remove(struct platform_device *pdev)
> +{
> +	struct ptp_rcar_gen4_priv *priv = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +
> +	ptp_clock_unregister(priv->clock);
> +
> +	iowrite32(1, priv->base + PTPTMDC_REG);
> +
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +}
> +
> +static const struct of_device_id ptp_rcar_gen4_of_match[] = {
> +	{ .compatible = "renesas,rcar-gen4-gptp", },
> +	{ /* Sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, ptp_rcar_gen4_of_match);
> +
> +static struct platform_driver ptp_rcar_gen4_driver = {
> +	.driver = {
> +		.name = "ptp-rcar-gen4",
> +		.of_match_table = ptp_rcar_gen4_of_match,
> +	},
> +	.probe    = ptp_rcar_gen4_probe,
> +	.remove   = ptp_rcar_gen4_remove,
> +};
> +module_platform_driver(ptp_rcar_gen4_driver);
> +
> +MODULE_AUTHOR("Niklas Söderlund");
> +MODULE_DESCRIPTION("Renesas R-Car Gen4 gPTP driver");
> +MODULE_LICENSE("GPL");

[Severity: Medium]
_ptp_rcar_gen4_gettime() reads PTPGPTPTM00 (nanoseconds) and then
PTPGPTPTM10 and PTPGPTPTM20 (seconds). These are three separate MMIO
reads with no capture command and no retry. Does the Gen4 gPTP block
latch the seconds registers when PTPGPTPTM00 is read?

If it does not, a second rollover between the first and second read
pairs a nanosecond value from just before the boundary with the
incremented seconds. The returned time then jumps almost a full
second ahead. The Gen3 ravb code issues GCCR_TCR_CAPTURE before
reading the time registers for this reason.

This matters more in ptp_rcar_gen4_adjtime(). It takes the result of
_ptp_rcar_gen4_gettime(), adds delta, and writes it back with
_ptp_rcar_gen4_settime(). A torn read there would be committed to the
hardware clock, not just returned to one caller.

If the hardware does latch on the PTPGPTPTM00 read, could a comment
document that? If not, would it be enough to read the seconds before
and after the nanosecond read and retry when they differ?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007185920.4042783-1-niklas.soderlund%2Brenesas%40ragnatech.se
