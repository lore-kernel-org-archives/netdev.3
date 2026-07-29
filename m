Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636330C632;
	Wed, 29 Jul 2026 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332863; cv=none; b=Z2K8eAKiTS1252GMxkr5hlfb/RXr6D93YIrY8Ym2MvW1qfLqkgrYSREhlggPNTizZyFc/euTFkYbiMUVExredTE37K690qkPf/vDP/RnSo/ktNRdl8YILnimoGNiBAjFZ03eXh7K9/w+ijGqMiBM/7C1OPaU3tblUPkdlVZ4n00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332863; c=relaxed/simple;
	bh=jlEI1LUBgajHoFcOAJRp0V5kt1+ea9ofQmYXh2Eqov4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oD2tQau1uDyoUhi7jxazxjq1wgRubbe13d2RWLpxn8iuG49BxT0uzJ7NHTQto6RX3aAwQqLFJ420lJY/OH8+AL4D873iLuigYgubzmqJiakUSHYILoVafBQ4UV78tn6P22fqa7bPbBpA0MtwY7LYhktGKk5OIxj3eaa9ZMrTCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FBinOYbQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FBinOYbQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UdsFQ5s299fIGj8Ok0XfdFGBptUgMB2HbZQXb2FyzEw=; b=FBinOYbQTFWp5j4oP8bNpb1eTj
	1bpznOfq9M97gEpz+TtjxUCiHQUhWLADjwQjlOyMHNeKOV/mxA9AtFaUeuUuxRYrJ5LvaAKKvu6Ym
	+cz54qqrnyGPnh0PW88ifeHXaTUDCI8FH15DvlYjxj8/dUYooJelXOh9VS6LVJw2c5I0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wp4d8-00EpNQ-RB; Wed, 29 Jul 2026 15:47:30 +0200
Date: Wed, 29 Jul 2026 15:47:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net v2 RESEND] net: phy: nxp-tja11xx: cancel registration
 work on remove
Message-ID: <7295d315-f091-4e93-bc7c-b9deadab0ab1@lunn.ch>
References: <20260729092714.965-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729092714.965-1-getshell@seu.edu.cn>

On Wed, Jul 29, 2026 at 05:27:14PM +0800, Hongyan Xu wrote:
> tja1102_p0_probe() schedules work to register the second port. That work
> uses the Port 0 private data and phydev. The private data is
> devm-allocated, but the driver does not cancel the work before detach.
> 
> If the device is removed before the worker runs, devres can free the
> private data while the pending work still dereferences it.
> 
> Store the Port 0 private data in phydev->priv and add a remove callback.
> The callback waits for the registration work before devres can free it.
> 
> This issue was found by a static analysis tool.
> 
> Fixes: 6a64d3cdc5ef ("net: phy: tja11xx: add delayed registration of TJA1102 PHY1")

I'm not sure this is worth a fixes tag. Does it bother people?

Have you managed to trigger it? It would need a script looking for the
first instance to pop into exists, and then unbinding the driver as
soon as it is created.

To me, this is yet another theoretical problem which never happens in
real life.

     Andrew
