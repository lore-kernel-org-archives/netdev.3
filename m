Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313369;
	b=hJEbe6+r/+LbRgT8djke9jpiISrJ61hv+YIhaAdyCg8QrDy4B9g4oV5fjZ7aMp1rTEmt
	 aIUCGdC1wUhiY4ZMSIVuw3NWdrURSP7oBPa6+T/ocRgHINfd37BIyJ4DbWObcWwyX1Zuc
	 STQC2Mu4nk4oSDPTDX1exmZAAXeOQ9GqQ4+7DXPCLUZcS5oiI/a608Gj3Q3Bdj3+Y1blZ
	 m0K603AxDHdFlU+yprrQUDgrlQypNUCJ06z99X8rA71kWPli8Dz/zQ5/Bpm4XCgtevl7V
	 yS2tXE2hAr5W6es90L38lar0J44XN6pHEA9NmXf6uaCfs5oBi1wJmmgSkk9I2MGIk6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313369;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ErVrZHzCGVb86fAl2PuuALhkKho2Yu7Rydoq0FHvBFY=;
	b=fRtxdNBtSy/NoRt8aSFHtSiFVx/W8jwOhy/8oqEDMD6VM1PDrv9vFYE72b+zqWGt5Vg7
	 KPAdpvqcq8amj9aPoMtDm0skS0Fm11M6qxak/RZWQvjJ6X1MLbtDzWcQRIWi6CCEXukll
	 mg4AFKzZ8cPMSzj1d06DjF9G9rjH8uK24QxZsA+hkukY9Iujs8TamOklhWnMf7mJivq1x
	 LolmbEI2DbPZSU6aMu95KMTX5TrCCTsjMq43BNDIqtCRmXujNVl20iqAD9rqP0uRfxdTq
	 F2y0mlX9hW+gEKk81dfxhqkTaTA6Hi13tpRRtpCPSqJxjp3RSRMnljYnWKXc/Ct8fqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Er76OvG+;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C8606A338
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B8C8606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Er76OvG+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794313368; x=1825849368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6oAZQRqY86x1xOtWlatjj91RHRAjPCFAjDhav2GUMac=;
  b=Er76OvG+np9CzOzBZy3IMnziG6OcewNzD3yQZxHlO94DWgxYTxGjDAHw
   GDwY3CqOdb6Cb9xfhhvKryzL395Va1quZysjYSJQ9nX2RtOGOHBEnvrDf
   EdKKLG3zMls2WTooC/Z4O7cFly8sLdm9TaJBaNRJq6gf1roCX7Hi/ePEl
   tJlj9+yiIR9FPXOrn+OJiDQWYotYuLcKT50XS1ArP2t3fcXjqh1+BNUOM
   2IYKTggfKZtAHKtr9XylWYFWKzrolQ0krZyY9pa61NIFnNrpakjneO/Kw
   3lR9hshnc/DgmxUB+NeyhHuuuJg4co90NclMqUyvULJXx2+KY8FHBMGU4
   w==;
X-CSE-ConnectionGUID: 9iCttozDRFuolkTKQzl6VA==
X-CSE-MsgGUID: fiB9ckwJTACKKJzD38XJMw==
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="297707299"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2026 05:22:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 10 Nov 2026 05:21:47 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 10 Nov 2026 05:21:44 -0700
Date: Tue, 10 Nov 2026 13:21:44 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <netdev@vger.kernel.org>, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Chintan Vankar <c-vankar@ti.com>, Danish
 Anwar <danishanwar@ti.com>, Daolin Qiu <d-qiu@ti.com>, "David S. Miller"
	<davem@davemloft.net>, Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Neelima Muralidharan <neelima@ti.com>, Paolo Abeni
	<pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>, Pratheesh Gangadhar
 TK <pratheesh@ti.com>, Richard Cochran <richardcochran@gmail.com>, Simon
 Horman <horms@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net-next v10 1/8] hsr: Add header_ops::parse_protocol
Message-ID: <20261110122144.3gvhmlmh2yudkcse@DEN-DL-M70577>
References: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
 <20261104-hsr_ptp-v10-1-2c4a38ad973c@linutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261104-hsr_ptp-v10-1-2c4a38ad973c@linutronix.de>

> af_packet uses dev_parse_header_protocol() to assign skb::protocol.
> The hsr stack does not assign a callback so the field is assigned to 0.
> 
> There is nothing known to be broken because this is missing. Having a
> callback assigned makes it possible to use the protocol field later in
> the series by packets which originate from the AF_PACKET interface.
> 
> The header used by the HSR stack corresponds to the ethernet header for
> the "first" part so the protocol member is at the same position.
> 
> Use eth_header_parse_protocol() for the hsr_header_ops's parse_protocol
> callback.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
