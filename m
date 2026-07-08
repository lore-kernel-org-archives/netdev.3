Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C848C14A60F;
	Wed,  8 Jul 2026 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552548; cv=none; b=CggoE06fTrAfrD22uFxYmNRQ2rigCayHPbNy2lbwTWeuoNrwBCAfAWWX3RXVZQGOxKdAIvwa6zWNkNDUw9NLRa6Cic7xkkWZKmoapNVFBED/Gm3EbTLPZ+9d5+IXZqj8Ftn2qsB5iOY6LfvMpe9BNzTSYlM3/rkCz9fJrmuEj9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552548; c=relaxed/simple;
	bh=VX4vjjA4u85KuWgvvCeORL6MUd01AAQTbmn/J2BZVfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+d5abAueQ6CY6q2APlUqwTHnfk+NghzEl+y3VI1Qvqm6bsRvJAuVDakTyw/CCvzHqHkldAJcZoT3gPLk81VhAuEGM9rSdPoSzAhKl5xbz0iEWk0YIuD+R540yCm8PCZ7S79sm+5vBVz/CJvUAVHhik+cnZcKTfklvw3jz8uW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=km//TbkL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="km//TbkL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BzS0ZxhAqv0xPwvd9MAUNmXADZ39TihBc+TR253aYHQ=; b=km//TbkLdQ1cZgTt0aHFWpJlz7
	BW0uu0j85s/JtJNESP6yK8yb1cqcVWS1yylXizSczHImnZBzn47wVO2WR5im1j3l4lqvFRFEF/Z+U
	V0WbqUxlpMjQW4GaS8w97QHmsbrjiJyRV3oY8GVHYLtvzsVasVyU1cHVIPT4k6EDiIFM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whbUM-00BPJK-HA; Thu, 09 Jul 2026 01:15:34 +0200
Date: Thu, 9 Jul 2026 01:15:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/3] net: dsa: mxl862xx: add SMDIO clause-22
 register access
Message-ID: <98505e14-d684-4225-9415-f4d872113998@lunn.ch>
References: <ak0KJ6gUk2l_IwoI@makrotopia.org>
 <96c362d3-59d2-43c4-b2aa-c12dfeb6fcca@lunn.ch>
 <ak6o7Ovekjb_evPs@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak6o7Ovekjb_evPs@makrotopia.org>

On Wed, Jul 08, 2026 at 09:45:48PM +0200, Daniel Golle wrote:
> On Wed, Jul 08, 2026 at 07:22:49PM +0200, Andrew Lunn wrote:
> > On Tue, Jul 07, 2026 at 04:16:07PM +0200, Daniel Golle wrote:
> > > Add mxl862xx_smdio_read() and mxl862xx_smdio_write() for clause-22
> > > SMDIO register access. MCUboot rescue mode only exposes clause-22
> > > registers; the existing clause-45 MMD interface is unavailable during
> > > firmware transfer. The MDIO bus lock is held per-transaction (not
> > > across polls) so that SB PDI polling during flash erase does not
> > > starve other MDIO users.
> > 
> > What other MDIO users are there? It sounds like once the switch is in
> > rescue mode, switch management is dead. So how can there be users?
> 
> The MDIO bus lock refers to the host bus which is used to connect
> the switch management interface. The same bus can also be used to
> connect other unrelated PHYs (eg. to provide a WAN or management
> interface independent of the switch).

Thanks for the explanation. Maybe 'does not starve other non-switch
MDIO users'?

I've not got to the rest of the patch yet, but i wondered if phylib
might still be trying to poll the switches PHYs.

	Andrew
