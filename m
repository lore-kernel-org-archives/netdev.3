Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160ED576EA8;
	Wed,  9 Sep 2026 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960738; cv=none; b=HQEz8zXFGl4Tzx3trURIn42njeNF9nFLVSafju+zUJfBt6YeiXQXUnhyas4HyjXS7RFt2zIDHS3sgJre3G+BXzVjQuZiAoBZpqKdmgk2aIOHTHkVQUE5RK4zJnvt5EaIgcKpTGO8/R+weWE/18JOu5SLCrJW4lgn2xBftpuPr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960738; c=relaxed/simple;
	bh=BC47foRZY6VTr+75+/SbIrh5vIluzXE73FHEEo1q0L0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dFUAxPzxbSLHBXbiNV4HCqk9R6su7lN/+IusvM8CJzr8P9C7GNH/HBqiuLm99ZCCI08RiIP4Mt7QEv740HfdmlealdbwMLFR23tvqA8LTD0u6MjEWYFdydftHuytAyMs3MPqba2x2SIX1UszCBYcV44+RtCbzwAzPrsAc1fjWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJx6CNvP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJx6CNvP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D021F00A3D;
	Wed,  9 Sep 2026 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960736;
	bh=gUBKyfxk2lkWO/qO3dcfUJoesjxDlIFD7mggsplyymQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HJx6CNvPp5wVdZNSpjMaAq5b6cRWx7W9VklS4Bq9ipgUf01tm3/3872AOIJH7HEwN
	 55AWu0GzQiUPSK9Rgs4jCgn9iHLxo+bTgKoaPgKkN/eJ6OJfjwtKL3NgZKcZVyJZvJ
	 c6tsl53fUlEibaplgx6RgFy3gYmTpfcSwFLdPQDRTc11wapdwPboutXVQai/UwmCyI
	 JtEA9cPmgxfIH/1w0WlVTpjz7LOqOoyRjKjo9KCNbg+ZlKUvun+RiFSHiHpgNSv26w
	 Wqjb5/Utyt0czzMLhJVltO+PufrJ/O8Nylf9OBGlrD9uhRnGPzNcAEkHskhFTlxDGE
	 i3Y/NOIkB26OQ==
Subject:
 Re: [PATCH net-next v2 8/8] r8152: support UPS for RTL8157 and RTL8159
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Wed, 09 Sep 2026 13:32:14 +0000
Message-ID: <178896073496.219967.4768075323923398433@kernel.org>
In-Reply-To: <20260903072852.58695-9-nic_swsd@realtek.com>
References: <20260903072852.58695-9-nic_swsd@realtek.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 2 · Low: 0

- [High] The three new version switches added by this patch (in
  r8157_ups_en()'s two call sites inside rtl8157_runtime_enable(), and…
- [Medium] In the resume (!enable) path of rtl8157_runtime_enable(),
  r8157_ups_en(tp, false) is invoked only after r8153_queue_wake(tp,…
- [Medium] r8157_ups_en(tp, false) detects PCUT_STATUS (a UPS power cut
  occurred, so the PHY/GPHY domain was powered down and is re-loading)…

--

r8152: support UPS for RTL8157 and RTL8159

This adds r8157_ups_en() for the RTL8157/RTL8159 UPS enable sequence and
extends r8156_ups_flags() with per-speed EEE flags and 5G/10G speed
encodings. rtl8157_runtime_enable() now arms and disarms UPS around
runtime suspend, and the two init paths switch from r8156_ups_en() to the
new helper.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 2b0972b96738..cc18b1c5a17c 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -4178,8 +4184,27 @@ static void r8156_ups_flags(struct r8152 *tp)
>  	if (tp->ups_info.aldps)
>  		ups_flags |= UPS_FLAGS_EN_ALDPS;
>  
> -	if (tp->ups_info.eee)
> -		ups_flags |= UPS_FLAGS_EN_EEE;
> +	if (tp->ups_info.eee) {
> +		switch (tp->version) {
> +		case RTL_VER_17_QFN68:
> +			if (tp->eee_adv & MDIO_EEE_10GT)
> +				ups_flags |= UPS_FLAGS_EN_10G_EEE;
> +			fallthrough;
> +		case RTL_VER_16:
> +			if (tp->eee_adv & MDIO_EEE_100TX)
> +				ups_flags |= UPS_FLAGS_EN_100M_EEE;
> +			if (tp->eee_adv & MDIO_EEE_1000T)
> +				ups_flags |= UPS_FLAGS_EN_1000M_EEE;
> +			if (tp->eee_adv2 & MDIO_EEE_2_5GT)
> +				ups_flags |= UPS_FLAGS_EN_2500M_EEE;
> +			if (tp->eee_adv2 & MDIO_EEE_5GT)
> +				ups_flags |= UPS_FLAGS_EN_5000M_EEE;
> +			break;
> +		default:
> +			ups_flags |= UPS_FLAGS_EN_EEE;
> +			break;
> +		}
> +	}
>  
>  	if (tp->ups_info.flow_control)
>  		ups_flags |= UPS_FLAGS_EN_FLOW_CTR;

[ ... ]

> @@ -4230,20 +4255,33 @@ static void r8156_ups_flags(struct r8152 *tp)
>  	case NWAY_2500M_FULL:
>  		ups_flags |= ups_flags_speed(9);
>  		break;
> +	case NWAY_5000M_FULL:
> +		ups_flags |= ups_flags_speed(10);
> +		break;
> +	case NWAY_10000M_FULL:
> +		ups_flags |= ups_flags_speed(11);
> +		break;
>  	default:
>  		break;
>  	}
>  
> -	switch (tp->ups_info.lite_mode) {
> -	case 1:
> -		ups_flags |= 0 << 5;
> -		break;
> -	case 2:
> -		ups_flags |= 2 << 5;
> +	switch (tp->version) {
> +	case RTL_VER_16:
> +	case RTL_VER_17_QFN68:
>  		break;
> -	case 0:
>  	default:
> -		ups_flags |= 1 << 5;
> +		switch (tp->ups_info.lite_mode) {
> +		case 1:
> +			ups_flags |= 0 << 5;
> +			break;
> +		case 2:
> +			ups_flags |= 2 << 5;
> +			break;
> +		case 0:
> +		default:
> +			ups_flags |= 1 << 5;
> +			break;
> +		}
>  		break;
>  	}
>  

[ ... ]

> @@ -4415,6 +4453,35 @@ static void r8156_ups_en(struct r8152 *tp, bool enable)
>  	}
>  }
>  
> +static void r8157_ups_en(struct r8152 *tp, bool enable)
> +{
> +	if (enable) {
> +		r8156_ups_flags(tp);
> +
> +		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
> +				  UPS_EN | USP_PREWAKE | PHASE2_EN);
> +
> +		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_MISC_2,
> +				  UPS_FORCE_PWR_DOWN);
> +	} else {
> +		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
> +				  UPS_EN | USP_PREWAKE);
> +
> +		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2,
> +				  UPS_FORCE_PWR_DOWN);
> +
> +		if (ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0) & PCUT_STATUS) {
> +			/* clear USB fw_ver_reg */
> +			ocp_write_byte(tp, MCU_TYPE_USB, USB_FW_USE_VER, 0);
> +
> +			tp->rtl_ops.hw_phy_cfg(tp);
> +
> +			rtl8152_set_speed(tp, tp->autoneg, tp->speed,
> +					  tp->duplex, tp->advertising);
> +		}

[Severity: Medium]
Should this PCUT_STATUS branch wait for autoload to complete before
touching the PHY?  The two peer helpers in the same driver guard the
identical branch:

drivers/net/usb/r8152.c:r8153b_ups_en() {
	...
	if (ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0) & PCUT_STATUS) {
		if (wait_autoload_done(tp))
			return;

		tp->rtl_ops.hw_phy_cfg(tp);
	...
}

r8153c_ups_en() does the same.  r8157_ups_en() was copied from
r8156_ups_en(), which also lacks the wait, but for this family that branch
was previously unreachable: r8156_ups_en()/r8157_ups_en() were only ever
called with enable=false from the init paths, always after
r8157_power_cut_en(tp, false) had already cleared PCUT_STATUS.  This patch
adds the first call with enable=true in rtl8157_runtime_enable(), so the
branch becomes live on the first runtime resume that follows a real power
cut.

For RTL8159 there is a second wait that looks relevant:

drivers/net/usb/r8152.c:r8159_wait_backup_restore() {
	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
	if (!(ocp_data & PCUT_STATUS))
		return 0;

	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL),
			       ocp_data & BACKUP_RESTRORE, 200, 20000, false);
}

That poll is itself predicated on PCUT_STATUS, and r8159_init() treats a
timeout there as fatal ("init failed, backup-restore timed out").  Can
hw_phy_cfg() run here while the GPHY backup-restore engine is still
running, given hw_phy_cfg() itself sets GPHY_PATCH_DONE | BACKUP_RESTRORE?

> +	}
> +}
> +
>  static void r8153_power_cut_en(struct r8152 *tp, bool enable)
>  {
>  	if (enable)

[ ... ]

> @@ -4573,9 +4640,28 @@ static void rtl8157_runtime_enable(struct r8152 *tp, bool enable)
>  		r8153b_u1u2en(tp, false);
>  		r8157_u2p3en(tp, false);
>  		rtl_runtime_suspend_enable(tp, true);
> +
> +		switch (tp->version) {
> +		case RTL_VER_16:
> +		case RTL_VER_17_QFN68:
> +			r8157_ups_en(tp, true);
> +			break;
> +		default:
> +			break;
> +		}

[Severity: High]
Is the omission of RTL_VER_17_QFN100 here intentional?

RTL_VER_17_QFN68 and RTL_VER_17_QFN100 are the two package variants
selected by __rtl_get_pkg_det() (0x1e/0x1c versus 0x18/0x1a), and
rtl_ops_init() gives them the same ops and the same EEE capabilities:

drivers/net/usb/r8152.c:rtl_ops_init() {
	case RTL_VER_17_QFN68:
	case RTL_VER_17_QFN100:
		tp->eee_en		= true;
		tp->eee_adv		= MDIO_EEE_100TX | MDIO_EEE_1000T | MDIO_EEE_10GT;
		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
		ops->init		= r8159_init;
	...
		ops->autosuspend_en	= rtl8157_runtime_enable;
}

Both also map to FIRMWARE_8159_1.  With the switch above, a QFN100 device
takes the default arm on both the suspend and the resume side, so
r8157_ups_en() is never called for it: UPS_EN | USP_PREWAKE | PHASE2_EN and
UPS_FORCE_PWR_DOWN are never programmed, USB_UPS_FLAGS is never written,
and the PCUT_STATUS recovery is never run on resume.  Does the commit
subject "support UPS for RTL8157 and RTL8159" then only cover one of the two
RTL8159 packages?

The same two-version lists appear in r8156_ups_flags(), both in the new EEE
switch and in the new lite-mode switch:

	switch (tp->version) {
	case RTL_VER_16:
	case RTL_VER_17_QFN68:
		break;
	default:
		switch (tp->ups_info.lite_mode) {

If RTL_VER_17_QFN100 is added to rtl8157_runtime_enable() later without
also updating r8156_ups_flags(), it would fall into the default arms and be
programmed with the legacy UPS_FLAGS_EN_EEE bit plus the lite-mode bits,
which is the encoding this patch declares wrong for this family.  Every
other chip-family switch in this driver lists all three versions together
(rtl_disable(), r8153_set_rx_early_timeout(), r8153_set_rx_early_size(),
rtl_reset_bmu(), r8156_fc_parameter() and the max_mtu switch), so the
two-version lists here stand out.

>  	} else {
>  		r8153_queue_wake(tp, false);
>  		rtl_runtime_suspend_enable(tp, false);
> +
> +		switch (tp->version) {
> +		case RTL_VER_16:
> +		case RTL_VER_17_QFN68:
> +			r8157_ups_en(tp, false);
> +			break;
> +		default:
> +			break;
> +		}
> +

[Severity: Medium]
Should UPS be exited before the PLA wake and WOL registers are
reprogrammed?  The other two UPS-capable chips do it in the opposite
order:

drivers/net/usb/r8152.c:rtl8153b_runtime_enable() {
	} else {
		r8153b_ups_en(tp, false);
		r8153_queue_wake(tp, false);
		rtl_runtime_suspend_enable(tp, false);
	...
}

rtl8153c_runtime_enable() begins its resume path with
r8153c_ups_en(tp, false) as well.

As written, r8153_queue_wake(tp, false) and
rtl_runtime_suspend_enable(tp, false) write PLA_INDICATE_FALG,
PLA_SUSPEND_FLAG, PLA_EXTRA_STATUS and the CRWECR-protected
PLA_CONFIG34/WOL registers while USB_POWER_CUT UPS_EN | USP_PREWAKE and
USB_MISC_2 UPS_FORCE_PWR_DOWN are still set.

Can those PLA writes be dropped or overwritten while the part is still held
in UPS force-power-down?  If they are, the device stays armed with
__rtl_set_wol(WAKE_ANY) and LINK_OFF_WAKE_EN while tp->saved_wolopts makes
the driver believe the user's WOL setting was restored.

A related effect of this order: when PCUT_STATUS is set, the hw_phy_cfg()
and rtl8152_set_speed() calls inside r8157_ups_en() now run after the
wake/WOL restore rather than before it, which is the reverse of what the
8153b/8153c paths do.

>  		r8157_u2p3en(tp, true);
>  		if (tp->udev->speed >= USB_SPEED_SUPER)
>  			r8153b_u1u2en(tp, true);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903072852.58695-1-nic_swsd%40realtek.com
