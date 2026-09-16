Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14374191F94;
	Wed, 16 Sep 2026 06:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541257; cv=none; b=FXKzpg9a3mTe+govtzrVuupF+YCr7Ie65fr63BaaKBhaF2Nlcvn5nxtqINZurYvKmwL7vpjBm7koBkJwoFwKdDaxF/40X8REjMDLNYAffRaXep2Al/GM7w+5gL/cjgODY78GWRWhf87FvEGti+Ut1ZBVCJHG0uRm0uI7mJ6p1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541257; c=relaxed/simple;
	bh=EIO+eFam8TnoD6V7yot6Xp+oCr5mIEVDaes4dOF6hn8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rPJoYHXRi932XcMytEEqCfDm8n1/HWQzRoBVNld/NpMsULePJo+tO4pdH53wGF3MEn6edJffREUHfe6xBhaWjRSVnDxbWNTBo6zcTHXcb1DIQmvVml48ymPeaRq9WnsAsLFivEza44S9l2Yl5Cbp4ONw7RjIib5kpCOTCGMxtcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=honMSnv1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="honMSnv1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D89F1F00898;
	Wed, 16 Sep 2026 06:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541254;
	bh=WArobJgIn2nz8fmX+Q+fLBZtnJ4GBEVMnIm3vTOPbF8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=honMSnv1aKWfMGnl1mNUhtj68d6ImFDFJwI6ZZjkyx6sgWKIgifaD1I0BD6jb392F
	 p9VOhAjr9OzX+os1rVN5RKWI1lXJn3hD5z0aY26zKj2YbfR9wdSSxq8cMASC8w7A+U
	 lVf0DNlO2lCrFiBHSar5iLZX+/lhv1An6+dYSM0+sm8J3lpL2W8TxruyyLRpcamuPO
	 ZYOYk4S4tumJQtBP3ImYQTgtNu6+ooLSnGNUCmr770pj8XT8IIjWJvj4wYb382Y8NM
	 oYlJi3qoSw2T6m/p0c24Sr3MdNPBTtH6oxor0n7loGXvQcL2YQ/91jBDM21IXVZfQ7
	 8hmleHQomhpdQ==
Subject: Re: [PATCH net-next v11 10/15] ax88179_178a: Add AX179A/AX279
 multicast configuration
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Wed, 16 Sep 2026 06:47:33 +0000
Message-ID: <178954125370.22033.18019147682392087483@kernel.org>
In-Reply-To: <20260914-ax88179a-v11-10-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-10-5ea7a925ba6d@birger-koblitz.de>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

- [High] At this commit, ax88179_set_multicast()
  (drivers/net/usb/ax88179_lib.c:313-315) only sets AX_RX_CTL_IPE when…
- [Medium] Adding '.ndo_set_rx_mode = ax88179_set_multicast' to
  ax88179a_netdev_ops (drivers/net/usb/ax88179a_devices.c:611) creates a…

--

ax88179_178a: Add AX179A/AX279 multicast configuration

This makes AX_RX_CTL_IPE conditional on data->ip_align in the shared
ax88179_set_multicast() helper, adds AX_RX_CTL_DROPCRCERR to the base
value, and registers the helper as .ndo_set_rx_mode for the AX88179A
netdev ops.

> diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
> index 3324069e90fc3..708b0b23f1363 100644
> --- a/drivers/net/usb/ax88179_lib.c
> +++ b/drivers/net/usb/ax88179_lib.c
> @@ -305,10 +305,14 @@ int ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
>  void ax88179_set_multicast(struct net_device *net)
>  {
>  	struct usbnet *dev = netdev_priv(net);
> -	struct ax88179_data *data = dev->driver_priv;
>  	u8 *m_filter = ((u8 *)dev->data);
> +	struct ax88179_data *data;
> +
> +	data = dev->driver_priv;
>  
> -	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_IPE);
> +	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_DROPCRCERR);
> +	if (data->ip_align)
> +		data->rxctl |= AX_RX_CTL_IPE;

[Severity: High]
Can this shift every received frame by two bytes on the legacy
AX88179/178A devices?

ax88179_set_multicast() is shared, and the legacy driver in
ax88179_178a.c registers it as .ndo_set_rx_mode in ax88179_netdev_ops.
At this commit, ->ip_align is never assigned anywhere in
ax88179_178a.c; ax88179_bind() zero-allocates the private data:

	ax179_data = kzalloc_obj(*ax179_data);
	if (!ax179_data)
		return -ENOMEM;

	dev->driver_priv = ax179_data;

The only assignments to ->ip_align in the tree at this commit are in
ax88179a_bind() in ax88179a_devices.c:

	if (ax179_data->chip_version == AX_VERSION_AX88279) {
		ax179_data->ip_align = 1;
	...
	} else {
		ax179_data->ip_align = 0;

So on legacy chips the first rx-mode update after ifup
(dev_open() -> dev_set_rx_mode() -> __dev_set_rx_mode(), a multicast
join, or a promisc toggle) rewrites AX_RX_CTL as
START|AB|DROPCRCERR without AX_RX_CTL_IPE, undoing what
ax88179_reset() programmed:

	*tmp16 = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_IPE | AX_RX_CTL_START |
		 AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;

Meanwhile ax88179_rx_fixup() still unconditionally accounts for the
2-byte alignment pseudo header:

	/* Skip IP alignment pseudo header */
	skb_pull(skb, 2);
	...
	memcpy(ax_skb->data, skb->data + 2, pkt_len);

Once the device stops inserting the pad, does each delivered frame lose
its first two bytes and pick up two bytes of trailing data?  The state
also looks sticky, since ax88179_link_reset() re-programs the cached
rxctl.

This also seems to be the opposite of the commit message claim that the
change makes things "consistent with the initial configuration in
ax88179_reset()", at least for the legacy chips, since ax88179_reset()
sets AX_RX_CTL_IPE unconditionally there.

A later patch in the same series ("ax88179_178a: Add support for
AX88179A/772D/279 EEPROM access") adds "ax179_data->ip_align = 1;" to
ax88179_bind(), which restores AX_RX_CTL_IPE for the legacy path, so
the end state of the series is fine.  Could that assignment be moved
into this patch instead, so legacy RX is not broken at intermediate
commits?

>  
>  	if (net->flags & IFF_PROMISC) {
>  		data->rxctl |= AX_RX_CTL_PRO;
> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 4bca801236b08..24accbc22092a 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -608,6 +608,7 @@ static const struct net_device_ops ax88179a_netdev_ops = {
>  	.ndo_set_mac_address	= ax88179_set_mac_addr,
>  	.ndo_validate_addr	= eth_validate_addr,
>  	.ndo_eth_ioctl		= usbnet_mii_ioctl,
> +	.ndo_set_rx_mode	= ax88179_set_multicast,

[Severity: Medium]
What serializes ax179_data->rxctl between this new callback and
ax88179a_mac_link_up()?

ax88179_set_multicast() builds rxctl in several separate stores (base
value, then |= AX_RX_CTL_IPE, then |= PRO/AMALL/AM) and then submits an
asynchronous register write:

	ax88179_write_cmd_async(dev, AX_ACCESS_MAC, AX_RX_CTL,
				2, 2, &data->rxctl);

It runs from __dev_set_rx_mode() with netif_addr_lock_bh() held only.

ax88179a_mac_link_up() reads the same field and programs the same
register with a blocking control transfer:

	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &ax179_data->rxctl);

That path comes from the phylink resolve work, and phylink_resolve()
holds only:

	mutex_lock(&pl->phydev_mutex);
	phy = pl->phydev;
	if (phy)
		mutex_lock(&phy->lock);
	mutex_lock(&pl->state_mutex);

so neither RTNL nor netif_addr_lock is held there.  ax88179a_reset() is
a third writer of the same field:

	ax179_data->rxctl = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_START |
			    AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;
	if (ax179_data->ip_align)
		ax179_data->rxctl |= AX_RX_CTL_IPE;
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &ax179_data->rxctl);

Two things look possible.  Can ax88179a_mac_link_up() observe rxctl
between the base store and the "|= AX_RX_CTL_IPE" store and program
AX_RX_CTL without IPE on an AX88279 where ip_align == 1, while
ax88179a_rx_fixup() keeps deriving its offsets from ip_align:

		pkt_len_plus_padd = ((pkt_len + 7 + (ax179_data->ip_align ? 2 : 0)) & 0x7FFF8);
	...
		memcpy(ax_skb->data, skb->data + (ax179_data->ip_align ? AX179A_RX_HW_PAD : 0),

And can the blocking write in ax88179a_mac_link_up() land after the
async URB from ax88179_set_multicast() completes, leaving the hardware
filter (promisc/AM bits) out of sync with data->rxctl until the next
link event or rx-mode change?

This still appears to be the case at the end of the series, where both
ax88179_set_multicast() and ax88179a_mac_link_up() remain unlocked.

>  	.ndo_set_features	= ax88179a_set_features,
>  	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
>  	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ax88179a-v11-0-5ea7a925ba6d%40birger-koblitz.de
