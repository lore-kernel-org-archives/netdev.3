Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C703D1CB6;
	Mon,  4 May 2026 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898031; cv=none; b=LgkCwr9kr8mpgLEul/tzQxLj+ZFXipsR2ozb6YHb15IE7MrMJklNfWLOwnhr7ri0JDbOvRmZ+ljrI8WdrUmXE7ZD5mD3Ef0LtHxndwRypIQZmnDeOYq2LTlbyIC2QcgK0cDVyYA93YWM5VzurpLerCkIPyR4K0e6KyVHX6D2nqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898031; c=relaxed/simple;
	bh=KOIBqQQqe9G6PoM9EzxhZmNSlWk8f4sRBJgU3Od2nKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGVkvrjomo9lpaDkxk40+NEyOdQIa5ZQMX+PSpBB7TYoWfYJH/Y2pztYMUCd+j9WTXpurTJThqsDblTm517o4lCwFQXQ3nxfW8LMkZPg76CLyYk+7Jbpqq2l2rhs13u4ap/lhEzgUvE9F3W0jRXBh8eJhPh0SAFxMOsKqZkSp9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=06TZ+vkD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="06TZ+vkD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vwIeQRyi7/LPm8LVvGfYx8R/Q1FLGGNiB7e7sj8C6ns=; b=06TZ+vkD34iCABtd/RT0MRcZQa
	k0XYh4D6FH8Uvam4N180a46knA3vURmUWzNwsmdlH86861w7gz2qdex1TySUv7MJFDujmYIQaqYU6
	6lzYRbVbxNg39qOuLxGyS7ojgHTxSmfGNIk6o3qQqsZJU4Oj3fDARGk/IGg7rOwE+fsc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJsUW-001G8J-8h; Mon, 04 May 2026 14:33:40 +0200
Date: Mon, 4 May 2026 14:33:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ijae Kim <ae878000@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: lan966x: avoid unregistering netdev on register
 failure
Message-ID: <8bc1d1e5-6be5-4b4f-81cd-2571ef441275@lunn.ch>
References: <20260502050741.76945-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502050741.76945-1-mhun512@gmail.com>

> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -756,7 +756,7 @@ static void lan966x_cleanup_ports(struct lan966x *lan966x)
>  			unregister_netdev(port->dev);
>  
>  		lan966x_xdp_port_deinit(port);
> -		if (lan966x->fdma && lan966x->fdma_ndev == port->dev)
> +		if (lan966x->fdma && port->dev && lan966x->fdma_ndev == port->dev)
>  			lan966x_fdma_netdev_deinit(lan966x, port->dev);
>  
>  		if (port->phylink) {

Maybe this is better?

		port = lan966x->ports[p];
		if (!port || port->dev)
			continue;

		unregister_netdev(port->dev);

	Andrew
