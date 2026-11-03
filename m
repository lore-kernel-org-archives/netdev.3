Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732191;
	b=q/zuw7MU2GVOzwlgBp5zU9Z+ArbTGVE1vyYQN6vcQLJ9VtCuh4JrFIFllaPowTJeHZBY
	 RC8EYhEHujv4PhfFn8gWSDLyDHyl1w+kgo8OWOjPx2jfnZqG5jn1drB5wuQMDMOU+Whpj
	 l6uNyouqUR+im+0L1C6lAoM1graZc0PlV9ngQDKJksPYIfkZFqDLENa0PvlCGVXCCgYGL
	 uAGB5KpXefazraJqrja+wMms2jsTae+6KTy8w2aVoBGX6B+VKpmljB2X45no4LeKGKZwv
	 nkY7X4mtTVHSdnwh0SNzif7fOPqsmm0v4dX2ptUdYeFFYkNfl3jhwj+uhfnC++8qA/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732191;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=5629z1hliFgRB1i8Gc9oK4Mr2yUaR1BiwYHKsmR/8Bs=;
	b=WL/a5zp1EUwDKNLQqGSP6T2GLFmILxCy5ITjAWZ2h6DIO2mJ3fTZ3hI3qFQAf91tcHzP
	 SwPVG5wiCRa04cmR9LW/9tqigSOJPsNFIqt2vGWMymX6bJVJV7oCZsXnQUb+Lffoqlngq
	 v9eg9+5Ae8nAbV34U9fawe9yOrue/GSb4FF8C8/VLw7pBYKFSM/r1vrQmm+y3+qfxvQn1
	 PIrXvjmJ7Lqxuh0HjL9n39XjT2+4GY0Y1+7K84/pBCEmUrSIKMlj+qlv6ENFX5UGKqXCU
	 OWn8w8YSaYJ+NFPgPhfm+a/TwSOcpoZvOeKMADmo5fV1WK2RvEIO75hWaG45lZWoG6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=miTVynxt;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED24606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 18:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AED24606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=miTVynxt
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8CBF5C49F4B;
	Tue,  3 Nov 2026 18:57:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DE3386046C;
	Tue,  3 Nov 2026 18:56:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95D44103291F9;
	Tue,  3 Nov 2026 19:56:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793732186; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=5629z1hliFgRB1i8Gc9oK4Mr2yUaR1BiwYHKsmR/8Bs=;
	b=miTVynxtoXW9Wx5uPS4QgDE1vcHvI5QwANZ+tG+FRuGk4H8WHeC7aTpwlSmpDUuz8SsLJ0
	LUEq9DxhZzFInjwaVRy2udvRdr0Y8swZGhaxanz6tCGB/2pIzER0lx1fcNVPdGtlDeu7iS
	k/p2Dw+A9xnuTa9vegqSHSQ0Sx+F1YlKP5uIbxjEL+MTJXo+7GddtcNQ1yCyvFVYCQyv1h
	sN+u6TKnIe8boAweKC1PZNC1f8dxVpZ8pJLw/tE63Spjhv6uPgYHU3wIyDPGeh+uo1SsR7
	YigMHQkG7EFROpBjfJruu/ffYaGjWfNdt2nXhwRu2L7pMvtUlQiY9JPf0/6XXg==
Message-ID: <862976ab-e80e-4d6b-9657-ad9bba2d020b@bootlin.com>
Date: Tue, 3 Nov 2026 19:56:20 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/5] net: mvneta: fix the TX queue arbitration and
 the mqprio offload
To: Josef Schlehofer <pepe.schlehofer@gmail.com>, netdev@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, w@1wt.eu,
 linux-kernel@vger.kernel.org
References: <20261103125021.70845-1-pepe.schlehofer@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261103125021.70845-1-pepe.schlehofer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Josef,

On 11/3/26 13:50, Josef Schlehofer wrote:
> The NETA TX arbiter is left at its reset default, which serves the TX
> queues in fixed priority. Under load a busy queue starves the others.
> OpenWrt has worked around this since 2017 by sending all TX traffic
> of its 32-bit boards through queue 0 [1].
> 
> Patch 3 serves the queues in weighted round robin. While working on it,
> four older bugs in the mqprio offload showed up. Turning the shaper off
> leaves the per-queue rate limits in place (patch 1). Deleting the qdisc
> never reaches the driver (patch 2). A failed setup is not undone
> (patch 4). Opening the interface or changing its MTU sets every rate
> limit to 10.23 Mbit/s (patch 5).
> 
> The series was tested on a Turris Omnia (Armada 385). The other NETA
> variants were not tested, but the driver already programs registers of
> the same block (MVNETA_TX_MTU and the token sizes) on all of them.
> Suspend and resume were not tested.
> 
> With patch 2, replacing an offloaded mqprio qdisc with another mqprio
> under a new handle loses the new configuration. The new qdisc is set up
> before the old one is torn down, and the driver now acts on that
> teardown. Software mqprio loses the configuration in the same way.

Wouldn't this break mqprio offload ? It's no longer priorising then ?

That behaviour of the high-prio queue potentially starving the other
is likely what mqprio users actually need, so maybe we need to setup
prio-based queue selection when adding an mqprio qdisc, and switch back
to WRR when its removed ?

Maxime

