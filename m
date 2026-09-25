Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04053CFF65;
	Fri, 25 Sep 2026 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376950; cv=none; b=CWsoHVfsba9c2FeUeV5TkSJJSMATssTY2cDj74tEznfbUVZC9MqfYTbV4hZ9cCT9CPT5ApyC6WeBRx8ezXLVaCT/0+/+BKaCyZpA1nQOKj77PAm/xEAYuhR+zY7kaHJjLkJxT4+MTsbXANWhXcAkBcq+d0mrvjJpeKiuQvGwySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376950; c=relaxed/simple;
	bh=CKmc+IyROfqLKImxsuxMQ0v9HEBPpVow7AB9ZTPfec4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbdS83zn9UWDKZXwm4Z8UYGLsQTjXwFvWZMCdE+abaLKTN4go/ROzkEfp8kj7P4ca2c+8yqAHZhUSP13DFOI+JsMFH6kDY4izNC2mqS1RfSJX+vaYYD0zL4R2I3o8KxSH7TJFZ120VsGWqax+saZRxlZaP8Rc34fr7M0DXkUZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MWblbe2/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MWblbe2/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=usdgnj4BG7stNWjiWpFVBjkeG9bD+IQsE/nVGE9U7X8=; b=MWblbe2/IXeWXUCvvdDl3UZXPL
	CcbL7s4FUsGHSUoWnqjqMsjcNIqb6WkLTgvYgPV+US6p1cxcG0Agq8hIiz1ZU/Cdm9kQc9HSISt7t
	6Ofj0cSYaqcsARBdR/Izv4NFOnPR4vdqcKmEwEjIRQeknhj1pMX2CKmcUWEEa9wQ13s0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAEpQ-007K2Q-On; Sat, 26 Sep 2026 00:55:40 +0200
Date: Sat, 26 Sep 2026 00:55:40 +0200
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
Subject: Re: [PATCH net-next v3 2/8] dt-bindings: net: Add SoC-e SWIP MDIO
 controller
Message-ID: <e5aa5cd8-e805-47d3-a105-07bf1b9eb9b8@lunn.ch>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-2-ddebafcb9ba7@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-2-ddebafcb9ba7@linutronix.de>

> The controller exposes separate register regions for transaction data
> and for the shared transaction control and external bus selector
> register.

> +examples:
> +  - |
> +    mdio@204 {
> +        compatible = "soce,swip-mdio-23-02";
> +        reg = <0x204 0xc>, <0x200 0x4>;

At least in the example, they are not separate?

   Andrew
