Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788153E31C;
	Tue, 13 Oct 2026 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791920998; cv=none; b=NEePLXoNPw6gel2hzUPd3ZtusnkaK4qT+AfAaqV90Nj9eZRa9f5oiSoa8Zfc2zsXlI8SwZZOntkc/yuV2VFzilIhuCFXsQ/ag/AVVLwwwvGZNCYZ8guK3ro2GtrGwjIPHSO7aoq0wrlhjSW0rj1oKsxJgeZ2mKQZTOwNQYB6s5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791920998; c=relaxed/simple;
	bh=lnPyQoJzvaAoTOXa9xWNkSRU6Wm8vtyKKtmMcFZ4Ogg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TY8PBOVIztHNcceXH3TqPiDmkaXheIQbQgbnhCgcvhBCuf6uBQXEZk3psHncXK57rCh5yDmvE5HeMvzWnsqWCQLc+S+L5qDZ+iCZTRo1jWSLxPGekim6NbJr9g5HyRN6RKfKjePSH6vUboE47/N8oz1mL8ypMRaZ5OnB6Migv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NiqQ/J/s; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NiqQ/J/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791920997; x=1823456997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lnPyQoJzvaAoTOXa9xWNkSRU6Wm8vtyKKtmMcFZ4Ogg=;
  b=NiqQ/J/si82jlF40MFcNVKoaFJB81cewBXsx4y70Z0VBAgFL1jiu61Nr
   FEwz/YtgcNcB+S+zsPQxXcCErNnlK8T8oK/SXWXEqOXYFOhzfrbqM/jWt
   K2oVB9BqwYV1GhEPqQ+Lgqu/4BHtaTjMtLrGHaYC6o51c9S5IMD6SeGAe
   LwioShNU8Gm2THUjXT9ZO+/fY+7pL0VyFHuhtbQn0lU5e1A25he4BvGV3
   3xKYbB16iXVn8tRK1XiDXFwAOUs7eSYGsI8X6vnKmQPZ8ZFNKWqR5HUyb
   PH72BQzoEvtbNIJNza27SAkvJIOQgPYl7uXhvwTzA4klP0izDoh5NhN70
   w==;
X-CSE-ConnectionGUID: OxT+NZxtShudPuS1PDMCtQ==
X-CSE-MsgGUID: Ry8g32UiRP2/6svSsJvEug==
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="232072001"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2026 12:49:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 13 Oct 2026 12:49:55 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 13 Oct 2026 12:49:53 -0700
Date: Tue, 13 Oct 2026 21:49:52 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: James Hilliard <james.hilliard1@gmail.com>
CC: <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net-next v2] net: stmmac: leave the datapath running for
 normal-size MTU changes
Message-ID: <20261013194952.i7saki3p7zc2f2hm@DEN-DL-M70577>
References: <20261013-stmmac-mtu-fastpath-v2-1-1e4ce8137689@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261013-stmmac-mtu-fastpath-v2-1-1e4ce8137689@gmail.com>

> When both MTUs are at most ETH_DATA_LEN, the receive buffer size and MAC
> receive limit do not change. Update the MTU without restarting the
> datapath.
> 
> This also avoids rebinding a live AF_XDP pool to a temporary RXQ. XDP
> rejects jumbo MTUs, so all supported XDP MTU changes take this path.
> Jumbo transitions still use the existing reopen path.
> 
> Found by source review while working on the stmmac MTU/resume recovery
> series. The fast path was tested on Allwinner H616 with sun8i EMAC1 and
> an AC300 PHY. The AF_XDP scenario was identified by inspection.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
