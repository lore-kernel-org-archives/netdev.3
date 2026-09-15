Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E4943A7E9;
	Tue, 15 Sep 2026 05:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789450164; cv=none; b=foc2HCkmyex3Kbp7fIxGqmXkzqQ+2ti4CtN0LQi0Lz7+805JJR+EXtw743YBuqEFJ80up9Tj8wG0pBgoa1s4X/hBGA0A5ASkNVHa2TCx7TrkrOCW4ZnYf+7QHqG7rSo0xnNUWbgb/8Ddmyd8PspsyiHrhQHqexYH/xyRGLbgUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789450164; c=relaxed/simple;
	bh=8RN+0SmxBN0En5bKl6m+0wqn9GNYqbU1vWllzXU7Z6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pmqe5iGf2QclH7xPAzwDMWfG6WZqjY5xGrkGBHXKmMHIdLR//nF38tSHt6MrxwG+a58UxerOMHngJgqTaxeNT2V2Bm/HVUg7UX7ME1tK/gHm2ZT0jSKYCxJo3mGB/0lQsDu8SP8Tc1RabJH4khbMvUwc6PP1uGr9CfeDo2cpJxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=u74FFgMC; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=1fEN9DYk; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="u74FFgMC";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="1fEN9DYk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789450155;
	bh=8RN+0SmxBN0En5bKl6m+0wqn9GNYqbU1vWllzXU7Z6A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u74FFgMCNHjbDw0cGN0EmtV+8aiEUH54hWAM8QE43LJpFsF6OzoardM8nuKRbjSp9
	 wxjwRfstHiWhekpVphJAk0RYn1xVeLZyDVbeXcprfqx6bEQ07OTDhOMNx9Mk186wQn
	 626eLdXl6v6bvfzMDWiOTPeVxV+6fMb62QWmTAKuEoqZQIs/f/UAHp5b8KQK5mndVj
	 K72g4H4V8twpDrIOHW+FewZq1GQABnXNCo+oBTdhjxIODGx4fqSjVG5Y2vyAtVA171
	 HoqOHtWagMQTt+xfnK0DnZSU+LvH7FlVoIAK4zlthiBeVhGiLqQ++DekasxeP0GmuD
	 E3tFtQGSY8KdA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 871FD3F88F; Tue, 15 Sep 2026 05:29:15 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789450154;
	bh=8RN+0SmxBN0En5bKl6m+0wqn9GNYqbU1vWllzXU7Z6A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1fEN9DYkFdQIBraoha6Snh2GWZj+H6H0FfS8D+vehSadWcu1vL5cwVGjpQWL4GB2p
	 NhZnX8y8NqNntLNMleEZD3TVHKoS9WTAKaHuNH1qKV0grzzvTDg5pFGpBogGgu1nME
	 LeUL3N1IyzZN0eGYkoc1zCQpbPOTncvRNr2bQoy5KjgtUy1JY78P/HU32PKEFHWAhu
	 od1Qq2dxAGvH1zzO/vGTHj8B0/aV7mBA326BRnPiCCJb6ca9j4b4XaIWsOO8SOVCkT
	 c+4r3SVqxaC3EQ39ikzzTF+Iiic1ynLMR44dwx20Br0vkGnunvA202HwFIUQ+eM2ro
	 vzHdJhuxjJIFQ==
Received: from [192.168.2.233] (unknown [223.86.26.228])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 24E7F3F846;
	Tue, 15 Sep 2026 05:29:07 +0000 (UTC)
Message-ID: <4510106f-ef2c-4c01-9235-c910faf74b2e@birger-koblitz.de>
Date: Tue, 15 Sep 2026 07:28:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jianhui Xu <neuromoments@gmail.com>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
 <20260914-ax88179a-v11-6-5ea7a925ba6d@birger-koblitz.de>
 <18c931ca985a82a044c9269743fb4fb7@tipi-net.de>
Content-Language: en-US
From: Birger Koblitz <mail@birger-koblitz.de>
In-Reply-To: <18c931ca985a82a044c9269743fb4fb7@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Nicolai,

thanks so much for reviewing this patch-series!
On 9/14/26 16:12, Nicolai Buchwitz wrote:
>>  static const struct usb_device_id products[] = {
>>  {
>> +    /* ASIX AX88179A USB 3.2 1000Mbit Ethernet */
>> +    USB_DEVICE_VER(0x0b95, 0x1790, 0, 0x0200),
> 
> USB_DEVICE_VER(0x0b95, 0x1790, 0x0200, 0x0200),
> 
> Otherwise it would select the wrong callback the existing AX88179 (0x0100)?
Oops, that is a good catch! I took this from manufacturer code and 
probably that range includes also prototypes. The older devices are
handled there with a different driver, however, but indeed we need to be 
sure the 0x0100 versions are not caught. Will fix in the v12.

> 
> Same as with AX88179 above.
Indeed. Will fix.


>> +static const struct net_device_ops ax88179a_netdev_ops = {
>> +    .ndo_open        = usbnet_open,
>> +    .ndo_stop        = usbnet_stop,
>> +    .ndo_start_xmit        = usbnet_start_xmit,
>> +    .ndo_tx_timeout        = usbnet_tx_timeout,
>> +    .ndo_get_stats64    = dev_get_tstats64,
>> +    .ndo_change_mtu        = ax88179_change_mtu,
>> +    .ndo_set_mac_address    = ax88179_set_mac_addr,
>> +    .ndo_validate_addr    = eth_validate_addr,
>> +    .ndo_eth_ioctl        = usbnet_mii_ioctl,
> 
> dev->mii.mdio_read is never initialized for ax88179a, so dev- 
>  >mii.mdio_read()
> through usbnet_mii_ioctl() is a NULL function pointer.
> 
> Something like:
> 
>    static int ax88179a_mii_ioctl(...)
>    {
>        struct ax88179_data *data = netdev2data(net);
>        return phylink_mii_ioctl(data->phylink, ifr, cmd);
>    }
> 
I will remove the entire
+    .ndo_eth_ioctl        = usbnet_mii_ioctl,
line. It should not be necessary.

>> +
>> +        if (pkt_desc & AX179A_RX_PD_VLAN) {
>> +            vlan_tag = pkt_desc >> AX179A_RX_PD_VLAN_SHIFT;
>> +            __vlan_hwaccel_put_tag(ax_skb, htons(ETH_P_8021Q),
>> +                           vlan_tag & VLAN_VID_MASK);
> 
> Drop the mask and pass the complete vlan_tag, so priority is preserved?
Indeed. Will fix.

>> +    if (!dev->can_dma_sg && (dev->net->features & NETIF_F_SG) && 
>> skb_linearize(skb))
>> +        return NULL;
> 
> Call dev_kfree_skb_any() before returning, so the skb can't leak when 
> skb_linearize() fails.
Will fix.

Birger
