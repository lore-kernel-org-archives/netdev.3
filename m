Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE31E3DB629;
	Mon, 16 Mar 2026 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685598; cv=none; b=kYZKTSv44pNW1TBBUjq8UsGZ88q5UeWGm56WeroO2LNBv5LzB1ldkPVDx2abjxXkbfHOAkI2Qip0aSKRa25X5jfxyVuP1G7wm0X7DSl8ZLUzMtEiU2NyOaKFj2Ncii9DyoFH2E8g5X3P74YKsAOqwhqyvSKQ4mQMr7LmsREaF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685598; c=relaxed/simple;
	bh=apYbyYOui1rckZizxTSjd9acpbvjHeFKs0eEOgcSTFA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljEUe1SmVcYCn85n4nDOySw89xegIhPiMDq8+f9kvSx2AR3DCwbQL/cwGyYjw9ozLxDaYqJjzOPJyTOC9hupoqHfmzp+eSyouw9UpIHTx+8l/2vrWb3CwWoyYB8Tk0E1fRQOG4SQnRcWQH3NgGQ0noFVGizs/urLTh8um3ORoq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EPyIZ9B9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EPyIZ9B9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773685591; x=1805221591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=apYbyYOui1rckZizxTSjd9acpbvjHeFKs0eEOgcSTFA=;
  b=EPyIZ9B9jZAOBvnv7Olkb7e9hjF/dJy+8/i87l9oOQjDGHfr2M4Y4YaQ
   wHBN2+E6mDX2OMKTTcKJ0r57VJVphhdTdkpONxZgs6XedkPEmEnXsoIT0
   UuNyYZjGiwSmAowO7RQy7D4t+RcBf0VV7IvhDRGe4WZGmmvpIuT+UZSTB
   aXhX1SkEfjmBX+OdPIeP11Lg0Vg9D2R8kUN/7WN7wpLcABSgkiyCpoyqY
   OgbaRGjD7mkIVoFianBEYGGMFzg758Da/8XFFXjOTxoRGdywAo1SwRFS9
   JMhJJD94AD2vyqLD8wVJKXYdUSRsYRkF9TRINwmD1f4d2pEaC4QmvhcgG
   Q==;
X-CSE-ConnectionGUID: pXnfX7B6TmWvfChuAYU54Q==
X-CSE-MsgGUID: +XnZOguVSHOT87prE55n1Q==
X-IronPort-AV: E=Sophos;i="6.23,124,1770620400"; 
   d="scan'208";a="55155074"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Mar 2026 11:26:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 16 Mar 2026 11:26:08 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Mon, 16 Mar 2026 11:26:05 -0700
Date: Mon, 16 Mar 2026 11:26:03 -0700
From: Charles Perry <charles.perry@microchip.com>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/3] net: macb: add safeguards for jumbo
 frame larger than 10240
Message-ID: <abhLO8fna/ioyd6O@bby-cbu-swbuild03.eng.microchip.com>
References: <20260313140610.3681752-1-charles.perry@microchip.com>
 <20260313140610.3681752-3-charles.perry@microchip.com>
 <DH4DORKIV5RB.3P7Z2RTRNCXH7@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DH4DORKIV5RB.3P7Z2RTRNCXH7@bootlin.com>

On Mon, Mar 16, 2026 at 06:21:38PM +0100, Théo Lebrun wrote:
> Hello Charles,
> 
> On Fri Mar 13, 2026 at 3:06 PM CET, Charles Perry wrote:
> > The RX buffers for GEM can have a maximum size of 16320 bytes
> > (0xff in the RXBS field of the DMACFG register means 255*64 =
> > 16320 bytes).
> >
> > The GEM IP has configurable maximum jumbo frame length that can go up to
> > 16383. The actual value for this limit can be found in the
> >        "jumbo_max_length" field (bits 0..13) of the DCFG2 register.
> > Currently, the macb driver doesn't use the DCFG2 register when
> > determining the max MTU, instead an hardcoded value (jumbo_max_len in
> > struct macb_config) is used for each platform. Right now the maximum
> > value for jumbo_max_len is 10240 (0x2800).
> 
> If DCFG2 contains the value then we can runtime detect it. With that, we
> could make the macb_config->jumbo_max_len attribute optional. Then
> start dropping it from platforms where we know we can trust the DCFG2
> value.
> 

Hello Théo,

That would be a good idea. We could use "jumbo_max_len == 0" as a way to
signal that the DCFG2 register should be used for determining the max MTU.

However, that's a new feature and it doesn't belong in this patch. All I
want to do in this patchset is put the real value of jumbo_max_length in
the PIC64-HPSC macb_config and make sure the driver doesn't overflow when
that's used.

Thanks,
Charles

> An alternative would be to validate macb_config->jumbo_max_len against
> the DCFG2 value, but that is less useful.
> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
