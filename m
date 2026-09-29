Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4F4CE663;
	Tue, 29 Sep 2026 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671760; cv=none; b=i+hHhojQa0cOmm15fx8Af3T/TDOltpvDwEsa8VQGW4il+ZNx3dqjRsK1f8kB1wPMJsyczEWzCbTcUSYgFDlY0XLaE4lHKGDJ6s0PVpHrnBac47GNmDG6sRbhp5oveohDf6LmimIm8XixJTBjqt6jy66S3e8/VojGfC/aYb/olTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671760; c=relaxed/simple;
	bh=zLSUSrIO6UNWf7qON0V3tBKQM/dUiz/r3LMVw+ocjL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFmd9SML9xl7zpolntO0I3meoPFq2g+Viw8qOCnXoqtHBftIqRRUkMwsQPHoiPfWdBLktOdpuX5SJe/WxXu8zvb2SdUV0UJEI7wcd4nojt1n1yp5wXa22VEKLM0QWnFxwF1He82NLth0G0JDcoKX+V1RFBKiP37kiasiCc8xnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uotl77A9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uotl77A9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E111F000FF;
	Tue, 29 Sep 2026 08:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671752;
	bh=OEvFdXxmiBBOQnGv/bJzw1AJCNWoYVHX2U47VS0pVAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uotl77A9faR8cxDMalABDPuVUSxa4nXqz5VdvUeq20CLbJ6gGG3pajwP7UASCNfrf
	 xM9yiJAlYiyQUcexXENjt/0nvf8XPlnxKN13hqYHJnmuEkayhJKIrmwJDw1JR9z1mM
	 lzM5yVL5mfQym4eZUUv0D0SQvzlzlIKNFEX2/P/X3uvtn4rkXqyeWOQK6OF2FpCTWe
	 Tg1xmnoYoFwvC6UttwThBW5xtSB98hkzDIzyGNLz+NxN11CletfA46GN5nhLLTl3GV
	 uQgOZ2d/BWw92s0irFQcLG7E1KkSc0nmPIcSEOCjz2d2pgj0deVjGR0p4FVmcg+MFa
	 NRLIBLFJsmg5g==
Date: Tue, 29 Sep 2026 10:49:08 +0200
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
	Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
	Josua Mayer <josua@solid-run.com>, Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
	Mehmet Fide <mehmet.fide@screeningeagle.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Maud Spierings <maudspierings@gocontroll.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 01/12] dt-bindings: arm: fsl: Document Variscite
 i.MX6UL boards
Message-ID: <20260929-logical-fanatic-quail-2ff20b@quoll>
References: <cover.1790512621.git.stefano.r@variscite.com>
 <a4e262cfb08153c23c80cd3098a684816993f1e9.1790512621.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4e262cfb08153c23c80cd3098a684816993f1e9.1790512621.git.stefano.r@variscite.com>

On Sun, Sep 27, 2026 at 02:46:16PM +0200, Stefano Radaelli wrote:
> From: Stefano Radaelli <stefano.r@variscite.com>
> 
> Document the existing VAR-SOM-6UL Concerto compatibles and the new

Which are existing? Don't mix up different issues.

> VAR-SOM-6UL and DART-6UL board variants based on i.MX6UL, i.MX6ULL
> and i.MX6ULZ.
> 
> Add specific compatibles for the storage, wireless, audio and
> carrier combinations while retaining the legacy Concerto strings.
> 
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 148 ++++++++++++++++--
>  1 file changed, 138 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 36e28e0e4ad9..726d563d1482 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -688,11 +688,51 @@ properties:
>            - const: phytec,imx6ul-pcl063   # PHYTEC phyCORE-i.MX 6UL
>            - const: fsl,imx6ul
>  
> -      - description: i.MX6UL Variscite VAR-SOM-6UL Boards
> -        items:
> -          - const: variscite,mx6ulconcerto
> -          - const: variscite,var-som-imx6ul
> -          - const: fsl,imx6ul
> +      - description: i.MX6UL Variscite VAR-SOM-6UL and DART-6UL Boards
> +        oneOf:

Please do not introduce own style.

> +          - items:
> +              - enum:
> +                  - variscite,mx6ulconcerto
> +                  - variscite,var-som-imx6ul-emmc-sd-card-wm8731-concerto-board

"board" is redundant

Also, look at other examples here, like Toradex. The actual variant
should be the last.

Best regards,
Krzysztof

