Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5653282F31;
	Sun,  2 Aug 2026 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785687604; cv=none; b=ksOs8WbiNRTFoONCzk27HWzzyRiF7uC3qAyh2XbuHPoX7wgyhPVlHZ0AQcZNDBTjp6zefi9CBu3LegV3vxkOcOp8QlRhdoZobZ/0iMgAlzhwiYHAE4YtuEXwz97OGYyz/q7buFK5L3Xj6aojDqDWBgId75zzEtB7w2P/ZUEjC+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785687604; c=relaxed/simple;
	bh=N9x5LnVmbe8qJcRxpY3ixhVfrofeq0IaZW/2mcpxPDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9raErnzm0nl3uFqxEbG9EswJ+YlNM3WzIs11Q0/I6eMy5jqZcuobGIc02mI3K8wxVkQrjpMnAar8VZ2+UxuVbL2vqHWwp6tNcGrm/U5DmAa/ORsxT3dQ+spoGgu1JWWF8Ra29jaJ6OCzKZWk337wgDdZAyEnVMag2TlaKhQo+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=v4kKKzoN; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=d4de7P/X; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="v4kKKzoN";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="d4de7P/X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785687594;
	bh=N9x5LnVmbe8qJcRxpY3ixhVfrofeq0IaZW/2mcpxPDU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=v4kKKzoNQKE/BG4rY+mwoWIxni41aNirjm5llPDzlx04nYbDeXsGwN45w/1LQBDyP
	 DVo+1eQ8MVbQwakf/lfrUeV8m8ZbgQ2yD9UqgEFzd8lX1z/8AV4v5SChgncHaCIkW1
	 Qx1rI0B9lOd68aKzZd7M+HYUdpspvmepfM/WBW6z9eoUSUb/F/sps3dZ5wt6YlZjBO
	 hoO1RiRHh2sbyWTTypQud4tme55lb8lCLCyD+PJ92jIhp+iC7xdH9WCJFfc9MihaC7
	 cmsoTj59VJNiEBQZyqUqjwBQGj3D0I1cqmB0BNr3cJOnLHfebxExubSI4Fczo/Z3jZ
	 9IM3X1S3D78OQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id EB9AD49651; Sun,  2 Aug 2026 16:19:54 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785687592;
	bh=N9x5LnVmbe8qJcRxpY3ixhVfrofeq0IaZW/2mcpxPDU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d4de7P/X8LoI15GWdHbcn0BshYkVwrbli2RbQYs5/fPVN+JEvcxECAl6fkv3PwHxa
	 wd01dKrmwaJJGOqxttMijFgdiF+vnbiDqarSaVYINGg4nEdq0uigqkuQj1YbtjDZnS
	 jpoHalibLMJkhMqMGe+XOcol+BfL8Qkn59WKWE9Gpp0nusMttqxZ34i10Ewzov/gN4
	 dv2vQ0A1f3RDHI8diXXdYcVX1X2DMzJpLib7QMwtB7qb+2kaTOHx3esXGTFk1sAIGT
	 25HR3rKxR04hAqARNgU3YSc5U9xAfbDfX9zeN4+9Fv9d8i4/UaXHzuz/JOYK/RsJu7
	 cvKOu3SrgGmTQ==
Received: from [192.168.1.146] (90-227-251-202-no2480.tbcn.telia.com [90.227.251.202])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 9470B4949C;
	Sun,  2 Aug 2026 16:19:51 +0000 (UTC)
Message-ID: <f473a12c-bfae-4006-9287-040b840a6e4f@birger-koblitz.de>
Date: Sun, 2 Aug 2026 18:19:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 03/12] ax88179_178a: Add HW support for
 AX179A-based chips
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
 <20260731-ax88179a-v4-3-2cf1f71b1dd2@birger-koblitz.de>
 <3eb5691a-4a84-487e-8d5e-f91a646c03c1@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <3eb5691a-4a84-487e-8d5e-f91a646c03c1@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/07/2026 21:37, Andrew Lunn wrote:
>> +static int ax88179_mdiobus_write(struct mii_bus *bus, int phy_id, int regnum, u16 val)
>> +{
>> +	struct usbnet *dev = bus->priv;
>> +	u16 res = (u16)val;
> 
> val already is a u16, so the cast is not needed.
Will fix in v5, this was code from the original driver.

> 
>> +
>> +	return ax88179_write_cmd(dev, AX_ACCESS_PHY, phy_id, (__u16)regnum, 2, &res);
> 
> Does ax88179_write_cmd actually modify the res value? I'm just
> wondering why you need the local copy.
The local copy is not needed. This was also C&P from the original driver.
Fixed in v5.

> 
>> +static void ax88179a_get_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
>> +{
>> +	struct usbnet *dev = netdev_priv(net);
>> +	struct ax88179_data *data;
>> +
>> +	data = dev->driver_priv;
> 
> This pattern happens enough that it is worth adding a helper,
> netdev2data() or something like that.
Will introduce ntdev2data() in v5.

>> +
>> +	netdev_info(dev->net, "ax88179a - Link status is: 1, Link speed: %d, Duplex: %d\n",
>> +		    speed, duplex);
>> +}
> 
> Maybe not needed? Does phylink print something?
Removed in v5, phylink prints the same information.

> 
>> +static int ax88179a_init_mdio(struct usbnet *dev)
>> +	netdev_err(dev->net, "Registering MDIO bus\n");
> 
> Left over debug.
Removed in v5.

> 
>> +	/* Initialize MII structure */
>> +	dev->mii.dev = dev->net;
>> +	dev->mii.mdio_read = ax88179_mdio_read;
>> +	dev->mii.mdio_write = ax88179_mdio_write;
>> +	dev->mii.phy_id_mask = 0xff;
>> +	dev->mii.reg_num_mask = 0xff;
>> +	dev->mii.phy_id = AX88179_PHY_ID;
> 
> So the aim is this is removed. Do the follow up patches remove it?
Ooops, forgot to remove this. Removed in v5.

> 
>> +static int ax88179a_reset(struct usbnet *dev)
>> +	if (ax179_data->chip_version == AX_VERSION_AX88279) {
>> +		*tmp16 = ax88179_mdio_read(dev->net, dev->mii.phy_id, MII_ADVERTISE);
>> +		*tmp16 &= ~(ADVERTISE_10FULL | ADVERTISE_10HALF);
>> +		*tmp16 |= AX_ADVERTISE_2500;
>> +		ax88179_mdio_write(dev->net, dev->mii.phy_id, MII_ADVERTISE, *tmp16);
>> +	}
> 
> If the PHY driver is doing the correct thing, this is not needed.  So
> long as you tell phylink that 10Mbps is not supported by the MAC, it
> should disable the advertisement of 10Mps link modes.
Fixed in v5.

> 
>> +	ax179_data->eee_enabled = 0;
>> +	ax179_data->eee_active = 0;
> 
> Are these used anywhere? Phylink should be tracking the EEE state, not
> the MAC driver.
Removed in v5.

