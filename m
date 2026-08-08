Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1643B47E5;
	Sat,  8 Aug 2026 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218516; cv=none; b=pCZKe3+k6xPBiKjlPCnCevo1sNx15mVSkx2zEtyw7I5LtKB0r9/eUZkmLf/oZttKWD6wuJRidhAGKy8FYkzLnkEzMOTa+rWVW3kdWNd1OCBHGM1SUdVt4c+8nkWvYVD2jmCQfXQWxRosdDB/xuEwLgXdNXi0d0dw62MF+yrzEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218516; c=relaxed/simple;
	bh=yVg0KOqzVgijdTUFmeOo673WQN3R/33FEyXcH1oldPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9WCkzj7YVoXJhsI+zVorSWFd7tS4moFTOYJOKJu37seZvaHLoSCFU3LqW7H6btSsXA01cI7JUcGnefjY8GUPbWbV3ybf3s4fAy8eQotBqrMpBOXzfnDarksdKHOlbJ6Rv8r7Dr9gbVz1KisdlvsWOc0rRYW3zR9l0ZKE3CSlfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWRoNdw1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWRoNdw1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DC01F00ADB;
	Sat,  8 Aug 2026 19:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218514;
	bh=eRxJ/fIuvhgM095oJLmIkSbGhYYGimgl7BaacitApRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lWRoNdw1Df0iEJYgPgYwPXwYjo+XISQiiSyffwrFw2M78cpFTONdVcTyDymjmp3oh
	 jWAl1hp+2PpoAZ6PDw8IzsExDIG7ynGQ5lQ77sS4vIIq7xydlJ9eD0MYxMjrAOTPhA
	 uSjX3asnFDQTKHiDDlRDvq8u1VU7g6+Sm6kJ9UzkuSU7FE0hTtt9k8vFgzg0H+SKVo
	 PPycdLMmHD6B2M1PxhwwCmRI8mVhiPBUaEMkLQchUuFIb9uKb32lj8B8Rzjpid4IQH
	 bOextiL5Kxnqg/wv1zEYdgQVX0IUN/QaXXdnMbmotW4g2umAZigcNUcrNoKwyOTRhk
	 uZFXaRyewQubg==
From: Jakub Kicinski <kuba@kernel.org>
To: nagadheeraj.rottela@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	srinivas.neeli@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	michal.simek@amd.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	git-dev@amd.com
Subject: Re: [PATCH 15/20] net: dsa: xilinx: register PHC backed by the RTC timer block
Date: Sat,  8 Aug 2026 12:48:32 -0700
Message-ID: <20260808194833.133327-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-16-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-16-nagadheeraj.rottela@amd.com>
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
net: dsa: xilinx: register PHC backed by the RTC timer block

This adds a new xilinx_tsn_ptp.c that brings up the IP-wide RTC timer block
living inside MAC1's register window and registers it as a PTP hardware
clock, with gettime/settime/adjtime/adjfine ops serialized by a new
per-switch spinlock. A timer ISR counts 128 hardware ticks and emits
PTP_CLOCK_PPS once per second.

A few questions on the commit message and the new code below.

The commit message says:

    The timer block sits at a fixed offset inside MAC1's per-MAC register
    window, which the switch driver already owns via the "mac1" reg-name.
    Map it in probe() and register the PHC in setup().

[Severity: Low]
Is the "Map it in probe()" part accurate for this patch? The only changes
to drivers/net/dsa/xilinx/xilinx_tsn.c here are the xlnx_tsn_ptp_init()
call plus the err_nb label in xlnx_tsn_setup(), and the
xlnx_tsn_ptp_exit() call in xlnx_tsn_teardown().

The "mac1" window itself is mapped by pre-existing code in
xlnx_tsn_probe():

	ret = xlnx_tsn_map_reg(pdev, "mac1",
			       &sw->mac[XLNX_TSN_PORT_MAC1].regs);

which matches the preceding sentence about the driver already owning that
window. Could the message just drop the probe() claim?

> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.h b/drivers/net/dsa/xilinx/xilinx_tsn.h
> index a228a7bebd53..6063763b5c17 100644
> --- a/drivers/net/dsa/xilinx/xilinx_tsn.h
> +++ b/drivers/net/dsa/xilinx/xilinx_tsn.h

[ ... ]

> @@ -103,6 +105,28 @@ enum tsn_port_state {
>  #define TSN_SPEED_CFG_100		BIT(30)
>  #define TSN_SPEED_CFG_1000		BIT(31)
>  
> +/* PTP RTC timer block: a single block per IP, physically housed
> + * inside MAC1's per-MAC reg window. Owned by the switch driver
> + * because the PHC it backs is IP-wide, not per-MAC.
> + */
> +#define TSN_TIMER_RTC_OFFSET_NS		0x00012800
> +#define TSN_TIMER_RTC_OFFSET_SEC_L	0x00012808
> +#define TSN_TIMER_RTC_OFFSET_SEC_H	0x0001280c
> +#define TSN_TIMER_RTC_INCREMENT		0x00012810
> +#define TSN_TIMER_CURRENT_RTC_NS	0x00012814
> +#define TSN_TIMER_CURRENT_RTC_SEC_L	0x00012818
> +#define TSN_TIMER_CURRENT_RTC_SEC_H	0x0001281c
> +#define TSN_TIMER_INTERRUPT		0x00012820
> +
> +#define TSN_TIMER_MAX_NSEC_SIZE		30
> +#define TSN_TIMER_MAX_NSEC_MASK		GENMASK_ULL(TSN_TIMER_MAX_NSEC_SIZE - 1, 0)
> +#define TSN_TIMER_MAX_SEC_SIZE		48
> +#define TSN_TIMER_MAX_SEC_MASK		GENMASK_ULL(TSN_TIMER_MAX_SEC_SIZE - 1, 0)
> +#define TSN_TIMER_INT_CLEAR		BIT(0)
> +#define TSN_TIMER_RTC_NS_SHIFT		20
> +#define TSN_TIMER_PULSES_PER_PPS	128
> +#define TSN_TIMER_GTX_CLK_FREQ		125000000U
> +
>  struct mii_bus;
>  struct xlnx_tsn;
>  
> @@ -134,6 +158,15 @@ struct xlnx_tsn_mac {
>   *	to refresh the shared prefix
>   * @mac: per-MAC state, indexed by user-port number (index 0 unused;
>   *	 MAC1 at [1], MAC2 at [2])
> + * @ptp_timer_irq: 1 PPS / RTC-overflow interrupt

[Severity: Low]
Is this description of the interrupt right? xlnx_tsn_ptp_timer_isr()
treats the same line as a 128 Hz periodic tick and only emits an event
once every TSN_TIMER_PULSES_PER_PPS interrupts:

	sw->countpulse++;
	if (sw->countpulse >= TSN_TIMER_PULSES_PER_PPS) {

So it is neither a 1 PPS nor an RTC-overflow interrupt, and the
@countpulse line two lines further down ("reset to zero every
TSN_TIMER_PULSES_PER_PPS ticks") already says something different.

> + * @ptp_clock: registered PHC; NULL until setup() succeeds
> + * @ptp_clock_info: PHC capability + ops descriptor
> + * @reg_lock: serialises RTC offset / increment register accesses
> + *	      from process context and the PHC ops
> + * @rtc_value: base RTC increment word for the GTX clock frequency,
> + *	       used as the starting point for adjust_by_scaled_ppm()
> + * @pps_enable: user requested PPS event delivery
> + * @countpulse: timer-tick counter, reset to zero every TSN_TIMER_PULSES_PER_PPS ticks
>   */

[ ... ]

> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn_ptp.c b/drivers/net/dsa/xilinx/xilinx_tsn_ptp.c
> new file mode 100644
> index 000000000000..75c177f752f1
> --- /dev/null
> +++ b/drivers/net/dsa/xilinx/xilinx_tsn_ptp.c
> @@ -0,0 +1,235 @@

[ ... ]

> +static int xlnx_tsn_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> +{
> +	struct xlnx_tsn *sw = container_of(ptp, struct xlnx_tsn, ptp_clock_info);
> +	u64 incval;
> +
> +	/* adjust_by_scaled_ppm() returns u64 but the increment register is
> +	 * 32 bits, so clamp to U32_MAX to avoid overflow.
> +	 */
> +	incval = adjust_by_scaled_ppm(sw->rtc_value, scaled_ppm);
> +	if (incval > U32_MAX)
> +		incval = U32_MAX;
> +
> +	guard(spinlock_irqsave)(&sw->reg_lock);
> +	mac_iow(&sw->mac[XLNX_TSN_PORT_MAC1], TSN_TIMER_RTC_INCREMENT,
> +		(u32)incval);
> +
> +	return 0;
> +}

[ ... ]

> +static int xlnx_tsn_ptp_settime(struct ptp_clock_info *ptp,
> +				const struct timespec64 *ts)
> +{
> +	struct xlnx_tsn *sw = container_of(ptp, struct xlnx_tsn, ptp_clock_info);
> +	struct timespec64 delta, tod, offset, counter;
> +
> +	guard(spinlock_irqsave)(&sw->reg_lock);
> +
> +	xlnx_tsn_tod_read(sw, &tod);
> +	xlnx_tsn_rtc_offset_read(sw, &offset);
> +	counter = timespec64_sub(tod, offset);
> +
> +	delta = timespec64_sub(*ts, counter);
> +
> +	/* A real wall-clock time is always far above the free-running counter,
> +	 * so this never triggers in practice. Reject it only as a safety net,
> +	 * since the offset register cannot store a negative value.
> +	 */
> +	if (delta.tv_sec < 0)
> +		return -ERANGE;
> +
> +	xlnx_tsn_rtc_offset_write(sw, &delta);
> +
> +	return 0;
> +}
> +
> +static int xlnx_tsn_ptp_enable(struct ptp_clock_info *ptp,
> +			       struct ptp_clock_request *rq, int on)
> +{
> +	struct xlnx_tsn *sw = container_of(ptp, struct xlnx_tsn, ptp_clock_info);
> +
> +	switch (rq->type) {
> +	case PTP_CLK_REQ_PPS:
> +		WRITE_ONCE(sw->pps_enable, on ? 1 : 0);
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static irqreturn_t xlnx_tsn_ptp_timer_isr(int irq, void *priv)
> +{
> +	struct ptp_clock_event event = { .type = PTP_CLOCK_PPS };
> +	struct xlnx_tsn *sw = priv;
> +
> +	sw->countpulse++;
> +	if (sw->countpulse >= TSN_TIMER_PULSES_PER_PPS) {
> +		sw->countpulse = 0;
> +		if (sw->ptp_clock && READ_ONCE(sw->pps_enable))
> +			ptp_clock_event(sw->ptp_clock, &event);
> +	}

[Severity: Medium]
What ties this synthesized pulse to the PHC second boundary?

sw->countpulse starts counting from whichever tick arrives first after
request_irq(), and the ISR never looks at TSN_TIMER_CURRENT_RTC_NS, so
the phase of the emitted PTP_CLOCK_PPS inside the PHC second looks
arbitrary, up to 1/128 s (about 7.8 ms) away from the true second
rollover.

The counter is also not re-phased when the RTC offset moves:

xlnx_tsn_ptp_settime()
	xlnx_tsn_rtc_offset_write(sw, &delta);

xlnx_tsn_ptp_adjtime()
	xlnx_tsn_rtc_offset_write(sw, &now);

including the large step done from xlnx_tsn_ptp_init(). Since
ptp_clock_info.pps = 1 registers a real PPS source, a consumer using
these events would be steered to a constant wrong phase. Would anchoring
countpulse to the nanoseconds register (or resetting it on
settime/adjtime and on enable) be preferable?

> +
> +	mac_iow(&sw->mac[XLNX_TSN_PORT_MAC1], TSN_TIMER_INTERRUPT,
> +		TSN_TIMER_INT_CLEAR);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +int xlnx_tsn_ptp_init(struct xlnx_tsn *sw)
> +{
> +	struct timespec64 ts;
> +	int ret;
> +
> +	spin_lock_init(&sw->reg_lock);

[Severity: Low]
Should sw->pps_enable and sw->countpulse be reset here as well?

struct xlnx_tsn is devm_kzalloc()'d once in probe() and survives a DSA
teardown/setup cycle, while xlnx_tsn_ptp_exit() only clears
sw->ptp_clock. If PPS was enabled before the teardown, pps_enable stays
1, and after the next xlnx_tsn_ptp_init() the ISR condition

	if (sw->ptp_clock && READ_ONCE(sw->pps_enable))

is true again on a freshly registered PHC that nobody asked for PPS on,
with a pulse phase carried over from the old countpulse value.

> +
> +	sw->ptp_timer_irq = of_irq_get_byname(sw->dev->of_node, "ptp_timer");
> +	if (sw->ptp_timer_irq <= 0)
> +		return dev_err_probe(sw->dev, sw->ptp_timer_irq ? : -ENXIO,
> +				     "failed to get ptp_timer IRQ\n");
> +

[ ... ]

> +	sw->ptp_clock = ptp_clock_register(&sw->ptp_clock_info, sw->dev);
> +	if (IS_ERR_OR_NULL(sw->ptp_clock)) {
> +		ret = sw->ptp_clock ? PTR_ERR(sw->ptp_clock) : -ENODEV;
> +		sw->ptp_clock = NULL;
> +		return dev_err_probe(sw->dev, ret,
> +				     "failed to register PTP clock\n");
> +	}

[Severity: Medium]
Is it safe to publish the clock before the hardware and sw->rtc_value are
initialized?

ptp_clock_register() calls posix_clock_register() and creates /dev/ptpN
before returning, so from this point on all ops are reachable from
userspace, which is exactly the concurrency the commit message describes.

If clock_adjtime() lands in xlnx_tsn_ptp_adjfine() during the window
below, sw->rtc_value is still 0 (devm_kzalloc'd), and

	incval = adjust_by_scaled_ppm(0, scaled_ppm);   /* 0 */
	...
	mac_iow(..., TSN_TIMER_RTC_INCREMENT, (u32)incval);

programs an increment of 0, stopping the RTC.

Two related points on the same window: the mac_iow() to
TSN_TIMER_RTC_INCREMENT below is done without sw->reg_lock while
xlnx_tsn_ptp_adjfine() writes the same register under the lock, so a
userspace frequency adjustment can be clobbered; and sw->rtc_value is
written here with a plain u64 store and read in adjfine with a plain
unlocked load, which can be observed torn on 32-bit.

Would moving the rtc_value assignment, the increment write and the
initial settime ahead of ptp_clock_register() address all three?

> +
> +	sw->rtc_value = div_u64(NSEC_PER_SEC, TSN_TIMER_GTX_CLK_FREQ) <<
> +			TSN_TIMER_RTC_NS_SHIFT;
> +	mac_iow(&sw->mac[XLNX_TSN_PORT_MAC1], TSN_TIMER_RTC_INCREMENT,
> +		(u32)sw->rtc_value);

[Severity: Low]
This isn't a bug on today's boards, but should the RTC rate come from the
DT clock rather than TSN_TIMER_GTX_CLK_FREQ?

The binding documents the clock that drives this block:

Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
    clocks:
      items:
        - description: GTX clock for transmitter logic and RTC
    ...
    clock-names:
      items:
        - const: gtx

and places no frequency constraint on it. The driver already reads a
wrapper-node clock rate elsewhere:

xlnx_tsn_mdio_register_all()
	s_axi = clk_get(sw->dev->parent, "s_axi");
	...
	host_hz = clk_get_rate(s_axi);

so clk_get_rate() on "gtx" looks available here too. On an instance
synthesized with a different RTC clock, both the nominal tick period and
the adjfine base would be permanently wrong.

Separately, the shift is applied after the division, so fractional
nanoseconds are truncated before reaching the 20 fractional bits (for
example 156.25 MHz gives 6 ns instead of 6.4 ns). Would

	div_u64((u64)NSEC_PER_SEC << TSN_TIMER_RTC_NS_SHIFT, rate)

be the intended form?

> +
> +	ts = ktime_to_timespec64(ktime_get_real());
> +	xlnx_tsn_ptp_settime(&sw->ptp_clock_info, &ts);

[Severity: Medium]
Can the dropped return value here hide a failure to program the RTC
offset? xlnx_tsn_ptp_settime() returns without touching the hardware when
the requested time is below the free-running counter:

	delta = timespec64_sub(*ts, counter);
	...
	if (delta.tv_sec < 0)
		return -ERANGE;

	xlnx_tsn_rtc_offset_write(sw, &delta);

On a board with no battery-backed RTC where the PL keeps running across a
warm reboot, the counter can be hours ahead while ktime_get_real() starts
near the epoch, so delta.tv_sec is negative. In that case the offset
registers keep whatever the previous incarnation or the bootloader left
there, and neither the log nor xlnx_tsn_setup() sees anything. Should the
return value be checked and propagated?

> +
> +	ret = request_irq(sw->ptp_timer_irq, xlnx_tsn_ptp_timer_isr, 0,
> +			  "xlnx-tsn-ptp-timer", sw);
> +	if (ret) {
> +		dev_err_probe(sw->dev, ret,
> +			      "failed to request ptp_timer IRQ %d\n",
> +			      sw->ptp_timer_irq);
> +		goto err_unregister_clock;
> +	}
> +
> +	return 0;
> +
> +err_unregister_clock:
> +	ptp_clock_unregister(sw->ptp_clock);
> +	sw->ptp_clock = NULL;
> +	return ret;
> +}

[ ... ]
