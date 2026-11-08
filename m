Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794176091;
	b=NzQjtSvw6Iq1fw88TdtcM9oPCR3979TPBNddfumpVLPj+pYBduWhzH7Ig2foRXqbinxZ
	 ZuaWfi2jwHqriA6a3bmZ0DqzKZXncfWEz0sVJ5DtSW1hbFzNMbCX/pGVyaOYBQxHAvcpd
	 xX4M5mA4qhvbhs1P1zcUINzG/xxN9CNm4yznSt8D4dWL0l3uqbv059QjO4BVJ2kKNe4G4
	 TUM0Gn68zxFxFPn47s8UwVegVIcLui5BBHUlP8wV4pkFbL4LB+HyFwV6Y8QvZcEPNvIby
	 6Sh28GxNFZTPiSISFx1tpsQMZWvrA7gkf+lh/UYEdVJRmYz597L3eBI+N7O63tO0q2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794176091;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=6HlW3TCaZn9o9E0elHB7OhlF6bCGUREXfflt55QEmic=;
	b=2/0sMCr+KoPXkKBHDxIM+OYxxzLJIujoKDwhOn93qKYxu8LXJUNfFTIwsjwuI7fPEL3Z
	 ktfP4+J2w/tGnvxN331LrGcFijTOA9S7xZU0QlFU9bZb1yAwFZN3yZJ4TCUbuJB78zigI
	 LOQdlYbz6LfU0rTdaBUpfUJcrizr/MZKi+lddcnd9pjYTunSoZ+WxuXX7ZzUEMAR/t6jI
	 5D64+POgMVjQbCJ/hvoDdsYCTfH5mSxNXdLsAk0pxOFtCI4u/rF09yR3eCYlsPHnWap2t
	 Nra4HSRZPY4uotGEx4bRaEt275R+NTH04Uuv3PPe0k8uEdd1G6GOzOhHyarucXg04Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=4sf9o8Kw;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5E5606A31C;
	Sun,  8 Nov 2026 22:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E5E5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=4sf9o8Kw
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DCD8FA1651;
	Sun, 08 Nov 2026 23:14:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794176081; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6HlW3TCaZn9o9E0elHB7OhlF6bCGUREXfflt55QEmic=;
	b=4sf9o8KwBP6ebyfUc2HMsNc+xqGEkf+i2THEMu//l222f/IW1FFw4jU8NmqD5DhqrApjLv
	+5Y0kDfvHANEOODffVpikXuoMYCikcjhAlLFHTXLN3wycR4LmBjPf5sWOMp/pPp4SoDygU
	XcUJBmdkbtEIJhdjilniIO0g/5maWpERcYchBdjzi10Vnul/kEFljlbGT/BoykAYCudKLZ
	Z2OELl+Dem8hUS0gniNg/vl7az2hww1AFt46Z98DUEXsXkPG0MZtbXDhZFJJT5dkgaHVC3
	k8X/G4/CMDNTUjftwFbf5ugO/6pRBZGlZNGF6eNrT1XXLuKRWWB3kzXv9v7qCQ==
Date: Sun, 08 Nov 2026 23:14:37 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
CC: theo.lebrun@bootlin.com, conor.dooley@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 sean.anderson@linux.dev, robert.hancock@calian.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net_1/2=5D_net=3A_macb=3A_credit_uns?=
 =?US-ASCII?Q?ent_frames_to_BQL_in_macb=5Ftx=5Ferror=5Ftask=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <179417344193.994134.16378845352525630728@kernel.org>
References: <20261107-nb-macb-tx-error-task-net-v1-1-a2aac5d64d52@tipi-net.de> <179417344193.994134.16378845352525630728@kernel.org>
Message-ID: <9F62B158-0DCC-4741-9A04-E5CAAB9CD11B@tipi-net.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3



On November 8, 2026 10:30:41 PM GMT+01:00, netdev-bot+sashiko@kernel=2Eorg=
 wrote:

> [=2E=2E=2E]

>[Severity: High]
>The commit message describes the problem in general terms: "The frames
>dropped on a TX error are never returned to BQL=2E" Does
>macb_hresp_error_task() leak in the same way?

Yes, same issue but IMHO a different and also pre-existing bug=2E I can fi=
x this in another patch=2E

> [=2E=2E=2E]
