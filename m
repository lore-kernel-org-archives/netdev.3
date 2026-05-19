Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66E3282F3C
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221815; cv=none; b=Q+VzIslDomgFrRox4Ycl5U0IatnSXqCGOV4v+rd+GAfWZ+FDAG1nLpc3A04BjM8XSfe8Cx1qS5SfrWH7B8dzak1RWoN4l3dIwhxflKwMaSDPJ0dxgYx9tfkWIKFaYduUCB16TiF3eEyJN6uLKb4Q2TcrTXwvJ2LWti6v2L80FDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221815; c=relaxed/simple;
	bh=dGpJxdmWIdtkbUWfe5ZEUFoP+OucZxgs7QjQkiD6LaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPxXMhloGQFaBxrerth0G/0V03OzZOGbsW4HWy6D958ahAXrKI81rk2SI4faKsZku6UwDyq2HMgbUbWHt3lnvjS6KSlsbUrA86oUUgruO7GNIGVP5V6//nRf0hgPKzfNuYfei8WaUkDNbfKyJrN555uNGvbvEa8HPaT+JyZb6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wz4Q52uJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Wz4Q52uJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ghfwAPHE10xSa9cu+i62DCg74sBvC8NfItxWt8xYocE=; b=Wz4Q52uJxbCCdvzKCQYpCxSxwk
	7f3lmB6ixZUeA5lLU9JMszfU4w5j939zqgAxzbCoRoajwWld8cE73yX9KozpMuXEoG6YsHHdj+LD5
	plL3DUjMprauZPu6t4ZC8FVFEcKv2Unlvez/AYx2+6jjAjrf4oLP6Retr5jzv0yw306g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPQrs-003jEL-Ep; Tue, 19 May 2026 22:16:44 +0200
Date: Tue, 19 May 2026 22:16:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Subject: Re: [PATCH 9/9] net: mdio: realtek-rtl9300: Link I/O functions in
 info structure
Message-ID: <c7eee96c-02fa-4e6b-abc9-ea6ba9a46106@lunn.ch>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
 <20260519165747.1288903-10-markus.stockhausen@gmx.de>
 <e4a1cd96-ff7a-49e7-add1-353a24b9aa08@lunn.ch>
 <021a01dce7c5$450cc2b0$cf264810$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021a01dce7c5$450cc2b0$cf264810$@gmx.de>

On Tue, May 19, 2026 at 09:25:30PM +0200, Markus Stockhausen wrote:
> > Von: Andrew Lunn <andrew@lunn.ch> 
> > Gesendet: Dienstag, 19. Mai 2026 20:46
> > An: Markus Stockhausen <markus.stockhausen@gmx.de>
> > Betreff: Re: [PATCH 9/9] net: mdio: realtek-rtl9300: Link I/O functions in
> info structure
> >
> > On Tue, May 19, 2026 at 06:57:47PM +0200, Markus Stockhausen wrote:
> > > All SOCs have slightly different I/O functions. Make them device
> > > specific by adding the functions into the info structure.
> >
> > If they are all different, why put all the registers into info?  Is
> > there some level of sharing?
> 
> Patch 5 tries to explain the sharing concept:
> 
> - A generic access function will always run the same way
> - The info structure tells it where to write (registers)
> - The indidivual access function tells it what to write (data) 

What to write is a u16. What else is there, given this is MDIO?

     Andrew
