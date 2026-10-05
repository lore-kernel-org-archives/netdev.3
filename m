Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78BC440A07;
	Mon,  5 Oct 2026 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194249; cv=none; b=YxZwt8qxqx7nj5wgmISkaVHCkfa21+fxKw7zFVc141UepZiD+klmfuQQXs/iY4DB/fL+DKPss4Qu1OfIMH2gYPc3ATmmjayL9dSMakyx8vkdHbZpa5cu/MI7NIZ1px7VjziMqqgmGUHto+YhVFWi7JS+1e8ssENgh+sF/NmJiec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194249; c=relaxed/simple;
	bh=nJI3QRxbJvrPxYZ4wRFsIBhrlonNjZyU61F5+v5vbj4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S2S2Xcbksv4rpBpY7Z5SOQFhljQvZW9jpKfR4M2H2kRRnugHQW6AjuIo08vlbsZkRF1hJs6rknrzk3co91fyFVKqRggrnen6FC24GDIus5bllC8InMFQgSakh5uwoK118R2c+Va6jbQWgnlmiOiPk/Xv3tnPNj9mujvsrxZOwEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdk4wWuI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdk4wWuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1606F1F00893;
	Mon,  5 Oct 2026 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791194242;
	bh=nH0LGWFiYcjbeClSZ/sAulz56g8Z4+AzX1TqfQEsvVI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fdk4wWuISslPlhbg3h6wFa4rJ82Syhd7djyeaN1Hf7BkQsgRe+/hPBfXsuDmJW5bO
	 8pbUPrsUuFfCrvXewPU3L9cZcjoo/S574XsiQQVpOxOldV453eBfVoykvAXsM1Ms7K
	 k5ZQxInSLFVGvRKk04GrklZ6Nede00KgU0qQsa1ZNc5+5eBymvo2t8Gp7dKWAZw1Ia
	 Y2rkNdBW3Y9XR4Xu6lIboRMrNw7TwBYZao8uRDCKkQrZPyTPnJyt7InXd7ltWnGbI9
	 aZfeKDDpYwM0z1mbSU3suv1nEAJlg1bM8FL4wW/3PakWIA9LJ2MiSVf5UTy3qcunB7
	 bnmXG5gPLsrEQ==
Subject: Re: [PATCH net-next v5 5/9] r8152: split r8157_hw_phy_cfg into
 RTL8157 and RTL8159 variants
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Mon, 05 Oct 2026 09:57:21 +0000
Message-ID: <179119424162.434549.12438188375752636403@kernel.org>
In-Reply-To: <20261001091144.28191-6-nic_swsd@realtek.com>
References: <20261001091144.28191-6-nic_swsd@realtek.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] r8159_hw_phy_cfg() (drivers/net/usb/r8152.c,
  RTL_VER_17_QFN68/QFN100) no longer calls rtl_eee_enable(tp, false),…
- [Low] The commit message says the split gives each function 'its own
  copy of the shared prologue/epilogue instead of switching on version…

--

r8152: split r8157_hw_phy_cfg into RTL8157 and RTL8159 variants

This patch splits r8157_hw_phy_cfg() into r8157_hw_phy_cfg() for
RTL_VER_16 and a new r8159_hw_phy_cfg() for RTL_VER_17_QFN68/QFN100. The
RTL8159 variant no longer calls rtl_eee_enable(tp, false), changes how the
EEE clock divider and 0xa5ea are programmed, and adds new PHY tuning
parameters. It also adds the sram2_set_bits()/sram2_clr_bits() helpers.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 1d7cca55104cc..13a59a1df37ea 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> +static void r8159_hw_phy_cfg(struct r8152 *tp)
> +{
> +	u16 data;
> +
> +	r8156b_wait_loading_flash(tp);

[ ... ]

> +	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
> +
> +	r8153_aldps_en(tp, false);
> +
> +	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);

[Severity: Medium]
With rtl_eee_enable(tp, false) gone, does anything on this path still
write the EEE-disabled state to the chip when tp->eee_en is false?

The epilogue of r8159_hw_phy_cfg() only does this:

	if (tp->eee_en)
		rtl_eee_enable(tp, true);

Before this patch, RTL_VER_17 always called rtl_eee_enable(tp, false)
first. Through r8156_eee_en(tp, false), that call clears EEE_RX_EN and
EEE_TX_EN in PLA_EEE_CR, EEE10_EN in OCP_EEE_CFG, and the 2.5G/5G bits in
OCP_EEE_ADV2. It then writes 0 to OCP_EEE_ADV. So at the end of the
function the hardware always matched tp->eee_en.

Take a user who turns EEE off:

r8152_set_eee()
    tp->eee_en = eee->eee_enabled;   /* false */
    rtl_eee_enable(tp, tp->eee_en);

The device then loses power or is reset:

r8156_ups_en(tp, false)   /* PCUT_STATUS set */
    tp->rtl_ops.hw_phy_cfg(tp)   -> r8159_hw_phy_cfg()
    rtl8152_set_speed(...)

The same applies to rtl8152_reset_resume() -> hw_phy_work ->
r8159_hw_phy_cfg(). Neither path touches the EEE registers, so they keep
their post-reset or firmware defaults.

If those defaults have EEE advertised, could the RTL8159 advertise EEE
and enter LPI after the user disabled it? r8153_get_eee() would then
report eee_enabled from tp->eee_en, but the advertised mask from
OCP_EEE_ADV/OCP_EEE_ADV2.

The commit message says:

    RTL8159 doesn't need EEE disabled before reprogramming PHY
    parameters, so r8159_hw_phy_cfg() drops the rtl_eee_enable(tp,
    false) call that r8157_hw_phy_cfg() keeps.

That call was also the only place where eee_en == false got applied to
freshly reset hardware. The other hw_phy_cfg variants keep the
disable-then-conditionally-enable pattern, and r8152b_hw_phy_cfg() uses
rtl_eee_enable(tp, tp->eee_en).

Would calling rtl_eee_enable(tp, tp->eee_en) in the r8159_hw_phy_cfg()
epilogue respect the datasheet requirement and still apply the user's
setting?

> +	WARN_ON_ONCE(data != PHY_STAT_LAN_ON);
> +
> +	/* PFM mode */
> +	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);

[ ... ]

> +	/* Disable bypass_turn_off_clk_in_aldps */
> +	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, 0xd3c8, BIT(0));
> +
> +	switch (tp->version) {
>  	case RTL_VER_17_QFN68:
>  	case RTL_VER_17_QFN100:

[Severity: Low]
This isn't a bug, but the commit message says each function gets:

    its own copy of the shared prologue/epilogue instead of switching on
    version mid-function.

Both functions still switch on tp->version mid-function.
rtl_ops_init() assigns r8157_hw_phy_cfg() only for RTL_VER_16, and
r8159_hw_phy_cfg() only for RTL_VER_17_QFN68/QFN100.

That means the switch (tp->version) here and the one in
r8157_hw_phy_cfg() each have just one reachable case. The default
branches can never run.

Could these switches be dropped, or the commit message changed to match
the code?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001091144.28191-1-nic_swsd%40realtek.com
