Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D20386C22;
	Wed,  2 Sep 2026 05:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327406; cv=none; b=NSOhOSnySf4FYtQxiP/ebHqkvgevoIF7QWEky20XOi5zjoOylNUy2eWtc9/KHQwB63zMIUMAp9ewtZ2p9WXZkzk0ZTtZNAub/6Ioi4jSAOLtSihMl8Wy7T1TPPbvIS3qyHLhpXU616MDCPljF1pvn517n+nyg47q+gdKmyy5/R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327406; c=relaxed/simple;
	bh=tj2gzw+V0f8YYRj/T9zFR6h+qIP/M4tRfC+H/SN3jAs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SUb/5bw6TBqF3Q6Wm2PEJNfRm8jOThqLWc0awRJ70+IauCcQjd+N3w4BwVAqMGmHZLD/ZO514ToX4FrQbWbcD+cw+AwRgRdy4Sl6SvHI06GTa0AEJNpd3ZbHhivI1hyJLOgVvRf59eg+Gsw+kNSZzif+7EeY3ecpydd3CJm+mPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0UhWkVC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0UhWkVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D661F000E9;
	Wed,  2 Sep 2026 05:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788327404;
	bh=b5K/2tcey193i96/BXtW35ONxn2wwpOGswPUoaAYHyM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H0UhWkVCTO3YnfMIBWKd0AOAMxmNPJ2n3Q6HRKZjChqZ5rwDZCp5l9yPR1b9zicEY
	 cHD75vvAlZ1yzXpKwCwtWMDA2qCIFjNMl2pg/UHQyJB5FLTxi2HFrQXEnmUWNlXl7l
	 gv1PQxzhhR02SSR7TAsw54fRlygZ10WRcfgsS61+0nn0tQA75F24mkIqRMeHCq6sQ6
	 4g5qtxEx2o0yQ2dzucfWncyPowAbSmKaJF6SGfD5a8eRYKIEYsPViXIRsYuIC5tqFX
	 OMVMdw5cRyey0j6gWQ9BYOwr7Fqd598aiaelCE5YfyGsLKRMCP3KFY/5vK08mVCnmS
	 wsAeQxd3bborg==
Subject: Re: [net-next,v15,10/13] net: mdio: realtek-rtl9300: Open up C22 and
 C45 space in parallel
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Wed, 02 Sep 2026 05:36:43 +0000
Message-ID: <178832740342.3394541.17329043321577379359@kernel.org>
In-Reply-To: <20260831143439.2404484-11-markus.stockhausen@gmx.de>
References: <20260831143439.2404484-11-markus.stockhausen@gmx.de>
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

Critical: 0 · High: 0 · Medium: 4 · Low: 0

- [Medium] otto_emdio_probe_one() now installs both accessor pairs
  (bus->read/write and bus->read_c45/write_c45) on every SMI bus, but…
- [Medium] priv->smi_bus_is_c45[] is set per physical SMI bus whenever
  any DT child of that bus declares compatible = "ethernet-phy-…
- [Medium] Installing bus->read_c45/bus->write_c45 on every SMI bus
  (including the C22-polling ones) makes PHY-driver code paths live that…
- [Medium] The driver's C22 path is Realtek-specific:
  otto_emdio_9300_read_c22()/otto_emdio_9300_write_c22() always encode…

--

net: mdio: realtek-rtl9300: Open up C22 and C45 space in parallel

The patch stops selecting the mii_bus accessors based on the per-bus
smi_bus_is_c45[] flag and instead registers both the C22 and the C45
read/write callbacks on every SMI bus, matching what the downstream
driver does.

Link: https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/files-6.18/drivers/net/phy/realtek/realtek_multiport.c#L349
Link: https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/files-6.18/drivers/net/mdio/mdio-realtek-otto.c#L1072

> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index ae7ba86e90b9a..b90972c1dc6a2 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
> @@ -688,13 +688,10 @@ static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_priv *priv
>  		return -ENOMEM;
>  
>  	bus->name = "Realtek Switch MDIO Bus";
> -	if (priv->smi_bus_is_c45[mdio_bus]) {
> -		bus->read_c45 = otto_emdio_read_c45;
> -		bus->write_c45 = otto_emdio_write_c45;
> -	} else {
> -		bus->read = otto_emdio_read_c22;
> -		bus->write = otto_emdio_write_c22;
> -	}
> +	bus->read_c45 = otto_emdio_read_c45;
> +	bus->write_c45 = otto_emdio_write_c45;
> +	bus->read = otto_emdio_read_c22;
> +	bus->write = otto_emdio_write_c22;

[Severity: Medium]
The commit message says that "when polling is set to C22 most of the C45
space can not be accessed" and that only "EEE register access is allowed
independently from the polling mode".  Should the opening up be limited to
that documented exception rather than to the whole opposite address space?

The hardware frame format and the PPU scan mode are still derived per bus
from priv->smi_bus_is_c45[] in otto_emdio_9300_setup_controller():

	if (priv->smi_bus_is_c45[i])
		glb_ctrl_val |= RTL9300_GLB_CTRL_INTF_SEL(i);

and in otto_emdio_9310_setup_controller():

	err = regmap_assign_bits(priv->regmap, RTL9310_SMI_GLB_CTRL1,
				 RTL9310_SMI_GLB_FMT_SEL_C45(i),
				 priv->smi_bus_is_c45[i]);

so the restriction described in the changelog is unchanged.  Before this
patch an access into the non-configured space was refused by mdio_bus.c
because the callback was NULL:

drivers/net/phy/mdio_bus.c:__mdiobus_c45_read() {
	if (bus->read_c45)
		retval = bus->read_c45(bus, addr, devad, regnum);
	else
		retval = -EOPNOTSUPP;
	...
}

Now the command is issued to the controller instead.  otto_emdio_run_cmd()
only reports the controller FAIL bit:

	return cmdstate & info->cmd_fail ? -ENXIO : 0;

Can a command that the controller accepts but cannot perform correctly in
the current mode return success here, so that otto_emdio_read_c45() hands
the data register contents to phylib as a valid PHY register value?  And can
a wrongly executed write leave the PHY in a state the driver has no record
of?

The port is also not excluded from the polling engine around a transfer -
otto_emdio_set_port_polling() is only toggled from the attach/detach
notifiers, and priv->lock only serializes the CPU side command writes.

Note the driver keeps the opposite policy elsewhere.  The C22 handlers still
refuse MMD access with:

	if (regnum == MII_MMD_CTRL || regnum == MII_MMD_DATA) {
		dev_warn_once(&bus->dev,
			      "C45 over C22 read access broken due to polling\n");
		return -EOPNOTSUPP;
	}

and the file header comment states:

 * - Access to MDIO_AN_EEE_ADV and MDIO_AN_EEE_LPABLE works via C45 over C22.
 * - It is unclear if these sequences change for different PHYs.

Should the header comment and the MMD guard be updated together with this
change, or should the new access be narrowed to the EEE registers?

[Severity: Medium]
Does this change PHY detection and binding on device trees that mix C22 and
C45 PHYs on one SMI bus?

otto_emdio_map_ports() sets the flag for the whole bus as soon as a single
child declares Clause 45:

	if (of_device_is_compatible(phy_dn, "ethernet-phy-ieee802.3-c45"))
		priv->smi_bus_is_c45[bus] = true;

and setup_controller() then programs the frame format for the entire
interface from that flag.  Previously a PHY of the opposite protocol on such
a bus was unreachable, so get_phy_c22_id()/get_phy_c45_ids() returned
-EOPNOTSUPP and of_mdiobus_register() failed with a clear error.  With both
callback pairs installed the ID read is now issued on an interface programmed
for the other framing, and since otto_emdio_run_cmd() only checks the FAIL
bit, whatever is in the data register becomes the PHY ID used for driver
matching.

The C45 fallback in get_phy_device() also becomes reachable on C22 polling
buses:

drivers/net/phy/phy_device.c:get_phy_device() {
	if (!is_c45 && phy_id == 0 && bus->read_c45) {
		r = get_phy_c45_ids(bus, addr, &c45_ids);
		if (!r)
			return phy_device_create(bus, addr, phy_id,
						 true, &c45_ids);
	}
	...
}

Can this create a bogus C45 phydev where registration previously returned
-ENODEV?

Once such a mismatched PHY is attached, otto_emdio_notify_phy_attach()
enables hardware polling for the port without comparing the individual PHY
protocol against the bus polling mode:

	if (!priv->smi_bus_is_c45[chan->mdio_bus] &&
	    !phy_id_compare_vendor(phydev->phy_id, RTL_VENDOR_ID)) {
		phydev_err(phydev, "Only Realtek PHYs allowed on C22 bus\n");
		return -EOPNOTSUPP;
	}

	return otto_emdio_set_port_polling(priv, port, true);

Would the PPU then send wrong-format polling transactions for that port,
leaving MAC_LINK_STS unpopulated as described in the file header comment?

[Severity: Medium]
Can enabling read_c45/write_c45 on C22 polling buses route MMD accesses to
the wrong PHY on the same bus?

The Realtek PHY driver reaches the bus C45 accessors through helpers that
pass the literal address 0 rather than phydev->mdio.addr:

drivers/net/phy/realtek/realtek_main.c:
static int rtlgen_read_vend2(struct phy_device *phydev, int regnum)
{
	return __mdiobus_c45_read(phydev->mdio.bus, 0, MDIO_MMD_VEND2, regnum);
}

static int rtlgen_write_vend2(struct phy_device *phydev, int regnum, u16 val)
{
	return __mdiobus_c45_write(phydev->mdio.bus, 0, MDIO_MMD_VEND2, regnum,
				   val);
}

Those helpers were written for the r8169 internal PHY bus (commit
da681ed73fb98 "net: phy: realtek: improve mmd register access for internal
PHY's").  rtlgen_read_mmd()/rtlgen_write_mmd() use them precisely for the
EEE registers this patch wants to open up:

	if (devnum == MDIO_MMD_VEND2)
		ret = rtlgen_read_vend2(phydev, regnum);
	else if (devnum == MDIO_MMD_PCS && regnum == MDIO_PCS_EEE_ABLE)
		ret = rtlgen_read_vend2(phydev, RTL_MDIO_PCS_EEE_ABLE);
	else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV)
		ret = rtlgen_read_vend2(phydev, RTL_MDIO_AN_EEE_ADV);

and they are installed as .read_mmd/.write_mmd on the "Generic FE-GE Realtek
PHY" entry matched by rtlgen_match_phy_device() for RTL_GENERIC_PHYID, a
Realtek vendor ID this MDIO driver explicitly admits on C22 buses.

Before this patch __mdiobus_c45_read() returned -EOPNOTSUPP on such a bus.
Now the literal 0 is resolved against the shared switch bus:

	port = otto_emdio_phy_to_port(bus, phy_id);
	if (port < 0)
		return port;

So phy_ethtool_set_eee() -> genphy_c45_write_eee_adv() -> phy_write_mmd()
for port N would rewrite the EEE advertisement of whichever port is mapped
to SMI address 0, and genphy_c45_read_eee_abilities() would populate port
N's supported_eee from that port.  If no port on the bus uses address 0,
otto_emdio_phy_to_port() returns -ENOENT instead of -EOPNOTSUPP, which
callers that treat -EOPNOTSUPP as "feature absent" do not expect:

drivers/net/phy/realtek/realtek_main.c:rtl822x_read_mmd() {
	...
	if (ret != -EOPNOTSUPP)
		return ret;
	...
}

The hardcoded address 0 predates this series, but is this patch what makes
it reachable on C22 buses?

[Severity: Medium]
Registering the C22 accessors on C45 buses also makes them reachable for
non-Realtek PHYs.  Should the vendor gating follow the PHY rather than the
bus?

The C22 path is Realtek specific.  otto_emdio_9300_read_c22() and
otto_emdio_9300_write_c22() always encode the page fields:

	.c22_data	= FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
			  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
			  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),

so per the file header comment the controller emits a page select write to
PHY register 31 before every C22 transaction, while
otto_emdio_read_c22()/otto_emdio_write_c22() emulate register 31 in
software.

The only guard against doing that to a PHY without a Realtek page register
is bus scoped, in otto_emdio_notify_phy_attach():

	if (!priv->smi_bus_is_c45[chan->mdio_bus] &&
	    !phy_id_compare_vendor(phydev->phy_id, RTL_VENDOR_ID)) {
		phydev_err(phydev, "Only Realtek PHYs allowed on C22 bus\n");
		return -EOPNOTSUPP;
	}

On a C45 bus that check is skipped, and a non-Realtek 10G PHY is legitimately
allowed there.  Previously bus->read/bus->write were NULL on such a bus, so
no C22 access could reach that PHY.  Now a PHY driver's phy_read()/
phy_write(), or userspace via ioctl(SIOCGMIIREG)/ioctl(SIOCSMIIREG), takes
the non-C45 branch:

drivers/net/phy/phy.c:phy_mii_ioctl() {
	case SIOCGMIIREG:
		if (mdio_phy_id_is_c45(mii_data->phy_id)) {
			...
			ret = mdiobus_c45_read(phydev->mdio.bus, prtad, devad,
	...
}

Can this write the vendor specific register 31 of a foreign PHY, and can a
read of register 31 return driver bookkeeping instead of the device's actual
register content, leaving software and hardware state diverged?

Extending the vendor check to the C22 accessors on every bus, or omitting the
page fields for non-Realtek devices, would keep the gating with the PHY.

>  	bus->parent = dev;
>  	bus->notify_phy_attach = otto_emdio_notify_phy_attach;
>  	bus->notify_phy_detach = otto_emdio_notify_phy_detach;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831143439.2404484-1-markus.stockhausen%40gmx.de
