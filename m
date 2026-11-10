Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274715;
	b=bRLQVeiyCEAhD6j9BDipPE2m8aT9p479IblgUAjTJmykzMwHp9IsYVM1nvbWkSwnP+Y1
	 B+nonZHYR9ZsNuFast9XwSi+NSRfls7iUVW8QWGrjtP9cfLGqX6DkLzTUIBPFuXVwBQiE
	 qdyW4E3/Hamtrp3ds5SbYr3XHFnA+6QR+JPFm6VaGUxgO+oiDknxsN3GLLFRbUo15JKwQ
	 2/czmf2/pfCtylcS+2OyZlF3F27RZ2sRYb3bC4g00NHpJf8JyhXqPrU/UsUJOcuxW4eHs
	 DuiEx/xZnLpDmFXavfkJRIASkWKfTSP8o76skndOCoh+YdiP7MMixjl32pdjnYDXgYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274715;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wMyCY+hyxJJcWSF46YTrirazgaO1qfvNMM/1r0G6iSI=;
	b=Gh9JjrK00jAAjimj6qpHVd+m1o9jtK4z9m1Klh+YaMKuIpHjz4fVRWDw6LE1n/Q7ERbT
	 yg58dAzW41tve1eOGPpYaBa93sZ7mIy4+rtk2mpuH9GMYofQraATurVoAide0NzILDd6R
	 NfSrdLn+0hC86VBY7VhgDq+8Qmo+42jW8E+msxEryEJLM9ybktH5WdS+FXNB3qSQkz8yq
	 1Ytz8cODI4tr+/qazB4nOjag1My0u1Q0IXrWhKQT4pjMvdkhhi6dCBTXZ+OaMKt/1eJu/
	 ms0phWc6gCWoXf3L3zDNHMkMzU4Wo2S7OPbcG1uGGJBu9BO7pDDYopxNEsZz6wiAE9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTlbHMp+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A360A2623;
	Tue, 10 Nov 2026 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTlbHMp+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9931F00900;
	Tue, 10 Nov 2026 01:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274713;
	bh=wMyCY+hyxJJcWSF46YTrirazgaO1qfvNMM/1r0G6iSI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WTlbHMp+BJBS3U4GiIJRccdt3ioUOWoYo15uO19rdKNeN6LzECQR2bU6ZpWsimDt6
	 UkKXHfBDoFjSyUEtQspapz4YHENM/3KXR5Yezm97RjRCNlRuLJF8BwgdEUBSQkavAy
	 MXMM+WcVr4/W7Xfr6UrOZFnAQycbrKeFpTZvYk7r9QOk0YxDVIuis769jlojcEbdfu
	 D8kxu3HjhTjufzCfyzT8Wcfs6cfQV3ViIOp428zpkzq3c4uWeBD8iDQGgVp5+KfdtR
	 W7APKyXYExmoaH/3FdsGlAgLKNggmZ5d2M1UTQ/2mHe0TC//Iroprd6xxqZmLd4zDV
	 2whfOZqIimhgw==
Subject: Re: [PATCH net-next v20 04/13] ax88179_178a: Add HW support for
 AX179A-based chips
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name,
 edumazet@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 neuromoments@gmail.com, beganovic.emir@gmail.com
Date: Tue, 10 Nov 2026 01:38:32 +0000
Message-ID: <179427471238.994134.16676779454831582668@kernel.org>
In-Reply-To: <20261106-ax88179a-v20-4-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-4-37b5a1189983@birger-koblitz.de>
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

Thank you for your contribution! Sashiko AI review found 13 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 7 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: usb: ax88179: UAF on unbind when down due to
  FLAG_AVOID_UNLINK_URBS
- [Medium] The three new `products[]` entries, `USB_DEVICE_VER(0x0b95,
  0x1790, 0x0200/0x0300/0x0400, ...)`, match on VID, PID and bcdDevice…
- [Medium] `ax88179a_rx_fixup()` silently drops any frame with `pkt_len >
  dev->hard_mtu + AX179A_RX_HW_PAD` (+2).
- [Medium] `ax88179a_mac_link_up()` programs the MAC but never calls
  `usbnet_link_change(dev, true, false)`, and `ax88179a_status()` only…
- [Medium] `ax88179a_reset()`, used as `driver_info->reset`, ends with
  `phylink_start()`, which also calls `phy_start()` on the attached PHY.
- [Medium] In `ax88179a_mac_link_up()`, three AX88279 MAC registers are
  written only in the `SPEED_2500` branch: `AX88179A_MAC_TX_PAUSE` (3…
- [Medium] net: usb: ax88179a: ax88179a_reset() clobbers custom MAC and
  perm_addr on open
- [Medium] net: usb: ax88179_178a: positive return from
  ax88179_mdiobus_write()
- [Low] The commit message leaves out several changes this commit makes.
- [Low] In `ax88179a_mac_link_up()`, `link_sts` starts at 0 and the
  return value of `ax88179_read_cmd(..., PHYSICAL_LINK_STATUS, ...)` is…
- [Low] `ax88179_data::rx_checksum` is written with plain stores in
  process context: in `ax88179_set_features()` under RTNL (cleared…
- [Low] The two code paths program the pause water levels byte-swapped
  relative to each other.
- [Low] `ax88179a_bind()` switches firmware mode (`AX_FW_MODE`), reloads
  eFuse/EEPROM and powers the Ethernet PHY (`ax88179_write_u8(dev,…

--

ax88179_178a: Add HW support for AX179A-based chips

This adds support for the AX179A family (AX88179A/B, AX88772D/E and
AX88279). All of them share VID/PID 0b95:1790 and are told apart by
bcdDevice. The new ax88179a_bind() switches the device from its CDC-NCM
configuration to the vendor configuration, and ax88179a_devices.c drives
the chips through phylink.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe23913b1e432..c22f8ed088083 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4114,6 +4114,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/net/asix,ax88796c.yaml
>  F:	drivers/net/ethernet/asix/ax88796c_*
>  
> +ASIX AX88179 USB ETHERNET DRIVER
> +M:	Birger Koblitz <mail@birger-koblitz.de>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	drivers/net/usb/ax88179*
> +

[Severity: Low]
This isn't a bug, but the commit message leaves out several changes
made here.

The new MAINTAINERS entry covers all of drivers/net/usb/ax88179*. That
includes the existing AX88179/178A driver.

The legacy ax88179_bind() now reads AX_CHIP_STATUS and fails the bind
if that read fails. Existing devices did not have that failure mode
before.

Kconfig changes from select PHYLIB to select PHYLINK, and
ax88179_set_features() changes as well.

Could the commit message describe these, or could they go into separate
patches?

[ ... ]

> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 55268d0890d12..f78ad344c1c4f 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c

[ ... ]

> @@ -1271,6 +1290,18 @@ static const struct driver_info at_umc2000sp_info = {
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
>  	/* ASIX AX88179 10/100/1000 */
>  	USB_DEVICE_AND_INTERFACE_INFO(0x0b95, 0x1790, 0xff, 0xff, 0),
>  	.driver_info = (unsigned long)&ax88179_info,

[Severity: Medium]
These entries match only on VID, PID and bcdDevice, with no interface
class check. They also come before the vendor-interface-only 0b95:1790
entry. Won't they match the CDC-NCM comm and data interfaces as well?

Commit c67cc4315a8e ("net: usb: ax88179_178a: Bind only to
vendor-specific interface") limited 0b95:1790 to the vendor interface.
By default the device then stays in CDC mode under the class driver,
and users can switch it through sysfs.

With these entries, ax88179a_bind() runs this whenever it probes a CDC
interface:

	if (udev->actconfig->desc.bConfigurationValue != 1) {
		netdev_info(dev->net, "Switching to vendor mode\n");
		usb_driver_set_configuration(udev, 1);
		return -ENODEV;
	}

When both drivers are built in, drivers/net/usb/Makefile links
ax88179.o ahead of cdc_ncm.o. ax88179 is then always tried first, so
the adapter is always forced out of CDC mode. With modules, the result
depends on load order.

This seems to contradict the commit message:

  "By default, the proprietary vendor interface is not active and Linux
  will load the CDC-NCM driver to support the devices. If the
  ax88179_178a module is configured by the OS to have precedence over
  CDC-NCM, then this driver will switch the device ..."

Is reversing c67cc4315a8e intended? If so, could the commit message say
so?

Could it also mention that AX88179A-family devices already in vendor
mode used to be driven by ax88179_info and now go through the new code?

> diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
> index 063427ff55e42..a314db4c97666 100644
> --- a/drivers/net/usb/ax88179_lib.c
> +++ b/drivers/net/usb/ax88179_lib.c

[ ... ]

> @@ -355,10 +378,17 @@ int ax88179_set_features(struct net_device *net, netdev_features_t features)
>  	}
>  
>  	if (changed & NETIF_F_RXCSUM) {
> +		/* When we disable rx-checksumming, we need to clear the rx_checksum
> +		 * flag before disabling the engine
> +		 */
> +		if (!(features & NETIF_F_RXCSUM))
> +			data->rx_checksum = 0;
> +
>  		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, &tmp);
>  		tmp ^= AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
>  		       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
>  		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, &tmp);
> +		data->rx_checksum = !!(features & NETIF_F_RXCSUM);
>  	}

[Severity: Low]
rx_checksum is written here with plain stores under RTNL. It is read
without a lock for every packet in ax88179a_rx_fixup(), which runs from
the usbnet BH workqueue:

		if (ax179_data->rx_checksum)
			ax88179a_rx_checksum(ax_skb, pkt_desc);

Should these accesses use WRITE_ONCE() and READ_ONCE(), as the
neighbouring rxctl field does? The ordering described in the new
comment isn't enforced by any memory-ordering primitive.

At this commit nothing calls this writer for the new chips. Later in
the series ax88179a_set_features() calls ax88179_set_features(), and the
race becomes reachable then.

[ ... ]

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> new file mode 100644
> index 0000000000000..1aa8479422517
> --- /dev/null
> +++ b/drivers/net/usb/ax88179a_devices.c

[ ... ]

> +static void ax88179a_mac_link_up(struct phylink_config *config,
> +				 struct phy_device *phy,
> +				 unsigned int phy_mode, phy_interface_t interface,
> +				 int speed, int duplex,
> +				 bool tx_pause, bool rx_pause)
> +{

[ ... ]

> +	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 2, 0x0410);

[Severity: Low]
After cpu_to_le16s(), this write sets AX_PAUSE_WATERLVL_LOW to 0x10 and
AX_PAUSE_WATERLVL_HIGH to 0x04. ax88179a_reset() writes the reverse:

	ax88179_write_u8(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 0x04);
	ax88179_write_u8(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH, 1, 0x10);

Which ordering is intended? The legacy AX88179 path uses LOW > HIGH
(0x52/0x34), which matches the link-up values. If that is the right
ordering, the reset values are misleading.

[ ... ]

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
> +		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 0x40);
> +		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT + 1, 1,
> +				 AX_MAC_MIQFFCTRL_FORMAT | AX_MAC_MIQFFCTRL_DROP_CRC |
> +				 AX_MAC_LSO_ERR_EN);
> +
> +		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_BFM_DATA, 1, AX_XGMII_EN);
> +
> +		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_LSO_ENHANCE_CTRL, 1,
> +				 0x1C | AX_LSO_ENHANCE_EN);

[Severity: Medium]
Three registers are written only on the 2.5G path:
AX88179A_MAC_TX_PAUSE, AX88179A_MAC_RX_DATA_CDC_CNT + 1 and
AX88179A_MAC_LSO_ENHANCE_CTRL. For other speeds only AX88179A_BFM_DATA
is cleared, and ax88179a_reset() doesn't restore the three either.

Say an AX88279 links at 2500 and then renegotiates to 1000 or 100
without an ifdown/ifup. Won't the MAC keep the 2.5G pause thresholds,
the MIQFFCTRL_DROP_CRC/FORMAT bits and the LSO enhance setting? The
lower-speed branch would also add AX_GMII_CRC_APPEND in
AX88179A_MAC_RX_STATUS_CDC on top of them.

A fresh 1G link-up never produces that register combination. Later in
the series the AX88279 PHY driver reports both 2500BASEX and SGMII, so
the speed change looks reachable.

[ ... ]

> +	ax88179_read_cmd(dev, AX_ACCESS_MAC, PHYSICAL_LINK_STATUS, 1, 1, &link_sts);
> +	ax88179a_bulkin_config(dev, link_sts, bulk_config_speed, !!duplex);

[Severity: Low]
The return value of this read is ignored, and link_sts starts at 0. If
the control transfer fails or returns no data, ax88179a_bulkin_config()
sees none of AX_USB_SS, AX_USB_HS or AX_USB_FS set.

The index then stays at 0 (BULK_IN_SPEED_2G5) at 1000 Mb/s, and is 0
or 1 at 100 Mb/s. AX88179A_BULKIN_SIZE has no entry at index 0, and
AX88772D_BULKIN_SIZE only fills in indices 5 to 7:

static const struct ax_bulkin_settings AX88772D_BULKIN_SIZE[] = {
	[BULK_IN_SPEED_100_FULL_HS]	= {5, 0xC0, 0x04, 0x06, 0x0F},
	[BULK_IN_SPEED_100_HALF_HS]	= {7, 0xC0, 0x04, 0x06, 0x0F},
	[BULK_IN_SPEED_FS]		= {7, 0x00, 0x00, 0x03, 0x3F},
};

Wouldn't an all-zero ax_bulkin_settings get written to
AX_RX_BULKIN_QCTRL? For AX88179A at 100M half duplex, the 1G_SS entry
would be written instead.

Could the read be checked, with a fallback such as BULK_IN_SPEED_FS
when it fails?

[ ... ]

> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1,
> +			 AX_MAC_RX_PATH_READY | AX_MAC_TX_PATH_READY);
> +}

[Severity: Medium]
Is a usbnet_link_change() call missing here, and in
ax88179a_mac_link_down()?

usbnet only submits RX URBs from usbnet_bh(), and only when
netif_carrier_ok() is true. On link up, bh_work is queued from
__handle_link_change(). The only way to reach that is through
usbnet_link_change().

The open sequence looks like this:

usbnet_open()
  ax88179a_reset()
    phylink_start()          <- netif_carrier_off()
  queue bh_work              <- carrier off, no RX URBs submitted
...
phylink_resolve()
  ax88179a_mac_link_up()
  netif_carrier_on()         <- nothing requeues bh_work

Doesn't RX stay stalled until some TX completion happens to queue
bh_work? The same would happen after every link down/up, and RX URBs
are never unlinked on link down.

ax88772_mac_link_up() and ax88772_mac_link_down() in asix_devices.c
call usbnet_link_change() for exactly this reason.

[ ... ]

> +static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
> +{

[ ... ]

> +	/* Power PHY for probing */
> +	ax88179_write_u8(dev, AX88179A_PHY_POWER, 0, 0, AX_PHY_POWER);
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
If ax88179a_init_mdio(), ax88179a_phylink_setup() or ax88179a_init_phy()
fails, the PHY powered on above is never powered off. Should the error
path write AX88179A_PHY_POWER = 0, as ax88179a_unbind() does?

Otherwise the device is left in vendor mode with no driver bound and the
PHY still powered, so it can bring up a link with the partner.

At this commit, this path looks reachable for every AX88279, because
phylink validation against genphy fails.

[ ... ]

> +static int ax88179a_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
> +{

[ ... ]

> +		if (pkt_desc & AX179A_RX_PD_DROP || !(pkt_desc & AX179A_RX_PD_RX_OK) ||
> +		    pkt_len > (dev->hard_mtu + AX179A_RX_HW_PAD) || pkt_len < 2 + ETH_HLEN) {
> +			skb_pull(skb, pkt_len_plus_padd);
> +
> +			/* Next RX Packet Descriptor */
> +			pkt_desc_ptr++;
> +			continue;
> +		}

[Severity: Medium]
Can this silently drop full-size VLAN-tagged frames after an MTU change?

ax88179a_bind() sets dev->hard_mtu to 9 * 1024. The shared
ax88179_change_mtu() then resets it with no room for an 802.1Q tag:

	dev->hard_mtu = net->mtu + net->hard_header_len;

HW VLAN stripping is not enabled, so received frames keep their tags
inline. A full-size tagged frame is mtu + 18 bytes, which is more than
mtu + 14 + AX179A_RX_HW_PAD.

So after any MTU change, for example 9000 to 1500, max-size traffic on
VLAN sub-interfaces would be dropped here with no counters. Before the
MTU is first changed, the same traffic is accepted.

[ ... ]

> +static int ax88179a_reset(struct usbnet *dev)
> +{

[ ... ]

> +	/* Ensure EEE state is off, consistent with phylink setup */
> +	ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, false, 0, NULL);
> +
> +	phylink_start(ax179_data->phylink);
> +
> +	return 0;
> +}

[Severity: Medium]
ax88179a_reset() is the driver_info->reset hook, and usbnet_open() calls
it before usbnet_status_start(). If usbnet_status_start() fails,
usbnet_open() jumps to done without calling info->stop(). ndo_stop is
never called either, because the open failed.

Won't phylink and the PHY state machine keep running with the interface
down? They could still issue USB register writes through mac_link_up().

On the next ifup, phylink_start() calls phy_start() again on a PHY that
is already started, which would hit:

	WARN(1, "called from state %s\n", phy_state_to_str(phydev->state));

[ ... ]

> @@ -0,0 +1,983 @@
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
> +	int ret;
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
> +	ret = ax88179_read_cmd(dev, AX_ACCESS_PHY, phy_id, (__u16)regnum, 2, &res);
> +	if (ret < 0)
> +		return ret;
> +	return res;
> +}
> +
> +static int ax88179_mdiobus_write(struct mii_bus *bus, int phy_id, int regnum, u16 val)
> +{
> +	struct usbnet *dev = bus->priv;
> +
> +	return ax88179_write_u16(dev, AX_ACCESS_PHY, phy_id, (__u16)regnum, val);

[Severity: Medium]
The mii_bus ->write and ->write_c45 callbacks are expected to return 0
on success or a negative errno.

ax88179_mdiobus_write() returns ax88179_write_u16() directly.
ax88179_mdiobus_write_c45() returns ax179a_write_mmd(), which in turn
returns ax88179_write_cmd().

Both end up in __ax88179_write_cmd() and usbnet_write_cmd(). These pass
back the usb_control_msg() byte count. Won't every successful 2-byte
write therefore return 2 instead of 0?

For SIOCSMIIREG, phylink_mii_ioctl() passes that value straight back to
userspace through ax88179a_mii_ioctl(). Some phylib or PHY driver code
checks if (ret) after phy_write() or phy_write_mmd(), rather than
if (ret < 0). That code would treat a successful write as a failure.

Could both write callbacks map a non-negative result to 0?

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
> +	if (link_sts & AX_USB_FS)
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
> +static int ax88179a_get_link_ksettings(struct net_device *net,
> +				       struct ethtool_link_ksettings *cmd)
> +{
> +	struct ax88179_data *data = netdev2data(net);
> +
> +	return phylink_ethtool_ksettings_get(data->phylink, cmd);
> +}
> +
> +static int ax88179a_set_link_ksettings(struct net_device *net,
> +				       const struct ethtool_link_ksettings *cmd)
> +{
> +	struct ax88179_data *data = netdev2data(net);
> +
> +	return phylink_ethtool_ksettings_set(data->phylink, cmd);
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
> +	.nway_reset		= phy_ethtool_nway_reset,
> +	.get_link_ksettings	= ax88179a_get_link_ksettings,
> +	.set_link_ksettings	= ax88179a_set_link_ksettings,
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
> +	u8 link_sts = 0, reg8[3];
> +	u8 bulk_config_speed = 0;
> +	u16 mode;
> +
> +	/* Stop RX/TX for link configuration */
> +	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, AX_RX_CTL_STOP);
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 0);
> +
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_CDC_DELAY_TX, 1, 0xa5);
> +
> +	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 2, 0x0410);
> +
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_ETH_TX_GAP, 1, 0);
> +
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_EP5_EHR, 1, 0x07);
> +
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_NEW_PAUSE_CTRL, 1,
> +			 0x28 | AX_NEW_PAUSE_EN);
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
> +		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 0x40);
> +		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT + 1, 1,
> +				 AX_MAC_MIQFFCTRL_FORMAT | AX_MAC_MIQFFCTRL_DROP_CRC |
> +				 AX_MAC_LSO_ERR_EN);
> +
> +		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_BFM_DATA, 1, AX_XGMII_EN);
> +
> +		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_LSO_ENHANCE_CTRL, 1,
> +				 0x1C | AX_LSO_ENHANCE_EN);
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
> +		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 0x40);
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
> +		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_RX_DATA_CDC_CNT, 1, 0xFA);
> +
> +		bulk_config_speed = ETHER_LINK_10;
> +		break;
> +	}
> +
> +	ax88179_read_cmd(dev, AX_ACCESS_MAC, PHYSICAL_LINK_STATUS, 1, 1, &link_sts);
> +	ax88179a_bulkin_config(dev, link_sts, bulk_config_speed, !!duplex);
> +
> +	if (speed != SPEED_2500)
> +		ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_BFM_DATA, 1, 0);
> +
> +	if (duplex)
> +		mode |= AX_MEDIUM_FULL_DUPLEX;
> +
> +	mutex_lock(&ax179_data->medium_status_mutex);
> +	if (dev->net->mtu > 1500)
> +		mode |= AX_MEDIUM_JUMBO_EN;
> +	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, mode);
> +
> +	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, READ_ONCE(ax179_data->rxctl));
> +	mutex_unlock(&ax179_data->medium_status_mutex);
> +
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1,
> +			 AX_MAC_RX_PATH_READY | AX_MAC_TX_PATH_READY);
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
> +static int ax88179a_mii_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
> +{
> +	struct ax88179_data *data = netdev2data(net);
> +
> +	return phylink_mii_ioctl(data->phylink, rq, cmd);
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
> +	.ndo_eth_ioctl		= ax88179a_mii_ioctl,
> +};
> +
> +static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
> +{
> +	struct usb_device *udev = interface_to_usbdev(intf);
> +	struct ax88179_data *ax179_data;
> +	int ret;
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
> +	mutex_init(&ax179_data->medium_status_mutex);
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
> +		ret = ax88179_read_cmd(dev, AX88179A_ACCESS_BL, AX88179A_SW_VERSION + i,
> +				       1, 1, &ax179_data->fw_version[i]);
> +		if (ret < 0)
> +			ax179_data->fw_version[i] = 0xff;
> +	}
> +	ret = ax88179_read_cmd(dev, AX88179A_ACCESS_BL, AX88179A_SW_REVISION,
> +			       1, 1, &ax179_data->fw_version[3]);
> +	if (ret < 0)
> +		ax179_data->fw_version[3] = 0xff;
> +
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
> +			      NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO;
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
> +	ax88179_write_u8(dev, AX88179A_PHY_POWER, 0, 0, AX_PHY_POWER);
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
> +
> +	/* Configure RX control register => stop operation */
> +	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, AX_RX_CTL_STOP);
> +
> +	rtnl_lock();
> +	phylink_disconnect_phy(ax179_data->phylink);
> +	rtnl_unlock();
> +	phylink_destroy(ax179_data->phylink);
> +	ax88179a_mdio_unregister(ax179_data);
> +
> +	ax88179_write_u8(dev, AX88179A_PHY_POWER, 0, 0, 0);
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
> +	__le64 *pkt_desc_ptr;
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
> +	rx_hdr = get_unaligned_le64((__le64 *)skb_tail_pointer(skb));
> +
> +	/* Check these packets */
> +	hdr_off = FIELD_GET(AX179A_RX_DH_DESC_OFFSET, rx_hdr);
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
> +	pkt_desc_ptr = (__le64 *)(skb->data + hdr_off);
> +
> +	pkt_end = 0;
> +	while (pkt_cnt--) {
> +		u64 pkt_desc = get_unaligned_le64(pkt_desc_ptr);
> +		u32 pkt_len_plus_padd;
> +		u32 pkt_len;
> +
> +		pkt_len = FIELD_GET(AX179A_RX_PD_LEN, pkt_desc);
> +		pkt_len -= (ax179_data->ip_align ? 2 : 0);
> +		pkt_len_plus_padd = ((pkt_len + 7 + (ax179_data->ip_align ? 2 : 0)) & 0x7FFF8);
> +
> +		pkt_end += pkt_len_plus_padd;
> +		if (pkt_end > hdr_off || (pkt_cnt == 0 && pkt_end != hdr_off))
> +			goto err;
> +
> +		if (pkt_desc & AX179A_RX_PD_DROP || !(pkt_desc & AX179A_RX_PD_RX_OK) ||
> +		    pkt_len > (dev->hard_mtu + AX179A_RX_HW_PAD) || pkt_len < 2 + ETH_HLEN) {
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
> +			__vlan_hwaccel_put_tag(ax_skb, htons(ETH_P_8021Q), vlan_tag);
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
> +	tx_desc |= FIELD_PREP(AX179A_TX_DESC_MSS, (u64)skb_shinfo(skb)->gso_size);
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
> +		tx_desc |= FIELD_PREP(AX179A_TX_DESC_VLAN_ID, (u64)tci);
> +	}
> +
> +	if (!dev->can_dma_sg && (dev->net->features & NETIF_F_SG) && skb_linearize(skb)) {
> +		dev_kfree_skb_any(skb);
> +		return NULL;
> +	}
> +
> +	headroom = skb_headroom(skb);
> +	tailroom = skb_tailroom(skb);
> +
> +	if (skb_cloned(skb) || !(headroom >= sizeof(tx_desc) && tailroom >= padding_size)) {
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
> +
> +	return skb;
> +}
> +
> +static int ax88179a_reset(struct usbnet *dev)
> +{
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	u16 *tmp16;
> +	u8 buf[5];
> +	u16 rxctl;
> +	u8 *tmp;
> +
> +	tmp16 = (u16 *)buf;
> +	tmp = (u8 *)buf;
> +
> +	/* Power up ethernet PHY */
> +	ax88179_write_u8(dev, AX88179A_PHY_POWER, 0, 0, AX_PHY_POWER);
> +	msleep(250);
> +
> +	/* Ethernet PHY Auto Detach*/
> +	ax88179a_auto_detach(dev);
> +
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_BULK_OUT_CTRL, 1, AX_MAC_EFF_EN);
> +
> +	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 0);
> +
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 0x04);
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH, 1, 0x10);
> +
> +	*tmp = 0;
> +	if (dev->net->features & NETIF_F_HW_VLAN_CTAG_FILTER)
> +		*tmp |= AX_VLAN_CONTROL_VFE;
> +	if (dev->net->features & NETIF_F_HW_VLAN_CTAG_RX)
> +		*tmp |= AX_VLAN_CONTROL_VSO;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, tmp);
> +
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_INT_MASK, 1, 0xff);
> +
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_RX_DMA_CTL, 1, 0);
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_TX_DMA_CTL, 1, 0);
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_ARC_CTRL, 1, 0);
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_SWP_CTRL, 1, 0);
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_TX_HDR_CKSUM, 1, 0);
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
> +	if (dev->net->features & NETIF_F_RXCSUM) {
> +		ax88179_write_u8(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1,
> +				 AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
> +				 AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6);
> +		ax179_data->rx_checksum = 1;
> +	} else {
> +		ax179_data->rx_checksum = 0;
> +		ax88179_write_u8(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 0);
> +	}
> +
> +	*tmp = 0;
> +	if (dev->net->features & NETIF_F_IP_CSUM)
> +		*tmp = AX_TXCOE_IP | AX_TXCOE_TCP | AX_TXCOE_UDP;
> +	if (dev->net->features & NETIF_F_IPV6_CSUM)
> +		*tmp |= AX_TXCOE_IP | AX_TXCOE_TCPV6 | AX_TXCOE_UDPV6;
> +	ax88179_write_u8(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, *tmp);
> +
> +	/* Configure RX control register => start operation */
> +	rxctl = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_START | AX_RX_CTL_AP |
> +		AX_RX_CTL_AMALL | AX_RX_CTL_AB;
> +	if (ax179_data->ip_align)
> +		rxctl |= AX_RX_CTL_IPE;
> +	if (dev->net->flags & IFF_PROMISC)
> +		rxctl |= AX_RX_CTL_PRO;
> +	WRITE_ONCE(ax179_data->rxctl, rxctl);
> +	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, rxctl);
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
> +			     1, 1, tmp) > 0)
> +		ax179_data->wol_supported = WAKE_MAGIC | WAKE_PHY;
> +
> +	/* Ensure EEE state is off, consistent with phylink setup */
> +	ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, false, 0, NULL);
> +
> +	phylink_start(ax179_data->phylink);
> +
> +	return 0;
> +}
> +
> +static int ax88179a_stop(struct usbnet *dev)
> +{
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	u16 reg16 = 0;
> +
> +	phylink_stop(ax179_data->phylink);
> +
> +	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);
> +	reg16 &= ~AX_MEDIUM_RECEIVE_EN;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);
> +
> +	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 0);
> +
> +	ax88179_write_u8(dev, AX88179A_PHY_POWER, 0, 0, 0);
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
All three new driver_info entries set FLAG_AVOID_UNLINK_URBS. None of
the existing ax88179 entries do.

With that flag, usbnet_stop() skips usbnet_terminate_urbs().
ax88179a_stop() only clears AX_MEDIUM_RECEIVE_EN and AX_RX_CTL and
powers down the PHY. The RX URBs stay submitted, and stay on dev->rxq,
after ifdown.

What happens if the device is then unplugged or unbound while the
interface is still down?

usb_unbind_interface()
  usb_disable_interface()      <- kills the leftover RX URBs
    rx_complete()
      defer_bh()               <- queues dev->bh_work
  usbnet_disconnect()
    unregister_netdev()        <- not running, no usbnet_stop()
    cancel_work_sync(&dev->kevent)
    free_netdev()              <- bh_work still pending

usbnet_bh_work() would then run on the freed struct usbnet and
net_device.

On a physical unplug, rx_complete() can also arm dev->delay on
-EPROTO, -ETIME or -EILSEQ. On this path nothing deletes that timer
before free_netdev().

Why do these chips need FLAG_AVOID_UNLINK_URBS? If there is no
hardware reason, could the flag be dropped? If there is one, how are
the outstanding RX URBs, bh_work and the delay timer meant to be
cleaned up before free_netdev()?

[Severity: Medium]
ax88179a_reset() is the driver_info->reset hook, so usbnet_open() runs
it on every ifup. It re-reads the MAC with ax88179_get_mac_addr() and
then copies dev->net->dev_addr into dev->net->perm_addr.

What happens if the address was changed while the interface was down?
ax88179_set_mac_addr() only allows a change when !netif_running(). It
writes the new address into dev_addr and AX_NODE_ID. On the next ifup:

- With a platform/DT MAC, eth_platform_get_mac_address() succeeds and
  the user-configured address is silently replaced in both dev_addr
  and AX_NODE_ID.

- Without one, the user's address is read back from AX_NODE_ID. For a
  non-local address, addr_assign_type is set back to NET_ADDR_PERM.
  The memcpy() then overwrites perm_addr with the user's address. The
  real permanent address is lost until the device is rebound, and
  ethtool -P reports the wrong value.

The in_pm check added later in the series doesn't cover this. in_pm is
false when ax88179a_reset() is called from usbnet_open().

ax88179a_bind() already reads the MAC and sets perm_addr. Does the
reset path need to do more than program dev->net->dev_addr into
AX_NODE_ID?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-ax88179a-v20-0-37b5a1189983%40birger-koblitz.de
