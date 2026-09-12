Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A553EE1D3;
	Sat, 12 Sep 2026 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244398; cv=none; b=JiALWvcOxZPf23VlWbetPcYHqkXYVc93ebbp3be2BXbMLIXHvcHY8GZqJ+SSVhmdCYhcvxiozAQBeIRKEaJXwlanp8SDgbg5dZ+Uyr4Q7/r/kRbjCUJ3+rKeOjm6j2k6kLC8yyNdW4u6PPnXFiuWRalujA+IXXKR+9qcC7Zs7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244398; c=relaxed/simple;
	bh=lv/jpcJ6DsW9I8+7JbGiL49q9M7awXgVVdjsGq62h/M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BlSSHLP/qyvCXHHLCImvaxZO5bjofBhQJFarx/IIHjj1FtwErpOLFkhXhBDWpRv/jrUFKcoQ7iGqnWjOy35RqdOa541/rCwingzjmlWHdiiY5wvgtvGGzFj4tZWtoZ5aeR7vA6D8FMw8vN1wmOoW6/2VDK1gL8kULi46u4Dte8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+phOwnc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+phOwnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F231F00898;
	Sat, 12 Sep 2026 20:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244396;
	bh=TKn7ufIecsVfsKJQvgtNcaPc53cLfzzq8ZatQMvV6BA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A+phOwncjRVZ4Dj8NIrjhZdjnBnZ4TDVUD4QtCTp6fcvoQ6TeUlWhlItbNqPmiurI
	 Mxgjq0FfiJDCVHq7SUoouVvUeHXcZf0eh1MRrT9diG85833s8MwTXf/Axy2YiORlDB
	 XpztD5/5Niar2ZZzGGpP+0wkqLulAwT2TtCzC05rIW3rUF9HM7ZUFaZzRnB5424p5k
	 3ADTv3lCzBHHnbA5TJVfbx6EUCL5LVharP2r8G+UgRicDrY2HqRHarLtGrtyUoA8ZJ
	 zB2UvP41A7jgG9Duu1PJlmTIBFMXA1drMzu30dIstxJ5Sb/NLVNmlhVX8tU55rRJZZ
	 tV2/3ZY2dmRKQ==
Subject: Re: [PATCH net-next v3 7/8] r8152: support rtl_fc_pause_pkt_en()
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Sat, 12 Sep 2026 20:19:55 +0000
Message-ID: <178924439522.3125.10329416653763304539@kernel.org>
In-Reply-To: <20260908075634.23740-8-nic_swsd@realtek.com>
References: <20260908075634.23740-8-nic_swsd@realtek.com>
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

- [Medium] Commit message mischaracterizes the change as an extraction
  and omits the new register programming it introduces.

--

r8152: support rtl_fc_pause_pkt_en()

This moves the flow control programming out of r8156b_init() into a new
helper rtl_fc_pause_pkt_en(), and calls it from r8156_init(), r8156b_init()
and rtl8157_enable(). The helper switches on tp->version and, for RTL8157
and RTL8159, programs a new pause limit register based on the link speed.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 1fcb1cc5b4a18..2b0972b967385 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -89,6 +89,7 @@
>  #define PLA_MTPS		0xe615
>  #define PLA_TXFIFO_CTRL		0xe618
>  #define PLA_TXFIFO_FULL		0xe61a
> +#define PLA_PAUSE_LIMIT         0xe61e
>  #define PLA_RSTTALLY		0xe800
>  #define PLA_CR			0xe813
>  #define PLA_CRWECR		0xe81c
> @@ -301,6 +302,10 @@
>  #define MTPS_JUMBO		(12 * 1024 / 64)
>  #define MTPS_DEFAULT		(6 * 1024 / 64)
>  
> +/* PLA_PAUSE_LIMIT */
> +#define PAUSE_LIMIT_EN		BIT(3)
> +#define PAUSE_LIMIT_MASK	0xf0
> +
>  /* PLA_RSTTALLY */
>  #define TALLY_RESET		0x0001
>  
> @@ -6088,6 +6093,93 @@ static void r8152b_enter_oob(struct r8152 *tp)
>  			   RCR_APM | RCR_AM | RCR_AB);
>  }
>  
> +static void rtl_fc_pause_pkt_en(struct r8152 *tp, u16 speed)
> +{
> +	int log2_ratio, ratio;
> +	u16 num_pause_pkts;
> +	u32 ocp_data;
> +
> +	switch (tp->version) {
> +	case RTL_VER_10:
> +	case RTL_VER_11:
> +		ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER,
> +			       CTRL_TIMER_EN | (1000 / 8));
> +
> +		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_CTRL,
> +				  FLOW_CTRL_PATCH_OPT);
> +
> +		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
> +		break;
> +	case RTL_VER_12:
> +	case RTL_VER_13:
> +	case RTL_VER_15:
> +		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
> +
> +		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR, FLOW_CTRL_EN);
> +
> +		/* enable fc timer and set timer to 600 ms. */
> +		ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER,
> +			       CTRL_TIMER_EN | (600 / 8));
> +
> +		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL);
> +		if (!(ocp_data & DACK_DET_EN))
> +			ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_CTRL,
> +					  FLOW_CTRL_PATCH_2);
> +
> +		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
> +		break;
> +	case RTL_VER_16:
> +	case RTL_VER_17_QFN68:
> +	case RTL_VER_17_QFN100:
> +		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
> +
> +		num_pause_pkts = 0xa;
> +		ratio = 10000;
> +
> +		if (!(speed & LINK_STATUS)) {
> +			dev_dbg(&tp->intf->dev, "No link\n");
> +			goto no_link;
> +		} else if (speed & _10bps) {
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
> +			dev_err(&tp->intf->dev, "Unknown link speed\n");
> +			goto no_link;
> +		}
> +
> +		log2_ratio = ilog2(ratio);
> +		num_pause_pkts -= log2_ratio;
> +
> +		/* Round up if ratio is more than halfway to the next power of 2.
> +		 * Floating-point is avoided by rewriting
> +		 * ratio > 1.5 * 2^log2_ratio as
> +		 * 2 * ratio > 3 * 2^log2_ratio
> +		 */
> +		if (2 * ratio > 3 * (1 << log2_ratio))
> +			num_pause_pkts--;
> +
> +no_link:
> +		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_PAUSE_LIMIT,
> +			      PAUSE_LIMIT_MASK | PAUSE_LIMIT_EN,
> +			      num_pause_pkts << 4);
> +
> +		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_PAUSE_LIMIT,
> +				  PAUSE_LIMIT_EN);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +

[Severity: Medium]
Is the changelog description of "Extract it as rtl_fc_pause_pkt_en()"
accurate for the RTL_VER_10/RTL_VER_11 and RTL_VER_16/RTL_VER_17 arms of
rtl_fc_pause_pkt_en()?  The three arms are not the same sequence that was
inline in r8156b_init().

For RTL_VER_10/RTL_VER_11 the helper programs:

	ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER,
		       CTRL_TIMER_EN | (1000 / 8));
	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_CTRL,
			  FLOW_CTRL_PATCH_OPT);
	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);

At the series baseline the flow control block in r8156_init() was gated as:

	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_15) {
		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR, FLOW_CTRL_EN);
		...
	}

so RTL_VER_10/RTL_VER_11 received no flow control programming, and
FLOW_CTRL_PATCH_OPT was only set from the RTL8153B firmware path.  Could
the changelog say why RTL8156A now gets a 1000 ms timer plus
FLOW_CTRL_PATCH_OPT, while RTL8156B keeps the 600 ms timer,
FLOW_CTRL_PATCH_2 and PLA_CPCR FLOW_CTRL_EN?

For RTL_VER_16/RTL_VER_17_QFN68/RTL_VER_17_QFN100 the helper adds a new
register, PLA_PAUSE_LIMIT (0xe61e), the new PAUSE_LIMIT_EN/PAUSE_LIMIT_MASK
bits, and a link-speed dependent pause packet count, but it sets neither
PLA_CPCR FLOW_CTRL_EN nor USB_FC_TIMER even though the changelog says the
flow control patch was "missing for ... RTL8157/8159".  None of the new
register or the pause budget calculation is described in the changelog.

Could the changelog describe the observed malfunction, the link speeds and
traffic conditions it was seen under, and what was tested, so the behaviour
change on already supported RTL8156A hardware and the new pause limit
programming can be judged?

>  static int r8153_pre_firmware_1(struct r8152 *tp)
>  {
>  	int i;
> @@ -6619,6 +6711,8 @@ static int rtl8157_enable(struct r8152 *tp)
>  	r8153_set_rx_early_size(tp);
>  
>  	speed = rtl8152_get_speed(tp);
> +	rtl_fc_pause_pkt_en(tp, speed);
> +
>  	rtl_set_ifg(tp, speed);
>  
>  	return rtl_enable(tp);
> @@ -8751,6 +8845,8 @@ static void r8156_init(struct r8152 *tp)
>  
>  	usb_enable_lpm(tp->udev);
>  
> +	rtl_fc_pause_pkt_en(tp, 0);
> +
>  	r8156_mac_clk_spd(tp, true);
>  

[ ... ]

> @@ -8852,20 +8947,7 @@ static void r8156b_init(struct r8152 *tp)
>  
>  	usb_enable_lpm(tp->udev);
>  
> -	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
> -
> -	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR, FLOW_CTRL_EN);
> -
> -	/* enable fc timer and set timer to 600 ms. */
> -	ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER,
> -		       CTRL_TIMER_EN | (600 / 8));
> -
> -	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL);
> -	if (!(ocp_data & DACK_DET_EN))
> -		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_CTRL,
> -				  FLOW_CTRL_PATCH_2);
> -
> -	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
> +	rtl_fc_pause_pkt_en(tp, 0);
>  
>  	r8156_mac_clk_spd(tp, true);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908075634.23740-1-nic_swsd%40realtek.com
