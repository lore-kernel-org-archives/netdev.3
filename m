Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A725ED531;
	Tue,  8 Sep 2026 00:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828107; cv=none; b=Y11xonBE9WdhRWj3QTUC0mDgoln2jknuOyP/ju1NvWueFadmktLTUNPVEzkQZltFyOoerp7GwNuK5+t6bgSvpW3rHMx7HZ9hvr1J/1pz63rd/pjgGQAIQA6hmvXcZFWWaZySN0Z+PxPuIpuTkbHD5CXOj1P2VaD2cJM69Bw1dXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828107; c=relaxed/simple;
	bh=Qofa4cQHK6qbNmu2sWU849/REHBQs1ipCjwOSjxdkoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdt1+/95z+lscesrcJUiKRoCBIWzNzgV7OplJ/2DMGyOH7nfTff9nQMTokp4cXDjbOFmmszEHmMs2oAG0PObs5BSqBBDuRpmuh80bN7St5J16ISguyVpYYxX220Kj0ZgHD10kXQ/RvW64I/l9sfDDJHf2ntI46DypZYtJ9NWzWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bQOhoUW3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bQOhoUW3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZqZpcsRv2wS6wXbMkDMMPls/14KMoj3Mdz28oqaB8nw=; b=bQOhoUW3tgfx4Ak8gYC11DoSvt
	7ZUxWzbgUTBTNO709RkJB2x29aLqqp+iSnB9mgYh20mXsb2WrBA/uhugDt+Yph5lhzFUsl55aUO5l
	utLF0ItRtzQNRVIsLgurt98gjv9YzrAGMjvLsap4W+ROGcJhZpLTEqa8sT05nPRUkA1g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3ju0-003gXD-Qi; Tue, 08 Sep 2026 02:41:32 +0200
Date: Tue, 8 Sep 2026 02:41:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: realtek-rtl9300: Support
 non-default clock frequency
Message-ID: <31658548-f9d2-48dc-b223-02fee1d391e9@lunn.ch>
References: <20260906081946.3499898-1-markus.stockhausen@gmx.de>
 <20260906081946.3499898-4-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906081946.3499898-4-markus.stockhausen@gmx.de>

On Sun, Sep 06, 2026 at 10:19:46AM +0200, Markus Stockhausen wrote:
> The ethernet MDIO controller of the Realtek Otto switches has a default
> MDC clock frequency of 2.5MHz. Via configuration bits one can adapt this.
> Depending on the series the following can be set
> 
> - RTL838x: 2.5 Mhz, 10 MHz
> - RTL839x, RTL930x, RTL931x: 1.25 MHz, 2.5 MHz, 5 Mhz
> 
> Enhance the driver so it allows to set the clock frequency via device
> tree. This helps to
> 
> - simplify protocol analysis with a logic analyzer (lower speeds)
> - reduce MDIO access times during normal operation (higher speeds)
> 
> Note: While the devices normally support a per-bus frequency selection,
> the RTL839x is an exception from that. It can only select the speed for
> both buses globally. To avoid device tree special treatment for this,
> use the per-bus speeds for this series too. Return an error if the
> RTL839x Devicetree specifies different frequencies for the first and
> second bus.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
