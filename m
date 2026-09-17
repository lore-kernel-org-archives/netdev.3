Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB334FD7B9;
	Thu, 17 Sep 2026 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680310; cv=none; b=Fy5VoNcLR5hgUoYqi9xnk9wOE5/NMoKGy3JV31xjiYFOrEtWe6UtusmezgeSUQa+FI48zwnmzmQLdSy7DdUq4WTgqltIFBe4yc1xR8x+a++KR70VfDeAPKWzDAmbeqTTEodwwxFcPZRwC+DWU9WwTBIbF2RBp9jW75seXayp8gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680310; c=relaxed/simple;
	bh=qisEgIS/5chZ/VJn8+lVuOWhXvQD1f4T7SJBz4X5VDI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nRA0xv4osn2Gr4cKb0imQbOwopZPJ8N4+k36I18wmS16vjdgKPD64nv9XwhtbMpEIKOybuCYMy8gMGliFVpLDDUDhVdwZHt6GbXup3xnPQubEHjzWWs3Ea4h4rFTmTWaPG1LdyyRvg169cMVwp+VoVXvH5JkS3aGNOpl+pISptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEZM/0uu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEZM/0uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1721F000FF;
	Thu, 17 Sep 2026 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680307;
	bh=4u4Kx7uMFTKGeAvr9D5KBr+pxP+rbnGZ/Uaz86jsU6Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oEZM/0uuEuNUW/R3jUeTLUWjD2d0FYVvCgSYr4w/zhs6anMKUhUHbNDxnk0mu6wxY
	 IanWLQ48wjvp6dKVORLGTe+aF+ECy9kP4tsUOptnaiXWIxleP/apsw0pLFf8/faDvZ
	 2iVjnPuV0yJQaGmTVamgmF9RWp1iwBbAxrs29iK4IsvkoqJyGIx23muzPqGXnoy82m
	 CnHwBHE/7nuh1cal0hGGWkDbc/XAvTP9g/dxwPG3XyMwToSMk8CGSnmIhyA0+4AEm9
	 Rkxv8LdQqaBDmdxnzn9cIzgUZz2KlKbV8hp62QsHKwm2J9eFBl6obmNYiTa5xLoRrF
	 3U8Jo6VxfOWbg==
Subject: Re: [PATCH net-next v12 13/15] ax88179_178a: Update driver name and
 information
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Thu, 17 Sep 2026 21:25:06 +0000
Message-ID: <178968030633.22033.16665978438548871360@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-13-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-13-60c04c9924a2@birger-koblitz.de>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 · Medium: 1 · Low: 3

- [Critical] usb: net: sysfs ABI and module name breakage for ax88179
- [Medium] Undisclosed Kconfig symbol rename leaves two in-tree
  defconfigs orphaned.
- [Low] FALSE POSITIVE (retained only per validation policy): the concern
  claims `select AX88796B_PHY` is bogus because the synthetic PHY IDs…
- [Low] The Kconfig prompt/help and MODULE_DESCRIPTION updated by this
  patch still describe the module as Gigabit-only while the device list…
- [Low] Firmware-version producer/consumer mismatch: ax88179a_bind()
  (drivers/net/usb/ax88179a_devices.c:761-766) reads only three bytes…

--

ax88179_178a: Update driver name and information

This renames the Kconfig symbol for the ax88179 driver, extends the Kconfig
prompt and help text with the newly supported chips, and adds selects for
PHYLINK and AX88796B_PHY. It also renames the usb_driver structure and its
.name string and updates MODULE_DESCRIPTION.

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
>  	depends on USB_USBNET
> -	select CRC32
>  	select PHYLINK
> +	select AX88796B_PHY
> +	select CRC32
>  	default y

[Severity: Medium]
Does this rename leave the two loongarch defconfigs behind?  Both
arch/loongarch/configs/loongson32_defconfig and
arch/loongarch/configs/loongson64_defconfig still carry:

    # CONFIG_USB_NET_AX88179_178A is not set

Since Kconfig silently ignores unknown symbols, and USB_NET_AX88179 keeps
"default y" while both defconfigs have CONFIG_USB_USBNET=m, doesn't
USB_NET_AX88179 come out as m there and the module get built on platforms
that explicitly disabled it?  The same silent flip would happen to any
existing .config with the old symbol disabled when run through
make oldconfig.

Should the two defconfig lines be renamed in the same patch?

The commit message says only:

    Add additionally supported devices to Kconfig description, add
    further requirements such as PHYLINK.

    Update driver name in usb_driver and update MODULE_DESCRIPTION
    to include the additionally supported chips.

The user-visible Kconfig symbol rename from USB_NET_AX88179_178A to
USB_NET_AX88179 is not mentioned at all.  Could the changelog call it out
so backporters know to look for defconfig fallout?

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

[Severity: Low]
This isn't a bug, but the prompt and help text still say Gigabit only,
while the list now includes a Fast Ethernet part and a 2.5G part.  The
prompt reads "ASIX AX88179/179A/178A USB 3.0/2.0 to Gigabit Ethernet" and
the help text says "to Gigabit Ethernet adapters", yet the added entries
are AX88279 and AX88772D/E.

The device table comments in ax88179_178a.c describe them as:

	/* ASIX AX88772D USB 2.0 100Mbit Ethernet */
	/* ASIX AX88279 USB 3.2 2500Mbit Ethernet */

and ax88179a_phylink_setup() in ax88179a_devices.c matches that:

	data->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE | MAC_100;
	if (data->is_ax88772d)
		data->phylink_config.mac_capabilities |= MAC_10;
	else if (data->chip_version < AX_VERSION_AX88279)
		data->phylink_config.mac_capabilities |= MAC_10 | MAC_1000;
	else
		data->phylink_config.mac_capabilities |= MAC_1000 | MAC_2500FD;

Could the wording be widened to cover 10/100 and 2.5G as well?

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
> index 93031b9ee92bc..2601a8875b9e2 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c

[ ... ]

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

[Severity: Low]
Same wording question here: the new MODULE_DESCRIPTION still says
"USB 3.0/2.0 Gigabit Ethernet Devices" although the driver now also binds
the 10/100 AX88772D and the 2.5G AX88279.  Would it be worth updating this
string too?

One more observation, in code this patch does not touch but which comes
from earlier patches in the same series and is still present at the end of
the series:

[Severity: Low]
Is the reported firmware version short one byte?  ax88179a_bind() in
drivers/net/usb/ax88179a_devices.c fills only three entries:

	for (int i = 0; i < 3; i++) {
		ret = ax88179_read_cmd(dev, AX88179A_ACCESS_BL, (0xFD + i),
				       1, 1, &ax179_data->fw_version[i]);
		if (ret < 0)
			ax179_data->fw_version[i] = 0xff;
	}
	netdev_info(dev->net, "AX88179A/279/772D Chip Version: %x, FW: %d.%d.%d.%d\n", ...

but both consumers print four, the probe message above and the ethtool
path in ax88179a_get_drvinfo():

	snprintf(info->fw_version, sizeof(info->fw_version), "%d.%d.%d.%d",
		 priv->fw_version[0], priv->fw_version[1],
		 priv->fw_version[2], priv->fw_version[3]);

struct ax88179_data is allocated with kzalloc_obj(), so fw_version[3] is
always zero rather than firmware data, and ethtool -i reports a trailing
".0" that never came from the device.  Should the fourth byte be read from
its real source, or should the stored and displayed version consistently
use three components?

[ ... ]

> @@ -1341,8 +1341,8 @@ static const struct usb_device_id products[] = {
>  };
>  MODULE_DEVICE_TABLE(usb, products);
>  
> -static struct usb_driver ax88179_178a_driver = {
> -	.name =		"ax88179_178a",
> +static struct usb_driver ax88179_driver = {
> +	.name =		"ax88179",
>  	.id_table =	products,
>  	.probe =	usbnet_probe,
>  	.suspend =	ax88179_suspend_wrapper,

[Severity: Critical]
This renames things that are visible to userspace, and I don't see
any compatibility shim for them.

usb_register() uses struct usb_driver .name verbatim for the driver
directory, so /sys/bus/usb/drivers/ax88179_178a becomes
/sys/bus/usb/drivers/ax88179 with this patch.  Anything that pokes
bind, unbind or new_id under the old path - udev rules, suspend/resume
helper scripts, test harnesses - silently stops finding the directory
after a kernel upgrade.

The module name changes too: the Makefile hunk in this patch keeps
ax88179-y := ax88179_178a.o ax88179a_devices.o ax88179_lib.o, so the
object is now ax88179.ko where it used to be ax88179_178a.ko.  Explicit
modprobe ax88179_178a invocations and any /etc/modprobe.d/ entries
(blacklist ax88179_178a, options ax88179_178a ...) no longer resolve.
Hotplug autoloading should still work since it goes through the
MODULE_DEVICE_TABLE(usb, products) modaliases, but the by-name cases
do not.

Would you consider adding MODULE_ALIAS("ax88179_178a") next to the
updated MODULE_DESCRIPTION so the old module name keeps resolving, or
is the view that the old name is young enough that nothing depends on
it?  Either way, could the changelog state explicitly that the usb
driver .name and the module name change, since right now it only
mentions "Update driver name in usb_driver" without noting the
user-visible consequences?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ax88179a-v12-0-60c04c9924a2%40birger-koblitz.de
