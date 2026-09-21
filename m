Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7469444F555;
	Mon, 21 Sep 2026 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979445; cv=none; b=HvvqXBiwvgx7ts01ahcbPBe/ZhgQA/Onov2aVBKugoJHV8el60SNK4SCvZFGjbLjSZar9bFdv5St548Trq0zMIpdaW0q9KjmmX8urjLKFR+zmbzEaDCiCmyGOfy1zNuPBVMkEGaN3adn3zu9fqYc6yzmuvaquLkeV9daP04pj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979445; c=relaxed/simple;
	bh=oMT4g92g74uguO1jSWY22y7grWgisiZbKlHy/oZ9Ujc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sK8gavbXRd1C/cc3rXmaPPmf/QjZQxs2Gv+eK17crnz8/LY73k8ji7p2VBea1IkHponk9UC2LNA/HXkvcqj5id+7GDmaVUCYoH+Rl7UWIU9lXNJmsPTu8p9FV3vXymTxDi7ehJBtefheoxmQUakEBI+MKh6iHdsWE+bvYkdrqYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YErxm2rt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YErxm2rt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783D51F0089A;
	Mon, 21 Sep 2026 08:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789979441;
	bh=C67ag6ScrGPUa35JtHX67lGNTuX6cVQ2t5yu4I3BJq0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YErxm2rtAeVtQJ1j51qayp/GhMUeKePdebyvT0M5+QAA62bxSPTn+8p/pXWkcaV84
	 RouTXwsmAHV242rNwgiCejOeQIHxfLRiCG2ebcae7E5Kq4kUt4n0c8fAooSfBQDTgu
	 EHeH5yh39RhOxgG3cEnmdavhNbDnh9U8c9Ivcf0BNC/Re3zji0MO8ut/kWxWztiq3S
	 cRZuZ5Ky2zaJnPc14D3ezKJiRimOXWdFbMJDBbc4xXGh2iBllrOZj0/+XfdC+PTdF+
	 rvJdTWP5m6f6YjApBH6HHPqnRvHIbCFSGaqmasGRATh7vpgEAZ0unfHvLY7t/gASqf
	 2DvXtKPWl450g==
Subject:
 Re: [PATCH net-next v4 8/8] r8152: enable UPS for RTL8157 and RTL8159 QFN68
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Mon, 21 Sep 2026 08:30:40 +0000
Message-ID: <178997944003.2160803.12830836722624033640@kernel.org>
In-Reply-To: <20260917070637.62827-9-nic_swsd@realtek.com>
References: <20260917070637.62827-9-nic_swsd@realtek.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] r8157_ups_en()'s UPS-exit (disable) path in
  drivers/net/usb/r8152.c starts reprogramming the chip as soon as it…
- [Medium] In rtl8157_runtime_enable()'s disable (resume) branch the new
  UPS exit is sequenced last instead of first: line 4722 calls…

--

r8152: enable UPS for RTL8157 and RTL8159 QFN68

This adds r8157_ups_en() and calls it from rtl8157_runtime_enable() for
RTL_VER_16 and RTL_VER_17_QFN68, so UPS is now toggled across runtime
suspend/resume for those chips.  It also extends r8156_ups_flags() with
per-speed EEE flags and two new ups_flags_speed() entries.

Two questions below about the new UPS exit path.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 05b2b79ab3e31..ebe9cc9322b3c 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -4484,6 +4522,35 @@ static void r8156_ups_en(struct r8152 *tp, bool enable)
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
> +	}
> +}

[Severity: High]
Should this PCUT_STATUS branch wait for autoload to complete before
reprogramming the PHY?

The two UPS helpers that are actually reached from a runtime resume after a
power cut, r8153b_ups_en() and r8153c_ups_en(), gate the same sequence on
wait_autoload_done():

	if (ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0) & PCUT_STATUS) {
		if (wait_autoload_done(tp))
			return;

		tp->rtl_ops.hw_phy_cfg(tp);

		rtl8152_set_speed(tp, tp->autoneg, tp->speed,
				  tp->duplex, tp->advertising);
	}

r8156_ups_en(), from which the new helper was copied, has no such wait, but
its branch appears to be dead: both callers (r8156_init() and r8156b_init())
run r8153b_power_cut_en(tp, false) first, which clears PCUT_STATUS.  With
this patch the unguarded branch becomes live via

  rtl8152_runtime_resume() -> tp->rtl_ops.autosuspend_en(tp, false)
    -> rtl8157_runtime_enable(tp, false) -> r8157_ups_en(tp, false)

and PCUT_STATUS is exactly the expected state there, because the suspend side
just ran r8157_ups_en(tp, true).  Can hw_phy_cfg() and the following link
renegotiation then run while the chip is still reloading its post-power-cut
configuration?

wait_autoload_done() also returns -ENODEV when RTL8152_INACCESSIBLE is set,
so the peer helpers bail out on a disconnect during resume.  Without that
check, does a disconnect here run the whole hw_phy_cfg() sequence and then
the BMCR_RESET poll in rtl8152_set_speed(), which can spin 50 * msleep(20)
on failing register reads?

For RTL_VER_17_QFN68 there is a second handshake that this path skips.
r8159_init() treats a missing backup-restore as fatal whenever PCUT_STATUS is
set:

	if (r8159_wait_backup_restore(tp)) {
		rtl_set_inaccessible(tp);
		dev_err(&tp->intf->dev,
			"init failed, backup-restore timed out\n");
		return;
	}

r8159_wait_backup_restore() polls USB_GPHY_CTRL for BACKUP_RESTRORE only when
PCUT_STATUS is set.  On the new runtime resume path, r8159_hw_phy_cfg() only
calls r8156b_wait_loading_flash() and then clears PCUT_STATUS before starting
firmware/PHY programming, so nothing waits for BACKUP_RESTRORE.  Is that
handshake needed here too?

>  static void r8153_power_cut_en(struct r8152 *tp, bool enable)
>  {
>  	if (enable)

[ ... ]

> @@ -4642,9 +4709,28 @@ static void rtl8157_runtime_enable(struct r8152 *tp, bool enable)
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
Is the ordering here intentional?  In the resume branch the UPS exit runs
after the PLA writes, while the other UPS-capable variants exit UPS first.

rtl8153b_runtime_enable():

	} else {
		r8153b_ups_en(tp, false);
		r8153_queue_wake(tp, false);
		rtl_runtime_suspend_enable(tp, false);

rtl8153c_runtime_enable() has the same order with r8153c_ups_en(tp, false)
first.

Here, r8153_queue_wake(tp, false) and rtl_runtime_suspend_enable(tp, false)
touch PLA registers (PLA_INDICATE_FALG/UPCOMING_RUNTIME_D3, PLA_SUSPEND_FLAG,
PLA_EXTRA_STATUS, and the CRWECR-gated PLA_CONFIG34/LINK_OFF_WAKE_EN plus
__rtl_set_wol(tp->saved_wolopts)) while UPS_EN | USP_PREWAKE and
UPS_FORCE_PWR_DOWN are still set, and r8157_ups_en(tp, false) only clears
those bits afterwards.

Since r8153b_ups_en()/r8153c_ups_en() poll PLA_BOOT_CTRL for AUTOLOAD_DONE
right after clearing the same two bits, the PLA block seems to still be
reloading its defaults at that point.  Can the WOL settings restored from
tp->saved_wolopts and the cleared UPCOMING_RUNTIME_D3 flag be overwritten by
that reload, leaving the device unable to wake or with link-off-wake still
armed?  The new helper has no AUTOLOAD_DONE gate either, so nothing in this
resume sequence waits for the reload.

>  		r8157_u2p3en(tp, true);
>  		if (tp->udev->speed >= USB_SPEED_SUPER)
>  			r8153b_u1u2en(tp, true);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917070637.62827-1-nic_swsd%40realtek.com
