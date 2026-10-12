Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979D2385D64;
	Mon, 12 Oct 2026 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813072; cv=none; b=bmExEnhnZZg4hLi2mdVvtWqgoN6uSBpPTiUESiiGne4L3sLVQ+Ta4eEUevCBlny4IWEK49n6GKPtLBg9JJ6LjwsESjgySH8s5wQvsZHAjPxZS9Xoa3ggzB/IWzfCdpWuic0F6LQ/3k4HggA+BQbaZnFd3P6c4A9jlXyKjw5QrA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813072; c=relaxed/simple;
	bh=wioaFwY7xuRuoR5xR/3foYooAYk/dKFJiHC1NDrxkjo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW97NalftfYOaaTKlK6fAqAH/46LOxQkV3Ia3hKS6u6YOYqq5VqXHmf3pSwhXqUt964MY7dBLuRQAGuq9CVcCvWmw49vutcV90Tb6OdPBf+rh2Sx4lvYRdw3sHSuVkj2TuOiapHx2cRs2i5KfdlAU1ElyL9pD9UruhoVwiQ8eIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aFDbhmSt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aFDbhmSt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791813072; x=1823349072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wioaFwY7xuRuoR5xR/3foYooAYk/dKFJiHC1NDrxkjo=;
  b=aFDbhmSthh7p4T+ewtnVIgZm7ZGSmNggmer+IGs8RsR8UCZ6XknjYyM6
   rN5K+wy48KE3SYzE3DTFSHj8XbZZGiRRcth69foX2s/ozBOnEQb77Y1ht
   M1jOnoNZQWQmvNEeq7F0KpUk/gjsMneZ4+9LiTQI+JQnj+QmbWTfL7/ns
   ZOMaIhTaH9Qs662gPDhaI8IGUQ76E4Am2cYaDWmBVKM7/76d+fLvDrAjo
   hKGPZWiO5Dopc8mHGc6kfiynDiMWLvgxuGLBVwi02t81/m8gXfNvpJZ+F
   W249HDuZ37B5DdtSbPq3EH7HDH7y9CNt7GdpQ/uAbZmLsaKwowYYV/0q9
   A==;
X-CSE-ConnectionGUID: XjH6BadORmyCy/Lnbmh7Hw==
X-CSE-MsgGUID: Aac2ORbtQzuFJC2QvNC/RQ==
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="64904604"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 06:51:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 12 Oct 2026 06:51:03 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 12 Oct 2026 06:51:01 -0700
Date: Mon, 12 Oct 2026 15:51:00 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
CC: <netdev@vger.kernel.org>, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
	<horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>, open list
	<linux-kernel@vger.kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net v2 0/6] net: bcmasp: Collection of fixes
Message-ID: <20261012135100.n5fsyqsvwieq2q7y@DEN-DL-M70577.microsemi.net>
References: <20261008210621.1374785-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261008210621.1374785-1-florian.fainelli@broadcom.com>

Hi Florian,

> This patch series is a collection of bug fixes accumulated during a LLM
> coding session. Thanks to Justin for the internal review and helping
> with the last patch.
> 
> Changes in v2:
> 
> - address Sashiko's feedback and correct the commit messages and code
>   accordingly
> - add Nicolai's R-b tag where collected
> 
> Florian Fainelli (6):
>   net: bcmasp: fix mib counters struct alignment with ethtool stats
>   net: bcmasp: unmap previous DMA mappings on TX map failure
>   net: bcmasp: validate minimum RX packet size in bcmasp_rx_poll()
>   net: bcmasp: fix OF node reference leak for phy_dn
>   net: bcmasp: account for offload header in TX short packet padding

I tried to apply the series, but it seems like this particular patch got lost. As
a consequence, it cant be applied with e.g. b4 shazam, and PW did not run the
sashiko check.

>   net: bcmasp: fix network filter lookup and wake filter pair allocation
> 
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 121 ++++++++++--------
>  drivers/net/ethernet/broadcom/asp2/bcmasp.h   |   4 -
>  .../net/ethernet/broadcom/asp2/bcmasp_intf.c  |  32 ++++-
>  3 files changed, 95 insertions(+), 62 deletions(-)
> 
> -- 
> 2.34.1
>

/Daniel
