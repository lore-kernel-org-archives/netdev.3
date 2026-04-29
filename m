Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A901262FD0;
	Wed, 29 Apr 2026 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426115; cv=none; b=N9n3liXotE9bHc40Hlipw2iUtSpNZ/16BRhiAazTFxHoKki8SK0fI2O3HSzekfzrJwcq60WKVGksF40VxMHzeVA6+H6QAfqW9d96x7/tmPDX3W+Gne0+DVH1xxAYHYutSRFYquc0h5PEXYxec167fnvETRbpVdyqdGSdHPhRcy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426115; c=relaxed/simple;
	bh=A+YGIW+gQg6fjtynR0Ap00tQpN/hqnEAQuzUoWWUz6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAZX9w7WmLU44lUbcQxS2xdNznMfUGezo5pnXHmcZj5hwERWF/YLECTXSYifHeMIEBM1eEGnJBaO24uBbPpoN6sVgR9TWv/5tNTGYMeYv5dAIdk5IlUpsmtLH1ucdwsEsvCp4H8nYtDCGuuybEJ0vsiGw90WZoTAAlLP8oIEcns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aZxB0ezn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aZxB0ezn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DpkW87IRui0aZcXqZZoR9Te84pOQWX7oAn03qgDdrBI=; b=aZxB0ezn2S98YGn1tBXwFMbEky
	hPSpu+NnXBfzgDTiPXs5E2ovvxXifx6t8up7wlMfKoagS5chKM7guYJwzOI1EdUJz5ixxBWHd//bf
	neTAR+CkZgS0WpSAqFxFL9MuBSiMShbq5l3DsAPJZJouNg5guu1+tJmH3saoRMdXCu2Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHtiq-000RWt-Ql; Wed, 29 Apr 2026 03:28:16 +0200
Date: Wed, 29 Apr 2026 03:28:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com,
	horms@kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v7 1/4] dt-bindings: ethernet: eswin: add clock
 sampling control
Message-ID: <6ecfeac7-b900-4861-b0b8-5c5d2e0754b2@lunn.ch>
References: <20260427072353.1114-1-lizhi2@eswincomputing.com>
 <20260427072439.1134-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427072439.1134-1-lizhi2@eswincomputing.com>

> For the TX path of eth1, there is also a skew between the TX clock
> and data on the MAC controller inside the silicon. This skew happens
> to be approximately 2 ns. Therefore, it can be considered that the
> 2 ns delay of TX is provided by the MAC, so the TX is compliant with
> the RGMII standard.

>    tx-internal-delay-ps:
> -    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
> +    minimum: 0
> +    maximum: 2540
> +    multipleOf: 20

This does not seem correct for eth1. Isn't minimum 2000, maximum 4540?
You have this fixed 2ns you cannot turn off.

	Andrew
