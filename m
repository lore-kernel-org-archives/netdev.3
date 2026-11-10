Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317053;
	b=F/O0DopTM1gs6VqFcdswlPphGpHpp0mmcfB/euS1UuGSEHfW8F4xutL3XBkW7goh4NnN
	 5v8qpBFXHi00dFo/fnyXugkzCzkcCj5hkrc1ZnR5XvnJdV05dzGM2gGN6H5iKQm92XvRU
	 MQP+Up7vRFuQNvc1x4YuZIMw2eirKwwGyqbVMHuPpQu8eaVX4EBVtpPMuD7qw3WrmaTBk
	 bb5smsbRTr2ZZf4yuoRA1H9riDyq26fX8Iv0T4Ca4iGTsgM0VlKrPjJttwHe9uTi6QzQo
	 uBUsFuYxVpalJ6c0hxnVZR0mDW9ayV49w0O1BkAyt1H/TiB9g1NSZgRoti+JU/5c7/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317053;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=sZMd6R4OSFptE9OWSCO1Y24/IvB2Is7uaKRJrJnRdQs=;
	b=UMeAjuFu4d0P0SEeRDCupOcGKPAntQtNQnkgqLdG2d3crrKWE2gvqCLMhTQxHjvhR5kb
	 /8FQsHKu4XXm9yI7iMCljCXizZp4IPHkKhwrutqrzzfmTiu+FS9wwqSnhK+4n2hrtlDj5
	 FKJJd9OCzPnmRZs//gUKUcs3t2esX0xvp99w/NHBQgGKs9ckn0NVpCoPxkyOj1mMwTMyK
	 7sd6FMuynLV8+W0I2iT1rm4WLZ4YszsS11ob/w9AJ2ZHBcyifPp4CvJBzHu6Y8vxTsH7C
	 aX1KiohemwfwSTXCZaEvbZgUvVvSEcqQkwW9GQwG08n2pTNpMzpQlXiV2kU33XSnz7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Mpidnu9V;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CEC606A766
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90CEC606A766
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Mpidnu9V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794317052; x=1825853052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ps0/AC18hxXpQVIXw0JMS3slBD7nD3RaVnfB+Fag+NI=;
  b=Mpidnu9VSAg++83qGShLDinvbkrKkjuBKTQiPYO/fruoSHBITZFJjkgx
   XgXdLN8sPkIXFnVVYZ+ckTvlQnhRK3qRiAjbP67axAvO8QWsrWyZ6qzUH
   uStxYRuaTPE7eBojw7V0HLQxMt1sXANPdDp5Rc7SEGjn/8C6179NbEJl3
   e2tyZsu9r/oMrILsQ4RpsvSJmGZvqDnLLYNgu3cAmWYSP8g26WEAJnPI0
   +JsqRIyh2FqbyFSloptzOJLNuYk8JlYsyMwykyTvbYRSnJjRPhur0PBgw
   lkhW1UtreEyQc9uLa8axDdRybXNjHw8INuY1ySJcw1vZhcgFIBqDlLJt3
   g==;
X-CSE-ConnectionGUID: k3mY7lHkR/ypGjHutIY7vA==
X-CSE-MsgGUID: 0zHUnWTmQAaseJwjJMZROQ==
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="297709555"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:24:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 10 Nov 2026 06:24:10 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 10 Nov 2026 06:24:07 -0700
Date: Tue, 10 Nov 2026 14:24:07 +0100
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
Subject: Re: [PATCH net-next v10 6/8] hsr: Assign a socket for cloned skbs
Message-ID: <20261110132407.fen7zmmxjn2fl32v@DEN-DL-M70577>
References: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
 <20261104-hsr_ptp-v10-6-2c4a38ad973c@linutronix.de>
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
In-Reply-To: <20261104-hsr_ptp-v10-6-2c4a38ad973c@linutronix.de>

> The cloned skb does not have the socket recorded of the original skb
> because skb_clone() clears sk_buff::sk. The original skb is never
> submitted but freed in hsr_forward_skb(). skb_tstamp_tx() will only
> submit timestamp information to the sender if the socket is recorded and
> the TS flags are available.
> 
> As of the recent changes everything is available except the socket and
> the requested timestamp gets lost.
> 
> This does not consider PRP part of the stack. The specification says
> that PTP-PRP packets do not have the RCT therefore these packets can be
> sent directly from userland skipping the stack.
> 
> Assign the socket of the original skb to the clone so the timestamp is
> forwarded to the user.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
