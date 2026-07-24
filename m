Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED5439906
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901655; cv=none; b=YQGYi+PU/BNs0luHEz+qxL5goiGbmy3DZelthLxv7J524ThQW30fbTHCwa/QXoUh1H3y7r77I9JMYt/3EOmS4fWwSls7GdVai8IghEOQk2mRLu7lFA7jjBB/6VVydcXSSeP8dl5KYrVU02WY5NVY31ECaRmawEw/MS+kuYWNveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901655; c=relaxed/simple;
	bh=ekIHPDMGVmK412YWOFwYcobGS3PK0L8wjUGTfb7ECeU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=hO0LZHxoMqkuAfcUuigZNFZvmWUsqGBImpZnqzJYE2Q/Cvq0X7ZgxiG5zdRiW25AsQ96aLt1OVf6fpAWOPquZKbJUFMcJpH5sPsaNOdw2kdVKE5gy16vNvFIF+cF5DM4ggDAoK0EPfSZoGnWokeIQabWkAzYg/clESPH7DN5xZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SByKBGMt; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SByKBGMt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6A3474E40F2F;
	Fri, 24 Jul 2026 14:00:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3704160395;
	Fri, 24 Jul 2026 14:00:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9613D11C1256B;
	Fri, 24 Jul 2026 16:00:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784901647; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cFFeWooi3gLI7K85QoVt1R3Bze7S8YUt4DaL8b4ttZc=;
	b=SByKBGMtJO/8cpifylU62RWpgkHkwYe5YFsATqVcHvPvDEXbmCZNhUdzY/W+RpVesppIyC
	Jjxdno2+XGeQ88CdfD6K9Yc05Mv2YkFaiTxrEmmkhZgcyevgOOns3PjGfoyywnh0jFAsLA
	JFO2w3sg+BJnKzf+I1TL7DFWds/gIDRa2EGgum47NpqwXr3MWRhR/99NY50jByi4oayYEz
	5xYY/SCMz1IU5/Kta4oXHPRWq6HvdNRfuMkv/ovesGf/Fv8eiAp20ydxADod1cJJjWQMzx
	lVC9ce73x2ihcmcQbfCwRKgDhlfBcRclVSW7F3lC8WCep2mn5NbXdLt2tc9dMQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 16:00:44 +0200
Message-Id: <DK6UTRKMBAIF.1C77ZFOW65OAX@bootlin.com>
Subject: Re: [PATCH net-next v4 07/15] net: macb: introduce macb_context
 struct for buffer management
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Paolo Valerio" <pvalerio@redhat.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
 <20260717-macb-context-v4-7-0acbe7f10cdb@bootlin.com>
 <06571ee60d158eb661ab72d577864321@tipi-net.de>
In-Reply-To: <06571ee60d158eb661ab72d577864321@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3

Hello Nicolai,

On Sun Jul 19, 2026 at 12:38 PM CEST, Nicolai Buchwitz wrote:
> Hi Th=C3=A9o
>
> On 17.7.2026 21:48, Th=C3=A9o Lebrun wrote:
>> Whenever an operation requires buffer realloc, we close the interface,
>> update parameters and reopen. To improve reliability under memory
>> pressure, we should rather alloc new buffers, reconfigure HW and free
>> old buffers. This requires MACB to support having multiple "contexts"
>> in parallel.
>>=20
>> Introduce this concept by adding the macb_context struct, which owns=20
>> all
>> queue buffers and the parameters associated. We do not yet support
>> multiple contexts in parallel, because all functions access bp->ctx
>> (the currently active context) directly.
>>=20
>> Steps:
>>=20
>>  - Introduce `struct macb_context` and its children `struct macb_rxq`
>>    and `struct macb_txq`. Context fields are stolen from `struct macb`
>>    and rxq/txq fields are from `struct macb_queue`.
>>=20
>>    Making it two separate structs per queue simplifies accesses: we=20
>> grab
>>    a txq/rxq local variable and access fields like txq->head instead of
>>    queue->tx_head. It also anecdotally improves data locality.
>>=20
>>  - macb_init_dflt() / macb_get_ringparam() do not access
>>    bp->ctx->{rx,tx}_ring_size as they will/might run while interface is
>>    offline and ctx is not NULL. Instead, introduce
>>    bp->configured_{rx,tx}_ring_size which get updated on user requests.
>
> nit: In the commit message: "ctx is not NULL" should be "ctx is NULL".

Indeed. Interface offline =3D=3D ctx is NULL.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

