Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAEB4F7CA6;
	Thu, 17 Sep 2026 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680301; cv=none; b=Ej/DGD4NFfW8jBqnjvb87PALxRkAds/iiY2jIViG9MxydrshOBv5r6B5yOG7xI6cEH435+KtcJhKKYuMa+PnXIuxBS288m9kx398H7lHT+YDHYkjFywblctBDJMiAOn40NLnKNQrU+GV9zX16ysvZOaX4XTSBxrXklqEx8icoMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680301; c=relaxed/simple;
	bh=YDktFbz8YLEUWeEvi+m1N0MQP1PgudzuoapabC/gGWU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MjwMUtuRuj9nYxday9hV06ncDxO+0a+w6A00cmN47vmPnpYEA03toK8W9Omy7xx1HLU5Lqb91ejepDNKlGK754yVWX4q0xkcxahJhERBgQUUIHHSZ/DyLz5UcIGlM1SrZIIeOwymcIQMUJtDzTAsDqecK+SUPORjCoQNiZgN5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1usfMHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1usfMHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5511F000FF;
	Thu, 17 Sep 2026 21:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680298;
	bh=BcS447xT9p1GJ+A7WZXsNHa16sgpoBhH7H7kXxJjFRg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B1usfMHTXyG1XUoLxaWdL8R2ew4L8/iEqAD1EzcvBPpssi5bQp1TgjTDg+9/dhdvd
	 77NzW5/byDLZqRZCwJ5Ew4HViD/pwGHzG4ljW+UypvO9+yP2jwUOLPdc07f3z6x8Q3
	 ixs9koFffckQIF/jYnZe0LLsDn0Lpyu9MmthSPSKCfWQqjwPKLmuuQi6UOaxwYca1A
	 i3EwukzhGTgLuLMEi0sl6jVPNbYjqAg3TQJU5DyZmUY4pzzuiF90oewMTrx0BgTVDb
	 SvsnzODlR2cBTXXKwlUzbkpSHZDeRa5UjpLwUXNSuKw5tGaslsLF7dQyjrofLnFX+b
	 Ha57LSkuVmLEg==
Subject: Re: [PATCH net-next v12 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Thu, 17 Sep 2026 21:24:56 +0000
Message-ID: <178968029668.22033.6092490845837885048@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-6-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-6-60c04c9924a2@birger-koblitz.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 27 potential
issue(s) to consider:

Critical: 0 · High: 4 · Medium: 19 · Low: 4

- [High] ax88179a_bind() advertises NETIF_F_HW_VLAN_CTAG_FILTER in
  dev->features/hw_features while ax88179a_netdev_ops provides neither…
- [High] The three new device IDs inherit the single usb_driver
  .suspend/.resume/.reset_resume of the legacy AX88179 code…
- [High] ax88179a_rx_fixup() dereferences device-controlled metadata with
  plain native-endian u64 pointer loads: `rx_hdr = *(u64…
- [High] ax88179a_rx_fixup() enforces only an upper packet-length bound
  (`pkt_len > dev->hard_mtu + AX179A_RX_HW_PAD`) and no minimum, so a…
- [Medium] ax88179a_bind() puts
  NETIF_F_IP_CSUM/NETIF_F_IPV6_CSUM/NETIF_F_RXCSUM/VLAN offloads into…
- [Medium] ax88179a_bind() sets
  ax179_data->eeprom_read_cmd/eeprom_write_cmd/eeprom_block/eeprom_wen…
- [Medium] ax88179a_ethtool_ops installs .nway_reset = usbnet_nway_reset,
  but ax88179a_bind() never fills in dev->mii (only…
- [Medium] ax88179a_stop() prepares `reg8 = 0` to power the Ethernet PHY
  down but then calls ax88179_read_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1,…
- [Medium] ax88179a_bulkin_config() starts with `int index = 0` and the
  ETHER_LINK_1000 / ETHER_LINK_100 cases only assign index when link_sts…
- [Medium] ax88179a_ethtool_ops mixes abstraction layers: pause
  parameters and SIOCxMIIREG go through phylink…
- [Medium] In ax88179a_reset() the WoL capability probe passes `&tmp` - a
  `u8 **` - as the destination of a 1-byte control read, while `tmp` is…
- [Medium] ax88179_mdiobus_read() ignores the return value of
  ax88179_read_cmd() and returns the u16 `res`, which ax88179_read_cmd()…
- [Medium] At this commit ax88179a_netdev_ops omits .ndo_set_rx_mode
  although the shared library provides ax88179_set_multicast() (which…
- [Medium] ax88179a_tx_fixup() writes into the SKB tailroom
  (skb_put_zero()) and headroom (skb_push() + put_unaligned_le64())…
- [Medium] Nothing bridges phylink's carrier-up transition to usbnet's
  RX-URB submission.
- [Medium] ax88179a_reset() calls phylink_start() but usbnet_open() has
  failure paths after info->reset() - info->check_connect() and…
- [Medium] All three new driver_infos set FLAG_AVOID_UNLINK_URBS, so
  usbnet_stop() skips usbnet_terminate_urbs() and RX URBs stay submitted…
- [Medium] ax88179a_stop() tears the MAC down (read-modify-write clearing
  AX_MEDIUM_RECEIVE_EN, then AX_RX_CTL = 0) before calling…
- [Medium] No lock serializes MAC register access and the shared
  ax179_data fields between the phylink resolve worker…
- [Medium] ax88179a_reset() calls phylink_start() and then
  usbnet_link_change(dev, 0, 0), giving the netdev two independent…
- [Medium] In ax88179a_mac_link_up() the SPEED_2500 branch (reachable
  only on the AX88279, the only chip advertising MAC_2500FD) programs…
- [Medium] In the SPEED_2500 branch of ax88179a_mac_link_up(), the two-
  byte write to AX88179A_MAC_RX_DATA_CDC_CNT passes the byte array…
- [Medium] net/usb: Silent packet drop on TX memory allocation failure
- [Low] The commit message tells users to give 'the ax88179_178a module'
  precedence over CDC-NCM, but the series builds ax88179.ko…
- [Low] ax88179a_tx_fixup() prepends an 8-byte TX descriptor and appends
  up to 16 bytes of padding but calls usbnet_set_skb_tx_stats(skb, 1,…
- [Low] ax88179a_mac_link_up() declares `u8 link_sts` without
  initialization, calls ax88179_read_cmd(dev, AX_ACCESS_MAC,…
- [Low] ax88179a_bind() powers the PHY (write AX_PHY_POWER to vendor
  command AX88179A_PHY_POWER, then msleep(250)) before the fallible…

--

ax88179_178a: Add HW support for AX179A-based chips

This adds a new ax88179a_devices.c to the ax88179 module, with bind,
reset, stop, rx_fixup and tx_fixup callbacks plus phylink/mdio support
for the AX88179A/B, AX88772D/E and AX88279 chips, which are matched by
BCD device version behind the shared 0x0b95:0x1790 id.  Kconfig switches
the driver from PHYLIB to PHYLINK.

A number of questions below.  Several of them appear to be resolved by
later patches in the same series; those are noted inline, since the
intermediate tree state is what a bisect would land on.

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

[Severity: Low]
The commit message says:

  "If the ax88179_178a module is configured by the OS to have precedence
   over CDC-NCM, ..."

but the Makefile builds ax88179.ko, not ax88179_178a.ko.  Should the
commit message name the module ax88179, so that modprobe softdep or
blacklist rules written from it actually match?

> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 6aa35c8eb594f..a2c596305f798 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -1270,6 +1270,18 @@ static const struct driver_info at_umc2000sp_info = {
>  
>  static const struct usb_device_id products[] = {
>  {
> +	/* ASIX AX88179A USB 3.2 1000Mbit Ethernet */
> +	USB_DEVICE_VER(0x0b95, 0x1790, 0x0200, 0x0200),
> +	.driver_info = (unsigned long)&ax88179a_info,
> +}, {
> +	/* ASIX AX88772D USB 2.0 100Mbit Ethernet */
> +	USB_DEVICE_VER(0x0b95, 0x1790, 0x0300, 0x0300),
> +	.driver_info = (unsigned long)&ax88772d_info,
> +}, {
> +	/* ASIX AX88279 USB 3.2 2500Mbit Ethernet */
> +	USB_DEVICE_VER(0x0b95, 0x1790, 0x0400, 0x0400),
> +	.driver_info = (unsigned long)&ax88279_info,
> +}, {

[Severity: High]
These three new ids share the single usb_driver .suspend/.resume/
.reset_resume of the legacy code (ax88179_suspend()/ax88179_resume()).
Can that path oops on the new chips?

ax88179_resume() ends up in the legacy ax88179_reset(), which calls:

	mii_nway_restart(&dev->mii);

but ax88179a_bind() only ever sets dev->mii.supports_gmii and never
installs dev->mii.mdio_read/mdio_write, so mii_nway_restart() would call
through a NULL mdio_write.

The same path also restores AX88179_BULKIN_SIZE[0] and rx_urb_size =
20K, and never calls phylink_suspend()/phylink_resume() even though the
driver sets phydev->mac_managed_pm = true.

The later patch "ax88179_178a: Add Suspend/resume support for
AX88179A/772D/279" adds ax88179a_suspend()/ax88179a_resume() and
dispatches via priv->suspend/priv->resume, so is the concern only that
this commit and the next few are not individually bisectable?

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> new file mode 100644
> index 0000000000000..5dac7a137c323
> --- /dev/null
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -0,0 +1,973 @@

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
Should ax88179_mdiobus_read() propagate the transfer error here?  The
return value of ax88179_read_cmd() is dropped, and for size == 2 that
helper zeroes its temporary before the transfer:

drivers/net/usb/ax88179_lib.c:ax88179_read_cmd() {
	if (size == 2) {
		u16 buf = 0;

		ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
		le16_to_cpus(&buf);
		*((u16 *)data) = buf;
	...
}

So a failed USB control transfer is reported to phylib as a successful
read of 0 (BMSR/BMCR == 0) rather than a negative errno.  The C45
accessors in this file do check ret < 0, which makes the C22 path look
inconsistent.

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

[Severity: Medium]
What happens on an AX88179A or AX88772D attached to a full-speed port?
link_sts has AX_USB_FS, so neither the AX_USB_SS nor the AX_USB_HS test
matches and index stays at 0 (or 1 for 100 Mbit half duplex).  The
full-speed override above is gated on chip_version == AX_VERSION_AX88279,
so it does not help these two chips.

AX88772D_BULKIN_SIZE[] has no designated initializer for index 0 or 1, so
the write below sends an all-zero {ctrl, timer_l, timer_h, size, ifg}
block:

	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, &bulkin_data[index]);

Since both tables do define BULK_IN_SPEED_FS, full-speed operation seems
to be expected; should the override drop the chip_version test?

[ ... ]

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

[Severity: Medium]
At this commit ax88179a_get_eeprom_len() advertises 0x4000 bytes for the
AX88279 and 640 bytes otherwise, but the installed callbacks still use
the legacy word-addressed protocol:

drivers/net/usb/ax88179_lib.c:ax88179_get_eeprom() {
	...
	__ax88179_read_cmd(dev, AX_ACCESS_EEPROM, i, 1, 2, &eeprom_buff[i - first_word]);
	...
}

They read none of the ax179_data->eeprom_read_cmd/eeprom_write_cmd/
eeprom_block/eeprom_wen fields that ax88179a_bind() sets, so 'ethtool -e'
services offsets up to 0x3FFF over AX_ACCESS_EEPROM instead of the flash
or eFuse command, and 'ethtool -E' ignores eeprom_wen.  The later patch
"ax88179_178a: Add support for AX88179A/772D/279 EEPROM access" wires
these fields up - would it be better to advertise the new length only
once the matching accessors are in place?

> +	.nway_reset		= usbnet_nway_reset,

[Severity: Medium]
Can usbnet_nway_reset() ever work for this driver?  It starts with:

drivers/net/usb/usbnet.c:usbnet_nway_reset() {
	if (!dev->mii.mdio_write)
		return -EOPNOTSUPP;
	...
}

and ax88179a_bind() only sets dev->mii.supports_gmii, leaving mdio_write
NULL, so 'ethtool -r' always fails.  Should this be
phylink_ethtool_nway_reset()?

> +	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
> +	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
> +	.get_pauseparam		= ax88179a_get_pauseparam,
> +	.set_pauseparam		= ax88179a_set_pauseparam,
> +	.get_ts_info		= ethtool_op_get_ts_info,
> +};

[Severity: Medium]
This table mixes the two abstractions: pause parameters and the MII
ioctl go through phylink, while link settings go straight to phylib and
bypass the phylink instance the driver just created.

phy_ethtool_set_link_ksettings() validates against phydev->supported
only, and phylink_bringup_phy() masks pl->supported and phy->advertising
rather than phy->supported.  For the AX88279 the phylink_config declares
MAC_100 | MAC_1000 | MAC_2500FD and no MAC_10, so a user can still force
a mode outside the MAC capability set, and pl->link_config is left stale.
Would phylink_ethtool_ksettings_get()/phylink_ethtool_ksettings_set() be
the right callbacks here?

[ ... ]

> +static void ax88179a_mac_link_up(struct phylink_config *config,
> +				 struct phy_device *phy,
> +				 unsigned int phy_mode, phy_interface_t interface,
> +				 int speed, int duplex,
> +				 bool tx_pause, bool rx_pause)
> +{
> +	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	u8 tmp8, link_sts, reg8[3];

[ ... ]

> +	switch (speed) {
> +	case SPEED_2500:

[ ... ]

> +		reg8[0] = 0x40;
> +		reg8[1] = AX_MAC_MIQFFCTRL_FORMAT | AX_MAC_MIQFFCTRL_DROP_CRC | AX_MAC_LSO_ERR_EN;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 2, 2, reg8);

[Severity: Medium]
Does this write swap the two bytes on big-endian hosts?  reg8 is a u8
array with an explicit byte order, but the helper reinterprets any
2-byte payload as a native u16:

drivers/net/usb/ax88179_lib.c:ax88179_write_cmd() {
	if (size == 2) {
		u16 buf;

		buf = *((u16 *)data);
		cpu_to_le16s(&buf);
	...
}

Would two separate 1-byte writes, or a __le16, be clearer here?

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

[ ... ]

> +		tmp8 = 0x40;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 1, &tmp8);

[ ... ]

> +	ax88179_read_cmd(dev, AX_ACCESS_MAC, PHYSICAL_LINK_STATUS, 1, 1, &link_sts);
> +	ax88179a_bulkin_config(dev, link_sts, bulk_config_speed, !!duplex);
> +
> +	if (ax179_data->chip_version < AX_VERSION_AX88279) {
> +		tmp8 = 0;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_BFM_DATA, 1, 1, &tmp8);
> +	}

[Severity: Medium]
Is this condition inverted?  AX_XGMII_EN in AX88179A_BFM_DATA is only
ever set in the SPEED_2500 branch, which is reachable just on the
AX88279 (the only chip advertising MAC_2500FD), yet the clearing write is
gated on chip_version < AX_VERSION_AX88279.

Related: the SPEED_1000/100/10 branches rewrite only the first byte of
AX88179A_MAC_RX_DATA_CDC_CNT, so after an AX88279 link at 2.5 Gbit
renegotiates down, the second byte keeps AX_MAC_MIQFFCTRL_FORMAT |
AX_MAC_MIQFFCTRL_DROP_CRC | AX_MAC_LSO_ERR_EN, and
AX88179A_MAC_LSO_ENHANCE_CTRL plus the 2.5G AX88179A_MAC_TX_PAUSE triple
also survive.  Should the lower-speed paths restore all of these?

[Severity: Low]
Above, link_sts is declared uninitialized and the read result is not
checked before it is passed to ax88179a_bulkin_config().  For size == 1
ax88179_read_cmd() forwards straight to __ax88179_read_cmd() and leaves
the caller's buffer untouched on error, unlike the size == 2/4 paths
which pre-zero a temporary.  Should link_sts be initialized, or the
return value checked, so a failing control transfer does not pick the
bulk-in block from a stale stack value?

> +	if (duplex)
> +		mode |= AX_MEDIUM_FULL_DUPLEX;
> +
> +	if (dev->net->mtu > 1500)
> +		mode |= AX_MEDIUM_JUMBO_EN;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &mode);
> +
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &ax179_data->rxctl);

[Severity: Medium]
What serializes these register accesses against the RTNL paths?
ax88179a_mac_link_up() runs from phylink_resolve(), which holds only
pl->phydev_mutex / phy->lock / pl->state_mutex and never RTNL, while
ndo_change_mtu does a read-modify-write of the same register:

drivers/net/usb/ax88179_lib.c:ax88179_change_mtu() {
	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &tmp16);
	tmp16 |= AX_MEDIUM_JUMBO_EN;
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &tmp16);
	...
}

So 'ip link set mtu 9000' concurrent with a link event can lose either
update.  ax179_data->rxctl is likewise written in ax88179a_reset() and
read here with no lock and no READ_ONCE()/WRITE_ONCE().

> +
> +	tmp8 = AX_MAC_RX_PATH_READY | AX_MAC_TX_PATH_READY;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 1, &tmp8);
> +}

[Severity: Medium]
Does anything re-submit RX URBs after this link-up?  ax88179a_reset()
ends with usbnet_link_change(dev, 0, 0), whose deferred
__handle_link_change() runs unlink_urbs(dev, &dev->rxq) while the carrier
is down, and usbnet_bh() only refills the RX queue when
netif_carrier_ok() is true and the work has been queued:

usbnet_link_change() -> __handle_link_change() {
	if (!netif_carrier_ok(dev->net))
		unlink_urbs(dev, &dev->rxq);
	else
		queue_work(system_bh_wq, &dev->bh_work);
}

phylink calls netif_carrier_on() from the resolver, which schedules
linkwatch but never queue_work(system_bh_wq, &dev->bh_work).  With a
static IP and no outgoing traffic, is the interface left with no RX URBs
queued after the cable is plugged in?

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
> +	.ndo_eth_ioctl		= ax88179a_mii_ioctl,
> +};

[Severity: Medium]
With no .ndo_set_features here, does toggling the advertised offloads do
anything?  ax88179a_bind() puts NETIF_F_IP_CSUM/NETIF_F_IPV6_CSUM/
NETIF_F_RXCSUM and the VLAN bits into hw_features, so
__netdev_update_features() accepts the change and updates only the
software bitmap.  ax88179a_reset() unconditionally enables the checksum
engines and sets ax179_data->rx_checksum = 1, and ax88179a_rx_fixup()
tests that private flag, so 'ethtool -K eth0 rx off' reports success
while frames keep being marked CHECKSUM_UNNECESSARY.  The later patch
"ax88179_178a: Add VLAN offload support for AX88179A" installs
.ndo_set_features - should it come first, or the features be advertised
later?

[Severity: Medium]
.ndo_set_rx_mode is also missing at this commit, although the shared
library already provides ax88179_set_multicast() and the legacy
ax88179_netdev_ops installs it, so promiscuous and multicast list
changes never reach the hardware (AX_RX_CTL_PRO is never set).  Plain
multicast happens to work because ax88179a_reset() sets AX_RX_CTL_AMALL.
The later patch "ax88179_178a: Add AX179A/AX279 multicast configuration"
adds the callback.

> +static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
> +{

[ ... ]

> +	dev->net->netdev_ops = &ax88179a_netdev_ops;
> +	dev->net->ethtool_ops = &ax88179a_ethtool_ops;

[ ... ]

> +	if (!ax179_data->is_ax88772d)
> +		dev->mii.supports_gmii = 1;
> +
> +	dev->net->features |= NETIF_F_SG | NETIF_F_IP_CSUM |
> +			      NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO |
> +			      NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
> +			      NETIF_F_HW_VLAN_CTAG_FILTER;
> +
> +	dev->net->hw_features |= dev->net->features;

[Severity: High]
Does register_netdev() reject this combination?  The features above
include NETIF_F_HW_VLAN_CTAG_FILTER while ax88179a_netdev_ops has
neither .ndo_vlan_rx_add_vid nor .ndo_vlan_rx_kill_vid at this commit:

net/core/dev.c:register_netdevice() {
	if (((dev->hw_features | dev->features) & NETIF_F_HW_VLAN_CTAG_FILTER) &&
	    (!dev->netdev_ops->ndo_vlan_rx_add_vid ||
	     !dev->netdev_ops->ndo_vlan_rx_kill_vid)) {
		netdev_WARN(dev, "Buggy VLAN acceleration in driver!\n");
		ret = -EINVAL;
	...
}

That would make every AX88179A/772D/279 device fail to probe until the
later patch "ax88179_178a: Add VLAN offload support for AX88179A" adds
the two callbacks.  Could the filter bit be advertised in that patch
instead, so this commit probes on its own?

[ ... ]

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

[Severity: Low]
Should the error labels also write 0 back to AX88179A_PHY_POWER?  The
PHY is powered up before ax88179a_init_mdio(), ax88179a_phylink_setup()
and ax88179a_init_phy(), and the unwind path only releases software
objects, so a failed bind (for example mdiobus_alloc() returning NULL or
mdiobus_register() failing) leaves the PHY powered with no driver
attached.  ax88179a_unbind() does the power-down write.

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
Are these u64 loads safe with respect to alignment and byte order?

usbnet allocates the RX buffer with __netdev_alloc_skb_ip_align(), so
skb->data is offset by NET_IP_ALIGN, and the trim length comes from the
device's URB actual_length, so the address above is unaligned by
construction on architectures that do not fix up unaligned 64-bit loads.

rx_hdr is also never byte-swapped, so on big-endian hosts hdr_off and
pkt_cnt below are decoded from the wrong halves.  The existing
ax88179_rx_fixup() uses get_unaligned_le32() for exactly this.

> +	/* Get the first RX packet descriptor */
> +	pkt_desc_ptr = (u64 *)(skb->data + hdr_off);
> +	le64_to_cpus(pkt_desc_ptr);
> +
> +	pkt_end = 0;
> +	while (pkt_cnt--) {
> +		u64 pkt_desc = *pkt_desc_ptr;

Same question here: hdr_off is only constrained by
hdr_off == skb->len - pkt_cnt * 8, never to an 8-byte boundary, and
le64_to_cpus() is applied once, in place, to the first descriptor only -
every later iteration reads its descriptor unconverted.  Would
get_unaligned_le64() per descriptor cover both problems?

> +		pkt_len = (u32)((pkt_desc & AX179A_RX_PD_LEN_MASK) >> AX179A_RX_PD_LEN_SHIFT)
> +			  - (ax179_data->ip_align ? 2 : 0);

[ ... ]

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

[Severity: High]
Only an upper bound on pkt_len is checked.  Can a descriptor with RX_OK
and pkt_len between 0 and 13 leak uninitialized memory?

usbnet_skb_return() calls eth_type_trans() unconditionally, and the short
pull there is ignored:

include/linux/etherdevice.h:eth_skb_pull_mac() {
	struct ethhdr *eth = (struct ethhdr *)skb->data;
	skb_pull_inline(skb, ETH_HLEN);
	return eth;
}

usbnet's own guard does not apply, because rx_process() returns early for
FLAG_MULTI_PACKET drivers:

drivers/net/usb/usbnet.c:rx_process() {
	if (dev->driver_info->flags & FLAG_MULTI_PACKET)
		return -EALREADY;

	if (skb->len < ETH_HLEN) { ... }
}

With an AF_PACKET listener, dev_parse_header() then copies h_source into
sockaddr_ll.sll_addr.  Should the loop also reject pkt_len < ETH_HLEN
(or ETH_ZLEN)?

[ ... ]

> +static struct sk_buff *ax88179a_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
> +{

[ ... ]

> +	if (!dev->can_dma_sg && (dev->net->features & NETIF_F_SG) && skb_linearize(skb)) {
> +		dev_kfree_skb_any(skb);
> +		return NULL;
> +	}
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

[Severity: Medium]
Both out-of-memory exits in ax88179a_tx_fixup() - this
skb_linearize() failure and the skb_copy_expand() failure a few
lines below - free the skb and return NULL.  For a driver_info with
FLAG_MULTI_PACKET set, is that distinguishable from "packet
collected, waiting for more"?

drivers/net/usb/usbnet.c:usbnet_start_xmit() {
	if (info->tx_fixup) {
		skb = info->tx_fixup (dev, skb, flags);
		if (!skb) {
			/* packet collected; minidriver waiting for more */
			if (info->flags & FLAG_MULTI_PACKET)
				goto not_drop;
			...
			goto drop;
		}
	}
	...
}

All three of ax88179a_info, ax88772d_info and ax88279_info set
FLAG_MULTI_PACKET, so the NULL return takes the not_drop path: the
core skips the tx_dropped accounting done at the drop label and
returns NETDEV_TX_OK.  The frame is freed here and never counted
anywhere, so it is invisible in both dev_get_tstats64() and
ifconfig/ip -s output, which makes an allocation failure under
memory pressure look like a silent black hole rather than a
counter the admin can see.

Should these two paths bump the drop counter themselves (the usual
spelling for a MULTI_PACKET minidriver being
dev_core_stats_tx_dropped_inc(dev->net) before returning NULL),
since the MULTI_PACKET contract puts the accounting on the driver?

[Severity: Medium]
Should this test skb_cloned()/skb_header_cloned() as well?  The decision
to modify in place is based only on the available headroom and tailroom,
and because ax88179a_bind() sets needed_headroom = needed_tailroom = 8, a
cloned linear skb (tap or AF_PACKET clone, TCP retransmit clone, tc
mirred) normally passes the size test and then gets skb_put_zero() and
skb_push() applied to the shared head.  skb_linearize() only unclones
non-linear skbs.  The sibling function guards the same sequence:

drivers/net/usb/ax88179_178a.c:ax88179_tx_fixup() {
	if ((skb_header_cloned(skb) || headroom < 0) &&
	    pskb_expand_head(skb, ...))
	...
}

> +
> +	usbnet_set_skb_tx_stats(skb, 1, 0);

[Severity: Low]
This passes a zero byte delta, but the function prepended an 8-byte
descriptor and up to 16 bytes of padding.  With FLAG_MULTI_PACKET set,
usbnet_start_xmit() accounts the full transfer:

drivers/net/usb/usbnet.c:usbnet_start_xmit() {
	entry->length += length;
	...
}

so tx_bytes counts the USB framing too (1500 becomes 1512+).  cdc_ncm
passes a negative delta for this.  The pre-existing ax88179_tx_fixup()
uses the same zero-delta convention, so this may be intentional.

> +static int ax88179a_reset(struct usbnet *dev)
> +{

[ ... ]

> +	/* Check if WoL is supported */
> +	ax179_data->wol_supported = 0;
> +	if (ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD,
> +			     1, 1, &tmp) > 0)
> +		ax179_data->wol_supported = WAKE_MAGIC | WAKE_PHY;

[Severity: Medium]
Is &tmp intended here?  tmp is the u8 * pointing at the local buf[5], so
&tmp is a u8 ** and the 1-byte read lands on the low byte of the pointer
variable itself rather than in the scratch buffer; the register value
that was meant to be inspected is discarded.  Every other call in this
function passes tmp.  It is latent today because tmp is not used
afterwards, but a later use or reordering would make it corrupt the
pointer.

> +
> +	phylink_start(ax179_data->phylink);
> +
> +	usbnet_link_change(dev, 0, 0);
> +
> +	return 0;
> +}

[Severity: Medium]
phylink is started here, but usbnet_open() has failure paths after
info->reset() - info->check_connect() and usbnet_status_start() - that
'goto done' and return an error without calling info->stop, so
ax88179a_stop()/phylink_stop() never runs.  Does that leave phylink
started on a netdev whose ndo_open failed, with the resolver free to call
ax88179a_mac_link_up() and raise the carrier while no RX URBs exist?  The
next successful open would then call phylink_start() a second time, and
phy_start() WARNs when the PHY is not in PHY_READY or PHY_HALTED.

[Severity: Medium]
These two calls also give the netdev two independent owners of the
carrier bit: usbnet_link_change(dev, 0, 0) calls netif_carrier_off()
directly behind phylink's back.  If a resolve completes with the link up
between the two statements, phylink has already called
netif_carrier_on() and programmed the MAC, and the following
netif_carrier_off() leaves the interface NO-CARRIER.

Since data->phydev->irq = PHY_MAC_INTERRUPT (no polling), nothing
schedules another resolve to repair the state until a physical link flap,
and the deferred __handle_link_change() unlinks the RX URBs as well.

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
Should this be ax88179_write_cmd()?  reg8 is set to 0 to power the PHY
down, but the read merely overwrites reg8 with the device's answer and
programs nothing, so the AX_PHY_POWER bit set in ax88179a_bind() and
ax88179a_reset() stays set after 'ip link set down'.  ax88179a_unbind()
has the intended form:

	tmp8 = 0;
	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &tmp8);

> +
> +	phylink_stop(ax179_data->phylink);
> +
> +	return 0;
> +}

[Severity: Medium]
Would it be safer to call phylink_stop() before the disable writes
above?  ax88179a_mac_link_up() runs from phylink's resolve work item
holding only pl->state_mutex, so a link-up landing in this window
re-writes AX_RX_CTL (with AX_RX_CTL_START), AX_MEDIUM_STATUS_MODE (with
AX_MEDIUM_RECEIVE_EN) and AX88179A_MAC_PATH after the teardown; the
read-modify-write of AX_MEDIUM_STATUS_MODE can also be lost.  Since
ax88179a_mac_link_down() is an empty stub, phylink_stop() cannot undo it.

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

[Severity: Medium]
What kills the RX URBs for these driver_infos?  FLAG_AVOID_UNLINK_URBS
makes usbnet_stop() skip usbnet_terminate_urbs(), and ax88179a_stop()
neither cancels nor drains them, so with the interface already down at
unbind time the URBs are killed by USB core, rx_complete() calls
defer_bh() -> queue_work(system_bh_wq, &dev->bh_work), and
usbnet_disconnect() only does cancel_work_sync(&dev->kevent) before
free_netdev().  Can that work item then run on a freed struct usbnet?
aqc111 uses the same flag combination, so this may be inherited from
usbnet rather than new here.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ax88179a-v12-0-60c04c9924a2%40birger-koblitz.de
