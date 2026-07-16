Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C837EFEB;
	Thu, 16 Jul 2026 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219827; cv=none; b=V1o9sJhGL3wqnjE60p9BH2KbDbd3J91RabzmC08Bb81PuDhwTUoJajm2n6bP6xScAmAS18lV7p2A5pdmYckhNQZ8VKWJasFrOugi2dT/PVrt/R6BJ3QQ/r+bsg0f/vaLyoh2X9HVsR0HpnY3wlqq8wI5pWJRwujS3/bWsG336mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219827; c=relaxed/simple;
	bh=K0BF7FbuoxREQX7R9oRRuKih1khVUEkSGv6AiK2pt2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3VF3f+1hqkabOHy7553WP+3JfA3He/VENt18FCEbMtsJPhPFLhLu190W/BfIoe9nBwEejJQ0TYS3cGZ7uAEkxWeMEQO4g2wQxKjRK6TLW1+W7v/t0aixr9yU5wDpYPQED0tTPPWJ2oa6kFW//UY04EOKIPW9SOWO4zNYSiudR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oUQiQEU7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oUQiQEU7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d5qYlpD+dPBiVmXiI59yOgTPp/v55fuilkEwBEDMrA4=; b=oUQiQEU7IyGmWs61ai3ffx+pzj
	m40tRCGB5E5Js7JSs+FAQDEezEDMuJdLGATgpr5vzY7oGf17YnAmOB/4+uIi7EOm0xdZihMceGlIU
	vgWA9n6/6L09e4hsUjGZsB56X72LukVRfr1IJe6mVNOHXy3qxWYY7mGS6ZooUZnGTXg8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkP4s-00CaIa-AP; Thu, 16 Jul 2026 18:36:50 +0200
Date: Thu, 16 Jul 2026 18:36:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Liu Changjie <liucj1228@outlook.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: Add Maxio MAE0621A PHY
Message-ID: <1a02ef89-2608-44c4-847f-239d9b86c7ab@lunn.ch>
References: <03b781d223194234bcf6e53df12880b4.1784011580644350.tspi3m-maxio-v1-cover@outlook.com>
 <MN0PR19MB6091ABAD3F4E6AC5FFD44E34ACF92@MN0PR19MB6091.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR19MB6091ABAD3F4E6AC5FFD44E34ACF92@MN0PR19MB6091.namprd19.prod.outlook.com>

> +  maxio,clk-out-frequency-hz:
> +    description:
> +      Selects a 125 MHz clock on the CLKOUT pin. If the property is absent,
> +      the hardware strap or bootloader configuration is preserved.
> +    const: 125000000

Not required, but maybe consider the value of 0 meaning the clock
should be disabled? If the MAC does not need it, turning it off can
save a little power.

This is something which can also be added later.

     Andrew
