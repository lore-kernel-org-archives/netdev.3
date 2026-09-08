Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B405452A2;
	Tue,  8 Sep 2026 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876919; cv=none; b=CzrcJuqJczzMApkMqoL+HAHOUO+OH8Eyg3jIxbIcXHI6xSiFMv14aljxevz7k1eQdpPteVLgRAC1stC2X0+18DMxacNsPpLd3LLNpDBHfId+xTMxAygoEWcif4qdJJMBOLhtiTHQK9/uRQ0+hD84ZL/DRCcooaNDYJSgJzEOsI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876919; c=relaxed/simple;
	bh=rWGB1xQsPqC57abiPtPIuURjJ+WGJBoKLTdoQ0XY6nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwGrRC28RH+dP/C770bTyGvw8z+Li+SCbFRGTYdHj4EWE1xEADOK1/cOyOs3wJ7qjmy/6ZTD1IXhb9RsziL/C/fukxepm4/P1TWEE0lpFStXVPG1dv6b7HR0Ae1yfKKznHxbn5GyZSqFm3SlBhb5GL+vY4sxabmi37/r3p/PLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q5SpoJy1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q5SpoJy1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MOTz/U5xVEOz81wxbrN54xwusG1fkct/Rq26Qe4gB5Q=; b=q5SpoJy1vAV+kut89zr2uS+UGa
	4YpWPdL8H85xHKUNs2JF23Ak4ZrXW/4PhaUchTYk66568+b4/K1PCyuAMKOsuVckkQq1NKYkwevcM
	w1Jr03WsCahyihzJpv3mu6XfBhh7ZMFkYI69hu2Vc6equq7PYfMTHb5Ke+LcvRPrfNQE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3wbC-003uZG-FI; Tue, 08 Sep 2026 16:14:58 +0200
Date: Tue, 8 Sep 2026 16:14:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: dp83867: restore the LED polarity after a
 soft reset
Message-ID: <252b331b-0ae8-4248-bcfb-5c63d8c2b7fa@lunn.ch>
References: <20260908114901.74637-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908114901.74637-1-donggeunyoo.kernel@gmail.com>

On Tue, Sep 08, 2026 at 08:49:01PM +0900, Donggeun Yoo wrote:
> dp83867_led_polarity_set() programs the LEDCR2 polarity bit for a
> DT-configured LED. It runs once, from phy_probe() via of_phy_leds().
> Every phy_init_hw() afterwards (phy_attach_direct(), mdio_bus_phy_resume(),
> and MAC drivers such as fec_main.c) calls .soft_reset first, and
> dp83867_phy_reset() issues DP83867_SW_RESET, which restores register
> defaults. config_init does not touch LEDCR2 and the requested value is
> not cached, so a DT-configured LED polarity is lost from the first
> attach onward.

What about the other bits in LEDCR2? dp83867_led_brightness_set()
might of been used to turn the LED on/off in order to show the state
of my caps lock key, etc.

	Andrew
