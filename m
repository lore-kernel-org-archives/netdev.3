Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4244335CBD7;
	Fri,  2 Oct 2026 04:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790915821; cv=pass; b=YaaKK/lRz/Zqfe4OVDXYoTRQ5FokZVrICYN/rDUUEucWHO36/AXzA/Q96UUxB7tgVs16fyWwqcijd7aEikFLPzht0AwzRmQORlp62yzTsMAtW2mYCpFCB/ZXCrslXsPLV2zZMgiX4dYGi+bqirpe/gVzZotygpItnUbOs9UEVs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790915821; c=relaxed/simple;
	bh=aWT8IJMJs0ddLNcKHq0aOPNMWYxpA29aEZfuqulkpuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6IycL6uo38GBknCtZ8godJ7qxDsfkiylu+B6iJU18/MpeVRz1A9xqcPWth7jyGPpg68G7luCOAxIxWzzsaIthZzv9luZYpWWrFBR4IsU64ivsPyVsLTTzmhjiWqCr4POLJC2GfE+MWZQuGB4WdDef26l0q07bG2Bxk/5ydw/NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=EWDEobE8; arc=pass smtp.client-ip=136.143.169.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="EWDEobE8"
ARC-Seal: i=1; a=rsa-sha256; t=1790915784; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=BAmM4T8o/G+2/ZAM6FBd5VuaDuH38HqYI8M0IsPiZDm1DWWdoywuxVS5DqSzoW/99bx3wqBmJfd70XshxicNSbkEctrqavJF0H0a1O0qW6HujTarPRZgxcpXWD6is91MCm8lWxbA+cIq2zxUSqzufBCtpQ+I3cCHKSseYKobDJY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1790915784; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aWT8IJMJs0ddLNcKHq0aOPNMWYxpA29aEZfuqulkpuY=; 
	b=IYi0scl2PQxwLD2khWVjKstG7nPn5EpfzgJHeKgNuZ+7K3unRlZtCE6Ut2fVVAyK5NcgxPzJjaUOy7oFaRTSKw+1Ep7we80r6pUbqHRSmVra7OJ3CZNjOeLjSgxMi+fgUqahoP1VwZRjTLr2379ZOdvGRWGGymKGnm60e53pkxY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790915784;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=aWT8IJMJs0ddLNcKHq0aOPNMWYxpA29aEZfuqulkpuY=;
	b=EWDEobE84Je8hVOmuqvabN3tIeaKK29SUxl6obb2+443Ze9MhTRXLM/VaW6gfa87
	MdmEtHyipLgcWaidFj/fdCWqGtL5ud3ugWX6EzOr3BZ0Zv/omIaDEF2cKdrD5rzEDWE
	nQqd68vaBrdKN/u/fsU6CVpg4EYWkaFriOE5nLRs=
Received: by smtp.zoho.eu with SMTPS id 17909157823821010.4367848092561;
	Fri, 2 Oct 2026 06:36:22 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Eric Dumazet <edumazet@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: keep the GMAC powered when the PHY wakes the system
Date: Fri,  2 Oct 2026 07:36:20 +0300
Message-ID: <20261002043620.1303136-1-iav@iav.lv>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1795d1c1-7103-4dcb-856f-8881521417e0@lunn.ch>
References: <20260930-dwmac-rk-phy-wol-v1-1-9fdc50bd9ae4@iav.lv> <1799630a-945e-49ca-b9d5-9e068c482cea@lunn.ch> <ab67bccd76b55d7252c5380a37809656.iav@iav.lv> <1795d1c1-7103-4dcb-856f-8881521417e0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 01, 2026 at 02:07:41PM +0200, Andrew Lunn wrote:
> Why is the PHY interrupting? What interrupts are left enabled? Should
> the mask be changed to disable everything except wol?

Only the WoL interrupt is left: rtl8211f_suspend() sets INER to PME
alone. The interrupt is the magic-packet wake itself.
resume_device_irqs() re-enables the line and it fires before the MAC
resumes; the handler reads INSR (0x80, PME) over MDIO with the GMAC
clocks off.

So the mask is fine; the problem is that with mac_managed_pm phylib
does not postpone the interrupt until the PHY resumes. Patch: [1].

No new version of this patch: the hang is a phylib issue, fixed by
[1]. With [1] and the GMAC powered down as today: 20/20 suspends (an
instrumented build logged no MDIO access to the powered-down GMAC).
Without it the same setup hung within 1 to 7 cycles in 14 of 16 runs,
some on instrumented builds; one run passed 25 cycles. What remains is that
rk_gmac_powerdown() disables phy-supply while the PHY is the wakeup
source; on Helios64 that regulator is always-on, so I cannot test a
fix for it.

[1] https://lore.kernel.org/r/20261002043548.1302145-1-iav@iav.lv

--
Igor Velkov
