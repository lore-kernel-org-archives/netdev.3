Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340FB349CCE
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255933; cv=none; b=JmUUfyYRcyccpNnZgcOjrIcBWQGOxtK69kknq4TvXQ7D22MXmA+Y3/J2VTNyuF5chCWE+hAXmPxj/ceBskb8LY+xKGWNZMW2rlbReg/rr7FsGr2wUzNDskaxk6kJY239wCj3jUHJIa1iFH7iU/AMpxh28L7RFHVrEdGtKbuhEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255933; c=relaxed/simple;
	bh=oyGTzbvxCuDvDM9+RpRvGN2hgWc851MaYea+ROmjQu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8awOsDpnSa2KJRDhmIVpFYXa6jDQHB2wnrwHDaYNlYuFwQf8jYiwuQf6+dL1oNyqplxBAdU/2AMnmsPPTg16eHII5b92otOV9DZDBsYV11WQO73gNZPbIeEkDgQvujPihcGrtGwpMHFW0m6aw0CnSzJ+ECEy+kAgjpWh+sCfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P2QyEbmL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P2QyEbmL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 843EF1A38DB;
	Fri, 12 Jun 2026 09:18:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 559F360012;
	Fri, 12 Jun 2026 09:18:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 857C6106C861E;
	Fri, 12 Jun 2026 11:18:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781255927; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=vVYoRcRdHxRy0+qoqV9cENhNZgpBYA4mJS7LJ6zHJ04=;
	b=P2QyEbmLEDJ31fZN40dey2srYbY5Fft7BVlu63MAiagOi8sQkFTxwK82uIaIfuWMIzMInS
	+oiNylmb8knPGBWoaBZYcdArffIcdempQtQ6CWlTZYJ6mC6MTroQ7SwWI9ZX+koOpw0g9R
	EH6A8TziPCtdhcFbyaZ0aOvWxBLwZOdZ4CL+HmT3WpXuhV/9RWouPKmEn2XcSV7ZPIo81w
	m+2VJUkDBuIzmYOs4YZMGCVe3RSmtm1E+LP0DyMhWwhCFqn2Y0QArQ4ZkG17uAzXCxeTdv
	Rsn45r+aSLes++jhke3W3H1DJ7Gw9sXYSH5B3yfimnSGIANhfYCt8L0jkLXNjA==
Message-ID: <c32f7996-a67b-452c-8ebd-d9e348f279c0@bootlin.com>
Date: Fri, 12 Jun 2026 11:18:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 09/10] net: dsa: microchip: implement
 lan937x-specific MDIO registration
To: Paolo Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
 <20260608-clean-ksz-3rd-v2-9-6e61b7be23c4@bootlin.com>
 <01b8171c-f684-4525-8f98-2d41c9b62f80@redhat.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <01b8171c-f684-4525-8f98-2d41c9b62f80@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Paolo,

On 6/11/26 12:54 PM, Paolo Abeni wrote:
> On 6/8/26 4:10 PM, Bastien Curutchet (Schneider Electric) wrote:
>> All the switches use a common mdio_register() function that uses two
>> ksz_dev_ops callbacks (.mdio_bus_preinit() and .create_phy_addr_map())
>> to handle the lan937x specific case. These two callbacks are used only
>> at this place in the code.
>>
>> Implement a new lan937x-specific MDIO registration functions that uses
>> these two lan937x-specific functions. The lan937x bindings don't
>> have any 'interrupts' property so this lan937x_mdio_register() doesn't
>> call ksz_irq_phy_setup().
> 
> Sashiko noted that ksz_irq_phy_setup() manually populate the mii_bus irq
> array by mapping the switch's internal port IRQs (PORT_SRC_PHY_INT)
> rather than relying on the device tree and stripping ksz_irq_phy_setup()
> may lead to regressions.
> 
> Is that a false positive?

Yes it is to me. ksz_irq_phy_setup() is currently gated by (dev->irq > 
0) which can't be true if no interrupt property is present in the 
device-tree.

> 
> Please note that to help processing the series, you should comment
> proactively on the AI reviews finding.
> 
Ok, I didn't know that, I'll do it from now on.


Best regards,
Bastien
