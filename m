Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084D35E958;
	Fri,  2 Oct 2026 04:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790915821; cv=pass; b=U9vEsyThENYrwx8qY3R6ItI7qSi1KYS2gNJfH8CQQasOC2pkv0+FHE/zhp6qbSySs+qGNQfNanU6AxWh+/zEve7XtMW9bId52zYrpqmeV08LwCt0B4VtIypj6b9TMNVAeY13c9Gr2m1MGLetYPRwbPZUtmBpvfmscNpdzWOmIk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790915821; c=relaxed/simple;
	bh=cfVnjHscJmEa7Qdr7GrLprmwVcyH921PwshXow6WstE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5oz39uuaxQPIHfRL7GQle6uW110p5VOTSXVG2trKz8AsOwwfIssjiiQQWvERhZrlvf+ZMJLkSFAzkZsDqdpBUq0N2k1MmHyzkFJeORHSyXEnDN6ue66UrwaGlxi7WlW3JkzCOcvuqHW33rpoSEI+8saeanqiTRbqzISTuVoufk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=DIBzDkH4; arc=pass smtp.client-ip=136.143.169.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="DIBzDkH4"
ARC-Seal: i=1; a=rsa-sha256; t=1790915788; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=j58SZN2BGBetlwoV9xWzBYgJ22BNptnCp47WPRT609KMnXmTjLNM3zCL+6TzgoeF2RsbIAyZTyqdTeynmnRGsJ5L9gLo7TWucOgoQytPmReVZZzK18u+3GcjeD3Uza7ioePbmhtEtqeILF1P1ZMEs/iomoqkyo6d2AccWCfjyXA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1790915788; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cfVnjHscJmEa7Qdr7GrLprmwVcyH921PwshXow6WstE=; 
	b=Xy9lrit0SDwYq9Us/yrGirWME1B1eJvEUJ8KB02yk8jjP5uNH6vQFOB0c6c+foypgZKVP/1DsllnZlF/DBUNQ7TXleQnXNPpFvPR5xq4TKVDdK62rUat55/Pe7w7IfY0vl/hqMQBET32SKqfe/hhf+sX7VfNRM4HoqM1NStYU6o=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790915788;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cfVnjHscJmEa7Qdr7GrLprmwVcyH921PwshXow6WstE=;
	b=DIBzDkH4e08TprVW/NNWb1RpUA8A4R1i3MlzhmrKBIzXRU5rw8eIyrxpQCPeSos+
	VHwEVPLvacn+81+DwJ4Ur0w+d0zC52Bdzd/zFbJZ/V+RijXJbxixnrUtBeW1RwqSvMn
	/low7PeYNgeyDIul4N9zmtJug6k56UTPkBkfRQJA=
Received: by smtp.zoho.eu with SMTPS id 1790915784611630.7486503118159;
	Fri, 2 Oct 2026 06:36:24 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: mask the MAC interrupt while resume resets the MAC
Date: Fri,  2 Oct 2026 07:36:23 +0300
Message-ID: <20261002043623.1304143-1-iav@iav.lv>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <47a5be82-c09f-486b-a7e3-35e6edb89ad6@lunn.ch>
References: <20260930-stmmac-irq-shut-v1-1-104d1a1dcb28@iav.lv> <47a5be82-c09f-486b-a7e3-35e6edb89ad6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 01, 2026 at 02:40:46PM +0200, Andrew Lunn wrote:
> For my understanding, it is the hardware reset which clears the mask,
> not software?
>
> If it is hardware, that is an odd hardware design.

Yes, the hardware: dwmac_dma_reset() sets SWR in DMA_BUS_MODE and the
MAC returns its registers to their reset values. On dwmac1000
GMAC_INT_MASK is a mask register, so its reset value 0 unmasks
everything; dwmac4 has an enable register (GMAC_INT_EN) instead.

A correction to the v1 text: no link change is needed. RGSMIIIS was
already pending before the reset (Helios64, SWR written from a test
script on the running board: int_status 0x1 under int_mask 0x1; after
it int_mask 0, DMA status 0x04000000). Nothing on the RGMII path reads
0xd8, which would clear it, so it stays pending from the first link
change on.

dwmac1000_core_init() rewrites the mask shortly after, from the same
resume thread. When that thread runs on the CPU that takes the MAC
interrupt, the storm starves it: with both on one CPU the storm hit
the first resume on Helios64, ROCK Pi 4A and ODROID-HC4; on different
CPUs it printed at most 3 messages per resume in 30 resumes.

v2 for net, with the description fixed and a Fixes tag:
https://lore.kernel.org/r/20261002043558.1302590-1-iav@iav.lv

--
Igor Velkov
