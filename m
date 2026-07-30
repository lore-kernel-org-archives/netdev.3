Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283CB4503ED;
	Thu, 30 Jul 2026 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428284; cv=none; b=T02yhLiwg83uWS4+v0XpJ0/J2DzU1LAP5hYgVdJqZzD2x3Q27ytn7oUFSG5hmdJ2X58e/f4wKVV8OdyTqPNOganbayl878Ka/5xNdkC+PV6H+MmRs/0EWLxWscsA2k540JpcHMDkKHTQtR1JFU/620xhXIhSQdqUoGgSGvn5L9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428284; c=relaxed/simple;
	bh=vJsCj0WGJFT/r3pSwZHqh0YnsZAM2HXVrUjgnJln13M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Ufd8Nj4i+TLbdxucAunEFap8OpiSYtbM9X1MXfQBLePI+6aWuhLV93JIj2KF6znS+iBxuRerDu5cMvT8A8zU2KNncCUuIR1lj52dZxF8ccUlH1SB9Smwvhr+AHh4gaYFSS0ewlwLTUCxxsusfRWp77aAGtrMRn/TtFiXdeAu8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UiurkyXn; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UiurkyXn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9AAF51A1325;
	Thu, 30 Jul 2026 16:17:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 646275FFA8;
	Thu, 30 Jul 2026 16:17:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1DE6711C15DAD;
	Thu, 30 Jul 2026 18:17:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785428278; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6zpxkZ89sJOGEuFlHm5pF9gcWQR7fy9CI9LVjWccDQg=;
	b=UiurkyXn+4Yr+Ep/gQss2cw6qZJ68TW0pLO1h6aJbL1JusuA6JIB5IT1Nk+9M28+yp/5/L
	luLSXpcAElCHa1LeTtS6j8qRqMRSJwqM8l+o6WZAp/NOjY0mqZddEe83Kh/QvLwkJI4EIm
	EIWIWYR/C6s5HPT+W8mh12zdxRSJTdlZISZftHha46pkMi6fDFe4gk1Xhf4wlcv4sRq6xe
	qsWZYAq/Z+xz6nLRYBcQIe/RuuJy4ACnRzdsKmLlVK+NyhIOt6loxxG37t7JigwHVZ81BZ
	SrqfnuNoPv0miMuDW2cBWi0VeFoRZWeRj5iu3uhgYCkyV9OaqMpea19bH5OCTQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 18:17:50 +0200
Message-Id: <DKC1I0FXMZJM.3ESMASUANI66R@bootlin.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Paolo Valerio" <pvalerio@redhat.com>, "Nicolai
 Buchwitz" <nb@tipi-net.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
To: "Paolo Abeni" <pabeni@redhat.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Richard Cochran"
 <richardcochran@gmail.com>, "Russell King" <linux@armlinux.org.uk>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v5 00/15] net: macb: implement context swapping
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
 <55b10825-5ecb-4abc-8551-bc4fc3c20365@redhat.com>
In-Reply-To: <55b10825-5ecb-4abc-8551-bc4fc3c20365@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Paolo,

On Thu Jul 30, 2026 at 1:52 PM CEST, Paolo Abeni wrote:
> On 7/24/26 5:29 PM, Th=C3=A9o Lebrun wrote:
>> MACB has a pretty primitive approach to buffer management. They are all
>> stored in `struct macb *bp`. On operations that require buffer realloc
>> (set_ringparam & change_mtu at the moment), the only option is to close
>> the interface, change our global state and re-open the interface.
>>=20
>> Two issues:
>> - It doesn't fly on memory pressured systems; we free our precious
>>   buffers and don't manage to reallocate fully, meaning our machine
>>   just lost its network access.
>> - Anecdotally, it is pretty slow because it implies a full PHY reinit.
>>=20
>> Instead, we shall:
>>  - allocate a new context (including buffers) first
>>  - if it fails, early return without any impact to the interface
>>  - stop interface
>>  - update global state (bp, netdev, etc)
>>  - pass newly allocated buffer pointers to the hardware
>>  - start interface
>>  - free old context
>>=20
>> This is what we implement here. Both .set_ringparam() and
>> .ndo_change_mtu() are covered by this series. In the future,
>> at least .set_channels() [0], XDP [1] and XSK [2] would benefit.
>>=20
>> The change is super intrusive so conflicts will be major. Sorry!
>>=20
>> --
>>=20
>> During iteration V3, the LLM raised many race conditions because BH
>> features aren't disabled at close and might do a variety of bad things
>> (interact with NAPI while disabled or re-arm IRQs). This is NOT fixed
>> here. Here we focus on swap, not close. The series is way too long
>> already.
> Note that Sashiko gemini has more to say:
>
> https://sashiko.dev/#/patchset/20260724-macb-context-v5-0-569b1852bc7f%40=
bootlin.com
>
> At least the possible deadlock in patch 13/15 looks real to me.

Thanks. I've patched it by moving printk() calls out of the bp->lock
critical section. I'll appear in next revision.

>
> Please also note net-next commit c82ff94592fb

Thanks for the hint, makes sense. I had heard "rumors" but didn't know
it was official policy. I'll make a full pass before sending next
revision (tomorrow probably).

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

