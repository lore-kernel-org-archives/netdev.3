Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618931;
	b=g8axpDpjeY5nzBa2SjI3iNxExaHmJthicSUhkb4Z7H+cDxkIpF9xsjtzoiXi49AKOhy1
	 mcjkfj7cD+NpnUYajbdbQ4ITaQ81+Tt3oMqrdfP52mrwK6gdljFC6fdfIJpSF6gXWGlCF
	 bTxCkc8lvhvEmgPmiYE80aH5uhotZTFRxxjrNC6rA3CsHj1oQdyUzGbzaagWeRDo4m36k
	 HACty3/cVqXQ+XS/Pvq8B/FThSlHsRM6MeZyXUKqB8ZpP265eD6pPRPISxz3vZDixVOEs
	 2zRfgbide/iewVhQY5m4CXYuoQZ8+GTo9jnOopMiBSAIsOqx8BQJFZq7VwjPOXV5KAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618931;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=S5HBX5WyYEvOcycUq/CbPV4Advk2wnS6D7kcF64F/Ds=;
	b=FicqN4MHOBFwb72+bwAHKtelvDX4/UHQjihZ7QZh5W03zOqX41wuiSGRnAr4jsPAuSeB
	 UomN8rjP6ASYBtZ6s2HkmA8R6CQbjIUgDONAvnbvj7qStiOAs61Lqp+blpocCxavOg2Ws
	 q2SfKOXV1tjDuUxYrSCSzpwwibY9xESC6+85EJ9jcYh7gs+3IpXq/XyBotNMK2WtUwbhf
	 ftWOYLBkaEKYecAz6jJuWdInG2dSdGLFTXiktAj0U2m8oMVGAfouJiY7Lh8uaDa2iYQds
	 fcwrw+HrjSldLDG3T3Bgj//K5TwQK0b/ojOnZAARy2zt0N0kpd7sYBoT4QW/eXFibAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=1HSB3kR3;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EB560A2639;
	Mon,  2 Nov 2026 11:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4EB560A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=1HSB3kR3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793618937; x=1825154937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gw37H1abHeljhxGG56+5FX6JEE4HykoW6/Bor3KrhW4=;
  b=1HSB3kR3Iw77pAldAZBgTjKKvAtWhViN5cEtlefQroTMnltmbZDIjYqh
   QqJaOid4G+MYt03+xHA0BRYa6ZYwyWJDyTizYMwTO7Albe+upMSAuvgrk
   rrbxxQNdM/FnVrjMAbQlfKF9lo55VZszbx0d9DEu93tFTjgIVfdUg45vu
   t+CmPvl6BJtUkY6d1LHurhh2+M1qBGNt04h+2VAzfux+JMDw+m2S+i3NL
   psxnCmQhW/zpgiY2La3gcxcLo0zAtVg/9cPUcbQF7eMtBIpFjBHx6JOUI
   mtcua6gA5nOPIiSSrjuG7d5bY6PztN4HHGXgKzbwpIjpnz/Hc/6xYK0tu
   g==;
X-CSE-ConnectionGUID: Ja/8ZeqjSma9AeTiAfGn1w==
X-CSE-MsgGUID: sJ9J1adJSsqTyO6loN0Rtw==
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="64912217"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 04:28:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 2 Nov 2026 04:28:49 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 2 Nov 2026 04:28:47 -0700
Date: Mon, 2 Nov 2026 12:28:46 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: <colton.pawielski@gmail.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Daniel Palmer <daniel@0x0f.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Karl Mehltretter
	<kmehltretter@gmail.com>
Subject: Re: [PATCH net v2] net: 8139cp: keep Rx masked while NAPI is
 scheduled
Message-ID: <20261102112846.j64carcljhtmqv3v@DEN-DL-M70577>
References: <20261031-b4-8139cp-napi-v2-1-5824797c0fe6@gmail.com>
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
In-Reply-To: <20261031-b4-8139cp-napi-v2-1-5824797c0fe6@gmail.com>

> From: Colton Pawielski <colton.pawielski@gmail.com>
> 
> cp_rx_poll() calls napi_complete_done() and only then takes cp->lock
> with interrupts disabled to unmask the Rx interrupts. An interrupt
> that is not masked while polling (TxOK, TxErr, ...) can arrive in
> between. cp_interrupt() then sees the Rx status bits, which are still
> set, finds NAPI no longer scheduled, masks Rx and schedules NAPI again.
> cp_rx_poll() then carries on and unmasks Rx anyway.
> 
> From that point Rx interrupts are enabled while NAPI is scheduled:
> cp_interrupt() leaves the Rx bits for the poll routine, does not mask
> them because napi_schedule_prep() fails, and the level-triggered
> interrupt fires again as soon as it returns. On an SH7751 LANDISK
> under combined Tx/Rx load this interrupt storm was captured with a RAM
> trace right before the board locked up hard.
> 
> Mask Rx in cp_interrupt() whenever Rx status is pending, not only when
> NAPI gets scheduled. If the race leaves Rx unmasked, the next interrupt
> masks it again, and the pending poll unmasks it when it completes.
> 
> Fixes: ab1e7e1d2666 ("8139cp: use napi_complete_done()")
> Signed-off-by: Colton Pawielski <colton.pawielski@gmail.com>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
