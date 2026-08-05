Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9B5471CFB;
	Wed,  5 Aug 2026 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937392; cv=none; b=q3CXV39zjjhF8zEFrpTeUOq94eDiouv6WNAvkw1lsF4Q/AJNYcx7GJm5TCAhIfkS3LIq+V95Nt/46q3RWnXSQE9K5zo5boGERsY1I3YANyxoefTMqLX42/AXOEPIjR7zTwGAKebZdlTbsYheNCGRI16e9WZnBnGDhikYFpQlzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937392; c=relaxed/simple;
	bh=ErbYByOC7d0OuCZ94AM8sUoVJ0YGR5+aoblVzt/0O2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBsPJS0SX6Sjgy6RxG6IVfMKZNZm3Lrwy1hfdU4SHdARXvzXzcyW9gPm2yWAgNLtTeAAvenO94jj6MfNV2Md99yvnse/XrXk8axnnQ0EivLQu9Fez/zD4kuR54IFHOvh0oHkJPr77XMoJQvLwXkQoAyz1VkVqdAJs7SiJTfNSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=RlaGfkGd; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="RlaGfkGd"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3819B3ED43;
	Wed,  5 Aug 2026 13:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1785937382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S53jgL42p3H7bz1OlPxTZWDrt2zQwIzC9EU1/GtuKWo=;
	b=RlaGfkGdge24Nl8IN8pg66wUXPOC1TzU3HAtazaH7XaafpL3ASqwK07SmbHnM1Ws8eE8+O
	LG4SOZUF6JYEaKoJti+FLoX6HWa+djoXlTVBmh15KNvOdE3UbzOvC4Ti/wKLGeTVOdSEp0
	pKMjlS7WXF+vJlDuTjDEGPRh1GQKZFJwMJD01VOyMh0DZ1TbNCFIdodubML6OMeyQyUhIj
	R2ElnCQH4E5W+Tf2pN3p8V1DIaHJUfkbVRe19dxXHrNtUaSltkhygenBiWJKl6V2ocIytj
	FM9ijduRpmeCPG1mGvk2M9A84DCj4MzSN9fOdE+E24q95FC018tMiAqROCbFjA==
Date: Wed, 5 Aug 2026 15:42:52 +0200
From: Arthur =?utf-8?Q?Cr=C3=A9pin?= Leblond <arthur@marmottus.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Netdev <netdev@vger.kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w5100: restore GPIO-based link detection
Message-ID: <anM93A0l2inhFxFu@pc-du-fromage>
References: <20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net>
 <d762ff5f-30ba-42fc-bf58-500f807483ad@lunn.ch>
 <anLzkNOBMvn7_0d3@pc-du-fromage>
 <5d9c865e-a9a2-4756-a27b-a5af60ef3bad@app.fastmail.com>
 <anMF9_h0OilX-Tz3@pc-du-fromage>
 <1111a5e1-49bb-44b6-918d-7cda152a318b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1111a5e1-49bb-44b6-918d-7cda152a318b@app.fastmail.com>
X-GND-Sasl: arthur@marmottus.net
X-GND-Cause: dmFkZTGy5GqwQYSll2cXe4YvbVRtBhta3PGLwZsxfE3xKR0Q+iub5e2kUeLhM57cKOcsB+ppEZktLm44t+q0T+LSBkjTZkqyln9fomIP4Yo7aKesnAnsWn31dq2ufy+N/I67G324Tsn79S0DWXJzNYin3eKTLmSGTUdLihAJZXiFSzDnSLNLdXQQQb+kvQI7063zVckF2moYmGmLQQA/ze4S/1DnMXjEgkd1TcLWxZ+NhwU2g5HDHDRNG9LWNrS1MJUJX7Uv39NsOOjwTGazikdbnWSDTgL20/Q4CUF7Vd2GGPMxxKgJXQv1titfDHhULEUYXwNWNssSr0fEIRB8O6XH5RZ5IGgto4ir8Nvz18M9K8IrFDsd3pg9T46IVcSrLXv7pM6kxdxc3rkj3SfeZCjCBEp0Nl3qvg4Q52U01swA1v34YI8NZg+4cnp49iL32sBSUnqF1NBosRp6quDUoO6knTYH+DEgYlTOeSuohJZXhsAZkOgdFqN++XorvMKoZJL/B4aU7zZNzFWVxe4BdFbqiRXnbmRBqmQZI+mbNATNRnSR68ZR/DLpjotC7VlJIaBK5DnC7SvZETAOBxj7OEZ/kmn9Ln3Z1fHABW47dPI6XNg1fVAwq80G97SwTTpYVgAM+d5KcbRLaZ3OXAgfMit9Ixy8spUlUewWy190A9fmDfsYUw
X-GND-State: clean
X-GND-Score: -100

On Wed, Aug 05, 2026 at 12:46:14PM +0200, Arnd Bergmann wrote:
>On Wed, Aug 5, 2026, at 11:44, Arthur Crépin Leblond wrote:
>> On Wed, Aug 05, 2026 at 11:11:53AM +0200, Arnd Bergmann wrote:
>> You're right for the W5100 that would not make any sense during data
>> transfers it would trigger the interrupt. That's unreliable.
>>
>> I am using the W5500, and in the datasheet it says
>>
>>    Link LED
>>    This shows the Link status.
>>    Low: Link is established
>>    High: Link is not established
>>
>> I can confirm it is what is happening, I don't see any changes
>> of state during TX/RX.
>
>Ok, good. On the other hand, the W5500 also has a PHYCFG register
>that should tell you the link status without looking at the
>GPIO line, though it's not clear if the CON/DISCON interrupt
>fires on link state change in MACRAW mode.
>
>It probably makes sense to wire up link w5100_get_link() to
>the phy register for w5500 either way, as that works without
>connecting a GPIO. Then you can just describe the LINKLED
>signal as an optional interrupt in the DT binding to trigger
>checking the link state in that register.
>
>     Arnd

Seems to work, the PHYCFG[0] bit gets updated on link change.

Arthur
