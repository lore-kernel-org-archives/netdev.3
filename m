Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39757386C21;
	Tue,  4 Aug 2026 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810737; cv=none; b=QGUQywTRDbA6EH9Iw1oK8HqbRBYJkFEAftEbeCsOL6GBCLIzwI9EIlP+JsQ45px4kMdsfNunAfejjQ8B8m2qB54IxXjfIvLfvTb7buVbNelO7uNmYAzEEgtvkPDjIALQXA1d3umLJhRzBj+hk97MAh4OZgcNVTdpSEkZ6qb0VKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810737; c=relaxed/simple;
	bh=3+ZzUhaF6AALdanGLZfeQIxgJrKqPriGHak63jYH8GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuserJxhANtDAme4YvdaBT8pGmbYfrHxYxt/W+gCqI9/D0V1F9j++Wb88uk0h1hRGAKE5X4x2DXwAwvxRQJ/BE6mHYUmftTwmD8K4d+r+p68Xgupt69/yk9fys8nUqN8C2XgonDvIr2awYEYml5I66XNrJUfDC4JTT8kl6uFuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CJ9kDJHF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CJ9kDJHF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ig4xx+8K879vx7u7CJVZ0beN15tVCP446l2UqWbg3Z4=; b=CJ9kDJHFq2oIDG4n2KGqW9uTer
	H+13kTcUWkYHnsH/t/QSE2qv7IgOoFy/FaCoCUjfnZfi39TJUfCS4YjiIDtZf1Ew/W26A8y7F5zKj
	YGxQHACgWIjgTjjyzgvptIM1N6/B6H6XaQk+92pS9+sShoC3uNDNliqiD05b2nwo9MZ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wr4wq-00FtZJ-C2; Tue, 04 Aug 2026 04:32:08 +0200
Date: Tue, 4 Aug 2026 04:32:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/3] Add DAPU Telecom DAP8211R(I) Gigabit
 Ethernet PHY driver
Message-ID: <94fb1a6e-71d6-42ae-b221-cc03a820d2e0@lunn.ch>
References: <20260803101734.270821-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803101734.270821-1-a.shimko.dev@gmail.com>

> DTS node example:
> &ethernet_1g_tile {
>   ...
>   phy-mode = "rgmii-rxid";
>   phy-handle = <&phy1>;
>   ...
> 
>   mdio: mdio {
>     phy1: ethernet-phy@1 {
>       ...
>       compatible = "ethernet-phy-id0008.011b";
>       rx-internal-delay-ps = <1050>;

Is this a random example, or what you are actually using?

   Andrew
