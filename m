Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771412F25F4;
	Fri, 30 Jan 2026 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769789994; cv=none; b=FItdIfmbUcxrw1rGTx9Uwl7UTxyG/ktd0VVWs5sDiJBGSDCQe8C2sj0LQQx90ne6ts740ekGzd8ss6/C2WlXW1IsMFv9s7co3gKXRQcoRLL5BnjGDbQC0jJnvdxu7cwhcKbyQgB0vr8HlGb0ksZbUVKPVaIFPhwGjk6EhuHU5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769789994; c=relaxed/simple;
	bh=PiQgZZcorInq0S4HzqIulPa/M2q19fVfPYLiurUf7L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkCfNK79WvJtzPlHyj0oemUGYQURtJZxtWWSXYKmv7pTY0JRXVtVCbxtJHD8g0glNTD1rm3jvbxH5p8V63VP8YMBDhNPk/BKT4/ZHyTxp9zbecx1HgLhzLlgsoVeZmfA0ZB+pBam3Du3WgnstVNO6CSFb9ycZCvuzA3LaKj2zlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iW855gy/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iW855gy/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P58uO+BAYpVIo+eCGe07VYbdwc4kHeceYKayqC0HKmE=; b=iW855gy/q0M4oOCeI8VQksCwKs
	oK/n//lZ5TJOv/5eedI96KNpa3ieWfjm49ydTb7qqUEuO6af1KBQ0d22oUCtElAwpS5V6eQdBe2gV
	/s77+mfZkwUBEcLnYJye97K/FGasO78Rf5VYPnqw1dlLmgX/HyyljzEi9trTXd3OZjwhT/rzN4nkF
	ct2i9Qjj4TeL9s2zKyeLCIkoCp+p8UsYOIApXejjlZJFSQsbECJgiCkihWvfqiiw8PFwHRpMI3XX7
	A77Qn0H4XWOrCrF04MURMM/X5o7LHlWcxGpwxOdtwzPW22cTcmADqbOIUUlCxxVoO9RQ4pTsjsggS
	SD+UhuNQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49316)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlrDj-000000001Gw-1Wtp;
	Fri, 30 Jan 2026 16:19:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlrDe-000000000ep-2PMx;
	Fri, 30 Jan 2026 16:19:38 +0000
Date: Fri, 30 Jan 2026 16:19:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH net-next 06/13] net: sfp: Add a sfp-bus ops when
 connecting a module without PHY
Message-ID: <aXzaGg3AkHOdP30A@shell.armlinux.org.uk>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
 <20260127134202.8208-7-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127134202.8208-7-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 27, 2026 at 02:41:54PM +0100, Maxime Chevallier wrote:
> The SFP bus infrastructure notifies its upstream when a PHY device was
> discovered on the module. However, we don't have any indication when a
> module with no PHY was inserted, except for the .insert() and .start()
> notifications.

That's the way you tell - if you get the .start() callback but you
haven't had a PHY connected, that means there's no PHY.

There should be no need to add this callback, since you shouldn't be
thinking that the module is fully initialised until you have received
the .start() callback.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
