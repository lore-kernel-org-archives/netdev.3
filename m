Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316386;
	b=w/ZYJ33YuQYHGlRJqB37P2y3SE7X4dvWdILQvJFExSa9Wgb80Juhl/pdu8KYI4g5q9eC
	 aphbPxbWJJAeXewEpGVZ6Tnlv8LvOj8gqBOrCCvK8IxCTpBH3XvKJgbhYIJuxZuXp+eeV
	 i5NQjUu5qVONfWA7DzVRIahR4fEUGhR9t2QmUMPrKE9ZU4/Wf9+JrhFoNy0uRSs6h2Iqc
	 2Jetj489PcUNsdm21tck5tBOXyZyxN+UThQcXwetYbRH3zWw0OzeLp9GRwyAvfuxQDpD/
	 yDqMXiZ0y6wH2M8AwhH7h29A/5Pq9XJ+NES2Cwh8oOl5frNQCykhpuP7o87Cc4Tb8xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316386;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=4/PUgGHYUsBakGH2n9+U2cm3j13pF/H0zXfMb2wTw/k=;
	b=O+TUGcaQZgyoA2BTLWdBNWf1dzn06xUVzvsVvvElIdilTX/yvU/FMkJ2LA+KiZDnBcTD
	 Y1aL4GvGxUhsXvWtwDCbUuBkzuSpoScW/cIS0pkhnJvRfkizt9iVuqgvPscRsEJi27txE
	 zbEeGBwRaSkiCVBUVBFXan+hzQeLX3d96tZdDm4a7thdWlEjZMTBhGkXdqstyDAR6lv7i
	 ePmL6KzWulc0c2qXnOOik6qTnTMNhoh5s0BAm3eFhUb/msJQh0ZAttyQy65ctd+6VC9X5
	 tl2HupgiogZH4EpfGi2KDlB/1CgcsDomoJbEUqilyTqolfFNkNYytyDr4hRLanjKt9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=V5nP3ijy;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118E1606BFE1
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 118E1606BFE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=V5nP3ijy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794316393; x=1825852393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j7I5cYjLFfIQgEIFs4gbeVj2Ley5zMpJDapySrU/KIc=;
  b=V5nP3ijyOepIE0yiyd32Nz2Qv4dJn1qXkf8yqgfrkQ9e6j6AreiMclod
   9GHqtr6Nb8V4Q/SWEN/SZAGGK9vzIywqpcTKfv+S91wmshMhVRuLFMkon
   5ckt1+3Zrh0TcZxgFg9PkccR9Lcx511m4ESXDNKjeh8bu6nFxxFCgCDcq
   4GNJ16naLnQ28W6xp6rjxv+ttbAkfTn0CvV+CRx/fOfAU2ZcXULosTjvg
   5OKYBzSA+Ek+NCBe0FqdfJc+35iymC2VuvEY6itTziWXitrvfzOtwD6BC
   uUP+zv8oNk/cJc2u3sSCO4uar/Tn4UTOulkGS+dgZhcFt/rkvpTqmIrqb
   g==;
X-CSE-ConnectionGUID: HZnfFUx5SmOkiKvglT9eVw==
X-CSE-MsgGUID: PzSShebrSdmwrUoKeYDr0g==
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="76949869"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2026 06:13:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 10 Nov 2026 06:13:04 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 10 Nov 2026 06:13:01 -0700
Date: Tue, 10 Nov 2026 14:13:00 +0100
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
Subject: Re: [PATCH net-next v10 4/8] hsr: Drop received PTP packets
Message-ID: <20261110131300.h5tojxvryo777vnk@DEN-DL-M70577>
References: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
 <20261104-hsr_ptp-v10-4-2c4a38ad973c@linutronix.de>
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
In-Reply-To: <20261104-hsr_ptp-v10-4-2c4a38ad973c@linutronix.de>

> Receiving PTP packets via the HSR interface does not make sense. The HSR
> stack will forward one copy to the user and ignore the duplicate from
> the other port. The PTP stack is however interested in both copies since
> they will have different content (due to different processing times
> within the HSR ring) and different timestamp information which is not
> forwarded at all.
> 
> Forwarding a PTP packet by the HSR stack is undesired because the
> forwarding takes time, it is not accounted in the packet and this makes
> the outgoing PTP packet inaccurate and therefore useless.
> 
> Drop all received PTP packets. For the PRP configuration it is the
> ether type, for HSR configuration it is the encapsulated protocol, that
> is checked. A PTP stack that is doing PTP over a HSR network needs to
> retrieve the PTP packet on the original slave interface where it was
> received. The PTP packet is dropped with RX_HANDLER_CONSUMED meaning it
> won't be visible by packet sockets bounded to protocol ETH_P_1588. It
> works for sockets bound to ETH_P_ALL which is what linuxptp is doing.
> 
> L3 packets (PTP over UDP) is not considered because it is not part of
> the HSR specification.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
