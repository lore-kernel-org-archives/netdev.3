Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B333ED13B;
	Wed, 16 Sep 2026 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541257; cv=none; b=pjOD2VtqDcQ9eG0tRBvyT6YBkc9bNckDdq5QLhrY3ujhN93dSY9zLVllRUZ1vwqm2UIP9pR9oikT3512RU8GZAjn0IDca4lHwqkcL6dj52ow54Vnr/BAv//omMyqkuATjg7IBoQGuQvnT/eAjotQcYxuoqNB7TJWJBqzGSpESh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541257; c=relaxed/simple;
	bh=NUvoRR3g2HaHKZGmBsaxZee7mmhsrIkkV0lXhuVu8y8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uftcVF3O2ZDOsrmXpXGHgkvuvR+9CS1Ri6bXCZtthjOV21l4bFpK70Ql/syxWEhEW1BsMnLh8IecjgH6/nXbzFZJGxkT7neBuvRBpl5TGNTg/uUy6/bmZmPPGhFu1G0SKkrXr7QChcI0dv9ktLCgiViwqNKj3eYCL4AJ27DQ/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR6T+s6s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR6T+s6s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A391F000FF;
	Wed, 16 Sep 2026 06:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541249;
	bh=MtXUKOys+yfbJla12gxl7gv2CjBUzIKtdPWW5F51lSE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UR6T+s6sT5H3DAVFjI5CKksSCmHE1bLEuxWdam30x6BoWf2BYWfOy/ScgjoklFdpm
	 os7W/hN71MCUKeBsiSlGMa1kH0OOUhblQlfxlvGWGEJWSsV66VR18Jggrua49uF6Vy
	 CSxTza80Cfl6cA5M9bYtAaGMOHDozw+nJwQT/CQYkjF0HNXBv/XeHGDqZ5/YqlujGY
	 6bYHt441to9p7/9yeLx9mOyR2bRZJE9H35xOcm1CcNiJGDBvs1NdcMuDEHu/u3kJsW
	 GDzCRpDCrd1nc7Te4aycW2tvLiYdpVy53CP9zotFuBBkC0wPAXZxKzIgbOOCw+ewBT
	 Unw/gnm9a7Twg==
Subject: Re: [PATCH net-next v11 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Wed, 16 Sep 2026 06:47:28 +0000
Message-ID: <178954124851.22033.17491504211504116054@kernel.org>
In-Reply-To: <20260914-ax88179a-v11-6-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-6-5ea7a925ba6d@birger-koblitz.de>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 20 potential
issue(s) to consider:

Critical: 1 · High: 4 · Medium: 12 · Low: 3

- [Critical] ax88179a_rx_fixup() validates the device-supplied per-packet
  length only against an upper bound (`pkt_len > dev->hard_mtu +…
- [High] Two of the three new USB id-table entries use a bcdDevice lower
  bound of 0 (`USB_DEVICE_VER(0x0b95, 0x1790, 0, 0x0200)` and…
- [High] ax88179a_netdev_ops sets `.ndo_eth_ioctl = usbnet_mii_ioctl`
  while ax88179a_bind() never populates struct usbnet's embedded…
- [High] ax88179a_rx_fixup() reads the trailing 8-byte RX descriptor
  header with `rx_hdr = *(u64 *)skb_tail_pointer(skb)` — no endianness…
- [High] Passing the address of a pointer to `ax88179_read_cmd`
  overwrites the local pointer variable, causing stack corruption.
- [Medium] ax88179a_stop() prepares `reg8 = 0` to power the Ethernet PHY
  down but then calls ax88179_read_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1,…
- [Medium] The commit message claims the device is by default handled by
  CDC-NCM and that this driver only takes over "if the ax88179_178a…
- [Medium] ax88179a_ethtool_ops mixes ABIs for one link object:
  `.get_link_ksettings = phy_ethtool_get_link_ksettings` /…
- [Medium] ax88179a_bulkin_config() applies the full-speed fallback only
  when chip_version == AX_VERSION_AX88279.
- [Medium] In ax88179a_tx_fixup() the skb_linearize() failure path does
  `return NULL` without freeing the skb.
- [Medium] ax88179_mdiobus_read() ignores the return value of
  ax88179_read_cmd(), and ax88179_read_cmd() with size == 2 copies its…
- [Medium] phylink_start() is called from ax88179a_reset() (the
  driver_info .reset hook, invoked early in usbnet_open()), but…
- [Medium] ax88179a_reset() calls phylink_start() (which queues the
  asynchronous phylink resolve work and starts the PHY state machine)…
- [Medium] AX_MEDIUM_STATUS_MODE is read-modify-written by
  ax88179_change_mtu() (process context, RTNL) and completely rewritten…
- [Medium] ax88179a_stop() disables the hardware (clears
  AX_MEDIUM_RECEIVE_EN, writes AX_RX_CTL = 0) *before* calling…
- [Medium] ax88179a_tx_fixup() writes an 8-byte TX descriptor into the
  SKB headroom (skb_push) and zero padding into the tailroom…
- [Medium] Undercounting TX packets for TSO super-packets.
- [Low] DISCARDED (fixed later in the same series): legacy
  ax88179_suspend()/ax88179_resume() applied to the phylink-managed…
- [Low] DISCARDED (fixed later in the same series): ax88179a_netdev_ops
  missing .ndo_vlan_rx_add_vid/.ndo_vlan_rx_kill_vid (which makes…
- [Low] ax88179a_bind() reads only three firmware-version bytes (`for
  (int i = 0; i < 3; i++)` from AX88179A_ACCESS_BL registers 0xFD..0xFF…

--

ax88179_178a: Add HW support for AX179A-based chips

This adds a new ax88179a_devices.c with bind/reset/stop/rx_fixup/tx_fixup
handlers plus phylink and MDIO bus support for the AX88179A/AX88772D/AX88279
family, and three new USB id-table entries selected by bcdDevice.  The
Kconfig select is switched from PHYLIB to PHYLINK.

A few questions below.

> diff --git a/drivers/net/usb/Makefile b/drivers/net/usb/Makefile
> index ddd76fa71e2ee..2ecead0181eaf 100644
> --- a/drivers/net/usb/Makefile
> +++ b/drivers/net/usb/Makefile
> @@ -13,7 +13,7 @@ obj-$(CONFIG_USB_LAN78XX)	+= lan78xx.o
>  obj-$(CONFIG_USB_NET_AX8817X)	+= asix.o
>  asix-y := asix_devices.o asix_common.o ax88172a.o
>  obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179.o
> -ax88179-y := ax88179_178a.o ax88179_lib.o
> +ax88179-y := ax88179_178a.o ax88179a_devices.o ax88179_lib.o

[ ... ]

> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 6aa35c8eb594f..33be9ef73e73d 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -1270,6 +1270,18 @@ static const struct driver_info at_umc2000sp_info = {
>  
>  static const struct usb_device_id products[] = {
>  {
> +	/* ASIX AX88179A USB 3.2 1000Mbit Ethernet */
> +	USB_DEVICE_VER(0x0b95, 0x1790, 0, 0x0200),
> +	.driver_info = (unsigned long)&ax88179a_info,
> +}, {
> +	/* ASIX AX88772D USB 2.0 100Mbit Ethernet */
> +	USB_DEVICE_VER(0x0b95, 0x1790, 0x0300, 0x0300),
> +	.driver_info = (unsigned long)&ax88772d_info,
> +}, {
> +	/* ASIX AX88279 USB 3.2 2500Mbit Ethernet */
> +	USB_DEVICE_VER(0x0b95, 0x1790, 0, 0x0400),
> +	.driver_info = (unsigned long)&ax88279_info,
> +}, {
>  	/* ASIX AX88179 10/100/1000 */
>  	USB_DEVICE_AND_INTERFACE_INFO(0x0b95, 0x1790, 0xff, 0xff, 0),
>  	.driver_info = (unsigned long)&ax88179_info,

[Severity: High]
Can the first and third entries claim the classic AX88179?  Two of the new
entries use a bcdDevice lower bound of 0, and they are placed ahead of the
pre-existing USB_DEVICE_AND_INTERFACE_INFO entry.

usb_match_device() only rejects when bcdDevice_lo > bcdDevice, and
USB_DEVICE_VER() sets no interface-class match flags, so
usb_match_one_id_intf() is never consulted.  usb_match_id() returns the
first hit in products[], which would now be:

	USB_DEVICE_VER(0x0b95, 0x1790, 0, 0x0200),
	.driver_info = (unsigned long)&ax88179a_info,

An existing 0x0b95:0x1790 dongle with bcdDevice 1.00 would then be bound
with ax88179a_bind()/ax88179a_info, which registers an MDIO bus, creates a
phylink instance and programs AX88179A-only vendor registers
(AX88179A_PHY_POWER, AX88179A_MAC_PATH, AX88179A_BFM_DATA).  ax88179a_bind()
reads AX_CHIP_STATUS but never rejects AX_VERSION_AX88179.

Would explicit lower bounds (0x0200 and 0x0400) match the commit message,
which states that bcdDevice 2.00/3.00/4.00 identify the three parts?

[Severity: Low]
This isn't a defect of the final series state, but at this commit the new
IDs share the existing usb_driver .suspend/.resume/.reset_resume callbacks,
so ax88179_resume() -> ax88179_reset() -> mii_nway_restart() runs against
dev->mii, whose mdio_read/mdio_write are never populated for these devices,
and phylink is neither suspended nor resumed.  This is addressed later in
the same series by "ax88179_178a: Add Suspend/resume support for
AX88179A/772D/279", which introduces per-instance suspend/resume pointers
and ax88179a_suspend()/ax88179a_resume().

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> new file mode 100644
> index 0000000000000..21ca71cba52ca
> --- /dev/null
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -0,0 +1,965 @@

[ ... ]

> +static const struct ax_bulkin_settings AX88179A_BULKIN_SIZE[] = {
> +	[BULK_IN_SPEED_1G_SS]		= {5, 0x7B, 0x00, 0x17, 0x0F},
> +	[BULK_IN_SPEED_1G_HS]		= {5, 0xC0, 0x02, 0x06, 0x0F},
> +	[BULK_IN_SPEED_100_FULL_SS]	= {7, 0xF0, 0x00, 0x0C, 0x0F},
> +	[BULK_IN_SPEED_100_HALF_SS]	= {6, 0x00, 0x00, 0x06, 0x0F},
> +	[BULK_IN_SPEED_100_FULL_HS]	= {5, 0xC0, 0x04, 0x06, 0x0F},
> +	[BULK_IN_SPEED_100_HALF_HS]	= {7, 0xC0, 0x04, 0x06, 0x0F},
> +	[BULK_IN_SPEED_FS]		= {7, 0x00, 0x00, 0x03, 0x3F},
> +};
> +
> +static const struct ax_bulkin_settings AX88772D_BULKIN_SIZE[] = {
> +	[BULK_IN_SPEED_100_FULL_HS]	= {5, 0xC0, 0x04, 0x06, 0x0F},
> +	[BULK_IN_SPEED_100_HALF_HS]	= {7, 0xC0, 0x04, 0x06, 0x0F},
> +	[BULK_IN_SPEED_FS]		= {7, 0x00, 0x00, 0x03, 0x3F},
> +};

[ ... ]

> +static int ax88179_mdiobus_read(struct mii_bus *bus, int phy_id, int regnum)
> +{

[ ... ]

> +	ax88179_read_cmd(dev, AX_ACCESS_PHY, phy_id, (__u16)regnum, 2, &res);
> +	return res;
> +}

[Severity: Medium]
Should the return value of ax88179_read_cmd() be checked here?  For size 2,
ax88179_read_cmd() in ax88179_lib.c copies its zero-initialised temporary
into the caller's variable regardless of the transfer result:

	u16 buf = 0;
	ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
	le16_to_cpus(&buf);
	*((u16 *)data) = buf;

So a failed or timed-out control transfer is reported to phylib as the
valid register value 0, which for BMSR reads as "link down, no
capabilities" and for BMCR as "autoneg disabled".  The Clause-45 sibling
ax179a_read_mmd() in this same file does propagate the error.

[ ... ]

> +static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts, u8 speed, bool full_duplex)
> +{
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	const struct ax_bulkin_settings *bulkin_data;
> +	int index = 0;
> +
> +	switch (speed) {

[ ... ]

> +	case ETHER_LINK_1000:	/* AX88279 & AX88178A */
> +		if (link_sts & AX_USB_SS)
> +			index = BULK_IN_SPEED_1G_SS;
> +		else if (link_sts & AX_USB_HS)
> +			index = BULK_IN_SPEED_1G_HS;
> +		break;
> +
> +	case ETHER_LINK_100:
> +		if (link_sts & AX_USB_SS)
> +			index = BULK_IN_SPEED_100_FULL_SS;
> +		else if (link_sts & AX_USB_HS)
> +			index = BULK_IN_SPEED_100_FULL_HS;
> +		if (!full_duplex)
> +			index++;
> +		break;

[ ... ]

> +	if (ax179_data->chip_version == AX_VERSION_AX88279 && (link_sts & AX_USB_FS))
> +		index = BULK_IN_SPEED_FS;

[ ... ]

> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, &bulkin_data[index]);
> +}

[Severity: Medium]
Can an all-zero bulk-in profile be written here for the AX88179A/AX88772D?

The full-speed fallback is applied only for AX_VERSION_AX88279.  For the
other parts, when link_sts has neither AX_USB_SS nor AX_USB_HS set, index
stays at 0 (BULK_IN_SPEED_2G5), or 1 for 100 Mbit half duplex.
AX88179A_BULKIN_SIZE[0] and AX88772D_BULKIN_SIZE[0..4] are not covered by
the designated initialisers, so {0, 0, 0, 0, 0} is written to
AX_RX_BULKIN_QCTRL.  An AX88772D on a full-speed port reports AX_USB_FS
only.

Related, in ax88179a_mac_link_up():

	ax88179_read_cmd(dev, AX_ACCESS_MAC, PHYSICAL_LINK_STATUS, 1, 1, &link_sts);
	ax88179a_bulkin_config(dev, link_sts, bulk_config_speed, !!duplex);

link_sts is an uninitialised stack byte and ax88179_read_cmd() only
zero-initialises its temporary for sizes 2 and 4, so a short or failed
transfer leaves stack garbage selecting the index.  Should the read result
be checked?

[ ... ]

> +static const struct ethtool_ops ax88179a_ethtool_ops = {
> +	.get_link		= ethtool_op_get_link,

[ ... ]

> +	.nway_reset		= usbnet_nway_reset,
> +	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
> +	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
> +	.get_pauseparam		= ax88179a_get_pauseparam,
> +	.set_pauseparam		= ax88179a_set_pauseparam,
> +	.get_ts_info		= ethtool_op_get_ts_info,
> +};

[Severity: Medium]
Is mixing the two ABIs for one link object intentional here?  The link
settings go through phylib directly on net->phydev, while pauseparam goes
through phylink.

phy_ethtool_set_link_ksettings() -> phy_ethtool_ksettings_set() validates
only against phydev->supported.  phylink_bringup_phy() restricts
phy->advertising:

	/* Restrict the phy advertisement according to the MAC support. */
	linkmode_copy(phy->advertising, config.advertising);

but leaves phy->supported untouched, so the mac_capabilities and
supported_interfaces set up in ax88179a_phylink_setup() are not enforced on
a user set, and pl->link_config ends up out of sync with what the
pauseparam entries in the same table operate on.
Documentation/networking/sfp-phylink.rst asks for
phylink_ethtool_ksettings_get()/_set() here.

Also, usbnet_nway_reset() tests dev->mii.mdio_write and returns -EOPNOTSUPP
when it is NULL, which is the case for these devices; would
phylink_ethtool_nway_reset() be the right callback?

[ ... ]

> +static const struct net_device_ops ax88179a_netdev_ops = {
> +	.ndo_open		= usbnet_open,
> +	.ndo_stop		= usbnet_stop,
> +	.ndo_start_xmit		= usbnet_start_xmit,
> +	.ndo_tx_timeout		= usbnet_tx_timeout,
> +	.ndo_get_stats64	= dev_get_tstats64,
> +	.ndo_change_mtu		= ax88179_change_mtu,
> +	.ndo_set_mac_address	= ax88179_set_mac_addr,
> +	.ndo_validate_addr	= eth_validate_addr,
> +	.ndo_eth_ioctl		= usbnet_mii_ioctl,
> +};

[Severity: High]
Can an MII ioctl on these interfaces hit a NULL function pointer?

ax88179a_bind() only sets dev->mii.supports_gmii, and the netdev private
area is zero-allocated, so mii.dev, mii.mdio_read and mii.mdio_write stay
NULL (unlike the legacy ax88179_bind(), which initialises all of them).

usbnet_mii_ioctl() has no guard:

	return generic_mii_ioctl(&dev->mii, if_mii(rq), cmd, NULL);

and generic_mii_ioctl() in drivers/net/mii.c calls the pointer directly:

	mii_data->val_out =
		mii_if->mdio_read(mii_if->dev, mii_data->phy_id,
				  mii_data->reg_num);

So SIOCGMIIPHY/SIOCGMIIREG (for example mii-tool eth0, with CAP_NET_ADMIN)
would call through a NULL mdio_read while dev_ioctl() holds rtnl.  Would
phylink_mii_ioctl() be the right handler for a phylink/mii_bus driver?

[Severity: Low]
This isn't a defect of the final series state, but at this commit the ops
table has no .ndo_vlan_rx_add_vid/.ndo_vlan_rx_kill_vid while
NETIF_F_HW_VLAN_CTAG_FILTER is advertised in ax88179a_bind(), which
register_netdevice() rejects with -EINVAL; .ndo_set_features and
.ndo_set_rx_mode are also absent.  All four are added later in the same
series by the VLAN offload and multicast patches.

> +static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
> +{
> +	struct usb_device *udev = interface_to_usbdev(intf);
> +	struct ax88179_data *ax179_data;
> +	int ret;
> +	u8 reg8;
> +
> +	/* Check if vendor configuration */
> +	if (udev->actconfig->desc.bConfigurationValue != 1) {
> +		netdev_info(dev->net, "Switching to vendor mode\n");
> +		usb_driver_set_configuration(udev, 1);
> +		return -ENODEV;
> +	}

[Severity: Medium]
The commit message says:

	"If the ax88179_178a module is configured by the OS to have
	precedence over CDC-NCM, then this driver will switch the device to
	use the vendor interface"

Is there anything in the patch that implements that opt-in?

The new USB_DEVICE_VER() entries carry no interface-class constraint, so
they also match the interfaces of the default CDC configuration.  Both
USB_NET_AX88179_178A and USB_NET_CDC_NCM are "default y", and ax88179.o is
linked before cdc_ncm.o in drivers/net/usb/Makefile, so for a built-in
build whichever probe runs first wins.  When this driver wins,
usb_driver_set_configuration(udev, 1) switches the device out of CDC-NCM
mode unconditionally.

Could the commit message describe the actual behaviour, or could the match
be restricted to the vendor configuration?

[ ... ]

> +	for (int i = 0; i < 3; i++) {
> +		ret = ax88179_read_cmd(dev, AX88179A_ACCESS_BL, (0xFD + i),
> +				       1, 1, &ax179_data->fw_version[i]);
> +		if (ret < 0)
> +			ax179_data->fw_version[i] = 0xff;
> +	}
> +	netdev_info(dev->net, "AX88179A/279/772D Chip Version: %x, FW: %d.%d.%d.%d\n",
> +		    ax179_data->chip_version,
> +		    ax179_data->fw_version[0], ax179_data->fw_version[1],
> +		    ax179_data->fw_version[2], ax179_data->fw_version[3]);

[Severity: Low]
The loop fills fw_version[0..2] but four components are printed, so the
last one is always the kzalloc-provided 0 and never comes from the device.
Is the loop bound or the register base off by one (four registers would be
0xFC..0xFF)?  The same array is exported through ethtool later in the
series.

[ ... ]

> +static void ax88179a_mac_link_up(struct phylink_config *config,

[ ... ]

> +	if (duplex)
> +		mode |= AX_MEDIUM_FULL_DUPLEX;
> +
> +	if (dev->net->mtu > 1500)
> +		mode |= AX_MEDIUM_JUMBO_EN;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &mode);

[Severity: Medium]
What serialises AX_MEDIUM_STATUS_MODE between this callback and
ax88179_change_mtu()?

ax88179_change_mtu() (now wired in as .ndo_change_mtu) does a
read-modify-write with sleeping control transfers in between:

	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &tmp16);
	tmp16 |= AX_MEDIUM_JUMBO_EN;
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &tmp16);

That runs under rtnl, while ax88179a_mac_link_up() runs from the phylink
resolve work under phylink's state_mutex and rewrites the whole register.
If change_mtu reads while the link is down and writes back after a
link-up, can the gigabit/duplex/flow-control bits be lost (or the jumbo bit
be dropped in the reverse order)?

[ ... ]

> +static int ax88179a_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
> +{

[ ... ]

> +	if (!skb || skb->len < sizeof(rx_hdr))
> +		goto err;
> +
> +	/* RX Descriptor Header */
> +	skb_trim(skb, skb->len - sizeof(rx_hdr));
> +	rx_hdr = *(u64 *)skb_tail_pointer(skb);

[Severity: High]
Is the endianness handling of the descriptors incomplete here?

rx_hdr is read with a plain u64 dereference and no conversion at all, while
the first per-packet descriptor gets le64_to_cpus() and every later one is
dereferenced raw after pkt_desc_ptr++.  The wire format looks
little-endian: ax88179a_tx_fixup() uses put_unaligned_le64() and the legacy
parser uses get_unaligned_le32() on the same trailing header.

On a big-endian host pkt_cnt and hdr_off would be byte-swapped, so the
consistency checks reject the URB; when a multi-packet URB does pass, every
descriptor after the first is decoded with the wrong length, RX_OK, DROP,
checksum and VLAN fields.

Both accesses are also unaligned: usbnet allocates RX buffers with
__netdev_alloc_skb_ip_align(), and hdr_off is a device-supplied 19-bit
value, so the 8-byte loads can land at 2-mod-8 addresses.  Would
get_unaligned_le64() inside the loop be the right accessor?

[ ... ]

> +	pkt_end = 0;
> +	while (pkt_cnt--) {
> +		u64 pkt_desc = *pkt_desc_ptr;
> +		u32 pkt_len_plus_padd;
> +		u32 pkt_len;
> +
> +		pkt_len = (u32)((pkt_desc & AX179A_RX_PD_LEN_MASK) >> AX179A_RX_PD_LEN_SHIFT)
> +			  - (ax179_data->ip_align ? 2 : 0);
> +		pkt_len_plus_padd = ((pkt_len + 7 + (ax179_data->ip_align ? 2 : 0)) & 0x7FFF8);
> +
> +		pkt_end += pkt_len_plus_padd;
> +		if (pkt_end > hdr_off || (pkt_cnt == 0 && pkt_end != hdr_off))
> +			goto err;
> +
> +		if (pkt_desc & AX179A_RX_PD_DROP || !(pkt_desc & AX179A_RX_PD_RX_OK) ||
> +		    pkt_len > (dev->hard_mtu + AX179A_RX_HW_PAD)) {
> +			skb_pull(skb, pkt_len_plus_padd);
> +
> +			/* Next RX Packet Descriptor */
> +			pkt_desc_ptr++;
> +			continue;
> +		}
> +
> +		ax_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len);
> +		if (!ax_skb)
> +			goto err;
> +
> +		skb_put(ax_skb, pkt_len);
> +		memcpy(ax_skb->data, skb->data + (ax179_data->ip_align ? AX179A_RX_HW_PAD : 0),
> +		       pkt_len);

[Severity: Critical]
Should pkt_len also be checked against a lower bound?  Only the upper bound
and the device-supplied DROP/RX_OK flags are tested, so a device-reported
pkt_len of 1..13 is accepted and passed up.

For pkt_len = 1, pkt_len_plus_padd = (1 + 7) & 0x7FFF8 = 8, so a
single-descriptor URB with hdr_off = 8 satisfies both pkt_end > hdr_off and
the final pkt_cnt == 0 && pkt_end != hdr_off check.

usbnet_skb_return() then calls eth_type_trans(), which reads a full struct
ethhdr from a 1-byte skb and does skb_pull_inline(skb, ETH_HLEN),
underflowing skb->len to roughly 4 GiB before netif_rx().  Every later
pskb_may_pull() then succeeds trivially.

The core backstop does not apply here, because rx_process() bails out
before the runt check for FLAG_MULTI_PACKET drivers, and all three new
driver_info entries set that flag:

drivers/net/usb/usbnet.c:rx_process() {
	if (dev->driver_info->flags & FLAG_MULTI_PACKET)
		return -EALREADY;

	if (skb->len < ETH_HLEN) {
	...
}

The legacy ax88179_rx_fixup() rejects short frames explicitly:

	if ((*pkt_hdr & (AX_RXHDR_CRC_ERR | AX_RXHDR_DROP_ERR)) ||
	    pkt_len < 2 + ETH_HLEN) {

Was dropping that check intentional?

[ ... ]

> +static struct sk_buff *ax88179a_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
> +{

[ ... ]

> +	if (!dev->can_dma_sg && (dev->net->features & NETIF_F_SG) && skb_linearize(skb))
> +		return NULL;

[Severity: Medium]
Does this path leak the skb?  skb_linearize() does not free on failure, and
because all three driver_info entries set FLAG_MULTI_PACKET,
usbnet_start_xmit() treats the NULL return as "packet collected":

drivers/net/usb/usbnet.c:usbnet_start_xmit() {
	skb = info->tx_fixup(dev, skb, GFP_ATOMIC);
	if (!skb) {
		if (info->flags & FLAG_MULTI_PACKET)
			goto not_drop;
	...
not_drop:
	if (skb)
		dev_kfree_skb_any(skb);
}

so nothing is freed and tx_dropped is not accounted.  The skb_copy_expand()
failure path a few lines below does call dev_kfree_skb_any(skb) first.

> +	headroom = skb_headroom(skb);
> +	tailroom = skb_tailroom(skb);
> +
> +	if (!(headroom >= sizeof(tx_desc) && tailroom >= padding_size)) {
> +		ax_skb = skb_copy_expand(skb, sizeof(tx_desc), padding_size, flags);
> +		dev_kfree_skb_any(skb);
> +		skb = ax_skb;
> +		if (!skb)
> +			return NULL;
> +	}
> +	if (padding_size != 0)
> +		skb_put_zero(skb, padding_size);
> +	/* Copy TX header */
> +	tx_desc_ptr = skb_push(skb, sizeof(tx_desc));
> +	put_unaligned_le64(tx_desc, tx_desc_ptr);

[Severity: Medium]
Should this check skb_cloned()/skb_header_cloned() before writing into the
shared data buffer?  The only gate is the numeric head/tailroom test, and
dev->net->needed_headroom is set to 8 in ax88179a_bind(), so a cloned but
roomy skb (TCP retransmit clone, or an AF_PACKET tap clone created by
dev_queue_xmit_nit()) takes the no-copy path.  skb_push() then writes 8
bytes ahead of skb->data and skb_put_zero() writes past skb->tail inside
the buffer every clone still shares.  skb_linearize() is a no-op for an
already-linear clone.

The legacy ax88179_tx_fixup() guards this:

	if ((skb_header_cloned(skb) || headroom < 0) &&
	    pskb_expand_head(skb, headroom < 0 ? 8 : 0, 0, GFP_ATOMIC)) {

[ ... ]

> +static int ax88179a_reset(struct usbnet *dev)
> +{

[ ... ]

> +	phylink_start(ax179_data->phylink);
> +
> +	usbnet_link_change(dev, 0, 0);
> +
> +	return 0;
> +}

[Severity: Medium]
Are phylink_start() and phylink_stop() balanced on the failed-open path?
phylink_start() runs from the .reset hook early in usbnet_open(), but
phylink_stop() only runs from ax88179a_stop(), which is reached via
ndo_stop.  If usbnet_open() fails after info->reset() succeeded:

drivers/net/usb/usbnet.c:usbnet_open() {
	if (dev->interrupt) {
		retval = usbnet_status_start(dev, GFP_KERNEL);
		if (retval < 0) {
			...
			goto done;
		}
	}
}

the done: label only does usb_autopm_put_interface() and returns, so
ndo_stop is never called.  phylink and the PHY state machine then keep
running on a down interface, ax88179a_mac_link_up() can re-enable
AX88179A_MAC_PATH and rxctl, and a later successful open would call
phylink_start()/phy_start() a second time.  These devices do have an
interrupt endpoint, and usbnet_status_start() can fail with
-ENOMEM/-ENODEV/-EBUSY.

[Severity: Medium]
Can the carrier state end up stuck down here?  phylink_start() queues the
asynchronous resolve and starts the PHY, then usbnet_link_change(dev, 0, 0)
runs synchronously:

drivers/net/usb/usbnet.c:usbnet_link_change() {
	clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags);
	netif_carrier_off(dev->net);
}

If phylink_resolve() has already called netif_carrier_on(), this clears the
carrier behind phylink's back, and phylink only touches the carrier on
state changes:

drivers/net/phy/phylink.c:phylink_resolve() {
	if (link_state.link != cur_link_state) {
		pl->old_link_state = link_state.link;
}

Since data->phydev->irq is PHY_MAC_INTERRUPT there is no polling, so
nothing re-runs the resolve until the next real link event.  The two
writers share no lock (rtnl versus phylink state_mutex).

> +static int ax88179a_stop(struct usbnet *dev)
> +{
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	u16 reg16;
> +	u8 reg8;
> +
> +	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);
> +	reg16 &= ~AX_MEDIUM_RECEIVE_EN;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);
> +
> +	reg16 = 0;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &reg16);
> +
> +	reg8 = 0;
> +	ax88179_read_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);

[Severity: Medium]
Is this meant to be ax88179_write_cmd()?  reg8 is set to 0 to power the PHY
down, but a read is issued, so nothing reaches the device and reg8 is
overwritten by the readback.  Both ax88179a_reset() and ax88179a_unbind()
use a write for the same register:

	tmp8 = 0;
	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &tmp8);

> +
> +	phylink_stop(ax179_data->phylink);
> +
> +	return 0;
> +}

[Severity: Medium]
Would phylink_stop() belong before the register writes?  A resolve already
in flight can run ax88179a_mac_link_up() between the AX_RX_CTL = 0 write
and phylink_stop(), and its tail restores exactly what was just disabled:

	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &mode);
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &ax179_data->rxctl);

	tmp8 = AX_MAC_RX_PATH_READY | AX_MAC_TX_PATH_READY;
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 1, &tmp8);

Since ax88179a_mac_link_down() is empty, the final resolve inside
phylink_stop() would not undo them, leaving the device RX/TX-enabled after
ndo_stop.  Each step here is separated by a sleeping control transfer.

[ ... ]

> @@ -0,0 +1,965 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/module.h>
> +#include <linux/phylink.h>
> +#include <linux/if_vlan.h>
> +#include "ax88179_lib.h"
> +
> +#define AX88279_EEPROM_LEN			0x4000
> +#define AX88179A_EEPROM_LEN			(32 * 20)
> +
> +enum ax_bulk_in_speeds {
> +	BULK_IN_SPEED_2G5 = 0,
> +	BULK_IN_SPEED_1G_SS = 1,
> +	BULK_IN_SPEED_1G_HS   = 2,
> +	BULK_IN_SPEED_100_FULL_SS = 3,
> +	BULK_IN_SPEED_100_HALF_SS = 4,
> +	BULK_IN_SPEED_100_FULL_HS = 5,
> +	BULK_IN_SPEED_100_HALF_HS = 6,
> +	BULK_IN_SPEED_FS = 7,
> +};
> +
> +static const struct ax_bulkin_settings AX88179A_BULKIN_SIZE[] = {
> +	[BULK_IN_SPEED_1G_SS]		= {5, 0x7B, 0x00, 0x17, 0x0F},
> +	[BULK_IN_SPEED_1G_HS]		= {5, 0xC0, 0x02, 0x06, 0x0F},
> +	[BULK_IN_SPEED_100_FULL_SS]	= {7, 0xF0, 0x00, 0x0C, 0x0F},
> +	[BULK_IN_SPEED_100_HALF_SS]	= {6, 0x00, 0x00, 0x06, 0x0F},
> +	[BULK_IN_SPEED_100_FULL_HS]	= {5, 0xC0, 0x04, 0x06, 0x0F},
> +	[BULK_IN_SPEED_100_HALF_HS]	= {7, 0xC0, 0x04, 0x06, 0x0F},
> +	[BULK_IN_SPEED_FS]		= {7, 0x00, 0x00, 0x03, 0x3F},
> +};
> +
> +static const struct ax_bulkin_settings AX88772D_BULKIN_SIZE[] = {
> +	[BULK_IN_SPEED_100_FULL_HS]	= {5, 0xC0, 0x04, 0x06, 0x0F},
> +	[BULK_IN_SPEED_100_HALF_HS]	= {7, 0xC0, 0x04, 0x06, 0x0F},
> +	[BULK_IN_SPEED_FS]		= {7, 0x00, 0x00, 0x03, 0x3F},
> +};
> +
> +static const struct ax_bulkin_settings AX88279_BULKIN_SIZE[] = {
> +	[BULK_IN_SPEED_2G5]		= {5, 0x10, 0x01, 0x11, 0x0F},
> +	[BULK_IN_SPEED_1G_SS]		= {7, 0xB3, 0x01, 0x11, 0x0F},
> +	[BULK_IN_SPEED_1G_HS]		= {7, 0xC0, 0x02, 0x06, 0x0F},
> +	[BULK_IN_SPEED_100_FULL_SS]	= {7, 0x80, 0x01, 0x03, 0x0F},
> +	[BULK_IN_SPEED_100_HALF_SS]	= {7, 0x80, 0x01, 0x03, 0x0F},
> +	[BULK_IN_SPEED_100_FULL_HS]	= {7, 0x80, 0x01, 0x03, 0x0F},
> +	[BULK_IN_SPEED_100_HALF_HS]	= {7, 0x80, 0x01, 0x03, 0x0F},
> +	[BULK_IN_SPEED_FS]		= {7, 0x00, 0x00, 0x03, 0x3F},
> +};
> +
> +static int ax88179_mdiobus_read(struct mii_bus *bus, int phy_id, int regnum)
> +{
> +	struct usbnet *dev = bus->priv;
> +	struct ax88179_data *priv;
> +	u16 res;
> +
> +	priv = dev->driver_priv;
> +	/* When reading PHYSID, return unused PHY-IDs from the ASIX vendor range */
> +	if (phy_id == AX88179_PHY_ID && regnum == MII_PHYSID1)
> +		return 0x003b;
> +	if (phy_id == AX88179_PHY_ID && regnum == MII_PHYSID2) {
> +		if (priv->chip_version == AX_VERSION_AX88179A && priv->is_ax88772d)
> +			return 0x772d;
> +		else if (priv->chip_version == AX_VERSION_AX88179A)
> +			return 0x179a;
> +		else if (priv->chip_version == AX_VERSION_AX88279)
> +			return 0x2790;
> +	}
> +
> +	ax88179_read_cmd(dev, AX_ACCESS_PHY, phy_id, (__u16)regnum, 2, &res);
> +	return res;
> +}
> +
> +static int ax88179_mdiobus_write(struct mii_bus *bus, int phy_id, int regnum, u16 val)
> +{
> +	struct usbnet *dev = bus->priv;
> +
> +	return ax88179_write_cmd(dev, AX_ACCESS_PHY, phy_id, (__u16)regnum, 2, &val);
> +}
> +
> +static int ax179a_read_mmd(struct usbnet *dev, u16 dev_addr, u16 reg)
> +{
> +	u16 res;
> +	int ret;
> +
> +	ret = ax88179_read_cmd(dev, AX88179A_PHY_CLAUSE45, dev_addr, reg, 2, &res);
> +	if (ret < 0)
> +		return ret;
> +	return res;
> +}
> +
> +static int ax179a_write_mmd(struct usbnet *dev, u16 dev_addr, u16 reg, u16 data)
> +{
> +	return ax88179_write_cmd(dev, AX88179A_PHY_CLAUSE45, dev_addr, reg, 2, &data);
> +}
> +
> +static int ax88179_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum, int regnum)
> +{
> +	struct usbnet *dev = bus->priv;
> +
> +	if (addr != AX88179_PHY_ID)
> +		return -EINVAL;
> +
> +	return ax179a_read_mmd(dev, devnum, regnum);
> +}
> +
> +static int ax88179_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
> +				     int regnum, u16 val)
> +{
> +	struct usbnet *dev = bus->priv;
> +
> +	if (addr != AX88179_PHY_ID)
> +		return -EINVAL;
> +
> +	return ax179a_write_mmd(dev, devnum, regnum, val);
> +}
> +
> +static void ax88179a_status(struct usbnet *dev, struct urb *urb)
> +{
> +	struct ax88179_data *data = dev->driver_priv;
> +
> +	if (urb->actual_length < 8)
> +		return;
> +
> +	phylink_mac_interrupt(data->phylink);
> +}
> +
> +static int ax88179a_auto_detach(struct usbnet *dev)
> +{
> +	u16 tmp16;
> +
> +	tmp16 = AX88179A_AUTODETACH_DELAY;
> +	ax88179_write_cmd(dev, AX88179A_AUTODETACH, tmp16, 0, 0, NULL);
> +	return 0;
> +}
> +
> +static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts, u8 speed, bool full_duplex)
> +{
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	const struct ax_bulkin_settings *bulkin_data;
> +	int index = 0;
> +
> +	switch (speed) {
> +	case ETHER_LINK_2500:	/* AX88279 only */
> +		index = BULK_IN_SPEED_2G5;
> +		break;
> +
> +	case ETHER_LINK_1000:	/* AX88279 & AX88178A */
> +		if (link_sts & AX_USB_SS)
> +			index = BULK_IN_SPEED_1G_SS;
> +		else if (link_sts & AX_USB_HS)
> +			index = BULK_IN_SPEED_1G_HS;
> +		break;
> +
> +	case ETHER_LINK_100:
> +		if (link_sts & AX_USB_SS)
> +			index = BULK_IN_SPEED_100_FULL_SS;
> +		else if (link_sts & AX_USB_HS)
> +			index = BULK_IN_SPEED_100_FULL_HS;
> +		if (!full_duplex)
> +			index++;
> +		break;
> +
> +	case ETHER_LINK_10:
> +		index = BULK_IN_SPEED_FS;
> +		break;
> +
> +	default:	/* No link */
> +		index = BULK_IN_SPEED_FS;
> +	}
> +
> +	if (ax179_data->chip_version == AX_VERSION_AX88279 && (link_sts & AX_USB_FS))
> +		index = BULK_IN_SPEED_FS;
> +
> +	if (ax179_data->chip_version == AX_VERSION_AX88279) {
> +		bulkin_data = AX88279_BULKIN_SIZE;
> +	} else {
> +		if (ax179_data->is_ax88772d)
> +			bulkin_data = AX88772D_BULKIN_SIZE;
> +		else
> +			bulkin_data = AX88179A_BULKIN_SIZE;
> +	}
> +
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, &bulkin_data[index]);
> +}
> +
> +static void ax88179a_get_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
> +{
> +	struct ax88179_data *data = netdev2data(net);
> +
> +	phylink_ethtool_get_pauseparam(data->phylink, pause);
> +}
> +
> +static int ax88179a_set_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
> +{
> +	struct ax88179_data *data = netdev2data(net);
> +
> +	return phylink_ethtool_set_pauseparam(data->phylink, pause);
> +}
> +
> +static int ax88179a_get_eeprom_len(struct net_device *net)
> +{
> +	struct ax88179_data *ax179_data = netdev2data(net);
> +
> +	if (ax179_data->chip_version >= AX_VERSION_AX88279)
> +		return AX88279_EEPROM_LEN;
> +	else
> +		return AX88179A_EEPROM_LEN;
> +}
> +
> +static const struct ethtool_ops ax88179a_ethtool_ops = {
> +	.get_link		= ethtool_op_get_link,
> +	.get_msglevel		= usbnet_get_msglevel,
> +	.set_msglevel		= usbnet_set_msglevel,
> +	.get_wol		= ax88179_get_wol,
> +	.set_wol		= ax88179_set_wol,
> +	.get_eeprom_len		= ax88179a_get_eeprom_len,
> +	.get_eeprom		= ax88179_get_eeprom,
> +	.set_eeprom		= ax88179_set_eeprom,
> +	.nway_reset		= usbnet_nway_reset,
> +	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
> +	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
> +	.get_pauseparam		= ax88179a_get_pauseparam,
> +	.set_pauseparam		= ax88179a_set_pauseparam,
> +	.get_ts_info		= ethtool_op_get_ts_info,
> +};
> +
> +static void ax88179a_mdio_unregister(struct ax88179_data *data)
> +{
> +	mdiobus_unregister(data->mdio);
> +	mdiobus_free(data->mdio);
> +}
> +
> +static int ax88179a_init_phy(struct usbnet *dev)
> +{
> +	struct ax88179_data *data = dev->driver_priv;
> +	int ret;
> +
> +	data->phydev = mdiobus_get_phy(data->mdio, AX88179_PHY_ID);
> +	if (!data->phydev) {
> +		netdev_err(dev->net, "Could not find PHY\n");
> +		return -ENODEV;
> +	}
> +
> +	data->phydev->irq = PHY_MAC_INTERRUPT;
> +	ret = phylink_connect_phy(data->phylink, data->phydev);
> +	if (ret) {
> +		netdev_err(dev->net, "Could not connect PHY\n");
> +		return ret;
> +	}
> +
> +	phy_suspend(data->phydev);
> +	data->phydev->mac_managed_pm = true;
> +
> +	phy_attached_info(data->phydev);
> +
> +	return 0;
> +}
> +
> +static void ax88179a_mac_config(struct phylink_config *config, unsigned int mode,
> +				const struct phylink_link_state *state)
> +{
> +	/* Nothing to do */
> +}
> +
> +static void ax88179a_mac_link_down(struct phylink_config *config,
> +				   unsigned int mode, phy_interface_t interface)
> +{
> +	/* Nothing to do */
> +}
> +
> +static void ax88179a_mac_link_up(struct phylink_config *config,
> +				 struct phy_device *phy,
> +				 unsigned int phy_mode, phy_interface_t interface,
> +				 int speed, int duplex,
> +				 bool tx_pause, bool rx_pause)
> +{
> +	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	u8 tmp8, link_sts, reg8[3];
> +	u8 bulk_config_speed = 0;
> +	u16 tmp16, mode;
> +
> +	/* Stop RX/TX for link configuration */
> +	tmp16 = AX_RX_CTL_STOP;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);
> +	tmp8 = 0;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 1, &tmp8);
> +
> +	tmp8 = 0xa5;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_CDC_DELAY_TX, 1, 1, &tmp8);
> +
> +	tmp16 = 0x0410;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 2, 2, &tmp16);
> +
> +	tmp8 = 0;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_ETH_TX_GAP, 1, 1, &tmp8);
> +
> +	tmp8 = 0x07;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_EP5_EHR, 1, 1, &tmp8);
> +
> +	tmp8 = 0x28 | AX_NEW_PAUSE_EN;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_NEW_PAUSE_CTRL, 1, 1, &tmp8);
> +
> +	mode = AX_MEDIUM_RECEIVE_EN;
> +	if (tx_pause)
> +		mode |= AX_MEDIUM_TXFLOW_CTRLEN;
> +	if (rx_pause)
> +		mode |= AX_MEDIUM_RXFLOW_CTRLEN;
> +
> +	switch (speed) {
> +	case SPEED_2500:
> +		reg8[0] = 0x00;
> +		reg8[1] = 0xF8;
> +		reg8[2] = 0x07;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_TX_PAUSE, 3, 3, reg8);
> +
> +		reg8[0] = 0x78;
> +		reg8[1] = (AX_LSOFC_WCNT_7_ACCESS << 5);
> +		reg8[2] = 0;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_STATUS_CDC, 3, 3, reg8);
> +
> +		reg8[0] = 0x40;
> +		reg8[1] = AX_MAC_MIQFFCTRL_FORMAT | AX_MAC_MIQFFCTRL_DROP_CRC | AX_MAC_LSO_ERR_EN;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 2, 2, reg8);
> +
> +		tmp8 = AX_XGMII_EN;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_BFM_DATA, 1, 1, &tmp8);
> +
> +		tmp8 = 0x1C | AX_LSO_ENHANCE_EN;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_LSO_ENHANCE_CTRL, 1, 1, &tmp8);
> +
> +		mode |= AX_MEDIUM_GIGAMODE | AX_MEDIUM_FULL_DUPLEX;
> +		bulk_config_speed = ETHER_LINK_2500;
> +
> +		break;
> +
> +	case SPEED_1000:
> +		mode |= AX_MEDIUM_GIGAMODE;
> +		bulk_config_speed = ETHER_LINK_1000;
> +		fallthrough;
> +
> +	case SPEED_100:
> +		reg8[0] = 0x78;
> +		reg8[1] = (AX_LSOFC_WCNT_7_ACCESS << 5) | AX_GMII_CRC_APPEND;
> +		reg8[2] = 0;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_STATUS_CDC, 3, 3, reg8);
> +
> +		tmp8 = 0x40;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 1, &tmp8);
> +		if (!bulk_config_speed)
> +			bulk_config_speed = ETHER_LINK_100;
> +		break;
> +
> +	case SPEED_10:
> +		reg8[0] = 0xFA;
> +		reg8[1] = (AX_LSOFC_WCNT_7_ACCESS << 5) | AX_GMII_CRC_APPEND;
> +		reg8[2] = 0xFF;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_STATUS_CDC, 3, 3, reg8);
> +
> +		tmp8 = 0xFA;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 1, &tmp8);
> +
> +		bulk_config_speed = ETHER_LINK_10;
> +		break;
> +	}
> +
> +	ax88179_read_cmd(dev, AX_ACCESS_MAC, PHYSICAL_LINK_STATUS, 1, 1, &link_sts);
> +	ax88179a_bulkin_config(dev, link_sts, bulk_config_speed, !!duplex);
> +
> +	if (ax179_data->chip_version < AX_VERSION_AX88279) {
> +		tmp8 = 0;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_BFM_DATA, 1, 1, &tmp8);
> +	}
> +
> +	if (duplex)
> +		mode |= AX_MEDIUM_FULL_DUPLEX;
> +
> +	if (dev->net->mtu > 1500)
> +		mode |= AX_MEDIUM_JUMBO_EN;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &mode);
> +
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &ax179_data->rxctl);
> +
> +	tmp8 = AX_MAC_RX_PATH_READY | AX_MAC_TX_PATH_READY;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 1, &tmp8);
> +}
> +
> +static const struct phylink_mac_ops ax88179a_phylink_mac_ops = {
> +	.mac_config = ax88179a_mac_config,
> +	.mac_link_down = ax88179a_mac_link_down,
> +	.mac_link_up = ax88179a_mac_link_up,
> +};
> +
> +static int ax88179a_phylink_setup(struct usbnet *dev)
> +{
> +	struct ax88179_data *data = dev->driver_priv;
> +	phy_interface_t phy_if_mode;
> +	struct phylink *phylink;
> +
> +	data->phylink_config.dev = &dev->net->dev;
> +	data->phylink_config.type = PHYLINK_NETDEV;
> +	data->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE | MAC_100;
> +	if (data->is_ax88772d)
> +		data->phylink_config.mac_capabilities |= MAC_10;
> +	else if (data->chip_version < AX_VERSION_AX88279)
> +		data->phylink_config.mac_capabilities |= MAC_10 | MAC_1000;
> +	else
> +		data->phylink_config.mac_capabilities |= MAC_1000 | MAC_2500FD;
> +
> +	if (!data->is_ax88772d) {
> +		data->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
> +		data->phylink_config.eee_enabled_default = false;
> +	}
> +
> +	if (data->chip_version == AX_VERSION_AX88279) {
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  data->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  data->phylink_config.supported_interfaces);
> +		phy_if_mode = PHY_INTERFACE_MODE_2500BASEX;
> +	} else {
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  data->phylink_config.supported_interfaces);
> +		phy_if_mode = PHY_INTERFACE_MODE_SGMII;
> +	}
> +
> +	phylink = phylink_create(&data->phylink_config, dev->net->dev.fwnode,
> +				 phy_if_mode, &ax88179a_phylink_mac_ops);
> +	if (IS_ERR(phylink))
> +		return PTR_ERR(phylink);
> +
> +	data->phylink = phylink;
> +	return 0;
> +}
> +
> +static int ax88179a_init_mdio(struct usbnet *dev)
> +{
> +	struct ax88179_data *data = dev->driver_priv;
> +	int ret;
> +
> +	data->mdio = mdiobus_alloc();
> +	if (!data->mdio)
> +		return -ENOMEM;
> +
> +	data->mdio->priv = dev;
> +	data->mdio->read = ax88179_mdiobus_read;
> +	data->mdio->write = ax88179_mdiobus_write;
> +	data->mdio->read_c45 = ax88179_mdiobus_read_c45;
> +	data->mdio->write_c45 = ax88179_mdiobus_write_c45;
> +	data->mdio->name = "AX88179A MDIO Bus";
> +	data->mdio->phy_mask = ~(1 << AX88179_PHY_ID);
> +	/* mii bus name is usb-<usb bus number>-<usb device number> */
> +	snprintf(data->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
> +		 dev->udev->bus->busnum, dev->udev->devnum);
> +
> +	ret = mdiobus_register(data->mdio);
> +	if (ret) {
> +		netdev_err(dev->net, "Could not register MDIO bus (err %d)\n", ret);
> +		mdiobus_free(data->mdio);
> +		data->mdio = NULL;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct net_device_ops ax88179a_netdev_ops = {
> +	.ndo_open		= usbnet_open,
> +	.ndo_stop		= usbnet_stop,
> +	.ndo_start_xmit		= usbnet_start_xmit,
> +	.ndo_tx_timeout		= usbnet_tx_timeout,
> +	.ndo_get_stats64	= dev_get_tstats64,
> +	.ndo_change_mtu		= ax88179_change_mtu,
> +	.ndo_set_mac_address	= ax88179_set_mac_addr,
> +	.ndo_validate_addr	= eth_validate_addr,
> +	.ndo_eth_ioctl		= usbnet_mii_ioctl,
> +};
> +
> +static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
> +{
> +	struct usb_device *udev = interface_to_usbdev(intf);
> +	struct ax88179_data *ax179_data;
> +	int ret;
> +	u8 reg8;
> +
> +	/* Check if vendor configuration */
> +	if (udev->actconfig->desc.bConfigurationValue != 1) {
> +		netdev_info(dev->net, "Switching to vendor mode\n");
> +		usb_driver_set_configuration(udev, 1);
> +		return -ENODEV;
> +	}
> +
> +	ret = usbnet_get_endpoints(dev, intf);
> +	if (ret < 0)
> +		return ret;
> +
> +	ax179_data = kzalloc_obj(*ax179_data);
> +	if (!ax179_data)
> +		return -ENOMEM;
> +
> +	dev->driver_priv = ax179_data;
> +
> +	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_CHIP_STATUS,
> +			       1, 1, &ax179_data->chip_version);
> +	if (ret < 0)
> +		goto err_nodev;
> +
> +	ax179_data->chip_version = (ax179_data->chip_version & 0xf0) >> 4;
> +	ax179_data->is_ax88772d = 0;
> +	if (ax179_data->chip_version == AX_VERSION_AX88179A) {
> +		if (le16_to_cpu(udev->descriptor.bcdDevice) == 0x300)
> +			ax179_data->is_ax88772d = 1;
> +	}
> +
> +	for (int i = 0; i < 3; i++) {
> +		ret = ax88179_read_cmd(dev, AX88179A_ACCESS_BL, (0xFD + i),
> +				       1, 1, &ax179_data->fw_version[i]);
> +		if (ret < 0)
> +			ax179_data->fw_version[i] = 0xff;
> +	}
> +	netdev_info(dev->net, "AX88179A/279/772D Chip Version: %x, FW: %d.%d.%d.%d\n",
> +		    ax179_data->chip_version,
> +		    ax179_data->fw_version[0], ax179_data->fw_version[1],
> +		    ax179_data->fw_version[2], ax179_data->fw_version[3]);
> +
> +	/* The AX88279 requires both the AX_RX_CTL_IPE and AX_RX_CTL_DROPCRCERR
> +	 * bits set in AX_RX_CTL for creating correct RX-URBs. AX_RX_CTL_DROPCRCERR
> +	 * is anyway set for all chips, make sure AX_RX_CTL_IPE is set via ip_align.
> +	 * Also configure eeprom access parameters.
> +	 */
> +	if (ax179_data->chip_version == AX_VERSION_AX88279) {
> +		ax179_data->ip_align = 1;
> +		ax179_data->eeprom_read_cmd = AX88179A_FLASH_READ;
> +		ax179_data->eeprom_write_cmd = AX88179A_FLASH_WRITE;
> +		ax179_data->eeprom_block = 256;
> +		ax179_data->eeprom_wen = 1;
> +	} else {
> +		ax179_data->ip_align = 0;
> +		ax179_data->eeprom_read_cmd = AX_ACCESS_EFUS;
> +		ax179_data->eeprom_write_cmd = AX_ACCESS_EFUS;
> +		ax179_data->eeprom_block = 20;
> +		ax179_data->eeprom_wen = 0;
> +	}
> +
> +	dev->net->netdev_ops = &ax88179a_netdev_ops;
> +	dev->net->ethtool_ops = &ax88179a_ethtool_ops;
> +	dev->net->needed_headroom = 8;
> +	dev->net->needed_tailroom = 8;
> +	dev->net->min_mtu = ETH_MIN_MTU;
> +	dev->hard_mtu = 9 * 1024;
> +	dev->net->max_mtu = dev->hard_mtu - dev->net->hard_header_len;
> +
> +	if (!ax179_data->is_ax88772d)
> +		dev->mii.supports_gmii = 1;
> +
> +	dev->net->features |= NETIF_F_SG | NETIF_F_IP_CSUM |
> +			      NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO |
> +			      NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
> +			      NETIF_F_HW_VLAN_CTAG_FILTER;
> +
> +	dev->net->hw_features |= dev->net->features;
> +
> +	dev->net->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM |
> +				  NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO;
> +
> +	netif_set_tso_max_size(dev->net, 16384);
> +
> +	/* Enable Transmission of Link Speed byte in interrupt URB */
> +	ax88179_write_cmd(dev, AX_FW_MODE, AX_FW_MODE_179A, 0, 0, NULL);
> +	ax88179_write_cmd(dev, AX_RELOAD_EEPROM_EFUSE, 0, 0, 0, NULL);
> +
> +	/* Read MAC address from DTB or ASIX chip */
> +	ax88179_get_mac_addr(dev);
> +	memcpy(dev->net->perm_addr, dev->net->dev_addr, ETH_ALEN);
> +
> +	/* Power PHY for probing */
> +	reg8 = AX_PHY_POWER;
> +	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
> +	msleep(250);
> +
> +	ret = ax88179a_init_mdio(dev);
> +	if (ret)
> +		goto err_nodev;
> +
> +	ret = ax88179a_phylink_setup(dev);
> +	if (ret)
> +		goto phylink_err;
> +
> +	ret = ax88179a_init_phy(dev);
> +	if (ret)
> +		goto initphy_err;
> +
> +	return 0;
> +
> +initphy_err:
> +	phylink_destroy(ax179_data->phylink);
> +phylink_err:
> +	ax88179a_mdio_unregister(ax179_data);
> +err_nodev:
> +	kfree(ax179_data);
> +	ax179_data = NULL;
> +
> +	return ret;
> +}
> +
> +static void ax88179a_unbind(struct usbnet *dev, struct usb_interface *intf)
> +{
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	u16 tmp16;
> +	u8 tmp8;
> +
> +	/* Configure RX control register => stop operation */
> +	tmp16 = AX_RX_CTL_STOP;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);
> +
> +	rtnl_lock();
> +	phylink_disconnect_phy(ax179_data->phylink);
> +	rtnl_unlock();
> +	phylink_destroy(ax179_data->phylink);
> +	ax88179a_mdio_unregister(ax179_data);
> +
> +	tmp8 = 0;
> +	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &tmp8);
> +
> +	kfree(ax179_data);
> +}
> +
> +static void ax88179a_rx_checksum(struct sk_buff *skb, u64 pkt_desc)
> +{
> +	u32 pkt_type;
> +
> +	skb->ip_summed = CHECKSUM_NONE;
> +	/* checksum error bit is set */
> +	if (pkt_desc & AX179A_RX_PD_L4_ERR || pkt_desc & AX179A_RX_PD_L3_ERR)
> +		return;
> +
> +	pkt_type = pkt_desc & AX179A_RX_PD_L4_TYPE_MASK;
> +	/* It must be a TCP or UDP packet with a valid checksum */
> +	if (pkt_type == AX179A_RX_PD_L4_TCP || pkt_type == AX179A_RX_PD_L4_UDP)
> +		skb->ip_summed = CHECKSUM_UNNECESSARY;
> +}
> +
> +static int ax88179a_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
> +{
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	struct sk_buff *ax_skb;
> +	u32 hdr_off, pkt_end;
> +	u64 *pkt_desc_ptr;
> +	u16 vlan_tag;
> +	u16 pkt_cnt;
> +	u64 rx_hdr;
> +
> +	/* SKB contents for AX179A-based chips:
> +	 *   <packet 1>
> +	 *   ...
> +	 *   <packet N>
> +	 *   <per-packet metadata entry 1>
> +	 *   ...
> +	 *   <per-packet metadata entry N>
> +	 *   <rx_hdr>
> +	 *
> +	 * where:
> +	 *   <packet N> contains pkt_len data bytes and padding:
> +	 *		2 bytes of IP alignment (optional, depends on AX_RX_CTL_IPE flag)
> +	 *		packet data received
> +	 *		optional padding to 8-bytes boundary
> +	 *   <per-packet metadata entry N> contains 8 bytes:
> +	 *		pkt_len and fields AX_RXHDR_*
> +	 *   <rx-hdr>	contains 8 bytes:
> +	 *		pkt_cnt and hdr_off (offset of <per-packet metadata entry 1>)
> +	 *
> +	 * pkt_cnt is number of entries in the per-packet metadata array.
> +	 */
> +
> +	if (!skb || skb->len < sizeof(rx_hdr))
> +		goto err;
> +
> +	/* RX Descriptor Header */
> +	skb_trim(skb, skb->len - sizeof(rx_hdr));
> +	rx_hdr = *(u64 *)skb_tail_pointer(skb);
> +
> +	/* Check these packets */
> +	hdr_off = (rx_hdr & AX179A_RX_DH_DESC_OFFSET_MASK) >> AX179A_RX_DH_DESC_OFFSET_SHIFT;
> +	pkt_cnt = rx_hdr & AX179A_RX_DH_PKT_CNT_MASK;
> +
> +	/* Consistency check header position */
> +	if (hdr_off != skb->len - (pkt_cnt * sizeof(rx_hdr)))
> +		goto err;
> +
> +	/* Make sure that the bounds of the metadata array are inside the SKB
> +	 * (and in front of the counter at the end).
> +	 */
> +	if (pkt_cnt * 8 + hdr_off > skb->len)
> +		goto err;
> +
> +	/* Packets must not overlap the metadata array */
> +	skb_trim(skb, hdr_off);
> +
> +	if (!pkt_cnt)
> +		goto err;
> +
> +	/* Get the first RX packet descriptor */
> +	pkt_desc_ptr = (u64 *)(skb->data + hdr_off);
> +	le64_to_cpus(pkt_desc_ptr);
> +
> +	pkt_end = 0;
> +	while (pkt_cnt--) {
> +		u64 pkt_desc = *pkt_desc_ptr;
> +		u32 pkt_len_plus_padd;
> +		u32 pkt_len;
> +
> +		pkt_len = (u32)((pkt_desc & AX179A_RX_PD_LEN_MASK) >> AX179A_RX_PD_LEN_SHIFT)
> +			  - (ax179_data->ip_align ? 2 : 0);
> +		pkt_len_plus_padd = ((pkt_len + 7 + (ax179_data->ip_align ? 2 : 0)) & 0x7FFF8);
> +
> +		pkt_end += pkt_len_plus_padd;
> +		if (pkt_end > hdr_off || (pkt_cnt == 0 && pkt_end != hdr_off))
> +			goto err;
> +
> +		if (pkt_desc & AX179A_RX_PD_DROP || !(pkt_desc & AX179A_RX_PD_RX_OK) ||
> +		    pkt_len > (dev->hard_mtu + AX179A_RX_HW_PAD)) {
> +			skb_pull(skb, pkt_len_plus_padd);
> +
> +			/* Next RX Packet Descriptor */
> +			pkt_desc_ptr++;
> +			continue;
> +		}
> +
> +		ax_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len);
> +		if (!ax_skb)
> +			goto err;
> +
> +		skb_put(ax_skb, pkt_len);
> +		memcpy(ax_skb->data, skb->data + (ax179_data->ip_align ? AX179A_RX_HW_PAD : 0),
> +		       pkt_len);
> +
> +		if (ax179_data->rx_checksum)
> +			ax88179a_rx_checksum(ax_skb, pkt_desc);
> +
> +		if (pkt_desc & AX179A_RX_PD_VLAN) {
> +			vlan_tag = pkt_desc >> AX179A_RX_PD_VLAN_SHIFT;
> +			__vlan_hwaccel_put_tag(ax_skb, htons(ETH_P_8021Q),
> +					       vlan_tag & VLAN_VID_MASK);
> +		}
> +
> +		usbnet_skb_return(dev, ax_skb);
> +		skb_pull(skb, pkt_len_plus_padd);
> +
> +		/* Next RX Packet Header */
> +		pkt_desc_ptr++;
> +	}
> +
> +	return 1;
> +
> +err:
> +	return 0;
> +}
> +
> +static struct sk_buff *ax88179a_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
> +{
> +	u64 tx_desc = skb->len & AX179A_TX_DESC_LEN_MASK;
> +	int frame_size = dev->maxpacket;
> +	struct sk_buff *ax_skb;
> +	u64 *tx_desc_ptr;
> +	int padding_size;
> +	int headroom;
> +	int tailroom;
> +	u16 tci = 0;
> +
> +	/* TSO MSS */
> +	tx_desc |= ((u64)(skb_shinfo(skb)->gso_size & AX179A_TX_DESC_MSS_MASK)) <<
> +		   AX179A_TX_DESC_MSS_SHIFT;
> +
> +	headroom = (skb->len + sizeof(tx_desc)) % 8;
> +	padding_size = headroom ? 8 - headroom : 0;
> +
> +	if (((skb->len + sizeof(tx_desc) + padding_size) % frame_size) == 0) {
> +		padding_size += 8;
> +		tx_desc |= AX179A_TX_DESC_DROP_PADD;
> +	}
> +
> +	if ((dev->net->features & NETIF_F_HW_VLAN_CTAG_TX) && (vlan_get_tag(skb, &tci) >= 0)) {
> +		tx_desc |= AX179A_TX_DESC_VLAN;
> +		tx_desc |= ((u64)tci & AX179A_TX_DESC_VLAN_MASK) << AX179A_TX_DESC_VLAN_SHIFT;
> +	}
> +
> +	if (!dev->can_dma_sg && (dev->net->features & NETIF_F_SG) && skb_linearize(skb))
> +		return NULL;
> +
> +	headroom = skb_headroom(skb);
> +	tailroom = skb_tailroom(skb);
> +
> +	if (!(headroom >= sizeof(tx_desc) && tailroom >= padding_size)) {
> +		ax_skb = skb_copy_expand(skb, sizeof(tx_desc), padding_size, flags);
> +		dev_kfree_skb_any(skb);
> +		skb = ax_skb;
> +		if (!skb)
> +			return NULL;
> +	}
> +	if (padding_size != 0)
> +		skb_put_zero(skb, padding_size);
> +	/* Copy TX header */
> +	tx_desc_ptr = skb_push(skb, sizeof(tx_desc));
> +	put_unaligned_le64(tx_desc, tx_desc_ptr);
> +
> +	usbnet_set_skb_tx_stats(skb, 1, 0);

[Severity: Medium]
Is a hardcoded packet count of 1 right for a TSO super-packet?

ax88179a_bind() advertises NETIF_F_TSO and calls
netif_set_tso_max_size(dev->net, 16384), and this function programs
skb_shinfo(skb)->gso_size into the MSS field of tx_desc, so the
hardware splits the buffer into skb_shinfo(skb)->gso_segs frames on
the wire.  Accounting the whole super-packet as a single packet makes
tx_packets in rtnl_link_stats64 (via dev_get_tstats64) undercount by
the segment count for every large TCP flow -- with a 16 KiB
super-packet and a 1448 byte MSS that is one counted packet instead
of eleven.  Byte accounting is unaffected only if the per-segment
headers are not expected to be counted; passing 0 as the byte delta
means those replicated headers are not counted either.

Would skb_shinfo(skb)->gso_segs ?: 1 (with a matching byte
adjustment for the duplicated headers) be what you want here, or is
there a reason the driver deliberately reports the pre-segmentation
count?

> +
> +	return skb;
> +}
> +
> +static int ax88179a_reset(struct usbnet *dev)
> +{
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	u16 *tmp16;
> +	u8 buf[5];
> +	u8 *tmp;
> +
> +	tmp16 = (u16 *)buf;
> +	tmp = (u8 *)buf;
> +
> +	/* Power up ethernet PHY */
> +	*tmp = AX_PHY_POWER;
> +	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, tmp);
> +	msleep(250);
> +
> +	/* Ethernet PHY Auto Detach*/
> +	ax88179a_auto_detach(dev);
> +
> +	*tmp = AX_MAC_EFF_EN;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BULK_OUT_CTRL, 1, 1, tmp);
> +
> +	*tmp16 = 0;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, tmp16);
> +
> +	*tmp = 0x04;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);
> +	*tmp = 0x10;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH, 1, 1, tmp);
> +
> +	*tmp = 0;
> +	if (dev->net->features & NETIF_F_HW_VLAN_CTAG_FILTER)
> +		*tmp |= AX_VLAN_CONTROL_VFE;
> +	if (dev->net->features & NETIF_F_HW_VLAN_CTAG_RX)
> +		*tmp |= AX_VLAN_CONTROL_VSO;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, tmp);
> +
> +	*tmp = 0xff;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_INT_MASK, 1, 1, tmp);
> +
> +	*tmp = 0;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_RX_DMA_CTL, 1, 1, tmp);
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_TX_DMA_CTL, 1, 1, tmp);
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_ARC_CTRL, 1, 1, tmp);
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_SWP_CTRL, 1, 1, tmp);
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_TX_HDR_CKSUM, 1, 1, tmp);
> +
> +	/* Read MAC address from DTB or asix chip */
> +	ax88179_get_mac_addr(dev);
> +	memcpy(dev->net->perm_addr, dev->net->dev_addr, ETH_ALEN);
> +
> +	/* The Bulk-Register configuration for the AX88179A is done in
> +	 * ax88179a_mac_link_up(), once the link is up for a given link and USB-speed.
> +	 */
> +	if (ax179_data->is_ax88772d)
> +		dev->rx_urb_size = 1024 * 24;
> +	else
> +		dev->rx_urb_size = 1024 * 48;
> +
> +	/* Enable checksum offload */
> +	*tmp = AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
> +	       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, tmp);
> +	ax179_data->rx_checksum = 1;
> +
> +	*tmp = AX_TXCOE_IP | AX_TXCOE_TCP | AX_TXCOE_UDP |
> +	       AX_TXCOE_TCPV6 | AX_TXCOE_UDPV6;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, tmp);
> +
> +	/* Configure RX control register => start operation */
> +	ax179_data->rxctl = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_START |
> +			    AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;
> +	if (ax179_data->ip_align)
> +		ax179_data->rxctl |= AX_RX_CTL_IPE;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &ax179_data->rxctl);
> +
> +	if (ax179_data->chip_version < AX_VERSION_AX88179A)
> +		*tmp = AX_MONITOR_MODE_PMETYPE | AX_MONITOR_MODE_PMEPOL | AX_MONITOR_MODE_RWMP;
> +	else
> +		*tmp = AX_MONITOR_MODE_RWMP;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, tmp);
> +
> +	/* Configure default medium type => giga */
> +	*tmp16 = AX_MEDIUM_RECEIVE_EN | AX_MEDIUM_TXFLOW_CTRLEN |
> +		 AX_MEDIUM_RXFLOW_CTRLEN | AX_MEDIUM_FULL_DUPLEX;
> +	if (!ax179_data->is_ax88772d)
> +		*tmp16 |= AX_MEDIUM_GIGAMODE;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, tmp16);
> +
> +	/* Check if WoL is supported */
> +	ax179_data->wol_supported = 0;
> +	if (ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD,
> +			     1, 1, &tmp) > 0)
> +		ax179_data->wol_supported = WAKE_MAGIC | WAKE_PHY;
> +
> +	phylink_start(ax179_data->phylink);
> +
> +	usbnet_link_change(dev, 0, 0);
> +
> +	return 0;
> +}
> +
> +static int ax88179a_stop(struct usbnet *dev)
> +{
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	u16 reg16;
> +	u8 reg8;
> +
> +	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);
> +	reg16 &= ~AX_MEDIUM_RECEIVE_EN;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);
> +
> +	reg16 = 0;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &reg16);
> +
> +	reg8 = 0;
> +	ax88179_read_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
> +
> +	phylink_stop(ax179_data->phylink);
> +
> +	return 0;
> +}
> +
> +const struct driver_info ax88179a_info = {
> +	.description = "ASIX AX88179A USB 3.2 Gigabit Ethernet",
> +	.bind = ax88179a_bind,
> +	.unbind = ax88179a_unbind,
> +	.status = ax88179a_status,
> +	.reset = ax88179a_reset,
> +	.stop = ax88179a_stop,
> +	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET | FLAG_AVOID_UNLINK_URBS,
> +	.rx_fixup = ax88179a_rx_fixup,
> +	.tx_fixup = ax88179a_tx_fixup,
> +};
> +
> +const struct driver_info ax88772d_info = {
> +	.description = "ASIX AX88772D/E USB 2.0 Fast Ethernet",
> +	.bind = ax88179a_bind,
> +	.unbind = ax88179a_unbind,
> +	.status = ax88179a_status,
> +	.reset = ax88179a_reset,
> +	.stop = ax88179a_stop,
> +	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET | FLAG_AVOID_UNLINK_URBS,
> +	.rx_fixup = ax88179a_rx_fixup,
> +	.tx_fixup = ax88179a_tx_fixup,
> +};
> +
> +const struct driver_info ax88279_info = {
> +	.description = "ASIX AX88279 USB 3.2 2.5Gigabit Ethernet",
> +	.bind = ax88179a_bind,
> +	.unbind = ax88179a_unbind,
> +	.status = ax88179a_status,
> +	.reset = ax88179a_reset,
> +	.stop = ax88179a_stop,
> +	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET | FLAG_AVOID_UNLINK_URBS,
> +	.rx_fixup = ax88179a_rx_fixup,
> +	.tx_fixup = ax88179a_tx_fixup,
> +};
>

[Severity: High]
Should this be tmp rather than &tmp?

tmp is declared as u8 *tmp and set to point at the local buf[5]
array, so &tmp is a u8 ** -- the address of the pointer variable
itself, not of the one-byte buffer.  ax88179_read_cmd() with size 1
falls through to __ax88179_read_cmd(), which hands that address to
the USB control transfer, so the device writes one byte straight
over the stack slot holding tmp, clobbering the pointer.

Nothing dereferences tmp after this point in ax88179a_reset() today,
so it does not crash, but it is still a stray write over a live local
and any future code added below this read (or a compiler that spills
and reloads tmp) would then follow a corrupted pointer.  The rest of
the function consistently passes tmp/tmp16 by value for exactly this
reason.

While here: the condition only tests that the control transfer
succeeded, it never looks at the value read back, so
wol_supported is set to WAKE_MAGIC | WAKE_PHY unconditionally on any
responding device.  Was the intent to test a bit in the returned
AX_MONITOR_MOD value?  And would plain u8/u16 locals be clearer here
than the tmp/tmp16 aliasing over buf[5], which is what made this
mistake easy to miss?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ax88179a-v11-0-5ea7a925ba6d%40birger-koblitz.de
