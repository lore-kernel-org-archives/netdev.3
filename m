Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4B63C0637
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310180; cv=none; b=MBJXZ0e4yv9tnjecOd3hXOfHRyO/9+Zt/42OAOSTQ+S/GN/nHaFdIVfYO2Acs7wY6hAACebJXHQ+COKqIzezB0DxmKiVpL/V0Q2w4Xltl1IWpixWVmW15ML6OwpE9rvmucP6O/dJxsMQdHha2wTmGLP6hV7i57agISZQwYA2oaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310180; c=relaxed/simple;
	bh=o2tbAsjH3Bj3ITMbfCIfI6vFFtcflfvoE/FTmCVqn+8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=uZmI6WeZissH3lRvfIIIpx8rx6Ehmb3Os0vsORfqxsUYjpyeZ6izKLrdu0g0+4Nx5H0guRgLerUuSUAV87WLEMTaYY4dlf5iKodhEZ0LdcFWYCx8RIOI88xDZxjCEzUg3kX685b3GcRRKRS6b3qzUz1OGHOUl0e0wMFsQwvqnpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fmSie3tw; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fmSie3tw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CD2CC4E42650;
	Thu, 12 Mar 2026 10:09:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9BCD65FDEB;
	Thu, 12 Mar 2026 10:09:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D14E710368916;
	Thu, 12 Mar 2026 11:09:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773310173; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nFQgtZbZOzsOMmIw2RPypC2zKtBFpiQqQrkl+bjWfQM=;
	b=fmSie3twSJgvMniuNeOaMgCypnaPOQgNSpPCA5mmJA5rcxWgqqto+u5Cb6zAWbB231nftB
	NdyDoNg4Qqsslt1F+LmG1MVYyhJzMxY9fZCF2e1IGVHQfH6RnXievAt5cPKnJ4k3jyZm0C
	igfswQiWXPdEojOZR3xlF/gTGROjw0W5V0nYOWjGg8jLtUU30e53NnTuDK7nPrl/Km4nAB
	1iUL+Cx6LPrLpkG9bO3Kw50sQYnVnj4fNqjJ2T4R6f0IymoQpiHVlJ7FNf10C6+oHn2UDs
	IKbcUGsdK9r1u0kqWq0PMgO5UQANDEOLyEmgyhWHXaCaAPS98UuWTPXJpNro3A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Mar 2026 11:09:24 +0100
Message-Id: <DH0PZN0WJZC5.26KLH464PMMTP@bootlin.com>
To: "Conor Dooley" <conor@kernel.org>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v3 00/10] macb usrio/tsu patches
Cc: "Conor Dooley" <conor.dooley@microchip.com>,
 <Valentina.FernandezAlanis@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Daire McNamara" <daire.mcnamara@microchip.com>, "Paul Walmsley"
 <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou"
 <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Richard Cochran" <richardcochran@gmail.com>, "Samuel Holland"
 <samuel.holland@sifive.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, "Sean Anderson"
 <sean.anderson@linux.dev>, "Vineeth Karumanchi"
 <vineeth.karumanchi@amd.com>, "Abin Joseph" <abin.joseph@amd.com>,
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 <Ryan.Wanner@microchip.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260310-moneyless-dispense-7bce14b16388@spud>
In-Reply-To: <20260310-moneyless-dispense-7bce14b16388@spud>
X-Last-TLS-Session-Version: TLSv1.3

Hello Conor,

On Tue Mar 10, 2026 at 6:17 PM CET, Conor Dooley wrote:
> At the very least, it'd be good of the soc vendor folks could check
> their platforms and see if their usrio stuff actually lines up with what
> the driver currently calls "macb_default_usrio". Ours didn't and it was
> a nasty surprise.
>
> Theo, you added eyeq5 recently. Does it genuinely have the same usrio
> bits as the at91 devices?

Sorry I missed your direct mention. After checking (because I completely
ignored this part of the code before), the User I/O feature is disabled
on EyeQ5 & EyeQ6H. It can be seen from DCFG1 BIT(9). It was invisible
because the USRIO register turns read-only when User I/O is disabled.

1. So I thought about adding runtime detection.

2. But then having eyeq5_config->usrio made no sense so I dropped it.

3. And then I thought that a config having usrio being NULL should
   imply MACB_CAPS_USRIO_DISABLED to ensure we don't NULL dereference
   the bp->usrio pointer.

#1 is useless for EyeQ combined with #2 and #3, but it should be useful
for the many compatibles that inherited the wrong default value of
at91_default_usrio.

I am sending those three patches as a reply, feel free to pick them up
if you consider them useful. They apply on top of your series and have
been tested on EyeQ5.

Thanks Conor,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

