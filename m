Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6B376494;
	Sat, 10 Oct 2026 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791646357; cv=none; b=e41GttX/fFvo07lv9Pxe2BX5wndbSQzNex7JLTD05tiOW8a91W6q/0O/BfJohQt4iPTtSB+s8o3RzC+SWtxDF5eH/WbHpuWkMYgRHNgqw1XZRGKZLjoyXa4Zv/nbzoLCne9LshM1Ab88pcu8iZLDnBYk8gniZNegkhqDb7IxElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791646357; c=relaxed/simple;
	bh=Fjaqr9z0/4IpSNXim/KBiOLW344lFa8Vy7SRK6DoHSs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHMBEkwY7VXe8M47tU37suo7oZfUklpfele4V/CbF94Dv/Vu8acEhYutJ9kIK+XmuS/8XL4uwIKnKGMSYk0/8WQRXX0l9czj5qUXV90Qm8n0WJd/ktiBJnKniW3xGJj9XcmHwUW5W8TZEe+LlToBuj/MnQ39ljldXYrHbVCu8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RlmuzxyL; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RlmuzxyL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791646361; x=1823182361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fjaqr9z0/4IpSNXim/KBiOLW344lFa8Vy7SRK6DoHSs=;
  b=RlmuzxyL2nCppDxlQo3UW+Ru1hTSHfp5Wvd8erqxxcvZsvidMzz1sBig
   j+4aqaYac1dwHBqbZPV+98hJ9k3hEr4GTnKIzrTpP8+FxjAy6fb+W7BAc
   mTNhOdOjosP2+AwG5JyuVn854ie3KsZTocVqgb2z1pMXIqjbAvfe1jcbF
   dhBg16EuIQjOJTVj6gf/0bllcQdtE0NN4htKUn9gctCDXVjLenqHNfi0p
   MSs61eMsM+HmnIx+QZjkeKs3ygwwZluy5gto+xs6zgtK3QiIr8/6r1Erx
   YETMeuQ5y97Um4vASfAc0d6PzSW0WyBuqnrrn+W2IcWk2ICeZCIx62D55
   g==;
X-CSE-ConnectionGUID: /NIkIOrrTamOMdyv8TAVmg==
X-CSE-MsgGUID: ZadMASfBQ8GQ2g2JEM72EA==
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="63905767"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 08:32:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Sat, 10 Oct 2026 08:32:28 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sat, 10 Oct 2026 08:32:25 -0700
Date: Sat, 10 Oct 2026 17:32:25 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Igor Velkov <iav@iav.lv>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4] net: stmmac: dwmac1000: clear the RGMII status
 interrupt
Message-ID: <20261010153225.s3f5jgrzgytyvnei@DEN-DL-M70577>
References: <20261009201709.1917585-1-iav@iav.lv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261009201709.1917585-1-iav@iav.lv>

> Since commit 2e2c878a3141 ("net: stmmac: remove SGMII/RGMII/SMII
> interrupt handling") nothing on the RGMII path reads GMAC_RGSMIIIS, so
> RGSMIIIS stays pending behind GMAC_INT_MASK from the first link change
> on. stmmac_resume() resets the MAC in stmmac_hw_setup(); the reset sets
> GMAC_INT_MASK to 0 until dwmac1000_core_init() writes the mask again,
> and the pending status storms the line:
> 
>   dwmac_dma_interrupt: unexpected status 04000000
> 
> A register dump at the first message on ODROID-HC4 showed it:
> 
>   core int_status 00000001 int_mask 00000000 pmt 00000000 rgsmiiis 0000000d
> 
> When the resume thread runs on the CPU that takes the MAC interrupt,
> the storm starves it: a soft lockup, then a watchdog reset or a hang.
> 
> Read GMAC_RGSMIIIS in dwmac1000_irq_status() when the status is not
> masked, as the driver did before 2e2c878a3141; the read clears it.
> 
> Wake-on-LAN resume from s2idle with the resume thread and the MAC
> interrupt on one CPU: Helios64 (dwmac-rk), 7.3-rc6, soft-locked in 3 of
> 3 resumes without a fix and in 0 of 10 with this patch; it ran with an
> out-of-tree dwmac-rk change that keeps the GMAC powered across suspend.
> ODROID-HC4 (dwmac-meson8b): 0 of 10 with this patch, 2 of 2 without a
> fix on a 7.3-rc5 build. irq_rgmii_n went up by one per resume.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
