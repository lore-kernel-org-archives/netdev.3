Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3CE3AE1A8
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587415; cv=none; b=bbs3rQtns8haz2SCl2niy0we1hT5GCoctlrlpv7chOc+zl9UKz8MEoJpnk6Vle6Ui04hp1b+FJij7eZ7zxefIMfRyUeWE2s1Euhz6HLuWi1I8Kj3YuzyM207c7Z/BcEjjhHCtLpgj+YLqEnocoIj3VSgIUozdFL/+UHG99RIUfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587415; c=relaxed/simple;
	bh=IemwttiSfgPPxYwhFfp0gmZ2By0onCl2QpRrL+1tyKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n62kiIKwwX6DHHRWmkseccqRm6QPV/6hO1ArQ55HrWZZjX9Fmf1GLvgQyQc//kNPIDHUC7Rt8ZjH2oSTsr5gAsV7CnUG26KVz/jBijEHDL6SS7I1cownE1k8aOoSfsjlIshleFfNr4Mub4n7A7wyKylNuwEG4OwpYC8sOxQqXPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SUQKKxra; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SUQKKxra"
Message-ID: <d4f606b9-d793-47c1-8c91-9c9da0e68b4a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784587401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEuvx0xqS6jOAxGHGjS56fzxNVbE0qKpn7aKV9qmCb8=;
	b=SUQKKxradGvzXTciYS8KMcmj+8F1RFfKbN4vzzvDpEPma1ytvrnkD1kxVr906ocCwWJvAT
	CTuWSgq0nIwkQd8XFRKzPTC4hQsx/hykf13Yg633SX0O4t2pp0S884c0I8idfTQEan3PLJ
	GjCSRA2/XFh5jxBE/uiJZzoXBxZet6M=
Date: Mon, 20 Jul 2026 23:43:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: stmmac: Simplify ioctl handling
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260718143848.677531-1-maxime.chevallier@bootlin.com>
 <ae82997f-537e-4a2d-abce-d163fcf9d868@lunn.ch>
 <6ac12388-60de-45aa-a8d0-62fcfaf7bea2@linux.dev>
 <1e640dcb-43ce-4a3b-a74a-ed8e48706b86@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <1e640dcb-43ce-4a3b-a74a-ed8e48706b86@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20.07.2026 19:12, Andrew Lunn wrote:
> On Mon, Jul 20, 2026 at 04:17:32PM +0100, Vadim Fedorenko wrote:
>> On 19.07.2026 17:13, Andrew Lunn wrote:
>>>> Looking at this, I'm wondering if we can't just get rid of SIOCSHWTSTAMP
>>>> handling in phy_mii_ioctl(). Looks like we can ?
>>>
>>> I'm not sure about that. We need Richards input.
>>>
>>> The code in phy_mii_ioctl() allows the MAC to be bypassed, it goes
>>> straight to a PHY based stamper. It could be the MAC has no idea the
>>> PHY has this capability, so it has not implemented the .ndo?
>>>
>>> It might be we need to hoist the code from phy_mii_ioctl() into
>>> dev_{sg}et_hwtstamp()?
>>
>> Hi Andrew!
>>
>> I think I've converted all phy drivers while removing support for
>> SIOCSHWTSTAMP/SIOCGHWTSTAMP from netdev ioctl. I believe it's impossible right
>> now to reach SIOCSHWTSTAMP path of phy_mii_ioctl via ioctl on net device.
> 
> Lets look at this, using a random example:
> 
> drivers/net/ethernet/marvell/mv643xx_eth.c
> 
> mv643xx_eth_netdev_ops has nothing about time stamping. However it
> does have a mv643xx_eth_ioctl. Which calls phy_mii_ioctl().
> 
> Lets say this Marvell MAC driver was paired with a
> nxp-c45-tja11xx. nxp_c45_probe() does:
> 
>                  priv->mii_ts.rxtstamp = nxp_c45_rxtstamp;
>                  priv->mii_ts.txtstamp = nxp_c45_txtstamp;
>                  priv->mii_ts.hwtstamp_set = nxp_c45_hwtstamp_set;
>                  priv->mii_ts.hwtstamp_get = nxp_c45_hwtstamp_get;
>                  priv->mii_ts.ts_info = nxp_c45_ts_info;
>                  phydev->mii_ts = &priv->mii_ts;
> 
> So it looks like in phy_mii_ioctl(), the conditions:
> 
>         case SIOCSHWTSTAMP:
>                  if (phydev->mii_ts && phydev->mii_ts->hwtstamp_set) {
> 
> are fulfilled, and
> 
>                          ret = phydev->mii_ts->hwtstamp_set(phydev->mii_ts,
>                                                             &kernel_cfg,
>                                                             &extack);
> 
> will happen.
> 
> Now, this combination of MAC and PHY is very unlikely but it proves
> the point. As far as i remember, Richard added this code for the
> dp83640 PHY device, but i don't remember what MAC driver it was paired
> with. He wanted to make PHY support just work without the MAC driver
> even caring.

looks like it won't work now. we have to create helpers in phy to fix it.
I can work on it, but I don't have such HW combination to test. Do you have some 
HW to test this combination?


> 
> 	Andrew

