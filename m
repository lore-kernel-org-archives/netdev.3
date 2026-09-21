Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5BA1EE7B7;
	Mon, 21 Sep 2026 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979433; cv=none; b=PDVDlgBclvY4f9eMOdbPTG5ISP+EuP9ouIC658AYpxoMIve6ezpArA+ipCeSfXCSG292EZmQcVU+umv4Vgv/kAPgGf6r2sxy3dLfWNQ1GAFu/VMegg0Qj3sozpufT45G7aeHDhJlYzlGtQE9ZTjxSMq/jTRgVSPFxTpXcR29XoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979433; c=relaxed/simple;
	bh=0icuCGelSsrHndUtDyKt15Z+QA62oQtYv8WQ5s8g0I4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eOxyf6NAvlr7zDbz5g7++pmhuNBHRglAnRXj/8R3APEFmc22OWRrjAMF7Wko7ap9g10D6s/fRPIgsMwh7NDB0B4GVcPZ6HAzfCPZTvFeUk1b4mA6K2AiHb6VQRTg4fSBWRUFlrfjo+xVo+ynw149BlHOb/S+p/qiY46JUTorbVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SegM6z19; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SegM6z19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45D01F000FF;
	Mon, 21 Sep 2026 08:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789979432;
	bh=yjWMaaLRsqZzD0894CVnibLaW0tZ9pcPnPr3pO/rnLc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SegM6z19T56pBYagEEDUfEuxnfxlIVjwx9qGIYaMrKyZsHgAfLBvaTVKoLp9UFpFH
	 EoASp4YTvvKDoqYPUIspPSpLdMd3NgigvwvgH558Smo9NdLGDzxtkiKX5eG21gN8v7
	 agSD6mJolW+n4VhzdEQvi0740Imr/x4w8KlVWcy2RRaR7+obeijOKN6qornf/UHi30
	 cv8sPEKqasTe1mvD542R8Q37cDxCn4GWPaaZ5iVqRjM8eLedghqg/bqxvvGRhU22CS
	 udZJCydZAaxhmB5f7huuFGidtqh3ZwTqE8bYEHX6paAG/lCNpaZ5cx+TJVp5qfdNZa
	 5g2ajt7Kul+Zg==
Subject: Re: [PATCH net-next v4 1/8] r8152: split r8156_init per chip and add
 missing init writes
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Mon, 21 Sep 2026 08:30:31 +0000
Message-ID: <178997943124.2160803.765103077515705742@kernel.org>
In-Reply-To: <20260917070637.62827-2-nic_swsd@realtek.com>
References: <20260917070637.62827-2-nic_swsd@realtek.com>
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

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Undocumented hardware behaviour change during the split:
  r8157_init() (installed as ops->init for RTL_VER_16 in rtl_ops_init())…
- [Medium] Silent reordering of hardware handshakes for RTL8157/RTL8159.
- [Low] Commit message vs. code: the message names the FC-timer block
  ("fenced to RTL_VER_12 <= version <= RTL_VER_15") as the example of a…

Pre-existing issues:
- [Medium] An RTL8159 backup-restore timeout marks the device
  inaccessible but cannot report the failure to its caller: r8159_init()…

--

r8152: split r8156_init per chip and add missing init writes

This splits the shared r8156_init() into r8156_init(), r8156b_init(),
r8157_init() and r8159_init(), factors the AUTOLOAD_DONE polling loops into
wait_autoload_done(), and adds a number of new OCP writes to the per-chip
init sequences.  A few observations below.

First, about the motivation in the changelog:

> RTL8156, RTL8156B, RTL8157 and RTL8159 shared a single r8156_init(),
> gated by a dense set of tp->version range checks. That made the init
> sequence hard to follow, and some checks (e.g. the FC-timer block,
> which was fenced to "RTL_VER_12 <= version <= RTL_VER_15") silently
> skipped RTL8156 (VER_10/11) and RTL8157/RTL8159 (VER_16/17)
> altogether even though nothing chip-specific justified the gap.

[Severity: Low]

This isn't a bug, but after the split the FC-timer block named here still
exists only in r8156b_init().  The PLA_RCR SLOT_EN clear, PLA_CPCR
FLOW_CTRL_EN, USB_FC_TIMER, FLOW_CTRL_PATCH_2 and USB_FW_TASK FC_PATCH_TASK
writes are absent from r8156_init() (VER_10/11), r8157_init() (VER_16) and
r8159_init() (VER_17), i.e. the exact gap the paragraph complains about is
unchanged by this patch, and the "While splitting:" list does not claim to
close it.

The gap is closed later in the series by "r8152: extract
rtl_fc_pause_pkt_en() and apply it to RTL8156/8157/8159", which factors the
block into rtl_fc_pause_pkt_en() with cases for RTL_VER_10/11,
RTL_VER_12/13/15 and RTL_VER_16/17 and calls it from r8156_init(),
r8156b_init() and rtl8157_enable().

Could this paragraph say that the FC-timer gap is addressed by a later patch
in the series rather than by this one?

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index af3d7dcb2f141..00b0fda306c30 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -542,6 +547,7 @@
>  #define RX_AGG_DISABLE		0x0010
>  #define RX_ZERO_EN		0x0080
>  #define RX_DESC_16B		0x0400
> +#define RX_END_TRANSFER_EN	BIT(11)
>  
>  /* USB_U2P3_CTRL */
>  #define U2P3_ENABLE		0x0001

[ ... ]

> @@ -8330,90 +8311,132 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)

[ ... ]

>  	switch (tp->version) {
>  	case RTL_VER_13:
>  	case RTL_VER_15:
> -	case RTL_VER_16:
> -	case RTL_VER_17:
>  		r8156b_wait_loading_flash(tp);
>  		break;
>  	default:
>  		break;
>  	}
>  
> -	for (i = 0; i < 500; i++) {
> -		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
> -		    AUTOLOAD_DONE)
> -			break;
> -
> -		msleep(20);
> -		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> -			return;
> -	}
> -
> -	if (tp->version == RTL_VER_17 && r8159_wait_backup_restore(tp)) {
> -		rtl_set_inaccessible(tp);
> -		dev_err(&tp->intf->dev, "init failed, backup-restore timed out\n");
> +	if (wait_autoload_done(tp))
>  		return;
> -	}

[ ... ]

> @@ -8421,73 +8444,261 @@ static void r8156_init(struct r8152 *tp)

[ ... ]

>  	set_bit(GREEN_ETHERNET, &tp->flags);
>  
> -	/* RX aggregation / 16 bytes RX descriptor
> -	 * BIT(11) is specific to RTL8159, with unknown meaning
> -	 */
> -	if (tp->version == RTL_VER_17)
> -		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
> -				  RX_AGG_DISABLE | RX_DESC_16B | BIT(11));
> -	else if (tp->version == RTL_VER_16)
> -		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_DESC_16B);
> +	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
> +			  RX_AGG_DISABLE | RX_ZERO_EN);

[ ... ]

> +static void r8157_init(struct r8152 *tp)
> +{
> +	u16 data;
> +
> +	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> +		return;
> +
> +	/* Enable SW reset */
> +	ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xcffe, BIT(3));
> +	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(0));
> +
> +	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
> +
> +	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION, BYPASS_MAC_RESET);
> +
> +	r8153b_u1u2en(tp, false);
> +
> +	if (wait_autoload_done(tp))
> +		return;
> +
> +	r8156b_wait_loading_flash(tp);

[Severity: Medium]

Is this reordering deliberate?  In the shared r8156_init() the flash-patch
wait for VER_16/17 ran right after r8153b_u1u2en(tp, false) and before the
AUTOLOAD_DONE poll:

	switch (tp->version) {
	case RTL_VER_13:
	case RTL_VER_15:
	case RTL_VER_16:
	case RTL_VER_17:
		r8156b_wait_loading_flash(tp);
		break;
	...
	for (i = 0; i < 500; i++) {
		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
		    AUTOLOAD_DONE)
			break;

r8156b_init() keeps that pre-poll placement for VER_13/15, so only the
VER_16 and VER_17 paths change order here.

r8159_init() moves r8156b_wait_loading_flash() after
r8159_wait_backup_restore() as well.  Both helpers poll USB_GPHY_CTRL
(GPHY_PATCH_DONE versus BACKUP_RESTRORE), and the backup-restore poll has a
20 ms budget:

	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL),
			       ocp_data & BACKUP_RESTRORE, 200, 20000, false);

while r8156b_wait_loading_flash() allows roughly 100 ms for the patch load.
If a pending flash load can delay BACKUP_RESTRORE, can this poll now time
out where it previously could not, given that the flash wait used to
complete first?  On timeout r8159_init() calls rtl_set_inaccessible() and
abandons the rest of the bring-up.

> +
> +	data = r8153_phy_status(tp, 0);
> +	if (data == PHY_STAT_EXT_INIT) {
> +		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
> +		ocp_reg_clr_bits(tp, 0xa466, BIT(0));
> +	}

[ ... ]

> +	set_bit(GREEN_ETHERNET, &tp->flags);
>  
> +	/* RX aggregation / 16 bytes RX descriptor / Bulk In End transfer */
> +	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
> +			  RX_AGG_DISABLE | RX_DESC_16B | RX_END_TRANSFER_EN);

[Severity: Medium]

Should r8157_init() clear USB_USB_CTRL bit 11?  Before the split that bit
was restricted to RTL_VER_17, with a comment saying it was RTL8159
specific:

	/* RX aggregation / 16 bytes RX descriptor
	 * BIT(11) is specific to RTL8159, with unknown meaning
	 */
	if (tp->version == RTL_VER_17)
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
				  RX_AGG_DISABLE | RX_DESC_16B | BIT(11));
	else if (tp->version == RTL_VER_16)
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_DESC_16B);

rtl_ops_init() installs r8157_init() as ops->init for RTL_VER_16, so every
RTL8157 now has bit 11 (newly named RX_END_TRANSFER_EN) cleared on each
probe and reset_resume.

Every other per-version divergence of the old function was reproduced
exactly in the split (USB_SPEED_OPTION for versions below VER_16, RX_DETECT8
for VER_12 to VER_15, PLA_MCU_SPDWN_EN for versions below VER_16, ACT_ODMA
for versions below VER_12, r8153_u2p3en() versus r8157_u2p3en(),
r8153b_power_cut_en() versus r8157_power_cut_en()), and the changelog
enumerates each intentionally added write without mentioning this one.

Can the changelog describe what bit 11 does on RTL8157, or keep the write
limited to RTL8159 as before?

[ ... ]

> +static int r8159_wait_backup_restore(struct r8152 *tp)
> +{
> +	u32 ocp_data;
> +
> +	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
> +	if (!(ocp_data & PCUT_STATUS))
> +		return 0;
> +
> +	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL),
> +			       ocp_data & BACKUP_RESTRORE, 200, 20000, false);
> +}
> +
> +static void r8159_init(struct r8152 *tp)
> +{

[ ... ]

> +	if (wait_autoload_done(tp))
> +		return;
> +
> +	if (r8159_wait_backup_restore(tp)) {
> +		rtl_set_inaccessible(tp);
> +		dev_err(&tp->intf->dev,
> +			"init failed, backup-restore timed out\n");
> +		return;
>  	}

[Severity: Medium]

This is a pre-existing issue and not introduced by this patch, since the
same abort path was in the shared r8156_init(), but as it is being moved
here: how does this failure reach the caller?

rtl_set_inaccessible() only sets one flag:

	static void rtl_set_inaccessible(struct r8152 *tp)
	{
		set_bit(RTL8152_INACCESSIBLE, &tp->flags);
		smp_mb__after_atomic();
	}

PROBE_SHOULD_RETRY is set only by r8152_control_msg() on a failed control
transfer, which a BACKUP_RESTRORE poll timeout is not, and
rtl8152_probe_once() checks only that flag after calling
tp->rtl_ops.init(tp):

	if (test_bit(PROBE_SHOULD_RETRY, &tp->flags))
		goto out2;

So probe continues through register_netdev() and returns success while the
rest of r8159_init() was skipped and every subsequent
generic_ocp_read()/generic_ocp_write() short-circuits to -ENODEV, leaving a
registered netdev that cannot pass traffic until re-plug.  Would it make
sense for this path to propagate an error or queue a device reset?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917070637.62827-1-nic_swsd%40realtek.com
