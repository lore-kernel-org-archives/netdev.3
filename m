Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6484CDDE4;
	Thu, 17 Sep 2026 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680298; cv=none; b=pzSlZM6EClRa5B4Ud8IEBu03nriHU2tDs4fhgcunrxZS7Q1ZdQ02eNzdFJg2hFtP72WQLAFj67wK9AbAGyITSwDAw38ceRg4s5ekh4K9qRZuNktp4OgGPSxyh5OzlLHhUmxB3gbn3OdfmnMhv7rtCeWu7BqxKdKXWunQ3bPqk/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680298; c=relaxed/simple;
	bh=o9deayMnkEMPTEuqixKb7y3zpxRuSCsA4amNXEGyd88=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uPY4LSE2Pob1QNy3UbEIZh98KWDWEuDFGFDbLI0dFBCNpKA/rlU+drATzUR8TyRh37Ioz+4sqc9QRf+jmiJGbnHumcAMNAaE75l09PR74ygwMRCIVbrXkIpRJL2Ngppc7njkJmR0czfWb2BX1SfReilMwgtW/6Tyf2jZaVRnVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZWKGyjV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZWKGyjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C21D1F00893;
	Thu, 17 Sep 2026 21:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680295;
	bh=UEiKkXTG555ayl8BTIx71sWHqll/pRlMyqDQo36PE9M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YZWKGyjVsALj5cYZu7bbBQz6fSvSTUmE5ErO+xYByk2X5glWsSyyHUksuUIvT3WJL
	 IW4aYUa56dgVrAeI3+vP/rr17hl6uOXe9EMvuYqBaPnwK4NjYFfdM5rsByGqDHnBHT
	 qj64SkVELBsBIHuVs9gyNbc/o7Q0tsCL2vJSKZdK63Q5jo/sr04XdTYrL4RCwmt1Rd
	 y/LAvHPW8vQ5NBMtzqpxU25YgsVDWCqW1xdPs5+MwyMZdCuXlKHUA70BMGcaPA2sgQ
	 hLxHcUq6B3hnE4OIhiAlzVXM7vOllglsw9+DHDIYklp0ULhB5PIrRHjODp5wMG/gDQ
	 8Do5ap6uHIEnQ==
Subject: Re: [PATCH net-next v12 04/15] ax88179_178a: Split driver into
 library and device specific code
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Thu, 17 Sep 2026 21:24:54 +0000
Message-ID: <178968029415.22033.4203681974249867316@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-4-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-4-60c04c9924a2@birger-koblitz.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 1 (5) · Low: 1

- [Medium] The module is renamed from ax88179_178a.ko to ax88179.ko
  (drivers/net/usb/Makefile: `obj-$(CONFIG_USB_NET_AX88179_178A) +=…
- [Low] New-file hygiene problems in the added files.

Pre-existing issues:
- [High] ax88179_get_eeprom() (drivers/net/usb/ax88179_lib.c) can copy
  uninitialized kernel heap bytes to userspace when the attached USB…
- [Medium] ax88179_set_features() (drivers/net/usb/ax88179_lib.c:338-364)
  ignores every command result.
- [Medium] ax88179_change_mtu() (drivers/net/usb/ax88179_lib.c:400-426)
  commits the software MTU first (`WRITE_ONCE(net->mtu, new_mtu);…
- [Medium] ax88179_set_mac_addr() (drivers/net/usb/ax88179_lib.c:425-443)
  calls eth_hw_addr_set(net, addr->sa_data) before issuing the…
- [Medium] ax88179_mdio_read() (drivers/net/usb/ax88179_lib.c:151-158)
  discards the return value of ax88179_read_cmd() and returns the output…
- [Medium] ax88179_set_eeprom() (drivers/net/usb/ax88179_lib.c:229-297)
  mixes byte-oriented userspace data with native-word register helpers,…

--

ax88179_178a: Split driver into library and device specific code

This splits the ax88179_178a driver into a shared library part
(ax88179_lib.c plus ax88179_lib.h) holding the register access helpers and
the generic net_device/ethtool callbacks, and device specific code that
stays in ax88179_178a.c.  The resulting module is renamed to ax88179.

A few questions on the move below, mostly about behaviour that comes along
with the code as it becomes shared by future controller back-ends.

> diff --git a/drivers/net/usb/Makefile b/drivers/net/usb/Makefile
> index 4964f7b326fbc..ddd76fa71e2ee 100644
> --- a/drivers/net/usb/Makefile
> +++ b/drivers/net/usb/Makefile
> @@ -12,7 +12,8 @@ obj-$(CONFIG_USB_HSO)		+= hso.o
>  obj-$(CONFIG_USB_LAN78XX)	+= lan78xx.o
>  obj-$(CONFIG_USB_NET_AX8817X)	+= asix.o
>  asix-y := asix_devices.o asix_common.o ax88172a.o
> -obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179_178a.o
> +obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179.o
> +ax88179-y := ax88179_178a.o ax88179_lib.o

[Severity: Medium]
This changes the module name from ax88179_178a to ax88179, and no
MODULE_ALIAS("ax88179_178a") is added anywhere in the ax88179 sources.

Does that break existing configuration that is keyed on the old module
name?  modprobe ax88179_178a and modinfo ax88179_178a stop resolving, and
entries such as

	blacklist ax88179_178a

in /etc/modprobe.d/*.conf, options/install lines, /etc/modules entries and
initramfs module lists silently stop applying, so a blacklist that used to
keep the in-tree driver away now lets it bind again.

The driver structure in ax88179_178a.c also still says

	static struct usb_driver ax88179_178a_driver = {
		.name =		"ax88179_178a",

so the sysfs directory name and the module name diverge.

Would ax88179_178a-y := ax88179_178a.o ax88179_lib.o, or adding
MODULE_ALIAS("ax88179_178a"), keep the old name working?

[ ... ]

> diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
> new file mode 100644
> index 0000000000000..761701ebc0692
> --- /dev/null
> +++ b/drivers/net/usb/ax88179_lib.c
> @@ -0,0 +1,444 @@

[ ... ]

> +int ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
> +		     u16 size, void *data)
> +{
> +	int ret;
> +
> +	if (size == 2) {
> +		u16 buf = 0;
> +
> +		ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
> +		le16_to_cpus(&buf);
> +		*((u16 *)data) = buf;
> +	} else if (size == 4) {
> +		u32 buf = 0;
> +
> +		ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
> +		le32_to_cpus(&buf);
> +		*((u32 *)data) = buf;
> +	} else {
> +		ret = __ax88179_read_cmd(dev, cmd, value, index, size, data);
> +	}
> +
> +	return ret;
> +}

[ ... ]

> +int ax88179_mdio_read(struct net_device *netdev, int phy_id, int loc)
> +{
> +	struct usbnet *dev = netdev_priv(netdev);
> +	u16 res;
> +
> +	ax88179_read_cmd(dev, AX_ACCESS_PHY, phy_id, (__u16)loc, 2, &res);
> +	return res;
> +}

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, since
ax88179_mdio_read() is moved verbatim, but is a failed PHY read here
indistinguishable from a genuine read of 0x0000?

The two-byte branch of ax88179_read_cmd() above stores its zero initialised
temporary into the caller's variable regardless of the transfer result:

	u16 buf = 0;

	ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
	le16_to_cpus(&buf);
	*((u16 *)data) = buf;

and ax88179_mdio_read() discards ret, so via usbnet_mii_ioctl() ->
generic_mii_ioctl() a SIOCGMIIREG copies the fabricated 0x0000 into val_out
and reports success.  The in-kernel mii_* helpers see the same value.

[ ... ]

> +int ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8 *data)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +	u16 *eeprom_buff;
> +	int first_word, last_word;
> +	int i, ret;
> +
> +	if (eeprom->len == 0)
> +		return -EINVAL;
> +
> +	eeprom->magic = AX88179_EEPROM_MAGIC;
> +
> +	first_word = eeprom->offset >> 1;
> +	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
> +	eeprom_buff = kmalloc_array(last_word - first_word + 1, sizeof(u16),
> +				    GFP_KERNEL);
> +	if (!eeprom_buff)
> +		return -ENOMEM;
> +
> +	/* ax88179/178A returns 2 bytes from eeprom on read */
> +	for (i = first_word; i <= last_word; i++) {
> +		ret = __ax88179_read_cmd(dev, AX_ACCESS_EEPROM, i, 1, 2,
> +					 &eeprom_buff[i - first_word]);
> +		if (ret < 0) {
> +			kfree(eeprom_buff);
> +			return -EIO;
> +		}
> +	}
> +
> +	memcpy(data, (u8 *)eeprom_buff + (eeprom->offset & 1), eeprom->len);
> +	kfree(eeprom_buff);
> +	return 0;
> +}

[Severity: High]
This is a pre-existing issue that this patch moves rather than introduces,
but can ax88179_get_eeprom() hand uninitialised slab bytes to userspace when
the device answers the vendor EEPROM read short?

eeprom_buff comes from kmalloc_array(), so it is uninitialised, and only
ret < 0 is treated as an error.  __usbnet_read_cmd() in usbnet.c only fills
the bytes it actually received and returns the transferred count:

	if (err > 0 && err <= size) {
		if (data)
			memcpy(data, buf, err);
	}

A device replying with 0 or 1 byte therefore returns 0 or 1 here, which
passes the ret < 0 test, leaving 2 or 1 bytes of that word untouched.  The
final memcpy() then copies the full requested range (up to AX_EEPROM_LEN)
into the ethtool buffer, and ethtool_get_any_eeprom() copies it out to
userspace.

Should this require exactly 2 transferred bytes per word, or use a zeroed
allocation?

> +int ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8 *data)
> +{
[ ... ]
> +	if (eeprom->offset & 1) {
> +		ret = ax88179_read_cmd(dev, AX_ACCESS_EEPROM, first_word, 1, 2,
> +				       &eeprom_buff[0]);
[ ... ]
> +	memcpy((u8 *)eeprom_buff + (eeprom->offset & 1), data, eeprom->len);
> +
> +	for (i = first_word; i <= last_word; i++) {
> +		netdev_dbg(net, "write to EEPROM at offset 0x%02x, data 0x%04x\n",
> +			   i, eeprom_buff[i - first_word]);
> +		ret = ax88179_write_cmd(dev, AX_ACCESS_EEPROM, i, 1, 2,
> +					&eeprom_buff[i - first_word]);

[Severity: Medium]
This is a pre-existing issue as well, only comment style changed in the
move, but is the write path byte-swapped relative to the read path on
big-endian hosts?

Byte oriented user data is memcpy()d into the u16 array and each word then
goes through ax88179_write_cmd() with size 2, which applies
cpu_to_le16s():

	if (size == 2) {
		u16 buf;

		buf = *((u16 *)data);
		cpu_to_le16s(&buf);

while ax88179_get_eeprom() reads through __ax88179_read_cmd() and returns
raw device bytes.

The boundary words look affected too: they are fetched with
ax88179_read_cmd() (which applies le16_to_cpus()) and then patched at a byte
offset, so an unaligned partial write can modify the wrong EEPROM byte on
big-endian systems.

[ ... ]

> +int ax88179_set_features(struct net_device *net, netdev_features_t features)
> +{
> +	u8 tmp;
> +	struct usbnet *dev = netdev_priv(net);
> +	netdev_features_t changed = net->features ^ features;
> +
> +	if (changed & NETIF_F_IP_CSUM) {
> +		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, &tmp);
> +		tmp ^= AX_TXCOE_TCP | AX_TXCOE_UDP;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, &tmp);
> +	}
[ ... ]
> +	return 0;
> +}

[Severity: Medium]
This isn't a bug introduced by this patch either, the function is moved
verbatim with only the static qualifier dropped, but what happens here if
the register read fails?

tmp is uninitialised, and the one byte path of ax88179_read_cmd() passes the
caller's pointer straight to __usbnet_read_cmd(), which leaves the
destination untouched on error or a zero length reply.  The code then XORs
tmp and programs it into AX_TXCOE_CTL/AX_RXCOE_CTL, so an arbitrary stack
byte ends up in the checksum control register, and the device can recover
that byte by reversing the known XOR mask.

Since 0 is returned unconditionally, __netdev_update_features() records the
requested mask as active and short-circuits an identical retry, leaving the
stack advertising offloads the hardware is not performing.  Should the
command results be checked and propagated?

[ ... ]

> +int ax88179_change_mtu(struct net_device *net, int new_mtu)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +	u16 tmp16;
> +
> +	WRITE_ONCE(net->mtu, new_mtu);
> +	dev->hard_mtu = net->mtu + net->hard_header_len;
> +
> +	if (net->mtu > 1500) {
> +		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
> +				 2, 2, &tmp16);
> +		tmp16 |= AX_MEDIUM_JUMBO_EN;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
> +				  2, 2, &tmp16);
> +	} else {
> +		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
> +				 2, 2, &tmp16);
> +		tmp16 &= ~AX_MEDIUM_JUMBO_EN;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
> +				  2, 2, &tmp16);
> +	}
> +
> +	/* max qlen depend on hard_mtu and rx_urb_size */
> +	usbnet_update_max_qlen(dev);
> +
> +	return 0;
> +}

[Severity: Medium]
This is a pre-existing issue carried over by the move, but can this leave
reception disabled on the interface?

The read-modify-write of AX_MEDIUM_STATUS_MODE is unchecked, and the
two-byte branch of ax88179_read_cmd() hands out its zero initialised
temporary on failure, so a failed read makes the driver write 0x8040 (jumbo
branch) or 0x0000 (non-jumbo branch) into the medium control register,
clearing AX_MEDIUM_RECEIVE_EN together with the gigabit, duplex, 125 MHz and
flow control enables.

The software state is already committed by WRITE_ONCE(net->mtu, new_mtu)
before that, and 0 is returned regardless, so netif_set_mtu_ext() records
success and rejects an identical retry because net->mtu already matches.

> +int ax88179_set_mac_addr(struct net_device *net, void *p)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +	struct sockaddr *addr = p;
> +	int ret;
> +
> +	if (netif_running(net))
> +		return -EBUSY;
> +	if (!is_valid_ether_addr(addr->sa_data))
> +		return -EADDRNOTAVAIL;
> +
> +	eth_hw_addr_set(net, addr->sa_data);
> +
> +	/* Set the MAC address */
> +	ret = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN,
> +				ETH_ALEN, net->dev_addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +

[Severity: Medium]
This is a pre-existing issue too, only the continuation line indentation
changed in the move, but should the old address be restored when the
AX_NODE_ID write fails?

eth_hw_addr_set() has already updated dev_addr at that point, and
netif_set_mac_address() does not roll back either.  It guards the callback
with

	if (memcmp(dev->dev_addr, ss->__data, dev->addr_len)) {
		err = ops->ndo_set_mac_address(dev, ss);

so an identical retry finds dev_addr already equal to the requested address,
skips the driver entirely and returns 0.  The chip keeps filtering on the old
node ID while the kernel believes the new address is active.

> diff --git a/drivers/net/usb/ax88179_lib.h b/drivers/net/usb/ax88179_lib.h
> new file mode 100644
> index 0000000000000..b2ee1356727cf
> --- /dev/null
> +++ b/drivers/net/usb/ax88179_lib.h
> @@ -0,0 +1,194 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include <linux/usb.h>
> +#include <linux/crc32.h>
> +#include <linux/usb/usbnet.h>
> +
> +#ifndef __LINUX_USBNET_AX88179_H
> +#define __LINUX_USBNET_AX88179_H

[Severity: Low]
This isn't a bug, but the three includes sit above the multiple inclusion
guard, so they are re-processed on every inclusion of ax88179_lib.h.  Could
they be moved below the #define?

The guard name __LINUX_USBNET_AX88179_H also does not follow the file name
ax88179_lib.h.

One more style nit: ax88179_lib.c ends with a blank line after the closing
brace of ax88179_set_mac_addr(), which checkpatch reports as a blank line at
end of file.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ax88179a-v12-0-60c04c9924a2%40birger-koblitz.de
