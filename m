Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDDE3E5EDA;
	Fri, 17 Jul 2026 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281588; cv=none; b=UNqOJX/sANM7Sd2+RgUHVGxEfA5G2+sQLj9K2jTEaiPW7ikKSXmgA1AHGDEBD/Ffkf69fblMxZFRB2WrxhorSLI/GUgtO1xkfkE8CyJFsAuH3sFq9JcgUBsX02fLBW7OseXIAWx4VSaPt0+1CX+VjbxlCg8PVd2HqHAhxQ7baZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281588; c=relaxed/simple;
	bh=BjhEIjHPwJkzUIxnd8Nm51VelkU5GvindlLB+VGkJPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuUZCBzyj8kupYyFvaqvEJHzlovvyU3T731c01FS45tlrwIVoK99vRdGXJuLmUmnRyMPh+8qiSE6ThoDL2SFuTa33lqLN/NwQaQSWm0VDsYajBGyUZrL5wqnMGQXVptY+GxkQiHHJ9S/tQIK/Adp8bsSKKlJoHETwrK+QaSfBsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QrOT4T1o; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QrOT4T1o"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 393F51A1049;
	Fri, 17 Jul 2026 09:46:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 083CE60361;
	Fri, 17 Jul 2026 09:46:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F8D411BD0C29;
	Fri, 17 Jul 2026 11:46:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784281583; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BjhEIjHPwJkzUIxnd8Nm51VelkU5GvindlLB+VGkJPE=;
	b=QrOT4T1o6n2JSEub4HrmxiK15zVBhIFVIY+v1Md7+JbTKywysO2R9zgRlhV2ioYWpkSgW0
	LNQE3B5BgyQfID2RJ+dnVLo3sb3MdIMTM5QS1zq3FxBmsPAn4wyyx9DTLZHnJKjBWRm+VW
	3iVREhbGQJGY722NTwsqOwla6sRbrOZaLzMw7JodnFQs0QPHOEE1lFKB2fT3GquTkFurr3
	ZqWUJNJ9vNbEZnPQyGo/m/eTAPVFKRxncMPE+H/3+8Vf54ZNh7rpIA4pnjOBnhQ8dwMSjf
	vXRe4zKbCpuXhalF4357Cp8ATNkHJwG/VVrOL0dxlQ85rPl6Nw8R/zis45YgSA==
Date: Fri, 17 Jul 2026 11:46:18 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v8 4/4] net: pse-pd: realtek-pse-mcu: add UART
 transport
Message-ID: <20260717114618.7d54c53a@kmaincent-XPS-13-7390>
In-Reply-To: <20260715075530.2491534-5-jelonek.jonas@gmail.com>
References: <20260715075530.2491534-1-jelonek.jonas@gmail.com>
	<20260715075530.2491534-5-jelonek.jonas@gmail.com>
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

On Wed, 15 Jul 2026 07:55:28 +0000
Jonas Jelonek <jelonek.jonas@gmail.com> wrote:

> Add the serdev (UART) transport for the Realtek PSE MCU core. It registers
> the MCU as a serdev device and provides the send/recv callbacks the core
> uses to exchange the 12-byte frames, receiving asynchronously via the
> serdev receive_buf callback.
>=20
> The baud rate defaults to 19200 and can be overridden per board with the
> "current-speed" property.
>=20
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
