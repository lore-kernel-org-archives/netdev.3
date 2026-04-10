Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F13BE14A;
	Fri, 10 Apr 2026 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834148; cv=none; b=gYl8qwPvCG5CNKVfIFx2s8rb4keA4EqHqkpf3DZl4T5GHt2GU/JTNJUyakOdiE8ENBcqBSXuSHn0HskuNQ/0S2FW/y+VUoVioC8j+wKfQJaUqtd8eMuG78kCaYQgr7ABKYDjlVoEWhL/d3T0/TAzd3UV5o271AP3ECbs3Nl6OsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834148; c=relaxed/simple;
	bh=79Ft3EawdRTaRPnsUc57WsU8IM1P/+6pKmvXxFX9G8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIXXk5heQghjtkTlgOa/B68ZlsyKnAJWNlcABPyR33MneKZp3VSC2l6Nh74fwTOima6WPbZHdaUdmvCC34soureuLTZE0xcTd+OnIw11tnyB90qQriyWAGM2QvcfabSGmjIJLBlElr8AeEO+xURQdabOoyEIPUqbWf1/2WIehF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A9q8TcFZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A9q8TcFZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ApYujIacdP2aE8VOgRham25seSJS2gNnur5BRHQdK3E=; b=A9q8TcFZnrB/zmBE7U/X4VaTw4
	yedLMh5M/3SLuWQab6ei7ktvAFhpRcBw9OBBHRV9db/l7OJPmPDc/mazSfbK8tg2frGBKc1M1snvj
	8B5ewNpMh+d/t+ctfTF3MVu1z70yrfOsgBL4yxFmHszV2gtvgQkeovhwmvGD4LY0kiIw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wBDZp-00FcNS-US; Fri, 10 Apr 2026 17:15:21 +0200
Date: Fri, 10 Apr 2026 17:15:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Biju <biju.das.au@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH net-next] net: phy: call phy_init_hw() in phy resume path
Message-ID: <839fec66-5ec0-4cc0-a0c4-ae2de6902188@lunn.ch>
References: <20260410142904.439666-1-biju.das.jz@bp.renesas.com>
 <adkOZl4gt5UoGv-0@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adkOZl4gt5UoGv-0@shell.armlinux.org.uk>

> Apart from that, looks fine to me - it seems some paths call
> phy_init_hw() can be called with or without phydev->lock held, and
> this one will call it with the lock held which seems to be okay.

Haven't we had deadlocks in this area before?

Please test with CONFIG_PROVE_LOCKING enabled.

       Andrew
