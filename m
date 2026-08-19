Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193734562A2;
	Wed, 19 Aug 2026 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146428; cv=none; b=Qr3Fw+I4z5Y7+IYvGBGZ5zyMQsqUi8OOK5Jgzv4EDw1cZFEQbnqRDHMtybQgvd/4YDvttAqs/urPKm9k+EnjgOePnCQ/XCg/dfcTMrX27BVSTzmBnGcbLOeL229GELVg7Sb77fyFYZ6ca3qCQ1lRk6lNm3K2nsnxmLTXjegwURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146428; c=relaxed/simple;
	bh=0l3XJJrWWNt8A/DgdkuFzG4f83aycIWuqHAltY1jjtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLkPVrgeeCbasq4rrCf5TSoYdHW/4fm2PTMzP10SlPDQlBhBzzkn033BQkAShjC22pJGK5+6oLEsjIxa8wd+JIhbqpuDo/JiTXrIGgyP0aHOMJoJCx41qQUMDSE7C5O6Rfil7FtpuBWvGcOIGjwufjq7RPHEpzbzXn7h9CDTjcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BxN1yftZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BxN1yftZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=giWqa6lpfFeCU/JLUYjYiMEl3KpEykjDpn1i4lrCPI8=; b=BxN1yftZkIQAr3grG+dBfOcgSP
	Mq90HcBzPKXTIzWjt4zv1EEDJguDVwj0GQcdfQxLF6bok3SKWOLTsw+RF0ZbXe6rQI+2mnCjpNLh2
	GMMySNThgViUitYSJc8NvM33XTHk7vEsgiVfhPR0AkcgeHlcmxGBxyBBx9sKentBYEpU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwgQ4-000c2M-Py; Wed, 19 Aug 2026 15:33:28 +0200
Date: Wed, 19 Aug 2026 15:33:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, kuba@kernel.org, maxime.chevallier@bootlin.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, chleroy@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v3 0/5] net: phy: fix cleanup after probe failure
Message-ID: <305b44bc-0a98-4481-8f92-b0c18a590b7f@lunn.ch>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819060236.24665-1-xuanqiang.luo@linux.dev>

On Wed, Aug 19, 2026 at 02:02:31PM +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> phy_probe() initializes the PHY driver, ports, SFP upstream, and LEDs in
> stages. Its error paths do not always release only the resources acquired
> at each stage. It can also mark the PHY ready before all setup succeeds.
> 
> Port setup also leaves SFP cleanup split between phy_sfp_probe(),
> phy_setup_ports(), and phy_probe(), and default port setup ignores errors
> from attaching the port to the PHY driver.
> 
> This series makes each initialization layer own its cleanup and propagates
> setup failures to the caller.
> 
> Patch 1 splits the phy_probe() cleanup by initialization stage.
> 
> Patch 2 makes SFP and port setup unwind their resources in the required
> order.
> 
> Patch 3 sets PHY_READY only after LED setup succeeds.
> 
> Patch 4 calls the PHY driver remove callback after later probe failures.
> 
> Patch 5 propagates errors from default port setup.

The scope of these patches has increased quite a bit. It is now more
like ongoing development work than a actual fix. Does this bother
anybody?

Please submit for net-next, once it reopens.

       Andrew
