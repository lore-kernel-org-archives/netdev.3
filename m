Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9107D4FDA75
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903789; cv=none; b=sJVuch+nZ2yexA6SXk83smgNdMV6As4Wced3CpiiUs5RHeMVCc6bFGQIo9oW4PTSVZx/gvgwerexsuYi160xV4/IY1cNrzUrm4BYn986UlW9/how01jQn0pnMvgU6PMfI+DIMGvrpq/RLuidl9eHED7e/aMZxT3YCeDoVcMfh/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903789; c=relaxed/simple;
	bh=VIcsaF53OzHfwToJnO2vo1HPZLJEmXFotEu93iXColI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=SqfRSgXmivTZSFlf2v6KXVc/JqU7/vs7KcLGP1oVPCVzQshKv8jPbb2q9TH12AIqxkw+jrKPdWeesWAerQh5DWcEFYIh/VKolnRXN+mtOyaRxrq7LG+XUkAHzmDNr8wIgVFUG4WJ2bb4mYn+nLpv1CMbZ1tQreEc/H50bIRVgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tY/FrQT0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tY/FrQT0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 115841A113B;
	Tue, 13 Oct 2026 15:03:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D6ADD60362;
	Tue, 13 Oct 2026 15:03:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A305D11D7176B;
	Tue, 13 Oct 2026 17:02:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791903783; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2rST7unSge9MnhfzEfaCIX116V0X31MgNwpNnpjBMfM=;
	b=tY/FrQT0Fiait+NPx8pSk8GXJIF7f/Zvka5BNcIfTddIrvOJUEIwxeJwGN/1fVxPs5lF8W
	tsc2OQgd1tEWxzj/oFaygga+S+6/Wz/EVw3aBDdS6v37lIRKgBtiDP/0ERxY8/5Fdj43Vi
	kS0ag6ahZXPgDn9MkZqF/EM4HTQbJjbnJPww7fn1A6drasGx20qQp+49CFiSDPenAmtKgB
	UMMYw5hxvd3uOy+Sx1yBmF4w9T31WmKcvPOoT/0YTMhFk6gqxKZuSEDBc4WUqrxxNL+Wdx
	RZZbEcFgr9h85d4lj6nQjClgDo9Yo/rd4wZU29tp/yA9L3csDChqm0DtgrvKZA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 17:02:54 +0200
Message-Id: <DM3SVHWDO65N.SWXCPUUEFQNE@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v10 1/8] net: macb: introduce macb_context
 struct for buffer management
Cc: <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <richardcochran@gmail.com>, <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <pvalerio@redhat.com>, <nb@tipi-net.de>,
 <vladimir.kondratiev@mobileye.com>, <gregory.clement@bootlin.com>,
 <benoit.monin@bootlin.com>, <tawfik.bayouk@mobileye.com>,
 <thomas.petazzoni@bootlin.com>
To: "Jakub Kicinski" <kuba@kernel.org>, <netdev-bot+sashiko@kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261001-macb-context-v10-1-beb541bbb7df@bootlin.com>
 <179115680422.434549.3193325311731249627@kernel.org>
 <20261007162223.595dee2e@kernel.org>
In-Reply-To: <20261007162223.595dee2e@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello Jakub,

On Thu Oct 8, 2026 at 1:22 AM CEST, Jakub Kicinski wrote:
> On Sun, 04 Oct 2026 23:33:24 +0000 netdev-bot+sashiko@kernel.org wrote:
>> - [Medium] The NAPI poll handlers read the context after
>>   napi_complete_done(), and nothing stops that context from being freed=
=E2=80=A6
>
> Looks legit at the surface. I was going to try to double check and
> then realized the series no longer applies :S

Yes that report was correct!

napi_disable() only waits for napi_complete_done() to be called,
but our poll functions still dereference the rings after the
napi_complete_done() call.

That's an issue for all drivers (quite a few are broken in that sense).
I see two solutions:
 - Avoid all dangerous reads in NAPI poll after napi_complete_done().
 - Wait for full NAPI poll to be done using synchronize_net().

We cannot use the first solution in MACB as we must re-read rings after
unmasking IRQs to check if we lost a wakeup signal, see commit
0bf476fc3624 ("net: macb: Fix lost RX packet wakeup race in NAPI
receive"). So we'll take the second one.

This bug is unrelated to context swapping though; the upstream driver
already has the same race condition. Sashiko rather funnily attributes
it to our series; somehow the use-after-free got more serious.

I checked for precedent as I would have been surprised we were the first
ones to land in that napi_disable() subtlety. See commit eb41a264a3a5
("net/mlx5e: Fix race between DIM disable and net_dim()") which uses the
synchronize_net() mechanism to prevent against the exact same race.

V11 has been sent already, see:

[PATCH net-next v11 1/9] net: macb: close race between NAPI polls & ndo_sto=
p
https://lore.kernel.org/netdev/20261013-macb-context-v11-1-b27785167566@boo=
tlin.com/

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

