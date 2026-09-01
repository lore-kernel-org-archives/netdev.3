Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A303B71C6
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246281; cv=none; b=uNEEznhAhBU+734aT+aEfgOn1zhyp0e4J6E3Ze37qRhHpUUm9HbhdbakVy8J+wDn03DODxRe4uSb6SmGW6fMERxvIvlSk6jpqTAQRu1yYmFcZn48bG6e23VDNgYY4QhWhp20zTqQRcM0bW5IoSiNu2vRw1wFTRcYrTakjeb98js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246281; c=relaxed/simple;
	bh=ChPkXBUseSQt3aK5/dAI0LBUjP5UIU7ikF5efk8xQ4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPUUTIpUMNxvR4YEabFkZKk9Zmr7dLYWHA8cNk67w8nx/dyOB6Jjg0mZvYCP7p1uTGRX7Y7Ufk8j6RvNy+R6PShaQbFVVOYXBtw+oyLycYOyExkjjrcOzaMTCTj7NKaXxG1WUxjEv3hZlVoyWBBIYdMmcHZgMdD6+MOH6bQQbdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=v206OMzf; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="v206OMzf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 890611A192B;
	Tue,  1 Sep 2026 07:04:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 59C716053C;
	Tue,  1 Sep 2026 07:04:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E6C111C791BE;
	Tue,  1 Sep 2026 09:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788246276; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zaM3jU4o2eLseJzaumSG3mU1xqoFMK4JnncFkSoW6BI=;
	b=v206OMzfYeQ7xEHxKAWOM1ctyzoIUou2/+W0y+dVbL+M4SfijKa5BWrW5WGJcxzHoaVz39
	k+WxEg+Vnf+EXsGS5ZZ7VvMw9Xkvehp9TX99d7CtRe9R6MEs7JhKV1zra/xiVSI9Csayzg
	jEZ4yUc4LqjQKg/1OxUmkHgT8heQODdZNCmZTNqrjbxjjqqZnNsPbGmnqY1qJ/VnPBoaG7
	ESyG1Y0VE7IzJqe5wU0GQJbVlj1Lkax1N6aYWzj1Mc2MZJAakiKN0EIWsIUs28d8p0thTb
	cOJnslXFyvqZVsOko5wI3mq7ATuumHBbXyKcqscJzQA2qoFNer7EE0i7OI9hDQ==
Message-ID: <b677535a-5395-4703-aa08-a71a6b26ccb6@bootlin.com>
Date: Tue, 1 Sep 2026 09:04:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: stmmac: dwmac4: Read the UC filter size
 from hardware capabilities
To: Andrew Lunn <andrew@lunn.ch>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 thomas.petazzoni@bootlin.com, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
 <20260831070121.349778-2-maxime.chevallier@bootlin.com>
 <2631c832d5aebc56e152628132494545@tipi-net.de>
 <480f15e2-e045-46b7-89af-1fbcefd3c4eb@bootlin.com>
 <b2fbcec7-90ee-4a6f-bd15-32e4e1ff1a47@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <b2fbcec7-90ee-4a6f-bd15-32e4e1ff1a47@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/1/26 02:26, Andrew Lunn wrote:
>> Yeah but dwmac4 has a hash filter, but same as the UC filter it's just not plumbed
>> in :/
>>
>> Let's leave this flag here, hash filter addition for MC filtering is coming-up, so let's not
>> drop it now only to re-enable it after, one of the other wonderful discoveries found by
>> running the selftests...
> 
> I assume you can put a MC address in a perfect match filter? You can
> perfectly match a multicast address just as well as a unicast address.
> 
> The hash filter is less accurate, but again can be used to match a
> unicast or multicast address, and then you need additional filtering
> in software, which Linux will do.
> 
> So it seems to me, you should use a perfect match filters if you have
> one available, independent of unicast or multicast, and only use a
> hash filter if you have run out of perfect match filters.

That's an interesting point. The HW supports that, we have 3 control knobs
for that in the MAC_PACKET_FILTER register :

 - HPF (bit 10) : Use Hash or Perfect Match for filtering.
                  0 : Match UC and MC against hash filter
                  1 : Match UC and MC according to HMC and HUC

 - HMC (bit 2) : Use Hash or Perfect Match for MC filtering
                 0 : Match MC against perfect filter
                 1 : Match MC against Hash table

 - HUC (bit 1) : Use Hash of PF for UC filtering
                 0 : Match UC against PF
                 1 : Match UC against Hash table

I don't know though how this all interacts with the primary MAC address. We
always have one entry in PF for the device's own MAC address, we should
probably always perfect match that one.

But as the UC Perfect Filter toggle is global for All UC addresses it means
we're stuck with perfect filter for all UC then ?

For MC, this is a good point, but I'm worried about the complexity vs gain.

If we consider the 4 dwmac boards I have (may not be a very representative sample),
we have :

 - imx8mp   : 64 PF (Perfect Fitler) entries
 - jh7110   : 9 PF entries
 - stm32mp1 : 4 PF entries
 - yt6801   : 1 PF entry

On a simple setup, between the IPv4 and IPv6 multicast, we very easily have at
least 3 multicast addresses assigned to our interface when it's brought up :

# ip maddr show eth0
2:      eth0
        link  33:33:00:00:00:01
        link  01:00:5e:00:00:01
        link  33:33:ff:00:af:d7
[...]

So on STM32MP1 this is already enough to fill the perfect fitler, any addition
trips either the promisc logic, or a more complex logic to re-split UC and MC into
Hash and Perfect filters separately

On YT8601, 1 PF entry, all MC to Hash, and any additional UC trips the UC-promisc mode.

I think in a typical setup, the UC table has more chance of getting filled than the hash
table, so a simpler option could be :

 - Always use hash for MC
 - Use perfect match for UC when possible
 - If perfect filter is full, use Hash for UC and MC matching, with
the idea that hash is still better than going UC-promisc ?

Maxime
