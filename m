Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F89046F4A1;
	Mon, 12 Oct 2026 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795975; cv=none; b=AphnxNMV6t0xwwT0h8IqrGoviwwN//8aubnL8BbawhafSYNF/Zzbw1MyWcrO+juhpEfeh2+G9JvH3kqW+j5xe/uPT3pDIFfD0rapXuuKsFNpwM7HSYx6+RKcVzyI0Ix6m0RBFTIRlok1ZzCEJm5uCFS2bm+/31ENmYKSuVAhc5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795975; c=relaxed/simple;
	bh=yFMleiRj8EWSMqMuI/Jf3DQtGTwXImNDctQOCoD7VlU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHfWi+jVPhHb9DcMLXB0Pw1RQsumDze7TTS4vmn71Hq+/MuN3/rf0WYlgv+llVg3zEBS+EUtHogrwGBSZfXnLPe9W0wB3mfnbLWRI5Z6tjvYULnl+rHsW/tH4ZcMsSfNvMbKZkCmRID6FH+9NOzZcLdXGnJCZ35SkMPrvbPWiEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyBe2aqR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyBe2aqR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C2E1F0089C;
	Mon, 12 Oct 2026 09:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795974;
	bh=iDXd7gy1//A5BuShbRwPnWl+jKK4HTCa7pXec1remVs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XyBe2aqRv3lmOrXhVBHGr+/UkZmBiSBGl6a2zRjhBTdzrtd9mpRUIYfbXdOh2JnCw
	 Y0dIVl5ZdWCt6ww9wOsPWgTJLECBj8GuRjLrA3pyeE9rnQe8c3mZx9r0j/BAtgSAuO
	 f0u9L0HQS2D9R6XeRtsVW/CiooCYPq07XyW1Wjk8aUiajEM/8A8uOLIQggwdKVZTTB
	 6SiXTBR0NcHzTIdb8U+pDDL3II2yDkJxAO3hY6lJxsXTdA6jYuonC2sX3sFeWa8+aH
	 NDmzwSj6yl8KUaBp11Pc/jtE2O8ijhsWmxzVrKrGqQEOdY4E74Zn5tmEG/8tLdD3dY
	 MrFeuADtpbPWA==
Subject: Re: [PATCH net-next v6 09/10] r8152: extract rtl_fc_pause_pkt_en()
 and apply it to RTL8156/8157/8159
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch,
 mail@birger-koblitz.de
Date: Mon, 12 Oct 2026 09:06:13 +0000
Message-ID: <179179597336.434549.14331980135791229827@kernel.org>
In-Reply-To: <20261008081556.47901-10-nic_swsd@realtek.com>
References: <20261008081556.47901-10-nic_swsd@realtek.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] rtl_fc_pause_pkt_en() also takes the 'Unknown link speed' else
  branch when the link is down.

--

r8152: extract rtl_fc_pause_pkt_en() and apply it to RTL8156/8157/8159

This commit moves the per-family flow-control pause frame setup into a new
rtl_fc_pause_pkt_en() helper. RTL8156A now gets the FC timer and
FLOW_CTRL_PATCH_OPT setup, and RTL8157/RTL8159 program the new
PLA_PAUSE_LIMIT register from rtl8157_enable() based on the negotiated speed.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 023e7af4c5fa6..b5092fdaa12c7 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -6172,6 +6177,104 @@ static void r8152b_enter_oob(struct r8152 *tp)
>  			   RCR_APM | RCR_AM | RCR_AB);
>  }
>  
> +static void rtl_fc_pause_pkt_en(struct r8152 *tp, u16 speed)
> +{

[ ... ]

> +	case RTL_VER_16:
> +	case RTL_VER_17_QFN68:
> +	case RTL_VER_17_QFN100:
> +		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
> +
> +		num_pause_pkts = 0xa;
> +		ratio = 10000;
> +
> +		if (speed & _10bps) {
> +			ratio /= 10;
> +		} else if (speed & _100bps) {
> +			ratio /= 100;
> +		} else if (speed & _1000bps) {
> +			ratio /= 1000;
> +		} else if (speed & _2500bps) {
> +			ratio /= 2500;
> +		} else if (speed & _5000bps) {
> +			ratio /= 5000;
> +		} else if (speed & _10000bps) {
> +			ratio /= 10000;
> +		} else {
> +			/* No rate bit is set, e.g. a 500 or 1250 Mbit/s
> +			 * sub-rate, which the driver does not advertise.
> +			 * Disarm the limit.
> +			 */
> +			dev_err(&tp->intf->dev, "Unknown link speed\n");
> +			ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_PAUSE_LIMIT,
> +					  PAUSE_LIMIT_EN);
> +			break;
> +		}

[Severity: Low]
Does this else branch also run when the link is down, not only for the
500/1250 Mbit/s case the comment describes?

When LINK_STATUS is clear, PLA_PHYSTATUS has no rate bit set.
rtl8157_enable() passes the raw rtl8152_get_speed() value through without
checking LINK_STATUS:

    speed = rtl8152_get_speed(tp);
    rtl_fc_pause_pkt_en(tp, speed);

set_carrier() checks LINK_STATUS before it calls enable. Other callers only
look at the cached carrier state, for example rtl8152_change_mtu():

    if (netif_carrier_ok(dev)) {
        ...
        tp->rtl_ops.disable(tp);
        tp->rtl_ops.enable(tp);

rtl8152_post_reset() and rtl8152_set_coalesce() work the same way.

Here is one possible sequence. The PHY link drops, and intr_callback() sets
RTL8152_LINK_CHG and schedules the work. Before rtl_work_func_t() runs
set_carrier(), a user changes the MTU or coalesce settings, or a USB reset
completes. rtl8157_enable() then runs on a down link. It logs "Unknown link
speed" and clears PAUSE_LIMIT_EN.

The link might come back before the work samples it. In that case
set_carrier() sees LINK_STATUS together with netif_carrier_ok(). It never
calls enable again, so wouldn't pause limiting stay disarmed for that link
session?

Would it make sense to check LINK_STATUS here, or in rtl8157_enable(), so a
down link isn't reported as an unknown speed?

> +
> +		log2_ratio = ilog2(ratio);
> +		num_pause_pkts -= log2_ratio;

[ ... ]

> @@ -6703,6 +6806,8 @@ static int rtl8157_enable(struct r8152 *tp)
>  	r8153_set_rx_early_size(tp);
>  
>  	speed = rtl8152_get_speed(tp);
> +	rtl_fc_pause_pkt_en(tp, speed);
> +
>  	rtl_set_ifg(tp, speed);
>  
>  	return rtl_enable(tp);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008081556.47901-1-nic_swsd%40realtek.com
