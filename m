Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827767;
	b=z5U5LINF+uI640utwFZx6uNqTiGvpD/krCQCZkxCE1hucrcVpmR3ooQFUAI3YwZQB5RY
	 sKDNbvUUhyDxWYId01fMzwuNigdeReFklxwSIQsXhUlJjPi/lCVWDY26I/Xe5c7A7eKpA
	 PW6VmNW3mKLCPnSnmwWRboMAQXNUe3nQLjO2oNR60CMfGe4DmOCicc0qiCGTWWXp0KRRp
	 zvk6U2DkutkZm5SYAuOaj8ql58fY/BecIvVbN3um+o5Za/Q5Rp9rNLvzJb5mJLuvARk+2
	 dzrGXb7Dbx6na8yC0iiP9V2PEfMh792SbHBPa/eWYJpqFQJmwQSfyB1VEa46+VFuvBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827767;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Z5JEWAHX8HIT/y9bERySyCdVuC9uxNIx0YOcG+Jkvv0=;
	b=MUQ7ziU4EJoW7sEVY+QZAXZQ3m1bOALU5nz4mx8A3hYEOkIt5z/dWlopvxbBhtXIzMjK
	 jWqnoyZvarJHLHegejtC7oxEw2nndjiH9cGdMsR9BO/otWpJhiwsCoj77yvgRj6lBSS7p
	 zZ8AhejaVpC2bS2aE9f9dmJU/hICzuYVC5+vthXPLTmGAg0k/RnRNCJtR8/wQnIfwdVIr
	 uGmexxtSYT/bP+tCgEB3Wisy1gy7WQ89jvcGYzfSZhqlN1ShjSQ/SKkd4rPBX1YK2uIbP
	 i7amepin6HqMUz2qNJMLVFQmyqmshDOJXD2/TOq9eem/wYE7q6YHz6F4sBqBRI9X67w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=i26NWnj+;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE245606BA3D;
	Wed,  4 Nov 2026 21:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE245606BA3D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=i26NWnj+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z5JEWAHX8HIT/y9bERySyCdVuC9uxNIx0YOcG+Jkvv0=; b=i26NWnj+huXIiWxNXO7EvLj08L
	dpWAOUvdfL/BjVLhLZa9UB9Y6lVKooJS3wov0erHqIbKb8nrhToeu3GBLuiNNksYk4T1yQVbzKkgD
	Y1Xb8/BoUJPnygFcAh5QHLr5/mvJbMZJv9xH9SJR1VI8xfNE9Iwe7KavNZ0C7QZg/2xM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOiXe-00EOKk-TI; Wed, 04 Nov 2026 22:29:10 +0100
Date: Wed, 4 Nov 2026 22:29:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: joseph@telaak.dev
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Chuanhong Guo <gch981213@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: Add Siflower SF19A2890
 GMAC
Message-ID: <e134193f-ba1b-47c1-9a06-419b1b796ea0@lunn.ch>
References: <20261104-sf19a2890-gmac-v1-0-a15965a49574@telaak.dev>
 <20261104-sf19a2890-gmac-v1-1-a15965a49574@telaak.dev>
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
In-Reply-To: <20261104-sf19a2890-gmac-v1-1-a15965a49574@telaak.dev>

> +  rx-internal-delay-ps:
> +    description:
> +      Applied in steps of about 55 ps, rounded to the nearest step.
> +    maximum: 14025

Please add minimum, and multipleOf.

I've not looked at the code yet, but default: 0 would also be good.

> +        rx-internal-delay-ps = <550>;
> +        tx-internal-delay-ps = <935>;

These values are odd. The RGMII standard says 2ns is required. Where
is the rest coming from.

> +        fixed-link {
> +            speed = <1000>;
> +            full-duplex;
> +        };

Does this mean there is a switch on the other end? Maybe look at what
the switch is doing for RGMII delays.

	Andrew
