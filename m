Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690752E058;
	Fri,  4 Sep 2026 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560727; cv=none; b=NbVkuIeEJSQakKQrT9Ab5aGw66fXbE5t6GPO2cceJ0jExxV7jr0NQOWFVXvaVxdZYXOEVFBL/Rwc+uJ1eUuMuAtdN4W8FNNPCxRGSulCh3bvspN5+hZELZzyic9RMBudByieh3ogSW1X4wf9qMRO0ddMcoF/kQtbWQNm6xmKkdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560727; c=relaxed/simple;
	bh=ynTzEUxDVnlr+inLnm3SpYhbUtpB4i84+NZrVpXDTns=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HXs1CCsDehB8VqRFJKpPG+ThbHc0SpfqZjpGjbVx3gJOZ6qbOxRJz+JBGz7TIfSooTNV/fzWcEOJSH6Zj2k+fQYDagEh+Ss5JmX2l2EGAuWZC5WZafK/xodWj8HELzir3b6pLZVUdLVBlJTAW/CaViXphSKf8M4Yepy4VijnlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPfvqHHi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPfvqHHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04C91F00A3F;
	Fri,  4 Sep 2026 22:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560719;
	bh=ZwVoFYjvGLPWVxMIzhlUfw4s2X+4tQ5xY+uVf4n+yp0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TPfvqHHiHFjD1FYNcY7OFZnNATQfwndxqZienwAL8KQYm4sdDqrUBveNJpATrW+SK
	 nyb6Drzzxut/t+OJOIIitcxdKJt4hD5OD+IV90vcAM/R+ggIP3SdEx9kCg1ZO4Atca
	 gHHgWBSGn6o1fWDLxWtiLxXQOdvJuevbIObriJktHTUneG4EMAipg5ioagJlBXu82s
	 njkIEdyd5Y/5qjKZGQuwseE31K1dcS+V10lG0nkKaEH5jHIJgSwrkvsbbRD0VK4YgE
	 D2hsJovnq89GSPuXxUsNv/gifyVPcL5Kxa6aSauVanz9sHqM478UDVH64xeJeV6d5H
	 /R0AUYe8qlMvQ==
Subject: Re: [PATCH net-next v9 3/7] r8169: add support for phylink
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, linux@armlinux.org.uk,
 enelsonmoore@gmail.com, daniel@thingy.jp
Date: Fri, 04 Sep 2026 22:25:18 +0000
Message-ID: <178856071821.219967.8296442995006284050@kernel.org>
In-Reply-To: <20260831053745.1197-4-javen_xu@realsil.com.cn>
References: <20260831053745.1197-4-javen_xu@realsil.com.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 3 (1) · Low: 1

- [High] PM paths no longer stop/start the link state machine.
- [Medium] The commit message ("Transfer old framework to phylink...")
  does not mention the uAPI-visible behaviour changes the patch makes.
- [Medium] MAC Tx LPI (EEE) is silently disabled by default.
- [Medium] PHY-backed ethtool operations now fail or silently lose
  changes while the interface is down.
- [Low] Reported concern (assessed as resolved later in the series): at
  this commit the stated motivation ("Phylink can support fiber mode…

Pre-existing issues:
- [Medium] Reported concern (assessed as pre-existing and Medium,
  therefore discarded): rtl_mac_enable_tx_lpi() accepts phylink's…

--

r8169: add support for phylink

This converts r8169 from direct phylib use to phylink, adding a
phylink_config plus mac_link_up/mac_link_down/mac_config and Tx LPI
callbacks, and routes the ethtool link, pause and EEE operations through
phylink.  A few questions below about the PM paths, the EEE defaults and
the ethtool behaviour changes.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index c60710f9bd21..823763e4f445 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -2253,7 +2256,7 @@ static int rtl8169_get_eee(struct net_device *dev, struct ethtool_keee *data)
>  	if (!rtl_supports_eee(tp))
>  		return -EOPNOTSUPP;
>  
> -	ret = phy_ethtool_get_eee(tp->phydev, data);
> +	ret = phylink_ethtool_get_eee(tp->phylink, data);
>  	if (ret)
>  		return ret;
>  
> @@ -2269,7 +2272,7 @@ static int rtl8169_set_eee(struct net_device *dev, struct ethtool_keee *data)
>  	if (!rtl_supports_eee(tp))
>  		return -EOPNOTSUPP;
>  
> -	return phy_ethtool_set_eee(tp->phydev, data);
> +	return phylink_ethtool_set_eee(tp->phylink, data);
>  }

[Severity: Medium]

Do these two callbacks still work while the interface is down?  tp->phydev
exists from probe onwards, but pl->phydev is only populated by
phylink_connect_phy() in rtl_open() and is cleared again by
phylink_disconnect_phy() in rtl8169_close().

phylink_ethtool_get_eee() leaves the return value at its initial value when
no PHY is attached:

drivers/net/phy/phylink.c:phylink_ethtool_get_eee() {
	int ret = -EOPNOTSUPP;
	...
	if (pl->phydev) {
		ret = phy_ethtool_get_eee(pl->phydev, eee);
	...
}

So after "ip link set ethX down", does "ethtool --show-eee ethX" (and
--set-eee) now return -EOPNOTSUPP where it previously operated on
tp->phydev directly?

The non-SFP path of rtl8169_set_link_ksettings() has a related question: with
no PHY attached, phylink_ethtool_ksettings_set() only updates phylink's own
link_config, and on the next open phylink_bringup_phy() rebuilds
config.advertising from phy->advertising.  Does a setting made while the
interface is down get silently dropped while still reporting success?

> @@ -2300,13 +2303,8 @@ static void rtl8169_get_pauseparam(struct net_device *dev,
>  				   struct ethtool_pauseparam *data)
>  {
>  	struct rtl8169_private *tp = netdev_priv(dev);
> -	bool tx_pause, rx_pause;
>  
> -	phy_get_pause(tp->phydev, &tx_pause, &rx_pause);
> -
> -	data->autoneg = tp->phydev->autoneg;
> -	data->tx_pause = tx_pause ? 1 : 0;
> -	data->rx_pause = rx_pause ? 1 : 0;
> +	phylink_ethtool_get_pauseparam(tp->phylink, data);
>  }
>  
>  static int rtl8169_set_pauseparam(struct net_device *dev,
> @@ -2314,12 +2312,10 @@ static int rtl8169_set_pauseparam(struct net_device *dev,
>  {
>  	struct rtl8169_private *tp = netdev_priv(dev);
>  
> -	if (dev->mtu > ETH_DATA_LEN)
> +	if (dev->mtu > ETH_DATA_LEN || data->autoneg == AUTONEG_DISABLE)
>  		return -EOPNOTSUPP;
>  
> -	phy_set_asym_pause(tp->phydev, data->rx_pause, data->tx_pause);
> -
> -	return 0;
> +	return phylink_ethtool_set_pauseparam(tp->phylink, data);
>  }

[Severity: Medium]

The new "|| data->autoneg == AUTONEG_DISABLE" test changes user visible
behaviour: "ethtool -A ethX autoneg off rx on tx on" previously ignored the
autoneg field, applied phy_set_asym_pause() and returned 0, and now returns
-EOPNOTSUPP.

The commit message says only:

    Transfer old framework to phylink. Phylink can support fiber mode card
    which can not get link status or link speed from standard phy registers.

Could the message describe this ethtool behaviour change?  The rationale
currently lives in the v9 changelog below the "---" separator, which is
stripped and does not become part of the git history.

The same applies to the jumbo pause restriction, which moves from
rtl_jumbo_config() (re-applied on every hardware start) to a one-shot
phylink_update_mac_pause_capabilities() call in rtl8169_change_mtu().  Is
the restriction still re-applied if the MAC is restarted without an MTU
transition?

[ ... ]

> @@ -2779,7 +2781,7 @@ static void rtl_prepare_power_down(struct rtl8169_private *tp)
>  		rtl_ephy_write(tp, 0x19, 0xff64);
>  
>  	if (device_may_wakeup(tp_to_dev(tp))) {
> -		phy_speed_down(tp->phydev, false);
> +		phylink_speed_down(tp->phylink, false);
>  		rtl_wol_enable_rx(tp);
>  	}
>  }

[ ... ]

> @@ -5007,8 +5001,6 @@ static void rtl8169_down(struct rtl8169_private *tp)
>  	/* Clear all task flags */
>  	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
>  
> -	phy_stop(tp->phydev);
> -
>  	/* Reset SerDes PHY to bring down fiber link */
>  	if (tp->sfp_mode)
>  		rtl_sfp_reset(tp);
> @@ -5038,8 +5030,6 @@ static void rtl8169_up(struct rtl8169_private *tp)
>  	napi_enable(&tp->napi);
>  	enable_work(&tp->wk.work);
>  	rtl_reset_work(tp);
> -
> -	phy_start(tp->phydev);
>  }

[Severity: High]

phy_stop()/phy_start() are removed from rtl8169_down()/rtl8169_up(), but the
replacements phylink_stop()/phylink_start() are only added to
rtl8169_close()/rtl_open().  rtl8169_down()/rtl8169_up() are also the
suspend, runtime suspend, shutdown and resume paths:

rtl8169_suspend()      -> rtl8169_net_suspend() -> rtl8169_down()
rtl8169_runtime_suspend() -> rtl8169_net_suspend() -> rtl8169_down()
rtl_shutdown()         -> rtl8169_net_suspend() -> rtl8169_down()
rtl8169_resume()       -> rtl8169_up()
rtl8169_runtime_resume() -> rtl8169_up()

and there is no phylink_suspend()/phylink_resume() anywhere in the driver,
even though phylink_config.mac_managed_pm is set to true.  Two questions:

First, is the phylink resolve work still quiesced on the suspend path?
disable_work_sync(&tp->wk.work) only covers the driver's own work item, and
right at the end of rtl8169_down():

rtl_prepare_power_down() {
	if (device_may_wakeup(tp_to_dev(tp))) {
		phylink_speed_down(tp->phylink, false);

phylink_speed_down() -> phy_speed_down() -> phy_config_aneg() restarts
autoneg while phylink is still started, so phy_check_link_status() ->
phy_link_up() -> phylink_run_resolve() can queue a resolve.  The resolve
worker does not take RTNL, so can rtl_mac_link_up() (rtl_link_chg_patch()
ERI writes) or rtl_mac_enable_tx_lpi() (OCP/ERI writes) run after
rtl8169_cleanup()/pci_clear_master(), after the PCI core has put the device
in D3hot on the runtime PM path, or after clk_disable_unprepare(tp->clk) in
rtl8169_suspend()?

Second, is the chip specific link configuration re-applied after resume?
After rtl8169_up() the MAC has been reset by rtl_reset_work() ->
rtl_hw_start(), but phylib state is still PHY_RUNNING with phydev->link ==
1, so phy_check_link_status() takes neither branch and phy_link_up() is not
re-emitted; phylink therefore never re-runs mac_link_up().  Since
rtl_mac_link_up() is now the only caller of rtl_link_chg_patch(), and
rtl_enable_tx_lpi() is only driven from the mac_enable_tx_lpi/
mac_disable_tx_lpi callbacks, do the speed dependent ERI settings for
RTL_GIGA_MAC_VER_34..38 and the MAC Tx LPI bits stay lost after every
suspend/resume cycle?

>  static int rtl8169_close(struct net_device *dev)
> @@ -5049,13 +5039,14 @@ static int rtl8169_close(struct net_device *dev)
>  
>  	pm_runtime_get_sync(&pdev->dev);
>  
> +	phylink_stop(tp->phylink);
>  	netif_stop_queue(dev);
>  	rtl8169_down(tp);
>  	rtl8169_rx_clear(tp);
>  
>  	free_irq(tp->irq, tp);
>  
> -	phy_disconnect(tp->phydev);
> +	phylink_disconnect_phy(tp->phylink);

[ ... ]

> @@ -5117,6 +5108,7 @@ static int rtl_open(struct net_device *dev)
>  		goto err_free_irq;
>  
>  	rtl8169_up(tp);
> +	phylink_start(tp->phylink);
>  	rtl8169_init_counter_offsets(tp);
>  	netif_start_queue(dev);
>  out:

[ ... ]

> @@ -5474,16 +5467,6 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
>  		return -EUNATCH;
>  	}
>  
> -	tp->phydev->mac_managed_pm = true;
> -	if (rtl_supports_eee(tp))
> -		phy_support_eee(tp->phydev);
> -	phy_support_asym_pause(tp->phydev);
> -
> -	/* mimic behavior of r8125/r8126 vendor drivers */
> -	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
> -		phy_disable_eee_mode(tp->phydev,
> -				     ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
> -

[Severity: Medium]

The unconditional phy_support_eee() call disappears here, but
rtl_init_phylink() below sets only lpi_capabilities, not
phylink_config.eee_enabled_default or lpi_timer_default.  phylink_create()
then leaves EEE off:

drivers/net/phy/phylink.c:phylink_create() {
	/* Set the default EEE configuration */
	pl->eee_cfg.eee_enabled = pl->config->eee_enabled_default;
	pl->eee_cfg.tx_lpi_enabled = pl->eee_cfg.eee_enabled;
	pl->eee_cfg.tx_lpi_timer = pl->config->lpi_timer_default;
}

and phylink_bringup_phy() skips phy_support_eee() and programs tx_lpi off:

drivers/net/phy/phylink.c:phylink_bringup_phy() {
	if (pl->mac_supports_eee) {
		if (pl->eee_cfg.eee_enabled)
			phy_support_eee(phy);

		phy->eee_cfg.tx_lpi_enabled = pl->eee_cfg.tx_lpi_enabled;
		phy->eee_cfg.tx_lpi_timer = pl->eee_cfg.tx_lpi_timer;
}

With phydev->eee_cfg.tx_lpi_enabled false, phydev->enable_tx_lpi is never
set, so phylink never calls mac_enable_tx_lpi().  Does that leave MAC Tx LPI
disabled by default on every EEE capable chip, and the newly added
rtl_mac_enable_tx_lpi() -> rtl_enable_tx_lpi() path unreachable until
userspace runs "ethtool --set-eee ethX eee on"?  Previously
phy_support_eee() set tx_lpi_enabled = true and r8169_phylink_handler()
called rtl_enable_tx_lpi(tp, tp->phydev->enable_tx_lpi).

Should rtl_init_phylink() set eee_enabled_default (and lpi_timer_default)
when rtl8169_get_lpi_caps() returns non-zero?

[ ... ]

> +static int rtl_mac_enable_tx_lpi(struct phylink_config *config,
> +				 u32 timer,
> +				 bool tx_clk_stop)
> +{
> +	struct rtl8169_private *tp = container_of(config,
> +						  struct rtl8169_private,
> +						  phylink_config);
> +
> +	rtl_enable_tx_lpi(tp, true);
> +
> +	return 0;
> +}

[Severity: Medium]

This isn't a bug introduced by this patch, but the mismatch is now visible
in the new callback signature: the "timer" argument that
phylink_activate_lpi() passes from pl->mac_tx_lpi_timer (the value set via
"ethtool --set-eee ethX tx-lpi-timer N") and "tx_clk_stop" are both dropped
while 0 is returned, and rtl8169_get_eee() then reports the unrelated MTU
derived value from r8169_get_tx_lpi_timer_us().  The old code had the same
behaviour through r8169_phylink_handler().  Should the callback either
program the requested timer or reject values it cannot honour?

[ ... ]

> +static int rtl_init_phylink(struct rtl8169_private *tp)
> +{
> +	struct phylink *pl;
> +	phy_interface_t phy_mode;
> +
> +	tp->phylink_config.dev = &tp->dev->dev;
> +	tp->phylink_config.type = PHYLINK_NETDEV;
> +	tp->phylink_config.mac_managed_pm = true;
> +	tp->phylink_config.lpi_capabilities = rtl8169_get_lpi_caps(tp);
> +	tp->phylink_config.mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
> +
> +	if (tp->sfp_mode) {
> +		phy_mode = PHY_INTERFACE_MODE_INTERNAL;
> +		tp->phylink_config.mac_capabilities |= MAC_10000FD;
> +	} else {

[Severity: Low]

At this commit the sfp_mode branch advertises only MAC_10000FD (plus pause),
while the unchanged sfp path of rtl8169_set_link_ksettings() still accepts
any speed valid for phydev->supported, including 1000.  Would a 1000BASE-X
fiber link then be missing from pl->supported and fail phylink_bringup_phy()
validation?

Related, the commit message says phylink "can support fiber mode card which
can not get link status or link speed from standard phy registers", but
rtl_mac_select_pcs() returns NULL and rtl_mac_config() is empty here, so
fiber link state still comes from the pseudo-PHY through phylib.

Both halves look resolved later in the series: at the end of the series
rtl_init_phylink() has a switch on enum rtl_sfp_mode where
RTL_SFP_8127_ATF adds MAC_1000FD | MAC_10000FD, sets 10GBASER and 1000BASEX
in supported_interfaces and installs real r8169_pcs_ops, and the sfp special
case in rtl8169_set_link_ksettings() is gone.  Would it help to word the
commit message so it does not promise the PCS behaviour that only arrives in
the later RTL8127atf/RTL8116af patches?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831053745.1197-1-javen_xu%40realsil.com.cn
