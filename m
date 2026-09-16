Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7B3F1653;
	Wed, 16 Sep 2026 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541262; cv=none; b=oqjEoGFuyfUx7CO2evqB2vlOe8ITTvsR56SvWsjbk0bCSQ7rJcJu0w/lGzVhkUE/ox4qoe1oJtNXNviCwRAxKdRSIiGgfu/zrEminaGlUhDmSzIkZf21sPXYXX3veucO4mGn+47ptrWI/8hRH5s1H9JB678qW9kD/Idf7FxQ/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541262; c=relaxed/simple;
	bh=Co/CR2VspwMp9bD8dBz1GmQstwwcTN50/G2bEEAQa+s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KFyh9uTMDMUVTjY+pq1adJcehzQpb3V/Mol7E7pMI4MHb1Ggk6cBRzuJBMwHumfgVo/rj2qUTVzznqUD/fUa8KD+2BfgktqWepzMIC2vp7dXIKbBtf2UDWpTbeBMSBgTAKMUeYIhF5RnQDcjpDhdcYzHSFAkvctf2OS6ar/N4go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9hn/VoA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9hn/VoA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8981F000FF;
	Wed, 16 Sep 2026 06:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541258;
	bh=fYdp3ky3qTXf+iDmtaQCpvhTKOp84/VX8WGsiHtKfi0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E9hn/VoAXrwgw0W/hpjwVWc+PSixXQ4SfgzzaIMAI0BSm8XzZpgv/7bwuuRK/YUc5
	 aGewki2BFk0tA9CBmN2z0D5jmgJRzjb6CtjLHiYgt4zo3AvQIAeGhWWcuhoMjlLFTX
	 bIqCDOa0fWt7YK9wp8JdxQ1bKUDHluJ4wqkOAx2VTEucoosVYgkcYaBAtu/z0iYtHL
	 L6Yua13X0TTEN21f8e+MeXwJ4YOhcrcUenLcCBA1n6bgPUZJTi0xUZtlJXNneKbUpp
	 2QD7FPfpyb32joClSim59z6m+mlsXrJZ4nzkO4u4btYvTdcAbl+5R9FwFHIk/xvrFs
	 5lz63R2v93T/Q==
Subject: Re: [PATCH net-next v11 13/15] ax88179_178a: Update driver name and
 information
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Wed, 16 Sep 2026 06:47:37 +0000
Message-ID: <178954125748.22033.8898298216384987097@kernel.org>
In-Reply-To: <20260914-ax88179a-v11-13-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-13-5ea7a925ba6d@birger-koblitz.de>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 3

- [Medium] The patch renames the user-visible Kconfig symbol
  USB_NET_AX88179_178A to USB_NET_AX88179 (drivers/net/usb/Kconfig:198,…
- [Low] The changelog states the patch adds 'further requirements such as
  PHYLINK', but `select PHYLINK` is not added by this patch: it appears…
- [Low] Changing usb_driver.name from "ax88179_178a" to "ax88179" in
  drivers/net/usb/ax88179_178a.c also renames the userspace-visible…
- [Low] The updated user-facing metadata classifies the whole family as
  Gigabit Ethernet while the same patch documents two non-Gigabit parts.

--

ax88179_178a: Update driver name and information

This patch renames the Kconfig symbol for the ax88179 driver, extends the
Kconfig prompt and help text with the newly supported ASIX parts, and
renames the usb_driver structure, its .name string and MODULE_DESCRIPTION.

A few questions below about the symbol rename and the wording.

> diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
> index 115990b0d9537..4158455a2da76 100644
> --- a/drivers/net/usb/Kconfig
> +++ b/drivers/net/usb/Kconfig
> @@ -195,11 +195,12 @@ config USB_NET_AX8817X
>  	  This driver creates an interface named "ethX", where X depends on
>  	  what other networking devices you have in use.
>  
> -config USB_NET_AX88179_178A
> -	tristate "ASIX AX88179/178A USB 3.0/2.0 to Gigabit Ethernet"
> +config USB_NET_AX88179
> +	tristate "ASIX AX88179/179A/178A USB 3.0/2.0 to Gigabit Ethernet"

[Severity: Medium]
Does renaming USB_NET_AX88179_178A to USB_NET_AX88179 silently flip the
driver on for the two in-tree defconfigs that still spell the old name?

Both arch/loongarch/configs/loongson32_defconfig and
arch/loongarch/configs/loongson64_defconfig still contain:

	CONFIG_USB_USBNET=m
	# CONFIG_USB_NET_AX8817X is not set
	# CONFIG_USB_NET_AX88179_178A is not set

Kconfig has no alias for a renamed symbol, so that line now refers to an
unknown symbol and is dropped. With USB_USBNET=m and the new symbol
keeping "default y", USB_NET_AX88179 resolves to m on those platforms, so
drivers/net/usb/Makefile builds ax88179.o and the select lines below
force-enable PHYLINK (and thus PHYLIB) plus AX88796B_PHY where the
platform configs had explicitly disabled the driver.

The same loss of the stored value happens for any existing .config run
through make oldconfig or make olddefconfig.

Would it make sense to rename the two defconfig entries in this patch,
and to mention the symbol rename in the changelog? The changelog
currently only speaks of the Kconfig description, the usb_driver name and
MODULE_DESCRIPTION.

[Severity: Low]
The prompt still says "to Gigabit Ethernet" while the help text below
gains AX88279 and AX88772D/E. In drivers/net/usb/ax88179a_devices.c those
same parts are described as:

	.description = "ASIX AX88772D/E USB 2.0 Fast Ethernet",
	.description = "ASIX AX88279 USB 3.2 2.5Gigabit Ethernet",

so the family now spans 100 Mbit, 1 Gbit and 2.5 Gbit. Should the prompt,
the help text ("to Gigabit Ethernet adapters") and MODULE_DESCRIPTION use
speed-neutral wording, or list Fast/Gigabit/2.5-Gigabit explicitly?

>  	depends on USB_USBNET
> -	select CRC32
>  	select PHYLINK
> +	select AX88796B_PHY
> +	select CRC32

[Severity: Low]
The changelog says the patch adds "further requirements such as PHYLINK".
Is that accurate? "select PHYLINK" appears here as an unchanged context
line; it was added by an earlier patch in the series (the pre-series tree
has "select PHYLIB"). The requirement this patch actually adds is "select
AX88796B_PHY", which force-enables the ASIX PHY driver for every config
that enables USB_NET_AX88179. Could the changelog name that one instead?

>  	default y
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
>  
> diff --git a/drivers/net/usb/Makefile b/drivers/net/usb/Makefile
> index 2ecead0181eaf..4026f19ecb826 100644
> --- a/drivers/net/usb/Makefile
> +++ b/drivers/net/usb/Makefile
> @@ -12,7 +12,7 @@ obj-$(CONFIG_USB_HSO)		+= hso.o
>  obj-$(CONFIG_USB_LAN78XX)	+= lan78xx.o
>  obj-$(CONFIG_USB_NET_AX8817X)	+= asix.o
>  asix-y := asix_devices.o asix_common.o ax88172a.o
> -obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179.o
> +obj-$(CONFIG_USB_NET_AX88179)      += ax88179.o
>  ax88179-y := ax88179_178a.o ax88179a_devices.o ax88179_lib.o

[ ... ]

> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 44a768c5808ac..1d35ef90eceb7 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -1341,8 +1341,8 @@ static const struct usb_device_id products[] = {
>  };
>  MODULE_DEVICE_TABLE(usb, products);
>  
> -static struct usb_driver ax88179_178a_driver = {
> -	.name =		"ax88179_178a",
> +static struct usb_driver ax88179_driver = {
> +	.name =		"ax88179",

[Severity: Low]
Is the userspace-visible side of this rename intentional? The .name
string is what shows up as /sys/bus/usb/drivers/ax88179_178a/ with its
bind, unbind and new_id attributes, so scripts and udev rules using that
path would need updating.

It is also reported by ethtool -i, via:

drivers/net/usb/usbnet.c:usbnet_probe() {
	...
	dev->driver_name = name;
	...
}

drivers/net/usb/usbnet.c:usbnet_get_drvinfo() {
	...
	strscpy(info->driver, dev->driver_name, sizeof(info->driver));
	...
}

and ax88179a_get_drvinfo() in drivers/net/usb/ax88179a_devices.c calls
usbnet_get_drvinfo() and only overwrites fw_version, so info->driver now
reads "ax88179". Could the changelog state this rename is userspace
visible, and that the patch is not a stable backport candidate?

>  	.id_table =	products,
>  	.probe =	usbnet_probe,
>  	.suspend =	ax88179_suspend_wrapper,
> @@ -1353,7 +1353,7 @@ static struct usb_driver ax88179_178a_driver = {
>  	.disable_hub_initiated_lpm = 1,
>  };
>  
> -module_usb_driver(ax88179_178a_driver);
> +module_usb_driver(ax88179_driver);
>  
> -MODULE_DESCRIPTION("ASIX AX88179/178A based USB 3.0/2.0 Gigabit Ethernet Devices");
> +MODULE_DESCRIPTION("ASIX AX88179/179A/178A based USB 3.0/2.0 Gigabit Ethernet Devices");
>  MODULE_LICENSE("GPL");

The Gigabit wording question above applies to this modinfo string as
well, since AX88772D/E is a Fast Ethernet part and AX88279 is 2.5 Gbit.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ax88179a-v11-0-5ea7a925ba6d%40birger-koblitz.de
