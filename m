Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB39457E5F;
	Fri, 16 Oct 2026 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792153625; cv=none; b=ZhghMugK9l4z77HStKcobD1DnSnLXiWM3L1m5XUDz8n0evLwY58eSqr9ExP8l87feXgd3bIUZaanT+2b8kj0B6n0bW/KXza2cjHp7kBEZBO0bH0YuuO26OjCw0kYQMBEd8ENjf1CVZOiyLlNqLr8q2CzR95rHNry/lV85vaZTZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792153625; c=relaxed/simple;
	bh=MmGvErraHmGXymUgElckL0Yil5M9Kitm7TIQpXtyBTU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqWTTGXn6ZbCYfCTXjzRjmYYJChEzC4Q6mu2PZyHIq0NRN8a1wpsRjvo9WxUzRXfH/2w3wWPpi6EcJZ8IdoG/4oR7JkFKy4yYxV3ZWrzhXN+Wuy0x8+ZHrJ1GFrlZ7CP024C+kdlm90sqafTyZ7sLLMX5VS4x7efyFSaRpU4Jh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Wnp1Q22P; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Wnp1Q22P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792153624; x=1823689624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MmGvErraHmGXymUgElckL0Yil5M9Kitm7TIQpXtyBTU=;
  b=Wnp1Q22Pws3WaLj8UsXckRdR7aVoCa5Ywuwv0OdoQm6Ac07BzBljOmlq
   eBOZNREQB4+xsCbouzavEkjRObp4436CRrJjqkBRihdXgfpICik/DqR8y
   ++HawzcReQ1YwEaz4j3QSw5oOlF0XR5K+S9KEwlMAk51wsKap1YgmkmsY
   fkosLpnYhZOhk+iW8tI2D4x6P2DnLgOmWvjJxiehNN8Bsy2EpClXucCi8
   FxMb5iNHZ3dBzyM7+yWeC7j3QhATNq8I0NZlu/g7p8NSWw41tnQPh8OyA
   +9gitf+IyB658CEGanuEr+HMMxjNwJR8kh2uL6sHTgLjhqts7SzbrnKdV
   w==;
X-CSE-ConnectionGUID: I0R7QpXoSLeudXur/QpfVA==
X-CSE-MsgGUID: NPZwkujlShm4Mhi8gM3t+w==
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="296564488"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2026 05:27:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 16 Oct 2026 05:27:03 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 16 Oct 2026 05:27:00 -0700
Date: Fri, 16 Oct 2026 14:26:59 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Jijie Shao <shaojijie@huawei.com>
CC: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <shenjian15@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<yangshuaisong@h-partners.com>, <ningwei15@huawei.com>,
	<shiyongbang@huawei.com>, <fengzheng6@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: hibmcge: set netdev_ops before hbg_init() to
 fix NULL pointer dereference
Message-ID: <20261016122659.3nyou6kycfu3m74x@DEN-DL-M70577>
References: <20261016110421.2288670-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261016110421.2288670-1-shaojijie@huawei.com>

> The driver assigns netdev_ops after hbg_init(), but hbg_init() calls
> hbg_mdio_init() -> hbg_phy_connect() -> phy_connect_direct() ->
> phy_attach_direct() -> phy_link_topo_add_phy(), which invokes
> netdev_need_ops_lock(). With CONFIG_NET_SHAPER enabled, this function
> dereferences dev->netdev_ops->net_shaper_ops. Since netdev_ops is still
> NULL at this point, a NULL pointer dereference occurs.
> 
> Move the netdev_ops assignment before hbg_init() so that
> netdev_need_ops_lock() can safely access netdev_ops during PHY
> attachment.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
