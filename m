Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAA652ED31;
	Fri,  4 Sep 2026 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560728; cv=none; b=sxIVN4t64Je5HgFxc06bifwe96KP93qwZIi6vAYYzmGpdR2ismkDpFJdITCED5DnRURENzVLvh2BiZAyLAuJ6RyErM3Yrw/YgFt3+FuysXJm42EtjM20dlCjKEm9Bwc9Myo15LoCeFLWKpy8w3AyMYXnEJe0+vCfVWfBnlgiQM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560728; c=relaxed/simple;
	bh=3ZF5lGBK+ZkbpO8m7vIYHWZ7uZ9raHHThvTOliwCyBU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NsQn2M52mzqc24+DC6GCnXYHCsLtIJXEtqx82hTLwF64FQkxAkiY0ZCtM5zTAHspcvlrWl1l3sSji6nUXAQ4OQcAnK82vFqSSgxMeQD11I5jsVcVPPpazZZqDbrl3HV5AsR3E442ZJCkEJgjdiAK+VPLjnkrW+t5tqcc2geRTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrPqXue7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrPqXue7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF581F00ACA;
	Fri,  4 Sep 2026 22:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560722;
	bh=WMxTN8N4fJu9KnJ2ByfZtaau8Dq/5Aq2DnK9W4MuT8Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FrPqXue7aURcpiXIy2tAtAsUdQBZsgZR8ZwXIfIAxbIpgm5jjDnh0sJ9yo1gCJ8Qz
	 oxkkaCYdthpphe/llVIvsjbASPsZzzqYPIrJikjzWZQBTER4qSPqPVuNbj13GpiAjS
	 CBYsRX4qGmn7c6DCczHubZ0CurW8FiRNeEzGmEqd5wbtKhQ3uie/PqJ2Xj+aFaMEa1
	 My2AON1/yJhiFUqobGJhAUgVOxQNlKC8OnhkzhQWnrVOFPRYAzccQycnsq6arDNpYA
	 7CpOadX+Te9yNwBu5EyjyhfrFBT8/UZaUdjRocwZaIR7fdxPCwPLiytcggv//UN/FP
	 +uL2GsEubdReg==
Subject: Re: [PATCH net-next v9 5/7] r8169: add support for RTL8127atf
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, linux@armlinux.org.uk,
 enelsonmoore@gmail.com, daniel@thingy.jp
Date: Fri, 04 Sep 2026 22:25:21 +0000
Message-ID: <178856072110.219967.12213252573988149432@kernel.org>
In-Reply-To: <20260831053745.1197-6-javen_xu@realsil.com.cn>
References: <20260831053745.1197-6-javen_xu@realsil.com.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 5 · Low: 1

- [High] The 1 Gb/s support the commit claims to add is dead code.
- [High] RTL8127atf loses its SerDes/PCS re-initialization across
  suspend/resume, so the fiber link cannot come back up.
- [Medium] The commit message ("RTL8127atf is also a fiber mode card, but
  its sds reg base addr is 0x0080 ... Add 10g and 1g support") does not…
- [Medium] In the newly added r8127_sfp_init_1g() the return value of
  r8168_phy_ocp_read(tp, 0xc804) is stored in `int val` and immediately…
- [Medium] r8127_sds_modify() silently swallows both failure modes of the
  new 0x2348 SDS command interface: it returns void, aborts without any…
- [Medium] The phylink resolve worker is never quiesced in the
  suspend/runtime-suspend/shutdown paths, yet this patch makes those…
- [Medium] rtl8169_pcs_config() unconditionally performs a full SerDes
  PHY hardware reset (r8127_sfp_sds_phy_reset(): 0x2350 bit0…
- [Low] Concern (validated as a FALSE POSITIVE): "RTL8127ATF is
  registered as an in-band 1000BASE-X PCS but its PCS callbacks do not…

--

r8169: add support for RTL8127atf

The patch wires RTL8127atf into phylink as a 10GBASE-R/1000BASE-X PCS,
adds a new SerDes command window (0x2348..0x234e) with read/write/modify
helpers, and adds a 1G SerDes init sequence. It also removes the dummy
SFP PHY driver entry from the realtek phylib driver and deletes
include/net/phy/realtek_phy.h.

The commit message says:

  "RTL8127atf is also a fiber mode card, but its sds reg base addr is
   0x0080, which is different from RTL8116af. Add 10g and 1g support for
   RTL8127atf in this patch."

[Severity: Medium]
Could the message describe the rest of what the patch does?  Beyond the
SerDes base address and the 10g/1g init sequences it also:

 - removes the "Realtek SFP PHY Mode" phy_driver entry together with
   rtlgen_sfp_get_features(), rtlgen_sfp_read_status() and
   rtlgen_sfp_config_aneg() from drivers/net/phy/realtek/realtek_main.c

 - deletes the global header include/net/phy/realtek_phy.h and the dummy
   MII_PHYSID2 hack in r8168_phy_ocp_read()

 - stops registering an MDIO bus and a phydev for every SFP mode, by
   changing rtl_init_one() from "if (tp->sfp_mode != RTL_SFP_8168_AF)" to
   "if (tp->sfp_mode == RTL_SFP_NONE)"

 - drops the RTL8127atf specific forced-speed path in
   rtl8169_set_link_ksettings()

 - introduces a second SerDes access mechanism (the MMIO window
   R8127_SDS_CMD/ADDR/DATA_IN/DATA_OUT with index/page/reg encoding),
   which is unrelated to the "base addr 0x0080" explanation

The phylib change in particular gives the phylib maintainers no notice
that their subsystem is touched.  Would it make sense to split the
phylib removal into its own patch, or at least mention it?

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index a04acb42e995d..eecde26d9de2c 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -1223,6 +1224,75 @@ static void r8127_sfp_sds_phy_reset(struct rtl8169_private *tp)
>  	usleep_range(10, 20);
>  }
>  
> +DECLARE_RTL_COND(r8127_sds_cmd_cond)
> +{
> +	return RTL_R16(tp, R8127_SDS_CMD) & R8127_SDS_CMD_EXEC;
> +}
> +
> +static int r8127_sds_read(struct rtl8169_private *tp, u16 index,
> +			  u16 page, u16 reg)
> +{
> +	u16 addr = (index << 11) | (page << 5) | reg;
> +
> +	RTL_W16(tp, R8127_SDS_ADDR, addr);
> +	RTL_W16(tp, R8127_SDS_CMD, R8127_SDS_CMD_EXEC);
> +
> +	if (rtl_loop_wait_low(tp, &r8127_sds_cmd_cond, 10, 100))
> +		return RTL_R16(tp, R8127_SDS_DATA_OUT);
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int r8127_sds_write(struct rtl8169_private *tp, u16 index, u16 page,
> +			   u16 reg, u16 val)
> +{
> +	u16 addr = (index << 11) | (page << 5) | reg;
> +
> +	RTL_W16(tp, R8127_SDS_DATA_IN, val);
> +	RTL_W16(tp, R8127_SDS_ADDR, addr);
> +	RTL_W16(tp, R8127_SDS_CMD, R8127_SDS_CMD_EXEC | R8127_SDS_CMD_WE);
> +
> +	if (rtl_loop_wait_low(tp, &r8127_sds_cmd_cond, 10, 100))
> +		return 0;
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static void r8127_sds_modify(struct rtl8169_private *tp, u16 index, u16 page,
> +			     u16 reg, u16 clearmask, u16 setmask)
> +{
> +	int val = r8127_sds_read(tp, index, page, reg);
> +
> +	if (val < 0)
> +		return;
> +
> +	val = (val & ~clearmask) | setmask;
> +	r8127_sds_write(tp, index, page, reg, val);
> +}

[Severity: Medium]
The -ETIMEDOUT returns were added to r8127_sds_read()/r8127_sds_write()
on purpose, but r8127_sds_modify() is the only consumer and it drops
both: the read error returns silently and the write return value is
discarded.

Should the failure be propagated up instead?  As written, if one of the
three r8127_sds_modify() calls in r8127_sfp_init_1g() never reaches the
hardware, the following mode select writes still execute:

	r8127_sds_modify(tp, 0, 1, 31, 0, BIT(3));
	r8127_sds_modify(tp, 0, 2,  0, ...);
	r8127_sds_modify(tp, 0, 0,  4, 0, BIT(2));

	RTL_W16(tp, 0x233a, 0x8004);
	RTL_W16(tp, 0x233e, (RTL_R16(tp, 0x233e) & ~0x3003) | 0x0002);

so the SerDes lane keeps its post-reset settings while the mode select
says 1G.  r8127_sfp_init_1g() is void and rtl8169_pcs_config() returns 0
unconditionally, so phylink records the PCS as configured and will report
SPEED_1000/DUPLEX_FULL once MDIO_STAT1 reads link up.  rtl8169_pcs_config()
already returns -EOPNOTSUPP for an unsupported interface, so a real error
could be reported here.

> +
> +static void r8127_sfp_init_1g(struct rtl8169_private *tp)
> +{
> +	int val;
> +
> +	r8127_sfp_sds_phy_reset(tp);
> +
> +	r8127_sds_modify(tp, 0, 1, 31, 0, BIT(3));
> +	r8127_sds_modify(tp, 0, 2,  0, BIT(13) | BIT(12) | BIT(6),
> +			 BIT(12) | BIT(6));
> +	r8127_sds_modify(tp, 0, 0,  4, 0, BIT(2));
> +
> +	RTL_W16(tp, 0x233a, 0x8004);
> +	RTL_W16(tp, 0x233e, (RTL_R16(tp, 0x233e) & ~0x3003) | 0x0002);
> +
> +	r8168_phy_ocp_write(tp, 0xc40a, 0x0000);
> +	r8168_phy_ocp_write(tp, 0xc466, 0x0000);
> +	r8168_phy_ocp_write(tp, 0xc808, 0x0000);
> +	r8168_phy_ocp_write(tp, 0xc80a, 0x0000);
> +
> +	val = r8168_phy_ocp_read(tp, 0xc804);
> +	r8168_phy_ocp_write(tp, 0xc804, (val & ~0x000f) | 0x000c);
> +}

[Severity: Medium]
Can the unchecked r8168_phy_ocp_read() result corrupt the following
write?  r8168_phy_ocp_read() can return a negative value:

	return rtl_loop_wait_high(tp, &rtl_ocp_gphy_cond, 25, 10) ?
		(RTL_R32(tp, GPHY_OCP) & 0xffff) : -ETIMEDOUT;

With val == -ETIMEDOUT, (val & ~0x000f) | 0x000c is 0xffffff9c, and
r8168_phy_ocp_write() ORs data into the command word without masking it:

	RTL_W32(tp, GPHY_OCP, OCPAR_FLAG | (reg << 15) | data);

rtl_ocp_reg_failure() only validates reg, so every bit of the encoded
address field ends up set and the write lands somewhere other than
0xc804.  Would checking val < 0 and aborting the init be better here?
Note r8127_sfp_init_10g() has the same shape today; this adds a second
instance of it.

[ ... ]

> @@ -2608,9 +2650,6 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
>  	    tp->pci_dev->subsystem_device == 0xe000)
>  		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
>  
> -	if (tp->sfp_mode == RTL_SFP_8127_ATF)
> -		rtl_sfp_init(tp);
> -
>  	/* We may have called phy_speed_down before */
>  	phy_speed_up(tp->phydev);

[Severity: High]
Does RTL8127atf still come back after suspend/resume with this call
removed?

rtl8169_down() puts the SerDes PHY into reset and programs mode select
0x233a = 0x801f for this chip:

	if (tp->sfp_mode == RTL_SFP_8127_ATF)
		rtl_sfp_reset(tp);

and it is reached from rtl8169_close(), rtl8169_suspend(),
rtl8169_runtime_suspend() and rtl_shutdown() via rtl8169_net_suspend().
A runtime suspend also drops the device to D3hot.

Previously the re-programming happened on every bring-up through
rtl8169_up() -> rtl8169_init_phy() -> rtl_sfp_init().  After this patch
rtl8169_up() only does that under "if (tp->phydev)", and tp->phydev is
NULL for RTL8127atf because rtl_init_one() now registers the MDIO bus
only for "tp->sfp_mode == RTL_SFP_NONE".

The only remaining caller of r8127_sfp_init_10g()/r8127_sfp_init_1g() is
rtl8169_pcs_config(), which phylink invokes from a major config, i.e.
from phylink_start() in rtl_open() or on an interface change.  r8169
never calls phylink_suspend()/phylink_resume().  So after a resume the
SerDes appears to stay in the 0x801f reset mode while phylink believes
10GBASE-R is configured, and the link stays down until the interface is
taken down and up again.  Note rtl8169_runtime_idle() schedules a runtime
suspend 10s after the carrier drops, which is the normal state of a fiber
port with no module or no link.

[ ... ]

> @@ -4942,7 +4981,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  	if (status & LinkChg) {
>  		if (tp->phydev)
>  			phy_mac_interrupt(tp->phydev);
> -		else if (tp->sfp_mode == RTL_SFP_8168_AF)
> +		else if (tp->sfp_mode)
>  			phylink_mac_change(tp->phylink,
>  					   !!(RTL_R8(tp, PHYstatus) & LinkStatus));
>  	}

[Severity: Medium]
Can the phylink resolve worker now run against a device that is being
powered down?

This call queues the phylink resolve work from hardirq for RTL8127atf,
including for the LinkChg caused by rtl_sfp_reset() itself.  Meanwhile
rtl8169_suspend(), rtl8169_runtime_suspend() and rtl_shutdown() take only
rtnl_lock() and go through rtl8169_net_suspend() -> rtl8169_down() ->
rtl_sfp_reset() -> rtl8169_cleanup(); a grep of phylink_ in this file
shows phylink_stop() only in rtl8169_close() and phylink_start() only in
rtl_open(), so nothing flushes pl->resolve on the PM paths.

The resolve worker holds only pl->state_mutex, and the suspend path holds
only RTNL, so the two lock sets are disjoint:

	rtl8169_down()				phylink resolve worker
	  rtl_sfp_reset()			  rtl8169_pcs_get_state()
	    r8127_sfp_sds_phy_reset()		    rtl8169_sds_read()
	  rtl_prepare_power_down()		  rtl_mac_link_up()/down()

Once the device is in D3, MMIO reads return all ones, so MDIO_STAT1 looks
like LSTATUS is set and phylink reports a 10 Gb/s link on a powered-down
device.  Should the PM paths call phylink_suspend()/phylink_resume(), or
at least phylink_stop()?

[ ... ]

> @@ -5725,6 +5785,24 @@ static int rtl8169_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
>  			      const unsigned long *advertising,
>  			      bool permit_pause_to_mac)
>  {
> +	struct rtl8169_private *tp = container_of(pcs, struct rtl8169_private,
> +						  pcs);
> +
> +	if (tp->sfp_mode == RTL_SFP_8127_ATF) {
> +		switch (interface) {
> +		case PHY_INTERFACE_MODE_10GBASER:
> +			r8127_sfp_init_10g(tp);
> +			break;
> +		case PHY_INTERFACE_MODE_1000BASEX:
> +			r8127_sfp_init_1g(tp);
> +			break;
> +		default:
> +			netdev_err(tp->dev, "Unsupported SFP interface mode: %s\n",
> +				   phy_modes(interface));
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
>  	return 0;
>  }

[Severity: Medium]
Does this bounce the fiber link on an advertisement-only change?  Both
init helpers start with r8127_sfp_sds_phy_reset(), which toggles 0x2350
bit 0 and rewrites 0x233a:

	RTL_W8(tp, 0x2350, RTL_R8(tp, 0x2350) & ~BIT(0));
	udelay(1);
	RTL_W16(tp, 0x233a, 0x801f);
	RTL_W8(tp, 0x2350, RTL_R8(tp, 0x2350) | BIT(0));

phylink calls pcs_config() from phylink_change_inband_advert() as well as
from a major config, and phylink_update_pause_state() does that
unconditionally when there is no PHY attached:

	if (!pl->phydev)
		phylink_change_inband_advert(pl);

tp->phydev is NULL for RTL8127atf after this patch, so an
"ethtool -A <dev> rx off tx off" would reach rtl8169_pcs_config() with an
unchanged interface and hard-reset the SerDes.  Should the helpers only
run when the interface actually changes?

[ ... ]

> @@ -5818,8 +5896,14 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
>  		tp->phylink_config.mac_capabilities |= MAC_1000FD;
>  		break;
>  	case RTL_SFP_8127_ATF:
> -		phy_mode = PHY_INTERFACE_MODE_INTERNAL;
> -		tp->phylink_config.mac_capabilities |= MAC_10000FD;
> +		tp->pcs.ops = &r8169_pcs_ops;
> +		phy_mode = PHY_INTERFACE_MODE_10GBASER;
> +		tp->phylink_config.default_an_inband = true;
> +		tp->phylink_config.mac_capabilities |= MAC_1000FD | MAC_10000FD;
> +		__set_bit(PHY_INTERFACE_MODE_10GBASER,
> +			  tp->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +			  tp->phylink_config.supported_interfaces);
>  		break;

[Severity: High]
How does the 1 Gb/s support announced in the commit message get selected?

phy_mode is fixed at PHY_INTERFACE_MODE_10GBASER here, so
phylink_create() -> phylink_parse_mode() derives pl->supported from
phy_caps_from_interface(10GBASER), i.e. 10 Gb/s link modes only, and
pl->link_config.interface stays 10GBASER.

There is no PHY (this patch stops registering an MDIO bus for SFP modes)
and no SFP bus (phylink_register_sfp() finds no "sfp" fwnode on a PCI
device), so the only PHY-less code that can re-select an interface never
runs:

drivers/net/phy/phylink.c:phylink_ethtool_ksettings_set() {
	...
	if (pl->sfp_bus) {
		if (kset->base.autoneg == AUTONEG_ENABLE)
			config.interface = phylink_sfp_select_interface(...);
		else
			config.interface = phylink_sfp_select_interface_speed(...);
	...
}

With link_config.interface pinned to 10GBASER, is any of the following
reachable?

 - the PHY_INTERFACE_MODE_1000BASEX case of rtl8169_pcs_config(), and
   therefore r8127_sfp_init_1g() in its entirety
 - the "state->interface == PHY_INTERFACE_MODE_1000BASEX" branch of
   rtl8169_pcs_get_state(), which otherwise always reports SPEED_10000
 - MAC_1000FD and the 1000BASEX supported_interfaces bit

"ethtool -s <dev> autoneg off speed 1000 duplex full" also looks like it
returns -EINVAL from phy_caps_lookup() because pl->supported only holds
10 Gb/s modes.  The patch removes the previous mechanism for forcing a
mode on this part (the RTL_SFP_8127_ATF case in
rtl8169_set_link_ksettings() calling rtl_sfp_init()) without adding a
replacement.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831053745.1197-1-javen_xu%40realsil.com.cn
