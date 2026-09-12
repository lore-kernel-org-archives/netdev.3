Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED89747A0A6;
	Sat, 12 Sep 2026 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244394; cv=none; b=rPxwQiw01vbvgmK0KLqu7jhgZZHqLo155US2fjJLOLqKVdNvuWZP1mc1vyAxBpGaKoeBfGoQ/qPjCpo1UbHKq1Rg7uzUJD0mvDepVEUUslQ5fFF012+w494ZwUabJcLxsycwkGpHL+O4Wqjf/TLEQnhjs8WYWaYVP3duI2BKWN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244394; c=relaxed/simple;
	bh=ldUSerSW2jBG177oZuwzg+AV8RaFXr9+CjFcvJbfNl4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s/5cwXvKPh75Qr8hhtt3QH2Nb5y/kApYL3JJM5muxWvcG6mkSXU7aRq7JdZotOCCxNZYnC0LGWnfGQgFoGxRV7AFl0IKIBo22rH4ZEateJFQ8tUcuMJdT8DfwKgYAFF0aiGR4vM8Wy2NPGfWBl//pnotggI46h/pABEgzEraisU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVRyCJ9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVRyCJ9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126E81F00893;
	Sat, 12 Sep 2026 20:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244392;
	bh=vjPZo04BgPYNcUO28YJgJQk0wsO/k39wxGT7T054q0o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZVRyCJ9X9Vomk5mmBrDCPIx424pF7/W9if/jD7RR7hrHUFGU/ztineEt1syC1o7+q
	 6CEox8ME1WrTHeksvnRS6a6Gp+Us32SUrYQiaTSBDKBKJS5AuBqkmr7z7iSbYnaiMt
	 pEjNZeU+z74rJ4EN0pXxr9f4k7ZiF3rrbHgNO6232kQQBSqKeasiTxxvdFpuc1iJCd
	 nozngFuF92zD0L5F4vjYrR0AEM7iO8HVztpz15urNxahE1w2eXsL3PxCNFo8XeyHPE
	 5aKLlFFh6RYZSQKGD8ZkoSuxRTcexAmJHBRyEos9L2CDmaU5v/RpdCxstz03WYtd2u
	 7I9kj4HY02zRg==
Subject: Re: [PATCH net-next v3 4/8] r8152: refactor r8157_hw_phy_cfg
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Sat, 12 Sep 2026 20:19:51 +0000
Message-ID: <178924439160.3125.7530266584332142922@kernel.org>
In-Reply-To: <20260908075634.23740-5-nic_swsd@realtek.com>
References: <20260908075634.23740-5-nic_swsd@realtek.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] r8159_hw_phy_cfg() (drivers/net/usb/r8152.c:8332), newly bound
  as the hw_phy_cfg handler for RTL_VER_17_QFN68/RTL_VER_17_QFN100 in…
- [Low] The commit is presented as 'refactor r8157_hw_phy_cfg' with
  'update PHY parameters for RTL8156B/57/59', but it silently changes…

--

r8152: refactor r8157_hw_phy_cfg

This splits the shared r8157_hw_phy_cfg() into r8157_hw_phy_cfg() for
RTL_VER_16 and a new r8159_hw_phy_cfg() for RTL_VER_17_QFN68/QFN100,
rebinds the VER_17 ops entry to the new function, adds sram2_set_bits()
and sram2_clr_bits() helpers, and adjusts PHY parameters for
RTL8156B/57/59.

Two questions below.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 6c189790b0bab..679aead731f73 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

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

[Severity: Low]
This isn't a bug, but the commit message describes this as a refactor plus
an "update PHY parameters for RTL8156B/57/59", and some of the register
programming changes are hard to classify from the message alone.

In r8157_hw_phy_cfg() this 0xd3c8 BIT(0) clear was previously inside the
"case RTL_VER_17_QFN68/RTL_VER_17_QFN100:" arm only, and it is now above
the version switch, so RTL8157 (RTL_VER_16) executes it for the first
time.

In r8156b_hw_phy_cfg() the new "Nway DACONB parameters" write:

	ocp_reg_w0w1(tp, 0xa4ca, 0x6000, 0x0040);

retunes RTL8156B (RTL_VER_13/RTL_VER_15) in a patch whose subject is an
r8157 refactor.

Can the changelog say which of these register changes fix an observed
symptom (and therefore want a Fixes: tag and stable backporting) versus
which are vendor tuning?  Would the RTL8156B change be better as its own
patch?

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

[ ... ]

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
Was dropping the EEE disable here intentional for RTL8159?

Before the split, RTL_VER_17_QFN68/QFN100 went through the shared
r8157_hw_phy_cfg(), which quiesced both ALDPS and EEE before touching PHY
parameters, and the RTL_VER_16 half still does:

	r8153_aldps_en(tp, false);
	rtl_eee_enable(tp, false);

r8159_hw_phy_cfg() only calls r8153_aldps_en(tp, false) and then starts
reprogramming PHY/SRAM/OCP parameters, including the EEE related ones
(PLA_MAC_PWR_CTRL4 EEE_SPDWN_EN, OCP_DOWN_SPEED and OCP_POWER_CFG
EEE_CLKDIV_EN).  The other handlers in this driver comment on that
ordering explicitly, for example in r8156b_hw_phy_cfg():

	/* disable EEE before updating the PHY parameters */
	rtl_eee_enable(tp, false);

The remaining half of the pair is only the conditional enable at the tail
of r8159_hw_phy_cfg():

	if (tp->eee_en)
		rtl_eee_enable(tp, true);

With tp->eee_en set to false through r8152_set_eee(), nothing turns
hardware EEE off any more, so after a re-run of hw_phy_cfg (the
PCUT_STATUS resume paths, or rtl_hw_phy_change_work_func() calling
tp->rtl_ops.hw_phy_cfg(tp)) does the PHY come back with its default EEE
state while ups_info still records EEE as disabled, silently undoing an
earlier "ethtool --set-eee eee off"?

This still looks the same at the end of the series, so no later patch in
the set restores the disable.

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
>  	case RTL_VER_17_QFN68:
>  	case RTL_VER_17_QFN100:
> -		/* Disable bypass turn off clk in ALDPS */
> -		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, 0xd3c8, BIT(0));
> -
>  		/* Power level tuning
>  		 * test mode power level
>  		 */

[ ... ]

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

These two hunks land in the RTL8159 epilogue and also change behaviour
rather than move code: EN_10M_CLKDIV goes from set to cleared with
ups_info._10m_ckdiv flipping from true to false (that field feeds the
UPS/suspend programming), and 0xa5ea BIT(2) is newly cleared.  Could the
changelog mention what these two changes do for RTL8159?

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
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908075634.23740-1-nic_swsd%40realtek.com
