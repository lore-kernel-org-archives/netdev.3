Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54640376A00;
	Thu,  1 Oct 2026 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880435; cv=none; b=f5GRtmtjLf9G2ECfsldmmUa35ByuF6f8ogxywyZmRhD2r59OzoiR/an1aPAIANR2eEU7M7XuWld9UkXrCfw6Vthe/xekDbMqEUXqRYqXOZskksUZCyrfvdLhPIKHPhwa+/cpuuQOFIHHb+uXakKxG2XovQ1ukV0jkF774WkkgwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880435; c=relaxed/simple;
	bh=Bb/hRJrBVDzdeBE8y6UEDigIIWGfH1lOT/PhCya8zRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8uNUTYX9GZFKIhb06ai58xc+t5cBP1LqItn52JuQqXsxkkOIrk6P3WgXIs1k6sud+ZY80jgQF16MdjZvuzFV6uF+cEXm4SZ7/dv2YEoje1AKg3c+jmiGppA8xD5HJxWOgraJCySMqsgyC2KPOvE+jFcPj2NdbFQ45WrMP9jVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=onVPciYp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="onVPciYp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FjP2eJrgBez3sre/vPENwEYU3qn89WadUYvbfIb/XK0=; b=onVPciYpIYETTkDhkP2EQbX9xR
	Kr6WQlauFGffWoTlcxKkG+Bt57bHK5Xact/hmLX40rI1rvILerkd15l9pL0yAMC0l/dqao35TWHNV
	wA4SlSKh0SfzNjZaHbODRo3pemXD8y38O37a5ApCLa2PyoWx+cym/+/pK40esBRbj/pc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xCLnn-008Rw2-Tr; Thu, 01 Oct 2026 20:46:43 +0200
Date: Thu, 1 Oct 2026 20:46:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qca83xx: read resolved QCA8337 link
 status
Message-ID: <7eed302b-d455-447f-9ce9-f15468b9792b@lunn.ch>
References: <20260928220749.857-1-yongzhao.derek@gmail.com>
 <01a62e77-6c4e-4665-ba46-26d12b1c77b4@lunn.ch>
 <20260930212348.1919-1-yongzhao.derek@gmail.com>
 <2ea832eb-33f4-4bf3-bdba-5d983038d012@lunn.ch>
 <20261001181634.1508-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001181634.1508-1-yongzhao.derek@gmail.com>

> This covers the resolved downshift case only.

It is good testing, thanks.

> It does not show whether
> BMSR can report link up while register 0x11 is still unresolved, and
> it does not change the SPEED_UNKNOWN limitation from my previous reply.

Greed.

> Given the traffic failure, I would like to target net for v2. Three
> questions:
> 
> 1. Is net appropriate, or should this stay in net-next?

The traffic failure was however because of the error with setting the
DACs?

> 2. Is 272833b9b3b3 ("net: phy: add support for qca8k switch internal
>    PHY in at803x") the right Fixes target? It added the QCA8337 entry
>    without .read_status; I have not checked whether the problem
>    predates it. Christian, as its author, is now on Cc.

Reporting the correct downshift has nothing to do with that, as far as
i understand. Correctly reporting downshift i would put to net-next.

> 3. Compared with genphy_read_status(), the helper takes the forced-mode
>    speed from register 0x11 rather than BMCR and adds MDI-X reporting,
>    and the added genphy_read_master_slave() call runs on every poll. Is
>    that scope acceptable for net, or would you prefer a narrower fix?

net is fixing broken things, especially regressions. net-next is new
features.

	Andrew
