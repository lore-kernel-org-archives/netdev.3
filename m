Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D744D56B85D;
	Wed,  9 Sep 2026 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960734; cv=none; b=jy6YjWqdIZk0SUusIbHFNf36cuEIzioMcOqBlwCsSvXC1dB7+4EcTWy0zW5hALmj4Z7GGssviesIigvsVK0rod7Vu2GAmVMhyPPl7HRNBIvdlS6KJbRIMGJG+Q86FujDXbRXaeO0p9iveMv2rBTPz65QkqL3+xTdHYE5PWNp3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960734; c=relaxed/simple;
	bh=Z9lpN/RLTor+DE3GV/3xO6X2UZspdFZpDPWmTefnRo4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=imvk2pb1CQnajY8/12JEZFJEIWVrlV5Ey0i919M+Oq/ID6t8m8gqCvcqZyMQejO3cck2jzTnELbkO+dlNkYuOIdvAZ+sFj7ZmoI+NlO0i8XR2WfFaJ5EmfoQ1BUJuIc24sm0WrhjjxfOjgnVHtu2FL5r9z46vXUX6WL2MENeLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LketqvuY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LketqvuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DB51F00A3D;
	Wed,  9 Sep 2026 13:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960732;
	bh=ZBuyp+Y0a1GTIYw2kfts6331CoEXOzlFqfoHTYG22gs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LketqvuYWT56b50AtieXuIMZZa7h2XxnF2fg7NXMeN90QUJIHds6CeQ41ikAiOUPg
	 KkAKVb1Ip4WtsOeJeWiH8D1BgB13FDNkPGRqiOItzUJMdi79okVnpl2QCTLWDB1LAp
	 tE4ihyHHV84lLwuIZlwbJPwABIsqka1hSXcagS+pDDTmvHZ+IcojQV/gOC9tdNaGgP
	 c/I+2aT9FtsNsSMLh0S3BSNG274qB2DEgiiO2Z8Snjix0X5X1BHqIfkBWSaaeTyVMi
	 UmUGXqyaGY0anHmbmIpyLSAy6zvb5Qp5wAA5GtDwAw8Uvfj4PV3cmDEe3Zlq4VS0Lh
	 TWsb+WOy6oGJw==
Subject: Re: [PATCH net-next v2 5/8] r8152: support rtl8157_unload and
 rtl8157_change_mtu
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Wed, 09 Sep 2026 13:32:11 +0000
Message-ID: <178896073134.219967.18178917542258941230@kernel.org>
In-Reply-To: <20260903072852.58695-6-nic_swsd@realtek.com>
References: <20260903072852.58695-6-nic_swsd@realtek.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The commit is presented as adding new callback "support" for
  RTL8157/RTL8159, but it silently changes runtime register programming…

--

r8152: support rtl8157_unload and rtl8157_change_mtu

This adds rtl8157_unload(), which uses r8157_power_cut_en() and disables
interrupt mitigation, and rtl8157_change_mtu(), which scales PLA_MTPS with
the configured MTU.  Both are wired up for RTL_VER_16 and
RTL_VER_17_QFN68/QFN100 in rtl_ops_init(), replacing rtl8153_unload and
rtl8156_change_mtu.

(no Link: tags in the commit header)

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 679aead731f7..06fad895fce0 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -7024,6 +7024,28 @@ static void rtl8156_down(struct r8152 *tp)
>  	r8153_aldps_en(tp, true);
>  }
>  
> +static void rtl8157_change_mtu(struct r8152 *tp)
> +{
> +	u32 max_pkt_size = mtu_to_size(tp->netdev->mtu);
> +	u32 ocp_data;
> +
> +	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, max_pkt_size);
> +
> +	/* Use at least 10K for MTPS */
> +	ocp_data = max_t(u32, max_pkt_size, 10 * 1024) / 64;
> +
> +	/* 16 * 1024 / 64 = 0x100, so the max is 0xff for 8 bits data */
> +	ocp_data = min_t(u32, ocp_data, 0xff);
> +
> +	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, ocp_data);
> +	r8156_fc_parameter(tp);

[ ... ]

> @@ -10189,6 +10206,16 @@ static void rtl8153b_unload(struct r8152 *tp)
>  	r8153b_power_cut_en(tp, false);
>  }
>  
> +static void rtl8157_unload(struct r8152 *tp)
> +{
> +	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> +		return;
> +
> +	r8157_power_cut_en(tp, false);
> +	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
> +			  BIT(0) | BIT(1) | BIT(2) | BIT(7));
> +}
> +

[ ... ]

> @@ -10367,13 +10394,13 @@ static int rtl_ops_init(struct r8152 *tp)
>  		ops->disable		= rtl8153_disable;
>  		ops->up			= rtl8157_up;
>  		ops->down		= rtl8157_down;
> -		ops->unload		= rtl8153_unload;
> +		ops->unload		= rtl8157_unload;
>  		ops->eee_get		= r8153_get_eee;
>  		ops->eee_set		= r8152_set_eee;
>  		ops->in_nway		= rtl8153_in_nway;
>  		ops->hw_phy_cfg		= r8157_hw_phy_cfg;
>  		ops->autosuspend_en	= rtl8157_runtime_enable;
> -		ops->change_mtu		= rtl8156_change_mtu;
> +		ops->change_mtu		= rtl8157_change_mtu;

[Severity: Medium]

The subject and changelog describe this as adding "support", but these two
ops assignments change register programming for hardware that released
kernels already drive.  RTL8157 (RTL_VER_16) was enabled by fd3c7d080df5
("r8152: Add support for the RTL8157 hardware") and RTL8159 (RTL_VER_17) by
ad2a55b63b41 ("r8152: Add support for the RTL8159 chip"), and the baseline
already assigns rtl8153_unload / rtl8156_change_mtu for both.

For the unload path, the old and new helpers are not equivalent:

	r8153_power_cut_en(tp, false):
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
				  PWR_EN | PHASE2_EN);
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);

	r8157_power_cut_en(tp, false):
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT, PWR_EN);
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2, BIT(1));

So PHASE2_EN is now left set and USB_MISC_2 BIT(1) is now cleared on these
chips.  This runs both from the probe error path and from
rtl8152_disconnect() via tp->rtl_ops.unload(), so the state left on the
chip after unplug or module removal differs from released kernels.  Given
that r8157_init() and r8159_init() already use r8157_power_cut_en() for
these versions, was the earlier rtl8153_unload assignment simply wrong?
If so, should this carry a Fixes: tag against fd3c7d080df5 and
ad2a55b63b41, and name the observable misbehaviour (power cut, suspend or
resume, WOL) that it corrects?

The change_mtu switch has the same question.  rtl8156_change_mtu() writes a
fixed PLA_MTPS of MTPS_JUMBO (12 * 1024 / 64), while rtl8157_change_mtu()
writes max(mtu_to_size(mtu), 10K) / 64 clamped to 0xff.  netdev->max_mtu
for RTL_VER_16 and RTL_VER_17_* is size_to_mtu(16 * 1024), so on a released
kernel a user can already configure a frame size above the fixed 12K MTPS
threshold through rtl8152_change_mtu() -> tp->rtl_ops.change_mtu().  Was
that mismatch causing a visible TX problem, and can the changelog say what
it was instead of only "unlike rtl8156_change_mtu which uses a fixed MTPS"?

As submitted, it is hard for a stable backporter to tell whether this is a
fix for shipping RTL8157/RTL8159 adapters or a cleanup with no user impact.
The rest of the series does not add the missing rationale or a Fixes: tag
either.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903072852.58695-1-nic_swsd%40realtek.com
