Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274719;
	b=n8Ys/UXHK5xZBBX7emeqlPV/NDWOQeThN8ugUfYJCCHqW0ITvl5XoARRzyAGf4SxsFAS
	 nYbEun9bRm3kGQXJqh18j8mai17A6bQVT1yL8PcIY71KZJNkwyUI3KeiKbfQ5F4BhJw41
	 1dcoEauW2l5x31me3PNw4tLMEI3a1vG+IMRnwkljI8JW+IJxr96KVy2KIUomSleYhvXR0
	 V/9Dy3uj+hGOw5haFe0g4f4KAEPzV6m6ur62+H2I/KH+7lsvqm8vK7B9TWvwi7nBwopRG
	 hghXh82z3kJ398Nx3Uimr3bkSuY0l0jKkr1s8MGS/5Z6G8Ndj/5YfcVhFxeOS++vW1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274719;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fkEE9d9MsSVbLsZ0o5u4ofj8b41Zhq4TGWUC/Rs9SMM=;
	b=2pZfBasEyMTRnKppkqlNx7UFjTT6wL77ox7b/HRe/ztBsRDRPOfdZbMoasX54aqzJQ0i
	 msPmhVNLviGkdyHroNiPf42TIlBMvrMG294MSuHed0rAYA00MeFBV8ITCdlYSSbanMSpg
	 +5emlQgvs8ka/jX3ls2A2SvhfJfNkHzq8PpA2deTX2peg61l8Wb4jQsndQyynn4tSCqKY
	 fVEvmRIJFr1Y6G1r8CbciLOmYtZprq+ib4DA99zspC2GuJwhMj5G8Ov7eroTetOUM7GWU
	 ZSEqlncNlcFSDNs2ntY48mt6TSbkivn4vOD0HO2uAHaAVhV9OW4ysAxzAGuzYVpnmGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mS9YQLpS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9AB60A6F71;
	Tue, 10 Nov 2026 01:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mS9YQLpS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B091F008A7;
	Tue, 10 Nov 2026 01:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274718;
	bh=fkEE9d9MsSVbLsZ0o5u4ofj8b41Zhq4TGWUC/Rs9SMM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mS9YQLpSzMzyWIX9IoQLtKBbJ0yNb4UWk11IbvFgMRP8mSnSqDN5JW4X55zR3cKHX
	 lDLbt3AJ/QnMoP/EHhkr5qZlmvTgnq/p3cdURulkjHdAJyLhW4k+j0oEhR01FbgQWG
	 IkOnE22pa4nKdA3Gux3vZe/zlNXKiS9KCH9+EMAWTx9lsiPDEVlO3Agq0cTjCxWe9h
	 75qXtXUVqQJ/vKaZsQ7eZsnLwKqLmJoN33J0x/BMhNhmjwRq1AmVwX92hanH5u0Mb5
	 laimHkjHvAxM/UKLH9Rg+k0SgVXFpNcte4SknLnhSIMCqq22G+5Ekptxke4TPzhikJ
	 RY/jnQJ04weeg==
Subject: Re: [PATCH net-next v20 07/13] ax88179_178a: Add VLAN offload support
 for AX88179A
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name,
 edumazet@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 neuromoments@gmail.com, beganovic.emir@gmail.com
Date: Tue, 10 Nov 2026 01:38:36 +0000
Message-ID: <179427471692.994134.3914237997430196941@kernel.org>
In-Reply-To: <20261106-ax88179a-v20-7-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-7-37b5a1189983@birger-koblitz.de>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 5 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ax88179a_set_features() calls ax88179_set_features() first.
- [Medium] The patch makes NETIF_F_HW_VLAN_CTAG_RX user-toggleable and
  off by default: it is added to hw_features only…
- [Medium] ax88179a_reset() rebuilds AX88179A_VLAN_ID_CONTROL from
  dev->features: VFE if CTAG_FILTER is set, VSO if CTAG_RX is set…
- [Medium] When CTAG_FILTER is enabled, ax88179a_set_features() clears
  the VLAN table with 256 iterations of…
- [Medium] The new VLAN code treats any non-negative return from
  ax88179_read_cmd() as success.
- [Low] The last line of the commit message, "Error-checking fixes
  Suggested-by: Jianhui Xu <neuromoments@gmail.com>", is not a valid…
- [Low] The patch turns on NETIF_F_HW_VLAN_CTAG_TX by default and makes
  it toggleable (`hw_features |= features`, ax88179a_devices.c:768-772).

--

ax88179_178a: Add VLAN offload support for AX88179A

This adds VLAN offload support for the AX88179A-based chips by wiring up
ndo_set_features, ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid. It enables
NETIF_F_HW_VLAN_CTAG_TX by default. It also exposes NETIF_F_HW_VLAN_CTAG_RX
and NETIF_F_HW_VLAN_CTAG_FILTER as toggleable hw_features.

> Error-checking fixes Suggested-by: Jianhui Xu <neuromoments@gmail.com>

[Severity: Low]
This isn't a bug, but is this meant to be a Suggested-by: trailer? With
"Error-checking fixes" in front of it, git interpret-trailers, b4 and
checkpatch won't parse it as a tag. A per-version change note would
normally go below the '---' line.

The note also claims more error checking than the code has. The
256-iteration table clear loop in ax88179a_set_features() doesn't check
any of its ax88179_write_cmd(), ax88179_write_u16() or ax88179_write_u8()
return values (see the comment on that loop below).

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 272e923656832..4207d2cc2b865 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -258,6 +258,88 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {

[ ... ]

> +static int ax88179a_vlan_rx_add_vid(struct net_device *net, __be16 proto, u16 vid)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +	u8 vlan_ctrl;
> +	int ret = 0;
> +	u16 reg16;
> +	u8 reg8;
> +
> +	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
> +	if (ret < 0)
> +		return ret;
> +	vlan_ctrl = reg8;

[Severity: Medium]
Can vlan_ctrl end up holding uninitialized stack data here?

__usbnet_read_cmd() only copies into the caller's buffer when the
transfer returned a positive length:

drivers/net/usb/usbnet.c:__usbnet_read_cmd() {
    ...
	if (err > 0 && err <= size) {
		if (data)
			memcpy(data, buf, err);
    ...
}

For size == 1, ax88179_read_cmd() passes &reg8 straight through. A
zero-length reply from the device returns 0. That passes the ret < 0
check while reg8 is still uninitialized.

The value is then ORed with AX_VLAN_CONTROL_RD and AX_VLAN_CONTROL_WE and
written back to AX88179A_VLAN_ID_CONTROL twice. That sends a stack byte
to the device and programs arbitrary VFE/VSO bits.

This also doesn't match the rest of the patch.
ax88179a_vlan_rx_kill_vid() zero-initializes reg8 and reg16, and
ax88179a_reset() checks its reads with > 0.

The same pattern applies to u8 tmp in ax88179a_set_features(). It is
uninitialized on the VFE-disable branch and on the CTAG_RX branch. If the
filter-enable loop ran first, tmp is left at 255, so a short read would
write 0xff | AX_VLAN_CONTROL_VSO.

Both add_vid and kill_vid read AX88179A_VLAN_ID_DATA0 with a 2-byte read.
A short reply there leaves reg16 at 0, because ax88179_read_cmd() uses a
zeroed bounce buffer. Wouldn't the write-back then clear the other 15
VIDs in that 16-VID group?

Should these checks treat anything shorter than a full-length read as an
error?

[ ... ]

> +	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);
> +	if (ret < 0)
> +		return ret;
> +	reg16 |= (1 << (vid % 16));
> +	ret = ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);

[Severity: Medium]
The VID bitmap only lives in device SRAM here, and the driver keeps no
software copy. What restores it after the device loses power?

ax88179a_reset() rebuilds AX88179A_VLAN_ID_CONTROL from dev->features
but doesn't touch the table:

drivers/net/usb/ax88179a_devices.c:ax88179a_reset() {
    ...
	*tmp = 0;
	if (dev->net->features & NETIF_F_HW_VLAN_CTAG_FILTER)
		*tmp |= AX_VLAN_CONTROL_VFE;
	if (dev->net->features & NETIF_F_HW_VLAN_CTAG_RX)
		*tmp |= AX_VLAN_CONTROL_VSO;
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, tmp);
    ...
}

Later in this series, "ax88179_178a: Add Suspend/resume support for
AX88179A/772D/279" wires .resume and .reset_resume to ax88179a_resume().
That function power-cycles the PHY and calls ax88179a_reset(). The vlan
core doesn't push existing VIDs to the driver again on open or resume.

After a power-losing suspend or a reset_resume with rx-vlan-filter on,
VFE would be set again on top of the power-on table contents.
ax88179a_set_features() clears all 256 entries before enabling VFE, which
suggests those power-on contents can't be trusted.

Wouldn't traffic for the configured VLANs then be dropped until
rx-vlan-filter is toggled?

> @@ -517,6 +599,75 @@ static int ax88179a_mii_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
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

[Severity: Medium]
What happens to the checksum offload state if one of the VLAN register
accesses below fails?

By the time we get here, ax88179_set_features() has already XOR-toggled
AX_TXCOE_CTL and AX_RXCOE_CTL in hardware and updated
data->rx_checksum. It also always returns 0:

drivers/net/usb/ax88179_lib.c:ax88179_set_features() {
    ...
	tmp ^= AX_TXCOE_TCP | AX_TXCOE_UDP;
    ...
}

If the VLAN FILTER or CTAG_RX sequence then returns a negative error,
__netdev_update_features() returns early. dev->features keeps its old
value, and nothing rolls back the hardware.

Take ethtool -K ethX tx on rxvlan on as an example. TXCOE gets toggled
on, then the VSO read fails, so NETIF_F_IP_CSUM stays off in
dev->features. On retry, changed still contains IP_CSUM, so the XOR turns
TXCOE back off, and this time the call succeeds.

Wouldn't CHECKSUM_PARTIAL frames then go out without hardware checksums?
RXCSUM can get out of sync the same way.

The VLAN-only case has a similar problem. Suppose the FILTER-on block
clears the table and sets VFE, and then the CTAG_RX block fails. Hardware
filtering is now on with an empty table. dev->features still has FILTER
off, so ndo_vlan_rx_add_vid is never called.

Would all tagged traffic be dropped in that state?

> +
> +	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER) {
> +		if (features & NETIF_F_HW_VLAN_CTAG_FILTER) {
> +			u8 vlan_state = 0;
> +
> +			ret = ax88179_read_cmd(dev, AX_ACCESS_MAC,
> +					       AX88179A_VLAN_ID_CONTROL, 1, 1, &vlan_state);
> +			if (ret < 0)
> +				return ret;
> +
> +			for (int i = 0; i < 256; i++) {
> +				/* Address */
> +				tmp = i;
> +				ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_ADDRESS,
> +						  1, 1, &tmp);
> +				/* Data */
> +				ax88179_write_u16(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0,
> +						  2, 0);
> +				/* Write-Execute */
> +				ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL,
> +						 1, vlan_state | AX_VLAN_CONTROL_WE);
> +			}
> +			vlan_state |= AX_VLAN_CONTROL_VFE;
> +			ret = ax88179_write_cmd(dev, AX_ACCESS_MAC,
> +						AX88179A_VLAN_ID_CONTROL, 1, 1, &vlan_state);

[Severity: Medium]
Should the return values in this loop be checked? The read before the
loop and the VFE write after it are checked. None of the 768 synchronous
control transfers inside the loop are.

If the device stops responding, each transfer can block for
USB_CTRL_SET_TIMEOUT (5 seconds). This runs under RTNL from
__netdev_update_features(). Wouldn't RTNL be held for about an hour?

Errors that come back quickly, such as -EPIPE, would leave some 16-VID
groups with stale bits. VFE is still enabled and 0 is returned, so could
the hardware filter accept VIDs the stack never registered?

[ ... ]

> @@ -612,9 +766,11 @@ static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
>  		dev->mii.supports_gmii = 1;
>  
>  	dev->net->features |= NETIF_F_SG | NETIF_F_IP_CSUM |
> -			      NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO;
> +			      NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO |
> +			      NETIF_F_HW_VLAN_CTAG_TX;

[Severity: Low]
Enabling NETIF_F_HW_VLAN_CTAG_TX here, and making it toggleable through
hw_features, makes the existing tag insertion in ax88179a_tx_fixup()
reachable:

drivers/net/usb/ax88179a_devices.c:ax88179a_tx_fixup() {
    ...
	if ((dev->net->features & NETIF_F_HW_VLAN_CTAG_TX) && (vlan_get_tag(skb, &tci) >= 0)) {
		tx_desc |= AX179A_TX_DESC_VLAN;
		tx_desc |= FIELD_PREP(AX179A_TX_DESC_VLAN_ID, (u64)tci);
	}
    ...
}

This checks dev->net->features again at transmit time, and vlan_get_tag()
also looks at skb->dev->features. By then validate_xmit_vlan() has
already decided to keep the tag in skb->vlan_tci.

__netdev_update_features() doesn't quiesce the TX queue, and
ax88179a_set_features() doesn't stop it either. If txvlan is switched off
while a tagged skb is between validate_xmit_skb() and tx_fixup, can the
frame go out untagged on the native VLAN?

The lan78xx TX path only checks skb_vlan_tag_present() and
skb_vlan_tag_get().

>  
>  	dev->net->hw_features |= dev->net->features;
> +	dev->net->hw_features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER;

[Severity: Medium]
Since NETIF_F_HW_VLAN_CTAG_RX is only added to hw_features, it is off by
default and can be toggled. Its only hardware effect is the
AX_VLAN_CONTROL_VSO strip bit. The RX path, however, tags frames based
only on the descriptor bit:

drivers/net/usb/ax88179a_devices.c:ax88179a_rx_fixup() {
    ...
		if (pkt_desc & AX179A_RX_PD_VLAN) {
			vlan_tag = pkt_desc >> AX179A_RX_PD_VLAN_SHIFT;
			__vlan_hwaccel_put_tag(ax_skb, htons(ETH_P_8021Q), vlan_tag);
		}
    ...
}

The chip may set AX179A_RX_PD_VLAN for tagged frames even when VSO is
clear. In that case the frame would keep its in-band 802.1Q header and
also get a hwaccel tag. Would the stack then treat it as double tagged?

Should this be gated on dev->net->features & NETIF_F_HW_VLAN_CTAG_RX, as
lan78xx_rx_vlan_offload() does? aqc111 can skip that check only because
aqc111_reset() always sets VSO.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-ax88179a-v20-0-37b5a1189983%40birger-koblitz.de
