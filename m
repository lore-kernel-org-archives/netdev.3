Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582328;
	b=Vx27OwGuYaPcZOOGHyMMjFS/rpPi8hUwOP1sGdfssb6Wvu//tinecZ1veKYEXYmZliw5
	 xeIZ9KmN+0yYyeY35FaxIwc3XeN14yJCb6AayyhQfJZYi+I3P/A535JCg9KTHdp82ET1i
	 rNg1dreCUYjkcAA8Zzys9ixT6vqTZCTV4Cu8b4PcAV4x+u0WbM2cdZj4wfkIrg2BxHCYW
	 JKPBbwMfocsVWn5NYGDLlOLp5vVfDSbz4d6KfG8EVp5k7AW6HJqJgP/XHpKA46bdj0In6
	 UZQ9k8zXkmwWcnGRgpQbkeRjm95imLFRnffp0XVTyEdDvvSwhjG1cOSL43eI1z8vhsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582328;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=D4Z9hw1h5TRJ5BsgYhWpux1ch96XJn/lw5L3zZBTE5Y=;
	b=AmyBTl3dxUFM5WYzi+eVy1zBcj9dpfevCsHKfkNsk74AJdlhX8mwokKS7iu6evVJEqjq
	 QE5m/MXMipl4cDpwdQbHaoZPfHsF+PaUR5FoJTa9nyv7OQfWdjr4rsb1TNVBlXvPFdRvc
	 tHk1Q6bC6QnJu0fJN0ANOECxOByY1nN1PT5HtLTy2iDc/3zJiEZXYSvTFfBCb3iODi+oj
	 weqwiHbcr/3Sq3eqINXJPqPacNEe931xkFF7rmKTdfG7F1v+gJRbJLfP1HrFSCcMGExBI
	 KSa9REfk9pKlIr2rVuOOBzzMeS3pn3jeuvxwdx0oT/8QSFKpY1+e7GPmj3xM6l1t8zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mUY2svjr;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E745606A326;
	Mon,  2 Nov 2026 01:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E745606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mUY2svjr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=D4Z9hw1h5TRJ5BsgYhWpux1ch96XJn/lw5L3zZBTE5Y=; b=mUY2svjrv6cMF/GBi8xCxI+qRq
	L51xEAsDZrS0jWjYBGThddCDMXDmosGglMmggBpSXSuE+BVnYHJ0BOsfYemACYIk/U+a2H1EJgEvi
	8IWTvE3BWjRO0F8dIO9kFxGubxMkwbXF0KMJ8ZAg7JAsU7iVA/4nXEPqbkhrEbX9a6t8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xNggz-00DiVZ-PE; Mon, 02 Nov 2026 02:18:33 +0100
Date: Mon, 2 Nov 2026 02:18:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] dt-bindings: net: amlogic,meson-dwmac: add
 amlogic,t7-dwmac
Message-ID: <95418d50-a83f-47da-819b-de04eab449e2@lunn.ch>
References: <20261022200640.3101932-1-tanure@linux.com>
 <20261022200640.3101932-3-tanure@linux.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022200640.3101932-3-tanure@linux.com>

> +        rx-internal-delay-ps:
> +          enum: [200, 400, 600, 800, 1000, 1200, 1400, 1600, 1800, 2000,
> +                 2200, 2400, 2600, 2800, 3000]

Is 0 possible with the hardware? If so, i would accept it.

   Andrew
