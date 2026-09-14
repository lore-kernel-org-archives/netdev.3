Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6751E471402;
	Mon, 14 Sep 2026 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395179; cv=none; b=ioCmW7lfU1v7SsJQZ96GnPXiDSjwfmjmeOUrIg7j7smBfEN4CGMlJtnAX9RU84G2EdG7PPKFElo34SEppuRKvZ0gJDEgseIPGIukpXEXV79rkOSRP+q7S1TQorZClGJkoEW9osRtfJZj0aFlHl9AKaXl2Trj0tP+veG+BwtlSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395179; c=relaxed/simple;
	bh=UrSK293fwFDujTjwSVBaMN8gvwemeZczHJsVM1ZYPy4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rbD2+gmOMB8ZRXpi1f29z3LPW/ZZIVPLojJ1mN8smOEGPNlk9YWyMpC2NfHYUEztAoBSplTztoxtwEU9pNwsNZkw+f1FIJ+pM/ZKaMbQ+wPfvWo28jx3aa37LaYhieh0vNsWOBiPMHE0IeTC/vYfFM6oFqBjE5BcPOoG3fy4RQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=IOuRaT6F; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="IOuRaT6F"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 061B6A02A9;
	Mon, 14 Sep 2026 16:12:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789395169; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=e/IgfF6yLLH39AK6wZv/vjP09JtDv7w42jijGVHpL4Q=;
	b=IOuRaT6FYPV67HJjNwppyiP3wSSn3Nd0cDIAp5I/lNPktMXSdC+245Q5/+pTRl9VZf3zJJ
	g4egBGOV8UYLFcX2M362LKDpKUZyjTkidCLrBPNAvb6jrSEY7sCy1LpSmmKYE0D75Escom
	ztso4/8VDlJd5GQ0jNH5yjFH0aomlwLa4z/46spqfCb2Y3ucLG3rmT6AiRpEDzR1q7UFfC
	dvgyrBaN0t9ppQY2AHsoA9p73SRUbWNpW8BII2Y91QKFQEg5WVwiEonIL+m0ItCbGdv7Bz
	22hgDH1hhKFbrQuFGYa2rPTGMWTKk0o/b0TCfCwHFx0Ce67+8gHpBVh1tT2mcg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 16:12:46 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v11 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
In-Reply-To: <20260914-ax88179a-v11-6-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
 <20260914-ax88179a-v11-6-5ea7a925ba6d@birger-koblitz.de>
Message-ID: <18c931ca985a82a044c9269743fb4fb7@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Birger

On 14.9.2026 14:46, Birger Koblitz wrote:
> This adds bindings and HW support for AX179A-based USB-Ethernet
> controllers. The AX179A-family of chips consists of the
> AX88279 (2.5GBit PHY)
> AX88179A/B (1GBit PHY, B variant has wider temperature range)
> AX772D/E (100Mbit PHY)
> 
> The controllers all have the same vendor and device ID
> (0x0b95, 0x1790) and are distinguished by their BCD device versions,
> which are
> 2.00 AX88179A/B
> 3.00 AX88772D/E
> 4.00 AX88279
> 
> For all chips, the driver calls the same ax88179a_bind() function
> and the chips are then distinguished by the chip version and
> BCD device ID. The AX179A-based chips all provide both a CDC-NCM
> compatible USB interface, and a proprietary vendor interface. By 
> default,
> the proprietary vendor interface is not active and Linux will load the
> CDC-NCM driver to support the devices. If the ax88179_178a module is
> configured by the OS to have precedence over CDC-NCM, then this driver
> will switch the device to use the vendor interface, and the device will
> be controlled by the ax88179_178a driver when the device is probed 
> again
> after an automatic reset by the device.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

> [...]

> diff --git a/drivers/net/usb/ax88179_178a.c 
> b/drivers/net/usb/ax88179_178a.c
> index 
> 6aa35c8eb594fda38f7680f8801f0d82090c1efd..33be9ef73e73dd550402692e96605d22c481c7ec 
> 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -1270,6 +1270,18 @@ static const struct driver_info 
> at_umc2000sp_info = {
> 
>  static const struct usb_device_id products[] = {
>  {
> +	/* ASIX AX88179A USB 3.2 1000Mbit Ethernet */
> +	USB_DEVICE_VER(0x0b95, 0x1790, 0, 0x0200),

USB_DEVICE_VER(0x0b95, 0x1790, 0x0200, 0x0200),

Otherwise it would select the wrong callback the existing AX88179 
(0x0100)?

> +	.driver_info = (unsigned long)&ax88179a_info,
> +}, {
> +	/* ASIX AX88772D USB 2.0 100Mbit Ethernet */
> +	USB_DEVICE_VER(0x0b95, 0x1790, 0x0300, 0x0300),
> +	.driver_info = (unsigned long)&ax88772d_info,
> +}, {
> +	/* ASIX AX88279 USB 3.2 2500Mbit Ethernet */
> +	USB_DEVICE_VER(0x0b95, 0x1790, 0, 0x0400),

USB_DEVICE_VER(0x0b95, 0x1790, 0x0400, 0x0400),

Same as with AX88179 above.

> [...]

> diff --git a/drivers/net/usb/ax88179a_devices.c 
> b/drivers/net/usb/ax88179a_devices.c
> new file mode 100644
> index 
> 0000000000000000000000000000000000000000..21ca71cba52ca84883a05d8be869115395c82af1
> --- /dev/null
> +++ b/drivers/net/usb/ax88179a_devices.c

> [...]

> +static const struct net_device_ops ax88179a_netdev_ops = {
> +	.ndo_open		= usbnet_open,
> +	.ndo_stop		= usbnet_stop,
> +	.ndo_start_xmit		= usbnet_start_xmit,
> +	.ndo_tx_timeout		= usbnet_tx_timeout,
> +	.ndo_get_stats64	= dev_get_tstats64,
> +	.ndo_change_mtu		= ax88179_change_mtu,
> +	.ndo_set_mac_address	= ax88179_set_mac_addr,
> +	.ndo_validate_addr	= eth_validate_addr,
> +	.ndo_eth_ioctl		= usbnet_mii_ioctl,

dev->mii.mdio_read is never initialized for ax88179a, so 
dev->mii.mdio_read()
through usbnet_mii_ioctl() is a NULL function pointer.

Something like:

   static int ax88179a_mii_ioctl(...)
   {
   	struct ax88179_data *data = netdev2data(net);
   	return phylink_mii_ioctl(data->phylink, ifr, cmd);
   }

> [...]

> +static int ax88179a_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
> +{

> [...]

> +
> +		if (pkt_desc & AX179A_RX_PD_VLAN) {
> +			vlan_tag = pkt_desc >> AX179A_RX_PD_VLAN_SHIFT;
> +			__vlan_hwaccel_put_tag(ax_skb, htons(ETH_P_8021Q),
> +					       vlan_tag & VLAN_VID_MASK);

Drop the mask and pass the complete vlan_tag, so priority is preserved?

> +		}
> +
> +		usbnet_skb_return(dev, ax_skb);
> +		skb_pull(skb, pkt_len_plus_padd);
> +
> +		/* Next RX Packet Header */
> +		pkt_desc_ptr++;
> +	}
> +
> +	return 1;
> +
> +err:
> +	return 0;
> +}
> +
> +static struct sk_buff *ax88179a_tx_fixup(struct usbnet *dev, struct 
> sk_buff *skb, gfp_t flags)
> +{
> +	u64 tx_desc = skb->len & AX179A_TX_DESC_LEN_MASK;
> +	int frame_size = dev->maxpacket;
> +	struct sk_buff *ax_skb;
> +	u64 *tx_desc_ptr;
> +	int padding_size;
> +	int headroom;
> +	int tailroom;
> +	u16 tci = 0;
> +
> +	/* TSO MSS */
> +	tx_desc |= ((u64)(skb_shinfo(skb)->gso_size & 
> AX179A_TX_DESC_MSS_MASK)) <<
> +		   AX179A_TX_DESC_MSS_SHIFT;
> +
> +	headroom = (skb->len + sizeof(tx_desc)) % 8;
> +	padding_size = headroom ? 8 - headroom : 0;
> +
> +	if (((skb->len + sizeof(tx_desc) + padding_size) % frame_size) == 0) 
> {
> +		padding_size += 8;
> +		tx_desc |= AX179A_TX_DESC_DROP_PADD;
> +	}
> +
> +	if ((dev->net->features & NETIF_F_HW_VLAN_CTAG_TX) && 
> (vlan_get_tag(skb, &tci) >= 0)) {
> +		tx_desc |= AX179A_TX_DESC_VLAN;
> +		tx_desc |= ((u64)tci & AX179A_TX_DESC_VLAN_MASK) << 
> AX179A_TX_DESC_VLAN_SHIFT;
> +	}
> +
> +	if (!dev->can_dma_sg && (dev->net->features & NETIF_F_SG) && 
> skb_linearize(skb))
> +		return NULL;

Call dev_kfree_skb_any() before returning, so the skb can't leak when 
skb_linearize() fails.

> [...]

Thanks
Nicolai
