Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1523EEAEA;
	Wed, 16 Sep 2026 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541258; cv=none; b=hbqMmxv8GMeQA9cNEHPo7XYwi4UrtIgG5gVnYB6xybTyVoPW5WoQBKHhajPxAunjAuqFTxvLMOdnRyZqzdl8o7TRYOwL2JBG3VQZSTGhzMud/JVqanuV5jUkJWgHBFFD+LMNyx0kIsduw6/GYMWIWEmgO5t7OvLXqijDz31k5xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541258; c=relaxed/simple;
	bh=RzPosFiEQuEcJl8udalQ3CetxHGZ5325UcevpQfnpPU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rjZAoJpaZlDur+3fuSrbTLu3gUCewUJFtjckPGpcnbeJP8tPd/+sgnOt8BoVVG4H9gZUpn8WpbUdc8VGvRiaJOUVTbc8vUETu2LG722tN7dCwHW21izPCogS+N8xWq9ysz9NVwO+5oRPHhOHOPK8D+z3b2KsrN6K31VQXO5qD5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlgDbovh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlgDbovh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46131F00893;
	Wed, 16 Sep 2026 06:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541253;
	bh=8VzBZ6Ju2KDqgyKeOAvFrUEzcRMpi4KwfvR1WZZ5kis=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AlgDbovhz/UuvXiSeLRjbYItyJLZbVNKu5IP2Z0c5su8Lff0lSKBq+SWs5CxLEduA
	 hrsgvAG0HpNp+k12JhjfSIq/qnEjyZtN8w/Yyh+9yypAizuUAMrwfof7DxI+SrAjcO
	 62HON/6h08vPaq8v9M1KEWT6dtuN8M2hQRVZpS4lyCYlG+giPqyfpYgeSAdgtr9LED
	 piJGCgWSqRHdymITnjcCdUoRSlPefuLx2IqYCLssb0ELbYSeB5ieEcaj7d2hhmlmFj
	 gEX5P9Jks9j7qBEPrNvrX/ibkvO3xtb7Z9e224Amo2pqmNcDBvCMCXZSfVi35iPT+7
	 SIIlkTMq+6cpQ==
Subject: Re: [PATCH net-next v11 09/15] ax88179_178a: Add VLAN offload support
 for AX88179A
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Wed, 16 Sep 2026 06:47:32 +0000
Message-ID: <178954125245.22033.3070868664144328965@kernel.org>
In-Reply-To: <20260914-ax88179a-v11-9-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-9-5ea7a925ba6d@birger-koblitz.de>
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

Critical: 0 · High: 1 · Medium: 7 · Low: 0

- [High] ax88179a_set_features() destroys the VLAN control register it
  just programmed: the 256-iteration filter-table clearing loop writes…
- [Medium] Series ordering / bisect breakage that the commit message does
  not disclose: ax88179a_bind() already sets dev->net->features |=…
- [Medium] Undisclosed, unrelated behaviour change in shared library
  code: the hunk in drivers/net/usb/ax88179_lib.c adds…
- [Medium] The newly added `data->rx_checksum = !!(features &
  NETIF_F_RXCSUM)` tracking in ax88179_set_features() is contradicted by…
- [Medium] The new VLAN ndo callbacks and the VLAN part of
  ax88179a_set_features() discard the return value of every…
- [Medium] ax88179a_set_features() programs the VLAN mode bits by XOR-
  toggling the value read from AX88179A_VLAN_ID_CONTROL (`tmp ^=…
- [Medium] The new VLAN helpers and ax88179a_set_features() perform
  1-byte register reads into uninitialized stack variables (`u8 reg8;`…
- [Medium] ax88179_set_features() publishes the new RX-checksum state
  with a plain store to data->rx_checksum from process context (RTNL…

--

ax88179_178a: Add VLAN offload support for AX88179A

This adds ndo_set_features, ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid
for the AX88179A family so that CTAG TX/RX offload and the hardware VLAN
filter table can be configured.  It also adds a line to the shared
ax88179_set_features() that tracks the NETIF_F_RXCSUM state.

No Link: tags were present in the commit header.

A few questions about the new code below.

> diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
> index ea36aef3d3e45..3324069e90fc3 100644
> --- a/drivers/net/usb/ax88179_lib.c
> +++ b/drivers/net/usb/ax88179_lib.c
> @@ -346,6 +346,7 @@ int ax88179_set_features(struct net_device *net, netdev_features_t features)
>  {
>  	u8 tmp;
>  	struct usbnet *dev = netdev_priv(net);
> +	struct ax88179_data *data = dev->driver_priv;
>  	netdev_features_t changed = net->features ^ features;
>  
>  	if (changed & NETIF_F_IP_CSUM) {
> @@ -365,6 +366,7 @@ int ax88179_set_features(struct net_device *net, netdev_features_t features)
>  		tmp ^= AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
>  		       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
>  		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, &tmp);
> +		data->rx_checksum = !!(features & NETIF_F_RXCSUM);
>  	}

[Severity: Medium]
This hunk changes RX checksum behaviour in the shared library used by both
ax88179_178a.c and ax88179a_devices.c, while the commit message only
mentions VLAN offload:

    Features supported are:
    NETIF_F_HW_VLAN_CTAG_TX, NETIF_F_HW_VLAN_CTAG_RX
    and NETIF_F_HW_VLAN_CTAG_FILTER.

Previously ax88179_data.rx_checksum was only ever set to 1 in
ax88179a_reset() and never cleared, so ax88179a_rx_fixup() kept calling
ax88179a_rx_checksum() after the user disabled NETIF_F_RXCSUM.  Could this
change be described in the commit message, or split into its own patch?

[Severity: Medium]
Does ax88179a_reset() undo this tracking?  It programs the same register
absolutely and forces the flag back on without consulting net->features:

drivers/net/usb/ax88179a_devices.c:ax88179a_reset() {
	...
	/* Enable checksum offload */
	*tmp = AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
	       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, tmp);
	ax179_data->rx_checksum = 1;
	...
}

After ethtool -K ethX rx off followed by ip link set ethX down; ip link set
ethX up, is hardware RX checksum offload re-enabled and rx_checksum forced
to 1 while net->features still has NETIF_F_RXCSUM cleared?

There is a second consequence of mixing an absolute write in reset() with
the XOR toggle here: a later ethtool -K ethX rx on reads the already-enabled
AX_RXCOE_* bits, XORs them to zero and disables the checksum engine, yet
sets rx_checksum = 1.  Would ax88179a_rx_fixup() then interpret descriptor
checksum fields produced by a disabled engine?

This is still the case at the end of the series.

[Severity: Medium]
Is the store to data->rx_checksum here synchronized against the reader?
The writer runs in process context under RTNL, while the reader runs from
usbnet's bh work:

drivers/net/usb/ax88179a_devices.c:ax88179a_rx_fixup() {
	...
	if (ax179_data->rx_checksum)
		ax88179a_rx_checksum(ax_skb, pkt_desc);
	...
}

There is no lock, READ_ONCE()/WRITE_ONCE() or barrier on either side.

The ordering also looks inverted for the disable direction: AX_RXCOE_CTL is
reprogrammed first and the flag is cleared afterwards, so frames handled in
that window can still be marked CHECKSUM_UNNECESSARY from descriptor bits
the MAC no longer produces.  Would clearing the flag before disabling the
hardware, and setting it after enabling it, be more correct?

>  
>  	return 0;
> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 97aad545daee1..4bca801236b08 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -239,6 +239,62 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {
>  	.get_ts_info		= ethtool_op_get_ts_info,
>  };
>  
> +static int ax88179a_vlan_rx_kill_vid(struct net_device *net, __be16 proto, u16 vid)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +	u8 vlan_ctrl;
> +	u16 reg16;
> +	u8 reg8;
> +
> +	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
> +	vlan_ctrl = reg8;

[Severity: Medium]
Can vlan_ctrl end up holding uninitialized stack data here?  reg8 is
declared without an initializer and the read return value is not checked.
For size == 1, ax88179_read_cmd() passes the caller buffer straight through
without zeroing it:

drivers/net/usb/ax88179_lib.c:ax88179_read_cmd() {
	...
	} else {
		ret = __ax88179_read_cmd(dev, cmd, value, index, size, data);
	}
	...
}

and nothing is copied on a failed transfer:

drivers/net/usb/usbnet.c:__usbnet_read_cmd() {
	...
	if (err > 0 && err <= size) {
		if (data)
			memcpy(data, buf, err);
	...
}

So on an -ENODEV/-ETIMEDOUT/stalled control transfer, is one byte of kernel
stack written back into AX88179A_VLAN_ID_CONTROL, where the device
interprets it as VFE/VSO/RD/WE?  The same pattern is in
ax88179a_vlan_rx_add_vid() and in ax88179a_set_features() (u8 tmp; read,
then tmp ^= AX_VLAN_CONTROL_VSO).  aqc111 initializes its equivalent locals
(u8 reg8 = 0).

> +
> +	/* Address */
> +	reg8 = (vid / 16);
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_ADDRESS, 1, 1, &reg8);
> +
> +	/* Data */
> +	reg8 = vlan_ctrl | AX_VLAN_CONTROL_RD;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
> +
> +	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);
> +	reg16 &= ~(1 << (vid % 16));
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);
> +
> +	reg8 = vlan_ctrl | AX_VLAN_CONTROL_WE;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
> +
> +	return 0;
> +}

[Severity: Medium]
Should these callbacks propagate the register access errors instead of
always returning 0?  The 8021q core and __netdev_update_features() use the
return code to decide whether to record the new state.

For the 2-byte case ax88179_read_cmd() zeroes a temporary and copies it out
even when the transfer failed:

drivers/net/usb/ax88179_lib.c:ax88179_read_cmd() {
	...
	if (size == 2) {
		u16 buf = 0;

		ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
		le16_to_cpus(&buf);
		*((u16 *)data) = buf;
	}
	...
}

So if the AX88179A_VLAN_ID_DATA0 read fails, reg16 becomes 0 and the
write-back clears the other 15 VIDs sharing that table word, while
ax88179a_vlan_rx_kill_vid() still reports success.  ax88179a_vlan_rx_add_vid()
has the same issue with only the new bit surviving.  A failed address or WE
write leaves the entry unprogrammed and also goes unreported.

ax88179a_set_features() does check ax88179_set_features(), but ignores all
of its own accesses, including the 256 loop iterations.

> +
> +static int ax88179a_vlan_rx_add_vid(struct net_device *net, __be16 proto, u16 vid)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +	u8 vlan_ctrl;
> +	u16 reg16;
> +	u8 reg8;
> +
> +	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
> +	vlan_ctrl = reg8;
> +

[ ... ]

> +	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);
> +	reg16 |= (1 << (vid % 16));
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);
> +
> +	reg8 = vlan_ctrl | AX_VLAN_CONTROL_WE;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -499,6 +555,49 @@ static int ax88179a_init_mdio(struct usbnet *dev)
>  	return ret;
>  }
>  
> +static int ax88179a_set_features(struct net_device *net, netdev_features_t features)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +	netdev_features_t changed;
> +	int ret;
> +	u8 tmp;
> +
> +	changed = net->features ^ features;
> +
> +	ret = ax88179_set_features(net, features);
> +	if (ret)
> +		return ret;
> +
> +	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER) {
> +		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &tmp);
> +		tmp ^= AX_VLAN_CONTROL_VFE;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &tmp);
> +		if (features & NETIF_F_HW_VLAN_CTAG_FILTER) {
> +			for (int i = 0; i < 256; i++) {
> +				u16 tmp16 = 0;
> +				/* Address */
> +				tmp = i;
> +				ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_ADDRESS,
> +						  1, 1, &tmp);
> +				/* Data */
> +				ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0,
> +						  2, 2, &tmp16);
> +				tmp = AX_VLAN_CONTROL_WE;
> +				ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL,
> +						  1, 1, &tmp);
                                  ^^^^

[Severity: High]
Does this bare WE strobe wipe the enable bits in the same register?
AX88179A_VLAN_ID_CONTROL is one byte holding all four bits:

drivers/net/usb/ax88179_lib.h:
	#define AX88179A_VLAN_ID_CONTROL		0x2B
		#define AX_VLAN_CONTROL_WE	0x0001
		#define AX_VLAN_CONTROL_RD	0x0002
		#define AX_VLAN_CONTROL_VSO	0x0010
		#define AX_VLAN_CONTROL_VFE	0x0020

ax88179_write_cmd(dev, ..., 1, 1, &tmp) writes the whole byte, so after
ethtool -K ethX rx-vlan-filter on, does the register end up as 0x01 with
VFE cleared (filter not enabled in hardware) and VSO cleared (RX tag
stripping silently turned off), while dev->features reports both enabled?

Every other site programs this register read-modify-write, including the two
callbacks added by this patch:

	reg8 = vlan_ctrl | AX_VLAN_CONTROL_WE;
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);

and ax88179a_reset() composes VFE/VSO from net->features.  Should the loop
use vlan_ctrl | AX_VLAN_CONTROL_WE as well?

Note also that the core re-pushes the VIDs after the feature change, and
ax88179a_vlan_rx_add_vid() then ORs WE onto the now-zeroed control value,
so nothing appears to restore VFE/VSO.  The same code is unchanged at the
end of the series.

> +			}
> +		}
> +	}
> +
> +	if (changed & NETIF_F_HW_VLAN_CTAG_RX) {
> +		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &tmp);
> +		tmp ^= AX_VLAN_CONTROL_VSO;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &tmp);
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Both VLAN mode bits are programmed by XOR-toggling the value read back from
the device rather than being set or cleared from the requested features.
The changed mask only says the requested software bit differs from the
previous software bit, not that the hardware bit still mirrors the old
software state.

Two cases where the register does not mirror net->features:

- right after the clear loop above leaves the control register as 0x01,
  so a following rx-vlan-filter off reads VFE=0 and XORs it to 1, arming
  the hardware filter while userspace is told filtering is off

- before the first ax88179a_reset(), since feature changes are accepted
  while the interface is down

In those cases the XOR inverts the request and the function still returns
success.  Would assigning the bits from features be safer here?

>  
>  static const struct net_device_ops ax88179a_netdev_ops = {
>  	.ndo_open		= usbnet_open,
>  	.ndo_stop		= usbnet_stop,
> @@ -509,6 +608,9 @@ static const struct net_device_ops ax88179a_netdev_ops = {
>  	.ndo_set_mac_address	= ax88179_set_mac_addr,
>  	.ndo_validate_addr	= eth_validate_addr,
>  	.ndo_eth_ioctl		= usbnet_mii_ioctl,
> +	.ndo_set_features	= ax88179a_set_features,
> +	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
> +	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,
>  };

[Severity: Medium]
Is the series bisectable across this point?  The earlier commit
"ax88179_178a: Add HW support for AX179A-based chips" already advertises the
filter capability in ax88179a_bind():

	dev->net->features |= NETIF_F_SG | NETIF_F_IP_CSUM |
			      NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO |
			      NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
			      NETIF_F_HW_VLAN_CTAG_FILTER;

	dev->net->hw_features |= dev->net->features;

but the two ndo callbacks only arrive here, and the core rejects that
combination:

net/core/dev.c:register_netdevice() {
	...
	if (((dev->hw_features | dev->features) &
	     NETIF_F_HW_VLAN_CTAG_FILTER) &&
	    (!dev->netdev_ops->ndo_vlan_rx_add_vid ||
	     !dev->netdev_ops->ndo_vlan_rx_kill_vid)) {
		netdev_WARN(dev, "Buggy VLAN acceleration in driver!\n");
		ret = -EINVAL;
		goto err_uninit;
	}
	...
}

At the parent commit, grepping ax88179a_devices.c for ndo_vlan_rx returns no
match, so does usbnet_probe() -> register_netdev() fail for every AX88179A,
AX88772D and AX88279 device at the intermediate commits?  Could the feature
bits be added in this patch instead, or the ordering noted in the commit
message?

>  
>  static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ax88179a-v11-0-5ea7a925ba6d%40birger-koblitz.de
