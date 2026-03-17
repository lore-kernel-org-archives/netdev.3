Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD862D3A7B;
	Tue, 17 Mar 2026 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761549; cv=none; b=huNLHUbI4NqL8Yd0w3zXxsWkrWiohKv7OmSdweCPBkLFcySFOvCcCxGT5pO9t9pUzl66XX0JOfKWVaORZQ2XSQGPASJZvTXwkK3pJ4558XwXTR5sMtq0/2WYCfIDdjRODrz1GEtQa+12XINmfcSxlmF09vV9xaDDVqSHdS+9bjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761549; c=relaxed/simple;
	bh=dB5xlhv0AK8726vApRjjf7WxxwLj9XH/7EBSZ5F8wFU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=FDIUn0q5RoEyoNdgJWuWjfJmluwwTdorcSL1ezJJSnqwJjRNfrokd5gb4FSvHOdziIq2P+llO8QYs9cH1RoWw4fmNsFjRRFyNtrsWyxz0Zn8KEseSKEj/Hcocx3nNHuhoTnbId/Y/Mi9e9JVnsNlC6HBgnBYC0sdi9ArA10dwF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VfaB9n5K; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VfaB9n5K"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 63BDC4E42659;
	Tue, 17 Mar 2026 15:32:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E2715FC9A;
	Tue, 17 Mar 2026 15:32:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 255331045061A;
	Tue, 17 Mar 2026 16:32:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773761546; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9/oN1sDc0ufWvDNWTMdGmLevclcivf0GDYvT6kTHMY8=;
	b=VfaB9n5KmeBybFfomLE3xUwaa/H1/AiyGm3thS8N8hpeZrhW647TsPwykSpVQFprdq49LL
	W/nT5TaiFOfJ9xwYU9/MfYYKD7DfET62UD5PeCNAfNQ7vRaOHzD9Y5/+D8bVEU4CCWfb+U
	18wfggiV2AqLZIq09jmMOGLyoci/ZB22mhQau4yNV9YQ86iL9XPFw7dh4eEuLeDBNW7+pq
	3deJm7lXnnKDAVtzwOs+wLCw/YHsVEjt3iUBZsO1vBF0Zts5HClTwdzf9jifbeZ96S3YHU
	SsKeSEZ7djDTzirJcKoiTRKq9RgsOLGMdl2m6JezMwTrW0qX9Ax7CEx+ZSx8aA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 16:32:23 +0100
Message-Id: <DH55ZO0TJKBD.1K8FXCOY1PRWG@bootlin.com>
Cc: "Simon Horman" <horms@kernel.org>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Charles Perry" <charles.perry@microchip.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v3 3/3] net: macb: add support for Microchip
 pic64hpsc ethernet endpoint
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260313140610.3681752-1-charles.perry@microchip.com>
 <20260313140610.3681752-4-charles.perry@microchip.com>
In-Reply-To: <20260313140610.3681752-4-charles.perry@microchip.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Mar 13, 2026 at 3:06 PM CET, Charles Perry wrote:
> pic64hpsc doesn't have the USRIO register so MACB_CAPS_USRIO_DISABLED is
> used.
>
> pic64hpsc does support PTP and has the timestamping unit so
> MACB_CAPS_GEM_HAS_PTP is used.
>
> jumbo_max_len is set to 16383 (0x3FFF) as reported by the DCFG2 register
> bits 0..13. The JML register also has a default value of 0x3FFF.
>
> dma_burst_length is set to 16 because that's what most other platforms
> use and it worked for me so far. There is one other mode where bursts of
> up to 256 are allowed but this might impact negatively other masters on
> the NOC.  The register default value is 4 (bursts up to 4).
>
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

