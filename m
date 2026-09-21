Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A044519BE;
	Mon, 21 Sep 2026 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979436; cv=none; b=IWstl9E5mJW0Ikz3TrqeLq7qH98mfl70SXvDDbfhc0sO6BNkeQRULfGtrAP6qnQxQtsFqOHUc0X4PtDXb2I0i9OUDj+oFZpFhJ6jI6q/pdmWUWJgGxEM6cT1obzREszA3y5hLgCKGygjN+7pkNglsY+AKoqJbJZ6Oq+VzE/KbTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979436; c=relaxed/simple;
	bh=Yd0uxyHQTGlQ3+hCXGPlmYlFuHJrMutLMSCThQbrFFY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n4NfMTA5GFYKcoA9NVCHVXaLCw5mpSLmhnwUl72+GKeCPmWvicHobkJVLMUU/63BOC/5GkYUMlTS68Y+goHDJl6cr4Lr59zp2sXZ63kRi/vy7/mSs2xTfOKrROXHiC3qjGyuEBidPYDKtgljinGATwbeV1ZjRkMTGGEMJLJ8i0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJWrQ5ck; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJWrQ5ck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374291F000FF;
	Mon, 21 Sep 2026 08:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789979434;
	bh=W+9/LqQt7kHG504rV0ExfKya1vB2CfePQ2Ls9RNjdIU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RJWrQ5ckGqApePtfDNmSrTvM0Y5ObURNkZ61RF5lbh0pHCofKZ9+mTi92ONuE7hQy
	 SREmbw7EgzeMiILd9c4Skr5PpMKioH03Ll6b2Larc8YrIh63vdyVbv9AD8TcXBayTz
	 abxZyDetAc1Ve+aoc5IlbfWDlIFA2FJCibKHalZ/AwmCk1iTuMpyWhWAPUc7MM1B/M
	 G/jv2kCJpgo1RIqQ/RQx2w6T0Rg+zU+CVWWM56AmLY2gC6Lio9REa/GkAmmpkwm3wp
	 GS5TDtHnFCUt5alLokvzkqLvC3R6wJo5J6XpfO2ApqkmbPIXSZsv2D5gekdnv9UMnM
	 +ggc6tLNOXmNQ==
Subject: Re: [PATCH net-next v4 3/8] r8152: split rtl8156_enable/up/down into
 per-chip-family functions
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Mon, 21 Sep 2026 08:30:33 +0000
Message-ID: <178997943377.2160803.16681954944740037290@kernel.org>
In-Reply-To: <20260917070637.62827-4-nic_swsd@realtek.com>
References: <20260917070637.62827-4-nic_swsd@realtek.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] For RTL8157/RTL8159 (RTL_VER_16, RTL_VER_17_QFN68,
  RTL_VER_17_QFN100) the newly extracted rtl8157_up() / rtl8157_down()…
- [Medium] The patch is presented as a refactor ("split
  rtl8156_enable/up/down into per-chip-family functions") but it…
- [Medium] Suspicious bitwise clear for Clear_SDR feature in rtl8157_up()

--

r8152: split rtl8156_enable/up/down into per-chip-family functions

This splits the version-guarded rtl8156_enable()/rtl8156_up()/rtl8156_down()
into per-chip-family callbacks: rtl8156b_enable() for VER_12/13/15 and
rtl8157_enable()/rtl8157_up()/rtl8157_down() for VER_16/17, while
rtl8156_up()/rtl8156_down() keep serving VER_10..VER_15. Along the way
several register writes that were previously version guarded become
unconditional for one family or another.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 9ce072c38b5b5..c513c286c5499 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -6849,8 +6892,7 @@ static void rtl8156_up(struct r8152 *tp)
>  
>  	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
>  
> -	if (tp->version >= RTL_VER_16)
> -		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
> +	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));

[Severity: Medium]

Should the behaviour changes to already-supported chips be a separate
patch from the mechanical split?

The subject describes a split, but this hunk starts clearing PLA_RCR1
BIT(3) on every ifup for RTL8156/8156B, which previously only happened
for VER_16 and later. The same patch also:

- adds a Clear_SDR write for VER_13/15 (USB 0xd3ca BIT(15)) in
  rtl8156_up()
- clears USB_SPEED_OPTION RG_PWRDN_EN|ALL_SPEED_OFF for RTL8157/8159 in
  rtl8157_up(), which was excluded for them before
- adds PLA_BDC_CR ALDPS_PROXY_MODE and PLA_OOB_CTRL DIS_MCU_CLROOB to OOB
  entry in rtl8156_down() and rtl8157_down()
- changes RTL8157/8159 OOB sizing to PLA_RMS=1526 and PLA_MTPS=10K in
  rtl8157_down()

The commit message says:

  "Per the datasheet, this uncovers real register differences that the
   old version guards had wrong or missing"

If the old guards were wrong, then shipping RTL8156/8156B dongles are
mis-programmed today, in particular for the OOB/wake-on-LAN path after
ifdown. Can the message name the observed symptom, add Fixes: tags for
the commits that introduced the wrong guards (195aae321c82, fd3c7d080df5,
ad2a55b63b41), and state which chips were tested?

Splitting the refactor from the register fixes would also let the fixes be
backported and bisected on their own.

>  
>  	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
>  
> @@ -6872,11 +6914,11 @@ static void rtl8156_up(struct r8152 *tp)
>  	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
>  		      0x08);
>  
> -	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
> +	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
> +			  PLA_MCU_SPDWN_EN);
>  
> -	if (tp->version < RTL_VER_16)
> -		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
> -				  RG_PWRDN_EN | ALL_SPEED_OFF);
> +	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
> +			  RG_PWRDN_EN | ALL_SPEED_OFF);

[ ... ]

> @@ -6929,7 +6977,102 @@ static void rtl8156_down(struct r8152 *tp)

[ ... ]

> +static void rtl8157_up(struct r8152 *tp)
> +{
> +	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> +		return;
> +
> +	r8153b_u1u2en(tp, false);
> +	r8153_aldps_en(tp, false);

[ ... ]

> +	/* share FIFO settings */
> +	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
> +		      0x08);
> +
> +	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
> +			  RG_PWRDN_EN | ALL_SPEED_OFF);

[Severity: Medium]

Is dropping the PLA_MCU_SPDWN_EN programming intentional for
RTL8157/RTL8159?

Before the split, VER_16/VER_17 ran rtl8156_up(), which cleared the bit
unconditionally at exactly this spot in the sequence:

	/* share FIFO settings */
	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
		      0x08);

	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);

	if (tp->version < RTL_VER_16)
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
				  RG_PWRDN_EN | ALL_SPEED_OFF);

and the old rtl8156_down() had

	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
			  PLA_MCU_SPDWN_EN);

as its first register write for these chips. Neither rtl8157_up() nor
rtl8157_down() touches PLA_MAC_PWR_CTRL3.

Grepping PLA_MCU_SPDWN_EN after the patch leaves only rtl8153b_up/down,
rtl8153c_up, rtl8156_up/down, r8153b_init, r8156_init and r8156b_init.
r8157_init() and r8159_init() do not clear it either, and
r8156_mac_clk_spd(), which r8157_init() does call, only writes
PLA_MAC_PWR_CTRL and PLA_MAC_PWR_CTRL2.

So for VER_16 and both VER_17 variants the MCU speed-down enable is now
never written: while the interface is up it keeps whatever the ROM/OOB
firmware or a previous driver instance left, and the set on OOB entry is
gone. The commit message enumerates the other register deltas but not
this one. Was the paired clear-on-up / set-on-down meant to be carried
over into rtl8157_up()/rtl8157_down()?

The omission is also still present at the end of the series
(eac8e24403901016050a115a3102a0c0b46ddbbd), where the later added
rtl8157_unload() does not add it back.

> +
> +	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
> +
> +	if (tp->saved_wolopts != __rtl_get_wol(tp)) {
> +		netif_warn(tp, ifup, tp->netdev, "wol setting is changed\n");
> +		__rtl_set_wol(tp, tp->saved_wolopts);
> +	}
> +
> +	r8153_aldps_en(tp, true);
> +
> +	/* Clear_SDR */
> +	ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xd378, BIT(7));
> +	ocp_word_clr_bits(tp, MCU_TYPE_USB, 0xcd06, BIT(15));
> +}
> +
> +static void rtl8157_down(struct r8152 *tp)
> +{
> +	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
> +		rtl_drop_queued_tx(tp);
> +		return;
> +	}
> +
> +	r8153b_u1u2en(tp, false);
> +	r8153_aldps_en(tp, false);

[Severity: Medium]
Is the clear (rather than set) of USB 0xcd06 BIT(15) here what you
meant?

The commit message says RTL8157/8159 "gain their own Clear_SDR enables
(USB 0xd378 BIT(7), USB 0xcd06 BIT(15))", and the comment above the two
writes just says "Clear_SDR". The first write uses ocp_byte_set_bits()
to set 0xd378 BIT(7), which matches "enable". The second uses
ocp_word_clr_bits() to zero 0xcd06 BIT(15), which is the opposite
direction, and it is the only Clear_SDR write in the series that clears
rather than sets: the RTL8156B path added in this same patch does

	ocp_word_set_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(15));

for its Clear_SDR enable. If 0xcd06 BIT(15) is an active-low or
disable-type bit, that would explain the asymmetry, but nothing in the
code or the changelog says so, and a plain clr/set typo here would
silently leave Clear_SDR off on RTL8157/8159 with no visible error.

Since these are bare magic addresses with no register defines, please
either give the bit a name (a #define alongside the other USB_*
registers) or extend the comment to state the polarity, e.g. that
BIT(15) of 0xcd06 must be 0 to enable Clear_SDR. Can you confirm
against the datasheet which of set/clear the hardware needs for that
bit?

[ ... ]

> +	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, 1526);
> +	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, 10 * 1024 / 64);

[ ... ]

> @@ -10090,10 +10233,10 @@ static int rtl_ops_init(struct r8152 *tp)
>  		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
>  		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
>  		ops->init		= r8157_init;
> -		ops->enable		= rtl8156_enable;
> +		ops->enable		= rtl8157_enable;
>  		ops->disable		= rtl8153_disable;
> -		ops->up			= rtl8156_up;
> -		ops->down		= rtl8156_down;
> +		ops->up			= rtl8157_up;
> +		ops->down		= rtl8157_down;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917070637.62827-1-nic_swsd%40realtek.com
