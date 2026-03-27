Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F1A21B9DA;
	Fri, 27 Mar 2026 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614910; cv=none; b=h8v35rQoRL4L/wNplmrOBC/wS5aKo3DPc2xVb5dvp7QoI/vdXs6cszqT3N36xNKxLgJxPlEvdaKi+pKUqyhgCscBLAzGp8mlK9hHKUfGD+5FYtMvow8O/WnjTwJja+sEhcIz8H/wyQFt6C68/qbqJ3TaNTFyOCfTgexhT1B1rbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614910; c=relaxed/simple;
	bh=X3kyuRjg7v+xLbz6US3MZDcLvz17mxsXqmt5e/m8kbM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPI+Mp3JT8+5fn9ieJ482/NqduiGzUWFHt+J7AZtdyrOr1klP2//3NR+F8tlxGYldwzqK/xIWRUAyZXFEz2cm+r3d86iOGrz/6PTLg2edziqtzD/GOmATGah7oJ2cQslSEce1aQqGOuZZSM+V8FHVxRQYcL7DFAYztGg7lP87nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Yu4TmWo1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Yu4TmWo1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774614908; x=1806150908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X3kyuRjg7v+xLbz6US3MZDcLvz17mxsXqmt5e/m8kbM=;
  b=Yu4TmWo1oxcMsMTUAk/K9+XptmbxvWAr+VVv8A2As1/b1JPXFSNseJXq
   rdD3S+Ojj9FHl0fu82CSVvIpMksYxwyrr7bs3IYYbcVnY9tM4XsAyzJyV
   OTAglF62XUBd/vFfS/YQtquJeEDju3oZHF4Paz7M8+zwvG7qXSNKlIMX5
   l8v41/nJG1y+iPovCMKgcaJhdCbiujAU259Tn7V48RssqMVOERZFzeC+l
   qVVL65LJSu26auoXCxzIpK9fdOianQsNKHlhzwjfbubOEsce4cJSNwUNz
   1pxK/08cYCVnV66xGvaeWLthdQWGybjT9ICLUpJ4QnUFTA4OAidsX8IWG
   Q==;
X-CSE-ConnectionGUID: tFGc9Y2OSSqwHrCtZH+5dg==
X-CSE-MsgGUID: bEduLCXNQ2CHYc669s0JdA==
X-IronPort-AV: E=Sophos;i="6.23,144,1770620400"; 
   d="scan'208";a="286683013"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 05:35:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 27 Mar 2026 05:34:35 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 27 Mar 2026 05:34:34 -0700
Date: Fri, 27 Mar 2026 05:34:32 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	"Russell King" <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/2] Add support for PIC64-HPSC/HX MDIO
 controller
Message-ID: <acZ5WDz5qVxBDj3e@bby-cbu-swbuild03.eng.microchip.com>
References: <20260323220254.3822444-1-charles.perry@microchip.com>
 <20260326203309.7154152d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326203309.7154152d@kernel.org>

On Thu, Mar 26, 2026 at 08:33:09PM -0700, Jakub Kicinski wrote:
> On Mon, 23 Mar 2026 15:02:52 -0700 Charles Perry wrote:
> >  .../net/microchip,pic64hpsc-mdio.yaml         |  68 +++++++
> >  drivers/net/mdio/Kconfig                      |   7 +
> >  drivers/net/mdio/Makefile                     |   1 +
> >  drivers/net/mdio/mdio-pic64hpsc.c             | 192 ++++++++++++++++++
> 
> Speaking under correction from PHY maintainers but I think we need 
> a MAINTAINERS entry that will cover Microchip MDIO, or at least the
> files you're adding. Important read:
> https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html

Sure, I think this should go under "RISC-V MICROCHIP SUPPORT" or maybe a
new "MICROCHIP PIC64-HPSC/HX DRIVER" entry if the former was meant only for
Polarfire SoC.

I'll add something in v3.

Thanks,
Charles

> -- 
> pw-bot: cr
