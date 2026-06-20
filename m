Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3550F40D572
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974027; cv=none; b=B0Xmx6NHInqaAfuEcj6hfMzW4bUIkBVVKcjDIc9Ek5aKFTMOGHJgfnve/3dIY21WwArzy+PMoZSAZaE0aLzco1tGn85HtqAfUVsHEYcXp+MYBAd5ub/bh7YV65dq2wrcS2i42bW8BxqMfBZkPJ7xdGNTAMVFS+2J54x0LneTwa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974027; c=relaxed/simple;
	bh=aFyWZi2dKu6cvjl+E5odo5qsgqgg8s2uxogxRIwv2cA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Ly1ULwkXDNCN6q5tz/RzWuSP+fEonqEe1ySC2SkrtNaKWsC2zv0zVbG8zsxyv7IZhyW5NICpfm0tU6grJv4bJi/yL2DHQmTX2SaifXDNEb5pyqY25eB7zrKfxuoooRmoRiJbO1S3VtsZ/yJ0+p4I+2jW+NNMOjQFPBsDAN8s6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=SzjJiMv0; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="SzjJiMv0"
Received: (wp-smtpd smtp.wp.pl 27456 invoked from network); 20 Jun 2026 18:46:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1781974016; bh=qMx0FL/YpV3Az0EBLtKhgozxWeMOUI884WPwMme0NEY=;
          h=From:Subject:To;
          b=SzjJiMv0kjhYW7c/uVkX/5Bi2sFnH0ycWnKoi89o7fh+ilza4hNNDPMJuuyQ2KJ2z
           ErvdsIsupKR0XIkUCZ29GtTmQz/OdyZ2cvGYnQzNXx+RjHFQs4Jent/7GwL8r4Kuct
           8gTH/Pd75o+6/GuEPhyNpGUXTv/6fSFzoR7ggxd3snMcAeOELirKf/tLcG/CLvd4fj
           W0V3qHX7/LjWUUtfjVRcOHaqnQFZMrG5NGdp5t7nOvZFhGOE4VVDpT1LoA7pa3Nh1w
           4fjvm+TCBZOjLpSxrCeJODQyWiWKVgJe0S4LkOIiEICptv9En4EbD7r4ks1s5I9Fp8
           S0dsKAC1neq+A==
Received: from 83.5.151.132.ipv4.supernova.orange.pl (HELO [192.168.3.224]) (olek2@wp.pl@[83.5.151.132])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <maxime.chevallier@bootlin.com>; 20 Jun 2026 18:46:56 +0200
Message-ID: <3b8ab7cf-fd09-400b-9115-a3985f765721@wp.pl>
Date: Sat, 20 Jun 2026 18:46:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: Re: [PATCH net] net: phylink: print correct c45 phy id when missing
 PHY driver
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, linux@armlinux.org.uk,
 andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk, vladimir.oltean@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260620131130.949298-1-olek2@wp.pl>
 <54769f58-ac83-4c5b-bd0d-3c0e83c1ab31@bootlin.com>
Content-Language: pl, en-GB
In-Reply-To: <54769f58-ac83-4c5b-bd0d-3c0e83c1ab31@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: 4a8b124b42a393db66d0c848a51194c2
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000002 [UdFM]                               

Hi Maxime,

>> --- a/drivers/net/phy/phylink.c
>> +++ b/drivers/net/phy/phylink.c
>> @@ -3917,13 +3917,30 @@ static void phylink_sfp_link_up(void *upstream)
>>   	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_LINK);
>>   }
>>   
>> +static u32 phylink_get_phy_id(struct phy_device *phy)
>> +{
>> +	if (phy->is_c45) {
>> +		const int num_ids = ARRAY_SIZE(phy->c45_ids.device_ids);
>> +		int i;
>> +
>> +		for (i = 1; i < num_ids; i++) {
>> +			if (phy->c45_ids.mmds_present & BIT(i))
>> +				return (phy->c45_ids.device_ids[i]);
>> +		}
>> +
>> +		return 0;
>> +	} else {
>> +		return phy->phy_id;
>> +	}
>> +}
> The function name is misleading, you don't really get the id, you get either
> the c22 id or the first non-zero C45 id.
Indeed. I think that all MMD C45 should have the same ID. Can you suggest a
better function name? :)
>
>> +
>>   static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
>>   {
>>   	struct phylink *pl = upstream;
>>   
>>   	if (!phy->drv) {
>> -		phylink_err(pl, "PHY %s (id 0x%.8lx) has no driver loaded\n",
>> -			    phydev_name(phy), (unsigned long)phy->phy_id);
>> +		phylink_err(pl, "PHY %s (id 0x%.8x) has no driver loaded\n",
> Why change the printk format from 0x%.8lx to 0x%.8x ?
I followed the printk format. For u32, it should be %x instead of %lx.
Should I keep 0x%.8lx?
>> +			    phydev_name(phy), phylink_get_phy_id(phy));
>>   		phylink_err(pl, "Drivers which handle known common cases: CONFIG_BCM84881_PHY, CONFIG_MARVELL_PHY\n");
>>   		return -EINVAL;
>>   	}
> After reading all that, I'm actually not really convinced the overall patch
> is the best approach. It's a lot of logic for a very niche case. This is really for
> debug purposes, so why not instead print either the phy_id for a C22 PHY, or
> just "C45 PHY" and no id at all for C45 ? This removes the confusion about the
> id being 0, while still being cleat that the user needs to figure-out what's
> going on with their module...
The world of 10Gbase-T SFP+ modules is quite messy. SFP modules with the 
same
part number use different PHYs (for example, an OEM SFP-10G-T might 
internally
use Aquantia AQC113C, Marvell CUX3610, Realtek RTL8211BE, RTL8261C...).
I think the PHY ID is very useful information here. It gives an idea 
which driver
package needs to be installed in the case of OpenWRT. Sometimes it also 
indicates
that a new chip doesn't have a driver in the kernel yet.


Best regarads,
Aleksander


