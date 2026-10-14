Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F378B547069
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946751; cv=none; b=ZfSh9PS5J2LTlcVw85mkwKnbHJo4Yv0H3g/otAT3iKMWnuER2xKgP9JcsfmfM2ryH3k5XuGcNbEi5cYIJGDemDLmY/R2++QEdSVOt83FIZt+54B3gvqIFIO4wN9ueXGcLNtE6nBcKY68UW25IkmXbG+A44NkL9pAuCvKOwXjNq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946751; c=relaxed/simple;
	bh=EigibZz81NbVVMQ0Yqupa/0hQKWQEQSbPgTL2jdzwNs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cU318ujAHc79s8qyrT/qqiJOX46I0AT+Gf3QEnMck3E1kKpXBBDl+Q5JYz7wR/yJCu8fu/HAKDud49h1chCfuSU75gYUJXwFfVQEyMXrQWTkKn1Rj6iODonrJadr7+l7yddi6/kX5jAIDOzvNMptSdl0w2tXVyP2FK1QgD7hVQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr/ZXKa0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr/ZXKa0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772551F00893;
	Wed, 14 Oct 2026 02:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791946749;
	bh=SjFAN0+l8sfrlhLaRSCgQ4atqblOrR3fSR+G29Huhgo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Nr/ZXKa006pa4U8PHYn8ssfDvK/xtrMUyYfmCHxA9XVVrCFmzL0Q4a+o14Qf6q312
	 /KJ37QyN/biIck+PjbB8i+sk9aGyUlNP4jaB0rGdsPIPoMF2PFMH4Fg2rsU0WAwikv
	 UXxgXPBOy9LyX31Ri8NMsxLF4mq6Pvq84JCK8rkyaghuokojyFlxZDLZXVUljM1l+6
	 9z/68jhPSB0nU0YnFBXlQumh1NZSU253MzQt/RIG0caX3QODPvnl8NSnVk6NzR92LF
	 +JzeqGEAbTbXJaQXt4C8PX34GFZF9ZvtAMNHJ6v/hPX3M2E8zgEOFr7crFEWSFzley
	 GupycqNPbxYlw==
Subject: Re: [PATCH net v3 2/3] net: txgbe: keep MAC enabled for SP devices
 that support NCSI
From: netdev-bot+sashiko@kernel.org
To: jiawenwu@trustnetic.com
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, jacob.e.keller@intel.com, kees@kernel.org,
 zhaochenguang@kylinos.cn, aleksandr.loktionov@intel.com,
 u.kleine-koenig@baylibre.com, rmk+kernel@armlinux.org.uk,
 maciej.fijalkowski@intel.com, horms@kernel.org
Date: Wed, 14 Oct 2026 02:59:07 +0000
Message-ID: <179194674799.434549.14142520027947482426@kernel.org>
In-Reply-To: <20261013020626.5548-4-jiawenwu@trustnetic.com>
References: <20261013020626.5548-4-jiawenwu@trustnetic.com>
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

- [High] The three new NCSI branches in txgbe_phy.c never take effect,
  because the txgbe driver never sets wx->ncsi_enabled.
- [Medium] The NCSI override in txgbe_gpio_direction_out() changes only
  direction_output requests.

--

net: txgbe: keep MAC enabled for SP devices that support NCSI

This patch tries to keep MAC Tx enabled on NCSI-capable SP devices. It
skips the TE clear in txgbe_mac_link_down() and re-enables TE in
txgbe_mac_finish(). It also makes txgbe_gpio_direction_out() ignore
requests to assert TX_DISABLE while WX_STATE_DOWN is set on an NCSI device.

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> index dc9f243146580..589ad5d2f17b3 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> @@ -182,7 +182,8 @@ static void txgbe_mac_link_down(struct phylink_config *config,
>  {
>  	struct wx *wx = phylink_to_wx(config);
>  
> -	wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
> +	if (!wx->ncsi_enabled)
> +		wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);

[Severity: High]
Is wx->ncsi_enabled ever set for txgbe devices? The only code in the
wangxun tree that writes it seems to be ngbe_init_type_code():

drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:ngbe_init_type_code() {
    ...
	wx->ncsi_enabled = (ncsi_mask == WX_NCSI_SUP ||
			   type_mask == NGBE_SUBID_OCP_CARD) ? 1 : 0;
    ...
}

txgbe_init_type_code(), txgbe_sw_init() and wx_sw_init() do not appear to
set it. That would leave it at zero from the netdev private allocation.

If so, none of the three new branches in this patch would ever take
effect. On an NCSI SP device, ifdown goes through:

txgbe_close()
  txgbe_down()
    txgbe_disable_device()   <- leaves TE set (subsystem_device_id check)
    phylink_stop()
      txgbe_mac_link_down()  <- !wx->ncsi_enabled is true, TE cleared
      sfp_upstream_stop()
        txgbe_gpio_direction_out()  <- override false, GPIO1 driven high

The TE re-enable in txgbe_mac_finish() would not run either. Would MAC Tx
and the optical transmitter still be turned off while the host interface
is down, just as they were before this patch?

On the same down path, txgbe_disable_device() already uses a different
test for the same TE bit:

drivers/net/ethernet/wangxun/txgbe/txgbe_main.c:txgbe_disable_device() {
    ...
	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
    ...
}

The parent commit "net: libwx: keep NGBE OCP cards MAC enabled" also says
that "'wx->ncsi_enabled' ... is not assigned in TXGBE".

The later patch in this series, "net: txgbe: keep MAC enabled for AML
devices that support NCSI", does not set it either. Its new checks in
txgbe_aml.c and txgbe_down() depend on the same flag.

Could wx->ncsi_enabled be set in txgbe_init_type_code() or txgbe_sw_init()
before phylink and the SFP/GPIO devices are created? The other option is
for these checks to use the subsystem ID test, as txgbe_disable_device()
does.

[ ... ]

> @@ -368,6 +373,11 @@ static int txgbe_gpio_direction_out(struct gpio_chip *chip, unsigned int offset,
>  	unsigned long flags;
>  	u32 set;
>  
> +	/* Keep the NCSI transmitter enabled while the host interface is down. */
> +	if (wx->ncsi_enabled && BIT(offset) == TXGBE_GPIOBIT_1 &&
> +	    test_bit(WX_STATE_DOWN, wx->state))
> +		val = 0;
> +

[Severity: Medium]
Suppose wx->ncsi_enabled is set. Does this override cover the case where
the SFP core releases TX_DISABLE to an input instead of driving it?

When no module is present, sfp_gpio_set_state() in drivers/net/phy/sfp.c
does this:

	if (state & SFP_F_PRESENT)
		drive = sfp->state_hw_drive;
	else
		/* Otherwise, let them float to the pull-ups */
		drive = 0;
	...
			gpiod_direction_input(sfp->gpio[GPIO_TX_DISABLE]);

That call reaches txgbe_gpio_direction_in(), which has no NCSI handling:

	wr32m(wx, WX_GPIO_DDR, BIT(offset), 0);

This happens in sfp_probe() when the cage is empty. It also happens when a
module is removed while the SFP state machine is not in SFP_S_DOWN.

Now suppose a module is inserted while the host interface is down.
sfp_check_state() only raises SFP_E_INSERT, and sfp_sm_main() stays in
SFP_S_DOWN because the upstream is not up. No direction_output call is
made, so this override never runs and the pin stays an input.

The SFP MSA requires a pull-up on TX_DISABLE inside the module. With that
pull-up, TX_DISABLE would read high and the laser would stay off until the
interface comes up.

Doesn't that contradict this part of the commit message: "Keep TX_DISABLE
deasserted while an NCSI host interface is down"?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013020626.5548-2-jiawenwu%40trustnetic.com
