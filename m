Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCB238DC6F;
	Fri,  9 Oct 2026 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542384; cv=none; b=Rz4gT0uoXkaazJteATTPOHvFzwiFPjDgPi6cpi5CXGa1C6QS+2DZqTLE/82Xy3djqTMgc0FCFAynL5OtMcWPlQ3Z9sqzUlUSZ2FJBh1/PnXw+UBdwolarPi+6QQgzNZ/7r8Da8IY8xtV0Rbbx9ZcYjiBX+IaUEGlpRC/t3IkZOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542384; c=relaxed/simple;
	bh=yuREDrIz9SKJKLrQfl0sDMPacUyEvm407gPC9dhOyps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euUCb7UxYhvHu2+aFOFP5AKxlsajRJVtHWAWjrZHK/yCfJ1D2RKqg0RhKtefPpCgsYb6jDyeJcDFQ95wW9Txc+HUGf5zl/fN6KqSiGOYQ7nlM7rgYQYVA2TIaSHd3gPz58JVVQW89DYAXwFKfqscpn/1ubBivU/aEuYTnpi1B0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8lb7rfF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8lb7rfF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BDE1F000FF;
	Fri,  9 Oct 2026 10:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791542383;
	bh=n6SBIK/RTJ2gKGJUx4mMtmO3hND48ShXeu1KsGP31Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T8lb7rfFs5SCf8klrO8V53eGWKjoijHWEtYbXWHIP2InyTIod20TSCfW4WiG05/XK
	 WsO4WDNP+RulRO+g/hJl4SIWDguooxunbrMQ1CsENWaCEbGRaiT12Z7s7ONfUbXPpB
	 oFnc2yqY2SVEzp4nc76HrvxBr02aZxa8EwHAVjGBpjA2lc0+AxPgtnMhGwiqg7ewMv
	 PCzjvztCmmMiGtqwe8irX26Mop83S3WyOj/FygoOAwyX+wEkNqwgjkP+7Q38UT3k4+
	 tyeGEzr/Up/klrZyNO2lb4nUd7gg1ygwG/n7p8Mr3eb03rY4auMB/fhUPQpXsa+KP7
	 KIZuAK6XaO3LA==
Date: Fri, 9 Oct 2026 12:39:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	pierluigi.p@variscite.com, Stefano Radaelli <stefano.r@variscite.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, Joseph Guo <qijian.guo@nxp.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Josua Mayer <josua@solid-run.com>, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, Mehmet Fide <mehmet.fide@screeningeagle.com>, 
	Markus Niebel <Markus.Niebel@ew.tq-group.com>, Maud Spierings <maudspierings@gocontroll.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v5 03/13] dt-bindings: arm: fsl: Add Variscite i.MX6ULZ
 board variants
Message-ID: <20261009-dexterous-petrel-of-storm-8156bf@quoll>
References: <cover.1791487179.git.stefano.r@variscite.com>
 <cb2311ceda0efe83d2a05d2d0488d547043b1d47.1791487179.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb2311ceda0efe83d2a05d2d0488d547043b1d47.1791487179.git.stefano.r@variscite.com>

On Thu, Oct 08, 2026 at 09:37:43PM +0200, Stefano Radaelli wrote:
> From: Stefano Radaelli <stefano.r@variscite.com>
> 
> Document VAR-SOM-6UL configurations on the Concerto and Symphony
> carriers and DART-6UL configurations on VAR-6ULCustomBoard with
> i.MX6ULZ.
> 
> The compatibles identify the SoM storage, wireless and audio options
> followed by the carrier, module and SoC compatibles.
> 
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> ---
> v4->v5:
>  - Put fsl,imx6ulz before the fsl,imx6ull fallback in the new Variscite
>    entries. Leave the existing EVK and BSH compatible order unchanged.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

