Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF9E372EE2;
	Wed,  7 Oct 2026 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399686; cv=none; b=s+3YQmYH88r3nfHzCTlNbNSPvP/2toO7sKNWH2vDAJqdFn7ymunKe92+TgAK/tZS2X3RK4zqD/iVwIXF44UV0iydYWi474TTDKm1KY177zDdrCUbwc+0MtqeYT4MbEu0QrX5z99PfYCslmhGdc2vnhbp0Ec5wEOf3VLwxwrWGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399686; c=relaxed/simple;
	bh=r9/UkX5qkfP9xquwLYCEm1mWZnTtMuFJtqI0Xc95j7U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/G/MTl13aL/kFlaJd38Lg/iY1dsnok4S9Fxyeprnxny5Xtvf2YcJgMdPKhZXtr2+7DUMZ86loXcilg18HyftU/FV7VsrEYsVHIz280P2oUzsHiRvoNadC9C7XMZBdgNw8OR430s2s5/I3OOVwfLZx3yPYVw7EgUMHxAsSBiEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nC0fnpli; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nC0fnpli"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791399685; x=1822935685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r9/UkX5qkfP9xquwLYCEm1mWZnTtMuFJtqI0Xc95j7U=;
  b=nC0fnplivNQA8Zum5aN7iSflVwrxYxchrHOiXU9cfynBXpG3tN6gIaA2
   hiVztBJOO4OQlnl5PeWY5qA15apFcG1dK0oTzJ5BbdSAaBTMk5OCrWUHw
   gu1CrIkR+rJh7Wly0Fv69ApNfpt2ncVmGJrgH3bP2FkcCgHbXTtbchG1W
   hGJ53XTFnMawBf0VGX8QbNl8Vto7tQdyLOtLQ3PwmdaU2lfUXCKWj7N8u
   W4Ud6eewpiK9M11Ojfmb/Wg3aqqyuKHBFX7K+I71Bxg8YbF2nvPbMtw56
   xHVBoU2HGSi3mCvpqnhX2EPmUy7ab8wZIFTwjRtUnp1emYQN0NeaGGidL
   g==;
X-CSE-ConnectionGUID: UUpgY4nlTj+ccujAnzQp7g==
X-CSE-MsgGUID: GsXw/hrGS5+RY26hXJvliQ==
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="63773922"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2026 12:01:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 7 Oct 2026 12:01:23 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 7 Oct 2026 12:01:21 -0700
Date: Wed, 7 Oct 2026 21:01:20 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<suraj.gupta2@amd.com>, <radhey.shyam.pandey@amd.com>,
	<michal.simek@amd.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <robert.hancock@calian.com>,
	<sean.anderson@linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v5] net: axienet: do not report TX completions as
 NAPI work
Message-ID: <20261007190120.ne5xjp5rhvsbezjv@DEN-DL-M70577>
References: <20261004065930.1004953-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261004065930.1004953-1-maimon.sagi@gmail.com>

> axienet_tx_poll() reclaims every completed TX descriptor in one pass:
> it passes lp->tx_bd_num to axienet_free_tx_chain() as the descriptor
> limit, and @budget is only used as the napi_consume_skb() bulk-free
> hint.  It then returns the number of packets reclaimed, which is bounded
> by the ring size rather than by the budget, so the poll can report more
> work than it was given.  This was seen after TX completion interrupts
> had not been taken for a while and a full ring was reclaimed at once:
> 
>   eth0: NAPI poll function axienet_tx_poll+0x0/0x180 [xilinx_emac]
>         returned 96, exceeding its budget of 64.
> 
> netpoll is affected as well.  poll_one_napi() polls with a budget of 0
> to reclaim the TX path only, and warns once if any work is reported.
> 
> TX completions are not budgeted work: Documentation/networking/napi.rst
> lets a poll process any number of them.  Do as bcmgenet does since
> commit a58cdf56b6eb ("net: bcmgenet: complete Tx NAPI after one reclaim
> pass"): reclaim the ring, complete NAPI with no work done, re-enable the
> TX completion interrupt and return 0.  Re-enabling the interrupt raises
> it straight away if more completions are already pending, so none is
> left behind.  This also drops the extra poll that used to follow a full
> budget's worth of completions, which only found an empty ring.
> 
> netpoll polls with a budget of 0 and must not complete NAPI, so skip
> the completion then; napi_complete_done() refuses it in that case
> anyway.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

