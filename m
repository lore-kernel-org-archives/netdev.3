Received: from srv4.3e8.eu (srv4.3e8.eu [193.25.101.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4964639E176;
	Tue, 22 Sep 2026 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.25.101.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106309; cv=none; b=MCFQwg6dUfiPFBRXlNu0Z46y4aNChxXu1BHlGpPAIhyoaLbAjWYdGL9/CUpzytncL53V/SNOUcxBP4MMDGvYwu0EE/CCx3VmmyLl+8+5vpHX3KabObVxxogB6T88TrWAcurW+5tblV83m6FrAgEl8jDMZmJmJxSl6lfmRfQnxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106309; c=relaxed/simple;
	bh=amjUuW11TXlXcQs76chCSTMMtF2XLzVokCf9805Firk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZOsMW1ET8jmPp4xKPVvpmNAXIy2UPO7uahuniNnuOQmyGel1C1VyKlMQ6kPCT7GsvSl3+2kcQdXOzgMRbztSIjyab/p/pEuBlUSazyY1zangEvtz1i14EQRQLmY+2lX4iozOH6oB/Ghkl/3JhUNwP5nk0xzVBoGwzyiWZpIsXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=3e8.eu; spf=pass smtp.mailfrom=3e8.eu; dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b=SIZzvSqN; arc=none smtp.client-ip=193.25.101.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=3e8.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3e8.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b="SIZzvSqN"
Received: from [IPV6:2003:ed:4708:38a0:7b81:aa82:3807:35d8] (p200300ed470838a07b81aa82380735d8.dip0.t-ipconnect.de [IPv6:2003:ed:4708:38a0:7b81:aa82:3807:35d8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by srv4.3e8.eu (Postfix) with ESMTPSA id A463D40186;
	Tue, 22 Sep 2026 21:34:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu; s=mail20211217;
	t=1790105657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BX3tsb1tiibcYdDIrOEQh5SGHk/9ncFiStVH+AnGUsA=;
	b=SIZzvSqNQK/QHD6CGs3GBjBnhbQmFBIfK3nhOEuYZ4ddKqaKK0J/8/rfVmvLcBmTKt/JX/
	6VelFgdzZ2u2qkulSq+fc6a3way0tyximYcX9Zyw4kwbJoK7/Grl6fx4YQJTEmdQNN4bm5
	pBXw6Rww4DPhTE6ymnmfO7cc/yWiQAc+DjOcwRf1fkX9rSBowz2X4eO3jpKgRIZWEBPRo7
	kXAESt72nFQX4dprgOy6gv7jka6lB7sg2ipWmsNqeZOWoNLa+mWv5zhoBXCRlCk+AGfhoK
	J9s5dBgRg5EZk7fRdsTJ0P34fYyzqWW73HvzBeXgtUMTBByiYrA2DLCwhoA1EA==
Message-ID: <64e712bb-4c2a-4738-9f99-7c8496e2d4d9@3e8.eu>
Date: Tue, 22 Sep 2026 21:34:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: sfp: add quirk for XikeStor SKT-2.5G-100M
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260920192632.72729-2-jan@3e8.eu>
 <b4a42595-295e-456b-82a0-91076f72407d@lunn.ch>
From: Jan Hoffmann <jan@3e8.eu>
Autocrypt: addr=jan@3e8.eu; keydata=
 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
 AqNjQxfojjo=
In-Reply-To: <b4a42595-295e-456b-82a0-91076f72407d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,
>> Note: The RTL8221B PHY in this module becomes stuck in a broken state
>> after attempting to read some registers on MMD 30 while it has already
>> established a link (this is a general issue with this PHY which happens
>> when it is configured for rate adaptation mode).
> 
> This sounds like something which should be fixed in the PHY
> driver. Can you take a look at that. Is there an errata for it with a
> suggested workaround?

Unfortunately, the read access which can break the PHY happens already 
in "get_phy_c45_ids", i.e. before the PHY driver is attached (and this 
is the only place where such a read access occurs).


I am not sure if there is any errata or official documentation about 
this issue.

What I do know is based on experimentation with mdio-tools (with some 
clues from existing driver code):

If bit 0 of register 0x75f3 on MMD 30 is set, reading any register on 
MMD 30 except for the actual SerDes registers (and also registers 5/6) 
breaks the PHY. In the broken state, all registers on MMD 30 (as well as 
registers 5/6 on all other MMDs) only read "0xdead". To make the PHY 
work again properly, a hardware reset is necessary.

When the PHY is configured to use either 2500Base-X with rate matching 
or HiSGMII only, it sets this bit as soon as a link is established. The 
PHY doesn't set this bit when 2500Base-X+SGMII or HiSGMII+SGMII mode is 
configured (i.e. dynamic switching depending on link speed).

(The driver unsets this bit when configuring the interface mode in 
"rtl822x_set_serdes_option_mode". Otherwise I probably would have never 
found the relation of that register to the issue.)


Some devices are unaffected by this issue, for example if the bootloader 
already configures the PHY to use 2500Base-X+SGMII or HiSGMII+SGMII (or 
at least can be made to do so).

Since the PHY takes about 4 seconds after hardware reset to establish a 
link, any devices where the kernel can do a reset are also not affected 
(like this SFP module, as long as the host supports TX_DISABLE).


I would really like to have a general fix for cases where neither of 
these two workarounds happen to already be in place. But I'm not sure 
how this could be done cleanly, as it requires special handling for 
these PHYs in the function that reads the PHY ID (or even before that).

Downstream in OpenWrt, I added a patch for "get_phy_c45_ids" to avoid 
reading MMD 30 from RTL8221B PHYs based on the PHY ID in MMD 1:

https://github.com/openwrt/openwrt/commit/88dcd8c303b688b344c8f22c24df6a49f6b6b707

But hardcoding it like this in the kernel core feels more like a hack 
than a solution.

One idea I had is if it would be possible to make "get_phy_c45_ids" 
change its behaviour based on a device tree property or a SFP quirk.

>> Signed-off-by: Jan Hoffmann <jan@3e8.eu>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>      Andrew

Thanks,
Jan
