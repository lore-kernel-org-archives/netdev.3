Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703436DA03
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785151722; cv=none; b=uc7V0fvSq9QHqLsSQBCBD6o6YKXoSG/W6tjORrRjvXtTSDOSqp9ZZVecjOn3FznhRxLVR3yM3lxuWhp5kv5bDBVW5TY2EW44HkiWX73/pGVuMSTR28zUul38qLGezzZkqpKhX8YkqotVZmyO13zI+o4+xf2dzZB9UKu95iJBzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785151722; c=relaxed/simple;
	bh=n0GD3cUUGeVIMrUID5JoQdwaQmUZHXOQUsNurhq+9Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7RTsht0SHVMC43KeHMdYXvjZ29Horit335x3JQvvp/8weNelSDlML5B42SbAzGs2g6j4cOgUhKiWCxaVJRHXovE2SwsVNusp+Z4hNCzfYKCoRxHW4PI5rw2JR/4mSLnj2lpPfgWVIeWHh95d1bkWC8hK1iQ1acQ92Uvhq648Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlYbih78; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlYbih78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785151720; x=1816687720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n0GD3cUUGeVIMrUID5JoQdwaQmUZHXOQUsNurhq+9Rg=;
  b=mlYbih78YnVwsvPblOIFHOGla2ExUMXn5avlS61AQkVW4gYfVie+hcP/
   2mILkr0GLQKyRUVp0IaMVFzRdsq85cCsTLToswa9yrXkZq+0GNa7lXAFP
   Tf5F/4XKFQtisdrBS4qiNbUQohWtxOrQMaOvXAHyOgIM2xZHMUpZRk95z
   zAhdwxrhMaGQxmEEaq1qw2rSYQ70JKVFYF9FktcwfjPaTR90CODfGXHwT
   yWjSey47dnjo1Ny2Iy7VG2U+GcjpZ9BH/lf6n9hJ5JXUt+5O1N21lHdBS
   svI/0tmCbUxzOUDXSWPb1pHPcjyZyQdR6vrvlhShWmrTKHLlm3Z9GePGi
   g==;
X-CSE-ConnectionGUID: T6nbgV9PS8e64G3sVcoWxA==
X-CSE-MsgGUID: ZF2Fo+fPT7OwzCnq+TVlnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="85836372"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85836372"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 04:28:39 -0700
X-CSE-ConnectionGUID: Qb5ID2khTAiJn0Y7QbjHmg==
X-CSE-MsgGUID: sqYNrvDvT9uBeF47vN3Ebg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="256720894"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 27 Jul 2026 04:28:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B157199; Mon, 27 Jul 2026 13:28:35 +0200 (CEST)
Date: Mon, 27 Jul 2026 13:28:35 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: faliye <fy15309206903@gmail.com>
Cc: netdev@vger.kernel.org, michael.jamet@intel.com, westeri@kernel.org,
	YehezkelShB@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net] net: thunderbolt: do not enable E2E flow control on
 the Tx ring
Message-ID: <20260727112835.GJ2365036@black.igk.intel.com>
References: <20260723025649.7112-1-faliye@ymail.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723025649.7112-1-faliye@ymail.ne.jp>

Hi,

On Thu, Jul 23, 2026 at 02:56:49AM +0000, faliye wrote:
> From: FAN YE <fy15309206903@gmail.com>
> 
> Commit a8065af3346e ("net: thunderbolt: Enable end-to-end flow control
> also in transmit") started passing RING_FLAG_E2E to tb_ring_alloc_tx()
> in addition to the Rx ring.
> 
> Per the USB4 spec, a Transmit Descriptor Ring with E2E flow control
> disabled does not require any credits to be available before the Host
> Interface Adapter Layer transmits a tunneled packet from it. Once E2E is
> enabled on that ring the controller must first obtain end-to-end
> credits.
> 
> The ASMedia ASM4242 USB4 host router (PCI 1b21:2425) never delivers
> those credits. The controller does accept the configuration: reading the
> ring OPTIONS register back right after tb_ring_start() returns exactly
> what was written, including RING_FLAG_E2E_FLOW_CONTROL (bit 28) and the
> E2E HopID field. No credit ever arrives though, so the Tx ring's
> hardware consumer index never advances and the link carries no traffic
> at all.
> 
> Measured on two hosts connected point to point, onboard ASM4242 on MSI
> X870E and X870, v6.17, stock drivers/net/thunderbolt/main.c with only
> this patch applied on top:
> 
>   before: 100% packet loss to the peer; thunderbolt0 is up and the
>           XDomain handshake completes ("new host found"), but iperf3
>           fails with "No route to host" once the neighbour entry
>           expires
>   after:  0% packet loss, 0.28 ms RTT; iperf3 4.21 Gb/s one way and
>           5.17 Gb/s the other (5 runs each, stddev <= 0.02), 1
>           retransmit in 10 s
> 
> An instrumented build additionally showed a frozen-Tx-consumer watchdog
> firing ~30k times in a 10 s window before this change.
> 
> Rx-side E2E is left untouched, so peers that do return credits keep
> receive-side flow control.
> 
> ASMedia does not look like an isolated case. The out-of-tree
> thunderbolt-ibverbs project disables native E2E on AMD NHI by default,
> noting that "Strix Halo has reproduced TX completion wedges with
> multiple native E2E rings active" -- the same failure mode, on a
> different vendor. Since the driver has no way to tell in advance which
> host router returns the credits, defaulting Tx-side E2E to off seems
> safer than adding a quirk per affected part; it can be turned back on
> for controllers that are known to implement the credit return.
> 
> Fixes: a8065af3346e ("net: thunderbolt: Enable end-to-end flow control also in transmit")
> Signed-off-by: FAN YE <fy15309206903@gmail.com>
> ---
>  drivers/net/thunderbolt/main.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> index 02a916505..121a42a4f 100644
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c
> @@ -930,7 +930,15 @@ static int tbnet_open(struct net_device *dev)
>  	if (tbnet_e2e && net->svc->prtcstns & TBNET_E2E)
>  		flags |= RING_FLAG_E2E;
>  
> -	ring = tb_ring_alloc_tx(xd->tb->nhi, -1, TBNET_RING_SIZE, flags);
> +	/*
> +	 * Leave E2E off the Tx ring. Per the USB4 spec a Transmit Descriptor
> +	 * Ring with E2E enabled must obtain end-to-end credits before it may
> +	 * transmit, and not every host router delivers them. On ASMedia
> +	 * ASM4242 the credits never arrive, which parks the Tx consumer index
> +	 * forever and makes the link unusable.
> +	 */
> +	ring = tb_ring_alloc_tx(xd->tb->nhi, -1, TBNET_RING_SIZE,
> +				RING_FLAG_FRAME);

Why not simply send revert for a8065af3346e?

>  	if (!ring) {
>  		netdev_err(dev, "failed to allocate Tx ring\n");
>  		return -ENOMEM;
> -- 
> 2.43.0
