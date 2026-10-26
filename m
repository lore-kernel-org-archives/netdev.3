Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999319;
	b=jQWnTaXs2u2gxWTa3PF9vbkxVzhT2LRcOtP+zNsJ3+CaJdSdD+h7cZ1Fo1lZMFWv1u+6
	 iClJWZ13cvEaaGFCrIngzFT75xQkM8O0P1KjMqcs/1IgCpVgZEoffl0xug7iVfrRN8kNy
	 OzHsydUzG3f4Ut7z8vCOPeziI83tPGYQc4NOsRKior2Lsd0umToIBHq6DgBAOtPuaegkt
	 Si2J0sUllhE8wRjwKRmaFfsgXKI9prHDDYBp9OxvYjE/GuNqBn+Wc4kDn0YdQtfT8hM2t
	 9DVsCfFVpa3ZLo+lB3uzPjYlvoCZZA2ArfpLzRZ8oBiifNqggxOzDK7XbPCHbzoDJlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999319;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BOPcVymxNrx1ajpQ+9wn+1qx2hBtOqLVwS2WonSwSm0=;
	b=edHGoO6cW1Y4KDXVRtSFQXubR24DdXzeowJwkom6fu3Qa4g8uyO2DtStXScOImElsSlL
	 0xStOxSTcQUIoGcJgaaJ6gZ1mFaFwF+qR1vd4JtIRwZqjiWSg7Nh6QmbGQB4OzTSITkTe
	 XN92qYEVF/LSxZDSdQBPR33SuxVSwufeO8eFWNrg1Q/UJ7DhOT9rSTvLT2aLaUd/QM8Bq
	 cHjwbsNNjsL8696MKSy+xOr68SgFO3K/7pjlMB4ydS7DkPfsths8hbNXxB+LWqAy3PNWn
	 Zz8opQP7ZP8/1/ns7KyynrG0+pKILboru9FbOtQPHhiG4YoNhvTIZXkZ3XhqIxfeZBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=mvGqOZUK;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A64606A31E;
	Mon, 26 Oct 2026 07:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85A64606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=mvGqOZUK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792999318; x=1824535318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=deFrrVpWgMGxOTxrTbK4OH/vduPGE+WvscKcvDwKZss=;
  b=mvGqOZUK8xiEn9PLGLVd1f6q2XJfcP68YkCLUI69U/dMsUoCHkArpURi
   2uq6jsvTmBLQ+1MF8lmc2dV3JSKVtt5RLQtWKkyZnedxCDJ3tWaacJBu1
   LtHcbaQvPznmZAq+nBtb+LG9n3r71C6X+qLaw2v2ghKS6ZJvHZr4ND2FO
   A6AP8iEfkPVaLUZ0cm+xZgmTOEu0y9MmJIffvUkf5/PebQSRlaZg7tZdO
   Jekhmm43sjgBSuXWmjrwjEBb2rCyPGAC5A3FbDHVtzygXXKMkKX+wSqg4
   X3TUrb/C3VfekcX9aiG5Zt+jjbTWRrycwQ0TsrX9OQ3ozuFHQV/jgcZ6B
   g==;
X-CSE-ConnectionGUID: pwURBPWpR1OCTpQ/dUnt4w==
X-CSE-MsgGUID: dg3/cerwTSCVeC5mPYzY5w==
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="232624030"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 00:21:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 26 Oct 2026 00:21:51 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 26 Oct 2026 00:21:49 -0700
Date: Mon, 26 Oct 2026 08:21:48 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Selby Mashiki <mashikiselby@gmail.com>
CC: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: lan966x: fix double fwnode_handle_put() and missing
 mdb deinit in probe error path
Message-ID: <20261026072148.6qwynmdj3n2go23x@DEN-DL-M70577>
References: <20261025203155.455075-1-mashikiselby@gmail.com>
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
In-Reply-To: <20261025203155.455075-1-mashikiselby@gmail.com>

Hi Selby,

> In lan966x_probe(), fwnode_handle_put(ports) is called after the
> fwnode_for_each_available_child_node(ports, portnp) loop finishes.
> However, if lan966x_fdb_init(), lan966x_ptp_init(), lan966x_fdma_init(),
> or lan966x_vcap_init() subsequently fails, execution jumps to or falls
> through to cleanup_ports, calling fwnode_handle_put(ports) a second time
> and skipping lan966x_mdb_deinit().
> 
> Add cleanup_mdb and cleanup_switch labels so post-loop initialization
> failures deinitialize MDB and clean up ports without calling
> fwnode_handle_put() on ports again.
> 
> Signed-off-by: Selby Mashiki <mashikiselby@gmail.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 1179a6e12..7abfd97ad 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -1228,7 +1228,7 @@ static int lan966x_probe(struct platform_device *pdev)
>  	lan966x_mdb_init(lan966x);
>  	err = lan966x_fdb_init(lan966x);
>  	if (err)
> -		goto cleanup_ports;
> +		goto cleanup_mdb;
>  
>  	err = lan966x_ptp_init(lan966x);
>  	if (err)
> @@ -1255,10 +1255,15 @@ static int lan966x_probe(struct platform_device *pdev)
>  cleanup_fdb:
>  	lan966x_fdb_deinit(lan966x);
>  
> +cleanup_mdb:
> +	lan966x_mdb_deinit(lan966x);
> +	goto cleanup_switch;
> +
>  cleanup_ports:
>  	fwnode_handle_put(ports);
>  	fwnode_handle_put(portnp);
>  
> +cleanup_switch:
>  	lan966x_cleanup_ports(lan966x);
>  
>  	cancel_delayed_work_sync(&lan966x->stats_work);
> -- 
> 2.56.0

This might fix the mentioned deinit issues listed in the commit description,
however it is still racy with the netdevs, which are unregistered at a later
point.

As I mentioned in my lan966x-pci series [1], I will redo the whole error/deinit
path in a series for net-next, which will fix it for good, including the issues
in this patch.

I can't reject this with pw-bot, since I am currently not listed as a maintainer
for lan966x. Horatiu is pre-occupied with PHY stuff, so he probably wont reply
either. I will add a patch that adds me to maintainers once net-next opens, so
patches are routed properly to me.

[1] https://lore.kernel.org/netdev/20261002090248.xwlcm3zclt6imaou@DEN-DL-M70577/

/Daniel
