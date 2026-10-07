Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06313B42E6
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365619; cv=none; b=p/ijIm2FsfgqRPGXHLUpH9IXWYS8IUZah4Wko6Xtcn0TGtalwMtszl/lbj5auJByHbNstA1MFmx9OhLoN/AG2/wYnJkC2OXy3nP69R2roGKFZP/rEFVOtEKZr8OGSsehK+JKMrzNx9SPkMp48ushI4cvfkVlBoOdiMXynHoGbvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365619; c=relaxed/simple;
	bh=WZtepZJi+fXZ5a9rI18gjLg8G9TEmqFcbIk1xwQwCTs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=V8hM3qHC69vQ5uvyhCZBKIz62RL3DIuZIUmWpuF0yPpiNlp+llqHfROGLk2ufNARZlrtbAc5KovIXm+Dpvr3aH+O2J5IcOgDnv2xZXm38xLsAJI5h2WH1LVHhFJ9wIDuvWTIJ6CsGhX3Pt2v4gyOPJexpTvxZMxNPBmP9PdCqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jtm4RO45; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jtm4RO45"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EE5894E410C6;
	Wed,  7 Oct 2026 09:33:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A27946074B;
	Wed,  7 Oct 2026 09:33:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EADA11D5006E;
	Wed,  7 Oct 2026 11:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791365594; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bBjAMNE8DIbb1aockxPO2wSzgWV1LwhUufl6QZs6pN0=;
	b=Jtm4RO453BbY7MznnFFdoAvmAxGpuZ232uy+yg9d5bijnvZIz2cDyx535WH1sNzVwdsZD0
	P9ZAWAVYTLQso02PDFu3OqiKCQmtluBfs4ds9mUZtt7ouFeylakDIL7QH6P8aHQMEN9CR7
	4FO12EEKvuUwgm9S7YvmuVRgohgZUycgW9Erml3s6VMFSpSsdA7Y2sNXYR4soIT9zcQ8Ot
	jHfCRWgnBxEmdnyJPPN7oUQXJatEOrjU9PJsJ1sSdTG/2tIHIIBd7aJGWxWNz8X3NurscT
	MMnQUBovj/gWO/S9gLWHW8hS+4gXyDoLew3Yn+HC8lvD1DQtZJ9J4MjsEdx8Hw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 11:33:03 +0200
Message-Id: <DLYI3O7PFN94.V7VH3HSLKEMD@bootlin.com>
Subject: Re: [PATCH net v4] net: macb: rate limit netdev error info print in
 the data path
Cc: <stable@vger.kernel.org>, "Conor Dooley" <conor.dooley@microchip.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Jeff
 Garzik" <jeff@garzik.org>, "Haavard Skinnemoen" <hskinnemoen@atmel.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
To: <taozj888@163.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261007053211.572073-1-taozj888@163.com>
In-Reply-To: <20261007053211.572073-1-taozj888@163.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello taozj888,

I was reviewing your patch but you sent V4 at the same time!

On Wed Oct 7, 2026 at 7:32 AM CEST,  wrote:
> From: taozijin <taozj888@163.com>

We need full names in kernel patches, you have that in your
Signed-off-by.

> Now the MACB ethernet driver print the netdev error information
> directly by netdev_err(), which would lead to a large number of
> error information print if there was a significant number of
> error or just jumbo packets exceeding the MTU received when booting.
> For example, it would print a large number of:
>
> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
> ...
>
> in gem_rx() by received a large number of packets without
> RX_EOF flag set, especially with unknown packet
> type that would penetrate the hardware offload for the IP packets.
>
> The unlimited prints here would greatly bother and delay
> the system booting process unless the source stop sending
> packets since they occupy the console output bandwidth and
> other processes have to wait for the completion of printing those
> messages.
>
> So rate limit the netdev error information print in the receive
> and transmit data path.
>
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Cc: stable@vger.kernel.org

What happened? This doesn't match your discussion with Nicolai.
https://lore.kernel.org/netdev/3e1515e162d084e2200eeaa6074bfbaf@tipi-net.de=
/

TLDR, because those threads are a mess:
 - why drop start_xmit diff?
 - fix your patch autorship
 - check your changelog!
 - check your fixes!

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

