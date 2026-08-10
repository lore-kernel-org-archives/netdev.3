Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A013A1E7E;
	Mon, 10 Aug 2026 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350354; cv=none; b=aNlvzIL6PLm6dEu6/7LIp+EMPvou965KO0iF3JCgH9dgSEZqzOpz+gGomrq1y6A+VaXvB5EalfKfyVO2/cDdGLwcff3w1bddMhjv8zMenCOjPtSMiUV7tt+iqI8SgdSmD/Igk4XXzca68FmcKMQPVcoHMoNw91oWfWWgXG8f0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350354; c=relaxed/simple;
	bh=k1aZLJAD+mrsCvGtCzq6e58VsZff/sr/hqvSiefuztc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Zsi7M9bbVxvTjPr2qcxknc+FjOmI43PvMYtrJuzW/+1p5j4dG0bvJObH41SQ4mW7lL2rQRcYyF1Cap4qQ4/+RxKRlCZSB3O5EFGUgqxEKK3Y085Ku9H2XHTaGOc6r+/i4GCSEkQQS/1i4V0WzlY4IVMrMJCe9uTNWK0pJsRn3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=atOhsZpp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N7EmxO9G; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="atOhsZpp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N7EmxO9G"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 44B6AEC00E3;
	Mon, 10 Aug 2026 04:25:50 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 10 Aug 2026 04:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786350349;
	 x=1786436749; bh=0B58fcvh3JLpn3944bCfbXx2NauJhYwHBqoWtkA03DI=; b=
	atOhsZpp2wseXZXKalUAm+lijlpGVXEqhtyd5GnmaIJcIeaAV+kHjx7DpYxHLkuN
	Xg4hhu+xSguF4L5oVW64qM2jGdaG1RYi1dGJMWG0FQQ1olFkuV7we90sIUyEVMIW
	CmnhsfHWMRhx0KkXcnIW9f9Ly9mKcdTf49D+qsmINSV0Re6VWCfcDcf+CXa7+nRE
	uKCu8Sg8wT0xa89Q7evCT8ntR9O+jbvSd/Cx8zkVFHvuev0+or+h3hZO5erJVbdg
	tvdBrftdhFUwnPGJXcBj3QhzrRzcF6JWXw1XmzjWoidHCZE4gV2qvo1abCMfaGbv
	zfIYxizTdXuYxYMaXZLwmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786350349; x=
	1786436749; bh=0B58fcvh3JLpn3944bCfbXx2NauJhYwHBqoWtkA03DI=; b=N
	7EmxO9GpwpgboLMCpCOA0+kW3e9UwV3J9B64wNfIpz2Ir50zUthFRgPw0w1zXoGM
	3p7F+2DQuy5J9mg7a868TuxEVxW8vD0drreO4bhSigeZgO6ESAqfqh3JFLXnr0wl
	QybDKB8egBA+ih/SkzQCIcXKBT2x3QSomofhDM5ElwADRF7fy5xfAWR7ayQBTVXk
	QscXg4elNJCwQQ4TD+pPMkbSHJLYYsy5lUttyOUNKw66AFx+Mx087MLb8t/TSZue
	BUu5MBKrU7koatAZ3SrKjcymnNwEEukofSOM7EDXzaKam/EYEcjSgqBklIPpsdNn
	KtWtBxypDu6+A0l42DPSg==
X-ME-Sender: <xms:B4t5am_stjuJxau7qBeDcl5MiQQUCVhIBDfU4yUzlaK0SXJGzMW7EQ>
    <xme:B4t5ahg5Mdk3Kz9DcKv50cHUThThUABxjMMbHiSJwDTuzXvsR1G8k9Kqw0o_rQQcy
    yS_Pwr2ML9QvSdcQYL3rWWFID2bHPMsfjtP88X-JdZ3kXYtoMSfePk>
X-ME-Proxy-Cause: dmFkZTFiasFJYUnaoP6PX/ZXnVGGhF7kkzGpC/lo9v0C/ajnMBzyCe0At/7cbk9GbiTXcP
    S9IgTj2yCtznfPwLsbdEEFK05mCFnvtJWrDpRc02Wfd+g6lPyFU5GIve75TZphXcGWwAVT
    AwBJEmRdnRXt52X1+b0hQLJ4f33b51A4LExnTjQUcqOi11v7LptTBWv/WSi1ImDGsDEgPF
    CxJhPodJhK4ffkUsp60745kzA4uppu2FMSK0Nce/PToXO1bfQhOt5H0p9Le05+1f7mbhqc
    /YsDIUNo1c7tJJ6kAal/uENFsSdZ+1kRqHNJ/KgjDJHCnvJ0gjAYyCATTm93RxNxybCTqN
    r1Bcgwjk47mXLMZlZJYm0TcwCMh33btPGB3vP928HKQ6rpvqwWoxRfYvkXgqRWDCLNO1Gl
    b/W6FIcKbY55ukHMy03DUlp4dBXev2/nBfomUUTvtmsRumARYFbxMHO6FI7nyWs+xiKLZh
    IDEe8HE0ZYF+uHUyhEvkfiysDTBogG4hTglio/bUdo/k2N/TvxCivYNViCbQhLJDbL2JcE
    Fa0HFIMczWq5HWmowNzF/L7cn3uPMBGvSQe6Lnpw0S2JbIFDiamzlLGgsXF8x06pjL3Fn7
    12LLoUrbCeP8zSNr7IRZCbpVhArJ+QCC83Tkwz/DCeFSPWQqQa0CgOdKWfYg
X-ME-Proxy: <xmx:Cot5aoM4Zj0mpNyxAFuLeN1YcEzwG7rygRg1UD7zbbQ6DhqkadD_xA>
    <xmx:Cot5aiq11UuHKQDs8Ntu3fAByMQVwm5ZSVpJQpjTli-P5WuAZ7UI7w>
    <xmx:Cot5an4s8YCRFUbiDVngptq0R6IgMH2VMjawwNAALx_A4jNWfesp3A>
    <xmx:Cot5aiFtUQ2biXUw9ong4lR1GcLoXTqcDLm6Ccy4QfG5zcco13MVaA>
    <xmx:DYt5anmv10d-7qkmUO0CapBUV1mWqME1HUtIbVfJqtWDYcZYHEzlZa4_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 9894232A006B; Mon, 10 Aug 2026 04:25:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9hGE10fN-aw
Date: Mon, 10 Aug 2026 10:25:22 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Krzysztof Kozlowski" <krzk@kernel.org>,
 =?UTF-8?Q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, Netdev <netdev@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <ed92fe3b-2fef-4343-8ef9-314e8753ce69@app.fastmail.com>
In-Reply-To: <44b4c6f3-3414-47ac-baaf-bca2f68df4c4@kernel.org>
References: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
 <20260806-wiznet-link-gpio-v3-2-532d4a143805@marmottus.net>
 <20260810-arrogant-anteater-of-economy-ef2078@quoll>
 <9e8fb566-e372-4519-ac0b-b8ca6de275e3@app.fastmail.com>
 <105fcc5b-e1d9-4bd8-a697-2d68e185aa38@kernel.org>
 <anmH0NR42wC4EwG-@pc-du-fromage>
 <44b4c6f3-3414-47ac-baaf-bca2f68df4c4@kernel.org>
Subject: Re: [PATCH net-next v3 2/3] dt-bindings: net: wiznet,w5100: add link-gpios
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026, at 10:21, Krzysztof Kozlowski wrote:
> On 10/08/2026 10:12, Arthur Cr=C3=A9pin Leblond wrote:
>>=20
>> We use this line to detect a link change but don't read its value in
>> the interrupt handler, we read the i2c PHYCFGR register to get the
>> link status.
>
> I know, but won't you have soon the same problem with active? Otherwise
> are you going to keep polling for the active link, since it is not
> reported through the main interrupt?

I don't see how we'd ever want to report 'active' state back to
the kernel, this just means it's either receiving or transmitting,
and the kernel already knows when a data transfer happened
because it either started sending or it receives an interrupt for
a received frame.

      Arnd
