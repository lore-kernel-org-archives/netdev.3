Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFE30C34C;
	Mon, 24 Nov 2025 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992690; cv=none; b=WJzOkMDgB6lbzdcM/5pBFEBJt+ue/Lbsg24qQwJ8qZadsOK0e1zF/nNsiML+iEJTR2qYLtMsYldhsiRSkUKDJOL0sS04yPzQS+QOJ5IoGwhwSFgK6tz9qIAglHXiihbhBMy7n9FmvK1iWuevJomf58cvTmz53LA0deOymOYvklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992690; c=relaxed/simple;
	bh=2w+k7C7j4CDih8pVTTZXa5lLx8bV6wsLE/Z4VSAH1Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpKEUjLOI9yc5VtOkhBD0lnG/2qRLXYNnhFETraqUf5VSIx11xPDxDI56QTM2vA6+YQEAQulu5z+bhF+uEHwTnSPqSyDUGbPTKeVPL7auAsvjHB+vUMdeaGogWGYMOA3Ff/8ebERaIcVPAHsc7rIBza2Ei0TbFYmyXl4X+v/1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e9fZHTiW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e9fZHTiW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oNSDEf7pSDqwi/Zo/EZjQROo6X1Fx9MtkA94QWEfUpI=; b=e9fZHTiWR9HUwq3wfRr4TVXB+a
	CJ4ctWiIkQNhTR7/l8N1sBc7QoZw0ztQX/jELayrlBqwPh9bWNbotF2SmoFcs+IcdUX1X/ZOVY44C
	Gh3JpNRStnAJGOei+jZqiMX4eNDmMyIU1ofVJFPsuwhWMHTci4r0ejfbnmxtGC9aO+1g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vNX4h-00Euo5-Gy; Mon, 24 Nov 2025 14:57:51 +0100
Date: Mon, 24 Nov 2025 14:57:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] net: mdio: eliminate kdoc warnings in
 mdio_device.c and mdio_bus.c
Message-ID: <e28d3121-e961-4764-97f1-31f262d63dca@lunn.ch>
References: <7ef7b80669da2b899d38afdb6c45e122229c3d8c.1763968667.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef7b80669da2b899d38afdb6c45e122229c3d8c.1763968667.git.buday.csaba@prolan.hu>

On Mon, Nov 24, 2025 at 08:19:15AM +0100, Buday Csaba wrote:
> Fix all warnings reported by scripts/kernel-doc in
> mdio_device.c and mdio_bus.c
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
