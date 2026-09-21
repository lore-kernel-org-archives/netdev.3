Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF9C451986;
	Mon, 21 Sep 2026 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979443; cv=none; b=Xw+xRiIwrjWVdhlrXCXJfFh9rbefyX2GKzm2/raGb6JP0HQQmrB1IrOEAtlF7MCC9kX9zbOCC/xiRgeFE8xpWKlo0JN2tbKu2zSLmzt+nYbSRC9bPDoJLw8Z1R9kiYzTlCS1BpH3pUkJBzmASuJlF2FyXsj/x6PTgRzyKNWFgiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979443; c=relaxed/simple;
	bh=7Gj5awCwXFy8070vtROZHwXzHjMm5Rfqr7GgyzYreMk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hWtlLTyeR/ee8KCD3ijGS3vKhhkJecoCegAur4bRJh0JZJmgPfP8xoez9gCl9UhYHi9RoLJKaN81O3ONWQBUzJo7Jw1aMETsW4y97Zw22mjtK1DjSH4+3bt0EfZ9DSczlh0dmccv/wbCDfMCkQRF+C4zqAVHcp1iaHUYsUnxl1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqh+C4wr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqh+C4wr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7133B1F00898;
	Mon, 21 Sep 2026 08:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789979436;
	bh=wNEYUGZC88AhU0NcvSKBXqpj+bQa1LtifzOVLPZeP3Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gqh+C4wrS3Ju47tZ1H1hrhMJUzPt40N6kNNETt6ELz7IttSmnTZLzqn6pagpKoNrQ
	 3y0EXa57fKY1r1CtJdUJjCASC8G0P4MgV5wb9UI+3LBQ8Rr62+tPq/x9vpalRbv9wO
	 2WJFw91qoyqliBx7bZnVIzkXZpGLiFaR4n8ybNfvYNLdleQxClLckjuj9w97TwCuJu
	 TG7mJGakrmxFRo9CxMnJo6K7ojqL3TLyTWmQjFGgOEvGNIDF2w8T8d98rSFfiKZRLB
	 72TxA3tHbd9fIrdff8QOM/tjmxVbDJWpB5fQuOmgLeUWY0vqb44+pvOpLZdMiU2Q8Y
	 jnQyuxT4ZgWXg==
Subject: Re: [PATCH net-next v4 4/8] r8152: split r8157_hw_phy_cfg into
 RTL8157 and RTL8159 variants
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Mon, 21 Sep 2026 08:30:34 +0000
Message-ID: <178997943498.2160803.2709433616562364871@kernel.org>
In-Reply-To: <20260917070637.62827-5-nic_swsd@realtek.com>
References: <20260917070637.62827-5-nic_swsd@realtek.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] r8159_hw_phy_cfg() (drivers/net/usb/r8152.c:8309) contains
  functional PHY programming that the commit message does not disclose.
- [Medium] r8159_hw_phy_cfg() (drivers/net/usb/r8152.c:8309) drops the
  unconditional rtl_eee_enable(tp, false) that r8157_hw_phy_cfg() keeps…
- [Medium] The preceding patch in this series, "r8152: split RTL_VER_17
  into QFN68 and QFN100 package variants", justifies the new package…
- [Low] The commit message states the split was done "instead of
  switching on version mid-function", but both resulting functions still…

--

r8152: split r8157_hw_phy_cfg into RTL8157 and RTL8159 variants

This splits r8157_hw_phy_cfg() into an RTL8157-only version and a new
r8159_hw_phy_cfg() for RTL_VER_17_QFN68/QFN100, each carrying its own copy of
the shared prologue and epilogue.  It also adds sram2_set_bits()/
sram2_clr_bits() helpers and replaces a raw 0xa430 write with the named
OCP_POWER_CFG/EN_10M_PLLOFF/EN_ALDPS_PLLOFF macros.

No Link: tags in the commit header.

A few questions below about the new function and the commit message.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index c513c286c5499..d30031dbf2d38 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -8257,12 +8271,85 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  		sram2_write_w0w1(tp, 0x807c, 0xff00, 0x5000);
>  		sram2_write_w0w1(tp, 0x809d, 0xff00, 0x5000);
>  		break;
> +	default:
> +		break;
> +	}
>  

[ ... copy of the r8157 epilogue snipped ... ]

> +static void r8159_hw_phy_cfg(struct r8152 *tp)
> +{
> +	u16 data;
> +
> +	r8156b_wait_loading_flash(tp);
> +
> +	ocp_word_test_and_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
> +
> +	data = r8153_phy_status(tp, 0);
> +	switch (data) {
> +	case PHY_STAT_EXT_INIT:
> +		rtl8152_apply_firmware(tp, true);
> +		ocp_reg_clr_bits(tp, 0xa466, BIT(0));
> +		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
> +		break;
> +	case PHY_STAT_LAN_ON:
> +	case PHY_STAT_PWRDN:
> +	default:
> +		rtl8152_apply_firmware(tp, false);
> +		break;
> +	}
> +
> +	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
> +
> +	r8153_aldps_en(tp, false);

[Severity: Medium]
Here the rtl_eee_enable(tp, false) call is gone, while the epilogue of
r8159_hw_phy_cfg() still ends with:

	if (tp->eee_en)
		rtl_eee_enable(tp, true);

with no else branch.

When tp->eee_en is false, is there anything left in this callback that
programs the EEE registers or updates tp->ups_info.eee?  r8157_hw_phy_cfg(),
r8153_hw_phy_cfg(), r8153b_hw_phy_cfg() and the r8156/r8156b variants all
keep the unconditional disable in the same spot.

tp->eee_en is user settable through r8152_set_eee(), which does
tp->eee_en = eee->eee_enabled followed by rtl_eee_enable(tp, tp->eee_en),
i.e. both states get programmed there.  hw_phy_cfg() is what re-establishes
that policy after the PHY goes back to defaults: it is re-run from the
PCUT_STATUS power-cut recovery paths and from rtl_hw_phy_work_func_t, and
rtl8152_apply_firmware() runs just above.

So after "ethtool --set-eee <dev> eee off" and a later power-cut recovery on
RTL8159, can EEE come back enabled/advertised in hardware while ethtool still
reports eee_enabled == 0 and tp->ups_info.eee (used to build USB_UPS_FLAGS)
stays stale?

The commit message says "RTL8159 doesn't need EEE disabled before
reprogramming PHY parameters", which covers the ordering role of that call.
Does it also cover its second role of enforcing the requested EEE state?

> +
> +	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
> +	WARN_ON_ONCE(data != PHY_STAT_LAN_ON);
> +
> +	/* PFM mode */
> +	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);
> +
> +	/* Advanced Power Saving parameter */
> +	ocp_reg_set_bits(tp, OCP_POWER_CFG, EN_10M_PLLOFF | EN_ALDPS_PLLOFF);
> +
> +	/* Disable ALDPS force mode */
> +	ocp_reg_clr_bits(tp, 0xa44a, BIT(2));
> +
> +	/* Disable bypass_turn_off_clk_in_aldps */
> +	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, 0xd3c8, BIT(0));
> +
> +	switch (tp->version) {

[Severity: Low]
The commit message says the split was done "instead of switching on version
mid-function", but both resulting functions still switch on tp->version with
only one non-default case each.

rtl_ops_init() installs ops->hw_phy_cfg = r8159_hw_phy_cfg only under
case RTL_VER_17_QFN68 / case RTL_VER_17_QFN100, and
ops->hw_phy_cfg = r8157_hw_phy_cfg only under case RTL_VER_16, so neither
default arm is reachable.

Can both switches (and their default: break; arms) simply be dropped?

>  	case RTL_VER_17_QFN68:
>  	case RTL_VER_17_QFN100:

[Severity: Medium]
The preceding patch in this series, "r8152: split RTL_VER_17 into QFN68 and
QFN100 package variants", justifies the new package detection with:

    "RTL8159 is sold in two packages, QFN68 and QFN100, which need
     different PHY tuning (added in a later patch) and a package-specific
     u2phy backup-restore patch"

This is the patch that adds the RTL8159 PHY tuning, yet both package
versions fall into the same case and get identical power-level, TX filter,
CMP timer, PLL and SRAM/SRAM2 values.  By the end of the series the only
QFN68-specific code is the u2phy backup-restore write (0xb99c BIT(0)) in
r8159_init(), the UPS enable/disable selection, and the 10G EEE UPS flag.

Is one of the two packages being programmed with the other package's PHY
parameters here, or was the per-package PHY tuning rationale in the previous
patch inaccurate?

> -		/* Disable bypass turn off clk in ALDPS */
> -		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, 0xd3c8, BIT(0));
> -
>  		/* Power level tuning
>  		 * test mode power level
>  		 */
> @@ -8272,22 +8359,35 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  		sram_write_w0w1(tp, 0x81ae, 0xff00, 0x0f00);
>  		sram_write_w0w1(tp, 0x81b9, 0xff00, 0xb900);
>  		/* normal link TX filter */
> -		sram2_write_w0w1(tp, 0x83b0, 0x0e00, 0);
> -		sram2_write_w0w1(tp, 0x83c5, 0x0e00, 0);
> -		sram2_write_w0w1(tp, 0x83da, 0x0e00, 0);
> -		sram2_write_w0w1(tp, 0x83ef, 0x0e00, 0);
> +		sram2_clr_bits(tp, 0x83b0, 0x0e00);
> +		sram2_clr_bits(tp, 0x83c5, 0x0e00);
> +		sram2_clr_bits(tp, 0x83da, 0x0e00);
> +		sram2_clr_bits(tp, 0x83ef, 0x0e00);
> +
> +		ocp_reg_w0w1(tp, 0xbf38, 0x01f0, 0x0160);
> +		ocp_reg_w0w1(tp, 0xbf3a, 0x001f, 0x0014);
> +		/* shorten CLKS latency */
> +		ocp_reg_clr_bits(tp, 0xbf28, BIT(14) | BIT(13));
> +		ocp_reg_clr_bits(tp, 0xbf2c, BIT(15) | BIT(14));
> +		/* CMP_Timer on MP_Timer=333
> +		 * GPHY OCP 0xbf28 bit[0] = 0x1
> +		 * GPHY OCP 0xbf28 bit[6:1] = 0x3
> +		 * GPHY OCP 0xbf28 bit[12:7] = 0x3
> +		 */
> +		ocp_reg_w0w1(tp, 0xbf28, 0x1fff, 0x0187);
> +		ocp_reg_w0w1(tp, 0xbf2a, 0x3f, 0x03);

[Severity: Medium]
These writes to 0xbf38, 0xbf3a, 0xbf28, 0xbf2c and 0xbf2a have no matching
removal anywhere in the diff, so they are new PHY programming rather than
moved code.

The commit message enumerates exactly three RTL8159 divergences (dropping
rtl_eee_enable(tp, false), clearing EN_10M_CLKDIV instead of setting it, and
the extra 0xa5ea BIT(2)) and then frames the rest as
"add sram2_set_bits()/sram2_clr_bits() helpers ... and use the named
OCP_POWER_CFG/EN_10M_PLLOFF/EN_ALDPS_PLLOFF macros".

Can the "shorten CLKS latency" and "CMP_Timer on MP_Timer=333" programming be
mentioned in the commit message as well?

>  
>  		/* AFE power saving for 2.5G & 5G */
>  		sram_write(tp, 0x8173, 0x8620);
>  		sram_write(tp, 0x8175, 0x8671);
>  
> -		sram_write_w0w1(tp, 0x817c, 0, BIT(13));
> -		sram_write_w0w1(tp, 0x8187, 0, BIT(13));
> -		sram_write_w0w1(tp, 0x8192, 0, BIT(13));
> -		sram_write_w0w1(tp, 0x819d, 0, BIT(13));
> -		sram_write_w0w1(tp, 0x81a8, BIT(13), 0);
> -		sram_write_w0w1(tp, 0x81b3, BIT(13), 0);
> -		sram_write_w0w1(tp, 0x81be, 0, BIT(13));
> +		sram_set_bits(tp, 0x817c, BIT(13));
> +		sram_set_bits(tp, 0x8187, BIT(13));
> +		sram_set_bits(tp, 0x8192, BIT(13));
> +		sram_set_bits(tp, 0x819d, BIT(13));
> +		sram_clr_bits(tp, 0x81a8, BIT(13));
> +		sram_clr_bits(tp, 0x81b3, BIT(13));
> +		sram_set_bits(tp, 0x81be, BIT(13));
>  
>  		sram_write_w0w1(tp, 0x817d, 0xff00, 0xa600);
>  		sram_write_w0w1(tp, 0x8188, 0xff00, 0xa600);
> @@ -8351,10 +8451,10 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  		sram2_write_w0w1(tp, 0x84b2, 0xff00, 0x6000);
>  		/* Training AAGC PAR (with uc2 patch) */
>  		sram2_write(tp, 0x8ffc, 0x6008);
> -		sram2_write(tp, 0x8ffe, 0xf450);
> +		sram2_write(tp, 0x8ffe, 0xf4ff);

[Severity: Medium]
The neighbouring lines in this block are pure sram2_set_bits()/
sram2_clr_bits() conversions, but this one changes the value written to
0x8ffe from 0xf450 to 0xf4ff.  Is this value change intended, and can it be
called out in the commit message?

>  		/* DAC BGK */
> -		sram2_write_w0w1(tp, 0x8015, 0, BIT(9));
> -		sram2_write_w0w1(tp, 0x8016, 0, BIT(11));
> +		sram2_set_bits(tp, 0x8015, BIT(9));
> +		sram2_set_bits(tp, 0x8016, BIT(11));

[ ... ]

> @@ -8440,8 +8540,15 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  		sram2_write(tp, 0x8ff8, 0xaa5a);
>  
>  		sram2_write_w0w1(tp, 0x88d5, 0xff00, 0x0200);
> -		break;
>  
> +		/* spdchg_pga1_lpf_cap */
> +		sram_write_w0w1(tp, 0x84bb, 0xff00, 0x0a00);
> +		sram_write_w0w1(tp, 0x84c0, 0xff00, 0x1600);
> +
> +		/* ENET PLL jitter improvement */
> +		ocp_reg_w0w1(tp, 0xbf8a, 0xfc00, 0x2000);
> +		ocp_reg_set_bits(tp, 0xbf88, BIT(2));
> +		break;

[Severity: Medium]
The spdchg_pga1_lpf_cap writes (0x84bb, 0x84c0) and the ENET PLL jitter
writes (0xbf8a, 0xbf88) are also new, with no counterpart removal in the
diff.  Should the commit message list these among the RTL8159 changes too?

>  	default:
>  		break;
>  	}

[ ... ]

> @@ -10264,7 +10371,7 @@ static int rtl_ops_init(struct r8152 *tp)
>  		ops->eee_get		= r8153_get_eee;
>  		ops->eee_set		= r8152_set_eee;
>  		ops->in_nway		= rtl8153_in_nway;
> -		ops->hw_phy_cfg		= r8157_hw_phy_cfg;
> +		ops->hw_phy_cfg		= r8159_hw_phy_cfg;
>  		ops->autosuspend_en	= rtl8157_runtime_enable;
>  		ops->change_mtu		= rtl8156_change_mtu;
>  		tp->rx_buf_sz		= 48 * 1024;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917070637.62827-1-nic_swsd%40realtek.com
