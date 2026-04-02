Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF54259CBD;
	Thu,  2 Apr 2026 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152282; cv=none; b=YQNSow11m0lJEAvBY13vU+wkm/57mtOi5UXn9OjlgnI0dpMGoWIwCLaZrSykkaD9CoGiCT5qKICg3QdvPj6hKeA7YRwC4fRLklHkeQo6COJB6i/PktJSj3nlJ6oyRxZWTHceTASU7SAO4MBQocI9dQxu1l8wHDEaMShOBL22KRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152282; c=relaxed/simple;
	bh=+eZJ72KKEz4oSP9Rvq379h1VmWRnkns+bvCWKc56AwM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpyxNNeNXmzU3xvYgxBHyjNhBRjYS3g7aZKeWy0r/LYVcY2wEJ/PcYCVhEbpAWIfmatk9aWOdmKfTgy7q+6EfuafGihrrtgzHiVe9DSEMzCg3KRkWO84gIEpiEI46uFhthomwCjWCTLsRoJw9jTRdXhbZOKHqWDmy3wnlCd4Xok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vjwP+VH5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vjwP+VH5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775152281; x=1806688281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+eZJ72KKEz4oSP9Rvq379h1VmWRnkns+bvCWKc56AwM=;
  b=vjwP+VH5PQCUpz2CLCxkq2MV9xqyPbeI18YUfFSiG9mMSy+I4+FMvpOt
   zX7HG1zYeA2d++Iuv4+G7mKRCBM5JkVGkoxEJA1picE6ST0MYFk+nhe3+
   Hjfi3SdtUK+QGgldtdL/V4AuAPXHRuta7i/Wus1Otz15F92XMoec2S5rk
   jKpN3axf5LubFEhm1mEX41OH1G11NHy+UUsQx4opuhppFTbs7DJEeL280
   KGzQuecv/ldrPQ0SLh0fsEMNdMCivXlARPN7ZGqS1pH1nLqpYwu4I5KpY
   uftAf5Bp+ZRHc2Yxn+h3aWs8BQ3TaPldlTlkSY2VhOqaUsT9VPWOHPGET
   Q==;
X-CSE-ConnectionGUID: 63LuaJA/RaCcuYiEkLrjSw==
X-CSE-MsgGUID: CyF56s5yQKuQjSluyuOduA==
X-IronPort-AV: E=Sophos;i="6.23,156,1770620400"; 
   d="scan'208";a="286977618"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2026 10:51:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 2 Apr 2026 10:51:09 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 2 Apr 2026 10:51:09 -0700
Date: Thu, 2 Apr 2026 10:51:07 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] net: phy: add a PHY write barrier when
 disabling interrupts
Message-ID: <ac6siwiXWOaw/hfg@bby-cbu-swbuild03.eng.microchip.com>
References: <20260402131229.319599-1-charles.perry@microchip.com>
 <20260402131229.319599-4-charles.perry@microchip.com>
 <6bb3aec4-1635-4287-b7ce-f15b693563ea@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6bb3aec4-1635-4287-b7ce-f15b693563ea@lunn.ch>

On Thu, Apr 02, 2026 at 03:31:52PM +0200, Andrew Lunn wrote:
> > +static int phy_write_barrier(struct phy_device *phydev)
> > +{
> > +	int err;
> > +
> > +	err = phy_read(phydev, MII_PHYSID1);
> > +	if (err < 0)
> > +		return err;
> 
> There are a small number of MDIO busses which don't implement C22,
> only C45. You are likely to get -EIO or maybe ENODEV, -EOPNOTSUPP,
> -EINVAL for such a read. Returning the error than makes
> phy_disable_interrupts() fail, etc.

Ok, I didn't know about this. Do you think there's any merit in handling
the case where phydev->mdio.bus->read is NULL and doing a C45 access in
that case?

> 
> This is why i suggested throwing away the return value.

Ok

Thanks,
Charles

> 
> Maybe call phydev_info() if there is an error, but i suggest making
> this a void function.
> 
>     Andrew
> 
> ---
> pw-bot: cr
