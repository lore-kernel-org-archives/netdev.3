Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846747CA8A;
	Sat, 12 Sep 2026 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244397; cv=none; b=cU9ktqB8f1QsFa7S5sr3BPY26ZTcEdeOE7Xozh367duSlK5uSbXV8gUUxURfxj+MpjFMVf3xzP6bCXMr2TEM2uH3H5Z95AlvDNo6Zwh0+F17k+k7syWf6iadRUhn5Ai88b/syvcE7Bb38ri9ubdfF+lutIne9+B3v6hjwD3eD5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244397; c=relaxed/simple;
	bh=5sRN1uBF6qno0lYFbNdS+qZSi0JADW3K1YYhfn7ju7s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SowFQfMn81STaPlWyLSPow3iuOUvgKafCDkzDVBGC3d16LS+smPw4McwZ5zFk29jmWO5RbbccCPnQrAqL4FGo1Qy9DpcFacVoa8TMkjI2lb98gDwPHR4OlQEQMVaifx4WY3CUI3Tk6aGQnIIB6vMfiqlvuT4ZVC1d5v4F7/JdrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNfgACtw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNfgACtw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4985E1F0089A;
	Sat, 12 Sep 2026 20:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244393;
	bh=did5sMvRbCjRf762XvuEt9OtppmMvjEsOSehve8QgzY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CNfgACtwsydOfCLoLpHXO4JXvEYsY3P+5sE/heXh8mQb+n+jenuPXURneuyboSSsQ
	 tri3yIEtKo4vAS6Og96YcninpHpkHDPnp7HPBetqonGAC2J0c8/MQNxdzbgFt62EsR
	 z42Xr36JMlZogYfT92wRLf9anvjrfDhBQ+Vbxj7nookVcI21cUhqmYo8S4JDfLCMKq
	 wMN0yQT2peI2xOBejM3IclpFnHtBLRcNHVMKni933JOPdrHKlduqtcTFfi3TaWB0Yz
	 oLbeAUuaFdD0xowooU4paXekX10wObQt+UncaS/BraPaRcRBlok1JqzMJruZA/SWGP
	 /NLmyjTkSkF3Q==
Subject: Re: [PATCH net-next v3 5/8] r8152: support rtl8157_unload and
 rtl8157_change_mtu
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Sat, 12 Sep 2026 20:19:52 +0000
Message-ID: <178924439287.3125.1065367731882815038@kernel.org>
In-Reply-To: <20260908075634.23740-6-nic_swsd@realtek.com>
References: <20260908075634.23740-6-nic_swsd@realtek.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Commit message understates the impact of the change and carries
  no Fixes: tag, even though it silently alters the register programming…

--

r8152: support rtl8157_unload and rtl8157_change_mtu

This adds rtl8157_unload() and rtl8157_change_mtu() and wires them into
the RTL_VER_16 (RTL8157) and RTL_VER_17 (RTL8159) op tables, replacing
rtl8153_unload() and rtl8156_change_mtu().  The interrupt mitigation clear
of USB register 0xcf04 is moved out of rtl8153_unload() into the new
callback.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 679aead731f73..06fad895fce09 100644
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

> @@ -10174,11 +10196,6 @@ static void rtl8153_unload(struct r8152 *tp)
>  		return;
>  
>  	r8153_power_cut_en(tp, false);
> -
> -	if (tp->version >= RTL_VER_16) {
> -		/* Disable Interrupt Mitigation */
> -		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04, BIT(0) | BIT(1) | BIT(2) | BIT(7));
> -	}
>  }

[ ... ]

> +static void rtl8157_unload(struct r8152 *tp)
> +{
> +	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> +		return;
> +
> +	r8157_power_cut_en(tp, false);
> +	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
> +			  BIT(0) | BIT(1) | BIT(2) | BIT(7));
> +}

[Severity: Low]
Could the changelog say what misbehaves today on these chips, and carry
Fixes: tags?  RTL_VER_16 and RTL_VER_17 are already supported in-tree
(added by fd3c7d080df531 and ad2a55b63b41af), and both assigned
ops->unload = rtl8153_unload and ops->change_mtu = rtl8156_change_mtu, so
this changes the register programming of shipped hardware rather than
enabling something new.

The commit message says the dedicated unload is needed "to disable
interrupt mitigation", but rtl8153_unload() already did that for
tp->version >= RTL_VER_16:

	if (tp->version >= RTL_VER_16) {
		/* Disable Interrupt Mitigation */
		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04, BIT(0) | BIT(1) | BIT(2) | BIT(7));
	}

so that part is only relocated.  The behaviour that actually changes is the
power cut disable sequence:

r8153_power_cut_en(tp, false):
	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT, PWR_EN | PHASE2_EN);
	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);

r8157_power_cut_en(tp, false):
	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT, PWR_EN);
	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2, BIT(1));

PHASE2_EN is now left set on the unload/disconnect path for these chips.
Is that intentional, and is there an observable symptom with the old
sequence?

Similarly, rtl8157_change_mtu() replaces the fixed MTPS_JUMBO (12 * 1024 /
64 = 0xc0) that rtl8156_change_mtu() programmed with an MTU derived value:
at the default 1500 byte MTU, max_t(u32, mtu_to_size(1500), 10 * 1024) / 64
gives 0xa0, and it saturates at 0xff for a 16K MTU.  Both paths are live at
runtime, via rtl8157_up() on every bring-up and via rtl8152_change_mtu() ->
tp->rtl_ops.change_mtu() on every MTU change.  What does the old MTPS value
break on these chips?

As written it is hard to tell whether this is net-next tuning or a fix for a
user visible defect on released kernels, and there is nothing for stable
backports to key on.  Note that this wording is unchanged at the end of the
series, so no later patch adds the missing justification.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908075634.23740-1-nic_swsd%40realtek.com
