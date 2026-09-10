Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CBF339705;
	Thu, 10 Sep 2026 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023729; cv=none; b=Cd1oSDGxnBYwKjFMcfS7TBKgMQjCp4yT3BJ41uni8ecXYHex0FNxBjr56+IygQYkOD/G8anRtvIFo7MJNVsPrbkvKeCjkzDlsRHdz1+Zr0M23tSU1xJpSCK/UDuhXK/6275EeVZpXvbzhrpL9Urr9q9zA1olqFIMCVJmMgQCmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023729; c=relaxed/simple;
	bh=j4vKVPvnsOsBQU/VrqbLlTk0VbnewQj8PhyL9juhic8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVqWZ6EIM/8watDsD0Hd4kP1ky66V1xE309G6Fu00Yb17hfLgUZeWP3/2Mhbm99QOg/Tbsqfgbil4OjJCnSFcKyn5vz6Ip+1ggZ16FwqtMpwNm/lF5jkI8qtBnR/mEr4gQNbZPeF+me2JgC3IvVkGScIB/uoROh/YCbVhE8B8b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=HkcLTc9P; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="HkcLTc9P"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F0D140002A;
	Thu, 10 Sep 2026 09:01:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789023721; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=vJp4rYGfCyVBSJ4qRp4Dvdioa41fPP8ClB9wWTWCzjw=;
	b=HkcLTc9Pv7shqY6xnM1fnVqUKoJ5NSzhnAZHVtmRA8vJ5pSbMF34oxJL340E7LmN64xgyx
	HK8PueNvZEw2Dkr9O6sMYuLf5L4qryshGLuJo0maVUyl4rP4S4Yt4OV9XzOYHXZ6oqTm4/
	qB8ALVLDe27vfHr8pK05B3/rjUaqhaTGSV7ndSjLm6j1pEQqBB+Ii9ChgwPHOW3t1OmDo5
	nCkCPsG5f7ZbMiuBe142X7UoTa4KH7jPCOncSP3vZiskGNez5XMUnKCnOeCg5ujhlcAfOQ
	EB0/i8fHXKXbBPQLOy2U0d15S152FntkJMeQ3jWspQ2MVCbd4SYJXXKCFObKMg==
Message-ID: <34c4739b-1d10-4bf9-b8b9-c09e023908b8@cjdns.fr>
Date: Thu, 10 Sep 2026 09:01:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, dqfext@gmail.com,
 SkyLake.Huang@mediatek.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
References: <20260909213250.3184238-1-cjd@cjdns.fr>
 <746ebc26-e4ad-4988-a839-c5805d7ab319@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <746ebc26-e4ad-4988-a839-c5805d7ab319@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 10/09/2026 04:03, Andrew Lunn wrote:
>> +	/* Clause 22 local data. */
>> +	ret = phy_write(phydev, MII_CTRL1000, 0x1e00);
> Please express this using
>
> /* 1000BASE-T Control register */
> #define ADVERTISE_1000FULL	0x0200  /* Advertise 1000BASE-T full duplex */
> #define ADVERTISE_1000HALF	0x0100  /* Advertise 1000BASE-T half duplex */
> #define CTL1000_PREFER_MASTER	0x0400  /* prefer to operate as master */
> #define CTL1000_AS_MASTER	0x0800
> #define CTL1000_ENABLE_MASTER	0x1000
>
> Once we have symbolic names, it might be obvious what this is doing,
> and if there is a better way to do it.
>
>
>> +	/* Vendor profile disables 100/1000BASE-T EEE advertisement. */
>> +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x003c, 0x0000);
>> +	if (ret < 0)
>> +		return ret;
> Any idea why? Is EEE broken? If it is, phy_disable_eee().


I am so sorry, we had this entire conversation about the other PHY and I 
did not check carefully enough that this one is doing the same thing. I 
will test and submit the same solution we arrived at over there.


Thanks,

Caleb


>
>      Andrew
