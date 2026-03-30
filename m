Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6DE3D3332;
	Mon, 30 Mar 2026 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879217; cv=none; b=fOM+B6OLqvKmYyVVSUZ2IFNkQEVv3FFi2Wsof41xHvK8ea84SCdhE10s/vEG7IbZGurWOEkI8w/1CJniNmN8m1sLhXpUAj5ajCeFehGoYodjNGfKAxVshP6qY9YDiFgFuFcE959Ot3c/SrQbrcgUr85Hw483Pgjgm8UL6jJd5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879217; c=relaxed/simple;
	bh=PYIefoqKaPsoDZtq6sEtaI74bCngcqGwyJSCcPwkuWU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVXC+bUVGUxFCwwPOymrx+TpQOmsg/2uNlqsr5YAMJVwbntHOMXVQwCKxWT06ivBbitpPo4oPBi0jLh4JCAPmNjS/TFfY2FWjcMfg9vL5OQgc7EpHb0MqVI3VA+fulFKMC2vPpOAEEzRjAzG6wc6nT+VPp2E2x54/BgrNZrMy0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vRPjMxeN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vRPjMxeN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774879212; x=1806415212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PYIefoqKaPsoDZtq6sEtaI74bCngcqGwyJSCcPwkuWU=;
  b=vRPjMxeNe08yJKvbdd0yiRi3YpRbHVTMljT2TygazZmzSG1BuNSyO80g
   zJVP6cJrM3GnIEhKmfd7DvhKcN/2v8YL17x8v9GbB3psQQ9EGdbrCrunW
   CM/wgawxs5lL4JWKDVF6a4TTKjAPzESE0a4IzjCiNfv/0QL9GVoZzxx6W
   HIsX/isozrXmTm9ya1XD/oaHJc2xSfSEyXgtfXSMuT7kQLsQCvzNzqGBF
   f5kWj5txcnvAwKYkdyt4mueLQb9ReKWH6gYw2iyij6dtD6xTTJsDojSs7
   VRKqPNJrJ9P8Q0ULoCScPaWGqEkX0bpLt4IXPtXykXRzINY/GQyb+GC8j
   A==;
X-CSE-ConnectionGUID: cscV8CARS5yPHgkEGqI0IA==
X-CSE-MsgGUID: R+GjTLdqTaWM8Zt2sz9FQQ==
X-IronPort-AV: E=Sophos;i="6.23,150,1770620400"; 
   d="scan'208";a="286781559"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 07:00:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 30 Mar 2026 06:59:49 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Mon, 30 Mar 2026 06:59:49 -0700
Date: Mon, 30 Mar 2026 06:59:47 -0700
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
Message-ID: <acqB0zJ7GqG2CiaB@bby-cbu-swbuild03.eng.microchip.com>
References: <20260323220254.3822444-1-charles.perry@microchip.com>
 <20260326203309.7154152d@kernel.org>
 <acZ5WDz5qVxBDj3e@bby-cbu-swbuild03.eng.microchip.com>
 <20260327165158.505855eb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260327165158.505855eb@kernel.org>

On Fri, Mar 27, 2026 at 04:51:58PM -0700, Jakub Kicinski wrote:
> On Fri, 27 Mar 2026 05:34:32 -0700 Charles Perry wrote:
> > On Thu, Mar 26, 2026 at 08:33:09PM -0700, Jakub Kicinski wrote:
> > > On Mon, 23 Mar 2026 15:02:52 -0700 Charles Perry wrote:  
> > > >  .../net/microchip,pic64hpsc-mdio.yaml         |  68 +++++++
> > > >  drivers/net/mdio/Kconfig                      |   7 +
> > > >  drivers/net/mdio/Makefile                     |   1 +
> > > >  drivers/net/mdio/mdio-pic64hpsc.c             | 192 ++++++++++++++++++  
> > > 
> > > Speaking under correction from PHY maintainers but I think we need 
> > > a MAINTAINERS entry that will cover Microchip MDIO, or at least the
> > > files you're adding. Important read:
> > > https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html  
> > 
> > Sure, I think this should go under "RISC-V MICROCHIP SUPPORT" or maybe a
> > new "MICROCHIP PIC64-HPSC/HX DRIVER" entry if the former was meant only for
> > Polarfire SoC.
> > 
> > I'll add something in v3.
> 
> Thanks! FWIW I'd prefer the latter - smaller entries make the
> responsibility clear. Under a big arch entry the maintainers are
> usually seeing too many random patches to act. You can add
> _both_ dedicated a entry and add the files to RISC-V MICROCHIP,
> if you prefer, too.

Ok, thank you for the suggestion.

I'll go with "MICROCHIP PIC64-HPSC/HX DRIVERS" for all the small SoC
drivers (MDIO, GPIO, timers, etc.) and a separate entry for the big things
like RDMA or FRER hw accelerator, if we ever get there.

I won't add anything to RISC-V MICROCHIP SUPPORT even if PIC64-HPSC is
indeed a RISC-V chip since this entry is all Polarfire.

Thanks,
Charles


