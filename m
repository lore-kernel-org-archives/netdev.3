Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249819;
	b=UEw95ZXrsLgNtIH17HDuNNBBtyaberN4Gy446W1OCDLVgZcv1akm5hJ8w9k35I/knsnN
	 KGseor/udccIyUFIi5Bo4SEPkiAAxLkTrN2/0TlGYRXww70p0eQxkZMUe0NaU2H6dbmIj
	 jHEMoNkCDE4FX7+HKiFyMT6dACbBhkcpuIPm5W84YWOZNpT1wLdpmtfpySPPzjAMqgWFo
	 OS3CdFYgUWJXXMPgoR/etlASniTXZvNnTWMzVV6owp72X25r8jdpLqAFxpUJz3HCdrc9w
	 KqijJs5M+P3P0PZm1nGy9OD73hJvIhRSNiWBN8UGqj7MD7ebDTc1WZX01vYWQ+F+ldQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249819;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8HtWsqjdMoTX2Fb8l+C+eNfBcEvZQRDPyczvbpyW3w8=;
	b=ZvINBJbYfLDf3GjkthAiBWnT8hw3Ix6J770hd0bFrN5ep7PuknDmxjKwPcXBF2UxujV+
	 IxamJQZI9UcWLg9uuqDXJT+DirTzbQZyCWAB77ZvP+h/M/XpY64VWcoerYvaADLX4Sqq1
	 O1y4mI0X4xkh8cHI3xfBlGwUN8V91YqKhg1blM+mk8zkYAfrjZM07M3mbcsFSmct5m3LP
	 RW6+ztLwD8O1y/q4P9tlIc/Hd5Xbh2gXARJ5YGqDPI2EyBpI8azLP4C0o+XA7kTlqFUjx
	 MqrDOLetC4uqW0dsrsEPYfNrvYxL55AoOSIMTHFPutXvJkbR5IYJ6xjjsfg5n870A7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amHqmKjA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715AA606A325;
	Mon,  9 Nov 2026 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amHqmKjA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951041F0089F;
	Mon,  9 Nov 2026 18:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794249819;
	bh=8HtWsqjdMoTX2Fb8l+C+eNfBcEvZQRDPyczvbpyW3w8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=amHqmKjArB7VMndrMInbLpnsEXdyIskeI+FNQZrb6+DWVjfBWicKn/xjk3uxeBamP
	 o53f/stlG72bu9HdSY9ukjCl0x+m3e3nOtU0TaWBDzpBzkR8a0oqR+b3eRhqrkvVKm
	 Vjt7PU8tOYqi3qXZY1KVt2WObAv7aUIsf7eFWhVm7zf+vay6A1yqf2JOv/yrYsyZQJ
	 Kj6vjaTxHLN0S5dg54YNfzIuu4XgMAR+wXMWOkWKTzEmh2zafKxR3oRAhVEK5SFvlF
	 +CCRDmWYAd6zeDVTS2BNDhEyJThIid0KY1xJN4G7EolI4ylzE2vzWtoEaniOasm3eV
	 1FiWEUkLAYBQQ==
Subject: Re: [PATCH net-next] net: usb: lan78xx: use phylink for Wake-on-LAN
From: netdev-bot+sashiko@kernel.org
To: prashantsengar25031@gmail.com
Cc: netdev@vger.kernel.org, Thangaraj.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 linux-usb@vger.kernel.org, kuba@kernel.org
Date: Mon, 09 Nov 2026 18:43:38 +0000
Message-ID: <179424981810.994134.1872539285457359260@kernel.org>
In-Reply-To: <20261108180137.3488023-1-prashantsengar25031@gmail.com>
References: <20261108180137.3488023-1-prashantsengar25031@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Adding `.mac_wol_set` makes phylink_mac_supports_wol() true, so
  phylink_suspend() ignores the driver's `mac_wol=false` argument and…
- [Medium] This patch removes WAKE_PHY (`ethtool -s ethX wol p`) for
  lan78xx devices that have a PHY, and the commit message does not…
- [Medium] The commit message says probe 'preserves' the default magic-
  packet configuration, but the behaviour changes.
- [Low] `pdata->wol` has writers that disagree on what it means.
- [Low] If phylink_ethtool_set_wol() fails in lan78xx_probe(), for
  example because an external PHY's set_wol returns an error other than…

--

net: usb: lan78xx: use phylink for Wake-on-LAN

This patch moves the lan78xx ethtool WoL handlers to
phylink_ethtool_get_wol() and phylink_ethtool_set_wol(). It adds a
mac_wol_set callback and advertises MAC wake modes through
phylink_config. At probe, it now sends a default WAKE_MAGIC configuration
through phylink and sets netdev->ethtool->wol_enabled.

> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index d73002b2c21ac..7d67dd150271b 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c

[ ... ]

> @@ -2617,12 +2629,24 @@ static int lan78xx_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
>  	return lan78xx_mac_eee_enable(dev, true);
>  }
>  
> +static int lan78xx_mac_wol_set(struct phylink_config *config,
> +			       u32 wolopts, const u8 *sopass)
> +{
> +	struct lan78xx_net *dev = netdev_priv(to_net_dev(config->dev));
> +	struct lan78xx_priv *pdata = (struct lan78xx_priv *)dev->data[0];
> +
> +	pdata->wol = wolopts;

[Severity: Low]
What is pdata->wol supposed to hold? The mac_wol_set kernel-doc in
include/linux/phylink.h says options the PHY can handle will already have
been removed from wolopts, so this stores the MAC-only set.

Both callers of phylink_ethtool_set_wol() overwrite pdata->wol right
afterwards with the merged PHY+MAC set:

lan78xx_set_wol() {
    ...
	ret = phylink_ethtool_set_wol(dev->phylink, wol);
	...
	phylink_ethtool_get_wol(dev->phylink, &actual);
	pdata->wol = actual.wolopts;
}

and phylink_ethtool_get_wol() does:

	wol->wolopts |= pl->wolopts_mac;

So is this store always dead?

lan78xx_suspend() passes the merged value to lan78xx_set_suspend().
phylink_suspend() decides from the MAC-only set instead:

	mac_wol = !!pl->wolopts_mac;

Take an external PHY on LAN7801 whose driver implements get_wol and
handles WAKE_MAGIC. There, wolopts_mac would be 0, so phylink calls
phylink_stop(), and lan78xx_mac_link_down() stops RX/TX and resets the
MAC.

The driver would still arm MAC magic-packet detection (WUCSR_MPEN_,
SUS_MODE_3) for a mode the PHY handles. It also would not set
PMT_CTL_PHY_WAKE_EN_ to pass on the PHY's wake.

Can the driver and phylink end up disagreeing about who handles WoL and
whether the MAC needs to keep receiving?

> +
> +	return 0;
> +}
> +
>  static const struct phylink_mac_ops lan78xx_phylink_mac_ops = {
>  	.mac_config = lan78xx_mac_config,
>  	.mac_link_down = lan78xx_mac_link_down,
>  	.mac_link_up = lan78xx_mac_link_up,
>  	.mac_disable_tx_lpi = lan78xx_mac_disable_tx_lpi,
>  	.mac_enable_tx_lpi = lan78xx_mac_enable_tx_lpi,
> +	.mac_wol_set = lan78xx_mac_wol_set,

[Severity: High]
Does setting mac_wol_set leave the link permanently down after a normal
system resume?

With mac_wol_set set, phylink_mac_supports_wol() returns true, and
phylink_suspend() ignores the mac_wol argument from the driver:

phylink_suspend() {
	...
	if (phylink_mac_supports_wol(pl))
		mac_wol = !!pl->wolopts_mac;

	if (mac_wol && (!pl->netdev || pl->netdev->ethtool->wol_enabled)) {
		...
		__set_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state);
	...
}

By default, the new probe code sets pl->wolopts_mac = WAKE_MAGIC (lan88xx
has no get_wol, so all of it goes to the MAC) and sets wol_enabled to
true.

So with the interface open, every system suspend through
lan78xx_suspend()->phylink_suspend(dev->phylink, false) takes this
branch. It sets PHYLINK_DISABLE_MAC_WOL and turns carrier off, but does
not stop phylink or phylib.

Only phylink_resume() clears that bit, and lan78xx calls it only from
lan78xx_reset_resume(). lan78xx_resume() is used when the device keeps
power across sleep, and it has no phylink call.

After that, phylink_resolve() sees a non-zero phylink_disable_state and
forces the link down:

	if (pl->phylink_disable_state) {
		pl->link_failed = false;
		link_state = pl->link_config;
		link_state.link = false;

Before this patch, ip link set down/up recovered from this state, because
phylink_stop() sets STOPPED and phylink_start() clears it. phylink_start()
only clears PHYLINK_DISABLE_STOPPED, so the MAC_WOL bit now survives
ifdown/ifup and ethtool wol d.

Won't the interface stay without carrier until a reset_resume or a driver
rebind?

On the reset_resume path, lan78xx_reset() hard-resets the PHY through
PMT_CTL_PHY_RST_. Before, phylink_resume()->phylink_start()->phy_start()
brought phylib back up and re-ran aneg configuration.

Now phylink_resume() takes the MAC-WoL branch (mac_initial_config plus a
re-resolve). phylib was never halted, so it doesn't reprogram the freshly
reset PHY.

Are user-configured advertisement or forced link modes lost in that case?

Runtime autosuspend doesn't trigger this, since lan78xx_open() holds a
usb_autopm reference until lan78xx_stop(). The system suspend path alone
is enough.

>  };

[ ... ]

> @@ -2848,6 +2872,10 @@ static int lan78xx_phylink_setup(struct lan78xx_net *dev)
>  	       dev->phylink_config.supported_interfaces,
>  	       sizeof(dev->phylink_config.lpi_interfaces));
>  
> +	pc->wol_mac_support = WAKE_MAGIC | WAKE_UCAST | WAKE_BCAST |
> +		      WAKE_MCAST | WAKE_ARP;

[Severity: Medium]
Is WAKE_PHY meant to be left out here? The driver still includes WAKE_PHY
in WAKE_ALL, and lan78xx_set_suspend() still handles it:

	if (wol & WAKE_PHY) {
		temp_pmt_ctl |= PMT_CTL_PHY_WAKE_EN_;

Before the patch, lan78xx_get_wol() reported supported = WAKE_ALL. Now
the supported mask comes from phylink_ethtool_get_wol(), which is the PHY
driver's get_wol result OR'd with wol_mac_support.

The internal PHY uses the lan88xx driver in drivers/net/phy/microchip.c.
It has set_wol but no get_wol, so it adds nothing, and WAKE_PHY is never
advertised.

ethnl_set_wol() then rejects it:

	if (wol.wolopts & ~wol.supported) {

The new wol->wolopts & ~actual.supported check in lan78xx_set_wol() also
rejects it with -EINVAL.

So ethtool -s ethX wol p, wol pg, and systemd-networkd WakeOnLan=phy all
worked before and now fail. The PMT_CTL_PHY_WAKE_EN_ path in
lan78xx_set_suspend() can no longer be reached.

The commit message doesn't mention this change. The PHY-less LAN7801
testing wouldn't exercise this path.

Should WAKE_PHY be added to wol_mac_support, since the MAC implements it?

> +	pc->wol_phy_legacy = true;
> +

[ ... ]

> @@ -4803,6 +4835,24 @@ static int lan78xx_probe(struct usb_interface *intf,
>  	if (ret < 0)
>  		goto free_urbs;
>  
> +	/* Preserve the default magic-packet wakeup configuration. */
> +	rtnl_lock();
> +
> +	ret = phylink_ethtool_set_wol(dev->phylink, &wol);
> +	if (!ret) {
> +		struct lan78xx_priv *pdata = (struct lan78xx_priv *)dev->data[0];
> +
> +		wol.cmd = ETHTOOL_GWOL;
> +		phylink_ethtool_get_wol(dev->phylink, &wol);
> +		pdata->wol = wol.wolopts;
> +		netdev->ethtool->wol_enabled = !!wol.wolopts;

[Severity: Medium]
The commit message says:

  Preserve the default magic-packet wakeup configuration

Does this code change the default PHY power behaviour, though?

Before the patch, lan78xx_bind() only set pdata->wol = WAKE_MAGIC. The
PHY was never told about WoL, and netdev->ethtool->wol_enabled stayed
false.

With wol_phy_legacy = true, phylink_phy_supports_wol() returns true
whenever a phydev is attached, so this call reaches
phy_ethtool_set_wol(). lan88xx_set_wol() then sets
priv->wolopts = WAKE_MAGIC, and external PHYs on LAN7801 get their WoL
hardware programmed.

With wol_enabled forced to true, phy_suspend() returns -EBUSY:

	phydev->wol_enabled = phy_may_wakeup(phydev) ||
			      (netdev && netdev->ethtool->wol_enabled);
	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
		return -EBUSY;

and lan88xx_suspend() skips genphy_suspend() while priv->wolopts is set:

	if (!priv->wolopts)
		genphy_suspend(phydev);

So the PHY would no longer be powered down when
phylink_stop()->phy_stop() halts it, including on a plain ip link set
down. In that case the !dev_open branch of lan78xx_suspend() disables all
wake sources anyway, so keeping the PHY powered doesn't seem to help.

Is this new default intended for every lan78xx device with a PHY?

> +	}
> +
> +	rtnl_unlock();
> +
> +	if (ret)
> +		netdev_warn(netdev, "failed to initialize WoL: %d\n", ret);

[Severity: Low]
What happens to pdata->wol if phylink_ethtool_set_wol() fails here? One
example is an external PHY on LAN7801 whose set_wol returns an error
other than -EOPNOTSUPP, such as an MDIO or USB control transfer failure.

pdata->wol keeps the WAKE_MAGIC value set in lan78xx_bind(). Meanwhile
pl->wolopts_mac stays 0 and netdev->ethtool->wol_enabled stays false.

lan78xx_get_wol() would then report no active WoL through phylink, but
lan78xx_suspend() still does:

	ret = lan78xx_set_suspend(dev, pdata->wol);

and arms magic-packet wake (WUCSR_MPEN_).

Should pdata->wol be reset on this failure path so it matches what
phylink reports? This can't happen with the internal lan88xx PHY, whose
set_wol always returns 0.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108180137.3488023-1-prashantsengar25031%40gmail.com
