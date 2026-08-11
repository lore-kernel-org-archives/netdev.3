Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F822AD00;
	Tue, 11 Aug 2026 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458353; cv=none; b=oRp0hBZXbiQJfsXAC3F+DMVEp/5TglY6sZIr9XCoETsvjosH2zcwnSHWAmcivRsRfINyKPRlxgByRZEy1OzOGCK2dl7DS1izq/NPvJOyyG6LNp2/lapAfWy+smo3g6pYoEasazLavTJ+ZHNXKxWhRMHM2pe8icNjH/3M1SzvgB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458353; c=relaxed/simple;
	bh=ke2CH8UPIVwN2hegZrxVEZUMRk7xGrpnGOXrnCxzdos=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qyjqNJguLWVzr0g0/ckNdP8/CYdF3gS3idsAHHGXd7FKeVBZtC7vbELYNQhqUgmEd3ayeTsPPWkMu0s0svLgLu3KvEvOhR4jC946gjnoZ2KZKuZf4LfqvF1e1onriqnMzdkB8pZO9Z+tEJK35lgyYft290d5KDykxThRRa9NSHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JPciYqgb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WmhYq2Qr; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JPciYqgb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WmhYq2Qr"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF83214000F3;
	Tue, 11 Aug 2026 10:25:49 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 11 Aug 2026 10:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786458348;
	 x=1786544748; bh=MVHBo9K2Wk2DeCidmUS0Kx+MIUWwsM/6MNQXk7bW2eQ=; b=
	JPciYqgbXNFRS+rfwdJkw5NCSHI6h6cjnv0X3kgUlHAXKvOO7aWqGpiCZBKPmrGW
	khESsgZw/RRvTWwWN4oFvmj4Lx0MNxSmOTtRg9/aVdN1/FAQY8hepmsqktafj7Pr
	cxpRscytHoXI5gHbZhFauDSBWnsPxkVFttjQYWemC1xe75x8Fy1vXsLZGkk/V7U7
	YAzP9ckjsorx4Et+WZsHc08DSqBw/8+kdwyBMvrXtdN95+FpjlxMEik710sX7wE9
	mfd9YOC09KgJRq6Ri9gI19kt3qfKJZJVGe8EfVRr7mB577WJCaHakwMjZTGu71PR
	yQsWfaHcaRBKIXTZK+2k3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786458348; x=
	1786544748; bh=MVHBo9K2Wk2DeCidmUS0Kx+MIUWwsM/6MNQXk7bW2eQ=; b=W
	mhYq2QrQ+aVYbS5dPtkzh/BSRD84pUvK36T6s0ZFyRFMgvrB/Nt9ka/NCpK+h83f
	mVEve+virZoEEuD8hCL2+th0h3fKq7UVgBhXF2Y3ja+zCcGo4eWwNiUdBTXNlfGl
	hVEs5vK1UxM71RIUJJq6g+b3tjZycbSdYoPrRW3Q0o0zvGzGWLG4yfXvfQNM9AQd
	rN5QEiCs6y1N4Fd2XtryZsaiNG+c0+myrvuasCSI/TXDckw/4z/BBDqa5nOIsVf8
	PCgc6NNW18oOPP0YHZCM5He1WSl4qJXnfwOXaKw1BFqJayhfIRJ02AU5FHmRS2kc
	4eS2/WkDdKttHvilJNXeg==
X-ME-Sender: <xms:5jB7ard16m7B5rc7m6XBuCc7zYgRy_TxMhpvdG-YwHUxUxC43RuoOA>
    <xme:5jB7asBc2fEiAYxxFbVHzCbtVra0rqjx-sBOqw8lkC3oJHYAqZlaEPctrBVd1AeaC
    lUoX1EfH83URXcNmW-xTp5CZs2zMHLxPax206LXn2VFW2LllVDyYw>
X-ME-Proxy-Cause: dmFkZTGk0MdjbbpeNh1QaJUeUW4n17idi1hVEA4RVnDre4k7eHOk72+g0LzYkhakF2FJeL
    vlr2SFHS0QIBU1RQcLG0RuBE0TGXCUJAcV3AM8wXMw5xEya+U4c5BY2i7/V/6OdPrDbTBQ
    lnr4MS8s0iJIAMync9qJrBDbLkf9fkraw31EZ2rmS8N5un4NZ1vGUxoltxmMTz8E4OJycc
    ZQmM9zjdHcI3js+F/lCxg5PLzMZOHfSYvx4HIsL+eXOSAZ9tZD9BrvSsYhUYpw3Loyu9ii
    XC/POWgZghIG+6HuUG+Tl9U6kX940WTocJ56TEBa/PwVdAHV2elfDLqOWG3aac2uvA86Er
    3ymA/GIwl51yoGrSJrBYrkytyxsZxHdD3OFEP2mHUyP6MsP2l1aG3LWVFiLB6LE9H0im/e
    1L8MTFQ3siJjDnHASGWztuBN6vHsFDTI/Rr37R9oxutm1lKTboGacpj3iGZnHipjmA8fSW
    yyEQxtIjZLGbWX4zZlcIZGntiwMnAgDJ7XYJ/CDhvfncEoksztGcTIk5AzdzkADNeHxaul
    Sy3ZwIGL7lvoFOGYXvq96/1Hq1EcOZtgWCqRZG6vuJN7yfJb2IXdni+oZv7jdae1QTWzAi
    OuoENgHLLiux7iXz6U38FCNXuZFGKzjTjHvwfI7Mio+8HX2fHKWGoPYnMEiA
X-ME-Proxy: <xmx:6TB7asZAymUfYPtWWR8k0FP9A9pl0KM0Ickx05Yz-IAacDhy0berTg>
    <xmx:6TB7asm_V6gFEizgySRmv4VaIjavis7WsLmMdSouG2B2LA84lNAjYw>
    <xmx:6TB7aqXGYb6X7xvcn1a1Z-YLYwdumtaJU3UowWzPtecIjEDFFV-Jww>
    <xmx:6TB7amIRVLzmVCm07VKG0XvpzwOiNJXSKb4Efq0E-S2LqC06KdUtrQ>
    <xmx:7DB7auDERW2D1zfF76zpbGRNqHcw3kx9kvZZpe-Sf7QIDWeRuuC-LrZy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B0A0A32A006F; Tue, 11 Aug 2026 10:25:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AE4jp8cz6WHc
Date: Tue, 11 Aug 2026 16:25:22 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, Netdev <netdev@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Message-Id: <7cb59930-6f50-4b49-af58-b67bab2f542b@app.fastmail.com>
In-Reply-To: <ansuYaT2GAMAA0hF@pc-du-fromage>
References: <20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net>
 <20260811-wiznet-link-gpio-v4-1-4d5f7da885a8@marmottus.net>
 <5812d452-5dbe-436b-ae6e-af062a873f7a@app.fastmail.com>
 <ansuYaT2GAMAA0hF@pc-du-fromage>
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: wiznet,w5100: convert to DT
 schema
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026, at 16:14, Arthur Cr=C3=A9pin Leblond wrote:
> On Tue, Aug 11, 2026 at 02:57:40PM +0200, Arnd Bergmann wrote:
>>
>>I think this needs to be IRQ_TYPE_EDGE_BOTH instead of IRQ_TYPE_EDGE_F=
ALLING
>>to make sense.
>
> This interrupt is for the main one which is active low, we don't need
> to catch the rising one.
> Only The link interrupt needs to be both edges.

Ah of course, sorry for the noise.

      Arnd
