Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274720;
	b=qSkP9gaYqhWB4N7RWnMATK15X+XoRw5GkoVPxp7pMFd8lIISY9UkTjvP7Zy+TmJGiQYf
	 42tS5jJdg43KGeRWATC+doBWKyNCjlL6mMtY2nSxBg5zd/GAWXprU2ZvcnlqW2q51VJtI
	 YjfSeQkppIisf/nwr7LJfkdXVo9xoqL3JFnZsJsFeNrBoX7ZttDd1csh+cF5epuT/5PEK
	 gHj6Ve8l+U8TjvqFL1O32SUAViKL3yFb2UtxVYRMdKn/T3Wdl04v8tVbJ1JzaHqz1gQft
	 qwxlpfx/lYh4gGhpUzPU4zqxto/AOAQjs6EFs+TxVeTx8XYTnfKE8YMQqda9ve4jHwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274720;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KGvE3KMGKuKrZA4+/bBtrQdCe/5VZY+KQbYE8ywCsFk=;
	b=PKs/1J3tUBIGS1ozpBmHBwyj7YB4sEcA/yBS7onAg0AdinAgTCoVRKDzvz06GMy6ELg7
	 tfxZL+TUPqyaD+8fCuvwU9qF2/kmGFbqGk3ymVLD7tEMMeUZAjM6Q74QhgxRb3ArLu9l2
	 RccnPxcej1zWRD1EntccKEdbri202sO7ReGZDLU0ge6WysnGlIwU1lUmh1XpBYt1tPSM0
	 2x5mlicmKw0TitBk0G3IzZWLhLZx1tDqPb6nEbUNQ+TOblWq6nG7bXF4y5PKeekK3Ds3J
	 4k/DN/am0nokcGgULj+jQJabPYdPFRBvtH48lmuevXJRTm+IxjplxeZ70EfKn+KVBjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3SNFD3o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484626071884;
	Tue, 10 Nov 2026 01:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3SNFD3o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092481F008BD;
	Tue, 10 Nov 2026 01:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274719;
	bh=KGvE3KMGKuKrZA4+/bBtrQdCe/5VZY+KQbYE8ywCsFk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X3SNFD3oZ27oV+/Yn9GYcEPlukGWrITuyJdZKCw1PBdbbyU83VCiSnE+GlWCb98YE
	 jZSgNG3ydQ58QPQtMYRt/e5deLWN6ID0lfiNVA4rksR7AfstGk8+V9UYSEcbD8MH6X
	 K+zFOJsqDNlyU7SOGnK3nzDkxYarkALpQx/Uxm/bbi99KeCmu56URbNaXxE7viq4Qy
	 edZkzov6sz1zQV0njxXkxMnfrwm5CvVm6ri9pHe5zuuYvqaM03xZncILjPevuXSZI/
	 FVkkSPRoOmOLPKNuRwKH5+JpULrnWlL9MU3K//Y39d1SxsQJEPeYyeGtP2cnJZ4JTn
	 VFnIEapaQ4FQA==
Subject: Re: [PATCH net-next v20 08/13] ax88179_178a: Add AX179A/AX279
 multicast configuration
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name,
 edumazet@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 neuromoments@gmail.com, beganovic.emir@gmail.com
Date: Tue, 10 Nov 2026 01:38:38 +0000
Message-ID: <179427471858.994134.13637494943113905652@kernel.org>
In-Reply-To: <20261106-ax88179a-v20-8-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-8-37b5a1189983@birger-koblitz.de>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch also changes RX behaviour on the existing
  AX88179/AX88178A devices, and the commit message does not say so.
- [Medium] Adding `.ndo_set_rx_mode = ax88179_set_multicast` to
  ax88179a_netdev_ops (ax88179a_devices.c:681) gives…
- [Low] This patch adds `.ndo_set_rx_mode = ax88179_set_multicast` to
  ax88179a_netdev_ops (ax88179a_devices.c:681).
- [Low] ax88179_set_multicast() (ax88179_lib.c:362-364) builds the value
  in a local `rxctl` and publishes it with `WRITE_ONCE(data->rxctl,…

--

ax88179_178a: Add AX179A/AX279 multicast configuration

This patch changes ax88179_set_multicast() to build the RX_CTL value in a
local variable. AX_RX_CTL_IPE is now set only when ip_align is set, and
AX_RX_CTL_DROPCRCERR is always set. The patch also installs
ax88179_set_multicast() as ndo_set_rx_mode for the AX88179A family of
devices.

> diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
> index a314db4c97666..b4b00c8b4b623 100644
> --- a/drivers/net/usb/ax88179_lib.c
> +++ b/drivers/net/usb/ax88179_lib.c
> @@ -321,16 +321,21 @@ int ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
>  void ax88179_set_multicast(struct net_device *net)
>  {
>  	struct usbnet *dev = netdev_priv(net);
> -	struct ax88179_data *data = dev->driver_priv;
>  	u8 *m_filter = ((u8 *)dev->data);
> +	struct ax88179_data *data;
> +	u16 rxctl = 0;
> +
> +	data = dev->driver_priv;
>  
> -	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_IPE);
> +	rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_DROPCRCERR);
> +	if (data->ip_align)
> +		rxctl |= AX_RX_CTL_IPE;

[Severity: Medium]
Does this also change RX behaviour on the existing AX88179/AX88178A
devices? The legacy driver uses this helper as its rx_mode handler:

drivers/net/usb/ax88179_178a.c:
	.ndo_set_rx_mode	= ax88179_set_multicast,

Before this patch the helper wrote AX_RX_CTL_START | AX_RX_CTL_AB |
AX_RX_CTL_IPE, without AX_RX_CTL_DROPCRCERR.

The value set in ax88179_reset() only goes into a temporary. It is never
stored in data->rxctl:

drivers/net/usb/ax88179_178a.c:ax88179_reset() {
    ...
	*tmp16 = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_IPE | AX_RX_CTL_START |
		 AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, tmp16);
    ...
}

On open, usbnet_open() runs the reset first. Then
dev_open()->dev_set_rx_mode()->ax88179_set_multicast() overwrites that
value, and ax88179_link_reset() keeps writing data->rxctl back. So legacy
adapters have been running with AX_RX_CTL_DROPCRCERR cleared. Frames with
a bad CRC were then counted in ax88179_rx_fixup():

	if ((*pkt_hdr & (AX_RXHDR_CRC_ERR | AX_RXHDR_DROP_ERR)) ||
	    pkt_len < 2 + ETH_HLEN) {
		dev->net->stats.rx_errors++;

This patch sets AX_RX_CTL_DROPCRCERR for every chip. If the hardware then
drops those frames itself, as the bit name suggests, would legacy users
stop seeing CRC errors in rx_errors?

The commit message says:

  "make sure that AX_RX_CTL_DROPCRCERR is also set to be consistent with
  the initial configuration in ax88179_reset()"

That reset value never survived on legacy devices, so this is a real
behaviour change rather than a consistency cleanup.

The message also leaves out the reason given in the ax88179a_bind()
comment, which says the AX88279 needs both AX_RX_CTL_IPE and
AX_RX_CTL_DROPCRCERR to produce correct RX URBs.

Could the commit message describe the change to legacy devices, or could
that change go in its own patch?

[Severity: Low]
This might not be a bug, but is AX_RX_CTL_AP left out on purpose here?
ax88179a_reset() stores a different baseline in data->rxctl:

drivers/net/usb/ax88179a_devices.c:ax88179a_reset() {
    ...
	rxctl = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_START | AX_RX_CTL_AP |
		AX_RX_CTL_AMALL | AX_RX_CTL_AB;
    ...
}

Now that ndo_set_rx_mode is set for ax88179a,
dev_open()->dev_set_rx_mode()->ax88179_set_multicast() replaces that value
with one that has AX_RX_CTL_AP cleared. ax88179a_mac_link_up() then writes
READ_ONCE(ax179_data->rxctl) back on every link-up. Before this patch
these chips kept AX_RX_CTL_AP set.

The intent is to match the reset-time configuration. Should
ax88179a_reset() drop AX_RX_CTL_AP, or should ax88179_set_multicast() keep
it? The legacy AX88179 has run without AX_RX_CTL_AP after open, but it is
not clear that the same is safe on AX88179A/AX88279 silicon.

[ ... ]

> @@ -351,9 +356,10 @@ void ax88179_set_multicast(struct net_device *net)
>  					AX_MCAST_FLTSIZE, AX_MCAST_FLTSIZE,
>  					m_filter);
>  
> -		data->rxctl |= AX_RX_CTL_AM;
> +		rxctl |= AX_RX_CTL_AM;
>  	}
>  
> +	WRITE_ONCE(data->rxctl, rxctl);
>  	ax88179_write_cmd_async(dev, AX_ACCESS_MAC, AX_RX_CTL,
>  				2, 2, &data->rxctl);

[Severity: Low]
Minor, but the value is already in the local rxctl. Could this pass &rxctl
instead of &data->rxctl? ax88179_write_cmd_async() reads the shared field
back with a plain load:

drivers/net/usb/ax88179_lib.c:ax88179_write_cmd_async() {
    ...
		buf = *((u16 *)data);
    ...
}

Elsewhere, data->rxctl is accessed with WRITE_ONCE()/READ_ONCE()
(ax88179a_reset(), ax88179a_mac_link_up()). If another writer changes the
field between the WRITE_ONCE() and this load, the URB carries a value this
call did not compute, and KCSAN may flag the unmarked access.

ax88179_write_cmd_async() copies into a stack buffer and
usbnet_write_cmd_async() duplicates it, so a pointer to the local should
be safe.

>  }
> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 4207d2cc2b865..a6b0a3f47118c 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -678,6 +678,7 @@ static const struct net_device_ops ax88179a_netdev_ops = {
>  	.ndo_set_mac_address	= ax88179_set_mac_addr,
>  	.ndo_validate_addr	= eth_validate_addr,
>  	.ndo_eth_ioctl		= ax88179a_mii_ioctl,
> +	.ndo_set_rx_mode	= ax88179_set_multicast,

[Severity: Medium]
Can this new writer of data->rxctl and AX_RX_CTL race with
ax88179a_mac_link_up()?

ax88179a_netdev_ops has no ndo_set_rx_mode_async. So __dev_set_rx_mode()
calls ax88179_set_multicast() directly, in atomic context under
netif_addr_lock_bh(), where it cannot take medium_status_mutex.

ax88179a_mac_link_up() runs from the phylink resolve work and holds
neither rtnl nor the addr lock. It stops RX, then reprograms the RX
framing and bulk-in registers with many synchronous control transfers.
It only takes medium_status_mutex around the final write:

drivers/net/usb/ax88179a_devices.c:ax88179a_mac_link_up() {
    ...
	/* Stop RX/TX for link configuration */
	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, AX_RX_CTL_STOP);
	ax88179_write_u8(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 0);
    ...
	ax88179_write_u16(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, READ_ONCE(ax179_data->rxctl));
	mutex_unlock(&ax179_data->medium_status_mutex);
    ...
}

Two orderings look possible. The first loses an update:

phylink resolve work              rx_mode change (e.g. promisc on)
ax88179a_mac_link_up()
  READ_ONCE(rxctl) -> old
                                  ax88179_set_multicast()
                                    WRITE_ONCE(data->rxctl, new)
                                    async AX_RX_CTL = new
  sync AX_RX_CTL = old

The hardware ends up with the old filter while software holds the new
one. Promiscuous, allmulti or multicast reception would then be missing
until the next rx_mode event.

In the second, the async write includes AX_RX_CTL_START. If it lands
between the AX_RX_CTL_STOP write and the final AX_RX_CTL write, does it
turn the receiver back on while the RX framing and bulk-in settings are
only partly applied? ax88179a_rx_fixup() would then parse URBs built with
those half-applied settings.

Before this patch ax88179a had no ndo_set_rx_mode, so neither ordering
could happen.

Could the rx-mode programming be deferred to process context, for example
through usbnet's EVENT_SET_RX_MODE kevent or ndo_set_rx_mode_async? It
could then be serialized with ax88179a_mac_link_up() under
medium_status_mutex.

>  	.ndo_set_features	= ax88179a_set_features,
>  	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
>  	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-ax88179a-v20-0-37b5a1189983%40birger-koblitz.de
