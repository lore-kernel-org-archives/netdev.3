Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794441352;
	b=w5OMBh0CX++1nUJaDOJ2ooaELDJGh9Nx+J8C++RA/LF5nHK0FKjMe1iT1RWqi9bHWWHG
	 xxqwWLz7Dwu22zjglt9vsRyctq0It4DbUWyH09TXpFYWDLDhy1bvAvqIYAuZQZA/89ugP
	 z7rvsAU937S7W+KDbz/lISlYfWbyLEYZUcfNuSt67bLMp+ut36cxuMo49iyk+xUsh3GMX
	 6k+oXQZOAymADbiwjeinRSpxX0A2p85XAR41/3HTzKy+tDsDaL8VcN5uIeTbfe091I1M+
	 EbcFsnqIBFBp0BDYYYbWzKx14xDmPwRA8OQdhdYRrn9bhUum2UfIqd0deSZR/okWYpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441352;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UhreHyS4L+Nan5+fJHgUbgRcOVCYQWIlXqVmK2Kq9Ys=;
	b=MEDLAg5Wusc8z4bALa3M1l5WeUy9L+BnoaoXDH7z2llZGJingfk7UbqC2tg/yrlG30Yx
	 VznRJ3AYSTHlnXrY2rIu0B9T2u2SxueF6AjrN+aTH9yHEOnER9NfVGDwEcUowWG7ctGXh
	 EdM2mGRYqNgU3TMvSpQzlAeNceLonjHm1+NK4m2O8e+8ZuWnigMtS28vjUS8BO0G5zvFa
	 oeEpFZ9Mb44xTKbnLNy7MyI/9j4v6XSNJZGyP+Ou/QdDnQ0p8wSNXZMweG6FlqwCLxZQF
	 VmZAiKhl8KqqVwiisAu3pcoF2ubPi1ane7fhCm6SNdTpoI74KWwaII0pD0x/1BVP0GA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=Pz3rDZ4L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B83A606A321;
	Wed, 11 Nov 2026 23:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B83A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=Pz3rDZ4L
ARC-Seal: i=1; a=rsa-sha256; t=1794441320; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ecw07BGZKig+hHYaxEa6FJ8SrhLr1BXunrg4zJDI5UR4ueQeMS3hIiKop851+dcvaLOreMwFczW1ybNocDfrAbgGa0UppQebo/2HgTGQQNjKdFaODnr5ajuqd1r+mPjBZKM2EHCOk9R8HKx4YrjozeMD46oeIkjKzF8UU39YhPI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1794441320; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UhreHyS4L+Nan5+fJHgUbgRcOVCYQWIlXqVmK2Kq9Ys=; 
	b=SMiDIpyirLHiON/tNSj/gCbV0b2xLaLKx7gOwVBNJl9tc2cfzPhccVLuzPDc2tGCrWCBfPD03+wd1BK4/Hc5J2/vr3qIMuq+/IItL1QN084q75cuTnCgwbrErMXYJv3aJeoXHBZBGFeQnM0p7EfP9SoO8EqfFLPPxELeaoXGhnE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=Pz3rDZ4LDKxJLtz/utET9e+wrgAen8mWzh8hsmY+JOwgy/ocPywIvgE7ahx534du8V8ZPrJaJWH71LuZD4HSn5p8ByhucFTbBm+8oyHsTEYZS8awUG7Nyc8MaFdl6bgeHzAJdvz46iDNcEg7aQySHRwDopewYoizdzUCMohabR8=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=UhreHyS4L+Nan5+fJHgUbgRcOVCYQWIlXqVmK2Kq9Ys=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794441318160361.78507131001663;
	Thu, 12 Nov 2026 00:55:18 +0100 (CET)
Date: Thu, 12 Nov 2026 01:55:16 +0200
From: Igor Velkov <iav@iav.lv>
To: netdev-bot+sinfo@kernel.org
Cc: Igor Velkov <iav@iav.lv>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Lukas Wunner <lukas@wunner.de>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Wei Fang <wei.fang@nxp.com>,
 Niklas =?utf-8?q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Paul Barker <paul@pbarker.dev>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Doug Berger <opendmb@gmail.com>,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Shenwei Wang <shenwei.wang@nxp.com>,
 Haoning Cheng <Haoning.CHENG@cn.bosch.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 0/4] net: phy: postpone PHY interrupts during sleep
 with MAC-managed PM
In-Reply-To: <179444109487.2168702.10631162542543162252@kernel.org>
References: <20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3@iav.lv>
 <179444109487.2168702.10631162542543162252@kernel.org>
Message-ID: <20261112-phylib-v5-sinfo-reply-1@iav.lv>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> - Whether the issue was actually triggered, or is only theoretical

Patch 4 fixes a hang seen on Helios64 (dwmac-rk, RTL8211F): in s2idle
without WoL the board hung or reset 10 of 10 times without the series.
The PHY IRQ thread stalls its CPU on an MDIO read while the GMAC clocks
are off, so that CPU never answers the NMI:

  watchdog: CPU0: Watchdog detected hard LOCKUP on cpu 1
  After 10 seconds, these CPUS still haven't responded to the NMI: 1

Patches 1-3 fix defects found by code inspection and Sashiko review;
they were not triggered.
