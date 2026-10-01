Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1727033BBCD;
	Thu,  1 Oct 2026 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840782; cv=none; b=GXoH5zGdeWhIXByRCKd+TESGmViT6g25rIdFkKZ/kzWWEyfbi2WiSeYprtrKqlRrLHgJYbC3Pq/A9F6Tl7Dj0lAWSVI1aPjsasq8Wdoyl08HwYyNte4x4jGnVu7g9/bWgStVPgU6mXb0lY0RaiuKXgzY894EEhrKWKdni1VOjQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840782; c=relaxed/simple;
	bh=AP84djVEDki0zyiBJLKdXB1AD6/h7C8uXwbwa95toeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCiljuroNRCe9dkA0AtGFM5zbizZoP2R7GzIKS8HvnFbxeGvCV2scIPV5lPcBP9c/UhgHHHqMY8IvDbxSpzBwFFThgfYONgc1pT9+iTN3crpuke4PqufVrxX+ccuZktlPZG2xqWYbgm7C7kGrUz0UfHzJFy1s+jZLKoch6EiHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8bK+t4n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8bK+t4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1631F000FF;
	Thu,  1 Oct 2026 07:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790840780;
	bh=E/imt2ZFR4iPgDVR5E7V1cTC9eu5GVAhLsMP8e8lZgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C8bK+t4nuolwA6ibbwTSxvT3bxhH8MeraRDJ5AOuR/1XtYxjYfjN2MPM4gh5y8i1y
	 uOI7lVWbTqBP2+2W1mjOJmXgSYPf1C6eURueVC6kknmNF8ZYsGnWL/mF3vTDL+CFzJ
	 MQ62bkS5T+P8KIZGad937ZQRVK67C500Qv6ZypcZoRcCiskrgzblVpYLJBRKRSM8eH
	 ctGFb+XLq1HTORXfSyWC3GjbB3X9SxuO5AoN06KhzWza3AeJXal+bZqIW6K0nNQho8
	 U79KfGDNmUHKFXo9k7s6VpP2s58xGm2JPKbZ3Q67+u7IjAMjlaF40QbAzyuCx81Wzz
	 B5vdXufloPT7g==
Date: Thu, 1 Oct 2026 09:46:17 +0200
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
	Josua Mayer <josua@solid-run.com>, Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
	Mehmet Fide <mehmet.fide@screeningeagle.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Markus Niebel <Markus.Niebel@ew.tq-group.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 01/13] dt-bindings: arm: fsl: Add Variscite i.MX6UL
 board variants
Message-ID: <20261001-spiritual-mongoose-of-force-9323be@quoll>
References: <cover.1790693249.git.stefano.r@variscite.com>
 <c547995bcb14779a5883d855137148ebddb7ef8d.1790693249.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c547995bcb14779a5883d855137148ebddb7ef8d.1790693249.git.stefano.r@variscite.com>

On Tue, Sep 29, 2026 at 05:17:28PM +0200, Stefano Radaelli wrote:
> From: Stefano Radaelli <stefano.r@variscite.com>
> 
> Document new VAR-SOM-6UL configurations on the already supported
> Concerto carrier while retaining its legacy compatible. Add
> VAR-SOM-6UL variants on Symphony and DART-6UL variants on
> VAR-6ULCustomBoard.
> 
> The new compatibles identify the SoM storage, wireless and audio
> options followed by the carrier, module and SoC compatibles.
> 
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> ---
> v3->v4:
>  - Split the board binding by SoC, extend the existing VAR-SOM-6UL
>    entry with new Concerto and Symphony variants, and add DART-6UL.
>  - Drop the redundant -board suffix from the new carrier compatibles
>    and use sorted items/enum lists.
> 
>  .../devicetree/bindings/arm/fsl.yaml          | 39 ++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

