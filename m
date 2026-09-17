Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829504EF15D;
	Thu, 17 Sep 2026 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680305; cv=none; b=i4blFlwnhBKEFm37jIXzVcjqXHCuHXgbmo/UDknXwrQargGQzVjINJddmrwE3O65IjbI5h1sONXQVezE8TDWS4IFQ4j3DrbzbcedCaauUzt4CuavVOVqpxFAOJ+WkZEz1HBIFZsf7YtUP8+Fuu2VL5kBRPllxnZiqs8duz7Lm+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680305; c=relaxed/simple;
	bh=N+AkSompeP7PyJuOPQ7TZ5JI8T5A3vTyILs5AymvrHQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kU9UdYllthgA7py7mX3HKfrlmLn/2q/+YKIwcNPD+OJx8eR+iIOKupt+rsOsAAT8UyD7tVrMeEXVBJHPh5RMf2R8zfEJrUKphzgs5yvL7XxLF2b9S4VqsQPda10HtvySjzvF5SIGHQn0mnPYnTtkOQE3ZtuvAGgi4Yf3mQUMtB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hicRnCqv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hicRnCqv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C089B1F000FF;
	Thu, 17 Sep 2026 21:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680303;
	bh=6O4RNG0FkAnObtpex+9otixvcuWfjqaS29V+78eSWJk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hicRnCqvV7am6bEbiiUw9nZdT+phUo6xh4R2h3/0JNh80rBa52oG5DbFRv/d1FFaW
	 RMwdZuhqrAdSOJf8kWpvd4cY6tocsLNMO7QPXGPpbvSAvNkarAtVQ2Ac5hINT6nRSq
	 W2cVr4ij5NITdH/WP5noC0+b+VHcscbc1j4QdD9Pq47KI3hc+cyzkgfEAJMm5VL2wq
	 DJljrFccOBR5tRFQB9qHdrSFu1NQNg09QXOG2uO1EFpkEE5m0WFMNbn96Q6ZKfMl9x
	 2C825+a5JyVdKMfHnpooz1+UImYBeesXmag/h15otzvz8knBz3+mSF7PHN5FqTwa81
	 196cUROzpbgtg==
Subject: Re: [PATCH net-next v12 10/15] ax88179_178a: Add AX179A/AX279
 multicast configuration
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Thu, 17 Sep 2026 21:25:02 +0000
Message-ID: <178968030235.22033.16475533840382469089@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-10-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-10-60c04c9924a2@birger-koblitz.de>
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

- [High] ax88179_set_multicast() (drivers/net/usb/ax88179_lib.c:305) now
  only sets AX_RX_CTL_IPE when data->ip_align is non-zero (line 314).
- [Medium] Registering ax88179_set_multicast() as .ndo_set_rx_mode for
  the AX88179A family (drivers/net/usb/ax88179a_devices.c:618) creates a…

--

ax88179_178a: Add AX179A/AX279 multicast configuration

This makes AX_RX_CTL_IPE conditional on the new ip_align field in the
shared ax88179_set_multicast() helper, adds AX_RX_CTL_DROPCRCERR to the
base value, and registers the helper as .ndo_set_rx_mode for the
AX88179A device family.

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
Can this break RX on the legacy AX88179/AX88178A devices at this commit?

ax88179_set_multicast() is also the rx-mode handler of the older driver:

drivers/net/usb/ax88179_178a.c:ax88179_netdev_ops = {
	...
	.ndo_set_rx_mode	= ax88179_set_multicast,
	...
};

but at this commit ax88179_bind() in ax88179_178a.c only kzalloc's the
private data and never assigns ip_align (grep for ip_align in that file
finds only netdev_alloc_skb_ip_align() calls), so "if (data->ip_align)"
is always false there and the async AX_RX_CTL write at the end of
ax88179_set_multicast() clears AX_RX_CTL_IPE.

That contradicts what ax88179_reset() programs:

drivers/net/usb/ax88179_178a.c:ax88179_reset() {
	...
	/* Configure RX control register => start operation */
	*tmp16 = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_IPE | AX_RX_CTL_START |
		 AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;
	...
}

and ax88179_rx_fixup() in the same file still strips the pad
unconditionally, with no ip_align test (unlike ax88179a_devices.c, which
uses "ax179_data->ip_align ? 2 : 0"):

drivers/net/usb/ax88179_178a.c:ax88179_rx_fixup() {
	...
			/* Skip IP alignment pseudo header */
			skb_pull(skb, 2);
	...
		memcpy(ax_skb->data, skb->data + 2, pkt_len);
	...
}

So after the first rx-mode update following reset (dev_set_rx_mode() at
interface open, a promisc/allmulti change, or an unprivileged multicast
join via IP_ADD_MEMBERSHIP or MLD), does every received frame get
delivered shifted by two bytes, with the memcpy() path pulling up to two
bytes from the following packet slot into the frame handed to the stack
while the descriptor-derived CHECKSUM_UNNECESSARY is still applied?

Additional detail from the series: the later commit "ax88179_178a: Add
support for AX88179A/772D/279 EEPROM access" adds
"ax179_data->ip_align = 1;" to ax88179_bind() in ax88179_178a.c, so the
final state of the series is fine. That leaves this commit through
"ax88179_178a: Add ethtool get_drvinfo" / "ax88179_178a: Update driver
name and information" with broken RX on legacy devices. Would it make
sense to move that ip_align assignment into this patch so the tree stays
bisectable?

>  
>  	if (net->flags & IFF_PROMISC) {
>  		data->rxctl |= AX_RX_CTL_PRO;
> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 481139f71ac26..e77450bc3299f 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -615,6 +615,7 @@ static const struct net_device_ops ax88179a_netdev_ops = {
>  	.ndo_set_mac_address	= ax88179_set_mac_addr,
>  	.ndo_validate_addr	= eth_validate_addr,
>  	.ndo_eth_ioctl		= ax88179a_mii_ioctl,
> +	.ndo_set_rx_mode	= ax88179_set_multicast,

[Severity: Medium]
Does this registration introduce an unsynchronized writer of
ax179_data->rxctl for the AX88179A family?

ax88179a_netdev_ops has neither .ndo_set_rx_mode_async nor
.ndo_change_rx_flags, so __dev_set_rx_mode() calls the handler directly
from dev_set_rx_mode():

net/core/dev_addr_lists.c:dev_set_rx_mode() {
	netif_addr_lock_bh(dev);
	__dev_set_rx_mode(dev);
	netif_addr_unlock_bh(dev);
}

ax88179_set_multicast() then does a multi-step read-modify-write of
data->rxctl (base value, then |= AX_RX_CTL_IPE, then |= PRO/AMALL/AM
with an async multicast-hash URB submitted in between) and finally
programs the register with ax88179_write_cmd_async().

Meanwhile ax88179a_mac_link_up() reads the same field and writes it
synchronously from the phylink resolve path, holding only phylink's
state_mutex:

drivers/net/usb/ax88179a_devices.c:ax88179a_mac_link_up() {
	...
	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &ax179_data->rxctl);
	...
}

and ax88179a_reset() rewrites both rxctl and the register:

drivers/net/usb/ax88179a_devices.c:ax88179a_reset() {
	...
	ax179_data->rxctl = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_START |
			    AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;
	...
}

The lock sets do not intersect, so can the phylink path latch an
intermediate rxctl value that is missing AX_RX_CTL_AM/AMALL/PRO? And
since one side uses an async URB while the other uses a synchronous
control transfer, can the two AX_RX_CTL writes also complete out of
order and leave the hardware filter without the multicast or promisc
bits until the next filter change or link event?

The same pattern already exists in the legacy driver's
ax88179_link_reset(), but for the AX88179A family this concurrency is
new here, and it is still present at the series tip. Would routing the
filter update through a deferred path (usbnet's EVENT_SET_RX_MODE /
driver_info->set_rx_mode, or .ndo_set_rx_mode_async) put it in the same
process context as the link and reset writers?

>  	.ndo_set_features	= ax88179a_set_features,
>  	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
>  	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ax88179a-v12-0-60c04c9924a2%40birger-koblitz.de
