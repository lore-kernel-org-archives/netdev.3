Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDA833A6EB;
	Mon, 21 Sep 2026 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981308; cv=none; b=hgg9K0xxSjsEK63PV6000Hw/uFhrZmp8hYgAEMih3rTiZ6TRqG1gavbchDxmKXsGObrJ80W8YXSF1F/r+x84svFKQ50UPcjMdlFPCuqO3vSKslKpp+QtmAPK1qVJby3FRjwsLFnsZbfUKEsciXvml0Qgpl0QIAMeJ2xrYWKwYYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981308; c=relaxed/simple;
	bh=Z2SoGjWG+kTjpmfzxSW2WbC/gloFMVtxPD/1PXeKi4w=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=F0LRsNq3J1a1i6w6oTI2nfKgbmLVKvOeN/3oDuV4cGQlSt3NEYTJvWQDKHpW5BdoPKwiuNLiAcYaOYJCdgHTj1FxYPa0/8IrNDe+l6h4QApnS5OiDasVYTZOApnnKS02XEZ9R9t2ygqYzcc0uRHKIX+rSQzkObtqlQYd8fuUFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RrlX4/oN; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RrlX4/oN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 992BD1A0F8C;
	Mon, 21 Sep 2026 09:01:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6D06160339;
	Mon, 21 Sep 2026 09:01:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DEF8E1032904C;
	Mon, 21 Sep 2026 11:01:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789981303; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z2SoGjWG+kTjpmfzxSW2WbC/gloFMVtxPD/1PXeKi4w=;
	b=RrlX4/oNYKQM3FY3Pk+7lzI5bM0YDc2y7a0CS5gDJux2xsWKpCLR8fogTnf56iyp7vKT0M
	wZf2nA+ST/8tZlReB5cZMKpip1jH6O4JlkpL91nRagD1A5HJ6PrlntRl9U3u7/5QZyItvn
	xRhL24mu8yG05oI7DpbYpfzMn8SrhLu+HWm6JEJrLeQt7y0SLXasQbRvgpZOEFESEUWAUa
	+RB6t+HNPG5O2MtLbO821vIHBAOyqmuIY+/jN0PpeOYbkLTlBLrwDaeH9hrNADcyDWjnvP
	IR6+Tju6EpdK2kIQnB8ESWlZBfcP7h+A34WL1MmQednBeKS5Rh2CEa45l6pMKQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 11:01:41 +0200
Message-Id: <DLKVEXS7X14N.XLLMBDDX6ZJW@bootlin.com>
To: "Zijin Tao" <taozj888@163.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH] net: macb: rate limit netdev error info print in the
 data path
Cc: <linux-kernel@vger.kernel.org>, <conor.dooley@microchip.com>,
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260920095839.62852-1-taozj888@163.com>
 <DLKVCOXTNGVZ.3CC6KFXDIFJ3X@bootlin.com>
In-Reply-To: <DLKVCOXTNGVZ.3CC6KFXDIFJ3X@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Zijin,

Also your To/Cc list is weird, make sure to use
scripts/get_maintainer.pl (or use b4 for patch
management which uses it automatically).

On Mon Sep 21, 2026 at 10:58 AM CEST, Th=C3=A9o Lebrun wrote:
> Hello Zijin,
>
> You sent the same patch 3 times?
> Message-ID: <20260920095839.62852-1-taozj888@163.com>
> Message-ID: <20260920100658.65087-1-taozj888@163.com>
> Message-ID: <20260920100920.65773-1-taozj888@163.com>
>
> Also you are missing the prefix [PATCH net] or [PATCH net-next].
> Read up about this here (and read the full page):
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> On Sun Sep 20, 2026 at 11:58 AM CEST, Zijin Tao wrote:
>> Now the MACB ethernet driver print the netdev error information
>> directly by netdev_err(), which would lead to a large number of
>> error information print if there was a significant number of
>> error or just jumbo packets received when booting.
>> For example, it would print a large number of:
>>
>> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
>> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
>> ...
>
> This whole patch is LLM generated? I don't think this "PHYT0036:00"
> device name could ever exist. Please don't hallucinate kernel logs.
>
> In both cases, I prefer the commit message to either indicate whether it
> is a theoretical bugfix or a bug hit in practice. I know I've faced
> such a log spam on MACB in the past, but I don't remember which log
> line it was.
>
>> in gem_rx() by received a large number of packets without
>> RX_SOF or RX_EOF flag set.
>>
>> The unlimited print here would greatly bother and delay
>> the system booting process unless the source stop sending
>> packets.
>
> I don't understand the relation to the booting process here.
>
>> So rate limit the netdev error information print in the receive
>> and transmit data path.
>>
>> Signed-off-by: Zijin Tao <taozj888@163.com>

Thanks Zijin,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

