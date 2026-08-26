Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A463EE1E5;
	Wed, 26 Aug 2026 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768478; cv=none; b=rOAWLobqK3EpEmc3+W2wcph3RVnFwKbacZsOTOt0PGjHxnJ54nJQjU7pma3/wWl368CbFuguFl26FnaJv0+OKGU59bKp4XZiXiwIzM5GsoSerl4qFYwAS6YtekLNEm1+LjJnHf2ivtAHZcutVk6nhZ8GimbXkZLn4+7oLhd/gQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768478; c=relaxed/simple;
	bh=VOnPnJ80iZ+h/9Z93HA0tEulZcEsXzobAn6JCdfnT70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeY+LpZG9WQdhwNp77yYmuS4tBlomQ+A6lJf/CcCJWAYQQOy9O9UGuW4tFhjoUdjfgQMHQLs+eReMHbOW0gTnfRl3fSvT7lE0CorlnZ13V93vY93l8tndoSgLg15w8uhcWShuCWilV+SA6dVUSaZ6jFbUZrA9EYxqwwdvN39PYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Hk1sA4C5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hk1sA4C5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zwuGqA37f+iLkmfyD6Zf5H9EKu/P6+wf6GNsdy+gc9w=; b=Hk1sA4C5Fk3HfdggGZLywciAjv
	DYKA9ZImEd9NE8zOP8r9AdBAy/ErgS6ku2FQ8c9HdvlvsqZFVYguqwufhQIYVJjQNG+YK4/GOQgiG
	tdyakHc2XbRZLAfYN+BUWg48Yz3VadoULf3opkrYvYY1h88mzD/mzAbWmWmIdJ3t5jGY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzIEw-001Ygo-Hc; Wed, 26 Aug 2026 20:20:46 +0200
Date: Wed, 26 Aug 2026 20:20:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Minda Chen <minda.chen@starfivetech.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net 3/6] net: stmmac: dwmac4: Account for the primary MAC
 address for UC filtering
Message-ID: <a4ba73ba-f377-4534-930f-5507bb2284fd@lunn.ch>
References: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
 <20260826140500.616466-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826140500.616466-4-maxime.chevallier@bootlin.com>

On Wed, Aug 26, 2026 at 04:04:55PM +0200, Maxime Chevallier wrote:
> The same filter slots are used to store the main MAC address as well as
> the address for the unicast filter. Let's account for that when deciding
> whether or not to use promisc when programming the UC list in hardware.
> 
> Fixes: 477286b53f55 ("stmmac: add GMAC4 core support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
