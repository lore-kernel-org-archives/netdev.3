Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493269;
	b=hqRvvQoVlwzwHtq4W448whxsDpLgAkO+XhlaCbBi20D7mBtLOj5ssZqX0731l3N9Ani2
	 n1EFqLvqy2GEOfelwimNbos2eaYJaAqv/CEBb21r29EfTlTa1BDsXNhZMn8pEVbrYupPL
	 FqKZuYEQCY3myUnJmO1d1ahDis+aBvSPYXNSHQK5hozAO+d8tw1w4PhRYTmSKBT4FYUsb
	 mxJUrS7+TwzTL9kWaqFmIGr1fdWITCcbtD2HHOMtZsKeVkp5oWuPlpSBYjSxJSzEH07U4
	 zYg5UbSxbPE8DHRtNwTloraFMa1gvf8Ourk0SAPh3LlhEi07cX1KPyi5CLCKdPkX1KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493269;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=M/fBweAhzcFLKDwuhXP3X3BybnVwQ3GjZgVfuw5XYNU=;
	b=0toqhgFKdJi1qz+OAtofJSLRIn4r8j2FK2HdmFcPkdmkxEGNwhYiWFQomnMTTwK4DHfd
	 QBIgDS/9AkD9xX/lMKqnZ2V1hh9WdaeaoSibD619uXJrLW+UwZrspNog+CNWfRHT4Y3ns
	 W25GQNEjEBOV0/ksBfA+CqTdiHiOa6iusWsn/kOcWQ6HBit0XuU3A0rvxDMtbiautesyc
	 VBlCYW9hYMRC1bMNq/x+b88cjqCmBX+spx9QsgfIVc1E8Y/Dw1Dy0y+LeLD4V4gB9JnJr
	 0+2nzP0zfYbjFhcEOVOsnEp/D0lkpNPRO2WgNukPqFR5QdaQxiVN7CZHqsBEy14Te7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=e2Nfqycy;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0D606C4E3;
	Thu, 12 Nov 2026 14:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E0D606C4E3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=e2Nfqycy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794493276; x=1826029276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=x+JNw/dnv+/uPmy8aMwFPaOOtJkAO2458id/MCOW844=;
  b=e2NfqycyuiP/eqCIXL2kc2R4yYIVV0dv0mTNAPyzqhrFeLpA8gyuHmiS
   V0oBbnT5h7I5Z18RywsC1jq2zjtsXDKS6x9mFoCJjX6gSCh1qzZcSBbsb
   A2JGpXdVF/JTlH3JEnpVRMNGldnQRDN3+z34zdOtthrZGta1NwOXAa297
   /MF5hydX+swGF0xLkLx/D+n5vT/N/EJVLtwvQcuGLlYfYf7Rkk76LfnFK
   I2xndIy9MRII6sQuIvJq919F1MeYyoTRq1hfVZIcqY4zhe8dz/xeByBds
   6MZKbNWi0K3Iz4KM2L6BL7E1KH4Hl0U1x7/BC4g1wubsjuQ+VNiOfU6Fq
   w==;
X-CSE-ConnectionGUID: reKXA5PPRLusex79S65Z6g==
X-CSE-MsgGUID: 5ak1JHUlQHKiGG6/Mts0yg==
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="66414905"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 07:21:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 12 Nov 2026 07:21:07 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 12 Nov 2026 07:21:06 -0700
Date: Thu, 12 Nov 2026 09:21:05 -0500
From: Charles Perry <charles.perry@microchip.com>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
CC: Charles Perry <charles.perry@microchip.com>, <theo.lebrun@bootlin.com>,
	<conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <git@amd.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Arya.Zahed@microchip.com>
Subject: Re: [PATCH net-next v2 4/4] net: macb: Add TSN CBS TC offload support
Message-ID: <avXLURArdsgp0dw9@MON-LT-C78453.mchp-main.com>
References: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
 <20260909142056.1433875-5-vineeth.karumanchi@amd.com>
 <avMxXCDMQMh5180r@MON-LT-C78453.mchp-main.com>
 <14e6511e-3878-4e14-8c25-7db5c179db8e@amd.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14e6511e-3878-4e14-8c25-7db5c179db8e@amd.com>

On Thu, Nov 12, 2026 at 03:39:26PM +0530, Vineeth Karumanchi wrote:
> Hi Charles,
> 
> On 11/10/2026 8:29 PM, Charles Perry wrote:
> > Hello Vineeth, 
> > 
> > On Wed, Sep 09, 2026 at 07:50:56PM +0530, Vineeth Karumanchi wrote:
> >> +
> >> +	/* qopt->idleslope is in kbps; convert to the units the hardware
> >> +	 * register expects:
> >> +	 * - High-speed GEM: fraction of port bandwidth, scaled to the full
> >> +	 *   32-bit register range
> >> +	 * - Standard MACB: the register counts bytes/sec in 1G (8-bit GMII)
> >> +	 *   mode and nibbles/sec in 10/100 (4-bit MII) mode, so scale kbps
> >> +	 *   by 1000/8 (125) or 1000/4 (250) respectively
> >> +	 */
> >> +	if (bp->caps & MACB_CAPS_HIGH_SPEED)
> >> +		idleslope = DIV_ROUND_UP_ULL((u64)qopt->idleslope * U32_MAX, speed_kbps);
> >> +	else
> >> +		idleslope = (u32)qopt->idleslope * (kset.base.speed >= 1000 ?
> >> +					       MACB_CBS_PORT_RATE_1G : MACB_CBS_PORT_RATE_10_100M);
> >> +
> > 
> > PIC64-HPSC, which has MACB_CAPS_HIGH_SPEED, doesn't have the first idle
> > slope calculation method which scales to the full 32 bits register range.
> > It uses nibble/sec for 10/100M, byte/sec for 1G, 2.5bytes/sec for 2.5G,
> > 5bytes/sec for 5G and 10bytes/sec for 10G.
> > 
> > Is it possible that you have another design config bit for the "full 32
> > bits register range" method used here?
> > 
> 
> The Cadence GEM revision `r1p14f2` in our implementation uses linear
> scaling across the full 32-bit idleSlope register range, as confirmed by
> Cadence support. However, the register description specifies only the
> second, speed-dependent formula, which does not match our observations.

Ok, on my side, Arya (cced) who did the testing confirmed that the measured
bandwidth is off with the 32-bits method. I think he tested at 1G.

> 
> I couldn’t find a configuration bit that distinguishes between these
> behaviors. Which Cadence IP revision is used in PIC64-HPSC?

r1p14f2a

The revision register reads: 0x220c010e
DCFG1: 08108510
DCFG2: 7af13fff
DCFG3: 24000000
DCFG4: 00000000
DCFG5: 502e7344
DCFG6: 0f9300fe
DCFG7: 00000000
DCFG8: 10100820
DCFG9: 00000000
DCFG10: 24454444
DCFG11: 000000f6
DCFG12: 37770101
DCFG13: 00037640

> 
> I can follow up with Cadence support to determine how software can
> identify which encoding applies.

Cool! Thank you.

> 
> Thanks,
> -- 
> 🙏 Vineeth
> 

-- 
Thanks,
Charles
