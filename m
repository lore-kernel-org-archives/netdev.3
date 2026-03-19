Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDCE3B19DB;
	Thu, 19 Mar 2026 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773956350; cv=none; b=JAxtaMBDZIB6k7VY0rCWQ8dcAw226hBJBl/MhuZSAn/Np9PzFxjDZ8uzoa1++l3uywNuDrqmjxvyxOIdxHtRN3ZrnMO36QDLwUhqVbRx/51ck1IGDuASrI4UgoLcwR19k1F6myAGw+p2ZWmT0FWDxYPr1wa9od5Xk9FggEZYm18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773956350; c=relaxed/simple;
	bh=VBkAAsTwbhuITRRUENQb3hb+oY6xnELFcZfpCbzNHe8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0ao2M3U2/iCHX+phsTWlLU2RUmC+QfSM5TpMoP2IAQF/ad4wj0fFvVUAar4YgUgqoNvYu0CoULkRoz+DvYGHosj+jOzmTZFQKbnOdYVwA1h88PriUL994dWwAZrS+xxsAFbIczONo3P/C3YfgdlRaB9SONePZWI3/5gd/Yp1yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yibeny0u; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yibeny0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773956349; x=1805492349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VBkAAsTwbhuITRRUENQb3hb+oY6xnELFcZfpCbzNHe8=;
  b=yibeny0u2TGwmSZQPrnEaaMF2d5g/ImSE03/taTqGYnqaB+uwkpgXpvs
   mAVOoVZQKb+0CxQcfm+nBpijmcPUWJFeqDWlt5E/G0h6yky0EWkExQnTH
   SsIDohB2dTtDXpP+Pndqj/1CptcKjlidhGCpUHtapqU2t1f+hkq6TkyaU
   Hp+fSPoPL5Ule/6KEsECfSvf7ts2cHmX3G11lMP4l+6XCNCDaSjZ0gbEf
   Z/yIcZRhW+/qdDmG2T89gnw1IzHmRZW8K3Lhh5eQjsKNnnaAvuMASruWh
   BUNUpL1avLURNDZX5QF3mzX5AdG2WZnjYwutZu8bxCkte6FVO6sjqYPaH
   w==;
X-CSE-ConnectionGUID: 636hfaD1Q8yRWTBhR6ZOXA==
X-CSE-MsgGUID: mghhuflPTCa1A3FeMWwUxg==
X-IronPort-AV: E=Sophos;i="6.23,130,1770620400"; 
   d="scan'208";a="222199135"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 14:39:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 19 Mar 2026 14:38:49 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 19 Mar 2026 14:38:48 -0700
Date: Thu, 19 Mar 2026 14:38:46 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: mdio: add a driver for PIC64-HPSC/HX
 MDIO controller
Message-ID: <abxs5isE0pAPQL9t@bby-cbu-swbuild03.eng.microchip.com>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-3-charles.perry@microchip.com>
 <6dc9a358-4140-457f-bdfb-b4fb22aaf88e@lunn.ch>
 <abxN9aGnCYA6s13u@bby-cbu-swbuild03.eng.microchip.com>
 <10f97968-ddb7-4a96-b08e-d4355cf82a79@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <10f97968-ddb7-4a96-b08e-d4355cf82a79@lunn.ch>

On Thu, Mar 19, 2026 at 08:53:01PM +0100, Andrew Lunn wrote:
> > My idea is that if someone wants to use whatever is the hardware default
> > or what was set by the bootloader, they have an option to do so. For that
> > reason, I made the clock and the clock-frequency optional. This is
> > something I can do without if you think it will homogenize better with new
> > drivers.
> > 
> > Now I just realized that I can achieve this by just making the
> > clock-frequency optional and not the clock.
> 
> It gets complicated pretty quickly, if you leave things open.
> 
> 802.3 sets a maximum of 2.5Mhz. When this driver takes over the
> hardware, and there is no hint from device tree what frequency to use,
> but the hardware is configured to 50Mhz, what should it do? Trust the
> bootloader? Or assume the bootloader or something else has messed it
> up? Same goes for 1KHz?
> 
> Is the hardware default documented in the datasheet? Does it default
> to 2.5Mhz?

No, it defaults to something rather slow: 610 KHz (assuming the input clock
is 156.25MHz, divides by 256)

> 
> >  - mdio-airoha.c: use 2.5MHz if not specified
> 
> I personally would do this. This keeps you in line with 802.3. Anybody
> wanting to do anything else then uses clock-frequency, so the
> intention is clearly documented.

Ok, sounds good, I'll use this policy.

Thanks,
Charles

