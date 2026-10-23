Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746251;
	b=Zx3Ig+82583yAFGcM80Sn0xr4uDAKjIED3cyNqTMc0d0I+H8ChYaFxnBCbgUDt6SAZIM
	 hUv7TBhjDEn7iO4DuD1vyHUCY32uIA244tvl0kxO4lzN4Ut6YEJdWOA9vLXJBF0b5MWcl
	 ugSFmpuSp6Yt80bwbcIEOdZQvicKMNoWoms4gQ20fjnLTobHEvg055w3f++Y4e8qTg7+B
	 hn8win69wju1zcMEa/wOA9hTUdBhuXGsupqhzN0cPBuYC3PCTApaT5TBR9Qgyg5b9yTBX
	 tZZO+K6bCX3bkhpBwbumqhOaUC9Xsf3IIz8TqWPrJ45KKW6mBjjlvgpi3GCwudh4AsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746251;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7v8wKhNfLWz/5275Zsjz7zNJ6v9XfFJf5zvD74gehpA=;
	b=w4ygdzU/Q4dsY7nTQVUvlH5mwEHGu6EBpb3tBmGOUvBTKdKu+n6cemKFjI8efWQX9be2
	 tnoCiEWCbtl7oPfePJPfveh+wDc/bBZGBB/zcH5lbYVrae7D5H4NepBUlgZzOFMxXZdAM
	 4lhyiSpeXVV+gKjKmVyMkLhO0pmjDlHsE+jLauBen1BtyjDM7E8p1k7c+S0VoNcixJjJq
	 sEA6cTy/LL5laetvh1fKUWfS7+GVGnyOPvZQpTJT67XFdam/FZO+DXc/OdWBQBW83RLt0
	 lEk/cuy6nVRt2lkAnAWsma0qSkC9mb8noQD/P9cm5u8bks7KSuL/cF3FMGcClBJ6rkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T86VNcqa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0389606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T86VNcqa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836521F01825;
	Fri, 23 Oct 2026 09:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792746250;
	bh=7v8wKhNfLWz/5275Zsjz7zNJ6v9XfFJf5zvD74gehpA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T86VNcqa5YVjQn2iY8LfJSXVJET2wQdUhnrMffmh7QYL8PO/DHWfHFs/DPwrKR4F9
	 knrRez9Gp//+F7oPjDb55KBiim0zzcGGQUTW7QE3X1hUHv6gqgbnTDLj/IwmdgaICR
	 Ubt6KyjK2NIYnS28vAh3ss2FwtsjwgfwK+kn/AGt6USbVAtI02X/oq7RfEuccE6Krs
	 VP1gCtiXaosf9pfk3tqX+9lLVJZ04fQLPUjoYfSL70TXdx2SjMSUJ9KLIlrNAAaji2
	 7qYNZaJ8OrU0wJQs5u3wOIAINolyKNckbHTEOaroS1m0DoS7qAMJ0ai/rjEr6MIlsn
	 i2wWCXxxkMizQ==
Subject: Re: [PATCH net v3 2/3] net: txgbe: keep MAC enabled for SP devices
 that support NCSI
From: netdev-bot+sashiko@kernel.org
To: jiawenwu@trustnetic.com
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, jacob.e.keller@intel.com, kees@kernel.org,
 zhaochenguang@kylinos.cn, maxime.chevallier@bootlin.com,
 aleksandr.loktionov@intel.com, u.kleine-koenig@baylibre.com,
 rmk+kernel@armlinux.org.uk, maciej.fijalkowski@intel.com, horms@kernel.org
Date: Fri, 23 Oct 2026 09:04:09 +0000
Message-ID: <179274624909.3134.8154533861591358950@kernel.org>
In-Reply-To: <20261020060107.25636-3-jiawenwu@trustnetic.com>
References: <20261020060107.25636-3-jiawenwu@trustnetic.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The NCSI TX_DISABLE override only covers
  txgbe_gpio_direction_out().
- [Medium] net: txgbe: TX_DISABLE asserted on NCSI devices during
  phylink_start()
- [Low] The new GPIO clamp in txgbe_gpio_direction_out() uses
  WX_STATE_DOWN as a stand-in for 'host interface down and phylink/SFP…

--

net: txgbe: keep MAC enabled for SP devices that support NCSI

On NCSI-capable SP devices, this commit keeps MAC Tx enabled. It skips the
Tx disable in txgbe_mac_link_down() and turns Tx back on in
txgbe_mac_finish(). It also makes txgbe_gpio_direction_out() ignore
requests to assert TX_DISABLE (GPIO1) while WX_STATE_DOWN is set, so the
optical transmitter stays on while the host interface is down.

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> index dc9f24314658..589ad5d2f17b 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c

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
Does phylink_start() drive TX_DISABLE before the SFP state machine
knows the upstream is up?

txgbe_up_complete() clears WX_STATE_DOWN first and then calls
phylink_start(). Inside phylink_start(), phylink_mac_initial_config()
runs before sfp_upstream_start():

drivers/net/phy/phylink.c:phylink_start() {
    ...
	phylink_mac_initial_config(pl, true);
    ...
	if (pl->sfp_bus)
		sfp_upstream_start(pl->sfp_bus);
    ...
}

phylink_mac_initial_config() goes through phylink_major_config(). For
interfaces with a signal rate, such as 10GBASE-R, 1000BASE-X and SGMII,
that calls sfp_upstream_set_signal_rate(). The call chain is then
sfp_set_signal_rate() -> sfp_mod_state() -> sfp_set_state() ->
sfp_gpio_set_state().

sfp_gpio_set_state() re-drives TX_DISABLE from all of sfp->state, not
just from RS0/RS1. At this point sfp->state still has SFP_F_TX_DISABLE
set, either from sfp_probe() or from the last phylink_stop(). So
gpiod_direction_output() is called with 1 for GPIO1.

WX_STATE_DOWN is already clear by then, so txgbe_gpio_direction_out()
no longer overrides the value. The optical transmitter is switched off.

If the module is in SFP_MOD_PRESENT, sfp_upstream_start() deasserts
TX_DISABLE again shortly afterwards via sfp_module_tx_enable(). That
still leaves a TX_DISABLE pulse on every ifup and every
txgbe_reinit_locked(), which drops the NCSI link each time.

The module may not have reached SFP_MOD_PRESENT yet. Examples are the
T_SERIAL wait in SFP_MOD_PROBE after probe, or SFP_MOD_ERROR. In that
case sfp_sm_main() stays in SFP_S_DOWN and never calls
sfp_module_tx_enable(), so TX_DISABLE stays asserted in hardware.

The interface could also be brought down again before the module comes
up. Nothing would then drive the line low, because the new check only
filters later writes.

The commit message says the SFP state machine "stays in SFP_S_DOWN
until the upstream is started again and then deasserts TX_DISABLE
itself". On this path the line is asserted before the state machine
gets that chance.

Could the override be keyed on something that stays set until
sfp_upstream_start() has run, instead of WX_STATE_DOWN? Or is there
another way to keep the NCSI transmitter enabled across
phylink_start()?

[Severity: High]
Is the direction_input path covered too? txgbe_gpio_direction_in() has no
matching check, and it still turns GPIO1 into an input:

drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c:txgbe_gpio_direction_in() {
    ...
	wr32m(wx, WX_GPIO_DDR, BIT(offset), 0);
    ...
}

The SFP core releases TX_DISABLE to an input whenever the module is not
present:

drivers/net/phy/sfp.c:sfp_gpio_set_state() {
	if (state & SFP_F_PRESENT)
		/* If the module is present, drive the requested signals */
		drive = sfp->state_hw_drive;
	else
		/* Otherwise, let them float to the pull-ups */
		drive = 0;

	if (sfp->gpio[GPIO_TX_DISABLE]) {
		if (drive & SFP_F_TX_DISABLE)
			gpiod_direction_output(sfp->gpio[GPIO_TX_DISABLE],
					       state & SFP_F_TX_DISABLE);
		else
			gpiod_direction_input(sfp->gpio[GPIO_TX_DISABLE]);
	}
    ...
}

This happens in sfp_probe() when no module is inserted. It also happens in
sfp_sm_main() when a module is removed while the upstream is up. The line
then floats to the module's TX_DISABLE pull-up, which keeps the
transmitter off.

Suppose a module is then inserted while the NCSI host interface is down.
Does anything drive the line again?

  sfp_check_state() only raises SFP_E_INSERT.
  sfp_sm_main() stays in SFP_S_DOWN because sm_dev_state != SFP_DEV_UP.
  phylink_sfp_set_config() skips phylink_mac_initial_config() while
  PHYLINK_DISABLE_STOPPED is set, so sfp_mod_state() never re-drives the
  GPIOs.

The first write that drives TX_DISABLE again seems to be
sfp_module_tx_enable(), which only runs once the host brings the interface
up. Until then the NCSI optical link can't transmit. On this path, "Keep
TX_DISABLE deasserted while an NCSI host interface is down" doesn't seem
to hold.

Could txgbe_gpio_direction_in() handle offset 1 under the same
ncsi_enabled && WX_STATE_DOWN condition, for example by driving it low as
an output? Or is there another way to make sure the pin stays driven low
on NCSI devices while down?

[Severity: Low]
The commit message says:

  WX_STATE_DOWN is set before phylink_stop() in txgbe_down() and cleared
  before phylink_start() in txgbe_up_complete(), so requests made while
  the interface is up, including TX fault recovery, still reach the
  hardware.

Is txgbe_down() the only place that sets WX_STATE_DOWN?
wx_soft_quiesce() also sets it while the interface is running, and it
never calls phylink_stop():

drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_soft_quiesce() {
	if (!netif_running(wx->netdev) ||
	    test_and_set_bit(WX_STATE_DOWN, wx->state))
		return;
    ...
}

wx_io_error_detected() calls it. So does wx_reset_task(), when
wx_tx_timeout() has found a PCIe error:

drivers/net/ethernet/wangxun/libwx/wx_err.c:wx_reset_task() {
    ...
		if (wx_check_pcie_error(wx))
			wx_soft_quiesce(wx);
		else
			clear_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
    ...
}

If the PCIe error later clears, WX_FLAG_NEED_PCIE_RECOVERY is cleared.
WX_STATE_DOWN stays set, though, while phylink and the SFP state machine
keep running.

If the module reports a TX fault in that window,
sfp_module_tx_fault_reset() does:

	sfp_set_state(sfp, state | SFP_F_TX_DISABLE);

	udelay(T_RESET_US);

	sfp_set_state(sfp, state);

Would the new check in txgbe_gpio_direction_out() force that assert pulse
to 0? If so, the fault reset never reaches the module, and the SFP core
keeps retrying until it reports a persistent fault.

This needs an NCSI device, a PCIe error and an SFP TX fault at the same
time, so the window is narrow. Still, the reasoning in the commit message
doesn't cover this path.

>  	set = val ? BIT(offset) : 0;
>  
>  	raw_spin_lock_irqsave(&wx->gpio_lock, flags);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020060107.25636-1-jiawenwu%40trustnetic.com
