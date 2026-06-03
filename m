Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F0C410D06
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476758; cv=none; b=Oz3LaxH01pnzYEP7Nt+gfKyi02/ff3w+GEV0pILs6UztYIOaOk1dyTMrHug3zNwfRqbbM0qpGunxMP6r9bRDtMZX2BiE4TVJNIJmF59mUI4Vjt/2UtvEr6UhK8G+PkEY5MyhanlXZuHK5l0PtPN8jzoHwlKq5Vvun+ydw4TIr6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476758; c=relaxed/simple;
	bh=RE/Zj/t1+FMfjYA6bjL+XT3fbStNtIs5GkWX+6ztI5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyFTqP4tWSK7qzCIOQbEgDFKiJDVPY64AAqCDK5koxBbEH2mQZ8JMCC/NMk/F0rdpqnJptQ9SIIhoVYeV7my0rTw2jiRB0YZJY/qdrJE9sx5Nc1reyC9SGkWAjOoJM3I7iYEC6OFGPEsaNBikmQNnVwBhcXydDHV4APL7B3Jv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZnUwckA+; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZnUwckA+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 12FB2C62216;
	Wed,  3 Jun 2026 08:52:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 151165FD24;
	Wed,  3 Jun 2026 08:52:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3192B10888413;
	Wed,  3 Jun 2026 10:52:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780476748; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=eo9kA44gQ5MhrhekfzyB7OX6oHlcxve3kXco3iA6of0=;
	b=ZnUwckA+4fxBjqzbpxuqsMeuo1F52eOviKl7tIgnLfY9Ta+zfKHw7du2+6Pd2WfwdCYGoi
	n5916bNva3nEBF7pelb/mnyZN4XlEttrczAHsXklPJD7M0mG5WPTW8mssc48xQo7X7hYr3
	7HhfiYixNFPtqbQxcH3P+1z+vmng6mL7wfOa2Uw2O7uKQ39PlDPRMOEkHXAs9SnkdzLCi7
	eqfFrbI1XJ8yaTTj68/nX2XoUvJEe+byIN5xRcSUoKVQvXSIdahEw2sNLOIb2geeZJUBhK
	PgD2wuvAH/qlQ8fEYUPqPjRZIekBnFOtJB8xwbLjG6tsFzITBf3OIXXQMofaEA==
Message-ID: <0bc2ae0e-316c-447e-9098-f18f4b491328@bootlin.com>
Date: Wed, 3 Jun 2026 10:52:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/5] net: phy: realtek: add support for dummy
 phy
To: Javen <javen_xu@realsil.com.cn>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260603065916.334-1-javen_xu@realsil.com.cn>
 <20260603065916.334-2-javen_xu@realsil.com.cn>
 <7496c873-fee7-4584-ad70-4315d7b94f8f@bootlin.com>
 <f614a60942e34bf39b1d49fb273221ab@realsil.com.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <f614a60942e34bf39b1d49fb273221ab@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 6/3/26 10:00, Javen wrote:
>> On 6/3/26 08:59, javen wrote:
>>> From: Javen Xu <javen_xu@realsil.com.cn>
>>>
>>> Add support for rtl8116af dummy phy driver, match phy id and read link
>>> speed from MII_BMCR.
>>>
>>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>>
>> Can you elaborate more on why this is needed ?
>>
>> The cover says :
>> "
>> In this mode, the driver
>> needs a dummy PHY ID so that phylib can attach to a dummy Realtek PHY
>> driver, while selected standard PHY registers are handled through the SerDes
>> register.
>> "
>>
>> Why can't you use the SerDes registers for your PHY driver ? The phrase above
>> suggests that the "SerDes registers" have the typical C22/45 layout. There are
>> PHYs and PCSs out there that aren't accessed through regular MDIO with
>> regmap being used to translate the mdio accesses done by phylib into the
>> actual register access method used.
>>
>> Maxime
>>
> 
> Thanks for your review.
> Maybe I shouldn't call it a "dummy" PHY. It is actually a real, dedicated PHY driver for the RTL8116af operating in Fiber/SerDes mode. The reason we cannot use the standard generic PHY driver is that hardware does not correctly populate the standard Gigabit Status Register (MII_STAT1000, Reg 0x0a). 
> Here is a snippet of our MDIO read trace during link up:
> r8169 0000:85:00.1: MDIO read: tp->ocp_base=0xa400, reg=0x0a, value=0x0000
> r8169 0000:85:00.1: MDIO read: tp->ocp_base=0xa400, reg=0x05, value=0x41a0
> Reg 0x0a returns 0x0000, the phylib generic status parser fails to resolve the 1000Mbps link, causing the driver to incorrectly fall back to a forced 10Mbps, even though the physical link is actually UP at 1000Mbps. Therefore, we need to register a custom PHY driver to provide a specific .read_status callback that parses MII_BMCR instead of relying on MII_STAT1000.

This behaviour of not getting proper information through the standard
register happens on multiple different PHYs, so having a dedicated driver
is the way to go indeed.

What does this PHY do exactly, does it connect to an SFP cage as the name
seems to imply ? If so, what kind of mode can it support ? 1000BaseX/100BaseX,
maybe SGMII as well ?

What I don't quite understand then is why you have the need to return a
custom PHY ID that matches that "dummy" driver, in the next patch.

If this is a regular PHY with C22 registers, what's the original content of
PHYSID1/2 ? M

Can you explain what the hardware looks like exactly ? What are the different
components involved, etc ?

Maxime

