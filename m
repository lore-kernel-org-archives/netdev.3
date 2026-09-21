Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E445349C;
	Mon, 21 Sep 2026 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979445; cv=none; b=g0keHFDKwN+4rZbBzU0s8E2BDwB2EWVjtDOhJaMmfhydiJPWyc4q49UMbGjTeVkyZK9jUaMlgR4J09C9CnudJ+L1lXg94mAyLJybVOdkZ40gbmRgf56VjYLO856E16J/S7vCgem+yjniPYbKibFqagdRY5KpzfU27DCZOa9ObWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979445; c=relaxed/simple;
	bh=JBF0plkfp2iAws//noS7iDWQ6KxoPe7QOP5T0zNhO/g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cL8hZB6XXzVdMN4OLMFKU/2+8ke934en82mB+LK3sYTkAP3+NT8V9NXPAZlNDaVlrEb1By2JN1MAoGGTKjBrRWtZAsA+2pBOxGn3NfGP/GNExmM5dZc/6zVGXwwtPAIJgB79pDjFRoX9vEP7podv+LG9C/+vWNyag3O88sP0GPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5Xy0rM3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5Xy0rM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FC51F00899;
	Mon, 21 Sep 2026 08:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789979439;
	bh=seTPrfwy1/zQzgIP6WES7KlGXQKqwIn3L9zlB2sR5kA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D5Xy0rM3vH32nZ3ChCKUJ+L65JosBQ8OKSxG3+WpwyyIhp630mc59UVmS3AfUebkz
	 QRYLDlioQLzncObNhpDZd1o+3L1x09oru9jwHJ0VEzRRiOhbGTCDyBcvO0wgCnhnle
	 37VN+DYI4lcvleoNKATTFUZHyX4sZF/OeQIdf5lixxws5imkNK4XkG2D6bl76EXIN2
	 1d7w5g+i078xizG8s8Tbp1ffB0hie6QvvNScPE3LplDcw2myBwlNCaxhpg7mxf1pAV
	 g1QSe7uRfau93B+WyXB80eW50/UJ2C4b9oyiszVUCpTlwR51TW4hr1GbKLOqj+/UdI
	 DT2tl/v/cxggA==
Subject: Re: [PATCH net-next v4 7/8] r8152: extract rtl_fc_pause_pkt_en() and
 apply it to RTL8156/8157/8159
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Mon, 21 Sep 2026 08:30:38 +0000
Message-ID: <178997943873.2160803.12886681417132799746@kernel.org>
In-Reply-To: <20260917070637.62827-8-nic_swsd@realtek.com>
References: <20260917070637.62827-8-nic_swsd@realtek.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] rtl_fc_pause_pkt_en() (drivers/net/usb/r8152.c, RTL_VER_16 /
  RTL_VER_17_QFN68 / RTL_VER_17_QFN100 branch) derives the…
- [Medium] The changelog misstates the pre-patch state and omits the
  impact/Fixes: information for what is a functional change to already-…
- [Medium] In the new RTL_VER_16/RTL_VER_17_* branch of
  rtl_fc_pause_pkt_en() (drivers/net/usb/r8152.c:6206-6252) both…

--

r8152: extract rtl_fc_pause_pkt_en() and apply it to RTL8156/8157/8159

The flow-control setup that used to live inline in r8156b_init() is moved
into a new rtl_fc_pause_pkt_en() helper, and cases are added for RTL8156A
(VER_10/11) and for RTL8157/RTL8159 (VER_16/17), where a per-speed
pause-packet count is programmed into the new PLA_PAUSE_LIMIT register.
The helper is called from r8156_init(), r8156b_init() and rtl8157_enable().

A few questions about the changelog and about the new VER_16/17 branch.

[Severity: Medium]

The changelog says:

    RTL8156A (VER_10/11) and RTL8157/RTL8159 (VER_16/17)
    never applied any flow-control patch at all.

Is the VER_10/11 half of that accurate?  The ops table maps RTL_VER_10 and
RTL_VER_11 to rtl8156_enable(), and rtl8156_enable() already runs the
FC_PATCH_TASK toggle on every enable:

	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
	usleep_range(1000, 2000);
	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);

What VER_10/11 appears to have been missing is just the USB_FC_TIMER
programming (CTRL_TIMER_EN | 1000 / 8) and the USB_FW_CTRL
FLOW_CTRL_PATCH_OPT bit that the new VER_10/11 case adds.  Could the
message be narrowed to that?

Also, the changelog does not describe an observable symptom (RX FIFO
overflow, drops, throughput loss under back-pressure), and there is no
Fixes: tag even though behaviour changes on already shipping hardware:
r8156_init() gains rtl_fc_pause_pkt_en(tp, 0) for RTL_VER_10/11
(candidate 195aae321c82 "r8152: support new chips"), and rtl8157_enable()
gains the PLA_PAUSE_LIMIT programming for RTL_VER_16 and both RTL_VER_17
variants (candidates fd3c7d080df5, ad2a55b63b41).

Could the impact be stated and the Fixes: tag(s) added, or the wording
adjusted so it does not read as fixing a defect?

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 3473061af129a..05b2b79ab3e31 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

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
> @@ -6163,6 +6168,93 @@ static void r8152b_enter_oob(struct r8152 *tp)
>  			   RCR_APM | RCR_AM | RCR_AB);
>  }
>  
> +static void rtl_fc_pause_pkt_en(struct r8152 *tp, u16 speed)
> +{
> +	int log2_ratio, ratio;
> +	u16 num_pause_pkts;
> +	u32 ocp_data;
> +

[ ... ]

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

[Severity: Medium]

Can the values this formula produces be spelled out?  The changelog says
"a log2-ratio formula that reproduces that table", but the table itself is
nowhere in the patch, so the programmed encoding cannot be checked against
the datasheet by a reviewer or by whoever touches this next.

Evaluating the arithmetic gives:

	10 Mbit/s   ratio 1000  ilog2 9  0xa - 9 = 1, round-up hits -> 0
	100 Mbit/s  ratio 100   ilog2 6  0xa - 6 = 4, round-up hits -> 3
	1 Gbit/s    ratio 10    ilog2 3  0xa - 3 = 7, no round-up   -> 7
	2.5 Gbit/s  ratio 4     ilog2 2  0xa - 2 = 8, no round-up   -> 8
	5 Gbit/s    ratio 2     ilog2 1  0xa - 1 = 9, no round-up   -> 9
	10 Gbit/s   ratio 1     ilog2 0  0xa - 0 = 10               -> 10

Is num_pause_pkts == 0 at 10 Mbit/s the intended encoding?  The write
below clears PAUSE_LIMIT_MASK | PAUSE_LIMIT_EN, ORs in 0 << 4, and then
PAUSE_LIMIT_EN is set again, so the limiter is armed with a count field of
zero.  PLA_PAUSE_LIMIT was not written at all for these parts before this
patch, so if zero means "no pause frames" this changes 10 Mbit/s
behaviour.

Would a plain switch or lookup table (or the datasheet table quoted in a
comment) make the per-speed values auditable, and can the 10 Mbit/s
boundary value be confirmed against the datasheet?

> +no_link:
> +		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_PAUSE_LIMIT,
> +			      PAUSE_LIMIT_MASK | PAUSE_LIMIT_EN,
> +			      num_pause_pkts << 4);
> +
> +		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_PAUSE_LIMIT,
> +				  PAUSE_LIMIT_EN);
> +		break;

[Severity: Medium]

Both fallback paths reach this label with num_pause_pkts still at its
initialiser 0xa, which is the 10 Gbit/s entry, and the label then writes
that count and sets PAUSE_LIMIT_EN.  Should the no-link and unknown-speed
cases instead leave PLA_PAUSE_LIMIT alone (the pre-patch behaviour), or
clear PAUSE_LIMIT_EN?

The name no_link and the dev_dbg("No link") read as if nothing is
programmed, but the limiter ends up armed with the fastest link's pause
count while the MAC may be running at 10 or 100 Mbit/s, where the intended
counts are 0 and 3.

How is the no-link path reached?  rtl8157_enable() re-reads PLA_PHYSTATUS
after the caller already tested LINK_STATUS:

set_carrier()
	speed = rtl8152_get_speed(tp);
	if (speed & LINK_STATUS)
		... tp->rtl_ops.enable(tp);

rtl8157_enable()
	speed = rtl8152_get_speed(tp);
	rtl_fc_pause_pkt_en(tp, speed);

A link drop between the two reads takes the !(speed & LINK_STATUS) arm.
Since ->enable() only runs again on an observed carrier down/up
transition, and nothing else re-programs PLA_PAUSE_LIMIT, can a later
low-speed link then run for the whole session with the 10 Gbit/s pause
budget?

Separately, the decode chain covers only _10bps, _100bps, _1000bps,
_2500bps, _5000bps and _10000bps, while this driver's own
enum rtl_register_content also defines:

	_2500bps	= BIT(10),
	_1250bps	= BIT(9),
	_500bps		= BIT(8),

and rtl8156_enable() treats _500bps as a real link state:

	if (speed & _1000bps)
		ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS, 0x11);
	else if (speed & _500bps)
		ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS, 0x3d);

If RTL8157/RTL8159 can report one of those, this lands in the final else,
emits dev_err("Unknown link speed") at KERN_ERR on every ops->enable()
call (link-up, ndo_open, change_mtu, set_coalesce), and still arms the
10 Gbit/s limit.  Should the remaining encodings be decoded here too?

> +	default:
> +		break;
> +	}
> +}
> +
>  static int r8153_pre_firmware_1(struct r8152 *tp)
>  {
>  	int i;
> @@ -6694,6 +6786,8 @@ static int rtl8157_enable(struct r8152 *tp)
>  	r8153_set_rx_early_size(tp);
>  
>  	speed = rtl8152_get_speed(tp);
> +	rtl_fc_pause_pkt_en(tp, speed);
> +
>  	rtl_set_ifg(tp, speed);
>  
>  	return rtl_enable(tp);
> @@ -8842,6 +8936,8 @@ static void r8156_init(struct r8152 *tp)
>  
>  	usb_enable_lpm(tp->udev);
>  
> +	rtl_fc_pause_pkt_en(tp, 0);
> +
>  	r8156_mac_clk_spd(tp, true);
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917070637.62827-1-nic_swsd%40realtek.com
