Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793560301;
	b=v5lrOXLE4iy2wdGGMIM+AQJuKi/0uEm58q2EkPOcVH/2tTv5KhfZnDMYbXwc6TWIi2Nf
	 UiMSSEJymYBLx4f31TUL9Qn42H+jY1sbtXy2TPR98NXK1bEncG1eGPFS0S7xaf7jbQR+j
	 BHLCjsLA+X0NesqeaoKZ32pbJy2elAwU8ZU86mpAYJt7araXav3wqUUGOIX/OZgTltgFM
	 hN6DvsT0Od9aedX1zDf8SBb2cg3elU6DU6l55l5ABkW67edP1h1PGTkbv/CVkz6v9QyOB
	 NB0UwsEBk0bmMaI/aDuilIhlsfj0DhI8E3vZcYMW6LAK1/+rQyttHGDW+dx2HYVznpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560301;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mPcWOwuHmd2vb2lc/1veBqXCg/9uHVaMceIoosx5SG8=;
	b=HjfIxqbsWE6v6aFd/qDitqwVZFeZpadACNwLVCvGbtDBolFYqsthBVT6PgjEto0K2v6H
	 VyIzm4XEELfFFdJfKLnLfts8/Yzbd+HgsSCpRSPFc33ppn9sA3GC8uHWDarLvYjSAR2M3
	 b0uSoAVdkFjKk02XggmUitMuvMBY/BLUlRvboBZKEaqxiApitU+YwpVtlnYhH/094dqdU
	 LuyFKnpJaf3A0QgpmLDfS/xf0eJvci8h9n8jN/RSsSAEcXQGO8r9Dyl9le2Rzk05Vlssm
	 m1fhX2xfMuhMDDOKboGtuSW5RbSpQ15pDRjn85uYQJYgONAhMRf5d/3okxOy/XPnFJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=VxAMb9Yk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111D606A324;
	Sun,  1 Nov 2026 19:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E111D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=VxAMb9Yk
ARC-Seal: i=1; a=rsa-sha256; t=1793560235; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=iRBtL5ZI127nRPDqqbTqjRcbsDS30mPeVHezXgaqcjUFMkQDqoK8sp0ijTBCmafp/flXvwvfocEKXG6gqj9RTAhrFG7X6e6PqPbMiPY+ZQKGq+3Uy6mFnYxWh9c6qf3xJwGMrnom/aDUk+LAwkjhpyQjzaWduNH2LiXxDDtZj1M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793560235; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mPcWOwuHmd2vb2lc/1veBqXCg/9uHVaMceIoosx5SG8=; 
	b=V9p49xnybzD+e3S8j1KhS/QP1iZM8Qkb2xIwizMus9rJS4YRbKeP/jFbaZwVwRaiMzJaLTSKo6lT+f5izvfYny9BInMU6MJOsy2DIsWxpJxsnMgz1isgcTzmVyA5qte7msiZOtUB8Lj75msKPXTYRmW4veWRqcIbsM0jlbIomS4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=VxAMb9YkFS0HWxIAL9v0QH3eV836oDrQf3tt3baPOt8693zNFZPNp1MlPM0j8dZAgVWcHVzmB2Eor+Q691r/iKGybzsFXRXVcPnGSLheFezn/xMsRaZHqLXZEDyQIiceVoSNrTionsswenYr487X/bcDE33WAf8HieHx4WNrtPQ=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=mPcWOwuHmd2vb2lc/1veBqXCg/9uHVaMceIoosx5SG8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793560234157386.45816168150634;
	Sun, 1 Nov 2026 20:10:34 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: netdev-bot+sashiko@kernel.org
Cc: iav@iav.lv, andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com, lukas@wunner.de, rafael.j.wysocki@intel.com, wei.fang@nxp.com, niklas.soderlund@ragnatech.se, paul@pbarker.dev, florian.fainelli@broadcom.com, opendmb@gmail.com, Thangaraj.S@microchip.com, shenwei.wang@nxp.com, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 5/5] net: phy: postpone PHY interrupts during sleep with MAC-managed PM
Date: Sun, 01 Nov 2026 21:09:52 +0200
Message-ID: <179356019298.3385307.17700170309730679223@iav.lv>
In-Reply-To: <179352219781.3131.16504721138901563596@kernel.org>
References: <20261031-b4-phylib-mac-pm-irq-v3-v4-5-5ba23b3ff9a4@iav.lv> <179352219781.3131.16504721138901563596@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Path 1 is real for a PHY that keeps its link interrupt enabled while
armed for WoL. phylink_suspend() calls phylink_stop() before
phylink_speed_down(), so the driver's suspend runs first. RTL8211F and
AN8801R mask the link interrupt there; on Helios64 (stmmac + RTL8211F,
wakeup-source) WoL suspend passed 4/4, though I did not log the link
speed. Of the wakeup-capable PHYs in drivers/net/phy, BCM54210E leaves
it enabled. Before this series, the link-up after the downshift could
arrive after stmmac gated its clocks, and phy_interrupt() would read the
PHY over a dead MDIO bus: the hang this series fixes. An aborted suspend
is the safer failure.

Path 2: phy_stop() with wol_enabled leaves the copper link up
(rtl821x_suspend() skips genphy_suspend()), so the MAC causes no link
interrupt. Counting netdev->ethtool->wol_enabled as a system wakeup is
what phy_interrupt() already does for PHYs without mac_managed_pm.
