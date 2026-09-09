Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83433569F08;
	Wed,  9 Sep 2026 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960732; cv=none; b=XbUMSJP19rBBkVMBeHSh8DZOGtBgaBTq4tAFD8iQdPUy00RBxi9DrGoAM9mi1wHlK73GeE2dxInPkSnGoSfeGq8lkDupLzw7FqT+CbkJDNWT/O+BSJgVATop0WLj6Aj59k3YwbyBKGR6sGwBf9ntB9mvAZGzN9LGKKtQmMZIZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960732; c=relaxed/simple;
	bh=6s0rPQfIWOKrgI0bIdqdeuNqR8CHzNCj1sCcZoUyDwk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cAKh2hi3ah6sYhNG/UeOHBlxbKUpMj8fdC5DpIMFRHaMGItkSdKCkNqjId6w42KkSBDkoideih9IGZX8F+GCEJ8wErIOq/sPwN8X5sbWpf4a5RupToYwDINl5v0XbYjkb3eSYQAlMNEZ/Wrb2b5Yd8mTldrzKKNUHf4QXRikyE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfvHR9Gm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfvHR9Gm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8257A1F00A3E;
	Wed,  9 Sep 2026 13:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960730;
	bh=72EtHI1jVwBt4tj52albuu/42pwmfxJmivqR0+f1yqM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NfvHR9GmCLLnp1ToJSaL37eps0EuRuQoiL7vnFuNARI69NWwSh/P5HCZUz8/ydww6
	 Mo5lyj4giux8KVJQ25njgkFHI6pEKe9uxNdt+t4OXMFuuRqTXvx6KrN8jcUZliWGzk
	 aasDFg5cXQIO8tih1NGSsmG4fegSe0D3uPd7Kq+xUhilYfbJgu3R92o+iCVvPEwG6Z
	 0STVMae6eiafy1kYG0eIPOqO8wcFR9pJ8Cn4pIMHxxQ0MFcmBgoUT+eCDFK7MKolWo
	 ZhKdsBDv02Fn1P+gxFJSXB+uzsc4TpahdOFxiNeIC0EW6e1QPq1NYidx3/9MvA+xU0
	 TXaZYLopBiwFA==
Subject: Re: [PATCH net-next v2 3/8] r8152: refactor rtl8156_enable,
 rtl8156_up, and rtl8156_down
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Wed, 09 Sep 2026 13:32:09 +0000
Message-ID: <178896072912.219967.2517940126950088007@kernel.org>
In-Reply-To: <20260903072852.58695-4-nic_swsd@realtek.com>
References: <20260903072852.58695-4-nic_swsd@realtek.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 2 · Low: 1

- [High] Guard inversion during the function split:
  `ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3))` was gated by…
- [High] Second guard inversion: the new rtl8157_up() unconditionally
  executes `ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,…
- [Medium] The commit is presented as a mechanical refactor ("instead of
  handling per-version differences with inline version guards"), but it…
- [Medium] rtl8157_up() omits the `ocp_word_clr_bits(tp, MCU_TYPE_PLA,
  PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN)` that the shared rtl8156_up()…
- [Low] The commit message states that "RTL8156B and RTL8157/8159 have
  different enable, up, and down sequences from RTL8156" and that…

--

r8152: refactor rtl8156_enable, rtl8156_up, and rtl8156_down

This splits the shared RTL8156 enable/up/down handlers into per-generation
callbacks: rtl8156b_enable for VER_12/13/15, and rtl8157_enable,
rtl8157_up and rtl8157_down for VER_16/17.  rtl_ops_init() is updated to
install the new callbacks.

A few questions below about the version guards that were removed during the
split, and about how the commit message describes the change.

[Severity: Medium]
The commit message describes this as replacing inline version guards with
dedicated functions:

    "Add dedicated rtl8156b_enable (VER_12/13/15), rtl8157_enable,
     rtl8157_up, and rtl8157_down (VER_16/17) instead of handling
     per-version differences with inline version guards."

That reads as behaviour preserving, but the up/down register sequences
change for both families:

- rtl8156_up() now clears PLA_RCR1 bit 3 for VER_10 through VER_15, which
  was previously done only for VER_16 and later
- rtl8157_up() clears USB_SPEED_OPTION RG_PWRDN_EN | ALL_SPEED_OFF, which
  the old shared path skipped for VER_16 and later, and it no longer
  clears PLA_MAC_PWR_CTRL3 PLA_MCU_SPDWN_EN
- rtl8157_down() no longer sets PLA_MCU_SPDWN_EN, and changes PLA_RMS from
  1522 to 1526 and PLA_MTPS from MTPS_DEFAULT to 10 * 1024 / 64
- both down paths now program PLA_BDC_CR ALDPS_PROXY_MODE and
  PLA_OOB_CTRL DIS_MCU_CLROOB
- new Clear_SDR writes are added to rtl8156_up() and rtl8157_up()

Could the commit message describe these hardware sequence changes, or
could they be split into separate patches?

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index f01f442fa71a..6c189790b0ba 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -6869,8 +6912,7 @@ static void rtl8156_up(struct r8152 *tp)
>  
>  	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
>  
> -	if (tp->version >= RTL_VER_16)
> -		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
> +	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));

[Severity: High]
Is this write inverted rather than moved?  Before the patch it ran only
for VER_16 and later:

	if (tp->version >= RTL_VER_16)
		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));

After the split, rtl_ops_init() installs rtl8156_up as ops->up only for
RTL_VER_10/RTL_VER_11 and RTL_VER_12/RTL_VER_13/RTL_VER_15, while
RTL_VER_16 and both RTL_VER_17 packages get rtl8157_up, which already
contains the same clear:

rtl8157_up() {
	...
	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
	...
}

So the copy left in rtl8156_up() now clears PLA_RCR1 bit 3 on exactly the
RTL8156/RTL8156B versions the old guard excluded, on every interface
bring-up.  Should this line have been deleted from rtl8156_up() instead?
PLA_RCR1 bit 3 has no name in the driver (only OUTER_VLAN and INNER_VLAN
are defined for that register), so it is hard to tell what the RX side
does with it on these parts.

>  
>  	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
>  
> @@ -6892,11 +6934,11 @@ static void rtl8156_up(struct r8152 *tp)
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
>  
>  	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
>  
> @@ -6906,10 +6948,19 @@ static void rtl8156_up(struct r8152 *tp)
>  	}
>  
>  	r8153_aldps_en(tp, true);
> -	if (tp->version < RTL_VER_16)
> -		r8153_u2p3en(tp, true);
> +	r8153_u2p3en(tp, true);
>  
> -	if (tp->version < RTL_VER_16 && tp->udev->speed >= USB_SPEED_SUPER)
> +	switch (tp->version) {
> +	case RTL_VER_13:
> +	case RTL_VER_15:
> +		/* Enable Clear_SDR */
> +		ocp_word_set_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(15));
> +		break;
> +	default:
> +		break;
> +	}

[Severity: Low]
This isn't a bug, but the commit message says the goal is to add dedicated
functions "instead of handling per-version differences with inline version
guards", and this adds a new inline per-version distinction for
RTL_VER_13/RTL_VER_15 in the shared path.

The message also says RTL8156B has different up and down sequences from
RTL8156, yet rtl_ops_init() still assigns the shared handlers for the
8156B case:

		ops->init		= r8156b_init;
		ops->enable		= rtl8156b_enable;
		...
		ops->up			= rtl8156_up;
		ops->down		= rtl8156_down;

Was a dedicated rtl8156b_up/rtl8156b_down intended here too, or should the
message only claim the enable path is split for VER_12/13/15?

> +
> +	if (tp->udev->speed >= USB_SPEED_SUPER)
>  		r8153b_u1u2en(tp, true);
>  }
>  

[ ... ]

> @@ -6949,7 +6997,102 @@ static void rtl8156_down(struct r8152 *tp)
>  	 */
>  	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TEREDO_WAKE_BASE, 0x00ff);
>  
> -	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
> +	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_BDC_CR, ALDPS_PROXY_MODE);
> +
> +	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL,
> +			  NOW_IS_OOB | DIS_MCU_CLROOB);
> +
> +	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
> +
> +	rtl_rx_vlan_en(tp, true);
> +	rxdy_gated_en(tp, false);
> +
> +	ocp_dword_set_bits(tp, MCU_TYPE_PLA, PLA_RCR,
> +			   RCR_APM | RCR_AM | RCR_AB);
> +
> +	r8153_aldps_en(tp, true);
> +}
> +
> +static void rtl8157_up(struct r8152 *tp)
> +{
> +	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> +		return;
> +
> +	r8153b_u1u2en(tp, false);
> +	r8153_aldps_en(tp, false);
> +
> +	rxdy_gated_en(tp, true);
> +	r8153_teredo_off(tp);
> +
> +	ocp_dword_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, RCR_ACPT_ALL);
> +
> +	rtl8152_nic_reset(tp);
> +	rtl_reset_bmu(tp);
> +
> +	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
> +
> +	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
> +
> +	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
> +
> +	rtl_rx_vlan_en(tp, tp->netdev->features & NETIF_F_HW_VLAN_CTAG_RX);
> +
> +	rtl8156_change_mtu(tp);
> +
> +	/* share FIFO settings */
> +	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
> +		      0x08);
> +

[Severity: Medium]
The shared rtl8156_up() clears PLA_MCU_SPDWN_EN at this point in the
sequence, unconditionally, including for VER_16/17:

	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
			  PLA_MCU_SPDWN_EN);

rtl8157_up() drops it, and rtl8157_down() drops the matching
ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN)
that rtl8156_down() still performs.  After this patch no code path for
RTL8157/8159 touches PLA_MCU_SPDWN_EN at all - r8157_init() and
r8159_init() never write PLA_MAC_PWR_CTRL3, while r8156_init() and
r8156b_init() do.

If the bit is already set when the interface is brought up (OOB firmware
default, or an older kernel that set it in its down path before unbind),
can the MAC MCU stay armed for clock/power-down while the interface is
running?  Is dropping the arm/disarm pair for VER_16/17 intentional?

> +	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
> +			  RG_PWRDN_EN | ALL_SPEED_OFF);

[Severity: High]
This looks like the second inverted guard.  In the shared rtl8156_up()
the same write was explicitly skipped for VER_16 and later:

	if (tp->version < RTL_VER_16)
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
				  RG_PWRDN_EN | ALL_SPEED_OFF);

rtl8157_up() is installed as ops->up only for RTL_VER_16 and the two
RTL_VER_17 packages, so the statement ended up in the single path the
guard excluded.  Should it be dropped here instead?

For context, git grep USB_SPEED_OPTION shows the register is programmed by
r8156_init() and r8156b_init(), but never by r8157_init() or r8159_init(),
which suggests the 8157/8159 sequence intentionally leaves RG_PWRDN_EN and
ALL_SPEED_OFF alone.

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
> +
> +	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
> +
> +	/* RX FIFO settings for OOB */
> +	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, 64 / 16);
> +	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, 1024 / 16);
> +	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, 4096 / 16);
> +
> +	rtl_disable(tp);
> +	rtl_reset_bmu(tp);
> +
> +	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, 1526);
> +	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, 10 * 1024 / 64);

[ ... ]

> @@ -10071,7 +10214,7 @@ static int rtl_ops_init(struct r8152 *tp)
>  		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
>  		tp->eee_adv2		= MDIO_EEE_2_5GT;
>  		ops->init		= r8156b_init;
> -		ops->enable		= rtl8156_enable;
> +		ops->enable		= rtl8156b_enable;
>  		ops->disable		= rtl8153_disable;
>  		ops->up			= rtl8156_up;
>  		ops->down		= rtl8156_down;
> @@ -10110,10 +10253,10 @@ static int rtl_ops_init(struct r8152 *tp)
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
>  		ops->unload		= rtl8153_unload;
>  		ops->eee_get		= r8153_get_eee;
>  		ops->eee_set		= r8152_set_eee;

[ ... ]

For reference, none of the above changes appear to be adjusted by the later
patches in this series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903072852.58695-1-nic_swsd%40realtek.com
