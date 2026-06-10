Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846D3A961B;
	Wed, 10 Jun 2026 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080471; cv=none; b=RjZ3FFFdSDiFZUdETI6ZYlUXkp6lyx96ru84XHMA4Idn27abgH+efwB3k+hi3mHCFYkUYWoNHr9VEgr7vAKTXWtx5CleBLwNe3r5qYZScRLlKMXgNMZqXIuRwD9HRWrbD6woG7OzaT6qSzECIfSoh/oEgmYB7Ww5Ki6UCmVLxs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080471; c=relaxed/simple;
	bh=AUx7esrtV7wOiWqUAImyg7TucWIPHwLWu8mtkvxHxEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUxFTRtREa4MfZja9/3ReKghJISkGu5w4G0nn5r76tmVH5Uhi8gR+cgKbiSio6nJMx/es8PMC6omLHAT05Tkm1RvGfVQtIQzxlA/FWGcnv1J1k7yIWTcIdAkhFhiejJ4rkEKIunaZ4a3nOITdrirjEJsq8XLjMIK7aG2y/t0NXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WosTeFJs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WosTeFJs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kKPo85nkEKPRvs7qndOCBSrD2NetLAVCKUslax6T9WE=; b=WosTeFJsTiZpNomuo16cd8eiIA
	saXsmvI8nvlDxMoAH1X+5TJgZdERBbW8lZhEIoj8swHeA1ehtInfzUwIpPOHYWTG83gGOkKDykN5Q
	4iZQZCj5bTcB2IRq5mrIUdbjgLO5hK38hcOtoBiqN6TnELdaIm6BAsA4aBlsa+W6DVZA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXEO8-006wqH-6L; Wed, 10 Jun 2026 10:34:16 +0200
Date: Wed, 10 Jun 2026 10:34:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/5] net: mdio: realtek-rtl9300: Add
 registers for high port count modes
Message-ID: <c273aa01-89cd-4257-a522-331e4031e1f9@lunn.ch>
References: <20260609052856.3142922-1-markus.stockhausen@gmx.de>
 <20260609052856.3142922-5-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609052856.3142922-5-markus.stockhausen@gmx.de>

On Tue, Jun 09, 2026 at 07:28:55AM +0200, Markus Stockhausen wrote:
> The high port count models of the Realtek Otto switches have additional
> registers to instrument the MDIO controller. These are:
> 
> - High port mask: A bitfield that extends the already existing low port
>   mask to select ports starting from 32.
> - Broadcast: This takes the port number during reads on the RTL931x.
> - Extended page: Some additional page info. The SDK does not give much
>   information about this. Basically some fixed value must be written
>   into it during access.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
