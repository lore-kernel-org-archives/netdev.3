Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317079;
	b=BpeDUCWU5vTJ7vaVTw0DpavXicHn9gZvlyOohmvSST5Iv9hBgrUeQQTQC0Xvuba1KC0m
	 2LosmC+UjNymT2fO2DuVPhC9N+O8ND8AREIqlmXtvYNsoEtZUxaRW8VPvZB2HNI/v5ka6
	 QD3LFaMwYhnIMbp1tvwOf4iADVomF2JozABJ4UYeY9V1WOWo24C4WceUpcqtfSMISCLeT
	 M9BW9p0X0yDPYIlLpG22c3dm/n3Z4Kk7ryYzqwMrYE658xXIDztChxfwHhBQsrfTMUvq+
	 lhSL82GYIhyZTpNLUeW9I1lGXNSbR6zuMr9fVU/YbODz0jfM6sbi7KD0o3O0Fqa1RQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317079;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ez/JCg58KR3ETRDnKPSAi5iS2CETEftIr/TvazZwHzk=;
	b=DSXWbJIs1e9KcnZA8hxj0QPdytPsu0XpzjNw8xvhlioP9P73cLGGx/RnaslYKf0NGFdS
	 dGNQi3toYX8W2nmL2cjDPVjS1GPZPLmyZdN2kNl0AJgvOp0M/fNzQLfNrnVZC1+6zHK5J
	 XeaDIxhR/0NDrS34PFt9VWK1OO5FVk7DR6OLOxjHr+reMWw8ApjeDU3QG6D5/ZSyt4kqM
	 iTre9o80Ivfb8bZNHqsPy6B2PpYYqtALSJQxB6iR8DoUb0ii3twmgk3x3rFic6et8dOEL
	 QOuFBrIk32EY6gQiIE3OOsVtfRwgH1pC+Ulr+/Nckkc9547Bff65xKQoOO/jgw4F7Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=mTzyxezS;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40508606A75E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40508606A75E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=mTzyxezS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794317079; x=1825853079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q0WM4IQNA+5HkUqTd6LkTN4cVtA3wujV9hn1BvMV2/o=;
  b=mTzyxezS44aZvswxlO0ZYQMX/cFpPPhpXYa1Ovv6SQayIlZZ5+to1z9L
   sDh3bO5V9Yh81H3hPCTqBd3n/RdXHCdtZl/ZCfDGXEx3dhncu3ISgUXqX
   xlcw7Q3uiT0N/JpBaz/lw/uqu7fFxCDLQcYFt/ZwrOju4A6I2o28a62ql
   7ZCywcy1WbLz7CsfbcPg87U6Zzo1v7gsarHh7L/jLHty5Hx6i+6Ici9fd
   rgP2Wv6/KII5Fpfl5fQ6pd3Q596yl9g20h7Oi3/gkb06Qm83ZHtDAJRt2
   HaatgcNjwEyolDtu6W9bKoIEx1Hoi9Tedmz/vXeSbxYjMDg3nQU4n0Lao
   g==;
X-CSE-ConnectionGUID: yWUbyzJJQaqnQpTDC39jPQ==
X-CSE-MsgGUID: b7Wzm2JaQKG46PFNfGv5aw==
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="66534219"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2026 06:24:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 10 Nov 2026 06:24:37 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 10 Nov 2026 06:24:34 -0700
Date: Tue, 10 Nov 2026 14:24:34 +0100
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
Subject: Re: [PATCH net-next v10 7/8] hsr: Move struct hsr_ethhdr to a global
 header
Message-ID: <20261110132434.uksd7ysdmntqx5bz@DEN-DL-M70577>
References: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
 <20261104-hsr_ptp-v10-7-2c4a38ad973c@linutronix.de>
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
In-Reply-To: <20261104-hsr_ptp-v10-7-2c4a38ad973c@linutronix.de>

> In the offloading case the network driver needs to inspect the HSR
> header to find out if the encapsulated type is a PTP packet where it
> needs to suppress offloading of the packet.
> 
> Move the header so it can be included by the driver.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
