Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74042FF17A;
	Wed,  8 Apr 2026 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659750; cv=none; b=MmfygbNFAvYSEdRZeJKIGkrvKdRpHWuKUD92+DwrwOeA7bIt94ObdGSFBNWS2GaduuRU1aiHLcnjy/0lmJ00lxkUCEhUWXMIBedjNfIAbTwVCcgL0GIdm8lZBD0+yHekgClzlyQT+1PT/kqT8Lfbs4pigWBJBY369ezhRWVt/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659750; c=relaxed/simple;
	bh=HWXvN8GHQ20X37rm6jfLG8h90XV0b3KQULPu6QFK8cI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lglDGf3BfXg+3eS/sIxKDOJfBciBPFCKCVu48ro513rzWHuIyAOaKuImEJU1WIWNgbtZekDYCDUMRNcOHAUdYSaMU5GH/167kWhXJ9p89ibwDE5vQEap+hoyU/nW77KmJP3L4j1K57yMkIhFcLxlr1b/B8XRwnnUnnA+uLFztBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0ycMwWGf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0ycMwWGf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775659748; x=1807195748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HWXvN8GHQ20X37rm6jfLG8h90XV0b3KQULPu6QFK8cI=;
  b=0ycMwWGfWvzG/0CvlIqY3RWFn8W4LriwqFQjwVIPcPmrCUphbmkxL9Mx
   wlF/9DXWHxGqZPoIi6sdpR1c0IdiIdgRCt2LnalN+uky8xy9fgn6P9CgC
   GR/W2kojNHTHxwHcOsTC93YszTC06ApttqAk/Ibv/Gw/IsQobCMk6uk7I
   yRJFWNrsH9tU4Tr0ribdDEty1kxgd1XkkkdUNB/asVpVLDHTuCM/d0bJ8
   nDfjNDBkCruSn0zBxJrh4hFsFPGvMQuZjeSrXOYyiY6wILoSyXHq2iTal
   cJlKgUg1Twxv/tZJDJp104OSM5zA40V7IrRjO4Yoin1VoAX1G/aqil8Zx
   g==;
X-CSE-ConnectionGUID: AruKD6+tQsqaT8RpMrwPvQ==
X-CSE-MsgGUID: roJ+gIOPTsK65oifWmbqYg==
X-IronPort-AV: E=Sophos;i="6.23,167,1770620400"; 
   d="scan'208";a="56247623"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 07:49:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 8 Apr 2026 07:48:57 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Wed, 8 Apr 2026 07:48:57 -0700
Date: Wed, 8 Apr 2026 07:48:55 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: fix a return path in get_phy_c45_ids()
Message-ID: <adZq1++hD2mcTDum@bby-cbu-swbuild03.eng.microchip.com>
References: <20260408133145.1177417-1-charles.perry@microchip.com>
 <bcc4943d-137f-46d0-b5fd-385577c1259e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bcc4943d-137f-46d0-b5fd-385577c1259e@lunn.ch>

On Wed, Apr 08, 2026 at 03:48:22PM +0200, Andrew Lunn wrote:
> On Wed, Apr 08, 2026 at 06:31:44AM -0700, Charles Perry wrote:
> > The return value of phy_c45_probe_present() is store in "ret", not
> > "phy_reg", fix this. "phy_reg" always has a positive value if we reach
> > this return path (since it would have returned earlier otherwise), which
> > means that the original goal of the patch of not considering -ENODEV
> > fatal wasn't achieved.
> > 
> > Fixes: 17b447539408 ("net: phy: c45 scanning: Don't consider -ENODEV fatal")
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> 
> Thanks for fixing this.
> 
> The Subject line should be [PATCH net] since this is a Fix.

Ok, I'll resend this with the proper patch prefix.

Thanks,
Charles

> 
> Otherwise:
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew
