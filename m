Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6E4B9201;
	Mon, 19 Oct 2026 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403398; cv=none; b=rykb2tftwi/5SIvrj9hPvo4xyxVVPE21zc4fMfDpJ8nJb845lUGC/cC3GLfD5/H345LhNqqJr7ae92DIFFRl0Qo21q9UFQYKBBzSICZTvkrid/eAXHlRHP8SI4JFapc0/NwzDbrf+qsEkgIoav/Q0HhaXyrCjYo5LUcxe14pfvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403398; c=relaxed/simple;
	bh=4T8X+mnirwDXrJzYavy3/QN/Xx0CmFgmoKtciO5afpM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0hjtLzv8Ot9UVc+VXTKWP3TnLmeNjFDcRrQEdnNVP+leWXpn7efNQDngcjpnkUxsMEkWBgy05PDIEkTG4EwxO+2ENeBgirogJArbIMC8ChMX3nY5Sx3YExkPVIIoJgnP8N+PD9s60iZddq+auprYxOe/BYksQvJxdpsyzpCkrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CZSYLcy+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CZSYLcy+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792403393; x=1823939393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4T8X+mnirwDXrJzYavy3/QN/Xx0CmFgmoKtciO5afpM=;
  b=CZSYLcy+3EuUOv2tLBbOLxm1msliAcgCc0iv/GAnTl3zM7CZjkfC2Zcr
   ietVLs2DD+L77l+Xv5v4XeNJQXBfxij7STOFTGYd9qqOFzwhux77Hy81/
   ywpyFSzoZtWEMzjnlE4ztS7z2Pqk4tnJjGdCa+eunHFKLgu1BiE0tzf3n
   D4DTxBiorDAK+qDSFblndna5+uFeWUiLvH/PyqavcBOwqLP9WYbZP5St4
   vMVI9bi++PZCljpWA2JR7OJwE5vwZ98xqBicGdhJhurHdqI6COmATrbWi
   aFFzLckWhK2u/VH9rmTR124DW69kHlY8jbkRslkIKf75pbVtRC3sAf2fo
   g==;
X-CSE-ConnectionGUID: Bjc3CSJCRReGvAr2uSyZ1w==
X-CSE-MsgGUID: tO8BcGNTTvWkJw7Wrzmxgg==
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="75656201"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:49:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 19 Oct 2026 02:49:52 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 19 Oct 2026 02:49:49 -0700
Date: Mon, 19 Oct 2026 11:49:48 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, Chris Snook <chris.snook@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: ag71xx: re-enable TX interrupts on RX OOM
Message-ID: <20261019094948.q7kis563ir7zxb4s@DEN-DL-M70577>
References: <20261019020147.213746-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261019020147.213746-1-rosenp@gmail.com>

> When the RX ring runs out of buffers the OOM path calls
> napi_complete() but does not re-enable interrupts.  Because
> INT_POLL masks both RX and TX events, TX completions are
> blocked until the OOM timer fires (~100 ms), which can cause
> TX ring exhaustion and dropped packets.

Is that not exactly what the OOM timer is for? It schedules napi and tx buffers
will eventually be freed. I mean, it seems like it was designed to work like
this.

> 
> Restore TX interrupt delivery so the engine can drain completed
> descriptors while NAPI waits for RX buffer memory.
> 
> Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: add Fixes: . 
>  drivers/net/ethernet/atheros/ag71xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
> index d93fd91ff884..5a33759be3cf 100644
> --- a/drivers/net/ethernet/atheros/ag71xx.c
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -1746,6 +1746,7 @@ static int ag71xx_poll(struct napi_struct *napi, int limit)
>  
>  	mod_timer(&ag->oom_timer, jiffies + AG71XX_OOM_REFILL);
>  	napi_complete(napi);
> +	ag71xx_int_enable(ag, AG71XX_INT_TX);
>  	return 0;
>  }
>  
> -- 
> 2.56.0
> 

/Daniel
