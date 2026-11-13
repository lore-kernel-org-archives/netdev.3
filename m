Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530226;
	b=v0g8RYtZexoXFMj7XswRMPKV0mwiJxJeQ+hxU/a+tHp51mGfBO4GpN4er+1MxD4dY9VN
	 7xGe5rfLoWuJas1QqTWoHXDCHEpkT/1BDuM16DHCTO9VzoBe6iIW1xqedHoq2KwiBVsQ7
	 WMBBUQt0zMxafCFBbXZ4EurIyNiaI5DUs2DTklGiHuME73fqkBDzYVIgU3Ax0qgLDmNrf
	 uRsRU9G9xOS/ENhn+7DEtI8chMfOcWZk4M1n/1GdZ2BFXJy37DF5BabA8LbFiKqtx9F4Z
	 LyDqybLrTxifZfHVAl92JV8UoI8MnYf6UuhjQ651EwkvRvw32IX98FsQBnlAgMpp7aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ndSvCKL9DmCz1Xlym3gvmuPi6Y2z+W2Q/BEPD9rU47Q=;
	b=H4Sm7y+nz+Wh3p0IPIi8fnjHemvlYkhPmLPSVztPSzNpSuIAET9GU6kpwqmnU/MRCesu
	 R/4Rt8kfUQ7H2jJXWtQTK1w3nvH0LQsrDJrWnRGVtQYskU9U707tDCeZMwYGDNWqCOq3q
	 rStO/7HIibAcMxWoiOD8X3Pfb6xXirqA0evIeZPdvk9aDdE96cAP01UgP8YNw827jc5ry
	 gDkIJUvxpugFXS4X3tLjGuFGGMRRoi0M874tgnv26ytxpWRNV23tbldF+6zi6GtaZYaiJ
	 P92PQvsNBy2Tr8lsp0IFHa9lfZYUYV0hXv/EOuiDJoxRBXGiXtRiODh/RzPDNSAerdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zQy7FD5U;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76648606A336
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76648606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zQy7FD5U
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a208d93758so4911655e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794530225; x=1795135025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndSvCKL9DmCz1Xlym3gvmuPi6Y2z+W2Q/BEPD9rU47Q=;
        b=zQy7FD5Uky8jI9lN1ow5BVWTgrCgNFNDWHfYmrXC0j4sT0wuqg2a4W1yyOahHI3PzQ
         mLfBh7BNwqqhUcYO+NEOXsUtVtvG7XkfgT1NWY6uubSRX03Y3Ckhdc3fd7Z8XaV2Gm5a
         AE9v8GyA1QqkSpgfwPwcnFPN+D18G8w7Tjm67tgyXF+wkpYFjofH1DzNtHY/BDY7GWAs
         9PP5GRKX0MQeiJUKTYA2+hrSuTBVatYr3zKCfqy0sHPa6wzHqEgBw2LXop48uI9FGfdf
         Cbcqg7hkyBaFlIWeXdF56cXJR2WxczCM2MrUbAX4FgYQbKiZKNUzpoMjYm/VQRLB0mHu
         FKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794530225; x=1795135025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ndSvCKL9DmCz1Xlym3gvmuPi6Y2z+W2Q/BEPD9rU47Q=;
        b=KJTMQ0pFMZB2XhTJHlpMwZjgkmcPSksj9XL1PD7CPjHjQblp4BriWZc6IqoOIiVgai
         /pS2DeABONZwdXCL/PewSHHfi6OTNrhseUSAhQaZHHpggU1TpFvu3y3ytb5MOnrpD4g2
         sI5VU7Z18TExpYv+sCeWKEuorvJsh0CIkJbHxA6DfVIJAieNZZYgl5KpEcvNBvuxPBjs
         XZqngUF9agJBnTBbJ8XStg61J0bZqlvR3PWtJiMRxKzPMWtbliS/PLb3jC0Yf0JfKmmD
         nJdroZjJQZ5d8aLTWU0FZlhvHJ1OOIZ/wc8ULTopKYTAMa9UsYtiUlYrA3rF7KihuBMr
         ILhg==
X-Forwarded-Encrypted: i=1; AL+hErEeaQaon2Lpqx08q7YDH4LJWCSz1oE6jIp2NEdt3wHk6/Js+QN18K62Z71ZJ2gxztAZdruyF3c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wjEPbSUUssCpx15Wx+W5E89Dr1kaCF6Ls8lcAFOEMgmQgBvbv
	qZSv98ZSf/bb/0h+eTTME2QXVG3LRnKB8lco9+8A+T4faZCfn9Y+ktcs
X-Gm-Gg: AYBFou2u6YPmx10EHpRb7gPQUnKho3bt0jRQZDqBXJQ5Bd9SoRs4h9WoAcspXo6mxFq
	X7qjUkta+AyUc7YxFI8Dc88D3rsdjissVcziDvetxju8pE+lLfqv2tf+Rf03cVRP9Uo4yenG0pA
	SLOHybVU5U33W1Z2j8+o/UHWWOihFw1o1esznfAM8MujJ/bfLGw4DpGpXrpDG9pZEz/b6KG+QfQ
	MLbPg/A/UBaqxLMsSmzSiHr68aHSRliaz/eX2XrVQra26QwKwePI7Vi0hXwI9XimGB8Ek6C9Krx
	8hgs8bC/cYCIqENsO/2vSkeEDkVoYAi7DECSFRjPKkpsUGMkwK9DeCiYluQmLC2rRut3Kye10fy
	ujrCBdPnfqZdDpUa/yyikcGKQoXBZ5EbT39GE4aoGzqwC4NF+S4DU2cOmnXtjxvwkEfbyU/xbxT
	HW8/1WvSK3d/oeCaDtSx2YhU0p2WAfhBkrYyAPKFpMdn7K+sO2td7Y9bguqxvLnLuQnxdEDjaLi
	IgipDsbfYvDKTorX/H39t+ysU+T3ho9SvsxcbJwy3ggT1DRU1H3+vquaZogJfheqIC50+bMXkVU
	LfN19hF4CAznOLM2foaeV9MdGOpLrB1oBBpDhON6LLHGxWH2z/uO2Lvcklb7axKb1c62BPy3PyB
	sRoKnZ/BgoVnHSZHzkEws3Z9+fASe84BAAhEcRLkVKu3HFVRVERpuaQ6VE+5kTd8qDo/z2ulC6v
	LNXMo+to4o5FEoaWsC
X-Received: by 2002:a05:600c:c05a:b0:4a3:59c9:a750 with SMTP id 5b1f17b1804b1-4bb55a6a5e5mr14393345e9.9.1794530224913;
        Thu, 12 Nov 2026 16:37:04 -0800 (PST)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571f6a40sm2591625e9.2.2026.11.12.16.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:37:04 -0800 (PST)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org,
	arnd@arndb.de,
	stefandoesinger@gmail.com,
	krzk@kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 15/24] net: mdio: Add ZTE ZX279128S MDIO controller
Date: Fri, 13 Nov 2026 00:37:03 +0000
Message-ID: <20261113003703.3666085-1-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <595371a9-6b7b-4ad9-985e-66f0e659f4a1@lunn.ch>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com> <20261014072109.1759502-16-ghahramani.navid@gmail.com> <595371a9-6b7b-4ad9-985e-66f0e659f4a1@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Andrew Lunn wrote:
> > +	writel(0, base + ZX_MDIO_STATUS);
> > +	writel(readl(base + ZX_MDIO_CMD) & ~ZX_MDIO_CMD_START,
> > +	       base + ZX_MDIO_CMD);
>
> This is the same as what you did at the beginning, but in the opposite
> order. Is it actually needed, and can the same order be used?

It is not needed. That clear came over from the first driver I wrote
for this board. There is no public documentation for the MDIO block, so
that driver was put together by reverse engineering, and I never
checked whether every step was needed. I removed the clear after the
transfer, so only the one before the start is left, and tested it on my
board. All five PHYs probe with the same IDs and link states as before,
and a few minutes of PHY polling plus traffic gave no MDIO timeouts.

> Is this the bus clock? Does it need setting to 2.5Mhz?

wclk is the MDIO block's work clock from the LSP1 clock controller. The
driver sets bit 12 of the command register, which I took to be an MDC
divider. The 50 MHz and 2.5 MHz in my comment are not measured, and the
wclk rate is not confirmed yet either. I will find out the real MDC rate
before I resend the MDIO driver and fix the comment and the code to
match.

> It needs a device tree binding. But that is mostly boilerplate.

The binding is patch 14/24 of this series and Rob gave a Reviewed-by.
The MDIO, PHY and switch patches will go to netdev as their own series
like you asked.

Best regards,
Navid
