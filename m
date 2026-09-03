Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C398C490C1B;
	Thu,  3 Sep 2026 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438283; cv=none; b=alcZ2gW9cMtRzI6IyHyqxzNYKmuBZW/Ln3dxv3n46Uc+9ukt6b1gjGhBSf/zswkbA2Di4WMGIQ46s766qcaulkkWEpIyirq1kTrrL/LyzspFQRtUmdeHWlqKldMQzZLod3+iG7khB+GzUdDr9T9NCeaLzfI+JQLw5nsKlwHzzgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438283; c=relaxed/simple;
	bh=9DEnXh1ZLlGgNc243B0KvcYmHPzNxZq/epYn5VJSMPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR2KlfGPmu7CVOLNT3AGSjsU+lAdrjbg/hccBGlY7tCXCmr2jYro6O1S746TspaNl+AmH34cNmOFYr5TKHcFPBFTI41r0w13ETsUeYW7HgmCcGcHD7+npxV7nNNSVzkVCS3Q8Gpfj90On6jdNccl5Qw39g4gjKaODdKJUqO8/V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5o6tujod; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5o6tujod"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H5ZZhwockPxWVjGyDcKUGd0wOptVbOXPYmCwFoHMfUs=; b=5o6tujodFE8QR4lh1kEEI8HwQo
	sKZvUSTrfQF66giRCiXwbKQyMMSBT2I41V6g2GPWcw7x/t5J7b2wobzdVW/fqbKU26WTL+OrQgNzM
	vWK/KmkviaIwL8XSKUAuPhbQxsvWTBDCXksu2tQMMJTUhiKlzzSsJgeu13fnxQFD5hRg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x26UY-002ic9-6S; Thu, 03 Sep 2026 14:24:30 +0200
Date: Thu, 3 Sep 2026 14:24:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: dsa: realtek: rtl8365mb: add EEE
 support
Message-ID: <1f2253f9-3368-4033-a091-ce424c08af89@lunn.ch>
References: <20260903092211.2922058-1-o.rempel@pengutronix.de>
 <20260903092211.2922058-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903092211.2922058-3-o.rempel@pengutronix.de>

On Thu, Sep 03, 2026 at 11:22:11AM +0200, Oleksij Rempel wrote:
> Add EEE support on the integrated-PHY ports, controllable per port via
> ethtool.
> 
> The integrated PHYs have no MMD registers; their EEE registers live in the
> switch's OCP space. phylib accesses EEE as MMD registers, so add
> phy_{read,write}_c45 realtek_ops that map those MMD accesses onto their OCP
> addresses, wired as the user MII bus C45 handlers when the chip provides
> them (rtl8366rb etc. unaffected).
> 
> The hardware manages LPI on its own, so advertise EEE to phylink with
> no-op mac_{en,dis}able_tx_lpi callbacks. The LPI timer is a single global
> per-speed register, so .set_mac_eee rejects the per-port TX LPI knobs
> rather than silently ignoring them.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
