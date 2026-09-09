Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FE356E054;
	Wed,  9 Sep 2026 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960737; cv=none; b=lRo33Tj04awYJFAwc2oBf37oC0AQHpy3SxmQE3/CPx/6IPaz58HZDYC6kOr3rpSKRp6ca364Z4n0/c7pveSoX6MKHfKwuScd8OHcadTDXWVBxXAoDTs1yj6+nMubGMZfIrQNmhZbyWP9mLXfUG8iFmzJLf/XP2XjoF1niwnv4VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960737; c=relaxed/simple;
	bh=TRmlgyvQOdocB2xX4J3qFKaL/Tha10BMCwWeWVUa90Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h7Pd6561I48m7HS0iksXpVW5eIiIMMDXZj9KPGa39iAZvxzLRFdw7N+MIgCeKVihPWTx//WrbM+JfXQn2X2R9/XqiuTKByf8Way23taLdyY5IVFXbNPxtpD4vkrifNmUVNhbnjQ28DHGT1ZZMiX6dWGlp/zU/fbNBMfJ836EJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ftd6M9fP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ftd6M9fP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409CD1F00A3A;
	Wed,  9 Sep 2026 13:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960734;
	bh=mBghGrrRJOTS2dvCxv4OJpt4+n6w8j+UaYNji6r1pCg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ftd6M9fPrn8JRsOBAsObgvvFWdPzM4YyA9e+EjGFPGhYAg57pPxn9A12IDCzRlV0l
	 sZ6Bo3F2gtD5WyxDqY6ah+twanfPW2ohK+dgY3klsXi9aijOL6Hi+1ozgqtGvgwxAT
	 LYewkanactl7EbsalcFMzkKakEcxqD9E4gbVzhblfRsIHtyWJLuvaShqqETeVWYoXa
	 iterloBiauS7IhH+By8o2YCnw6mSqTVe8TmoqdnWf7mg0AMQ/2KriM/in4DtBC+YGG
	 usIz4PXfEgTmlzxNMoPLaAbrcbT6A8cK3zeWlkbkSO0P+tNXRfFf7U/6OmElq4vBQe
	 FI8OaMsj6Y1TA==
Subject: Re: [PATCH net-next v2 7/8] r8152: support rtl_fc_pause_pkt_en()
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Wed, 09 Sep 2026 13:32:13 +0000
Message-ID: <178896073385.219967.16523220515085464809@kernel.org>
In-Reply-To: <20260903072852.58695-8-nic_swsd@realtek.com>
References: <20260903072852.58695-8-nic_swsd@realtek.com>
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

- [Medium] Commit message describes the change as an extraction of the
  inline flow-control block from r8156b_init, but only the…

--

r8152: support rtl_fc_pause_pkt_en()

This moves the inline flow control block out of r8156b_init() into a new
helper rtl_fc_pause_pkt_en(), and calls it from r8156_init(), r8156b_init()
and rtl8157_enable(). It also adds a new PLA_PAUSE_LIMIT register with
PAUSE_LIMIT_EN and PAUSE_LIMIT_MASK bits used by the RTL8157/RTL8159 path.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 1fcb1cc5b4a1..2b0972b96738 100644
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

[Severity: Medium]
The changelog says "Extract it as rtl_fc_pause_pkt_en()", but does that
describe all three arms of this switch?

Only the RTL_VER_12/13/15 arm below is code moved out of r8156b_init().

At the baseline commit (6ebcf5074cff) the USB_FC_TIMER / FLOW_CTRL_PATCH_OPT
/ FC_PATCH_TASK writes above have no counterpart for RTL_VER_10 or
RTL_VER_11 anywhere in the tree, and PLA_PAUSE_LIMIT does not exist at all.
So r8156_init() (RTL_VER_10/11) and rtl8157_enable() (RTL_VER_16 and
RTL_VER_17_*) both start touching flow control registers that were
previously never programmed on already-supported hardware.

Could the changelog describe the new register programming separately from
the extraction, and state which user-visible symptom the new writes fix?
If they fix a defect on shipped chips, would Fixes: tags be appropriate so
stable tooling can tell which releases are affected?

Also, the new PLA_PAUSE_LIMIT define uses spaces instead of tabs, unlike
the surrounding register defines.

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

[Severity: Medium]
This whole RTL_VER_16 / RTL_VER_17_QFN68 / RTL_VER_17_QFN100 arm is new
register programming rather than moved code, and the two starting values
(0xa and 10000) plus the log2 rounding heuristic below are unexplained.

Could a comment be added describing what PLA_PAUSE_LIMIT[7:4] means in
hardware terms, and how 0xa and the ratio of 10000 relate to it?

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
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903072852.58695-1-nic_swsd%40realtek.com
