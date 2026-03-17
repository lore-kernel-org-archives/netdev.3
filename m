Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44164224249;
	Tue, 17 Mar 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761524; cv=none; b=g/04h9Yao0voGTK0rKYtCjC/lHPkFX90S3EBBJbiKArbyRkgrUpOJtn4WY53RFvBOvaTm32DrXyvVkqTWxhM9ObcRCb886dBKQCDh3behcMLAbIwHyISV8lm1OuDiRH1NixPGZaM+6aMcPGQOU/1/cX4aKgFKhQDcc7sgN7AOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761524; c=relaxed/simple;
	bh=OY0K6FBV/7jWVvsW7bGyr0VgEm5RsdpEOhpcLB2Y/WI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Oay+/hhvJt3uHUb5laLMBcoSFvB/f5BKNVIH3ZldvtbsY3iIyq8SSb+UQu938ZNQVhd0VXxqezFZzCMMkjmeVZ9uG2ghOywdLMLjRrfq464F53qvNs4IcdJq16rICvdUP9dV0CZxD3n1e+ipbUsQVWghHB4HJd6aFTa5KSQFXe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fhSBufwR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fhSBufwR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B24604E42656;
	Tue, 17 Mar 2026 15:32:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 700675FC9A;
	Tue, 17 Mar 2026 15:32:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE93C10450617;
	Tue, 17 Mar 2026 16:31:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773761519; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+5u6MoGFtgIcW2sEYj40m3lzX61iiWgVwntgDRRPBvA=;
	b=fhSBufwRISuEzdz0zkFRjzambEReyZCL7JrHzTCRvyAQaYQbycsJ9ZO9nZopioc+pf8qUD
	aefz0r3ADCV7pqSkpjO9MDbvgmsOsDI3lHYVKWL1VSfi3iQehryImAg8dE+CfjNogbAUWt
	UDvIatrHVgBcn0PrnZNVTaboBA/1xHKuNBMer0TzavYh8s2TfZ8JrzSjgJ/n8UM4NP0jXn
	xg1+YOW1gHr6CQ+HBSZ1OB3FHQu6pP87ETS7WELHPgXayx+juOPT1oAk6UgfW5+m7FIhNu
	C2FjsdKNBwDy7tTXYuWOsxv4lA042sVerl5CF+4wPHm7DRECiq5eFSAeWtRupg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 16:31:55 +0100
Message-Id: <DH55ZAW09CJW.18CMNS7Z3UWOY@bootlin.com>
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: net: cdns,macb: add a
 compatible for Microchip pic64hpsc
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Charles Perry" <charles.perry@microchip.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260313140610.3681752-1-charles.perry@microchip.com>
 <20260313140610.3681752-2-charles.perry@microchip.com>
In-Reply-To: <20260313140610.3681752-2-charles.perry@microchip.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Mar 13, 2026 at 3:06 PM CET, Charles Perry wrote:
> Add "microchip,pic64hpsc-gem" for "PIC64-HPSC" and
> "microchip,pic64hx-gem" for "PIC64HX", compatible with the former.
>
> The generic compatible "cdns,gem" works but offers limited features.
> Keep it as a fallback.
>
> The GEM IPs within pic64hpsc have their MDIO controllers unconnected
> from any physical pin. Add a check to prevent adding PHYs under the GEM
> node.
>
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/net/cdns,macb.yaml    | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

