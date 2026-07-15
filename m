Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1434248DF;
	Wed, 15 Jul 2026 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784146643; cv=none; b=SxPSqx8Jkjz6V/GynWTRUZWsjQ1iQ1gGsanXwTIDrIJh+Bg8cMSxK39LO4ovo7DI58eq/GhMon5AnvlMa+odsw0DZSjitFxvlo6RFlJ1eOfUXK3SZI9VQ+A5uyvLib+8mw7Krita3VzXWtldSvEWP32m2wxG/BeP/7Bnc7oQ/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784146643; c=relaxed/simple;
	bh=Y8RbGicqciH4YVXdpGvnlbxYu1En1Zgwql1aFPqhdcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giIpWA1i9pM2K0rNNVL8g9gqCYiARb3dI78pynQ/CDRi2L7tMiY9qRCsHV1tuLKh0KAnLKHj+oZlL+Yr3ObU+wLKCdeBee8JK9Rk8dQFt0bXUg/FZQd0IjQZ5/JPQ/mE8MZNbflGCohT0xtt2xuIODGn3SVUEZ3rY72TcTHV8vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n0Bhf4CY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n0Bhf4CY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0vkvPbGVeeie5MdKofKnxfVICX0ID/+ET99g5gac/cY=; b=n0Bhf4CY5/2QRySJIy63HCBlxR
	NSuUdmkvrfWaGo1gWjI8fGRk7QUZ56Mc/yjddOFadf9wfs6zaxILx48Sv1R7tNxRtbNq0PpUXEg3J
	j9xK//r1Jzk5YdkNGRX5yGfNF29DLU6OSj9qtC9Vx3/fcimB9UgIa39HiEDTg+tVCiVk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wk62Q-00CQAq-CM; Wed, 15 Jul 2026 22:17:02 +0200
Date: Wed, 15 Jul 2026 22:17:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next] net: phy: drop duplicated header include in
 mdio-device
Message-ID: <5a917e15-5cad-4101-801f-8786848a71bf@lunn.ch>
References: <20260715201213.206180-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715201213.206180-1-maxime.chevallier@bootlin.com>

On Wed, Jul 15, 2026 at 10:12:12PM +0200, Maxime Chevallier wrote:
> During a tree-wide gpio include cleanup, the linux/gpio.h include was
> replaced with linux/gpio/consumer.h.
> 
> mdio-device.c was already including that header, resulting in a
> duplicated inclusion. Let's drop it.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
