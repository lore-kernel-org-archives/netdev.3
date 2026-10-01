Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB9C3911DC
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790824333; cv=pass; b=KSZOiHVufborrbaPKpT+hBUzfT/QXddTEN2Zo2M10BpDUETGop8jXqUUVsHwEHa/k5jIth569PxAGU7qn67f8OmuELb5kPEC3QKlp3NSwTSbCqNLcXV3sCBMdwFaifVEekgbgEDQrqKD0cpBY4TMsL1rSxCZIiYyp23oewPrDQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790824333; c=relaxed/simple;
	bh=SYd2eZNTTjbXE4pCMExkA3U+Sr74a01zLGfHC1ZABrU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHqmoA9mCQUda8M/UDHsJoXJUtC0r0p+FSIwb7XimroSv9nUsvHFZIwajOlAvGVjxuhYoSmM24ir18BT9yje3EV232wjDiObLHxmavr95k5mf8O7OGVepB96C/Mnq9JaSNT+Fgvb78og62OyvV2teEjJf3p0cn+VR3/1MOpwCdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=RN+2+W7w; arc=pass smtp.client-ip=136.143.169.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="RN+2+W7w"
ARC-Seal: i=1; a=rsa-sha256; t=1790824275; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=TA98rY7jTz2jj7alFAwPg1bklk78328w21pi6qQAyFcve7JVLpa6vDve2UHWF2KXEIseb/cnKMuRm9+cbm2O3nBBvdHMdAC7tieAFh++j4b+dmx7zBpMWLxsKEVJ+lpQWAgNRjTgSiT8lMhPuIuQAsP0cc8P9/tq4LXsjKwroAs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1790824275; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SYd2eZNTTjbXE4pCMExkA3U+Sr74a01zLGfHC1ZABrU=; 
	b=Ts4aE4gcocfsQ3oshOOYSOxDCcIWH3nFTzsDIObiVKNVX+RWr/NiQ9Z5gfMEzwFsDgc8EUADaAa5rZDTOS+DlQ8rCzbCYhojP7MDKgvvWmdjRO42h4xIsHQdQpXhNA0D/oUsRmtP1U0Rk8ia25wkPO44jsut9iUv7k4SX7cgoT8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790824275;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=Date:Date:Message-ID:From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SYd2eZNTTjbXE4pCMExkA3U+Sr74a01zLGfHC1ZABrU=;
	b=RN+2+W7w+CfQBqJmePn5t6EBN2gvfJdzdhKxJpw6IKvYDYsJiPa35YWkj7tg1qv8
	XN1VZqovdOVRcoAyhnZD/NZdBnl4GOqKlIoV06+W9MQoZ9SpdmViouOmL9P0G9Aa5+1
	TP/Kf7Z4fA683oO6LXiWllHR1AEh+P71hX2SBl5M=
Received: by smtp.zoho.eu with SMTPS id 1790824271591284.1136497752825;
	Thu, 1 Oct 2026 05:11:11 +0200 (CEST)
Date: Thu, 01 Oct 2026 06:11:09 +0300
Message-ID: <ab67bccd76b55d7252c5380a37809656.iav@iav.lv>
From: Igor Velkov <iav@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Eric Dumazet <edumazet@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: keep the GMAC powered when
 the PHY wakes the system
In-Reply-To: <1799630a-945e-49ca-b9d5-9e068c482cea@lunn.ch>
References: <20260930-dwmac-rk-phy-wol-v1-1-9fdc50bd9ae4@iav.lv>
 <1799630a-945e-49ca-b9d5-9e068c482cea@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, Sep 30, 2026 at 11:51:45PM +0200, Andrew Lunn wrote:
> You have not answered the question why is hangs? Given the current
> description, this just sounds like a workaround, not a fix.

It hangs because the PHY interrupt handler accesses the powered-down MAC.

stmmac sets mac_managed_pm, so mdio_bus_phy_suspend() returns before
setting irq_suspended and phy_interrupt() runs the handler at once.
rtl8211f_handle_interrupt() reads INSR over this GMAC's MDIO bus.
From rk_gmac_suspend() to suspend_late, and from resume_early to
rk_gmac_resume(), runtime PM is still enabled and that read reaches
the MAC with aclk_mac/pclk_mac gated.

On RK3399 such a read never completes: a test readl() right after
rk_gmac_powerdown() hung the board with no soft-lockup panic until
the hardware watchdog reset it (>5 min with the watchdog off).
Refusing MDIO access to the powered-down MAC: 10/10 suspends without
a hang; the same cycle script without it hung in 4 of 5 runs, each
time within three cycles. With the GMAC kept powered (v1): 45/45.

v2 will use device_wakeup_path(), and its Fixes tag will be
d65cb2e27e6e: that commit, not 6911308d7d11, stopped setting the MAC
wakeup flag.

pw-bot: cr

--
Igor Velkov
