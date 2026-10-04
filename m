Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C5C47276E;
	Sun,  4 Oct 2026 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791138165; cv=pass; b=JC9zCuIbxdUDkZIP1lPpHhNNc1MzIDyd5675eSdu+BlS1m+t2EVK322nX9kphAqUo7z/QuR5DVKktR6TN/2enpQueOhvJmiDsv4q3H4AlYyTjKawL7TmGw9qBeO3n3LWFctINi2Vk1zmg9rGgpKiIP3hppOVwKMfGxa9oQIn97s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791138165; c=relaxed/simple;
	bh=VEwE65DM5MIhdG0SoXgdoyenuDG44eqV9z22wPGegBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=EAcHEQd7M7HNwJVVnTY6N4uxU9Nk8BUqJFK+wsQlOPIOwAVPy44jcYsiYFkYa4Gzc4c8hjyTm4+NT9NRhFS0U789O44wZsld1NfrlLVyx0KuhlXh0kL+ICbXJkw6hLlA7E2+/6FZiYlF8ir1MSry9Ej7bN6oVmDr/qjMXxCjdJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=GRkIH0FC; arc=pass smtp.client-ip=136.143.169.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="GRkIH0FC"
ARC-Seal: i=1; a=rsa-sha256; t=1791138128; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=gpN6QzHtQKEFogo3mQ5R9mehA6mrGqOliED9BNencIGYsmjGrDVmoB4Yo1crKsQWi3vGrsvW019FCOegSjByZExUFFoTtIbHjrfCnleBHgzgySa4phJJxRvL0GjXGWtKAe/PnX1tn6pNC+2WG6W/IG5CZlDtUQVPMKEPJYfU+eo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1791138128; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VEwE65DM5MIhdG0SoXgdoyenuDG44eqV9z22wPGegBE=; 
	b=FKCBn+RLuCAgx2u0agLdn/pvgLiMbEr/J+DyUVt6yEvVLngC3+2tQT7lehCcpHbjw/gw2MBqZnH0hvyMnf1hLtluM3lrPdUAgGARpN4INp529cujELVmpUb2YESZ1xvUnL1surUm5nTY/HcNOyDb1I/oAa9rnJktdCJ9hmDw/tQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791138128;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Date:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=VEwE65DM5MIhdG0SoXgdoyenuDG44eqV9z22wPGegBE=;
	b=GRkIH0FC0DyHldvysbc7coh14TUjLSIvSrEKfYMTYPOunKAjODL6FEMBqMC6Bc4W
	fomyWucCw69SWsqgNhetRzvQoy2+g5L6YcG/1TEUqfx55kYpXxueaM1FUiXxPW3jetE
	ZwFoILAIqvMB2mZa/ZTbcgN6kkOQqsoTb37JLGuw=
Received: by smtp.zoho.eu with SMTPS id 1791138126437858.8295904896949;
	Sun, 4 Oct 2026 20:22:06 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Lukas Wunner <lukas@wunner.de>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH net] net: phy: postpone PHY interrupts during sleep with
 MAC-managed PM
In-Reply-To: <281b1def-a8ab-4edb-b35f-a30dcdfdd38d@lunn.ch>
References: <20261002043548.1302145-1-iav@iav.lv>
 <281b1def-a8ab-4edb-b35f-a30dcdfdd38d@lunn.ch>
Date: Sun, 04 Oct 2026 21:21:07 +0300
Message-ID: <179113806785.1966445.16617711605614337666@iav.lv>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, Oct 04, 2026 at 04:28:50PM +0200, Andrew Lunn wrote:
> One obvious question. What exactly does it mean when the MAC driver
> manages PHY PM. Maybe calling irq_suspend is part of that management?

The commit that added the flag, fba863b81604 ("net: phy: make PHY PM
ops a no-op if MAC driver manages PHY PM"), says the MAC drivers "take
care of suspending/resuming the PHY", so that "the MAC PM callbacks can
handle any dependency between MAC and PHY PM". The bug it fixed was
phy_init_hw() from mdio_bus_phy_resume() running after the MAC's
phy_start().

irq_suspended came later, in 1758bde2e4aa ("net: phy: Don't trigger
state machine while in suspend"), for a different window, and was
placed after the existing mac_managed_pm return; its commit message
does not mention mac_managed_pm. So nothing sets irq_suspended for
these PHYs: phylib returns early and no MAC driver touches the flag.

> What exactly is going wrong with the ordering in your case?

The callback order is fine; the interrupt does not wait for it.
resume_device_irqs() runs at the end of dpm_resume_noirq(), before the
early and normal phases. The wake interrupt is pending by then, so
phy_interrupt() runs at once, while stmmac_resume(), which powers the
GMAC up through rk_gmac_resume(), runs only in the normal phase.
1758bde2e4aa describes the same window: "between dpm_resume_noirq()
and mdio_bus_phy_resume()".

As for the MDIO bus: with stmmac it is the MAC's own registers;
mdio_bus_class has no PM callbacks, so the bus goes down with the MAC
in rk_gmac_suspend().

If the MAC should cover this window instead, irq_suspended could be
set and cleared in phylink_suspend()/phylink_resume(), but only
stmmac, lan78xx and asix call them; macb, axienet, am65-cpsw, ngbe and
the phylib-only drivers (fec, ravb, bcmgenet, cpsw, ...) would stay
uncovered. Which would you prefer?

Either way, v2 will reword the comment you quoted: the point is not the
MDIO bus but that the interrupt can fire before the MAC resumes the PHY.

--
Igor Velkov
