Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C213ECBCC;
	Tue, 14 Apr 2026 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182594; cv=none; b=BcTLbCk83yvtLjw04jarhXFFHUsV66emzLaQq8zVFlMm+ue5MN4wXXCbmaqt5GuytmBxw3K+bfCew8LYIxLqcVS7Aq0ROIgjuyg/y3cfurAb+AyDmeH0Z13jibfB/kPnu4nWzuixaHyi6y86R216h+oV3utmGkf/jbZodl7uLG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182594; c=relaxed/simple;
	bh=SFw9iz2oVl8hr1by6jpcXPTI7WCzs4roRgk+szgPTu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF9niDuvl6qHvZ8+bowLNOlmS0N/AuG/WU9VhCh8IsiquykUU8I7ojNluitQWiglIGSh1j/G7V2MbA58ciAgRjO0g8T5RjdrVZxKhdFO4nhqgIuK205bNvVfM6dmHdxNridwYCCVprASFvcfUFAzi8BbZAlWh3yf4IfifLy2k/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zwcEDXy8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zwcEDXy8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xQ58gtdAusbDMk8ed8MhQu1u9QhNqZSU4++degY58I8=; b=zwcEDXy8BaTZVIUp26BkIGtuvi
	MNsGHFutBTNIv2d9CXvQBKxx1rYDVIfeEpsCVacqfrOC4IRH9wxcvw5LTqUXBBsxF8zY8be7JDAaD
	K0giz+F83w6sJDssOxQlr9zaZfkLiMYSj7T0GYKzmYmVsdGype/PKEgS8Irpbipc/x0o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wCgE9-00G4ZV-3S; Tue, 14 Apr 2026 18:03:01 +0200
Date: Tue, 14 Apr 2026 18:03:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Biju <biju.das.au@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/5] net: phy: Move phy_init_hw() from
 phy_resume() to __phy_resume()
Message-ID: <b3521be0-c5da-45ef-b6bd-64e4a7b97966@lunn.ch>
References: <20260412140032.122841-1-biju.das.jz@bp.renesas.com>
 <20260412140032.122841-6-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412140032.122841-6-biju.das.jz@bp.renesas.com>

On Sun, Apr 12, 2026 at 03:00:27PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Now that redundant locking has been removed from PHY driver callbacks,
> phy_init_hw() can be called with phydev->lock held.
> 
> Many MAC drivers and the phylink framework resume the PHY via
> phy_start(), which invokes __phy_resume() directly without going
> through phy_resume(). Keeping phy_init_hw() in phy_resume() means it
> is not called in this path.
> 
> Move phy_init_hw() into __phy_resume() so that PHY soft reset and
> re-initialisation happen unconditionally on every resume, regardless
> of which code path triggers it.

I would change the order of these patches. First remove the redundant
locks. You can then put phy_init_hw() into __phy_resume(), rather than
first moving it into phy_resume() and then __phy_resume().

      Andrew
