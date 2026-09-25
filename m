Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7E370D41;
	Fri, 25 Sep 2026 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348259; cv=none; b=ZFaXQue3h53emQ2rL43ws7uGr8SacLCF3aZW/+owR8psaauwEwDya1HeCTHxGGM6zXosY5LU2hBJh99ban/cCo14GN65UkRzYWWVjU/YueY8yS77Fx7iQBFX//wKwgHYw4t8DXGuIpNqIBKLkxb/3N5Mcv8Sk7WnhZouyHQzq34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348259; c=relaxed/simple;
	bh=vokxpPPeJFF9m4UiOT54OmKjxI7Lroxu8kn2nd0T4+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0Qcg8yFK2f7DZrNhfGrajspUVZw/OVsg6qUPuEg29+YoyBASG45P9laEWbz4HjNfbMgq9Gk7ImVltBfgy9GLl3f2fpJYypxKwvEeXDzDPyDOeFNifq2mKbXk88WDbd6FlDP8SJIzaYmsC5CeWYZs4opz6f4mw0RMWSWnfGL/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VkvErMx+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VkvErMx+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B3X/8T/KxsERTXdE9gjbpSLjxra0gRxccQouuWityYo=; b=VkvErMx+c1zApjiTSzU7Fo76q2
	nfQj+trbiy2fxHZ9RN+3bxZPEged/aevjI1KqnM/VCkckVG+sI6ihFvgPCiRYXl1BxSUleI5PPAJ8
	d5KTlyz0tKRm4+f752Ybv8TxJuv91amhWs2WKdjwL26eVf7En6HQUCekqN/EUoVqY6IE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xA7MU-007EVC-5n; Fri, 25 Sep 2026 16:57:18 +0200
Date: Fri, 25 Sep 2026 16:57:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/8] net: dsa: motorcomm: Identify port type
 at runtime
Message-ID: <bdc8063e-0141-4cf0-9070-8424e3ac7812@lunn.ch>
References: <20260923021945.2203368-1-mmyangfl@gmail.com>
 <20260923021945.2203368-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923021945.2203368-4-mmyangfl@gmail.com>

On Wed, Sep 23, 2026 at 10:19:35AM +0800, David Yang wrote:
> The yt921x_port_is_internal/external() macros hardcoded the port layout:
> they treat ports 8 and 9 as external on every chip and count the dummy
> ports as internal.
> 
> Identify the actual port capabilities using chip info and track
> configuration of external ports (although only SerDes is supported now).
> This is a hardening and cleanup step ahead of the SerDes PCS support, no
> behavior changes intended.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
