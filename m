Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D481DF73A;
	Tue, 14 Apr 2026 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182785; cv=none; b=B+Zp5t+KT+ioIOexECWNXb6Ieh32JDv6lCqfpoat9KSpLGGOm3/wzXxNRYhEx8Xh2zS4fahOUp+ZDmJGj+yR5AKUZ/lMnnuKMBy6IO9cUxhcaTMLDdKIlCsA3XRfRwjU1cgaj2SG/5FbZh8ZOMcZQRskRNv8a56iO8c940pra+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182785; c=relaxed/simple;
	bh=X6n/ePmx7Y8XgbFs+FLGlMsly7Z4KqP7ndxWxu76KhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKlz1T5f3o6SGkkpzkQWjMNoMicGfGmknQkCn7dQ/bnzs7GfQJ752BsDV7xFe5e7hyr0hpPdgvJc3+JyRns34mooP4MpEZlKsPFWmcSvtf+CzkBSoyA8wsaLSKAmFu02TGsuNADIZ3asllt9vwhJLfGH7I4zEmpQ4opopxm5jYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FaujmS2I; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FaujmS2I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=1aIwPjpUdqpVRY4z4kfe5+tt4PPO5m5sZ4yKz7WEsBE=; b=Fa
	ujmS2IKGj9jggVpGmyFSBUB1OOnab3CpQInT1HIsaj93aAB1fQ44+2lxcmMyFYT+s1Z3tw13eZ0ta
	XJKkntdcgW0Qg62EUEa/meKs+EC5zUIR6zgwIBB27wbfUeZrp0uOHmndVnU1/hneRpfpgf26HNwRg
	DnhcL+aXC8LFUb0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wCgHC-00G4bE-5E; Tue, 14 Apr 2026 18:06:10 +0200
Date: Tue, 14 Apr 2026 18:06:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Biju <biju.das.au@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Russell King <linux@armlinux.org.uk>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/5] net: phy: mscc: Drop unnecessary
 phydev->lock
Message-ID: <5431b5f1-2cea-4f32-8e03-51251dbbe648@lunn.ch>
References: <20260412140032.122841-1-biju.das.jz@bp.renesas.com>
 <20260412140032.122841-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260412140032.122841-4-biju.das.jz@bp.renesas.com>

On Sun, Apr 12, 2026 at 03:00:25PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Remove manual mutex_lock/unlock(&phydev->lock) calls from several
> functions in the MSCC PHY driver.
> 
> In vsc85xx_edge_rate_cntl_set(), phydev->lock is taken around a single
> phy_modify_paged() call. phy_modify_paged() is already a fully locked
> atomic operation that acquires the MDIO bus lock internally, so the
> additional phydev->lock is unnecessary.
> 
> The remaining three functions — vsc85xx_mac_if_set(),
> vsc8531_pre_init_seq_set(), and vsc85xx_eee_init_seq_set() — use
> phy_read(), phy_write(), phy_select_page(), and phy_restore_page(),
> all of which operate under the MDIO bus lock. Taking phydev->lock
> around them provides no additional serialisation.
> 
> Along with dropping the locks, error-path labels are renamed from
> out_unlock to err or restore_oldpage to better reflect their purpose.
> In vsc8531_pre_init_seq_set() and vsc85xx_eee_init_seq_set(), the
> redundant intermediate assignment of oldpage before returning is also
> eliminated.
> 
> No functional change intended.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
