Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793588168;
	b=bLN5+teZ9/vEqgko3yAPrgb5ljtPzxS2L3G4BP+c9huisbuU83eDzWrykma9OatwkE/q
	 kxVSARWabMoc3BDVxfDerblvRcwc48GBO7V3a0zFSwXjQ9mA8SyrsRq3pftDFx8gI+2PW
	 PNbZ292601uGHwJNcPYzaSOFnm6BTWfEbcUoJmm2NPaMNYnAMbh2ATn29fOp66/VphRBK
	 9S2HAXagXegeI3wc2bGIjrRnnorxt3T9y/IRM/VHmuydIvD/3BYgBvt+75ItPOm1gs8U0
	 dMRwGwf3B0FfQ5/S7uFoSflsZ7fdbJF+HZGGKjlDC6X2L7NiEctVIk/u/gpURUUnRFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793588168;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=F47TvpF4alCvrDwB/lWnRKJYMN0llS7GsPiSe1nXvh8=;
	b=fGA4LcIgOOhZsrquhJmKLvjnVtDNMjGgULtnH63Mt3fXxTYDWe4CvI2FjEvbvhM7G/Oy
	 1T3415GL5DcIxfT6jLDEsQ4KWzyCE5j2LrI7dTiisrAgbEFxAFjweavBiGS1zdW78vyuS
	 Bj8HwNO2pHufocgsC4flS8wubjeBFb/Lu0aCYL7bnY+jKiC4wMkbdWqK4hAWTQLU4bJtW
	 74hXCOQ2kfguDo1MZJNoNDglUbY0dC4imDvmT7vcn+O3i+EoUhhCOM4K//k7J1aett4xw
	 bBenbskQ8hxCUudwYXl7d9zOkwBjAsejINaPNjcDHGW/OwKe1I+jxBh0LyEHJ9rEiAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeconstruct.com.au;
	spf=pass smtp.mailfrom=codeconstruct.com.au;
	dkim=pass header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=I926b+8a;
	arc=none smtp.remote-ip=203.29.241.158
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECF6606A324;
	Mon,  2 Nov 2026 02:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ECF6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=I926b+8a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793588158;
	bh=F47TvpF4alCvrDwB/lWnRKJYMN0llS7GsPiSe1nXvh8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I926b+8aUm++ApEmUumF6Wq1fFjZYN/De2AQVGpR7/LKQmgawmZ1MZBHmTXRtGXeA
	 WNy4K6xrj1IK8Yj0N+JU/18N0U93HBopE4zHN2PFpZ+lpP+0dOb2ajvqmaN1L1CrSR
	 1WfZFU31ZSVQCH/es2G7x5G6paJL+mlzMOOtDdEqALUG6dpww6GWIV+rAzs1SFqnAS
	 CmEauo5bUgRJucwgkMWNHk5cGLNHCexucabtj9R8T2DP+nE/2R4EgVyGDL+JdbIqXP
	 eje/0nxF65/YuIA3ZovO7hzFS/jhSx1JpK0/IScBRfsaFBOllaBj1SygxYX4Ad47rX
	 AMUoOzEtIHamg==
Received: from [192.168.72.161] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id F1D0C64A21;
	Mon,  2 Nov 2026 10:55:53 +0800 (AWST)
Message-ID: <4102c20ece135c4d94e94af4441a01425ad159fc.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 0/2] net: mctp: Add MCTP transport for the
 Axiado AX3005 IRoT
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Akhila Kavi <akavi@axiado.com>, Sammai Chakravarthy	
 <schakravarthy@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Tzu-Hao Wei	 <twei@axiado.com>, Karthikeyan Mitran
 <kmitran@axiado.com>, Matt Johnston	 <matt@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, Adam Young <admiyo@amperemail.onmicrosoft.com>
Date: Mon, 02 Nov 2026 10:55:53 +0800
In-Reply-To: <20261101-mctp-transport-irot-ax3005-v1-0-36ceb822f01e@axiado.com>
References: 
	<20261101-mctp-transport-irot-ax3005-v1-0-36ceb822f01e@axiado.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Akhila,

> The Axiado AX3005 SoC has an integrated root-of-trust (IRoT)
> co-processor next to the application processor. Security protocols such
> as SPDM and PLDM run between the two over MCTP. This series adds a
> transport for that link, so the host side uses ordinary AF_MCTP
> sockets.

One overall thing: why not use the MCTP MMBI (DSP0284) transport spec
for this? Sounds like this would be an exact match for the MMBI
use-case.

[Also: CCing Adam who is working on PCC, which may have some overlap
with the mailbox protocol used here]

And finally: how confident are you that the peer will never be able to
reassemble? Even if the peer's own MCTP stack may not reassemble,
there's no chance of it bridging to other endpoints in future?

I have a few (minor) comments on the implementation, but would like to
sort out the overall protocol usage first.

Cheers,


Jeremy
