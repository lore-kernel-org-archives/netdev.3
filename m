Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F04521221;
	Fri,  4 Sep 2026 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560729; cv=none; b=W7jccufVjTYL17qEbFxzr2uTilq+px+BAxFJDrv6tkBRda0N5Y8/TjqANQn/0ljLXkwOXz2CbzqZbGjfQfMMHUY4O9EblR8nHzLVB2NsaAtXHa5vdxEcyWTQ5/ZLmkuTPSJP62kIrk+pEGCjc5QR5eFLFC7ByNfJiLXP/cZVy20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560729; c=relaxed/simple;
	bh=yFYg8z07zPKiq5WiLXfvWf+Qv9ECVqBxRlO/S1R6UVo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=inA2X1lVb2nFuKr5nEKCb6ZW000J50vz+IItSoKDZAXmJqH9U8XaWKYeQGJueesRQOLE3EntSLq057vUZc0KdMImwmpDIA+mXTYHwKHHqt1CbHLougrYjBYvhm6D68o32M/aL78WVV12Zw0bGs382nWxz1CdEM8bc1xnuVMHOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWRh1oon; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWRh1oon"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98DE1F00ADB;
	Fri,  4 Sep 2026 22:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560723;
	bh=oLRqweM/f4JDqD7ZIBMmJbNJU8mg0h7QjEqi7roiD24=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mWRh1oon0riGZRqR5/ewlKkeTOzMWtGZoxjDlZtutEO0YXfrjlr8f8/48CQ+cLIw/
	 XjVnl7YVedAqILYj3AiYyL2WL3U4uxnBFYBuownJ7bKGkcNba3sU22DQVivTy1AGmG
	 DNJtwpfkwLondwS1yxu+S5wyrlDLDsEZIYV0SnDcjE9Wi8KznOO0mKNPfvTeBLHG3A
	 hE9/yaJbNSHk14TidBZVqoMAqg3S+Fh8H99map9lI4yRyVS/ksBBXimL6Phjr1GER6
	 qFDiqWt+P2MrZ/7U2HxRAKbNhx09XzbxOVYA1Pc8b1venKv0dMofY2OkHAq3ig5WYx
	 02UD8WIDgpAFw==
Subject: Re: [PATCH net-next v9 6/7] r8169: add ltr support for RTL8117 series
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, linux@armlinux.org.uk,
 enelsonmoore@gmail.com, daniel@thingy.jp
Date: Fri, 04 Sep 2026 22:25:22 +0000
Message-ID: <178856072250.219967.7821276831481477544@kernel.org>
In-Reply-To: <20260831053745.1197-7-javen_xu@realsil.com.cn>
References: <20260831053745.1197-7-javen_xu@realsil.com.cn>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

- [Medium] Undisclosed scope creep in rtl_enable_ltr(): the newly added
  `r8168_mac_ocp_modify(tp, SEND_LTR_MSG, 0x0000, LTR_MSG_EN)` (MAC-OCP…
- [Medium] The patch splits RTL_GIGA_MAC_VER_52 out of the VER_46..48
  branch of rtl_enable_ltr() into its own case (r8169_main.c:3199-3214)…

--

r8169: add ltr support for RTL8117 series

This adds a dedicated LTR programming sequence for RTL_GIGA_MAC_VER_52 in
rtl_enable_ltr(), adds VER_52 to the L1.2 enable/disable version lists in
rtl_hw_aspm_clkreq_enable(), and sets a new MAC OCP bit (0xe038 BIT(0)) at
the end of rtl_enable_ltr().

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index eecde26d9de2c..5dbbc3a48c09a 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -353,11 +353,13 @@ enum rtl_registers {
>  	ALDPS_LTR	= 0xe0a2,
>  	LTR_OBFF_LOCK	= 0xe032,
>  	LTR_SNOOP	= 0xe034,
> +	SEND_LTR_MSG	= 0xe038,
>  
>  #define ALDPS_LTR_EN			BIT(0)
>  #define LTR_OBFF_LOCK_EN		BIT(0)
>  #define LINK_SPEED_CHANGE_EN		BIT(14)
>  #define LTR_SNOOP_EN			GENMASK(15, 14)
> +#define LTR_MSG_EN			BIT(0)
>  };
>  
>  enum rtl8168_8101_registers {

[ ... ]

> @@ -3194,8 +3196,23 @@ static void rtl_enable_ltr(struct rtl8169_private *tp)
>  		r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
>  		r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0000, LINK_SPEED_CHANGE_EN);
>  		break;
> -	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
>  	case RTL_GIGA_MAC_VER_52:
> +		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
> +		r8168_mac_ocp_modify(tp, LTR_SNOOP, 0x0000, LTR_SNOOP_EN);
> +		r8168_mac_ocp_write(tp, 0xe02c, 0x1880);
> +		r8168_mac_ocp_write(tp, 0xe02e, 0x4880);
> +		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
> +		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd2, 0x883c);
> +		r8168_mac_ocp_write(tp, 0xcdd4, 0x8c12);
> +		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xe0a6, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xe0a8, 0x9003);
> +		r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0000, LINK_SPEED_CHANGE_EN);
> +		break;
> +	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
>  		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
>  		RTL_W8(tp, COMBO_LTR_EXTEND, RTL_R8(tp, COMBO_LTR_EXTEND) | COMBO_LTR_EXTEND_EN);
>  		fallthrough;

[Severity: Medium]
Splitting RTL_GIGA_MAC_VER_52 out of the VER_46..48 arm drops this write for
every VER_52 device:

	RTL_W8(tp, COMBO_LTR_EXTEND, RTL_R8(tp, COMBO_LTR_EXTEND) | COMBO_LTR_EXTEND_EN);

The changelog justifies the removal with "this bit is not required for
RTL8116af", but is RTL_GIGA_MAC_VER_52 equivalent to RTL8116af?

rtl_chip_infos maps both XIDs to the same mac_version:

	{ 0x7cf, 0x54b,	RTL_GIGA_MAC_VER_52, "RTL8168fp/RTL8117" },
	{ 0x7cf, 0x54a,	RTL_GIGA_MAC_VER_52, "RTL8168fp/RTL8117",
	  FIRMWARE_8168FP_3 },

and the af variant is only distinguished at runtime:

	static bool rtl_is_8116af(struct rtl8169_private *tp)
	{
		return tp->mac_version == RTL_GIGA_MAC_VER_52 &&
			(r8168_mac_ocp_read(tp, RTL_PKG_DETECT) & RTL_PKG_DETECT_MASK) ==
			RTL_PKG_DETECT_8116AF && ...

So plain RTL8117/RTL8168fp cards that have had the COMBO_LTR_EXTEND_EN write
since LTR support was added now lose it. Should the removal be gated with
rtl_is_8116af(), or should the changelog state that the bit is not needed on
any RTL8117 and explain the behaviour change for existing hardware?

The following patch in the series, "r8169: fix RTL8116af can not enter
s0idle and c10", does not touch rtl_enable_ltr(), so this stands at the end
of the series.

> @@ -3215,6 +3232,7 @@ static void rtl_enable_ltr(struct rtl8169_private *tp)
>  	}
>  	/* chip can trigger LTR */
>  	r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0003, LTR_OBFF_LOCK_EN);
> +	r8168_mac_ocp_modify(tp, SEND_LTR_MSG, 0x0000, LTR_MSG_EN);
>  }

[Severity: Medium]
Was this write meant to be limited to the new RTL_GIGA_MAC_VER_52 arm?

It sits in the shared epilogue after the switch in rtl_enable_ltr(), and
every non-default case ends in break (or falls through into VER_51), so it is
also executed for VER_46..48, VER_51, VER_61..66, VER_70 and VER_80 by way of
rtl_hw_aspm_clkreq_enable()->rtl_enable_ltr() on any chip >= VER_32 with
tp->aspm_manageable.

SEND_LTR_MSG (0xe038) and LTR_MSG_EN are introduced here and appear nowhere
else under drivers/net/ethernet/realtek/, so there is no in-tree precedent
for this bit on the 8168h/8168ep or 8125/8126/8127 generations, whose LTR
value tables in the same function are entirely different.

VER_51 in particular now gets LTR message generation enabled while it is
absent from both mac_version lists in rtl_hw_aspm_clkreq_enable(), so it
never receives the matching "chip can trigger L1.2" programming.

The rest of the patch is carefully version gated (a dedicated
case RTL_GIGA_MAC_VER_52 is split out, and VER_52 is added to both lists in
rtl_hw_aspm_clkreq_enable()). Could this write be moved into the
case RTL_GIGA_MAC_VER_52 block, or gated by an explicit version list, or the
changelog extended to cover the wider hardware change it makes?

> @@ -3248,6 +3266,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>  		rtl_enable_ltr(tp);
>  		switch (tp->mac_version) {
>  		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
> +		case RTL_GIGA_MAC_VER_52:
>  		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
>  			/* reset ephy tx/rx disable timer */
>  			r8168_mac_ocp_modify(tp, 0xe094, 0xff00, 0);
> @@ -3260,6 +3279,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>  	} else {
>  		switch (tp->mac_version) {
>  		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
> +		case RTL_GIGA_MAC_VER_52:
>  		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
>  			r8168_mac_ocp_modify(tp, 0xe092, 0x00ff, 0);
>  			break;

Related to the SEND_LTR_MSG question above: this disable path clears only
0xe092 and never LTR_MSG_EN, so once ASPM has been enabled once the new bit
stays set on all affected chips. Is that intended?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831053745.1197-1-javen_xu%40realsil.com.cn
