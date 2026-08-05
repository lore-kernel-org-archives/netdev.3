Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934992AD2E;
	Wed,  5 Aug 2026 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926805; cv=none; b=k77HfR/FzyELpTE8GIsqPK1087lJkYqj3dkUt51EDLlwX4WqWrg92fxTkVPmaTkCB1A2VVkVoTZVoUK76sbXNDscWuqXgn3G7VN/ICc8WDxrr0XzC5wSrzE788cllS6UU1E3QnhqP5meu/m0iAM9UdZ1dszU0x1YITyt5rJfsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926805; c=relaxed/simple;
	bh=lTO8qW1df+7Gcrx0GWraRMiY/ayKGQd8rNPZwPUPbrA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hVBJ1DG7oUX4JoJVXgebJOW8goYhtAOOBPxlOG9EXr4AfKpSfCEWYvjWTZA9raD6kF/bA59JbC1cnb0CdqgWrCoI4MV2mE26n5F7+Cah8kxqqhXvFo18nOTZzVPgtWT3XEHazwB5nJJajLd4Ydfs0Yx8gk3+EA/CRdhZjN/7l3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cfmxU3Ab; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KLLLXHBQ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cfmxU3Ab";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KLLLXHBQ"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6BDEA1400167;
	Wed,  5 Aug 2026 06:46:41 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 05 Aug 2026 06:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785926800;
	 x=1786013200; bh=H7NyNVqGvuncYgKOUwQnFoHtG5DB1uI+j2X0vZBvALc=; b=
	cfmxU3AbhLcd1nfR8t0vS9WzVoXB9uObcQ/GQ8BrbiDyPc80j63y6Mid/rU8Kp2I
	cNIAEQ/bJtRWeaJFE4QEkin2u6D7kPyrEoD0WKzFX9gQ0Ljx4bXC75QGeYfbTGDA
	LNxJ2lJO8x5fkLA6KmQNo6Vyg9SFV7h6gdjk3qndybg0C3mTJmcqF/NhaPyzC3u/
	tffz+uVbi7Qcn+/XawD28J9rM7MfdPYP9+a0I0x1VWZV1tibRNLkx7ZlL/u4+Bjx
	2RHbLjSSG04RIPUaT4lUhSRY9cMzuvVciEhX1GU/EiVeUBjwvJA87nYM7bPoUgqv
	wNKj/9aW+PPhM+eT4xu5Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785926800; x=
	1786013200; bh=H7NyNVqGvuncYgKOUwQnFoHtG5DB1uI+j2X0vZBvALc=; b=K
	LLLXHBQKehIxCvqGoYKCi+ORI9/UHbLPCeBxcvTY1n8SKB649SJxPYxD5MG/fxzw
	sp8H9pK7IgJdKWdDoL57HYX1ScGpfoT2XZnKt2BZYmzFOMfjH4NTetrnDnFpSerF
	KC47mmLLMD9BcF8k8eWaGLEk/B3zKDhYYbWI1k8FIqq267sfZHY9BiQ3VlVrQUWa
	B1YRcH3F03wilOWz3+TXX2sBbm5nv9r5H60Li2FTsRTmUBlqroWgrnfgfahkNplz
	w1GsH457ytxjQ+6NnDYR3bUc+2BwMyGIzf4J6ox56bdLeMp49H7V9J1csG3sQWT2
	uOiQC0b5G0F8f7Xf3w5Sw==
X-ME-Sender: <xms:ihRzahwGC7ssr-g-_Y2UDRAIFzfMBWXv81Mh03xU7IfjDB9Eb5zPiA>
    <xme:ihRzasGVjVAJ1Ffa8q_GpxkSjqOSYl5f19IEYBjB3eI6uNhZmalyXmXOWEhEYX1Qw
    XPJTZojA9odf5eM4lJwS-v_RloqOJ9ixxJpG5_l8DmHi9H1_5c68Kw>
X-ME-Proxy-Cause: dmFkZTFHwz1z+DpEdXU2CCr8fWisG/2YXjEecDm72FvON2UqgcvTGG3FzPwQtPYoW5xi2d
    Pokbvyfs6VGPZqW8e5FE1NYxOkf+2Em3zxD5F+evsRQ5ru9Wh8WAD9kS9W3LyNyyT6jlgk
    4ZY/cNZdLb1RIPARjP37+N1YrQnJWsyX/IedsqFLfVoMFMqBX4m/xfmVOALWY5xA/3Gyak
    t/Y6jMmV8GRi9HD+wKyorPs6uEW/uabaoiX+SM84Iui+to9WdZmeohb2N5hY8OFGy1KKWN
    BW3IRQSMCBqEdVR0T4q9VdvD4bgQTHuCbFDE/dHV4wMhoszHQntS/bYtx8Ks6xLO2za2Kd
    CCKkmOt0m7S9IejPrdiovGPI1C/ZufP5zDOci6ORi74iQ2W9vv5xioZkjXUlwmIGpVUwer
    W2h18H6ulQ5ZOgnlejZsiR+tPbzfY6dxojRybfNnue901UfJFWLQvYWcTz7Ee3u7tgcsTL
    Jf1BoZAfGVhjbtebnJOKuIF+KSAVC9kp79kuSRWDq2fB9gB5XTeIVs+RYSSPudwRsc07V+
    +RhK2doRvbYuCTIdUDTVlTBWHG2VvUbJRHehT4tBQl3NeiyDoMO8HuYVWUMhGefNbW4kJu
    O7fZhOa/1MjwZhgiHze8r50FnWueN0yd7eluTRwk0y5ST86VDoRqzZIlP+Pg
X-ME-Proxy: <xmx:jRRzagg13UNBXPA2tFzj3tRt4dIwLpKWaQaX4diLuU-Rq5DEnL0ngg>
    <xmx:jRRzasu3-hPnAWpSr9ZXQwaRTj_pDCRDJxJ9xmBSuWaBEvSUVL--5g>
    <xmx:jRRzagvxewMFDy1pryW_FQcErRyMOVr28AYI0MiwSQqVW2QZtEshEQ>
    <xmx:jRRzairL-cY8bn83PhlGvSyk4Wv2ZNYJLm84J1NCDZuwPs5WDW7XnA>
    <xmx:kBRzaoYTO2OXh0Kky6xAeEcmxc3xKpQ5hTN_S2UPpeO5RD_uRcmdv-pF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 8DB0032A0062; Wed,  5 Aug 2026 06:46:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGiDCXf8z4CV
Date: Wed, 05 Aug 2026 12:46:14 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Cc: "Andrew Lunn" <andrew@lunn.ch>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, Netdev <netdev@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1111a5e1-49bb-44b6-918d-7cda152a318b@app.fastmail.com>
In-Reply-To: <anMF9_h0OilX-Tz3@pc-du-fromage>
References: <20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net>
 <d762ff5f-30ba-42fc-bf58-500f807483ad@lunn.ch>
 <anLzkNOBMvn7_0d3@pc-du-fromage>
 <5d9c865e-a9a2-4756-a27b-a5af60ef3bad@app.fastmail.com>
 <anMF9_h0OilX-Tz3@pc-du-fromage>
Subject: Re: [PATCH] w5100: restore GPIO-based link detection
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026, at 11:44, Arthur Cr=C3=A9pin Leblond wrote:
> On Wed, Aug 05, 2026 at 11:11:53AM +0200, Arnd Bergmann wrote:
> You're right for the W5100 that would not make any sense during data
> transfers it would trigger the interrupt. That's unreliable.
>
> I am using the W5500, and in the datasheet it says
>
>    Link LED
>    This shows the Link status.
>    Low: Link is established
>    High: Link is not established
>
> I can confirm it is what is happening, I don't see any changes
> of state during TX/RX.

Ok, good. On the other hand, the W5500 also has a PHYCFG register
that should tell you the link status without looking at the
GPIO line, though it's not clear if the CON/DISCON interrupt
fires on link state change in MACRAW mode.

It probably makes sense to wire up link w5100_get_link() to
the phy register for w5500 either way, as that works without
connecting a GPIO. Then you can just describe the LINKLED
signal as an optional interrupt in the DT binding to trigger
checking the link state in that register.

     Arnd
