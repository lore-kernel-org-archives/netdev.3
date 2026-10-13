Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512151614D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898156; cv=none; b=sHqoLwvXnJQlnji/24qIkKR2fR+Bq6zT96QmWQrCPEAHKSED4Efl5XLYgyI9fuYRRMLxXTHbMfSSLY9orbD31lkl1vqQ1TNTHbyiW9EwmoSTza2fP0CZSyplfN/f/LxI+IK0/1nQCY/7RcUCuKBN0+b/eLADtc7SoHLuQSVk2ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898156; c=relaxed/simple;
	bh=EbN7Knrt0OCrGMFCuwdJc51LQrTYRZZbRQk0u9xqksg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=FK9QmICWdpiMdTC62zkk9iEBZNh3BkjlcMY4gb7BS+JxsO/Dm845G0asaTjoy7bNRls8GfxnnI6GQXf/E973qDxYxl4urAkQ2sbI71HIbmGHouOXKuqujfe02lw7Gnj2IUB7BKxVwQwmDadcHkwIvN63YyrRVXwg1oDXxz/vvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aDcaMASs; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aDcaMASs"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B36FAC653EC;
	Tue, 13 Oct 2026 13:30:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 118CF60362;
	Tue, 13 Oct 2026 13:29:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6E7011D7147B;
	Tue, 13 Oct 2026 15:29:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791898147; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yjwr2Aqkb02cz2mzO8i3fWKLC5oCZd8nSAd6KcG3YKQ=;
	b=aDcaMASskhxDB62XaICTggXflf3lUiyNrR+XIijxlfMkwW7a4ZIBik1/BIxkqIG9FGA1Vn
	nAEN8bLNHyOhvybAtiNpEv/F+OKfK0xGxorR2rzU+Ygesu5Jey4nOGfZPAGOXfhS1mnd23
	JOjE5ufHSbO2Q5fb+yzS2ufU5e4tVIonnvzWEIH7TRMsvMVnqFTAAHtMkWsUSOSFpt9s/D
	p+CdVpLRHcY4KkLqk4Fuu5qfsC6JDwiLNhhK9j9Xb8mL4UD4W2o+SsmFNoEEZjyU70jffL
	vaW/DIZX38oulNwioBKX43X6TjjrkStNjw8CrSS33b0l2Aj9fgro5A/m6JyBwA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 15:29:01 +0200
Message-Id: <DM3QVLRVVXH2.1WVQ5I6JTPJE5@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v11 0/9] net: macb: implement context swapping
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Paolo Valerio" <pvalerio@redhat.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <stable+noautosel@kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
To: <netdev-bot+sinfo@kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
 <179189760303.2527009.1878014132075349485@kernel.org>
In-Reply-To: <179189760303.2527009.1878014132075349485@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello netdev-bot+sinfo,

On Tue Oct 13, 2026 at 3:20 PM CEST,  wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

This series has been tested on EyeQ5 which has two GEM instances.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

