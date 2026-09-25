Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A5509EEA;
	Fri, 25 Sep 2026 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377511; cv=none; b=p69vOSSPFiDozReiTQgnPgFamHAX+6FeA0er+Oa09xos27vzCgVmzYP+zoM1VF9OjKTpOc+RXyRuaS5YPbKAZQ+5DPcnJjI3VEx6gb62Gtqp4QtFpUg2sur/m0n9Q2P/k7aUUsjmpZKguPN3SCNnJRuOYmFCYMA4O5+Ks6bmq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377511; c=relaxed/simple;
	bh=nCYlGLO6kZh9bo0A+MIdNf49AA+uVrLTJV2J7tEJV5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3U+vJGTWGPBKhK34DFYDxLwasW3kCMD+1wyTFM7rJEw9SujorRIm4HW5ZxBMifufIDQqzJt4i3jCbNHhpJCM4x19HNfSltM2BVIhxzii2I6TcR6D+T3hIAlDNsz9zEdEaWfR2fJngdcbsh4tamslyrDUUmrsh/YNDh+Lr441/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YzD9UN8G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YzD9UN8G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lJOmKJ6UjY7owjMN7s2usEwfCxjnnHNKXOmJAF4Zr2c=; b=YzD9UN8GW2czQXGN+0i4cEHfaC
	ircxf9old2up3hv94ZU7xLbId7QWvNznCpgop1gqoRev90BUmJI530cApKNX83X6YMDpQxrtMqkVD
	807NWysdJG0GoYhWxfFGT5xLjDfPmiWogP0CR8yBZzFDMDi6fiNXZ6K06p87wGhI78bU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAEyU-007K87-LL; Sat, 26 Sep 2026 01:05:02 +0200
Date: Sat, 26 Sep 2026 01:05:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v3 3/8] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
Message-ID: <88bd3f83-ce29-4424-b536-e2ab05b8b822@lunn.ch>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-3-ddebafcb9ba7@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-3-ddebafcb9ba7@linutronix.de>

> +  mdio@204:
> +    $ref: /schemas/net/soce,swip-mdio.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      Integrated MDIO controller bus on the master side of the mux.
> +
> +  mdio-mux@202:
> +    $ref: /schemas/net/mdio-mux-mmioreg.yaml#
> +    unevaluatedProperties: false

> +        mdio_parent: mdio@204 {
> +            compatible = "soce,swip-mdio-23-02";
> +            reg = <0x204 0xc>, <0x200 0x4>;
> +            reg-names = "data", "control";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +        };
> +
> +        mdio-mux@202 {
> +            compatible = "mdio-mux-mmioreg", "mdio-mux";
> +            reg = <0x202 0x2>;

So these two overlap? That is pretty unusual, so might be worth a comment somewhere.

	Andrew
