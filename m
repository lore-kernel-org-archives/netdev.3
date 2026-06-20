Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420551FBEBC;
	Sat, 20 Jun 2026 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781983490; cv=none; b=lxFP9sfoju8FNSLhV6zSGJjsm7qALXZROOospUlP3Z4D1/jR4flRGelADPv9XHhFezEmKSShj8azxUTBqtlnhUshMLIqZeLcKQfRXyX46Y8Cfken7AWPUrbj0BDbr4TiwLKyV8CtpBKgvXC2ocyS0mT8XUAiKzoKq0K7HH8HUnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781983490; c=relaxed/simple;
	bh=0EhfHHmd454sxOP6bZLi9rVkgwtyXZBFCpbo4ZcKf5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmzmAKg/BVmW0NZMWM7JCzr36EdkUodVB+6pwch/VGf/qqqKfM73CQz3nxybLEUGVJIpgQAdW9PIRHp81enYNvd2iFZtdqZ2SVEjNNAzR5XSCWLznT+aaBN680foWK8lONVW617DjJKwf4D1W9vGImoxOk2Jp3shNC+ei+R2kQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6D6tNnXt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6D6tNnXt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5Vr4wzBSMmUUn3FU+bTe35KUPQSu4QlPmHGB/7aG0pw=; b=6D6tNnXtQSl4hxbOe+OfrJd05v
	2ZteX0dAsB9NUN/1Ym88IooHpEz/2kJYTN3eZjpssNIbJ3GBwDmRAUuo6iAGU7kJmZGP+JvuPgdyl
	m1wsfOTqWzmobB3NUfgGaU7J3qr7bLMX9c/3/PvBNFWbQINVmMneY00wzYcUnEcNmlUI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wb1J0-008d5X-7q; Sat, 20 Jun 2026 21:24:38 +0200
Date: Sat, 20 Jun 2026 21:24:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk, vladimir.oltean@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phylink: print correct c45 phy id when missing
 PHY driver
Message-ID: <f1900d7c-955d-4d7e-adfb-c66fc53a5a9f@lunn.ch>
References: <20260620131130.949298-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620131130.949298-1-olek2@wp.pl>

On Sat, Jun 20, 2026 at 03:11:13PM +0200, Aleksander Jan Bajkowski wrote:
> If no PHY driver is found, `phy_id` is returned. `phy_id` holds the c22 ID.
> Modules with a rollball bridge support only c45 transfers. The c45 IDs are
> stored in the `c45_ids` structure. In the current code these modules report
> an ID 0x00000000. This may lead users to mistakenly conclude that the
> rollball bridge isn't properly implemented in their SFP module. This patch
> fixes the wrong IDs for c45 modules when a driver cannot be found.

The problem with C45 is there is not one ID, but multiple IDs. And
they can be from different vendors, depending on who the different IP
blocks have been licensed from.

We came to the conclusion not to report any C45 IDs is the most
meaningful thing to do.

      Andrew
