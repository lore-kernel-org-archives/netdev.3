Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B948F853;
	Sat, 12 Sep 2026 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244399; cv=none; b=iT8gQZn+VN0VoyPqLq6ig1O4NwiejmBpiVYXxCMCQy1Pj2ok1Lak73ZcVuIIjLBYse/c+5R5qNAbUmr5qIKVMbstfhjhLxoI6m3/RSAPkVWCPEJa43DDsfxT9Z4Piu/cOciQMPGQoazwGkRzy7nRWRembUF60uYvaPLDBSiZECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244399; c=relaxed/simple;
	bh=yxm4SQ1hnZzoglclt7fQTPb/ydslXyQJ9FgJaESRypg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CMhKjFaZzCh8q/yPbarL9I2wnF3kX9/VPRjgN9jyuhjJbihLhUJ46j3UOu92WXAweJu2Gjl7IGDueA9C9nRcfVyo9j3AmPyPQMxzYEDY5XU4rTLxYzhMObhd2w/FKXJRpw0bZvb7QoiwaHudoxlDWu4WrldGvEohE86Lwx4MPRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfseLKbg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfseLKbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D471A1F00899;
	Sat, 12 Sep 2026 20:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244397;
	bh=LYwa8sDjoeC4azKo5/ddtMABm0Ruj4IzgEzdF26VlHc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hfseLKbgZxrIaY+211DxXl09t+Bt+SAsEZnol/IunaMom4Dn6BkUFtXSU1e9oIwnd
	 Ubp18aBBPYJTQyjcgBZUCH8yqpfAFz5UL6l0oUUSIzVUojAXep3Jur86cSFKTiv56A
	 zykMZoSE3iQPNokm9WMC2+ykGIuL+M0/K5zAdMeY/ArnymHYMw7iLJNSJzbaEaXEfp
	 7MYV9ZyDfnh7i0XMo23ix1dj9nLjLpCmpHzN9dVHBd7/jBiEhF042eCq2xEM3xugP6
	 liRbXpIejJyV902ScWpbZ7jYv24gozgwTABN1gggiydI0WXyfJjlJ8kf1ArhGgL+Bs
	 CYjSefaRIpwqw==
Subject:
 Re: [PATCH net-next v3 8/8] r8152: support UPS for RTL8157 and RTL8159
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Sat, 12 Sep 2026 20:19:56 +0000
Message-ID: <178924439640.3125.13644220695109747344@kernel.org>
In-Reply-To: <20260908075634.23740-9-nic_swsd@realtek.com>
References: <20260908075634.23740-9-nic_swsd@realtek.com>
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

- [Medium] Incomplete version dispatch: the four new switch statements
  added by this patch enumerate only RTL_VER_16 and RTL_VER_17_QFN68 and…

--

r8152: support UPS for RTL8157 and RTL8159

This adds r8157_ups_en() for the RTL8157/RTL8159 UPS enable sequence,
extends r8156_ups_flags() with per-speed EEE flags and 5G/10G speed
encodings, and switches r8157_init()/r8159_init() over to the new
enable helper.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 2b0972b967385..cc18b1c5a17c3 100644
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

[Severity: Medium]

Should RTL_VER_17_QFN100 be listed here as well?

In rtl_ops_init() the two RTL8159 packages share one identical block:

	case RTL_VER_17_QFN68:
	case RTL_VER_17_QFN100:
		tp->eee_en		= true;
		tp->eee_adv		= MDIO_EEE_100TX | MDIO_EEE_1000T | MDIO_EEE_10GT;
		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
		ops->init		= r8159_init;
		...
		ops->hw_phy_cfg		= r8159_hw_phy_cfg;
		ops->autosuspend_en	= rtl8157_runtime_enable;

So QFN100 advertises the same 100M through 10G EEE capabilities, but with
only RTL_VER_17_QFN68 matched above it takes the default arm and gets the
old UPS_FLAGS_EN_EEE encoding that this patch replaces for this chip
generation.

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

[Severity: Medium]

Same question for the lite_mode suppression: RTL_VER_17_QFN100 is not
listed, so it still gets the bit 5/6 lite_mode field that this hunk treats
as not applicable to this generation.

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

[Severity: Medium]

Does this leave RTL_VER_17_QFN100 without UPS entirely?

rtl_ops_init() assigns ops->autosuspend_en = rtl8157_runtime_enable for
both RTL_VER_17_QFN68 and RTL_VER_17_QFN100, and __rtl_get_pkg_det()
results of 0x18/0x1a select RTL_VER_17_QFN100. On runtime suspend the
chain is:

	rtl8152_runtime_suspend()
	  -> tp->rtl_ops.autosuspend_en(tp, true)
	     == rtl8157_runtime_enable(tp, true)
	        -> switch (tp->version) ... default: break;

so r8157_ups_en() is never reached for that package, while the commit
message says "support UPS for RTL8157 and RTL8159".

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

[Severity: Medium]

Mirror of the above on the resume path.

Note that r8159_init(), shared by both RTL8159 packages, was converted in
this same patch:

	r8157_power_cut_en(tp, false);
	r8157_ups_en(tp, false);

so the QFN100 path does get the new disable call at probe/init time, but
never the enable/disable dispatch during runtime suspend and resume.

There is a QFN68-only quirk elsewhere in r8159_init() ("Enable u2phy
backup restore patch"), so a package-specific restriction is plausible.
Should case RTL_VER_17_QFN100 be added to all four new switches, or should
the commit message be scoped to the QFN68 package with a note on the
hardware difference?

>  		r8157_u2p3en(tp, true);
>  		if (tp->udev->speed >= USB_SPEED_SUPER)
>  			r8153b_u1u2en(tp, true);

[ ... ]

> @@ -9130,7 +9216,7 @@ static void r8159_init(struct r8152 *tp)
>  	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
>  
>  	r8157_power_cut_en(tp, false);
> -	r8156_ups_en(tp, false);
> +	r8157_ups_en(tp, false);
>  	r8153_queue_wake(tp, false);
>  	rtl_runtime_suspend_enable(tp, false);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908075634.23740-1-nic_swsd%40realtek.com
