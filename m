Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458CF569F19;
	Wed,  9 Sep 2026 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960733; cv=none; b=IvVWjZ45GnE0G6+q0Ve73esq3IVyIRixdl3KsPnEN6E5RmOcp6h9+OeMGZv50N9Mv758DLgUUote626LdtB8LSAn37/yc5YA7KECYWBt8WYGgT6quRpo4lsAYp1rgXzgo9baRLzP4ScGaXh3E/nWq9lKTiPSc2tWuiIeTuKM5Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960733; c=relaxed/simple;
	bh=rbWcq4iOOpkl01+75USy40jwxg7urEwKUDmL0rcDb04=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bTgQ+cLn0jZ1SZZpddLSz44vNO5b8pX3Tz6RqdvMMbM7bu/Mp17LFdDTSsmHX6zrsPuoReSXFXaOFnJYoyqlXol0DYpp6bRuHhbJxH+mB69sfZIrcb6/MtM91cYqW1ZjyybegYltVaPDTd7LBgeJIhBamKQsCx2xs4E5RkVPcCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsnrHWDf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsnrHWDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA161F00A3A;
	Wed,  9 Sep 2026 13:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960731;
	bh=G1KtiNMq2MrgyU7ebFIiMymFaGA3MQPiSgWtzieMtgg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NsnrHWDfXdbqBUTxpdv4o62bxBuDWaUKDQUBj4V3cWId3PVQ0badRfZOOrbDIPPDP
	 OiERs9dU6Z6VfQthpNwnEKTb15obNztPkwRW5f5Fqo7BflJmTfSCbMvPKazgSJ6gP7
	 gDpjWwE8U2QjeO3kyms90ntdW+J4Yz5aUJ/qUsjLOOGvtxPIAn2Ebhuu/goqrbGZxM
	 2qwH/E+WOAWrRT3qCLnEVJI1iTV+SfHKwkt7NeVih0Kr9UNdzCSRzABnAaern2O3Ix
	 F/NuCm2r4Jkgrmd6O/FZNkepOmMe8r37DEmjKNnq9P4BEao0LVoFjylcIe/yOg44xW
	 hxuwboUY4JRdQ==
Subject: Re: [PATCH net-next v2 4/8] r8152: refactor r8157_hw_phy_cfg
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Wed, 09 Sep 2026 13:32:10 +0000
Message-ID: <178896073022.219967.8138929054667142378@kernel.org>
In-Reply-To: <20260903072852.58695-5-nic_swsd@realtek.com>
References: <20260903072852.58695-5-nic_swsd@realtek.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 2

- [Medium] r8159_hw_phy_cfg() (new RTL_VER_17_QFN68/QFN100 callback,
  drivers/net/usb/r8152.c:8332) drops the unconditional…
- [Low] The commit is presented as a refactor ('Split r8157_hw_phy_cfg
  into ... and add sram2 bitwise operation helpers') and only vaguely…
- [Low] The newly added EN_ALDPS_PLLOFF define in the OCP_POWER_CFG block
  uses space alignment while all neighbouring defines in the same block…

Pre-existing issues:
- [Medium] Both r8157_hw_phy_cfg() and the new r8159_hw_phy_cfg() return
  early when `rtl_phy_patch_request(tp, true, true)` fails, after ALDPS…

--

r8152: refactor r8157_hw_phy_cfg

This splits the shared r8157_hw_phy_cfg() into r8157_hw_phy_cfg() for
RTL_VER_16 and a new r8159_hw_phy_cfg() for RTL_VER_17_QFN68/QFN100, adds
sram2_set_bits()/sram2_clr_bits() helpers, and updates PHY parameters for
RTL8156B/8157/8159.  A few questions below.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 6c189790b0ba..679aead731f7 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -655,6 +655,7 @@ enum spd_duplex {
>  /* OCP_POWER_CFG */
>  #define EEE_CLKDIV_EN		0x8000
>  #define EN_ALDPS		0x0004
> +#define EN_ALDPS_PLLOFF         0x0002
>  #define EN_10M_PLLOFF		0x0001

[Severity: Low]
This isn't a bug, but the new define uses spaces for alignment while
EEE_CLKDIV_EN, EN_ALDPS and EN_10M_PLLOFF in the same block use tabs.
Could it use a tab as well?

[ ... ]

> @@ -8075,6 +8086,9 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
>  		sram_write(tp, 0x8074, 0x2417);
>  		sram_write(tp, 0x807a, 0x2417);
>  
> +		/* Nway DACONB parameters */
> +		ocp_reg_w0w1(tp, 0xa4ca, 0x6000, 0x0040);
> +
>  		/* XG PLL */
>  		ocp_reg_w0w1(tp, 0xbf84, 0xe000, 0xa000);
>  		break;

[Severity: Low]
The subject says "refactor" and the changelog says "update PHY parameters
for RTL8156B/57/59", but several hardware behaviour changes for already
shipped parts are mixed in with the mechanical sram/sram2 helper
conversions.  Could these be split out, or at least described?

This new Nway DACONB write lands in r8156b_hw_phy_cfg(), reached through
the RTL_VER_13 fallthrough and the RTL_VER_15 case, so it applies to
shipped RTL8156B devices even though the commit is about the
r8157/r8159 split.

In r8157_hw_phy_cfg() below, the 0xd3c8 BIT(0) clear moves out of the
RTL_VER_17 case into the common preamble, so RTL8157 (RTL_VER_16) now
also gets the ALDPS clock-bypass change.

In the r8159_hw_phy_cfg() tail below, EN_10M_CLKDIV changes from set to
cleared and tp->ups_info._10m_ckdiv flips from true to false, which
changes the UPS flag word programmed on every runtime suspend:

	if (tp->ups_info._10m_ckdiv)
		ups_flags |= UPS_FLAGS_EN_10M_CKDIV;

0xa5ea additionally clears BIT(2), sram2 0x8ffe changes from 0xf450 to
0xf4ff, and there are new CLKS latency, CMP_Timer, spdchg_pga1_lpf_cap
and ENET PLL writes.  What failure modes do these address, and which
package or revision were they tested on?  Should any of them carry a
Fixes tag?

> @@ -8151,11 +8165,14 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);
>  
>  	/* Advanced Power Saving parameter */
> -	ocp_reg_set_bits(tp, 0xa430, BIT(0) | BIT(1));
> +	ocp_reg_set_bits(tp, OCP_POWER_CFG, EN_10M_PLLOFF | EN_ALDPS_PLLOFF);
>  
>  	/* Disable ALDPS force mode */
>  	ocp_reg_clr_bits(tp, 0xa44a, BIT(2));
>  
> +	/* Disable bypass_turn_off_clk_in_aldps */
> +	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, 0xd3c8, BIT(0));
> +
>  	switch (tp->version) {
>  	case RTL_VER_16:
>  		/* XG_INRX parameter */

[ ... ]

> @@ -8277,12 +8294,85 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  		sram2_write_w0w1(tp, 0x807c, 0xff00, 0x5000);
>  		sram2_write_w0w1(tp, 0x809d, 0xff00, 0x5000);
>  		break;
> +	default:
> +		break;
> +	}
> +
> +	if (rtl_phy_patch_request(tp, true, true))
> +		return;

[Severity: Medium]
This isn't a bug introduced by this patch, but the early return without
rollback is now duplicated into the RTL8159 path as well.  By this point
r8153_aldps_en(tp, false) and rtl_eee_enable(tp, false) have already run
and most per-version parameters have been written, and
rtl_phy_patch_request() can fail on timeout or when RTL8152_INACCESSIBLE
is set:

	if (request && wait &&
	    !(ocp_reg_read(tp, OCP_PHY_PATCH_STAT) & PATCH_READY)) {
		dev_err(&tp->intf->dev, "PHY patch request fail\n");
		rtl_phy_patch_request(tp, false, false);
		return -ETIME;
	}

On that path r8153_aldps_en(tp, true), r8152b_enable_fc() and
set_bit(PHY_RESET, &tp->flags) are all skipped, so the device is left
with ALDPS and EEE off, pause advertisement unrefreshed, the freshly
written SRAM/OCP parameters never latched by a PHY reset, and
tp->ups_info out of sync with the hardware.  Would it make sense to undo
the ALDPS/EEE disable before returning?

> +
> +	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, EEE_SPDWN_EN);
> +
> +	ocp_reg_w0w1(tp, OCP_DOWN_SPEED, EN_EEE_100 | EN_EEE_1000, EN_10M_CLKDIV);
> +
> +	tp->ups_info._10m_ckdiv = true;
> +	tp->ups_info.eee_plloff_100 = false;
> +	tp->ups_info.eee_plloff_giga = false;
> +
> +	ocp_reg_set_bits(tp, OCP_POWER_CFG, EEE_CLKDIV_EN);
> +	tp->ups_info.eee_ckdiv = true;
> +
> +	rtl_phy_patch_request(tp, false, true);
> +
> +	rtl_green_en(tp, test_bit(GREEN_ETHERNET, &tp->flags));
> +
> +	ocp_reg_clr_bits(tp, 0xa428, BIT(9));
> +	ocp_reg_clr_bits(tp, 0xa5ea, BIT(0) | BIT(1));
> +	tp->ups_info.lite_mode = 0;
> +
> +	if (tp->eee_en)
> +		rtl_eee_enable(tp, true);
> +
> +	r8153_aldps_en(tp, true);
> +	r8152b_enable_fc(tp);
> +
> +	set_bit(PHY_RESET, &tp->flags);
> +}
> +
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
>  
> +	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
> +
> +	r8153_aldps_en(tp, false);
> +
> +	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
> +	WARN_ON_ONCE(data != PHY_STAT_LAN_ON);

[Severity: Medium]
Is the missing rtl_eee_enable(tp, false) here intentional?  Before the
split, RTL_VER_17_QFN68/QFN100 went through the shared
r8157_hw_phy_cfg() which did:

	r8153_aldps_en(tp, false);
	rtl_eee_enable(tp, false);

The retained r8157_hw_phy_cfg() still has both calls, and
r8156b_hw_phy_cfg() carries the same step with the comment
"/* disable EEE before updating the PHY parameters */", but
r8159_hw_phy_cfg() only disables ALDPS, so the whole RTL8159
SRAM/SRAM2/OCP block and the rtl_phy_patch_request() window run with EEE
still enabled.

The tail of the function is enable-only:

	if (tp->eee_en)
		rtl_eee_enable(tp, true);

so when the user has turned EEE off via r8152_set_eee() (tp->eee_en ==
false), nothing clears OCP_EEE_CFG/OCP_EEE_ADV after hw_phy_cfg() runs
again from rtl_hw_phy_work_func_t() following a power cut, firmware
reload or resume.  Can hardware EEE state and the tp->eee_en /
tp->ups_info.eee shadow diverge in that case?  rtl_eee_enable() does
handle RTL_VER_17_QFN68/QFN100, so this does not look like a hardware
limitation.

[ ... ]

> @@ -8460,8 +8563,15 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
>  	default:
>  		break;
>  	}
> @@ -8471,9 +8581,9 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  
>  	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, EEE_SPDWN_EN);
>  
> -	ocp_reg_w0w1(tp, OCP_DOWN_SPEED, EN_EEE_100 | EN_EEE_1000, EN_10M_CLKDIV);
> -
> -	tp->ups_info._10m_ckdiv = true;
> +	ocp_reg_clr_bits(tp, OCP_DOWN_SPEED,
> +			 EN_EEE_100 | EN_EEE_1000 | EN_10M_CLKDIV);
> +	tp->ups_info._10m_ckdiv = false;
>  	tp->ups_info.eee_plloff_100 = false;
>  	tp->ups_info.eee_plloff_giga = false;
>  
> @@ -8485,7 +8595,7 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  	rtl_green_en(tp, test_bit(GREEN_ETHERNET, &tp->flags));
>  
>  	ocp_reg_clr_bits(tp, 0xa428, BIT(9));
> -	ocp_reg_clr_bits(tp, 0xa5ea, BIT(0) | BIT(1));
> +	ocp_reg_clr_bits(tp, 0xa5ea, BIT(0) | BIT(1) | BIT(2));
>  	tp->ups_info.lite_mode = 0;
>  
>  	if (tp->eee_en)
> @@ -10284,7 +10394,7 @@ static int rtl_ops_init(struct r8152 *tp)
>  		ops->eee_get		= r8153_get_eee;
>  		ops->eee_set		= r8152_set_eee;
>  		ops->in_nway		= rtl8153_in_nway;
> -		ops->hw_phy_cfg		= r8157_hw_phy_cfg;
> +		ops->hw_phy_cfg		= r8159_hw_phy_cfg;
>  		ops->autosuspend_en	= rtl8157_runtime_enable;
>  		ops->change_mtu		= rtl8156_change_mtu;
>  		tp->rx_buf_sz		= 48 * 1024;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903072852.58695-1-nic_swsd%40realtek.com
