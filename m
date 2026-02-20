Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB0C2C11CD
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603104; cv=none; b=dWGXeyko99zePgplO1c/9DGSJdsEgmsoqSW7w1A6E+MpfaqFhIZEvBoobQcLaWS6Y5YvbNigikDJjdyCJJwzd1KpbvkOHd/MtVdMkD7tNOd2yNWDdjWG5/LKONLWdAzPWqpwnkZc7+mFaGq2A9ZB8EkayDc5IokgPlkowxDp6/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603104; c=relaxed/simple;
	bh=iv2w/l6S7bc+01smkIa6Hgl+4jGTZZW2ISEvtpgwN1A=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=CFm1cig4zWhKrD0oP/IBn/ETbRpcrbaub7Q5fiJ6HjvEA1TvX4irKn81KL67jfqOCde/g70/guzF+O7qxR0aa+cUEmrmD7i2dhF/rDDKmoqoy5laFAeoHFCD67EqCVhX35T3CawH4M8jF2yl3ISG/eFnLWfTEZM8knEeF3nX+1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zKOJMlFE; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zKOJMlFE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6E776C16540;
	Fri, 20 Feb 2026 15:58:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6FF325FA8F;
	Fri, 20 Feb 2026 15:58:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BB9B10368D25;
	Fri, 20 Feb 2026 16:58:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771603099; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iv2w/l6S7bc+01smkIa6Hgl+4jGTZZW2ISEvtpgwN1A=;
	b=zKOJMlFEmDAZEqZM3eGSnURKdRST3P+EXK6bhN/yRGnNUSs3iAVe46X5e70ToRkTPl86Qi
	TVqAs92c1TABzsxVFXSUR5UTUlNt08qB8La7oGSsHHAA229ZUDTlrXKjhmKHL0K238Z+tY
	DuzcSjNmlS3hzvyhQhOt3Viy9zzHxLPbDgogN+oKqKXjcl4weo+iOr10wxkvif1uCcs2yA
	kitdgpOkAv8+zvfIlAPCtTR35AtDZQWUMZhnyoVySbdzi5EX+d9Ij8DCx9AqoJ1xn/jHAv
	faz67pvwFHtS7rkoA4Pubg4IwvuZjBa29mcP2a+ZkMz5+4Wtgpqjv2GodoYmSw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 16:58:16 +0100
Message-Id: <DGJWVV088CPI.2AIYKMLF747NK@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 0/8] net: macb: Add XDP support and page pool
 integration
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <DGDZR8L3E9WI.2MEYVL01KQ2YN@bootlin.com> <874inj72uv.fsf@redhat.com>
 <DGG9UYCB17KB.4V0H8BECUV57@bootlin.com> <87fr6w1udm.fsf@redhat.com>
In-Reply-To: <87fr6w1udm.fsf@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Feb 19, 2026 at 7:05 PM CET, Paolo Valerio wrote:
> On 16 Feb 2026 at 10:17:39 AM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>=
 wrote:
>> On Sat Feb 14, 2026 at 4:37 PM CET, Paolo Valerio wrote:
>>> On 13 Feb 2026 at 05:57:17 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.co=
m> wrote:
>>> The one about DMA_BIDIRECTIONAL is already part of this review cycle
>>> (see bot's reply to 5/8) and already incorporated. I'm also considering
>>> the possibility a change that make this no longer relevant anyways, but
>>> I'm not sure as it was planned as a follow up.
>>
>> Yes indeed, Jakub's LLM pointed it out. I looked into this for a bit and
>> couldn't find any good solution. In the end I couldn't find any
>> measurable performance improvement so no need to worry about it (on my
>> platform). I guess the only valid option is to reopen
>> if `running && (!!old_prog !=3D !!new_prog)`?
>
> yeah, which I guess is fine, after all.
> Also, this way at some point we may even consider to remove the xdp
> headroom for the skb case and reserve less like NET_SKB_PAD. This would
> have the extra bonus to not require a full page for 1500 mtu with 4k
> pages.

I will be adding a close/open cycle with the XSK pool introduction.
That is why in my branch I preferred to lean in the direction of not
closing/reopening in the XDP program load (to avoid 2x reopens on AF_XDP
zero-copy). I get your point though.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

