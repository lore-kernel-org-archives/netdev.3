Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26F404882;
	Mon, 21 Sep 2026 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979444; cv=none; b=q6vOMKRY+66eYPSIYvzCTf/fvKlmUqbqRHaiYhWY0+ITsydnZ9ipfAi4ftwdZpTPzUXMLWMQOb0x52LCo1cRzusfwOU4+cfVwgIc1HboVG57GgJksJZio5tlZcug6owMVgxv/xCyy8tZC4F54OWzOM/RQD8Mnf/+ZReDj6iCSl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979444; c=relaxed/simple;
	bh=02t9yxP+vt0o6sEkW9ydUShKPyF4Jnt7lZClnvNgEc0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sAER1Rj7zzw9fBYR3PZ3x20SZdj8o6twyet+tA5bF34ayA0s6RBLIiRjD8lDYbAc20sY2moRTWJrtPte5BKLi3wlVplLh4Vuckpvw+ip+QceT3xwEj8E5g8c7w0z/Z0dRppK2ivUww5ggyyzFuzDDCWmWJ7CitB+GmmUdW1DMjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvX3HFEw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvX3HFEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8FC1F000FF;
	Mon, 21 Sep 2026 08:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789979437;
	bh=ZDEvm7jnPf4XzAjpcHhR/52rAiNoL6uDnDeDMoBH/Ds=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lvX3HFEwnaJcYN+6hEZ7jH02SKBih26HF/xyV2sdSEOMPVcShi34Hvc1T83QSpasI
	 kT6eoVVx/nlv0fMXFd577fB5ZAu5kf2VNbXMz9z6d6xgTFusnJYBVlNRMgQyqwSK44
	 4K+1PFDoTwLIx9oVXELf2OdSbHwz160X/jh+rC/YifE1vLc04TfP8W72VhkJWyDZR1
	 PzZ0iNm2JzxlsVVdoc5zxtWXjxbXuV+JMZ+zxDzaVawr6zpqKvFWDVYgbttG8/Br5y
	 Fpvjb5i6bgKOy/cXM5YqDvi3wFFW4CeCN5h+XqwqpUhFDhUslN/1tOlgkP3b86zMfe
	 +xXKPoTvuquCg==
Subject:
 Re: [PATCH net-next v4 5/8] r8152: add rtl8157_unload and rtl8157_change_mtu
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Mon, 21 Sep 2026 08:30:36 +0000
Message-ID: <178997943625.2160803.4711623040581335767@kernel.org>
In-Reply-To: <20260917070637.62827-6-nic_swsd@realtek.com>
References: <20260917070637.62827-6-nic_swsd@realtek.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Commit message / Fixes: tag mismatch for a substantive
  hardware-programming correction.

--

r8152: add rtl8157_unload and rtl8157_change_mtu

Adds rtl8157_unload(), which uses r8157_power_cut_en() plus the
Interrupt Mitigation disable that rtl8153_unload() previously gated on
"tp->version >= RTL_VER_16", and rtl8157_change_mtu(), which scales
PLA_MTPS from the configured MTU. Both are wired to RTL8157 and RTL8159
through ops->unload and ops->change_mtu.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index d30031dbf2d38..f44dcb88b5c6a 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -7004,6 +7004,28 @@ static void rtl8156_down(struct r8152 *tp)
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
> +
> +	/* TX share fifo free credit full threshold */
> +	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TXFIFO_CTRL, 512 / 64);
> +	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TXFIFO_FULL,
> +		       ALIGN(max_pkt_size + tp->tx_desc.size, 1024) / 16);
> +}
> +

[ ... ]

> @@ -10151,11 +10173,6 @@ static void rtl8153_unload(struct r8152 *tp)
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

[ ... ]

> @@ -10344,13 +10371,13 @@ static int rtl_ops_init(struct r8152 *tp)
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
>  		tp->rx_buf_sz		= 32 * 1024;
>  		tp->support_2500full	= 1;
>  		tp->support_5000full	= 1;

[Severity: Medium]
The subject and changelog read as purely additive, but the two ops
rewirings here (and the identical pair in the RTL_VER_17_QFN68 and
RTL_VER_17_QFN100 branches further down) change register programming for
hardware that is already supported in released kernels. Would a Fixes:
tag and a note about the user-visible symptom help here, at least
fd3c7d080df5 ("r8152: Add support for the RTL8157 hardware") plus the
RTL8159 support commit?

Two concrete deltas, first the power-cut sequence. rtl8153_unload() used:

	r8153_power_cut_en(tp, false)
	    ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT, PWR_EN | PHASE2_EN);
	    ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);

while rtl8157_unload() now uses:

	r8157_power_cut_en(tp, false)
	    ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT, PWR_EN);
	    ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
	    ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2, BIT(1));

So PHASE2_EN is now left set and USB_MISC_2 BIT(1) is now cleared. These
writes really execute on unbind, since rtl8152_disconnect() calls
rtl_set_unplug() first but rtl_set_unplug() only sets
RTL8152_INACCESSIBLE when tp->udev->state == USB_STATE_NOTATTACHED, and
they also execute on the probe error path. Was the old sequence leaving
the device in a bad state after power-cut or resume?

Second, PLA_MTPS at the default MTU. rtl8156_change_mtu() wrote
MTPS_JUMBO (12 * 1024 / 64 = 192) unconditionally, while
rtl8157_change_mtu() writes max_t(u32, mtu_to_size(1500), 10 * 1024) / 64
= 160 for a 1500 byte MTU. Every RTL8157/RTL8159 user therefore gets a
different TX threshold after this patch, both from
rtl8157_up() -> rtl8157_change_mtu() and from ndo_change_mtu. Is that
intentional for existing setups, and is it something that should be
backported?

Also on the changelog wording:

    and an MTPS scaled from the configured MTU (10K-16K, max_pkt_size /
    64 capped at 0xff) instead of a fixed MTPS_JUMBO/MTPS_DEFAULT.

The replaced callback, rtl8156_change_mtu(), only ever writes MTPS_JUMBO.
MTPS_DEFAULT is written by rtl8156_down(), which these chips no longer
use after the earlier split into per-chip-family functions; rtl8157_down()
already writes 10 * 1024 / 64. Could the description be adjusted so it
matches the code being replaced?

Neither this message nor any later patch in the series changes
rtl8157_unload()/rtl8157_change_mtu(), so the tags and description would
need to be corrected here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917070637.62827-1-nic_swsd%40realtek.com
