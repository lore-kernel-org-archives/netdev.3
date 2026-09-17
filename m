Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFE3C345D
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 05:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789623418; cv=none; b=sjQYltY4r39WsCgp4hvx0gGIy6QlLU2jj714JgiALr69n+j49sc47/khDvK6TXqMNyINaKyyrTZPlNPkaJzDpMZPbSr9GfDVToE4SD6DsPHHxK6k5W/OjyLBmdg5/f8N/qy+SjASMhYBjC6oF4Zjbedy1ak2nYEkboATdxULiqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789623418; c=relaxed/simple;
	bh=X9SJs/sY96Vy6jNsW50HK4N4xIB89JOQo1fJdlS1z0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLFDCaStqMw9CrKJ2vA71TUWurPVbftlMshqwfBDKFFHIfbjD/7Hhi1d9AtQhcFqVBd/JEkyT5PgH2K/T/CXFqbumqQSbKIM7WhXmyM7GLidELygarOPHvY9NwWTSb8JjuRsm1tw0U7mJGN0xK25h1N9mOaTZ4yOcyEjajxnag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jeSiE7yM; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jeSiE7yM"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DD6684E40708;
	Thu, 17 Sep 2026 05:36:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A7A6D60580;
	Thu, 17 Sep 2026 05:36:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C31D511C79C1A;
	Thu, 17 Sep 2026 07:36:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789623409; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=qj8/gd1aVy2AiuqNBTIl5F66/IiKLO5YZ1ExmZ84VAY=;
	b=jeSiE7yMt2uvUGWHQv0Zmg4MMO5BDc1wX2D0i8UVpALRNwSdTbNom0dLEe9DmXdm/R8TT4
	nzjqdzcA3/KNa12KvwPJJB1CPg63gNbV22tuuZc1op+l7pP08xrNyBWM4k2FxF179fDyxO
	dybmAvGQAi/BoQsKRGjY0B7pOkulMogFLmKRxuT79UEs0LWc4UM6LdGJEvVDpJVzrFJ/Hs
	kWEmwXU38CDLBC9kKrvhho6Wa5Q1qdfhNdckBuXis1DMxYOnf2WPLFxbFulzYSisCnRnXM
	MwUr3QJ7y4ULjmm47CaBVlZ3XDK4ns7LrrHzkkJQTZTedvB4nXgExr4fepMa2Q==
Message-ID: <3bdf2ecc-9dd1-428c-8841-36b1f19916e7@bootlin.com>
Date: Thu, 17 Sep 2026 07:36:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: stmmac: qcom-ethqos: advertise supported
 SerDes interfaces
To: Thomas Karpiniec <tom.karpiniec@outlook.com>,
 Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
 Coia Prant <coiaprant@gmail.com>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Russell King <rmk+kernel@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CH3PR11MB8413FCBA598F7FABC04ADCFEE4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
 <CH3PR11MB841353E5708DDD7C5E2EA1D5E4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
 <aqqI9wOnradk9d7K@oss.qualcomm.com>
 <97924d2f-45f9-44d5-b482-97fcbb70abdc@bootlin.com>
 <CH3PR11MB8413131D50175690DF9FDAB0E4B82@CH3PR11MB8413.namprd11.prod.outlook.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <CH3PR11MB8413131D50175690DF9FDAB0E4B82@CH3PR11MB8413.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Thomas,

+Coia

On 9/17/26 06:29, Thomas Karpiniec wrote:

>> Can you test settung the STMMAC_FLAG_SERDES_SUPPORTS_2500M flag in
>> dwmac-qcom-ethqos ?
> 
> I can confirm that dma_cap.pcs = Y.

Thanks for looking up :) This is a good start

> 
> I tested setting STMMAC_FLAG_SERDES_SUPPORTS_2500M on hardware and unfortunately the flag alone doesn't solve the problem.

Yeah, but it's still the right first move. Russell planned to do that as well :

https://lore.kernel.org/netdev/E1vvDJi-0000000ArhH-3ipf@rmk-PC.armlinux.org.uk/#t

> 
> I think there are a couple of things missing. stmmac_phylink_setup doesn't use the integrated PCS bitmap to populate config->supported_interfaces, so SGMII is still not advertised to phylink as a usable host interface. Also stmmac_integrated_pcs_init is adding 1000BASE-X unconditionally, which wouldn't be appropriate here.

Ok so, the missing bit seems to be that priv->integrated_pcs isn't taken
into account in stmmac_phylink_setup(). This needs to be added then :)

Looks like there's also the inband support that needs addressing, that was
part of his RFC here :

https://lore.kernel.org/netdev/E1vvDJi-0000000ArhH-3ipf@rmk-PC.armlinux.org.uk/#t

> I did a proof-of-concept fixing those things and the end result looks a little messy: config->supported_interfaces could come from either get_interfaces _or_ the integrated PCS with unclear (to me) responsibility.

There's only dwmac-intel, dwmac-spacemit and dwmac-rk that use the
.get_interfaces() API. Let me add Coia in CC, as they're working
on better PCS support specifically for Rockchip :

https://lore.kernel.org/netdev/20260915123802.1561724-1-coiaprant@gmail.com/

For spacemit, looks like it's not really a problem as there's no PCS
involved. For intel though, heh... Intel platforms with dwmac AND PCS
are hard to come by, but I think at that point let's roll with the
bitwise or'int of get_interfaces + pcs interfaces.

> This POC did show that STMMAC_FLAG_SERDES_SUPPORTS_2500M enabled phylink to configure the integrated PCS for 2500BASE-X and a 2.5 Gbps link came up with no apparent issues.

Maybe the blind spot is inband aneg. Mohd, you were quite involved in
this, do you remember where we stand on that front ?

Thanks,

Maxime


