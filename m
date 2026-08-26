Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17239768F;
	Wed, 26 Aug 2026 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768463; cv=none; b=bkZcdz7ukxBoB3jtFFAh9GM+fuz7HNm61eNXitGN/1ApqsNEDZ3WdS0FUf7nXcceY4oJUR6PlvRcLypcWtLvZ1mhtK1T/iuU1MmcHvP0W50LXEjugyjzaopc9MsJSllplhz8bPHZmjnSXAHTV31MRXWg77GcXkxxCFk5YHsOpzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768463; c=relaxed/simple;
	bh=XcHn/CQrREcHhOi5lDQoKlsKe1KIecSb5VA5GBFHNNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5JJJeEZN/fVc1eWwVSR0OC2/A3JNqutDFG0BxNPB1n4n9426wTfGfH+bwLN2EsnsEJIlgAfXwpndDRv+Zxhk+IQeJLyoeYZuz5i42HqKlema5Ll2v+j2o/8YZDEncyn+Wda1l9wnpWqfaB8UFTbW/8Squdy4boc+p7LJbfSy9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FLBJ7Hbf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FLBJ7Hbf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3J+94by0KWzCTNzt3+OAztwAe1j7eQMzuqcXsoony+k=; b=FLBJ7HbfjXV/nWArtIMk0naaBp
	Lak8kevUYOs+7jaUtJtXYoaZza1a2H5oLM4cow+hDurvz+i64tvoBVHRWKn3O23zIWOkzFny3bxkc
	8mBMkuFGBRquhShfDvV+NzPdILWQzRIfRMBGEl/bSNSHYQAN1zkEPE0gxf2yLiDBdU4E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzIEc-001Yfz-Dj; Wed, 26 Aug 2026 20:20:26 +0200
Date: Wed, 26 Aug 2026 20:20:26 +0200
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
Subject: Re: [PATCH net 2/6] net: stmmac: dwmac1000: Account for the primary
 MAC address for UC filtering
Message-ID: <3c8d8053-fa47-4a2b-839f-592c45b0e080@lunn.ch>
References: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
 <20260826140500.616466-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826140500.616466-3-maxime.chevallier@bootlin.com>

On Wed, Aug 26, 2026 at 04:04:54PM +0200, Maxime Chevallier wrote:
> The same filter slots are used to store the main MAC address as well as
> the address for the unicast filter. Let's account for that when deciding
> whether or not to use promisc when programming the UC list in hardware.
> 
> Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
