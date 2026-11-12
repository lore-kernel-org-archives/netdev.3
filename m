Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470369;
	b=2P2V/MtMFJhi7MINWXdIjzZd0sm1Sm5WT6F+SkSBMf9J8XrUsXT0aMi5DioYSZEuVwyI
	 ossmj2vPo6LGVgw7S20LqFzVHC5v+BGGYgE4ev/AHxVK9rL4A9wQiqH7z3QOny6kqhcl2
	 esWUZZCP9Qjtx9E3S2hYJffqE3bEyL6diSohQP7S+cPRk5EHvulfHJBlis0UYzHOsiSds
	 qXBgYaKIePs5ro05JGr1pYiWxgMCSF8HD4J4XqSGY9sAxsVsJ/Zt1ka078FjEsAqvo9X7
	 LE3DcffrREB56osQRRKwXll6YxyjJVBaBu/4U99rAF3IwnCcffpZSSaqUb/kmpKZaLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470369;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wQaCaoND2Ob9tUVM3EQRSZPhnHHuEZMAZZbzI1uVGOk=;
	b=GLNQFmY7mYcxwJCELfUv10A6CM8MDMPfUmnpHsTRcprYAZ/Ych40VI/xEffQOeCffoMT
	 wAp2Wwx820nKvYPQmMec8vn9AASbq4Z2c1rSxPmHuiGtJcAzylSV/lNFBF5LDLGt/drpH
	 idTzLAToxvWJi4iL6FXDTDPTGNDKX5fGbbv/XFrSXuVq+bTr8fwXurGxOAPagFq9fsqBl
	 aI/pRbOV0njIBEijbTkihucEFzc1YGGcGPz0TEygzSekdK6ZNhnToWil/+6Oy/nVnTMk4
	 eaPIvuoN3ktpMpOpRxxYXxnPz1IXnRasS1/tqboZkZdsvrPC39HIrQ6LzjkRXUpsqtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H7/bV1mP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A364F606A31C;
	Thu, 12 Nov 2026 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7/bV1mP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966C21F00A07;
	Thu, 12 Nov 2026 07:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794470369;
	bh=wQaCaoND2Ob9tUVM3EQRSZPhnHHuEZMAZZbzI1uVGOk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H7/bV1mPiMFvkta9uF0nJJeUC9ckx6zSFEXwl/v/myV7Qtv3YK4FKTALADGHhxobC
	 d2NZrsMBvvMpKYNFgjgz9RKnONR6dORn6aas5aVFBOFjqybLWqWtL4TuqhePJ2zVgj
	 nZ9P/hSbJuZyYqkuIkTigwVIPLycUsVeJj8gfvNVOyHREZER3JmMkTHTpfKiDkCvmy
	 iuOwsSUlP+03K1u6Bo7xOyL3aLrom55j2m4LQxA/kx5RE+UsnXs4qU8nbtmUnTV1U+
	 aIHemYwZbSuY1ARkSel2hjmQpWjxK5P/+659iQfjJaYDeciw3RHbylxNtSbyWSYauc
	 47eVgbF780tVg==
Subject: Re: [PATCH net-next] net: usb: name usb ethernet mdio buses reliably
From: netdev-bot+sashiko@kernel.org
To: blake.alexander@airbus.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Thangaraj.S@microchip.com,
 UNGLinuxDriver@microchip.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 07:59:28 +0000
Message-ID: <179447036808.2199510.3756033413270962857@kernel.org>
In-Reply-To: <20261109-net-usb-mdio-naming-v1-1-f4cca6737784@airbus.com>
References: <20261109-net-usb-mdio-naming-v1-1-f4cca6737784@airbus.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Three of the four drivers that build these IDs are converted;
  smsc95xx is not.
- [High] The new MDIO bus ID is no longer unique on xHCI controllers with
  two root hubs, which can make the second adapter fail to probe.
- [Medium] The commit says the new name is "predictable and deterministic
  ... when attached at the same position within the USB hierarchy".

--

net: usb: name usb ethernet mdio buses reliably

This commit changes the MDIO bus ID in the asix_devices, ax88172a and
lan78xx USB ethernet drivers. The old ID was a "usb-<busnum>:<devnum>"
string and the new one is the output of usb_make_path(). The goal is a
stable MDIO bus name for fixed USB ethernet controllers soldered onto the
board.

> Use usb_make_path() to generate the MDIO bus name instead, ensuring a
> predictable and deterministic bus naming scheme when attached at the
> same position within the USB hierarchy.

[Severity: Medium]
Is the name deterministic on the embedded controllers this patch is aimed
at?

DWC3 and CDNS3 create their xHCI child with an auto-assigned ID:

drivers/usb/dwc3/host.c:dwc3_host_init() {
    ...
	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
    ...
}

xhci-plat then uses that device name as the bus_name:

drivers/usb/host/xhci-plat.c:xhci_plat_probe() {
    ...
	hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
			       dev_name(&pdev->dev), NULL);
    ...
}

The N in "xhci-hcd.N.auto" comes from the global platform_devid_ida. All
auto-ID platform devices share it, so N depends on registration order and
not on the hardware instance. Things that can change the order include
deferred or async probing, the number of DWC3 instances, and dual-role
re-creation.

Could the same soldered LAN78xx show up as "usb-xhci-hcd.0.auto-1" on one
boot and as "usb-xhci-hcd.1.auto-1" on another?

There is also a link speed case. If a USB3 LAN7800 falls back to high
speed, it enumerates on the USB2 root hub. Its devpath is then the HS port
number, which need not match the SS port number.

The usb_make_path() kerneldoc in include/linux/usb.h already points out
part of this:

 * With a partial exception for devices connected to USB 2.0 root hubs, these
 * identifiers are also predictable.  So long as the device tree isn't changed,
 * plugging any USB device into a given hub port always gives it the same path.
 * Because of the use of "companion" controllers, devices connected to ports on
 * USB 2.0 root hubs (EHCI host controllers) will get one path ID if they are
 * high speed, and a different one if they are full or low speed.

Should the commit message mention these limits?

> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> index 293ef80c4e302..c752fa3868b81 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c
> @@ -680,9 +680,8 @@ static int ax88772_init_mdio(struct usbnet *dev)
>  	priv->mdio->write = &asix_mdio_bus_write;
>  	priv->mdio->name = "Asix MDIO Bus";
>  	priv->mdio->phy_mask = ~(BIT(priv->phy_addr & 0x1f) | BIT(AX_EMBD_PHY_ADDR));
> -	/* mii bus name is usb-<usb bus number>-<usb device number> */
> -	snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
> -		 dev->udev->bus->busnum, dev->udev->devnum);
> +
> +	usb_make_path(dev->udev, priv->mdio->id, MII_BUS_ID_SIZE);

[Severity: High]
Is this ID still unique on xHCI controllers that have two root hubs?

usb_make_path() builds the ID only from bus_name and devpath:

	actual = snprintf(buf, size, "usb-%s-%s", dev->bus->bus_name,
			  dev->devpath);

The USB2 primary HCD and the USB3 shared HCD of one xHCI controller get
the same bus_name. One example is xhci_pci_common_probe():

		xhci->shared_hcd = usb_create_shared_hcd(&xhci_pci_hc_driver, &dev->dev,
							 pci_name(dev), hcd);

xhci_plat_probe() and vhci_hcd_probe() do the same thing with
dev_name(&pdev->dev).

Each root hub numbers its ports from 1, and a device on a root port has
the port number as its devpath. A USB2 adapter on HS root port N and a
USB3 adapter on SS root port N would therefore both get
"usb-<controller>-N".

usbip makes this easy to hit. An AX88772 on the first HS vhci port and a
LAN7800 on the first SS vhci port would both become "usb-vhci_hcd.0-1".

__mdiobus_register() uses bus->id as the device name:

	dev_set_name(&bus->dev, "%s", bus->id);
	...
	err = device_register(&bus->dev);
	if (err) {
		pr_err("mii_bus %s failed to register\n", bus->id);
		return -EINVAL;
	}

Would the second adapter then fail to probe in ax88772_init_mdio(),
ax88172a_init_mdio() or lan78xx_mdio_init()?

The old busnum:devnum ID could not collide here, because the two root
hubs have different bus numbers.

Could the ID include something that tells the shared HCD's root hub apart
from the primary one, such as the root hub speed?

[ ... ]

> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index d73002b2c21ac..153aa56b8e681 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -2117,8 +2117,7 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
>  	dev->mdiobus->name = "lan78xx-mdiobus";
>  	dev->mdiobus->parent = &dev->udev->dev;
>  
> -	snprintf(dev->mdiobus->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
> -		 dev->udev->bus->busnum, dev->udev->devnum);
> +	usb_make_path(dev->udev, dev->mdiobus->id, MII_BUS_ID_SIZE);

[Severity: High]
Should smsc95xx be converted too?

The subject and commit message talk about MDIO bus names for USB ethernet
devices in general. However, smsc95xx_bind() still builds the old ID:

drivers/net/usb/smsc95xx.c:smsc95xx_bind() {
    ...
	snprintf(pdata->mdiobus->id, ARRAY_SIZE(pdata->mdiobus->id),
		 "usb-%03d:%03d", dev->udev->bus->busnum, dev->udev->devnum);
    ...
}

After this patch, it is the only user of that format left in
drivers/net/usb.

The LAN9512/LAN9514 parts that smsc95xx drives are soldered onto boards
such as the Raspberry Pi 1B/2B/3B. That is the use case described in the
commit message.

smsc95xx finds its PHY with phy_find_first() and not by bus name. There
does not seem to be any dependency on the old format.

If smsc95xx was left out on purpose, could the commit message explain
why?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-net-usb-mdio-naming-v1-1-f4cca6737784%40airbus.com
