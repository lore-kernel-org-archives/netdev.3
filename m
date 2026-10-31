Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793434510;
	b=VnXDvJ7IhA2Wf2fDMhojU0l+EXp1XbuYkT3J9sd/Uoi+dn7zi/iBcQ3UtWEvpsaqVyjB
	 84WQwdNrAGOSc051MOcu+1Ztx90EaP68jALfE7KrVNCl4S8InZJN5WyJgRqFiJEwGJTl1
	 spcx8JXq7MBgeQe9sgkwil10VPevEFkYwiZHr6jO5m7Lx71aOOpYi0GOeauPzowXKIaoB
	 BzulkU6OugMs2iV9N4ee34lFdQa+mgoBt4lwElK2qA7FqjNFNXj71HmJfAWnIBq5rujTG
	 yrLjNB1uFcHL13dXobw5JsdTcsC6QHVBVLkipkfCU8s29NqrywH33EqZU3uCXTGXudQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793434510;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uT6v4Xn0ekRQ/dccyYyJtT8xDye8PelpFDuIVEmaRz0=;
	b=Q7OAC0HGBIcP+f2mEW43KUTuSZNTun8elJ/k+PDTK3lRN3myZh4cfwUhIgpB5/tiF3Pe
	 HxS787snWcbbMLzjukzq40QaipvrnkHRXt9wfv9aILtwuWPHPf7xX2LSx0dSxqJAjYdxG
	 JH1HMgm7O6hEA6M/oxEqZSmnzTtdoJKlp4S48CngylPDqNWAIboEEQATSVlcznJ1Cd7/O
	 akcpjCpGcVsichi0HQU20frfufRO/X39yQlq9lQgNHU/VUf4FlRjVBekg239rmpGo+iv0
	 QZjbpoGT9YbWg53qPlbsGELX/90XGtfJOflUqQpsls3WBzQXaSvD1O4P1JXXBzdj1vA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=KMvX8Nkp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50756606A31C;
	Sat, 31 Oct 2026 08:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50756606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=KMvX8Nkp
ARC-Seal: i=1; a=rsa-sha256; t=1793434452; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Yify8tmgdYSbVopsJlydWtpeI2UXkOOfXuiazwE1AvrvVzXAFnRZj6gTSwZ5cUlnyC4GRDcnZ2iKJF53NHeN+1pDWW/oHjNk6XGJ9BRarminH1Haz/dYyl9rVvtGCUTvdHfMAxcbGVMse9Bm5G+dXjcc+HvMpHI84qEP+stJFMc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793434452; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uT6v4Xn0ekRQ/dccyYyJtT8xDye8PelpFDuIVEmaRz0=; 
	b=eDaI+n91ZLzQa3uHrnFlgx3omj5Ba1M6q4Tk9Ai5/y4nl+Wr7TzscOOvcfT6Q/RlKamKhCv1ZlxIs7kn+ZXWVmEDiwgXYNuOXU0FyaX+V53iyFg0b87Ob/4YWHODTBFTqlaP6jkpT+RQ1QycGiimdvo3612WG/HBu+56l9Dq5vQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=KMvX8NkpogJBvnAgF++pM8jAAuNhJUUBIYMvuBPLaVSzjLK2Kgbnk4WvjXszmUrbl7SFAU4ytlQjw9UzxncCFIoUOAUjZk0G2xETrbwZe/FkqTpE1pPw1rqbW3wRDTs6Z6AUjil6+wGc4xXUQ8lD1iyASjW4vsTG2v42onGy004=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=uT6v4Xn0ekRQ/dccyYyJtT8xDye8PelpFDuIVEmaRz0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793434451622317.1807577626872;
	Sat, 31 Oct 2026 09:14:11 +0100 (CET)
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
 Shenwei Wang <shenwei.wang@nxp.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/5] net: phy: postpone PHY interrupts during sleep
 with MAC-managed PM
Date: Sat, 31 Oct 2026 08:13:51 +0000
Message-ID: <179343443172.2895107.13605713175307417010.phylib-v4-sinfo@iav.lv>
In-Reply-To: <179343389984.3286.809839136574794731@kernel.org>
References: <20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4@iav.lv>
 <179343389984.3286.809839136574794731@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

> - Whether the issue was actually triggered, or is only theoretical

Patch 5 fixes a hang seen on Helios64 (dwmac-rk, RTL8211F): in s2idle
without WoL the board hung or reset 10 of 10 times without the series.
The PHY IRQ thread stalls its CPU on an MDIO read while the GMAC clocks
are off, so that CPU never answers the NMI:

  watchdog: CPU0: Watchdog detected hard LOCKUP on cpu 1
  After 10 seconds, these CPUS still haven't responded to the NMI: 1

Patches 1-4 fix defects found by code inspection and Sashiko review;
they were not triggered.
