Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27A28E0F
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786786280; cv=none; b=pozV0JcHOMkWmn76F6+KJJtK5NuP1skR9AU9iaHqNK2l/f3tp9P6dW85C6jy3J9axhXTX3fxlfa0Ey5gQLmdInYd383Qjz641v3upetF9dyM8cS8bNArepuU78L1iARbhxrCqqODD6UxiwhZOLGoynQ4Dyblgb9H8n6mXofGZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786786280; c=relaxed/simple;
	bh=ru11fKShwv5gQdLCUPqFSnzljkn2GZujVLvBIb2zq1g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=EJqI88qAfoKqsgX4FwysRNbEMjAs6t121/y6jUc37Iv/76QfXi1weB1Qnfbrzx+R9PeL4Cq8dosTxRIAUxC4aVSWyZCfaVyM2mQevvZFFYvIeQKQeWrzEcEpAf6kEdwxQtsAFtCIwsiNAZ6Gh0rt6YFkLLz31P8BOHzcm2ACxwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FogRtmcv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FogRtmcv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D1E941A165C;
	Sat, 15 Aug 2026 09:31:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 883E2604AA;
	Sat, 15 Aug 2026 09:31:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2B9511C4F483;
	Sat, 15 Aug 2026 11:31:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786786271; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hq1rS7xTHCK+4NmJUeesfVNP7BdMNrqpNoMZPNdvbq4=;
	b=FogRtmcv+0qrXmZ5gk3yFJPH/r4eavqo6i2jPYPljE6ZFpDS5C/DetxzMNKo5v7/Vjxj9v
	pYqhj3dsp+WCfkPTLr5I7fkfApdegPAVrgeWIMGysS1Kh+Jud8MOc9gQ0t+g+2vvyTEIT+
	WkZUz9wwZEhTV86dnpOQ6MI4mJ4+IW0KhtZmfY9Mn9ZsrelREhbn9xuHl/Nb8ffopKWDW6
	+ye2xJQTcgoHUxWB/4/WZ/6BDKl/RZOmWAaFBd7odzuJs6NhgNDRWoObrUfE0CIWS+enZN
	kj24m5DPQjC+04IUceFWmVITFoVzMYpk41UCe5Jky0RQbzuAbbO3kDIQG4lpVw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Aug 2026 11:31:06 +0200
Message-Id: <DKPEVAUSS07G.39Z7NX3WYHZ5H@bootlin.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Paolo Valerio" <pvalerio@redhat.com>, "Nicolai
 Buchwitz" <nb@tipi-net.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v9 00/17] net: macb: implement context swapping
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com>
In-Reply-To: <20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Aug 12, 2026 at 10:03 AM CEST, Th=C3=A9o Lebrun wrote:
> MACB has a pretty primitive approach to buffer management. They are all
> stored in `struct macb *bp`. On operations that require buffer realloc
> (set_ringparam & change_mtu at the moment), the only option is to close
> the interface, change our global state and re-open the interface.
>
> Two issues:
> - It doesn't fly on memory pressured systems; we free our precious
>   buffers and don't manage to reallocate fully, meaning our machine
>   just lost its network access.
> - Anecdotally, it is pretty slow because it implies a full PHY reinit.
>
> Instead, we shall:
>  - allocate a new context (including buffers) first
>  - if it fails, early return without any impact to the interface
>  - stop interface
>  - update global state (bp, netdev, etc)
>  - pass newly allocated buffer pointers to the hardware
>  - start interface
>  - free old context
>
> This is what we implement here. Both .set_ringparam() and
> .ndo_change_mtu() are covered by this series. In the future,
> at least .set_channels() [0], XDP [1] and XSK [2] would benefit.

Sorry for the insistence, but do we have a chance of seeing this merged
before the next merge window? Context swapping is a nice feature to get
into v7.3 and it would allow us to send XDP (& XSK) series that are
dependent on context swapping.

Thanks!

Have a nice week-end,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

