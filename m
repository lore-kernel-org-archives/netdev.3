Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E123E959D;
	Tue, 14 Apr 2026 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182939; cv=none; b=jWs0hlaCY/g4Jc6RDKZIQ68ZdB2WYb3FeIL1iZr2sXVtL17uOUQT8PFMpzFRqf+MXBovApLrip5DhkfIUx74gZmuo+eC8Vtj/FgMK6/CL3l11M0/qEmK1+Y9yvRTszYt/7ViqNhmwVH2nYUgpmAphzFEpkoO45VnOTQHUmu4aC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182939; c=relaxed/simple;
	bh=i7cLXOH3bg2HhdAtutDv7+140uaUv7c3qSpgUARvR3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3NVXcDNDy9OAqTzj41/+JkBXwlOIgBQ8shZIGDO66RIPIXsLc47Yj6qCjZmfV26O4tf2nbR7Yz8/Qwxsr8EXLykm0RTRtH7oP5aGujURJyoAhaQaeWgAN+qXSvMz2pDtT9PHPd6NF5iM0NYQksxaNBPbFneQCC3N1oxHCMjLZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LSFnxnfP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LSFnxnfP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=30DTiAdb2PIyWaBgT5fvXGend40NuCOrUtPsS7Neq6U=; b=LSFnxnfPfbDnomLHs40DQj06bB
	tYL5b941900GhYD2O2KHwB9O566w92Ap+yxROWUO1GmBOsLMhcoGrv+bxrHxmszj7mjRJR+D4x4MB
	J65s4d6rg81MrRs3DDz9qEwd5RshIB0wyqjA3xVM5iAck/CKPhakU5ImzrR6J9ZHBr/0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wCgJj-00G4d9-3O; Tue, 14 Apr 2026 18:08:47 +0200
Date: Tue, 14 Apr 2026 18:08:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Biju <biju.das.au@gmail.com>
Cc: Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/5] net: phy: microchip_t1: Replace
 phydev->lock with mdio_lock in lan937x_dsp_workaround()
Message-ID: <7924b6fa-8a8a-4a17-bb3d-40a9578a3f8a@lunn.ch>
References: <20260412140032.122841-1-biju.das.jz@bp.renesas.com>
 <20260412140032.122841-5-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412140032.122841-5-biju.das.jz@bp.renesas.com>

> -	mutex_lock(&phydev->lock);
> +	mutex_lock(&phydev->mdio.bus->mdio_lock);

phy_lock_mdio_bus(), and the phy_unlock_mdio_bus().

    Andrew

---
pw-bot: cr
