Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA59361942;
	Mon, 10 Aug 2026 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377902; cv=none; b=b8s8RBr7vQX/g2dbnWw7miBzW0e91HFWJyFcEx5TKeKLfcmtbIOBKfncM9Nteu5Sxn2GPD+YyGiD6ZvWX283ICDj3qTHz20DXhn412bZzuIiut3iBFQbnoSzLzWW/VHGzC9ofB4RsBefNNDfDh7nbQhlh0esqW3sE6YafY867kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377902; c=relaxed/simple;
	bh=DwkmqhLEyV/bGXpKf4SRdyai3NrqSm1inhujU/yFmxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+0x2WOQq0f9/QflrHvrLZbpWDz01ppqLXWdV3CTm/NLet6AU+rKAUM9sqdKzKMgHWJY5kAkX431Ae/VVu7CJuXQtBSxNW7gIncx6X4GM3CvBCtO6xr4OucQst9ADYg6usfsHpuXFS3r1LehZO47De4MN0ts7hu10kEn2YcY2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JB4wSMFP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JB4wSMFP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y4AITN0RCwXypX6V4I5qA82RE//jsyui6N1bPe6k7z4=; b=JB4wSMFPSr7qsbEipgjPbQ06ja
	VsbZHiaEKMqFqWUo+vk15V8ElqwawHOk8SbyPEXOqrYhHxuzcOdX7y/v2E0jyTU9hWeTJi18aNN3h
	hVUTpa1veO2lLGjWNt0cA0a3+aOJIkkZwXF7WrlRfW8XDRRZPxw2hWEcBB+TQxxlYKgYB9gjF7AE2
	pRnYNNNRmcoe3IgTEao5rreKpwKnr9mfLpNLwEqmUNOGQPLtd5mNq/mujby2j+xRgpYWGY78wK6A4
	TSUz11KH6dk20MzLWdkTjLK3sZVsSeIr7GwLhYb0XbDoBs/ZTRPOY8INhivOb13QH1c4iaPUdXOnT
	at8p2fnw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtSUS-002s2B-0A;
	Mon, 10 Aug 2026 16:04:40 +0000
Date: Mon, 10 Aug 2026 09:04:33 -0700
From: Breno Leitao <leitao@debian.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Russell King <rmk+kernel@armlinux.org.uk>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next,PATCH 1/1] net: stmmac: Fix manage error case during
 stmmac_dvr_probe
Message-ID: <ann2g_WFlHAaTnFI@gmail.com>
References: <20260810150749.458682-1-christophe.roullier@foss.st.com>
 <20260810150749.458682-2-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810150749.458682-2-christophe.roullier@foss.st.com>
X-Debian-User: leitao

On Mon, Aug 10, 2026 at 05:07:49PM +0200, Christophe Roullier wrote:
> In case of error during stmmac_mdio_register, pm_runtime is not
> cleaning before exit probe.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> Fixes: 5ec55823438e ("net: stmmac: add clocks management for gmac driver")
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Breno Leitao <leitao@debian.org>
