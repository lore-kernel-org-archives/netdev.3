Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4543E49C0;
	Wed,  7 Oct 2026 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405357; cv=none; b=am137OxuS2r5Ha/MEhjxWCYKcQB6FTsfGwe5OU4nihJ7t7Zjd9J+X/478f7XolAcztcsh5+mjCtz9i0hht9KVxD0HYqZ0FAclb4n7PavboMlNCqfUr8G/wZBTTm9casr+tRkffn718XK2YJfWUrxQgSrIfC5HqHdQhn4qcxnjrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405357; c=relaxed/simple;
	bh=CrQMPQuIrP3UT/xnSnr7TdUvHO25V4vTzGjDeiouuHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLq7bOAJp3dmg2pqvVYLzen3jP4hVTGmHYaXJxle3VXv2Vducjg2GMs3+e2QUWQoskMiIw7HP4ra36ZWNdXGgm0uZiZGR15hdapQhdOFqIJ7Vu8NikX+uV4+3kz+lytO12+XJZtwOBdaT2wZDlEORv2sL9RRYJXMUXgYQSjTcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAnTrrZ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAnTrrZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAFC1F000FF;
	Wed,  7 Oct 2026 20:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405356;
	bh=iBnT7QbK9u0Gs8c95AjLx+P8e034rEiTzbi8S3Cwpwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EAnTrrZ9FBxijRk+eVs2T8pzlvv92TXfyUbTV4OOYhJre5ukKSsgV9PDEl3ZM+B/D
	 UohnG4dEbUub4MM3HZ38Jz8NzciIgVZ3pdUwgnYDSHNfCyok4rFESVz8jIPMAOt+lm
	 dLJi2vVZjTU6/qHvBm1tgWJ5EH9e6YdQCeJgHq57YAs7cqBq9Bu2WMWUiaYh+CFRoj
	 kDX9aClQniHp9CYj9DR1YS1/4rwJcuF7H5sDiaNL3ZG/MiyEpfTNQBayP8HMjRxGEP
	 VTC5XO9OIp2tx4YpIPk5+pAQ737aGag1CtbkztZTAz3ll2Rl2Z/egQvBmn+7T+ZbIy
	 XKqbZAf0OIRNw==
Date: Wed, 7 Oct 2026 15:35:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Josua Mayer <josua@solid-run.com>,
	Eric Dumazet <edumazet@google.com>, Frank Li <Frank.Li@nxp.com>,
	devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	pierluigi.p@variscite.com, Sascha Hauer <s.hauer@pengutronix.de>,
	Joseph Guo <qijian.guo@nxp.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Stefano Radaelli <stefano.r@variscite.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, Conor Dooley <conor+dt@kernel.org>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v4 05/13] dt-bindings: net: micrel: Fix RMII clock select
 property type
Message-ID: <179140535486.208329.1445143309084105314.robh@kernel.org>
References: <cover.1790693249.git.stefano.r@variscite.com>
 <9a0f70dc168278a484bb336835bf2e419a9d089d.1790693249.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a0f70dc168278a484bb336835bf2e419a9d089d.1790693249.git.stefano.r@variscite.com>


On Tue, 29 Sep 2026 17:17:32 +0200, Stefano Radaelli wrote:
> From: Stefano Radaelli <stefano.r@variscite.com>
> 
> The binding describes micrel,rmii-reference-clock-select-25-mhz as a
> boolean. dt-schema requires properties ending in -mhz to contain an
> unsigned integer value. A bare property therefore produces a
> property-units.yaml type warning.
> 
> Describe 25 MHz selection as <1> and keep the property restricted to
> KSZ8021, KSZ8031, KSZ8081 and KSZ8091 PHYs, which have the RMII
> reference clock select bit. The driver checks only for the property
> presence, so this does not change runtime behavior.
> 
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> ---
>  .../devicetree/bindings/net/micrel.yaml       | 27 ++++++++++++++-----
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

