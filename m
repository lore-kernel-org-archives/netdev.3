Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16925228D;
	Mon, 12 Oct 2026 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791787394; cv=none; b=fpeFxZmNHbylLA149UKc45mdvN5FDIcaXEEdyUTMte1hm/LUfhkQ7udtyJouvuS9WOK6Krmpg7IHolPIluXRUpOZ9SIDDW0itaYY+LdLZyNJjl8VFqDhJGwp9TFScG/A/FgI14yO9A6oNiFwit2j4aRKcGfafgGBv2Oht71iN14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791787394; c=relaxed/simple;
	bh=VW9aul7d+3OS5C+EsSUO6S6eu6zJ5DtrvlTXDH3Z7yw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg1bgtTnpi9lF8mxY2CcAN34vK1FvnZUPhTHjUQKrjaE79zzQyXvVzfdJI/RQsW2hM665A0W+DFRhSLaMI1cfTJ7CNrA2DYpX+SGBksEr/MyYPcAvzhqnnTN+0DQ4b9tBS+kIvArmgxL5otrSiz9r10qaZQ39YXHaEyaJyS+cS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EFHJEl3/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EFHJEl3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791787393; x=1823323393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VW9aul7d+3OS5C+EsSUO6S6eu6zJ5DtrvlTXDH3Z7yw=;
  b=EFHJEl3/fRd5DAfN3HvB+AtDV6CmIb66ncvkwW3pdU4vzahQ37ZzdiOV
   WL7I6EL1TktXA6VUBZwDPH/IIzfaDjtDfz5nLXB5Q3qP7m+gTky1O3N5U
   8XDGxxGDDpp6/yJV1/2n9sryqrZTIcimB2BkC64IPnJgvRI07hhJ2gwM2
   BnD5wFeD87JMtalf4yUkR1IGtq0wbPtfw5SOMVZNpmivyqlCCfC4ePDZB
   rYlPuDkPl/R4MwccyB8HkvagTB2afd6epKoWK44LQQf1xkh/J/ABD+0c1
   FZIcpYqSQyIw/LtFNcLYBybYX8k4FORIaCTIM7f4ilMyrg6fV+meYE9VJ
   w==;
X-CSE-ConnectionGUID: AWIBbI3HQDeC+sEuQX/qiQ==
X-CSE-MsgGUID: 81wLTtfMTa+vYQgxANf12g==
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="63943851"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 23:43:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Sun, 11 Oct 2026 23:43:06 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 11 Oct 2026 23:43:03 -0700
Date: Mon, 12 Oct 2026 08:43:00 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?=
	<rafal@milecki.pl>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jon Mason
	<jon.mason@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Joey Zhong
	<zhongx@broadcom.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: bgmac: enable interrupts only after NAPI is
 ready
Message-ID: <20261012064300.qa7e7yvwem5mxfz2@DEN-DL-M70577>
References: <20261010070011.60403-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261010070011.60403-1-rosenp@gmail.com>

> bgmac_open() calls bgmac_chip_init(), which unmasks the interrupts and
> enables the MAC receiver, before request_irq() and napi_enable().
> bgmac_enet_resume() also enables NAPI only after bgmac_chip_init().
> 
> When frames arrive in that window, the first RX interrupt masks all
> interrupts in bgmac_interrupt() and calls napi_schedule() on a NAPI
> instance that is still disabled, so nothing is scheduled. Nothing
> unmasks the interrupts again, the RX ring fills up and the interface
> stays deaf until it is brought down and up without traffic.
> 
> On an Asus RT-N16 (BCM4716) a single "ip link set eth0 down/up" while
> a host sends UDP to the router left INT_MASK at 0, INT_STATUS with RX
> pending and the RX DMA idle on a full ring, with the RX packet and
> interrupt counters no longer moving. With this change, 10 of 10 such
> cycles recovered on their own.
> 
> Request the IRQ and enable NAPI before the chip is initialized.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

