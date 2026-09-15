Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC02E54B;
	Tue, 15 Sep 2026 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430532; cv=none; b=hrJn+XnvePWwWS9FYjWtVny61gFpd0bjX//A0QjsQaYzFu6CSZFLLKfX/xdzrCF2aubELc2d1FWgrNp6yCgtmhWNlEH0/OgSkHh36DUVlBZ7rVtIKS1dajr3U/vzCj27F6Wp+CWUTyGP+/cQFpr9HdDIE09ZAnRTqzjB5Yo+97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430532; c=relaxed/simple;
	bh=Z00tgr0iJfPA6eCMkmvMyUoY2ciT53//89in3zibU0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwtSefZogT2YspE4XPE0IddKq520l8GeJELjtTsccNcNLwyGAKQhTBfOr3Y4v4Us3CDfGWtov6X/gAaRvSG29e1Pyxp/46ZYhv2+AogcTt5wCoPANIiI/cxNGaQkFQSq4aQP4MAE4ITmev4N8tSzLmc5epnSQDrgnovQ4e2dV/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=X28921eC; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Mf+uPeuh; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="X28921eC";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Mf+uPeuh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789430528;
	bh=Z00tgr0iJfPA6eCMkmvMyUoY2ciT53//89in3zibU0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X28921eCEaYJ38BHyYq5iW09sw+p6KrB7T4UR90EKnghPx1UAmkquq7r+QEgNNVz+
	 BvPZvIRxdJhdyQ4rpc9AraxFeu3Fp/7fZSjJA92HN5gibxf+jlOgYQFpnYXaoVWi94
	 uBcMYGTrBA4nsLLnyANmZtvkfxjViLP0jTDC1Fo7oBWLTWehT2NwLARBtdaKEu1Y0N
	 ksGclHcz/emnfGSWisk88fbD3l/6mfbdKvdXtjza0e8g2CGYal/Ncz30mjlbJLnKHX
	 lat9NZJKmJDyuvs/QjBuamXCXGJ3fpsjRlWtkvYcK2pAyiksJKEg4XsMiLg/ABzOVg
	 mGlhImR95794g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E48D93F844; Tue, 15 Sep 2026 00:02:08 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789430527;
	bh=Z00tgr0iJfPA6eCMkmvMyUoY2ciT53//89in3zibU0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mf+uPeuhMlfwrAs6neqDmLOoZcIxSAWlgwUUooq6+brTbhntqKzrew6O9hK6fVjCl
	 3apW/67Y6PCkLN8BNM2g1zY5y5+BlgEbvKnPpgP6PPcGBt077mNmMJRq+f+2V9LBZT
	 62XiFLXLsAepuX/6Iv2pJvHqMVFKG6l4m75WY290PN8otWXRNipUtvm7NmoCxzmHl0
	 RElJYmojO+zo34/BWj2xKIjX/bPX9erTMzxwqiTZV4V/9TjWWxYYxOz/7QsMNCE9pp
	 pjpChq0yvD7WRS/zSHajtwFwD8AvB9uLFKezCXF5hoh3xDGWN7VbMVKGzFr+hBIc6R
	 ATypADhDnua8Q==
Received: from [IPV6:2409:8a62:2532:dca0:14f4:3e22:1e7c:23c2] (unknown [IPv6:2409:8a62:2532:dca0:14f4:3e22:1e7c:23c2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 9852B3EBCA;
	Tue, 15 Sep 2026 00:02:03 +0000 (UTC)
Message-ID: <9a4ad1ba-0d98-4a5d-b18d-742f82337641@birger-koblitz.de>
Date: Tue, 15 Sep 2026 02:01:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
To: Andrew Lunn <andrew@lunn.ch>, Nicolai Buchwitz <nb@tipi-net.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
 <20260914-ax88179a-v11-6-5ea7a925ba6d@birger-koblitz.de>
 <18c931ca985a82a044c9269743fb4fb7@tipi-net.de>
 <3103b046-fa19-4b59-af4a-f326783eda4f@lunn.ch>
Content-Language: en-US
From: Birger Koblitz <mail@birger-koblitz.de>
In-Reply-To: <3103b046-fa19-4b59-af4a-f326783eda4f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/26 18:53, Andrew Lunn wrote:
>>> +static const struct net_device_ops ax88179a_netdev_ops = {
>>> +	.ndo_open		= usbnet_open,
>>> +	.ndo_stop		= usbnet_stop,
>>> +	.ndo_start_xmit		= usbnet_start_xmit,
>>> +	.ndo_tx_timeout		= usbnet_tx_timeout,
>>> +	.ndo_get_stats64	= dev_get_tstats64,
>>> +	.ndo_change_mtu		= ax88179_change_mtu,
>>> +	.ndo_set_mac_address	= ax88179_set_mac_addr,
>>> +	.ndo_validate_addr	= eth_validate_addr,
>>> +	.ndo_eth_ioctl		= usbnet_mii_ioctl,
>>
>> dev->mii.mdio_read is never initialized for ax88179a, so
>> dev->mii.mdio_read()
>> through usbnet_mii_ioctl() is a NULL function pointer.
>>
>> Something like:
>>
>>    static int ax88179a_mii_ioctl(...)
>>    {
>>    	struct ax88179_data *data = netdev2data(net);
>>    	return phylink_mii_ioctl(data->phylink, ifr, cmd);
>>    }
> 
> Is this transitory? Does a later patch fix this up?
> The aim is to remove all dev->mii accesses.
> 

No, unfortunately, this is an mii-leftover. I thought that
usbnet was emulating the mii ioctl somehow, not that it was expecting
to be able to use a mii_mdio_read. I will remove the
 >>> +	.ndo_eth_ioctl		= usbnet_mii_ioctl,
line, entirely.

Birger

