Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5CA3939B6
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908893; cv=none; b=FQZdgjIpdBpFXPttHd9eienA5AQdYtz0weuhccZnWVydRBloZ7+bSzW8i+xf+oV2eqW8Yu0AJTUZFi8fqiAF0FYU5+O/AWfJgErk2XbqPxgvAdtsyK+u6hBUeX+DVLZsykHdV5zaqYt9cDg+o3YX+uaVbzVq4VWN9mD5ODKhgdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908893; c=relaxed/simple;
	bh=NxqJ3F5F2fcQeY3OCz8eCtxPd/hh4STLXcjymWcf4KI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=sCM04QIe7dhPGZEWcpgM6xHhvzwu+J0wanJx7UeAvrEa/xGt70Mjndv+31gfjWkXdsN2M6sN7R9+NRZkJCbDSfH4Z/VKvkcfopAvnnLyHv5pXNblHTy8/iRUDokRhxwbhF62eGx7211qqPac8HP0ovtPMl1iC+ffwjF8uSEnEFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uMx487Ci; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uMx487Ci"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D3DDD4E413FD;
	Fri, 28 Aug 2026 09:21:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9F01F60537;
	Fri, 28 Aug 2026 09:21:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E90F111C78028;
	Fri, 28 Aug 2026 11:21:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787908876; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TLtk2lBHyf4laQvUhBYdFUmCeCvqgv04fPuI7JBoqdk=;
	b=uMx487Ci3CN9sAO4PuSX+wMlCxyJVfgtm6++wQkYdYa0HeHqEKAGhJ5V/mK+2BYL/52uND
	HSszgTcp4nFCq+EePbf0n+VA2ZZm+pQRegAPrAcauy1JB5xpNIl5ig3v0hzUTqFcXkT+rN
	bYXcVzeWDW3TtJ6iZBl6VYHpX7bHKT7HE3+F+5KhpUB+6aNYhK7nfRoimLhiT/XzemGKwt
	Rh6rDLezF9d4milbXTbqjlLwlzTm4PAr+nPoTxsbyMlfxdHuberb4OfyWqSF1kipgEdDn9
	iQpzlkk5NJYguRDF4+sNdlOPwz8mJRFyDvQrlvsvsP5tWrcHJi33k7KhiKuBTg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 11:21:12 +0200
Message-Id: <DL0GSSXQPVDE.2O8IIQA60348U@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 1/4] net: macb: Rename MACB_CAPS_QBV to
 MACB_CAPS_TC
Cc: <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <git@amd.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Karumanchi, Vineeth" <vineeth@amd.com>, "Conor Dooley"
 <conor@kernel.org>, "Vineeth Karumanchi" <vineeth.karumanchi@amd.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
 <20260807095012.640223-2-vineeth.karumanchi@amd.com>
 <20260807-juggle-porcupine-71281d2d9041@spud>
 <DKIX8UXQE9AW.3V3Y8P4USSJDR@bootlin.com>
 <080ab679-cd69-48ed-b96d-c515741101ba@amd.com>
In-Reply-To: <080ab679-cd69-48ed-b96d-c515741101ba@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Aug 10, 2026 at 12:11 PM CEST, Karumanchi, Vineeth wrote:
> On 8/7/2026 11:56 PM, Th=C3=A9o Lebrun wrote:
>> On Fri Aug 7, 2026 at 7:09 PM CEST, Conor Dooley wrote:
>>> On Fri, Aug 07, 2026 at 03:20:09PM +0530, Vineeth Karumanchi wrote:
>>>> The MACB_CAPS_QBV capability flag was originally introduced to
>>>> gate TAPRIO/QBV support. However, GEM IP versions that support
>>>> QBV also implement multiple TSN clauses.
>>>>
>>>> Replace this with a generic capability flag that can be reused
>>>> by other TSN features. Rename MACB_CAPS_QBV to MACB_CAPS_TC to
>>>> better reflect its role as a general traffic-class offload capability.
>>>
>>> I'm not convinced that this is broadly correct, whether or not there's
>>> Qav support (which is what you're using the newly renamed flag for)
>>> depends on an IP configuration time define that I think is independent
>>> of whether or not there's Qbv support (gem_exclude_cbs).
>>>
>>> That said, the only platform that supports Qbv that I have the exact
>>> documentation for does not disable the CBS bits.
>>=20
>> EyeQ5 instances have both active qbv and cbs as well.>
>> I see two ways forward:
>>  - MACB_CAPS_TC aggregating the two, coming from match data
>>  - split and use runtime-detection, see DCFG1/0x0280 bits 1 and 24
>
> This was the initial plan for the QBV implementation.
>
> Quoting from
> https://lore.kernel.org/netdev/20250814071058.3062453-3-vineeth.karumanch=
i@amd.com/
>
> "The 'exclude_qbv' bit in the designcfg_debug1 register varies across
> MACB/GEM IP revisions, making direct probing unreliable for detecting
> QBV support. This patch introduces a capability-based approach for
> consistent QBV feature identification across the IP family."

This is surprising to me! What's the source? Do you have AMD hardware
where DCFG1-6 have diverging layouts?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

