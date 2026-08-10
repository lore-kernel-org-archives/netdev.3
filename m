Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB943DE438;
	Mon, 10 Aug 2026 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367042; cv=none; b=K797dq1QtKPCOzc1L1j0HNcsOPNdvFNLuZScg9zaejuRTIdBJ6QL4oZbJ5Knbl1cGJTUfJ/9f9C1XptM3zz5sWamqce6SWmDCcNAMv1B6J24DjIPO52lrBwbT44QEApbIJYI/YHnwgR8M5tbYPffgcYdpHa+22fVPAuhu77we1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367042; c=relaxed/simple;
	bh=csLxryjZSCJnJZZYiLRo4/kwlCVFAV9BnemOaZJfPq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXraYrXZHGVog0ez/0Mc/j4l9zSrSDuiIbdBB0ohYIGoFPAGrOfl9g7SJBdQ2Qjwe/tT+3HutPqIUe8luLNpjZDAbKgWrlnS27tbCda9NIZuSD/SdT87ar4PIs7QZ2D0T7+F+zoPstf/MQm0MrrnxYUfMDy037EpNiawydlnrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nSmmFU/W; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nSmmFU/W"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7798B1A152A;
	Mon, 10 Aug 2026 13:03:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4BA446033B;
	Mon, 10 Aug 2026 13:03:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 899A411C4A5FA;
	Mon, 10 Aug 2026 15:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786367031; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hUEqfK02muguHMHipiw/K/RN4QdvY1/badYn8vdcLMs=;
	b=nSmmFU/WFUMhwsLRffO2yxwqfbq+C5AUBwjWDkyVF0T2S3uR2LK6e3ivoyij7lSKA60ch9
	DYP+3YlktdgOCc0ZG5CV3azsjMy2JAWUefUYq9Y82kXZzSv53apmcOl1zVmC8gbPMFkDku
	Or++C8hr2+4x+u6kKVueHPKvyoCTn34pnFNALsBcJuFullc8D/2f7NaUeMjjbg0TXoiuL8
	cUP3d1U0bl0RJf8eqihhkNFNAzF+LTn/c8poX8fgPon8GZSYEKSMdH/u56mkZmeWSy967a
	AL9hqT/IrbY6IBkQFDc46PbWds1loAoBtRTecTtQ5zBzPDPixk+c+kFZbvrLqQ==
Date: Mon, 10 Aug 2026 15:03:48 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, Sander Vanheule
 <sander@svanheule.net>
Subject: Re: [PATCH net-next v12 4/4] net: pse-pd: realtek-pse-mcu: add UART
 transport
Message-ID: <20260810150348.121a1a49@kmaincent-XPS-13-7390>
In-Reply-To: <20260809112251.5797-5-jelonek.jonas@gmail.com>
References: <20260809112251.5797-1-jelonek.jonas@gmail.com>
	<20260809112251.5797-5-jelonek.jonas@gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Sun,  9 Aug 2026 11:22:50 +0000
Jonas Jelonek <jelonek.jonas@gmail.com> wrote:

> Add the serdev (UART) transport for the Realtek PSE MCU core. It registers
> the MCU as a serdev device and provides the send/recv callbacks the core
> uses to exchange the 12-byte frames, receiving asynchronously via the
> serdev receive_buf callback.
>=20
> The baud rate defaults to 19200 and can be overridden per board with the
> "current-speed" property.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
