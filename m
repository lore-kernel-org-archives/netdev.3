Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E759A45FFA5;
	Wed, 26 Aug 2026 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764544; cv=none; b=C0B1jT4yj4sFXoEyuUp4yONXG81mJZ5iWJRkOx+H0Ost/qrmpT9xY9o2Sn797lo9sNgxeiJuQ4K3+8NknnkB7hJ57VuxRz6zqLAyIupoDucQZY2r+C3mWQKVXkOSPtOLwIVjWiYL4Ck9FswApIpfkNkxDVIEuM2exHRyjesJvIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764544; c=relaxed/simple;
	bh=4WlcAwsBthws5nO6s/ckaxYcloMjGe6I3tef7NcdXuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kevKLV+QDLeyIdDZrwbA+AGD5rPt+N6H6M2mschNeEAWcXHidIU8vLzRDLbDf7gujHlag4T6v6jgrzGMmMxrtws+2z1TFZSBvSCyiUVtz5cgwknboCfCBh+YURpAqqr8z2bIkk373a7xYMbZhlMg4ZjLECoo7Csw784PQnHmAZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=phZDpajS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="phZDpajS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pAjODtpQqyueJbvp6Fq4/45DZn9lRL9ZRH+sAfq2788=; b=phZDpajStQl/ZW14WG+hCFWE8R
	zr+Bd88VPCP8uUTag9XQ/e3W0xqSQov70rgBgfjtdvbM4LSYAH8Udh8P+7/EWhSTfTpXLu5//SRMB
	ad2B5G6D8H/2lI6SfDA/D+728CfVIEXuxF1b+wUEH3776mhh6sC9BTOM6DgDQB7wUy3c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzHDC-001Y3I-2I; Wed, 26 Aug 2026 19:14:54 +0200
Date: Wed, 26 Aug 2026 19:14:54 +0200
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
Subject: Re: [PATCH net 1/6] net: stmmac: selftests: Check multiple MMC
 counters
Message-ID: <3d6e75eb-be26-47a2-96de-d29c0b634bfc@lunn.ch>
References: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
 <20260826140500.616466-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826140500.616466-2-maxime.chevallier@bootlin.com>

On Wed, Aug 26, 2026 at 04:04:53PM +0200, Maxime Chevallier wrote:
> The MMC counters report MAC statistics. Multiple counters can be
> enabled when the IP is integrated, however there's no way to know
> exactly which ones. Un-implemented counters seem to report 0.
> 
> It was found that on StarFive JH7110 and Amlogic SM1, the counter that's
> used by the selftest (mmc_tx_framecount_g) isn't implemented, triggering
> an MMC selftest failure.
> 
> Both the above SoCs seem to implement mmc_rx_framecount_gb, let's use
> this counter as well for MMC counter validation.
> 
> Note that this doesn't guarantee that we won't encounter the same issue
> again if another IP implements yet another set of counters that don't
> include that new one.
> 
> If the game of whack-a-mole with implemented counters becomes too hard to
> maintain, we may simply consider removing the MMC selftest entirely.
> 
> Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Seems sensible.

If more moles need whacking, we could consider the value of 0 as
success.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
