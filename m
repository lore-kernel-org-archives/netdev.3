Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F33B19AC;
	Sun,  2 Aug 2026 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682796; cv=none; b=TqHT8TW6UB/i2czR8n9LVRJ8k9e24WFALR2jLbVgxqnRRwJ1mc5QOeeKCdMAwLN+9T4JIHD1gV/twFB9c7H/ZOJMd0+WZFB2Qjho8ymxpiUnAsc477EG77NUfFcnDObcuI5X2M7NpBEPXtrqMD5ikNJNh/ymYIJqGRNLANsSdPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682796; c=relaxed/simple;
	bh=l6l5Xsj7sBYzwOstYYEMkSQYbglkHXzkpJuf/kD3a5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfggP9lVz+rGtJWfRjfRm1PUh45eCJ9G52Dr+foHO5z171DPud3Ax0faMV+zH6xmrXIdW7Eu4+V7kvrcnsLqmAwq2PRJaz6hmGzWA3M9WA/V81JFbk/ckvT/CENoqXkNRtvzLpePO8Y3B+xfn0S+/cqhHnpPTcw14+Z55wF7/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xW7qyKOy; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xW7qyKOy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7EE004E410A0;
	Sun,  2 Aug 2026 14:59:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D8FD6029B;
	Sun,  2 Aug 2026 14:59:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 954BB11C17641;
	Sun,  2 Aug 2026 16:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785682785; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=L4NN96LF4St9BOce9EbqXSjeEKLi906TafrDSHuyFzE=;
	b=xW7qyKOyUBRdLJ9lR5d2R8ZCztLSdd0LHQKI4xxvys3kxNB2rrR5hTvjy1awyaGRKayqlh
	nyl+NkZd7qdP8uDJHyTNtzhgVpd/6RUYdtH3A2Yk6JarrXEQT2oPnQIvUeWWqdhsC2kvny
	SJxokonb3HmmuOqwuZ6AVC26MMfsm3aAZegcQhmPfgbUhBFHUEha3gh18AaIgOKZtvFB12
	PtYZ4wk6A+qklUtdyGID2NbeBZI6l4YUxhuyLEOp6w+KbcHvC69LiOU5T3SOy9C1218GBf
	aJcNsR3ESNKUqyy57rYP7BB3V6SvQYlY4KZsp8ZK8Beyr86iSV07meKDgKpjHg==
Message-ID: <82df688c-80c7-4536-afd8-1332005b0736@bootlin.com>
Date: Sun, 2 Aug 2026 16:59:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] net: pcs: xpcs: add ANRESTART support for SGMII
 link recovery
To: Andrew Lunn <andrew@lunn.ch>, Coia Prant <coiaprant@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>,
 David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-renesas-soc@vger.kernel.org, Jiawen Wu <jiawenwu@trustnetic.com>
References: <20260801142244.679437-2-coiaprant@gmail.com>
 <20260801142244.679437-8-coiaprant@gmail.com>
 <cfddb747-11d0-476d-8402-e0886cca582e@lunn.ch>
 <CALj3r0i1TCTgvm8FrJAJqmZgoJp61NCxc_xmVYaDFd-gh4H=7w@mail.gmail.com>
 <2886b24e-1c3d-48f7-8b22-9620fa0404f7@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <2886b24e-1c3d-48f7-8b22-9620fa0404f7@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 8/2/26 16:30, Andrew Lunn wrote:
> On Sun, Aug 02, 2026 at 11:11:40AM +0800, Coia Prant wrote:
>> Hi Andrew,
>>
>> Thanks for the careful review.
>>
>>> This probably needs more wide spread testing. I would be afraid that
>>> if you kick off an AN cycle, you loose the link until it completes?
>>> You would of noticed that on your hardware, but other hardware
>>> obviously behaves differently...
>>
>> The trigger condition is: link is down AND an_complete is set.
> 
> Ah, i missed the "link is down" check. That makes it safer.
> 
> I still find it interesting that this devices is different. Has the
> silicon vendor done the integration of the licensed IP wrong?
> 
>> Regarding testing:
>> - Jiawen Wu has tested this on Wangxun NICs and reported no regression
>>   (Tested-by tag included in the patch).
> 
> Probably Maxime will test on the platform he has, but i don't know if
> any use the XPCS.

Indeed :( The only XPCS HW I have right now is the ksz9477 switch, and it
uses an old version of the IP with its own quirks.

I'll test it indeed, but I've yet to find some affordable HW with an XPCS
and that I can easily source :(

Maxime

> 
> 	Andrew

