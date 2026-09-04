Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55093DAAB0;
	Fri,  4 Sep 2026 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560725; cv=none; b=Oqx2xHNYLCYvXpA+3m+OhG+srAF6Iblef1RMkW9Q1S7tOAHlfITpLQSI78TLbEB4+F1cDeeNXnOwpTCmDm+yT5JysOGB/0KgvnQrZ4D2bRLOhNMicHyDr2ilTg6mJwQxHF4H/wUCHG5oiQMYHz/105YLNnRm1UOFxBVtsopNbD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560725; c=relaxed/simple;
	bh=xT/+lLNBqEtRs8d6hGhAFw33kWa1UGG+9w6sadFdcEI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wk9kCPOfWWKj/9ZoJP3kzSP5HsK9HzLKNSnYjx6c17Z+h5PXo8AewowzBuIqVQcoDC7LIHR8CqOWG53vT4MsBNVLU3YTXdmciRxcZD/gJMfHyoJkSH56H1zAcMiX+PSVrLsy7pA9iMq0hpg9RkNJhKwzjOt1Z9RYOB2w3MC2Esg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pqd49Usa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pqd49Usa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C511F00A3E;
	Fri,  4 Sep 2026 22:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560718;
	bh=8SdaT1Rre7irmny/AiKrmCEIXC/yaX1ZpzkqWVcM97Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Pqd49Usa8ZL/AWFoQiUmoy0K8Q5YWcQkIA8ZRN6TSCymoX6UN/dmbYJp650QbepTA
	 +iGqHgVxZjRjKEgBFc2qwA+IC2JjEUgTkmaXhjJuuDna5W6NoEwOx4Q/3bVKC80pd+
	 7c+za5SKIbew5FTTYUU8T3Myf6bLDZVNMpk4GZNr0NNtJ28TH3vs8zlHu2xIocEt8C
	 29ISlDJ5WsP6fclCmf+IwMo8DvwgyV1su/hco8fS5iNlcUub+Cv+iW+5NcKIVPWFkV
	 ZvEuNYUtKbevSDE7cGEcItQpawlpK5XhFhOwdkRm6IxnjlkoTTiUzvxl7Wt3GHlU1q
	 IIvG28Qi4ouAQ==
Subject:
 Re: [PATCH net-next v9 2/7] net: phy: phylink: add helper to modify pause
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, linux@armlinux.org.uk,
 enelsonmoore@gmail.com, daniel@thingy.jp
Date: Fri, 04 Sep 2026 22:25:16 +0000
Message-ID: <178856071681.219967.2291837962290089662@kernel.org>
In-Reply-To: <20260831053745.1197-3-javen_xu@realsil.com.cn>
References: <20260831053745.1197-3-javen_xu@realsil.com.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 6 · Low: 2

- [High] phylink_update_mac_pause_capabilities() destroys, rather than
  masks, the requested pause configuration, so the "pause capability…
- [Medium] phylink_update_mac_pause_capabilities() mutates the live
  pl->supported mask in place: it unconditionally sets Pause and…
- [Medium] phylink_update_mac_pause_capabilities() has no guaranteed way
  to re-program the MAC after a pause-capability change: it relies on…
- [Medium] phylink_update_mac_pause_capabilities() conveys the capability
  change only by writing pl->config->mac_capabilities (lines 1923-1924)…
- [Medium] In phylink_update_mac_pause_capabilities(), the asymmetric-
  request test is written as '(pause_state & MLO_PAUSE_RX) ^…
- [Medium] phylink_update_mac_pause_capabilities() treats an asymmetric-
  only MAC capability as if pause were entirely unsupported: the first…
- [Medium] phylink_update_mac_pause_capabilities() omits the MLO_AN_FIXED
  guard that phylink_ethtool_set_pauseparam() applies before reaching…
- [Low] phylink_update_mac_pause_capabilities() updates
  pl->config->mac_capabilities and pl->supported inside one…
- [Low] The commit message describes only the Realtek motivation ("when
  we enable jumbo, pause are not supported.

--

net: phy: phylink: add helper to modify pause

This patch factors the body of phylink_ethtool_set_pauseparam() out into a
new static helper phylink_update_pause_state(), and adds a new exported
core API, phylink_update_mac_pause_capabilities(), which lets a MAC driver
withdraw or restore MAC_SYM_PAUSE/MAC_ASYM_PAUSE at runtime.  The stated
motivation is Realtek hardware that cannot do flow control while jumbo
frames are enabled.

No Link: tags are present in the commit header.

>     For Realtek nics, when we enable jumbo, pause are not supported. So we
>     must check the pause capabilities from ourself and lp.

[Severity: Low]

Could the commit message describe what the patch does, in addition to why?

Two things happen here that a reader of the log would want to know about:
phylink_update_pause_state() is split out of the existing ethtool path as a
behaviour-preserving refactor, and a new exported core API,
phylink_update_mac_pause_capabilities(), is added which mutates the
driver-owned pl->config->mac_capabilities, the phylink supported mask and
pl->link_config.

The only caller is added later in the same series, in rtl8169_change_mtu(),
which is the usual API-then-user layout, so that part is fine.

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 3ec3bb439109..646b8e1e727b 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1829,6 +1829,126 @@ int phylink_set_fixed_link(struct phylink *pl,
>  }
>  EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
>  
> +/**
> + * phylink_update_pause_state() - Update the phylink pause frame configuration
> + * @pl: a pointer to a &struct phylink instance
> + * @pause_state: bitmask indicating the new pause state
> + *
> + * Update the MAC pause frame (flow control) state for the phylink instance.
> + */
> +static void phylink_update_pause_state(struct phylink *pl, int pause_state)
> +{
> +	struct phylink_link_state *config = &pl->link_config;
> +	bool tx_pause = !!(pause_state & MLO_PAUSE_TX);
> +	bool rx_pause = !!(pause_state & MLO_PAUSE_RX);
> +	bool manual_changed;
> +
> +	mutex_lock(&pl->state_mutex);
> +
> +	/*
> +	 * See the comments for linkmode_set_pause(), wrt the deficiencies
> +	 * with the current implementation.  A solution to this issue would
> +	 * be:
> +	 * ethtool  Local device
> +	 *  rx  tx  Pause AsymDir
> +	 *  0   0   0     0
> +	 *  1   0   1     1
> +	 *  0   1   0     1
> +	 *  1   1   1     1
> +	 * and then use the ethtool rx/tx enablement status to mask the
> +	 * rx/tx pause resolution.
> +	 */
> +	linkmode_set_pause(config->advertising, tx_pause,
> +			   rx_pause);
> +
> +	manual_changed = (config->pause ^ pause_state) & MLO_PAUSE_AN ||
> +			 (!(pause_state & MLO_PAUSE_AN) &&
> +			   (config->pause ^ pause_state) & MLO_PAUSE_TXRX_MASK);

[Severity: Medium]

This manual_changed test is the only thing that forces pl->link_failed and
phylink_run_resolve(), and it was written for the ethtool path where
MLO_PAUSE_AN can toggle.

When phylink_update_mac_pause_capabilities() calls in, only MLO_PAUSE_RX
and MLO_PAUSE_TX are ever cleared and MLO_PAUSE_AN never changes, so with
pause autoneg enabled (the phylink default, link_config.pause =
MLO_PAUSE_AN) manual_changed is false and no resolve is queued.

For an MLO_AN_INBAND SGMII setup with no phydev, is there anything left to
re-run mac_link_up()?  phylink_change_inband_advert() ends up in
phylink_mii_c22_pcs_encode_advertisement(), where the SGMII family has no
pause bits at all:

	case PHY_INTERFACE_MODE_SGMII:
	case PHY_INTERFACE_MODE_PSGMII:
	case PHY_INTERFACE_MODE_QSGMII:
		return 0x0001;

so pcs_config() reports no change, no AN restart happens and the link does
not cycle.  Does the MAC then keep the tx_pause/rx_pause programming from
the previous mac_link_up() call while phylink believes pause is
unsupported, which is the jumbo-plus-pause combination this series is
trying to avoid?  The capability-regained direction has the same gap, and
so does the PHY case when phydev->autoneg is clear, since
phy_set_asym_pause() only renegotiates when autoneg is set.

> +
> +	config->pause = pause_state;
> +
> +	/* Update our in-band advertisement, triggering a renegotiation if
> +	 * the advertisement changed.
> +	 */
> +	if (!pl->phydev)
> +		phylink_change_inband_advert(pl);
> +
> +	mutex_unlock(&pl->state_mutex);
> +
> +	/* If we have a PHY, a change of the pause frame advertisement will
> +	 * cause phylib to renegotiate (if AN is enabled) which will in turn
> +	 * call our phylink_phy_change() and trigger a resolve.  Note that
> +	 * we can't hold our state mutex while calling phy_set_asym_pause().
> +	 */
> +	if (pl->phydev)
> +		phy_set_asym_pause(pl->phydev, rx_pause, tx_pause);
> +
> +	/* If the manual pause settings changed, make sure we trigger a
> +	 * resolve to update their state; we can not guarantee that the
> +	 * link will cycle.
> +	 */
> +	if (manual_changed) {
> +		pl->link_failed = true;
> +		phylink_run_resolve(pl);
> +	}
> +}
> +
> +/**
> + * phylink_update_mac_pause_capabilities() - Dynamically update MAC pause
> + * @pl: a pointer to a &struct phylink returned from phylink_create()
> + * @mac_pause: the new MAC pause capabilities mask
> + *
> + * This function allows a MAC driver to dynamically change its pause state,
> + * such as losing/gaining Pause frame support based on MTU size.
> + * It recalculates supported link modes and triggers renegotiation if needed.
> + */
> +void phylink_update_mac_pause_capabilities(struct phylink *pl, unsigned long mac_pause)
> +{
> +	struct phylink_link_state *config = &pl->link_config;
> +	unsigned long old_pause;
> +	int pause_state;
> +
> +	ASSERT_RTNL();
> +
> +	if (mac_pause & ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE)) {
> +		phylink_err(pl, "Attempted to dynamically change non-pause MAC capabilities\n");
> +		return;
> +	}

[Severity: Medium]

The sibling entry point into the same (now shared) code guards it with:

phylink_ethtool_set_pauseparam()
	if (pl->req_link_an_mode == MLO_AN_FIXED)
		return -EOPNOTSUPP;

	if (!phylink_test(pl->supported, Pause) &&
	    !phylink_test(pl->supported, Asym_Pause))
		return -EOPNOTSUPP;

Should the new exported helper carry the MLO_AN_FIXED check too?  An MTU
change is independent of the AN mode, so a fixed-link MAC can reach here,
and phylink_update_pause_state() will then run
linkmode_set_pause(config->advertising, tx, rx) with tx/rx derived from
config->pause, which defaults to MLO_PAUSE_AN, i.e. false/false, clearing
ETHTOOL_LINK_MODE_Pause_BIT and Asym_Pause_BIT from
pl->link_config.advertising.

That mask is what fixed-link pause resolution consumes:

phylink_get_fixed_state()
	state->pause = MLO_PAUSE_NONE;
	phylink_resolve_an_pause(state);

with lp_advertising seeded from the DT properties in
phylink_parse_fixedlink():

	if (fwnode_property_read_bool(fixed_node, "pause"))
		__set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
			  pl->link_config.lp_advertising);

Can this silently disable the flow control described in firmware, with no
error returned to the caller since the helper is void?

> +
> +	old_pause = pl->config->mac_capabilities & (MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
> +	if (old_pause == mac_pause)
> +		return;
> +
> +	mutex_lock(&pl->state_mutex);
> +
> +	pl->config->mac_capabilities &= ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
> +	pl->config->mac_capabilities |= mac_pause;

[Severity: Medium]

Does writing config->mac_capabilities have any effect for a MAC that
implements mac_get_caps()?  phylink_validate_mac_and_pcs() prefers the
callback:

	if (pl->mac_ops->mac_get_caps)
		capabilities = pl->mac_ops->mac_get_caps(pl->config,
							 state->interface);
	else
		capabilities = pl->config->mac_capabilities;

and the mac_get_caps kernel-doc says config->mac_capabilities is only used
when the callback is absent.  stmmac_mac_get_caps() goes further and
overwrites the field the helper just wrote:

	config->mac_capabilities = priv->hw->link.caps;
	return priv->hw->link.caps;

For such a driver, would the phylink_test() checks below both still pass,
leaving pause_state unmasked while the advertisement is nevertheless
rewritten by phylink_update_pause_state()?  The helper is void and prints
no warning, so the driver cannot tell the update was a no-op.

Also, is the core expected to write into the driver-owned struct
phylink_config after phylink_create()?

> +
> +	phylink_set(pl->supported, Pause);
> +	phylink_set(pl->supported, Asym_Pause);
> +
> +	if (pl->phydev)
> +		linkmode_and(pl->supported, pl->supported, pl->phydev->supported);
> +	else if (pl->sfp_bus)
> +		linkmode_and(pl->supported, pl->supported, pl->sfp_support);
> +
> +	phylink_validate(pl, pl->supported, config);

[Severity: Medium]

Is it safe to force Pause and Asym_Pause into the live pl->supported mask
and then ignore the phylink_validate() return value?  The bits are only
removed again inside phylink_validate_mask_caps(), that is, on the success
path.

phylink_validate() has early returns that leave the caller's mask
untouched:

	if (!test_bit(state->interface, interfaces))
		return -EINVAL;

as do the mac_select_pcs() ERR_PTR, PCS interface mismatch and
pcs_validate() failures.  On those paths pl->supported keeps the
force-set Pause|Asym_Pause bits, so the phylink_test() checks just below
conclude pause is supported, the requested restriction is not applied and
ethtool keeps reporting pause the MAC has just declared unsupported.

Such a failure is reachable in exactly the case this API is for, since
phylink_get_capabilities() drops RATE_MATCH_PAUSE support when either
pause capability is missing:

		if (!(mac_capabilities & MAC_SYM_PAUSE) ||
		    !(mac_capabilities & MAC_ASYM_PAUSE))
			break;

On the state->interface == PHY_INTERFACE_MODE_NA path,
phylink_validate_mask() copies a possibly empty accumulator into supported
before returning -EINVAL, so can pl->supported end up empty and
pl->link_config.advertising rewritten, with no rollback and no way for the
void caller to notice?

Related question: every other phylink_validate*() call site validates into
a local mask, for example phylink_bringup_phy():

	ret = phylink_validate_phy(pl, phy, supported, &config);
	if (ret) { ... return ret; }

Validating here against the single pl->link_config.interface rather than
over phy->possible_interfaces or pl->sfp_interfaces looks like it would
permanently prune modes only reachable via other interface modes on c45
PHYs and multi-interface SFPs.  Is that intended?

> +
> +	pause_state = config->pause;

[Severity: High]

Does this destroy the requested pause configuration rather than mask it,
so that the capability-regained direction can never restore pause?

pause_state is read from config->pause, masked here, and then written back
into the same field by phylink_update_pause_state():

	linkmode_set_pause(config->advertising, tx_pause,
			   rx_pause);
	...
	config->pause = pause_state;
	...
	if (pl->phydev)
		phy_set_asym_pause(pl->phydev, rx_pause, tx_pause);

There is no saved copy of the original request, and the advertisement is
re-programmed from the masked value.

In the default configuration phylink_create() sets

	pl->link_config.pause = MLO_PAUSE_AN;

with no MLO_PAUSE_RX/MLO_PAUSE_TX, while phylink_bringup_phy() advertises
pause via phy_support_asym_pause() and copies those bits into
pl->link_config.advertising.  So even a call that grants
MAC_SYM_PAUSE|MAC_ASYM_PAUSE ends up running

	linkmode_set_pause(adv, false, false);
	phy_set_asym_pause(phydev, false, false);

and linkmode_set_pause() clears both bits for false/false:

	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT, advertisement, rx);
	linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, advertisement,
			 rx ^ tx);

With the r8169 caller added later in the series that gives:

	ip link set eth0 mtu 9000
	  rtl8169_change_mtu()
	    phylink_update_mac_pause_capabilities(pl, 0)
	      -> pause bits cleared in phydev->advertising
	ip link set eth0 mtu 1500
	  rtl8169_change_mtu()
	    phylink_update_mac_pause_capabilities(pl, MAC_SYM_PAUSE|MAC_ASYM_PAUSE)
	      -> pause_state is still MLO_PAUSE_AN, bits cleared again

Nothing re-runs phy_support_asym_pause() or otherwise re-seeds the
advertisement, so is flow control lost for good after the first
transition?  Would keeping the user request separately and masking it only
at resolve time avoid this?

> +
> +	if (!phylink_test(pl->supported, Pause)) {
> +		pause_state &= ~(MLO_PAUSE_RX | MLO_PAUSE_TX);

[Severity: Medium]

Should this branch also consider Asym_Pause?  MAC_ASYM_PAUSE is accepted
independently of MAC_SYM_PAUSE, and phylink_caps_to_linkmodes() sets only
ETHTOOL_LINK_MODE_Asym_Pause_BIT for it, so pl->supported can legitimately
hold Asym_Pause without Pause.

The capability table in include/linux/phylink.h documents tx-only pause as
valid in that state, and phylink_ethtool_set_pauseparam() allows it:

	if (!phylink_test(pl->supported, Pause) &&
	    !phylink_test(pl->supported, Asym_Pause))
		return -EOPNOTSUPP;

After phylink_update_mac_pause_capabilities(pl, MAC_ASYM_PAUSE), does an
existing tx-only setting get cleared here and then un-advertised by
phylink_update_pause_state(), even though the MAC still supports it?

> +	} else if (!phylink_test(pl->supported, Asym_Pause)) {
> +		if ((pause_state & MLO_PAUSE_RX) ^ (pause_state & MLO_PAUSE_TX))
> +			pause_state &= ~(MLO_PAUSE_RX | MLO_PAUSE_TX);

[Severity: Medium]

Does this XOR detect an asymmetric request?  MLO_PAUSE_RX and MLO_PAUSE_TX
are different bit positions:

	MLO_PAUSE_RX = BIT(0),
	MLO_PAUSE_TX = BIT(1),

so 0x1 ^ 0x2 == 0x3 and the condition is non-zero whenever either bit is
set, including the symmetric rx=1/tx=1 case.  It looks equivalent to
pause_state & MLO_PAUSE_TXRX_MASK, so after "ethtool -A eth0 rx on tx on"
a symmetric-pause-capable MAC would have flow control cleared entirely.

The peer check in phylink_ethtool_set_pauseparam() expresses the intended
rule as a plain comparison:

	if (!phylink_test(pl->supported, Asym_Pause) &&
	    pause->rx_pause != pause->tx_pause)
		return -EINVAL;

Would !!(pause_state & MLO_PAUSE_RX) != !!(pause_state & MLO_PAUSE_TX) be
what is wanted here?

> +	}
> +
> +	mutex_unlock(&pl->state_mutex);
> +
> +	phylink_update_pause_state(pl, pause_state);

[Severity: Low]

The capability update and the dependent pause state are committed in two
separate pl->state_mutex sections: mac_capabilities and pl->supported are
written above, the mutex is dropped here, and phylink_update_pause_state()
re-acquires it to publish link_config.pause and link_config.advertising.

phylink_resolve() runs from system_power_efficient_wq without RTNL and
takes pl->state_mutex, so it can run in that window and see pl->supported
already saying pause is unsupported while link_config.pause still has
MLO_PAUSE_RX|MLO_PAUSE_TX, then call mac_ops->mac_link_up() with pause
enabled.  The observed combination equals the pre-call state, so this is a
transient window rather than a lasting one, but would doing both updates
under a single acquisition be simpler to reason about?

> +}
> +EXPORT_SYMBOL_GPL(phylink_update_mac_pause_capabilities);
> +

[ ... ]

> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> index 1dda5c7ed5f1..3a88a69882a6 100644
> --- a/include/linux/phylink.h
> +++ b/include/linux/phylink.h
> @@ -843,4 +843,6 @@ void phylink_replay_link_begin(struct phylink *pl);
>  
>  void phylink_replay_link_end(struct phylink *pl);
>  
> +void phylink_update_mac_pause_capabilities(struct phylink *pl, unsigned long mac_pause);
> +
>  #endif

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831053745.1197-1-javen_xu%40realsil.com.cn
