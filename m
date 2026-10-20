Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516536;
	b=Omjb0IwxRGoq2cR7CRhMJsqhl5qTKKktsZbx/Ew3oNdRRykiwB/XvqkxDfzO947df3jj
	 N3M+Kpe+XHI+c864pDWlN2dznQHrc4fbQvPwRHUocccWdxy5KHPL/58AzCoCaW8JVL4g+
	 VqFWU4I67+uhkIZZ7puXYRLrHW/bv2OTiVn2y/JSUG+b+TBY9UsO5osJKVnOA6ocihKQ7
	 12hgQpVozzMDbeqbeWCrFD83IUtDTI8ZMCglkyHmjLgXIcndr0CxvvcSAog2eosu4QyAt
	 enUV2HfNn84AN33Nq/iBkVQ0PefOOr6bReRTkgoLdELKlG+iu7S1kKj5EW1RU86kOCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516536;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=OdcH/0G5TygIz1llf3tnNdwtdILJ239brH+wW6iM/MM=;
	b=4FNTy+A8xtaLBfNtW/M8pZ+3l1Wuh0SQ73sQM9RZqhg4WobPpmIVBx2C8G2NifFfs7mA
	 cIei0CEPgTHU3e6TDe2BesGynpySM3bpv3+6jyYfhrbdnmUxmuIFYb+TyuJQDHi4ArdF/
	 REAnsXRKy1wANdiISex8ZfixJy1x+KkUlrt1Bb36/Hv15+TnI5Mm3nWfNELIndWZQ9O3m
	 HK4rXFf/fNAbuGbppzYos1VzeXBqB8bEYdscUVnuVqYCMnEHVd7jvRr4rXMDMg6AYuIs5
	 aLADIOAvpQ+Q6G6BabgWZICqqSGEv87AKUxoffmY/Iqc9yktL9WkREpxJ8opt6Sb3Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=E5Xa2poa;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4E2606AA0B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 17:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE4E2606AA0B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=E5Xa2poa
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2EFC24E4128B;
	Tue, 20 Oct 2026 17:15:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0190560393;
	Tue, 20 Oct 2026 17:15:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F0441103289A8;
	Tue, 20 Oct 2026 19:15:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792516531; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=OdcH/0G5TygIz1llf3tnNdwtdILJ239brH+wW6iM/MM=;
	b=E5Xa2poadgALzKUr4lDwWd+h4KD8v74ZMm7iW3l/CrJCoeAux6JySsRDMxxzOyccrdRPHp
	r4LGuE7P3GPy8TPzSah90LoHQdFFHUHbyyKJp9pjNFVTKBzysKuktS4G+ALTlmYIFsdje9
	/o5Nn4mrSh2kc8IiXdwNQVqbPOtxE6jNeFsQzcsR9cM5K0+yTG/tLbq0GKIMrYHJqO6SvX
	CK1S/JfNUfuz6Vq3VRUC4k7mG+th2Zbmfp5l54SizSWTFhJgDXLc+gETRcGoyiNb6rMHD+
	yxP36SSwksyvQlKArlyUNQDuFQXkP5A2JWKBVtWUdDNXadFzLtZdTmXbr09pjQ==
Message-ID: <d28a828f-2f91-48c4-a462-993dfa317cb1@bootlin.com>
Date: Tue, 20 Oct 2026 19:15:24 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net-next v2 0/2] net: pse-pd: si3474: probe error path
 cleanups
To: Carlo Szelinsky <github@szelinsky.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Piotr Kubik <piotr.kubik@adtran.com>,
 Sai Krishna <saikrishnag@marvell.com>, Simon Horman <horms@kernel.org>,
 Kyle Swenson <kyle.swenson@est.tech>, netdev-bot+sashiko@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261020171134.852878-1-github@szelinsky.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261020171134.852878-1-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/20/26 19:11, Carlo Szelinsky wrote:
> Two small changes to the error paths in si3474 probe. They do not
> depend on the PSE fixes for net ("net: pse-pd: assorted lifetime and
> error-path fixes" v2) and apply to net-next as they are.
> 
>   1  The error message after a failed devm_add_action_or_reset() reads
>      the ancillary I2C client, which was just unregistered.
>   2  Use dev_err_probe() for a failed controller registration, as
>      pd692x0 and tps23881 do.
> 
> 1 was found by code inspection and not reproduced. Both are
> build-tested only, with W=1.

Hello,
net-next is currently close as we are in the merge window.
Please resend it when it open again:
https://netdev.bots.linux.dev/net-next.html

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

