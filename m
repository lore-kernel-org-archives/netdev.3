Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F2A363C5F
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581399; cv=none; b=CfXnr/2vvoHtr7yGP/c7sopaGRCDfgdXSF8sUtws2LhmfZoPDodqeIHiaM9id35rXkHY526C26iMC13d0wPeTZibWQELxIjFIByqoQzyXeFYnVRVOUeeruDlJ2P6a2H0/D4//i09o+Dkd6A6zxgzRuMWABMnMBiJIYlA0rzahoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581399; c=relaxed/simple;
	bh=oma0ZYbgO1ix4cNdhw6QgRg7zo6QLKFCq2yr/Mi62Og=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcKyHrNPlOa7o9NliEQi5G46pRg/dQ4ZMF6qJXfSjZCk2hrnIDuJus1EeYcC+EZBY0p6TBQgpN2VG44wD1JJpWkrkwNGeFfMNuL6THYw8HPM6WB9TCqpbopP9GRrZZQJxqqxVFN6pWa28EvKq93bK2JK5qdJsQ43tOPiGhNMVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEluFGmh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEluFGmh"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4998590d392so12969135e9.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787581396; x=1788186196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MBIde6Y7JOCXOPgJcdPnOWn/cKDT3PrajChSHP+TKKI=;
        b=iEluFGmhFaQn/wfpHpmcXb/R2htE2YGClldktVw6KLz4MWt+crKp1N0PzJk+tOdoGg
         cfAmwufx/v8HCiA7CsSwX4HUpGHnuxjYCgZspskDMskKnKgZA0Lw1Xic1yE7XVjRodPd
         81IA/M2E/nt5yvxXNDdCz+7zmg81sPdbtjq4DnT+oqsRySdNpqzi9ZWVuf4Dd76PqynR
         3WzaguLytz7iFYY98FF7ab48SRCYNDvQybTzaAOUS2wBTkkpNdFG5uE4imtuF5rmW4H0
         YvRJKCaFUuzLKgw1Mq49ODTr08pFJTFxoNkRWTtoaTSTD4iYbPWuhISbp2dlNte6U688
         4y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581396; x=1788186196;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MBIde6Y7JOCXOPgJcdPnOWn/cKDT3PrajChSHP+TKKI=;
        b=WvyqJ3PGVjYrfkJvoRVRM/wHz5uUONJCQEu9xGkxfl0geM6WjH5+E/8xsUNZRsERZu
         kIH4ujI/eZU67aYkwTH9fbfCS4jTKX/xowcQj5wYXUPfCPnk++Cc08GMluymJ8m1HztT
         RojnY+Wus/VL88cVtshfM2uEt14H3tqTsOXuLl9FT/7bmfk4SQHtPoj9Kdopg++xTUHG
         QqP+rV8lJoBXy/ZKrZZsnSFB5OExxQYJ/LKM+AuhRDjRgT7S4DqWcxMLjiwrf31Hcmdh
         ly8lV8KJwDkW3fUXLzK84kNahobh1s68NDnDRwwB2IopjnZPswX7Slcz5Spxct1hrShg
         t2nQ==
X-Forwarded-Encrypted: i=1; AHgh+RpRgKyWkkD1kvaPXkMTdEmRBXF9XyKBlB1H2k5NrPKKCunLtn8FJ35WVfn07zxJDcVQ1s76aHo=@vger.kernel.org
X-Gm-Message-State: AFuF++lmn7e556WcgGLYatlpTtfTfDuHGfRO8jZidy0rcM93i/g8R6kj
	gKJKZg2qcYmjOGbBaa1nC2BSALdNYyq4CYN9rd0MvYlYS55evRdIk4i/
X-Gm-Gg: AR+sD10GTWVYrdQ1eUOXPrtONezlQg3hVpvAVkjoZCET899UWGTufTFT3imJpA5A9Ke
	C5/G8JAdLQHI9iRgybhjz4CCznh02MYm0h1VdKIxfDP6wrXNyzTvPkvr2GldHSd2TWMbsQYZJ0r
	lzLJ9CUyVJdp87v8CJpXSGhv7AYKPiEOyd9SK40oTypSYAwVbaeKv3BbMxjSDXY2RaJiHTFs90E
	mLPCX8i9TFqmhozuEWzq/RCDYdaZ1OX/5HGTi+81d0CykCcWb7oQ7leBl1OTAAqa3B+92iHs/yx
	oFPmMoG2BmvAt0SKO3E5y9tBbtY6hW5Q8hArOoXNA2q6KDJx3wdokFrV7iB7Os/enBnN405jEuJ
	3Ncz//RnkBW8BwX1Yv0uUi0fCozBTsguY2+YO/bSS6MWWrgAeztGpTewcNFn6+4qogdJBVavKc7
	86QyZCSFOhkPTbyPfl4w/tMPDDObbUJDMlGGP0SF4w/xeDk1JF36uFoHPNR0OVr2fRU3Zh/NS7n
	2Asjy9Cz/75GvkmUQqTfq4mshutPW5Dkic/
X-Received: by 2002:a05:600c:46cb:b0:499:a277:e8b5 with SMTP id 5b1f17b1804b1-499b82d2865mr316509465e9.3.1787581395952;
        Mon, 24 Aug 2026 07:23:15 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c35935f5sm63148625e9.2.2026.08.24.07.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:23:15 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:23:12 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pascal Kneuper <PKneuper@dspace.de>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, 0x1207@gmail.com, si.yanteng@linux.dev,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 DBaldin@dspace.de
Subject: Re: [PATCH net v2] net: stmmac: restore NET_IP_ALIGN in the RX DMA
 offset
Message-ID: <20260824152312.3f6dd2b7@pumpkin>
In-Reply-To: <20260824125014.47862-1-PKneuper@dspace.de>
References: <20260813092923.284285-1-PKneuper@dspace.de>
	<20260824125014.47862-1-PKneuper@dspace.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 14:50:14 +0200 (CEST)
Pascal Kneuper <PKneuper@dspace.de> wrote:

> Since the RX path was converted to zero-copy, the page pool page is handed
> to the stack directly as the skb head, and the offset the DMA engine writes
> at is what determines the alignment of the packet headers.
> 
> Before the conversion the payload was copied into an skb obtained from
> napi_alloc_skb(), which reserves NET_SKB_PAD + NET_IP_ALIGN. The
> conversion moved the headroom into stmmac_rx_offset() but did not carry
> over NET_IP_ALIGN, so on architectures where NET_IP_ALIGN is 2 the IP
> header now lands misaligned:
> 
>   64 (NET_SKB_PAD) + 14 (ethernet) + 20 (IP) = 98
> 
> Same for the XDP branch:
> 
>   256 (XDP_PACKET_HEADROOM) + 14 (ethernet) + 20 (IP) = 290
> 
> On ARM32 this is fatal, because ldm and ldrd trap on unaligned addresses
> even when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set.

I suspect an alternative is mark the structure(s) as __packed
when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set.
The compiler will then only use 'normal' memory instructions which
won't fault.
OTOH aligning the buffers is likely to be better.

David

> 
> Any received echo request panics the machine, e.g:
> 
>   Unhandled fault: alignment exception (0x001) at 0x81873062
>   Internal error: : 1 [#1] SMP ARM
>   Hardware name: Altera SOCFPGA Arria10
>   PC is at icmp_echo+0x38/0xa8
>   LR is at icmp_rcv+0x22c/0x370
>   Call trace:
>    icmp_echo from icmp_rcv+0x22c/0x370
>    icmp_rcv from ip_protocol_deliver_rcu+0x2c/0x224
>    ip_protocol_deliver_rcu from ip_local_deliver+0xc8/0x1a0
>    ip_local_deliver from ip_sublist_rcv_finish+0x3c/0x50
>    ip_sublist_rcv_finish from ip_list_rcv_finish+0x110/0x118
>    ip_list_rcv_finish from ip_list_rcv+0xc8/0xdc
>    ip_list_rcv from __netif_receive_skb_list_core+0x170/0x1c0
>    ...
>    napi_complete_done from stmmac_napi_poll_rx+0xcb0/0x1030
>   Code: e24dd068 e59020a0 e28dc010 e0822001 (e8920003)
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> The faulting instruction is the ldm of *icmp_hdr(skb) in icmp_echo().
> 
> Fix by adding NET_IP_ALIGN back to the RX offset, which restores the
> alignment the stack used to get.
> 
> Note that commit a955318fe67e ("stmmac: align RX buffers") made a similar
> change in 2021 and was reverted by commit 12d125b4574b ("stmmac: Revert
> "stmmac: align RX buffers"") because it caused packet corruption. That
> patch raised the offset from 0 without adjusting the buffer size
> accounting, so the DMA engine could arguably write past the end of the RX
> buffers, though this was never root caused.
> Commit df542f669307 ("net: stmmac: Switch to zero-copy in non-XDP RX
> path") since derives the page pool allocation from stmmac_rx_offset(), so
> the extra bytes are accounted for.
> 
> Fixes: df542f669307 ("net: stmmac: Switch to zero-copy in non-XDP RX path")
> Cc: Daniel Baldin <DBaldin@dspace.de>
> Assisted-by: GitHub-Copilot-CLI:claude-opus-5
> Signed-off-by: Pascal Kneuper <PKneuper@dspace.de>
> ---
> v2:
>  - also add NET_IP_ALIGN to the XDP branch, reproduced the same panic
>    with an XDP_PASS program attached (Jakub Kicinski)
>  - retitle accordingly, v1 was non-XDP only
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a71f0df263785..4d4b155d0d931 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1527,9 +1527,9 @@ static void stmmac_display_rings(struct stmmac_priv *priv,
>  static unsigned int stmmac_rx_offset(struct stmmac_priv *priv)
>  {
>  	if (stmmac_xdp_is_enabled(priv))
> -		return XDP_PACKET_HEADROOM;
> +		return XDP_PACKET_HEADROOM + NET_IP_ALIGN;
>  
> -	return NET_SKB_PAD;
> +	return NET_SKB_PAD + NET_IP_ALIGN;
>  }
>  
>  static int stmmac_set_bfsize(int mtu)

