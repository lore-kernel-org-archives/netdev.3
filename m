Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D2E3D8100;
	Wed,  5 Aug 2026 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916642; cv=none; b=rWg7fX7WNQNEHiN8d5b/PHiENseN/bWp88+j8pwUe1DQB2rYvlyRWGgRIt+I15YAfkp8ggu9oHI9cRWiaWqLJZiXorCEnnRHjo6YuijVFNfixCKhxULMvwDsZ6QMcZeOKknsnZbZy+lErM6QeIjRXdKZ8a0FIkrnZi+MIx+VwuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916642; c=relaxed/simple;
	bh=/Rp7Pn+fQI6CSgJp+UCS8DYzICT6DFqq6AcdVmsPy3g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=K9X6mR+LsT5w1W5lEGuU0SGvCWGwVmAU9rzax6BLAhRLv2qFgOblmu+E3ylrHwN92TPU/BTZSZhVxcP0llR06uLtqMXTRpXkvXndAkf1U3j0MqPjg2cQCBSfHBMUVM7WRlHH+uQS+aEcJpyQP0pmZOlzyM2LoWoapGqs/6fmbcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YOASK5V0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L2+jVF9d; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YOASK5V0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L2+jVF9d"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 701BBEC010C;
	Wed,  5 Aug 2026 03:57:18 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 05 Aug 2026 03:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785916637;
	 x=1786003037; bh=t0HLp9lMB53EPz7W4VemVUhiOzhn6/MzcjznWPXCNW4=; b=
	YOASK5V0Hk6uem8tg7wIIgy+fY29SpkWlxJz5J8o7DVEqSdjSQ/jeBxj8pV1XDJQ
	TOMBZ3gWZrVUGj+GIqqR7jvDo+C81O1E77pOO8Ht7QwLqIe377eG4Yfjuv4RiYz3
	cAC/BZg44K81dUlA1lcOxmR3rxudoxB2cHiPEV8bgm0jHXDN7fbVsNEPuMLtVbLj
	DK9/pC++ChH8QcaEpc/CNVUcSxB1WlZhwT+99ALx+h/m6d6nkSEnoHYDthylpT9b
	q07smSxAJhhqPjqtmJo/qaEvzKTm8Wc0ZyXtUJZ4VLlkJA4z3lABtQG1szrER/57
	9msnrx4t30CEne9pTFpIVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785916637; x=
	1786003037; bh=t0HLp9lMB53EPz7W4VemVUhiOzhn6/MzcjznWPXCNW4=; b=L
	2+jVF9d+//MF7vFEBo6XnJ2FvBvcCY7UvJh47cCo+Npdldb+x26LWjrMBvcQLB9q
	cpsUMXZT6tMuT8cOcgASja48tT0Q0mWNwcN33n3Yk6u55Yf9Pe0bRT9UxsybX2Rf
	L9NwFHmc3b/gD4/obBsa10LHFAvshw+SpAKGm2uTXkkpPlRqCmM++8J/XjQzNbZE
	vgtzFaVO92Meh5lWv2avDhLExRhhMgZLU26s/Huz/Mx9Q2SwGr+x0GjpHWbdniFy
	A33ZOjxs1M/w4kTruTzp4hfSlgJfu8E8ljZro1IG82Zd9XAAW5ELvsdBXdQPzt5y
	p58UvED5zdCpYxDSlobfQ==
X-ME-Sender: <xms:1-xyaq-vqwzr_uAZU2Io58IJIezITkEkKOqbPMc2xuUFz-BPaXZVKA>
    <xme:1-xyaljb0zff_5kRuMt0MH9TOS6qE5zRTj5pfOZ8bzaEb7vRPHQWHXUvFQcwh5uZW
    72VC56LiM-s4qvdILetCGORdHNec8kAJ0iwhT256phBub5kzffCbMw>
X-ME-Proxy-Cause: dmFkZTGLU2C4275XGDwOOF+++c22vH9o9zBf21wc8/5IYXJR0sXyNLVPaONXE/qXHDEvQy
    YuH57d/J9KXtF2/WvkjE0xA/yhxJjN7cGIzOCNHx1Hcb3b6s7pAEBE102HLGtR5YmMsBUH
    w9D7UOCKxEiWpPNHm6ZhbVfuafRqD+qNgMY8vKcZ2GIXMRmHTU+PMK1HcrKNDrJ+oasqe5
    WzvLz2UXo0hAXn0c9Am/Fad6qLFrxioluLTe1OucwIwC4TaoVCOTIUYbIqtcAmuu1pUJNv
    LQDDovFIfJdXbdiy+YXEINddHXk/cCMCUr19/RE66KhDTVpYjQssqO2UjqcsRNzTpS30CV
    vFElVBA4Y4QdsEaqwlg7ED706SuD4xgvSidfs6flFvDO79d/aZMfSHzGY/TF83Yqez4a6l
    Z60tlr2CnIN28sXwBTfhjskGlTJNFmSgEAKhHUeCKXD3lcFi3zCNW0wclIzTyMSxbnfaSL
    QQYLlGsJ+lvin1qNSWNvET4iNCJwRVb9gCRaT0Szf8Lju/RAGP1axacjgw/AvD087KQlyc
    7KoXqmjGtY9Gu2VZ7Xxv5y6hyvWw2YX3I6IcxH+5wJAX3dFVK4y8gnBtjudS6pZ2AtyJHz
    IpZhNfPelsflCAcFsPMPjUeiNgyMZO2a8AVG84mwjRmONe/AXsZjnoUECDww
X-ME-Proxy: <xmx:2exyaq5xKzQcaUVK1LvTzAeRbx9mFItfdXxe0XRJJMoGMNmPvmar4A>
    <xmx:2exyaqQ5dEEp1kHXVBNKGp9R-1MkWAcEeu8l0IUphP9pLQkih_UXeQ>
    <xmx:2exyalsEZiJAtlyUMYuMCxGc40XDHxHIRAdXXweAyfJiCJ8dfJ0u5A>
    <xmx:2exyak88q6CZC3RoE8Ca9pvgYqhF-kGAEN25YFszfJ-4pGo5HiGANQ>
    <xmx:3exyau5LF8Ftu5GiYT2m7ggkfnXapzvAtOLeVOSVhHhpJSW8Mrp-gn7w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5AAB232A0064; Wed,  5 Aug 2026 03:57:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AW9x60_DFePc
Date: Wed, 05 Aug 2026 09:56:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jakub Kicinski" <kuba@kernel.org>,
 =?UTF-8?Q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, Netdev <netdev@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <910e82a4-24ca-451d-b9f8-5039cafea672@app.fastmail.com>
In-Reply-To: <20260804135807.0912ddf9@kernel.org>
References: <20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net>
 <20260804-wiznet-link-gpio-v2-1-3b1d0c870f35@marmottus.net>
 <20260804135807.0912ddf9@kernel.org>
Subject: Re: [PATCH v2 1/2] w5100: restore GPIO-based link detection
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026, at 22:58, Jakub Kicinski wrote:
> On Tue, 04 Aug 2026 19:40:56 +0200 Arthur Cr=C3=A9pin Leblond wrote:
>> Commit dacf281771a9 ("w5100: remove unused gpio link detection")
>
> Sounds like a fix, so the two patches should probably travel separatel=
y,
> the fix with a Fixes tag and more explanation (what you have in the
> cover letter and more) in the message.
>
> And the conversion should travel via net-next.

It's not really a fix for my patch though: the original code never
worked on mainline kernels because the w5100_spi_probe() function
always passed -EINVAL as the gpio number since it was first added in
630cf09751fe ("net: w5100: support SPI interface mode"). Arthur
correctly adds support for the link gpio line using DT probing.

I would suggest rewording the patch description to clarify this
by describing what the added code does first before mentioning
the removal of the old version.

      Arnd
