Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DA44EFFDB;
	Thu, 17 Sep 2026 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680305; cv=none; b=lUhEYTCktEBYehl4KuStvVxz42qrLBZ5iMi1AFPD8ThsjY3I3yvqRfP4KDMERrdi61sQyTb3dbCZfGr+m1WTh8vO7oDlLbNcKkXrPrrYpz11582EfkMTUiqJ5Y1TLNX55LqlIwi0L6Nmn3Y+HeExUWUZAgQwooLtFraOigj8v2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680305; c=relaxed/simple;
	bh=sw83+JuA7B31gawQTZyaIVRoozYq3zUxFXiGYTMYphs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LoRnIGSBWokEFCGolNMHesLxc5ouNuPR4sRnUmCl9hqN/zos1K1ivAzcoqR2/asj2RFz/NonHkayrUpTIdRJ7aabkJMWJTuvaGZeVJrYnbDmlsunKQglsw2FqA4OSwqDdEj6tDBHzUECcTLvQyq1mc3f1AlDDl9TGqbXPjk0DtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtmwbkHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtmwbkHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8271F00893;
	Thu, 17 Sep 2026 21:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680302;
	bh=v05r7qFzSHfMikyPL5YQfPdfydhT3dEGI34OjziPc60=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UtmwbkHLgnArnUhLKbhM8qRUgBHTQzFMNtzwNubHn05CS832XZwVYYpdA9v9eTDGN
	 RWw1kzwsXvB7v0A756xrC0r1unj8vASG6m2ScAp1L+/gnQASCAdcgp7z3CjaNamrS1
	 u1XnZd6UvXS/KogTCtLZWc/JDBrgWUV8ZbeZgr536GZ1k0YXq4iacduW6ZXOUemwYc
	 UHEyCfuNYL4dstx+z3krbS+ikgHMOBmKretBKO5FtIx0Dz4THp3YX4SdhZQ4UEvgmL
	 janWxqIpoTmAzlziswu98vBiVHyCnSk7j9838ke69iVs+wyKxX+5H0b6CUy/NjCYfV
	 evk/xTBQSr7lA==
Subject: Re: [PATCH net-next v12 09/15] ax88179_178a: Add VLAN offload support
 for AX88179A
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Thu, 17 Sep 2026 21:25:00 +0000
Message-ID: <178968030096.22033.824447734953057557@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-9-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-9-60c04c9924a2@birger-koblitz.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider:

Critical: 0 · High: 4 · Medium: 5 · Low: 0

- [High] ax88179a_set_features()
  (drivers/net/usb/ax88179a_devices.c:578-603) clobbers the persistent…
- [High] This patch newly installs `.ndo_set_features =
  ax88179a_set_features` on the AX88179A ops table…
- [High] net: missing endianness conversion for subsequent Rx descriptors
  in ax88179a_rx_fixup
- [High] net: unswapped read of rx_hdr yields garbage on big-endian
  architectures
- [Medium] The series is not bisectable: the VLAN feature bits are
  advertised three commits earlier than the callbacks this patch adds,…
- [Medium] The new VLAN register sequences ignore every USB register-
  access error and still report success.
- [Medium] All three new functions read AX88179A_VLAN_ID_CONTROL into an
  uninitialised local u8 and ignore the result, then transmit a value…
- [Medium] The new `data->rx_checksum` write in ax88179_set_features()
  (drivers/net/usb/ax88179_lib.c:369) races with, and is ordered wrongly…
- [Medium] Enabling NETIF_F_HW_VLAN_CTAG_FILTER makes
  ax88179a_set_features() (drivers/net/usb/ax88179a_devices.c:582-596)…

--

ax88179_178a: Add VLAN offload support for AX88179A

This adds ndo_vlan_rx_add_vid/ndo_vlan_rx_kill_vid and an AX88179A specific
ndo_set_features to program the hardware VLAN filter table and the VLAN
control register, and starts tracking the RX checksum state in
ax88179_set_features(). A few questions below about the register
programming and about how the series is split.

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
>  
>  	return 0;

[Severity: High]
One more question about the RX path that this rx_checksum tracking
feeds into.  ax88179a_rx_fixup() picks up the 8-byte hardware footer
with a plain native load:

	rx_hdr = *(u64 *)skb_tail_pointer(skb);

The device writes that footer little-endian, like the per-packet
descriptors that follow it, but here there is no le64 conversion at
all.  On big-endian hosts, do hdr_off and pkt_cnt extracted from
rx_hdr come out as nonsense, so the bounds check against skb->len
fails and the whole URB worth of packets is dropped (or, worse, a
plausible-looking hdr_off points the descriptor pointer somewhere
inside the payload)?

There is a second concern with the cast: skb_tail_pointer(skb) is not
guaranteed to be 8-byte aligned, and dereferencing it as u64 * traps
on architectures that do not tolerate unaligned accesses.
get_unaligned_le64(skb_tail_pointer(skb)) would address both the
alignment and the byte order in one step.

Is the driver intended to be little-endian only, or should this and
the descriptor reads use the explicit le64 accessors?  If the former,
that restriction is not stated anywhere and the driver still builds on
big-endian configurations.

[Severity: High]
While checking who consumes the new data->rx_checksum flag I ended
up in ax88179a_rx_fixup(), and the descriptor decoding there looks
endianness-broken for all but the first packet of a batch.

le64_to_cpus(pkt_desc_ptr) is called once, before the loop, so it
byte-swaps only the descriptor at the head of the array.  Inside the
loop pkt_desc_ptr is then incremented and each following descriptor is
read natively:

	le64_to_cpus(pkt_desc_ptr);

	pkt_end = 0;
	while (pkt_cnt--) {
		u64 pkt_desc = *pkt_desc_ptr;

On a big-endian host, is every packet after the first parsed from a
byte-reversed descriptor?  If so the extracted length and status
fields are garbage, the pkt_end/pkt_len arithmetic derived from them
is meaningless, and the subsequent skb_pull()/skb_trim() on the batch
SKB can be asked to move past skb->len.  The same descriptor also
gates ax88179a_rx_checksum(ax_skb, pkt_desc), so the CHECKSUM_*
decision this patch now makes conditional on data->rx_checksum would
be taken from bits that never came from the hardware.

Would converting per iteration, e.g. u64 pkt_desc =
get_unaligned_le64(pkt_desc_ptr) (or le64_to_cpu(*pkt_desc_ptr))
inside the loop and dropping the single pre-loop swap, be the intended
fix?  Or is the array meant to be swapped in one go somewhere I am not
seeing?

[Severity: Medium]
Is the update order here correct for the disable case?  AX_RXCOE_CTL is
programmed first and data->rx_checksum is cleared afterwards.

The reader lives in the usbnet BH work item:

drivers/net/usb/ax88179a_devices.c:ax88179a_rx_fixup() {
	...
	if (ax179_data->rx_checksum)
		ax88179a_rx_checksum(ax_skb, pkt_desc);
	...
}

Writers run in process context under RTNL (ndo_set_features, and
ax88179a_reset() via usbnet_open), the reader runs from bh_work, and
neither side uses READ_ONCE()/WRITE_ONCE().  In the window between the
AX_RXCOE_CTL write and the flag update, can descriptors produced with the
checksum engine already off still be consumed with rx_checksum == 1 and
end up marked CHECKSUM_UNNECESSARY?

Would clearing the flag before disabling the engine, and setting it after
enabling it, be the safer order?

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 6bf1ac17aa1d5..481139f71ac26 100644
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
Can reg8 be used uninitialised here?  For a 1-byte access
ax88179_read_cmd() passes the caller's buffer straight through:

drivers/net/usb/ax88179_lib.c:ax88179_read_cmd() {
	...
	} else {
		ret = __ax88179_read_cmd(dev, cmd, value, index, size, data);
	}
	...
}

and the destination is only written on a successful, non-short transfer:

drivers/net/usb/usbnet.c:__usbnet_read_cmd() {
	...
	if (err > 0 && err <= size) {
		if (data)
			memcpy(data, buf, err);
	...
}

On -EPIPE/-ETIMEDOUT/-ENODEV or a short reply, reg8 keeps whatever was on
the stack, and that value is then copied to vlan_ctrl and written back into
AX88179A_VLAN_ID_CONTROL together with RD and WE.  Does this both disclose
a byte of stack to the device and allow arbitrary VFE/VSO bits to be
programmed?  The same pattern appears in ax88179a_vlan_rx_add_vid() and in
ax88179a_set_features() with u8 tmp.

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
Should the return values of these register accesses be propagated instead
of returning 0 unconditionally?

For the 2-byte row read, a failure still stores 0 into the caller's
variable:

drivers/net/usb/ax88179_lib.c:ax88179_read_cmd() {
	if (size == 2) {
		u16 buf = 0;

		ret = __ax88179_read_cmd(dev, cmd, value, index, size, &buf);
		le16_to_cpus(&buf);
		*((u16 *)data) = buf;
	}
	...
}

so if the read of AX88179A_VLAN_ID_DATA0 fails, reg16 becomes 0 and the
following write-back clears the other 15 VIDs sharing that row.  A failed
address write can also apply the modification to whichever row was
previously selected.

Since __vlan_vid_add() records the VID when the callback returns 0:

net/8021q/vlan_core.c:__vlan_vid_add() {
	...
	err = ops->ndo_vlan_rx_add_vid(dev, proto, vid);
	if (err)
		return err;
	...
}

can the software VLAN list end up claiming VIDs that were never programmed,
or VIDs that were silently erased?  ax88179a_bind() already checks the
return values of these same helpers.

> +
> +static int ax88179a_vlan_rx_add_vid(struct net_device *net, __be16 proto, u16 vid)
> +{

[ ... same read-modify-write sequence as kill_vid, same questions apply ... ]

> +	return 0;
> +}
> +
>  static void ax88179a_mdio_unregister(struct ax88179_data *data)
>  {
>  	mdiobus_unregister(data->mdio);
> @@ -506,6 +562,49 @@ static int ax88179a_mii_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
>  	return phylink_mii_ioctl(data->phylink, rq, cmd);
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
> +			}
> +		}
> +	}

[Severity: High]
Does "tmp = AX_VLAN_CONTROL_WE" wipe the VFE and VSO bits that live in the
same register?  All four bits share AX88179A_VLAN_ID_CONTROL:

drivers/net/usb/ax88179_lib.h:
	#define AX88179A_VLAN_ID_CONTROL 0x2B
		#define AX_VLAN_CONTROL_WE	0x0001
		#define AX_VLAN_CONTROL_RD	0x0002
		#define AX_VLAN_CONTROL_VSO	0x0010
		#define AX_VLAN_CONTROL_VFE	0x0020

The loop writes a bare 0x01, so it clears the VFE bit that was just set a
few lines above, and also clears VSO even though NETIF_F_HW_VLAN_CTAG_RX
did not change.  The other new call sites keep the current contents:

	reg8 = vlan_ctrl | AX_VLAN_CONTROL_WE;
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);

and ax88179a_reset() programs those bits from net->features, which suggests
they are meant to persist:

	if (dev->net->features & NETIF_F_HW_VLAN_CTAG_FILTER)
		*tmp |= AX_VLAN_CONTROL_VFE;
	if (dev->net->features & NETIF_F_HW_VLAN_CTAG_RX)
		*tmp |= AX_VLAN_CONTROL_VSO;

Because VFE/VSO are then updated with read/XOR/write, does the hardware end
up inverted with respect to net->features?  After "ethtool -K ethX
rx-vlan-filter on" the filter is left off in hardware, and the following
"rx-vlan-filter off" XORs VFE back on with an empty table, dropping all
VLAN tagged RX while the stack believes filtering is disabled.

For reference, aqc111_set_features() re-reads the control register after
the clearing loop and re-asserts the bit:

drivers/net/usb/aqc111.c:aqc111_set_features() {
	...
	aqc111_read_cmd(dev, AQ_ACCESS_MAC, SFR_VLAN_ID_CONTROL, 1, 1, &reg8);
	reg8 |= SFR_VLAN_CONTROL_VFE;
	...
}

Was that step meant to be carried over here?

[Severity: Medium]
Is it acceptable to hold RTNL across this loop?  ndo_set_features is called
from __netdev_update_features() with RTNL held, and each iteration issues
three synchronous control transfers via ax88179_write_cmd() ->
usbnet_write_cmd() -> usb_control_msg(), i.e. 768 blocking bus
transactions with USB_CTRL_SET_TIMEOUT each.

On a busy bus, or when a transfer stalls and hits the timeout, this blocks
all other network configuration in the system for a long time.  Could the
clear be limited to rows actually in use, batched, or moved out of the RTNL
section?

> +
> +	if (changed & NETIF_F_HW_VLAN_CTAG_RX) {
> +		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &tmp);
> +		tmp ^= AX_VLAN_CONTROL_VSO;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &tmp);
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct net_device_ops ax88179a_netdev_ops = {
>  	.ndo_open		= usbnet_open,
>  	.ndo_stop		= usbnet_stop,
> @@ -516,6 +615,9 @@ static int ax88179a_mii_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
>  	.ndo_set_mac_address	= ax88179_set_mac_addr,
>  	.ndo_validate_addr	= eth_validate_addr,
>  	.ndo_eth_ioctl		= ax88179a_mii_ioctl,
> +	.ndo_set_features	= ax88179a_set_features,
> +	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
> +	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,
>  };

[Severity: High]
Wiring up .ndo_set_features here also makes the shared checksum/TSO
programming in ax88179_set_features() reachable on this chip family for the
first time.  Is that consistent with ax88179a_reset()?

usbnet_open() runs the reset on every ifup:

drivers/net/usb/usbnet.c:usbnet_open() {
	...
	if (info->reset) {
		retval = info->reset(dev);
	...
}

and ax88179a_reset() programs the engines absolutely, ignoring
net->features:

	*tmp = AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
	       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, tmp);
	ax179_data->rx_checksum = 1;

while ax88179_set_features() programs them relatively with read/XOR/write.
So after "ethtool -K ethX tx off; ip link set ethX down; ip link set ethX
up", hardware offload is on while the feature bits say off, and the next
"ethtool -K ethX tx on" XORs the engine off while the stack thinks offload
is active.

ax88179a_tx_fixup() sets no per-packet checksum request bit, so with
AX_TXCOE_CTL cleared and NETIF_F_IP_CSUM advertised, can packets go out
with uncomputed TCP/UDP checksums?  On the RX side, rx_checksum forced back
to 1 with the RXCOE engine off would make ax88179a_rx_checksum() mark
packets CHECKSUM_UNNECESSARY from descriptor bits the hardware no longer
produces.

Would absolute programming from features (and/or having reset honour
net->features) be the right fix?

Also, neither the new .ndo_set_features hook for checksum/TSO nor the new
data->rx_checksum tracking is mentioned in a changelog titled "Add VLAN
offload support for AX88179A".

[Severity: Medium]
Is the series bisectable with respect to these two callbacks?  The commit
"ax88179_178a: Add HW support for AX179A-based chips" already advertises
the filter bit in ax88179a_bind():

	dev->net->features |= NETIF_F_SG | NETIF_F_IP_CSUM |
			      NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO |
			      NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
			      NETIF_F_HW_VLAN_CTAG_FILTER;

	dev->net->hw_features |= dev->net->features;

but ndo_vlan_rx_add_vid/ndo_vlan_rx_kill_vid only appear in this patch, and
register_netdevice() rejects that combination:

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

usbnet_probe() calls info->bind() before register_netdev(), so on the
commits between the feature advertisement and this patch, does probe fail
with -EINVAL and a warning for the whole AX179A family?  Could the feature
advertisement be moved into this patch (or the callbacks moved earlier) so
every commit in the series probes?

The changelog also lists NETIF_F_HW_VLAN_CTAG_TX, although nothing in this
diff touches TX tagging; that already exists in ax88179a_tx_fixup() from
the earlier commit.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ax88179a-v12-0-60c04c9924a2%40birger-koblitz.de
