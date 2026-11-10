Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274725;
	b=0YR5FoSxTCt04GGC/dMJnFnbqFl9gKNYfhdYNOtJxjw1lrvvxYhX/RnKnN27woH0s+3r
	 pwlNg3R5eKCwwVPDOZbyhxeAHSDin1lXAc2600Ad17R39NXMUGBduV/1l/IpE3IR94o21
	 GO1fNl8zfyllTjh3i4dH6LnVturSMIuP7BXqtdZtxPpv6Q1uXVWKOOizKqZlm4yW3K+nK
	 PCWjtSEM2qE/iRNp7+1MziDHriWisU4d7yhStpjBGBR4WXLnT+1aieIwtEzAykEmGT0C5
	 fhGUI2aMkqtQdCieRcIgqjxhTuts/kZ0hIpaWJsAurOXo6MFMGQShgEjUKOmj3Guwdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274725;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EGEcWUfn/13k0jIOiTW1HLBDS6PwspAB17PSb8l0O0g=;
	b=1LDBfoe0SXVxcdOtu/TKur+J5Nj8RUEn1giBSLF0bEM1VAHNhMYXSBiu0NPFrbd9K3so
	 LRz005TvtrrsAsk7D3FoHimdIbgBKbxm2jGuYgfkGBkicKLD2GkXGzWjLCaEX7tiKuukH
	 zeELemmUCxB89fSvpQc2quGjQbhoMvtbXfAsFOuWhYwWQsX49IVKhr66MWP/GZyxt2IDz
	 6LMP3uJGh8zHclEHfN7uTJ3d+pGNL2z6RnBB+wxOQsJazTu7j0eD8ZOkcdB4FU7+/MFWQ
	 1qiY0Mu2VKFEA+piqoYl3P3OCiMqYkuq8hQoexoBouMwPNfFd9eoqpIlJpKgcQDVqkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQ27L1D6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B0606A920;
	Tue, 10 Nov 2026 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQ27L1D6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4E91F008A1;
	Tue, 10 Nov 2026 01:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274724;
	bh=EGEcWUfn/13k0jIOiTW1HLBDS6PwspAB17PSb8l0O0g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EQ27L1D62o4r9n7Vf1jcWqtP8qKSQaYpGWTyD2OOwICCaWDcVTgdrfEiV5OJbhZ4Z
	 L1XjluK+daXOx0HwEzsKuat4CucsjBjFfFOFVi67Dd7sEOZvEPmzTK3PTT5IDNjXko
	 lCgwP9YgqRQ9e/PzOrXDG6XGn1SYTaVFYp6LUFtX6iaO0kddN8WCjj9xaI4+OagJJx
	 AXxrQvCUsB30XAQvDi6tCc5CZ1fkyzfB/vfr2yZmoJIpGHy80eow9WqLRw4kj3/MEo
	 hy/RJG9ob6RKTI3ppEjaEzuh2CvxvZPRQosY4hl64GlUIA9AKexVqEJDVcUg64LUVF
	 HicqlW2Mhrv2g==
Subject: Re: [PATCH net-next v20 11/13] ax88179_178a: Update driver name and
 information
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name,
 edumazet@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 neuromoments@gmail.com, beganovic.emir@gmail.com
Date: Tue, 10 Nov 2026 01:38:43 +0000
Message-ID: <179427472308.994134.12251386133447333120@kernel.org>
In-Reply-To: <20261106-ax88179a-v20-11-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-11-37b5a1189983@birger-koblitz.de>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch renames the USB driver from "ax88179_178a" to
  "ax88179" (`struct usb_driver ax88179_driver`, `.name = "ax88179"`,…
- [Medium] The patch renames the Kconfig symbol
  CONFIG_USB_NET_AX88179_178A to CONFIG_USB_NET_AX88179…
- [Medium] The patch adds `select AX88796B_PHY` to USB_NET_AX88179
  (drivers/net/usb/Kconfig:202) so that the internal PHYs of the…
- [Low] After this patch, which exists to update these strings, the
  descriptions of supported hardware disagree with each other and with…

--

ax88179_178a: Update driver name and information

This commit renames the Kconfig symbol USB_NET_AX88179_178A to
USB_NET_AX88179 and renames the usb_driver from ax88179_178a to ax88179.
It adds a select of AX88796B_PHY and updates the Kconfig help text and
MODULE_DESCRIPTION to list the AX88179A/B, AX88279 and AX88772D/E chips.
It also updates the two loongarch defconfigs to use the new symbol.

> diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
> index 115990b0d9537..27862e380bdb4 100644
> --- a/drivers/net/usb/Kconfig
> +++ b/drivers/net/usb/Kconfig
> @@ -195,11 +195,12 @@ config USB_NET_AX8817X
>  	  This driver creates an interface named "ethX", where X depends on
>  	  what other networking devices you have in use.
>  
> -config USB_NET_AX88179_178A
> -	tristate "ASIX AX88179/178A USB 3.0/2.0 to Gigabit Ethernet"
> +config USB_NET_AX88179
> +	tristate "ASIX AX88179/179A/178A USB 2.0/3.0 to 100M/1G/2.5GbE Adapters"
>  	depends on USB_USBNET
> -	select CRC32
>  	select PHYLINK
> +	select AX88796B_PHY

[Severity: Medium]

The commit message says this will "add further requirements such as
PHYLINK", but select PHYLINK was already there and CRC32 has only moved.
The only new dependency is AX88796B_PHY, and the message does not name it.
Could the commit message mention it?

Does selecting AX88796B_PHY have any effect at this point in the series?
ax88179_mdiobus_read() in ax88179a_devices.c returns synthetic PHY IDs for
the new chips:

	if (phy_id == AX88179_PHY_ID && regnum == MII_PHYSID2) {
		if (priv->chip_version == AX_VERSION_AX88179A && priv->is_ax88772d)
			return 0x772d;
		else if (priv->chip_version == AX_VERSION_AX88179A)
			return 0x179a;
		else if (priv->chip_version == AX_VERSION_AX88279)
			return 0x2790;

At this commit, no PHY driver matches 0x003b179a, 0x003b772d or
0x003b2790. The later commit "ax88796b: Add support for AX88772D, AX88179A
and AX88279" adds these IDs, but only to the C driver in
drivers/net/phy/ax88796b.c.

When CONFIG_AX88796B_RUST_PHY is set, drivers/net/phy/Makefile builds the
Rust driver for this symbol instead:

ifdef CONFIG_AX88796B_RUST_PHY
  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b_rust.o
else
  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
endif

drivers/net/phy/ax88796b_rust.rs still registers only:

    drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],

With CONFIG_AX88796B_RUST_PHY=y, won't phylib fall back to genphy for the
AX88179A, AX88772D and AX88279 PHYs, even at the end of the series?

For the AX88279, the genphy fallback drops asix_ax88279_get_features(),
the custom config_aneg and read_status, PHY_BROKEN_FORCED, and the
2500BASEX/SGMII interface switching. genphy can't advertise or report
2500baseT. Can the 2.5G mode that the MAC advertises be negotiated at all
in that case? The AX88772D would also lose its 1000baseT capability
masking.

The Kconfig help for the Rust variant says "The features are equivalent".
Should ax88796b_rust.rs get matching entries for the new IDs?

> +	select CRC32
>  	default y

[Severity: Medium]

What happens to existing .config files after this symbol is renamed?

A saved CONFIG_USB_NET_AX88179_178A=m, or "# CONFIG_USB_NET_AX88179_178A
is not set", no longer refers to any symbol. make olddefconfig then treats
USB_NET_AX88179 as a new symbol and gives it the default y, which is
limited to m when USB_USBNET=m.

Configs that deliberately disabled the driver get it re-enabled. That is
why the two loongarch defconfigs had to be fixed by hand in this patch.
Distro configs with =m and USB_USBNET=y end up with the driver built in.

The rename is cosmetic, so could the USB_NET_AX88179_178A symbol name be
kept? If the rename stays, should the commit message mention the effect on
out-of-tree and distro configs?

>  	help
>  	  This option adds support for ASIX AX88179 based USB 3.0/2.0
> @@ -207,6 +208,9 @@ config USB_NET_AX88179_178A
>  
>  	  This driver should work with at least the following devices:
>  	    * ASIX AX88179
> +	    * ASIX AX88179A/B
> +	    * ASIX AX88279
> +	    * ASIX AX88772D/E
>  	    * ASIX AX88178A
>  	    * Sitcomm LN-032

[Severity: Low]

This isn't a bug, but after this change the descriptions of supported
hardware don't agree with each other.

The new prompt mentions 100M and 2.5GbE but doesn't name the AX88279 or
the AX88772D, which are the chips that provide those speeds.

The help body still begins "This option adds support for ASIX AX88179
based USB 3.0/2.0 to Gigabit Ethernet adapters", but the list below it now
includes the AX88179A/B, AX88279 and AX88772D/E.

The new MODULE_DESCRIPTION in ax88179_178a.c leaves out the AX88772D/E:

  "ASIX AX88179/179A/178A/279 based USB 3.0/2.0 100M/1G/2.5GbE Controllers"

products[] still binds that chip through ax88772d_info.

The help text also doesn't mention that the module is now called ax88179.
It still has the existing typo "Sitcomm LN-032" (should be Sitecom).

[ ... ]

> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index b077b7153f0c0..88dce368eacfe 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -1361,8 +1361,8 @@ static const struct usb_device_id products[] = {
>  };
>  MODULE_DEVICE_TABLE(usb, products);
>  
> -static struct usb_driver ax88179_178a_driver = {
> -	.name =		"ax88179_178a",
> +static struct usb_driver ax88179_driver = {
> +	.name =		"ax88179",

[Severity: Medium]

Doesn't this rename change what userspace sees for every existing
AX88179/AX88178A adapter, and for the OEM adapters built on them?

usbnet_probe() copies the usb_driver name into the usbnet state:

	name = udev->dev.driver->name;
	...
	dev->driver_name = name;

usbnet_get_drvinfo() then reports that name:

	strscpy(info->driver, dev->driver_name, sizeof(info->driver));

ax88179a_get_drvinfo() calls usbnet_get_drvinfo(). The legacy
ax88179_ethtool_ops has no get_drvinfo, so the ethtool core falls back to
the parent device's driver name, which is the same string.

After this patch, ethtool -i reports "driver: ax88179" instead of
"driver: ax88179_178a". /sys/bus/usb/drivers/ax88179_178a/ also becomes
/sys/bus/usb/drivers/ax88179/.

After a kernel upgrade, several kinds of existing config would stop
matching:

  - systemd .link/.network files with Driver=ax88179_178a
  - udev rules with DRIVERS=="ax88179_178a"
  - NetworkManager matches on the driver name
  - scripts that write to .../drivers/ax88179_178a/{bind,unbind,new_id}

MODULE_ALIAS("ax88179_178a") at the end of the file only keeps the old
module name loadable. It has no effect on the usb_driver name.

Could .name stay as "ax88179_178a"? The commit message only says "Update
driver name in usb_driver" and does not mention this compatibility impact.

>  	.id_table =	products,
>  	.probe =	usbnet_probe,
>  	.suspend =	ax88179_suspend_wrapper,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-ax88179a-v20-0-37b5a1189983%40birger-koblitz.de
