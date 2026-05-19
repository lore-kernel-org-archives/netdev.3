Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179922EFD9B;
	Tue, 19 May 2026 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779157202; cv=none; b=Jmp91onNgYeggrUDkJVoBiBULZloOM7IdlRtdHdmtInSZ52bpJRWK/voKPetIRkBB/DNupZs+uRPfPtl0Ebx2rMtcyMaKI9Gaxlfcx/XFjzeEiN6FoWZ7xcoS1xDqnwIcMhYvAuIvsvMGuUG4vlnEgbyErSl6wcssoZURC139pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779157202; c=relaxed/simple;
	bh=S+Be9QbRUA8mj/wKyMTanDw0iY8dOqs8erFeNPqm30o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIP6TzCQNf7wA8vrDRR32yKulbassEdZECE0Rfz2vznoJfUWH+fzkAAhwf6BmZFm3sy6mzmFLRWyUaCMinZr3jv2NW/njydbbiM7av0COc8r7ET4MxqI82jZhtBjRsUUy0VlMWniKJE7pge5Gfl8WGhplLKUICbl2TZrxMMY9ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ri6LkZ6H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ri6LkZ6H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TD50u8oIXhVSPGMfaOTBqShX/wD9XGWEgPD9NWB+GWo=; b=ri6LkZ6Ho5Ur2lSZiVBS6AMU40
	HSNEZfer3zgDEqdJGjurhNVIFbLakDoFyIuVjGE7CmAh9D+aKhUYPYb7ov3J+WySOtu3S4hDs3b0X
	nZlhEOQBvxLB34r1R4fLJGyZ5Ltd5xHonDf4dATB0RYbf81GdzKDLQm9YgB8FMtetb3M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPA3Y-003aFZ-NN; Tue, 19 May 2026 04:19:40 +0200
Date: Tue, 19 May 2026 04:19:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: phy: honor eee_disabled_modes in
 phy_support_eee()
Message-ID: <05a24b73-ff89-41e2-a655-224f1c2dbc31@lunn.ch>
References: <20260518-devel-phy-support-eee-fix-v2-0-05b52626fa68@tipi-net.de>
 <20260518-devel-phy-support-eee-fix-v2-1-05b52626fa68@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518-devel-phy-support-eee-fix-v2-1-05b52626fa68@tipi-net.de>

On Mon, May 18, 2026 at 10:23:09AM +0200, Nicolai Buchwitz wrote:
> phy_support_eee() copies supported_eee into advertising_eee
> unconditionally, overwriting any filtering applied during phy_probe()
> based on DT eee-broken-* properties or driver-populated
> eee_disabled_modes.

Sorry, i should of questioned this on v1. What PHY are you using which
masks advertising_eee in probe? It seems like this is wrong, and it
should be setting >eee_disabled_modes, or maybe eee_supported.

> Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

This patch itself looks O.K.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
