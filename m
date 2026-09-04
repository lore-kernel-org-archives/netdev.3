Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F6F51A75C;
	Fri,  4 Sep 2026 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560725; cv=none; b=PEyPlWZbEAXkLNg8c0vxYaKX2HKpLe+7lcj/Rre1Y9PX6CrT6LFu8+any3GGsuNSqy8Eo0PmPPueeTy3vNt3deInVnLd4Kcw1PSmUbk8OahxA3fjlKp/2RulZp7AO1YXRduyPw31Fg4cwSH8wYRbaQieaQGeM/pWOP9uXOdpFLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560725; c=relaxed/simple;
	bh=1gtFDsfZOL28vqkGNIlbITfcZCQrSZ9D/Mqinp0lt/g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JTFRwdO4UdZN21dJAl9EhBCJZ0P4cZtr0n3YCad6nIGn4SHQ5UFLcaIoHphaVGBqbjkgrlVZfxtH62bSTk7Q6WvUx890DyOQ14j40gQkIxQWctdjplsjrLTcoai9wSGTlvoKsWbDB9NBq4kauSKYFJwweEXeECCgnfhd4LedKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMV/k8/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMV/k8/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1941B1F00AC4;
	Fri,  4 Sep 2026 22:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560720;
	bh=gw3pyDblcvU1iWnEtqT0CZwCFEW69AxvEJRcwLn5SY4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EMV/k8/NNXyZpdOQJRB+KZmfIutoqgkoVVK+RiUSjqqhObu/fVCH4Jz+IVCJe541q
	 vXfvbLR6czgQjim6q01DVpL0bKBgwGkk6OJnQil367BPusRaMxJZd1tEgf6eVo8Q6h
	 +ZjjfsPbRR2l+YIYF439hOWDHjJx7NxC7CbByg/qII69Cto4P05cJgcz9qTIE2HyKh
	 Vrm+23l5w3vaHRYo3UzKeOpUyhvJ72h4ac13etjbU1UTKKOaCxAEf6baXuZ82uXGxe
	 lN9KzWsHq0ijk4kEAtEHIDU7ICTEJTT7QEv37Sobtozok2OwOUh+NW7+bBjWnueup1
	 n/3Po6pefXeQA==
Subject: Re: [PATCH net-next v9 4/7] r8169: add support for RTL8116af
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, linux@armlinux.org.uk,
 enelsonmoore@gmail.com, daniel@thingy.jp
Date: Fri, 04 Sep 2026 22:25:19 +0000
Message-ID: <178856071965.219967.14695801109001005732@kernel.org>
In-Reply-To: <20260831053745.1197-5-javen_xu@realsil.com.cn>
References: <20260831053745.1197-5-javen_xu@realsil.com.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 1

- [Medium] For RTL_SFP_8168_AF the driver registers a phylink PCS and
  declares in-band 1000BASE-X autonegotiation (tp->pcs.ops =…
- [Medium] The phylink conversion in this series removed phy_stop() from
  rtl8169_down() and phy_start() from rtl8169_up() (both present at…
- [Medium] The newly added PCS callback rtl8169_pcs_get_state() (via
  rtl8169_sds_read()) performs indirect OCP/SerDes MMIO accesses with no…
- [Low] For the new no-PHY 1000BASEX mode the driver still advertises
  EEE/LPI capabilities derived from the copper-PHY version check:…

--

r8169: add support for RTL8116af

This adds detection of the RTL8116af SFP variant of RTL_GIGA_MAC_VER_52,
registers a phylink PCS that reads link state from the SerDes registers,
and guards the existing internal-PHY code paths against a NULL
tp->phydev.  A few review questions below.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 823763e4f4456..a04acb42e995d 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -4891,8 +4939,13 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  		goto out;
>  	}
>  
> -	if (status & LinkChg)
> -		phy_mac_interrupt(tp->phydev);
> +	if (status & LinkChg) {
> +		if (tp->phydev)
> +			phy_mac_interrupt(tp->phydev);
> +		else if (tp->sfp_mode == RTL_SFP_8168_AF)
> +			phylink_mac_change(tp->phylink,
> +					   !!(RTL_R8(tp, PHYstatus) & LinkStatus));
> +	}
>  
>  	rtl_irq_disable(tp);
>  	napi_schedule(&tp->napi);

[ ... ]

> @@ -5002,7 +5055,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
>  	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
>  
>  	/* Reset SerDes PHY to bring down fiber link */
> -	if (tp->sfp_mode)
> +	if (tp->sfp_mode == RTL_SFP_8127_ATF)
>  		rtl_sfp_reset(tp);
>  
>  	rtl8169_update_counters(tp);

[Severity: Medium]
Should the PM paths also quiesce phylink here?

rtl8169_down() masks interrupts, runs rtl8169_cleanup(), pci_clear_master()
and rtl_prepare_power_down(), but nothing calls phylink_stop() or
phylink_suspend() on this path.  phylink_stop() is only reached from
rtl8169_close(), while rtl8169_suspend(), rtl8169_runtime_suspend() and
rtl_shutdown() all reach rtl8169_down() through rtl8169_net_suspend():

rtl8169_net_suspend()
    netif_device_detach(tp->dev);
    if (netif_running(tp->dev))
        rtl8169_down(tp);

Since pl->phylink_disable_state is only set by phylink_stop() and
phylink_suspend(), phylink_run_resolve() is still free to queue
phylink_resolve() on system_power_efficient_wq, including a resolve queued
from the rtl8169_interrupt() -> phylink_mac_change() call added above.  The
suspend callbacks drop rtnl_lock before the PCI core moves the device to
D3hot, so RTNL does not exclude it.

Can that resolve then run rtl8169_pcs_get_state() -> rtl8169_sds_read()
MMIO/OCP reads, or rtl_mac_link_up() -> rtl_link_chg_patch() ERI/MMIO
writes, against a device that is already powered down?

> @@ -5024,9 +5077,9 @@ static void rtl8169_up(struct rtl8169_private *tp)
>  		rtl8168_driver_start(tp);
>  
>  	pci_set_master(tp->pci_dev);
> -	phy_init_hw(tp->phydev);
> -	phy_resume(tp->phydev);
> -	rtl8169_init_phy(tp);
> +	if (tp->phydev)
> +		rtl8169_init_phy(tp);
> +
>  	napi_enable(&tp->napi);
>  	enable_work(&tp->wk.work);
>  	rtl_reset_work(tp);

[Severity: Medium]
Same question from the resume side: rtl8169_up() is the counterpart of
rtl8169_down(), and neither phylink_resume() nor phylink_start() is called
from rtl8169_resume() or rtl8169_runtime_resume().  Is the start/stop
pairing intentionally asymmetric, with phylink_start()/phylink_stop() only
in rtl_open()/rtl8169_close()?  For the copper case, phy_init_hw() and
phy_resume() are also re-run from rtl8169_init_phy() without phylink
knowing about it.

[ ... ]

> @@ -5628,6 +5692,53 @@ static void rtl_mac_config(struct phylink_config *config, unsigned int mode,
>  {
>  }
>  
> +static u16 rtl8169_sds_read(struct rtl8169_private *tp, u16 sds_reg)
> +{
> +	unsigned long flags;
> +	u16 val = 0;
> +
> +	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
> +	__r8168_mac_ocp_write(tp, OCP_SDS_ADDR_REG, sds_reg);
> +	__r8168_mac_ocp_write(tp, OCP_SDS_CMD_REG, SDS_CMD_READ);
> +	val = __r8168_mac_ocp_read(tp, OCP_SDS_DATA_REG);
> +	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
> +
> +	return val;
> +}
> +
> +static void rtl8169_pcs_get_state(struct phylink_pcs *pcs,
> +				  unsigned int neg_mode,
> +				  struct phylink_link_state *state)
> +{
> +	struct rtl8169_private *tp = container_of(pcs, struct rtl8169_private,
> +						  pcs);
> +	u16 bmsr, lpa;
> +
> +	bmsr = rtl8169_sds_read(tp, RTL_SDS_C22_BASE + MII_BMSR);
> +	lpa = rtl8169_sds_read(tp, RTL_SDS_C22_BASE + MII_LPA);
> +
> +	phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lpa);
> +}

[Severity: Medium]
Does this need a runtime PM guard before touching the SerDes registers?

For RTL_SFP_8168_AF there is no phydev, so phylink's mode is MLO_AN_INBAND
with pl->phydev == NULL, and phylink_ethtool_ksettings_get() takes the
unconditional PCS read path in that case:

	case MLO_AN_INBAND:
		if (pl->phydev)
			break;

		phylink_mac_pcs_get_state(pl, &link_state);

rtl8169_get_link_ksettings() is a bare wrapper around
phylink_ethtool_ksettings_get() with no pm_runtime_get*/pm_runtime_active()
check, unlike rtl8169_get_stats64() which brackets its hardware access.
phylink_mii_ioctl() with SIOCGMIIREG reaches the same code.

If a plain "ethtool ethX" runs while the device is runtime suspended (after
rtl8169_close(), or after rtl_mac_link_down() -> pm_runtime_idle() and
rtl8169_runtime_idle() -> pm_schedule_suspend()), the reads return 0xffff,
so bmsr has BMSR_LSTATUS and BMSR_ANEGCOMPLETE set and
phylink_mii_c22_pcs_decode_state() reports a bogus 1000/Full link.  On
platforms that do not decode MMIO in D3hot the access can raise an
unsupported-request instead.  Should this path take a runtime PM reference,
or bail out when the device is not active?

> +
> +static int rtl8169_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
> +			      phy_interface_t interface,
> +			      const unsigned long *advertising,
> +			      bool permit_pause_to_mac)
> +{
> +	return 0;
> +}
> +
> +static int rtl8169_pcs_validate(struct phylink_pcs *pcs,
> +				unsigned long *supported,
> +				const struct phylink_link_state *state)
> +{
> +	return 0;
> +}
> +
> +static void rtl8169_pcs_an_restart(struct phylink_pcs *pcs)
> +{
> +}

[Severity: Medium]
These two callbacks are registered for a mode that declares in-band
1000BASE-X autonegotiation, but neither of them touches the hardware.

include/linux/phylink.h documents the contract:

 * For 1000BASE-X, the advertisement should be programmed into the PCS.
 ...
 * When an autonegotiation restart is required for 802.3z modes,
 * .pcs_config() should return a positive non-zero integer (e.g. 1)

rtl8169_pcs_config() discards neg_mode, interface, advertising and
permit_pause_to_mac and returns 0, rtl8169_pcs_an_restart() is empty, and
rtl8169_sds_read() is the only SerDes accessor added, so there is no write
path at all.

Does this mean ethtool -s advertise=..., rtl8169_set_pauseparam() ->
phylink_ethtool_set_pauseparam() and rtl8169_nway_reset() ->
phylink_ethtool_nway_reset() all return success while the SerDes keeps
advertising whatever reset or firmware left there?  Since
phylink_resolve_an_pause() uses phylink's software advertisement, the
resolved pause can also differ from what the peer actually sees.

If autonegotiation really is fixed or firmware-managed on this part, would
it be clearer to express that through pcs_inband_caps or by rejecting the
unsupported configuration, rather than acknowledging the request?

> +
>  static void rtl_mac_disable_tx_lpi(struct phylink_config *config)
>  {
>  	struct rtl8169_private *tp = container_of(config,

[ ... ]

> @@ -5692,10 +5810,18 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
>  	tp->phylink_config.lpi_capabilities = rtl8169_get_lpi_caps(tp);
>  	tp->phylink_config.mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
>  
> -	if (tp->sfp_mode) {
> +	switch (tp->sfp_mode) {
> +	case RTL_SFP_8168_AF:
> +		tp->pcs.ops = &r8169_pcs_ops;
> +		tp->phylink_config.default_an_inband = true;
> +		phy_mode = PHY_INTERFACE_MODE_1000BASEX;
> +		tp->phylink_config.mac_capabilities |= MAC_1000FD;
> +		break;

[Severity: Low]
This isn't a functional bug, but should RTL_SFP_8168_AF be excluded from
rtl8169_get_lpi_caps() as well?

rtl8169_get_lpi_caps() only gates on rtl_supports_eee() and
tp->sfp_mode == RTL_SFP_8127_ATF:

	if (!rtl_supports_eee(tp) || tp->sfp_mode == RTL_SFP_8127_ATF)
		return 0;

	caps |= MAC_100FD | MAC_1000FD;

RTL_GIGA_MAC_VER_52 passes rtl_supports_eee(), so lpi_capabilities ends up
as MAC_100FD | MAC_1000FD and PHY_INTERFACE_MODE_1000BASEX is added to
lpi_interfaces further down, even though mac_capabilities for this mode is
only MAC_1000FD and there is no phydev.  Nothing can act on it, since
phylink_activate_lpi() is only reached when pl->phy_enable_tx_lpi is set
from a connected PHY and phylink_ethtool_get_eee()/set_eee() return
-EOPNOTSUPP without pl->phydev, but the advertised mask still lists a speed
this interface cannot run at.

> +	case RTL_SFP_8127_ATF:
>  		phy_mode = PHY_INTERFACE_MODE_INTERNAL;
>  		tp->phylink_config.mac_capabilities |= MAC_10000FD;
> -	} else {
> +		break;
> +	default:
>  		tp->phylink_config.mac_capabilities |= MAC_10 | MAC_100;
>  
>  		if (tp->mac_version == RTL_GIGA_MAC_VER_80)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831053745.1197-1-javen_xu%40realsil.com.cn
