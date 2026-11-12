Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461607;
	b=WemvIHbH31EXQRx0F35aQDRbHFHSSfROmjIlGRr/BJrPmtNacWtfvQr5IhMB+bRE16Ex
	 aQ1jooMET7x+PliFf/uFxaOI8Oa8bueuuL2v6YczO3yDHxk+gSivucaQKyt0mQq4Tvy3B
	 swaga0gXiA9xbph7OJdTmV4J4n/7+7uyirWeuszZGj2/jSqbL4dMSWkq6ba0Q2GLbyQiI
	 X92exRtEVj7kUeXGMT+53Rqvbc1cmnWIxO3XWNp3UXA/J01JqObpZ6GXjnRLoP1/QO2pv
	 AS3Q/eS61LyRoefWjnMnp9vFlhQWG3yw3IS2Xl5HVcHo5HpkxN/zwZzrbQbjPo78K/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461607;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JfLB+wLJjdVddJxTwmaAZ1MngQJyFegVgHKt7Xbp8ms=;
	b=xfFsXuSOLfkosCQrAt+JM9LOCjf33Sq4My6Ont+vYNqZ5UE0zr8zDDy8sXY+jWyHtyrQ
	 F0iZrAPDhZyf9gHkI/kMcTfJ09FTKiU7+U6/2A5KzoV2BycOQvYBYpRtaWMptrGp1QQkt
	 tw1KD+EkkPYvwyyAHtFBY/G/9ybhXGG8zJWmYtNgCvoBBgSvxK8PqXIxV+w6i//2qJIT/
	 Z/tlN7N6MPgkyK7Felqsw8MGHuLI+NUSZC/9OGPySqX36RwffKI3wJtq/DtvtP5o6Z+EN
	 0PJ1aH/XtSZnvC4KO+H37itcEk0whM0/N3ipzTjDv6pN4DSclDOzNgNeBGs3x0TzdEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fIBTAtZW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566B0606A338;
	Thu, 12 Nov 2026 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fIBTAtZW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4217A1F00A05;
	Thu, 12 Nov 2026 05:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794461606;
	bh=JfLB+wLJjdVddJxTwmaAZ1MngQJyFegVgHKt7Xbp8ms=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fIBTAtZWa55C89qEHvpUkXsKxpweeQgIzP9egTawgCgNdswSB7FIN9rVUvSuSy3eU
	 Muc8iG1WBCY//e6LUfQTtQC4Zs+/XLFunN//CnM+X8qo6sO80yZy/TXoYTtMBuEg1y
	 7Ysi0W7T+B0aLVAoLHGL4ahBpWB8WAy7qYCEN62raQGGeW7tjDEVKfFJ5du2Ugt27W
	 Nb9MBplCK9/0tg0mBufzwCD6YM8fznVTWbvgvHyM+Q8tekQ544pvLtdp6zH71KWMnM
	 6gGqaueuzgNdjnEkx/CpxurrbnukjDvFWsTZiQVqemWIRpALfhVRHM57lEo80TJlVL
	 9XaP5AOQ/bUnw==
Subject: Re: [PATCH net-next v1 2/3] r8169: add PTP hardware clock support for
 RTL8127a
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 05:33:25 +0000
Message-ID: <179446160576.2199510.11188001061728081280@kernel.org>
In-Reply-To: <20261109023022.770-3-javen_xu@realsil.com.cn>
References: <20261109023022.770-3-javen_xu@realsil.com.cn>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The PHC stays registered and callable while the NIC is runtime-
  suspended, and its callbacks never take a runtime-PM reference or…
- [Medium] rtl8169_ptp_read() returns u16, but it wraps
  r8168_phy_ocp_read(), which returns int and gives -ETIMEDOUT when the…
- [Medium] rtl8169_ptp_clkadj() is void and drops the -ETIMEDOUT from
  rtl8169_ptp_poll() when PTP_CLK_CFG_EXEC never self-clears.
- [Medium] In rtl_init_one(), tp->ptp_support is set only from
  IS_ENABLED(CONFIG_PTP_1588_CLOCK) && tp->mac_version ==…
- [Medium] The PTP block configuration is applied in only one place,
  rtl8169_ptp_init(), once per ndo_open, and only after rtl8169_up() has…
- [Low] The commit message does not mention that every open and close on
  RTL8127A now writes PTP/SyncE control registers and an undocumented…
- [Low] In rtl8169_ptp_gettimex64(), ptp_read_system_prets() and
  ptp_read_system_postts() bracket all of…

--

r8169: add PTP hardware clock support for RTL8127a

This adds a PTP hardware clock for RTL8127A. The clock is in the PHY and
is accessed through the PHY OCP interface. It supports adjfine, adjtime,
gettimex64 and settime64. It is registered on open, unregistered on close,
and seeded from system time each time the chip is brought up.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 96d3a2bd70947..fc3cfa09a57e7 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -5780,6 +5784,9 @@ static void rtl8169_up(struct rtl8169_private *tp)
>  	rtl8169_napi_enable(tp);
>  	enable_work(&tp->wk.work);
>  	rtl_reset_work(tp);
> +
> +	if (tp->ptp_support)
> +		rtl8169_ptp_set_local_time(&tp->ptp);
>  }
>  
>  static int rtl8169_close(struct net_device *dev)
> @@ -5791,6 +5798,8 @@ static int rtl8169_close(struct net_device *dev)
>  
>  	phylink_stop(tp->phylink);
>  	netif_stop_queue(dev);
> +	if (tp->ptp_support)
> +		rtl8169_ptp_stop(&tp->ptp);
>  	rtl8169_down(tp);
>  	for (int i = 0; i < tp->num_rx_rings; i++)
>  		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
> @@ -5861,6 +5870,8 @@ static int rtl_open(struct net_device *dev)
>  	}
>  	rtl8169_up(tp);
>  	phylink_start(tp->phylink);
> +	if (tp->ptp_support)
> +		rtl8169_ptp_init(&tp->ptp);
>  	rtl8169_init_counter_offsets(tp);
>  	netif_start_queue(dev);
>  out:

[Severity: High]
Can the PHC be used while the NIC is runtime-suspended?

The clock is registered here and is only unregistered in rtl8169_close().
Runtime and system suspend go through rtl8169_net_suspend(), which calls
rtl8169_down() but does nothing with the PHC:

drivers/net/ethernet/realtek/r8169_main.c:rtl8169_net_suspend() {
    ...
	netif_device_detach(tp->dev);

	if (netif_running(tp->dev))
		rtl8169_down(tp);
    ...
}

If the interface is up with no carrier, rtl8169_runtime_idle() schedules
a suspend:

	if (!netif_running(tp->dev) || !netif_carrier_ok(tp->dev))
		pm_schedule_suspend(device, 10000);

Once the chip is in D3, /dev/ptpN is still live. clock_gettime(),
clock_adjtime() and the PTP_SYS_OFFSET* ioctls still reach gettimex64,
settime64, adjtime and adjfine. None of these take a runtime-PM
reference or check pm_runtime_active(). rtl8169_get_stats64() and the
LED helpers in this driver do guard their hardware access that way.

With MMIO returning all-ones:

- r8168_phy_ocp_read() returns 0xffff.
- Each r8168_phy_ocp_write() spins for its full 250 us timeout.
- The EXEC poll in rtl8169_ptp_poll() never sees bit 0 clear.

read_poll_timeout_atomic() counts only the udelay time, so the poll
runs about 1000 polled OCP reads. All of this happens under
spin_lock_irqsave(&ptp->lock).

Wouldn't that keep IRQs off for milliseconds on every PHC call? After
that, gettimex64 would return 0 with tv_nsec = 0x3fffffff and
tv_sec = 0xffffffffffff. settime, adjtime and adjfine would also report
success without doing anything.

Resume seems to have two more problems. rtl8169_runtime_resume() calls
rtl8169_up() without RTNL or ptp->lock:

	if (tp->TxDescArray)
		rtl8169_up(tp);

phy_ocp_lock only serializes single register accesses. So phy_init_hw()
and genphy_soft_reset() in rtl8169_init_phy() can interleave with a
multi-register PTP sequence running on another CPU.

rtl8169_up() then calls rtl8169_ptp_set_local_time(), which steps the
PHC back to CLOCK_REALTIME on every runtime or system resume. Doesn't
that discard the time a PTP servo had set? The adjfine rate is also
never cached or restored.

This is unchanged at the end of the series.

> @@ -6904,6 +6915,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	tp->dash_type = rtl_get_dash_type(tp);
>  	tp->dash_enabled = rtl_dash_is_enabled(tp);
>  
> +	tp->ptp_support = IS_ENABLED(CONFIG_PTP_1588_CLOCK) &&
> +			  tp->mac_version == RTL_GIGA_MAC_VER_80;
> +	if (tp->ptp_support)
> +		rtl8169_ptp_setup(&tp->ptp, tp, dev, &pdev->dev);
> +

[Severity: Medium]
Should this also check tp->sfp_mode?

On the RTL8127ATF fiber variant, rtl_get_sfp_mode() returns
RTL_SFP_8127_ATF. r8169_mdio_register() is only called for RTL_SFP_NONE,
so there is no phydev, and rtl8169_up() skips rtl8169_init_phy().

A PHC is still registered in that case. The PTP block, which the commit
message says is "in its PHY", is still programmed on every open and
resume through rtl8169_ptp_set_local_time() and
rtl8169_ptp_hwtstamp_enable().

What happens if that block isn't clocked or isn't in the data path in
fiber mode? The clkadj polls would time out with IRQs off and log
errors on every open and resume, and userspace would get a bogus PHC.
Later in the series, hardware timestamping is also advertised for this
variant.

It isn't clear whether the PTP block at 0xe400 works in fiber mode, but
the code treats both modes the same way.

>  	if (rtl_hw_support_rss(tp)) {
>  		tp->rss_data = devm_kzalloc(&pdev->dev, sizeof(*tp->rss_data),
>  					    GFP_KERNEL);
> diff --git a/drivers/net/ethernet/realtek/r8169_ptp.c b/drivers/net/ethernet/realtek/r8169_ptp.c
> new file mode 100644
> index 0000000000000..6201170e0c83e
> --- /dev/null
> +++ b/drivers/net/ethernet/realtek/r8169_ptp.c
> @@ -0,0 +1,291 @@

[ ... ]

> +static u16 rtl8169_ptp_read(struct rtl8169_ptp *ptp, u32 reg)
> +{
> +	return r8168_phy_ocp_read(ptp->tp, reg);
> +}

[Severity: Medium]
r8168_phy_ocp_read() returns int and gives -ETIMEDOUT when the GPHY_OCP
handshake times out:

	if (rtl_phy_ocp_wait(tp, true))
		val = -ETIMEDOUT;
	else
		val = RTL_R32(tp, GPHY_OCP) & 0xffff;

Doesn't the u16 return type here turn that into the register value
0xff92? Callers would then treat it as real data:

- rtl8169_ptp_modify() writes (0xff92 & ~mask) | set back to the
  register. For PTP_CLK_CFG that sets bits 4-15. PTP_SYNCE_CTL,
  PTP_INER, PTP_CTL and 0xa640 in rtl8169_ptp_hwtstamp_enable() are
  affected the same way.
- rtl8169_ptp_poll(..., PTP_CLK_CFG_EXEC, false) sees bit 0 clear in
  0xff92, so a failed read counts as command completion.
- rtl8169_ptp_read_time() ORs 0xff92 into the nsec and sec fields, so
  gettimex64 returns a made-up time.

Later in the series, the same helper also feeds the RX/TX timestamp
paths.

[ ... ]

> +static void rtl8169_ptp_clkadj(struct rtl8169_ptp *ptp,
> +			       enum rtl8169_ptp_clkadj_mode mode)
> +{
> +	rtl8169_ptp_modify(ptp, PTP_CLK_CFG, PTP_CLK_CFG_MODE,
> +			   PTP_CLK_CFG_EXEC | mode);
> +	rtl8169_ptp_poll(ptp, PTP_CLK_CFG, PTP_CLK_CFG_EXEC, false);
> +}

[Severity: Medium]
The -ETIMEDOUT from rtl8169_ptp_poll() is dropped here. Because
rtl8169_ptp_clkadj() is void, gettimex64, settime64, adjtime and
adjfine all return 0 even when the command never completed. Should the
error be passed back to the PTP core?

PTP_CFG_TIME holds both the operands and the results:

- rtl8169_ptp_write_time() fills it for DIRECT_WRITE, INC_STEP and
  DEC_STEP.
- rtl8169_ptp_adjfine() writes the rate word into NS_LO/NS_HI.
- rtl8169_ptp_gettimex64() reads the result from it after DIRECT_READ.

If DIRECT_READ doesn't complete, can gettimex64 return a leftover
adjtime delta, adjfine rate word or settime value as the current PHC
time, with status 0? The next command could also be issued while EXEC
is still set.

This is unchanged at the end of the series.

[ ... ]

> +static void rtl8169_ptp_hwtstamp_enable(struct rtl8169_ptp *ptp, bool enable)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ptp->lock, flags);
> +
> +	rtl8169_ptp_modify(ptp, PTP_SYNCE_CTL, PTP_SYNCE_EN, 0);
> +	if (enable) {
> +		rtl8169_ptp_modify(ptp, PTP_INER, 0,
> +				   PTP_INT_RX_TS | PTP_INT_TX_TS);
> +		rtl8169_ptp_modify(ptp, PTP_GEN_CFG, 0,
> +				   PTP_GEN_CFG_INT_CLR_MODE);
> +		rtl8169_ptp_write(ptp, PTP_INSR, 0xffff);
> +		rtl8169_ptp_write(ptp, PTP_CTL, PTP_CTL_TYPE_3 | BIT(12));
> +	} else {
> +		rtl8169_ptp_modify(ptp, PTP_INER,
> +				   PTP_INT_RX_TS | PTP_INT_TX_TS, 0);
> +		rtl8169_ptp_modify(ptp, PTP_CTL, PTP_CTL_EN, 0);
> +	}
> +	rtl8169_ptp_modify(ptp, 0xa640, 0, BIT(15));

[Severity: Low]
This isn't a bug, but the commit message doesn't say that every open and
close on RTL8127A now calls rtl8169_ptp_hwtstamp_enable(ptp, false).
That call:

- clears PTP_SYNCE_EN, regardless of what firmware or BIOS configured;
- masks the RX/TX timestamp interrupts;
- clears PTP_CTL_EN;
- sets BIT(15) of PHY OCP register 0xa640.

Could the commit message explain why SyncE is turned off? Could 0xa640
get a #define and a comment saying what bit 15 does and whether it
changes PHY behaviour beyond PTP?

The same writes are still there at the end of the series.

> +
> +	spin_unlock_irqrestore(&ptp->lock, flags);
> +}

[ ... ]

> +static int rtl8169_ptp_gettimex64(struct ptp_clock_info *info,
> +				  struct timespec64 *ts,
> +				  struct ptp_system_timestamp *sts)
> +{
> +	struct rtl8169_ptp *ptp = container_of(info, struct rtl8169_ptp, info);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ptp->lock, flags);
> +	ptp_read_system_prets(sts);
> +	rtl8169_ptp_clkadj(ptp, PTP_CLKADJ_DIRECT_READ);
> +	ptp_read_system_postts(sts);

[Severity: Low]
Do prets/postts cover more than the latching event here?
rtl8169_ptp_clkadj() does three things:

1. an OCP read of PTP_CLK_CFG for the read-modify-write;
2. the OCP write that triggers the latch;
3. the EXEC-clear poll loop, with at least one more OCP read plus
   udelay(1) per iteration.

Each PHY OCP access is an MMIO write plus a busy-poll on OCPAR_FLAG. The
window is therefore several OCP round trips wide and not centred on the
latch point. Wouldn't that bias the midpoint phc2sys uses and inflate
the uncertainty reported by PTP_SYS_OFFSET_EXTENDED?

This is unchanged at the end of the series.

> +	rtl8169_ptp_read_time(ptp, PTP_CFG_TIME, ts);
> +	spin_unlock_irqrestore(&ptp->lock, flags);
> +
> +	return 0;
> +}

[ ... ]

> +void rtl8169_ptp_init(struct rtl8169_ptp *ptp)
> +{
> +	struct ptp_clock *clock;
> +
> +	ptp->info = rtl8169_ptp_info;
> +	snprintf(ptp->info.name, sizeof(ptp->info.name), "%pm",
> +		 ptp->dev->dev_addr);
> +
> +	clock = ptp_clock_register(&ptp->info, ptp->parent);
> +	if (IS_ERR(clock)) {
> +		netdev_err(ptp->dev, "failed to register PTP clock: %pe\n",
> +			   clock);
> +		return;
> +	}
> +	ptp->clock = clock;
> +
> +	rtl8169_ptp_hwtstamp_enable(ptp, false);

[Severity: Medium]
This is the only place the PTP block configuration is applied. It runs
once per ndo_open, after rtl8169_up() has already seeded the clock with
rtl8169_ptp_set_local_time().

On runtime or system resume, rtl8169_up() runs phy_init_hw(),
r8169_hw_phy_config() and genphy_soft_reset() again and re-seeds the
PHC time, but never re-applies this configuration. If the PHY reset or
power-down clears these registers, won't the hardware state after
resume differ from what was set up at open?

Later in the series, ptp->config keeps the user's hwtstamp setting, but
rtl8169_ptp_hwtstamp_set() only reprograms the hardware when the config
changes. Timestamping could therefore stay disabled after resume with
no error.

Separately, 0xa640 BIT(15) is set in both the enable and disable
branches of rtl8169_ptp_hwtstamp_enable(). Is there any path that clears
it?

> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109023022.770-1-javen_xu%40realsil.com.cn
