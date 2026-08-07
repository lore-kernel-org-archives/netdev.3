Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F644360EF2
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127202; cv=none; b=VYTTL5o6ACtqdGL0p298P0hCunmshts9ePL8/vRcsyOuU/w6gTgWvm/ZQ5jgmdPysfSfP8cSsCKebUCiw4bAkKWb4MU4UNHKEPnJKxMeToJy2J2L0tmTQbPAwqNyHALS9hrEjs1+VK/yXk32Ok8cWnh1rr0+yV8C8ZGKIRYI9l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127202; c=relaxed/simple;
	bh=uTd1s9/wgO6nffFcb8CCb9qsqIc8tmIH7Wjkjt1fFPI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=seyvqOM/NvUpw+Mk8RcZr6rbDIuc/CzGSyccOjkVVRdzbZKK1bEz4NWUWM1zwZokZDY9jT7/iJZ+lHavmwuV7EU3VcKGbG1AfnUAOxNC9jhzp1GF/QHNXTmLnFgtEnOifHBP32uCp0XYeYH0Sn6JPbB85mVGiPbeX0Fmj/FJt5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jmhmhLfG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jmhmhLfG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B2F4C4E41139;
	Fri,  7 Aug 2026 18:26:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 805DD603F0;
	Fri,  7 Aug 2026 18:26:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6A5811C37D5C;
	Fri,  7 Aug 2026 20:26:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786127192; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uTd1s9/wgO6nffFcb8CCb9qsqIc8tmIH7Wjkjt1fFPI=;
	b=jmhmhLfGEvb0FqTp286m2XRmrSOs0TuTZzZx2fqaSuyMy+hnA6LmqsYVFo1F4SVcJ0K+kO
	LICx9PZ6VbRCTTX+WqZhDUhu9lSqjcBCppfJhxwXRYNf+H7hoVjKrkzUT1N+jhmVpjs+AW
	urIp2cq7KjJuMrQIUwLqoIP6SLto0KAfnjGPfzZUjAN4RfHDrZgbLPGBtuCRe7elzyPQk7
	7KNQxGzBcb8OUToBH9/Yn82WjD4ji8RpvMokPWFvrox8hylIo1vb55DCOz/6v8+X6KuSfD
	N6IMLQi2FxQDGIO07VeiFlRX256WwuLt77oTZfe8jiEi8skO8Vq+64KUW8fkAA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 20:26:28 +0200
Message-Id: <DKIX8UXQE9AW.3V3Y8P4USSJDR@bootlin.com>
To: "Conor Dooley" <conor@kernel.org>, "Vineeth Karumanchi"
 <vineeth.karumanchi@amd.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 1/4] net: macb: Rename MACB_CAPS_QBV to
 MACB_CAPS_TC
Cc: <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <git@amd.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
 <20260807095012.640223-2-vineeth.karumanchi@amd.com>
 <20260807-juggle-porcupine-71281d2d9041@spud>
In-Reply-To: <20260807-juggle-porcupine-71281d2d9041@spud>
X-Last-TLS-Session-Version: TLSv1.3

Hello Vineeth & Conor,

On Fri Aug 7, 2026 at 7:09 PM CEST, Conor Dooley wrote:
> On Fri, Aug 07, 2026 at 03:20:09PM +0530, Vineeth Karumanchi wrote:
>> The MACB_CAPS_QBV capability flag was originally introduced to
>> gate TAPRIO/QBV support. However, GEM IP versions that support
>> QBV also implement multiple TSN clauses.
>>=20
>> Replace this with a generic capability flag that can be reused
>> by other TSN features. Rename MACB_CAPS_QBV to MACB_CAPS_TC to
>> better reflect its role as a general traffic-class offload capability.
>
> I'm not convinced that this is broadly correct, whether or not there's
> Qav support (which is what you're using the newly renamed flag for)
> depends on an IP configuration time define that I think is independent
> of whether or not there's Qbv support (gem_exclude_cbs).
>
> That said, the only platform that supports Qbv that I have the exact
> documentation for does not disable the CBS bits.

EyeQ5 instances have both active qbv and cbs as well.

I see two ways forward:
 - MACB_CAPS_TC aggregating the two, coming from match data
 - split and use runtime-detection, see DCFG1/0x0280 bits 1 and 24

What I like with 1 is that when reading code it's easy to see what
platform can use what features.

What I like with 2 is that it's less churn overall: no modification of
match data once support is merged.

I guess let's go with 2?

(I'll review the rest of the series later on.)

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

