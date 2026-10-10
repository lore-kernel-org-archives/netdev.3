Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF12371CF8;
	Sat, 10 Oct 2026 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619127; cv=none; b=syBeReX98wkV4dPO9HIyZUVxkgAHLm1fnJFmS1YQlP5QdrqP53mX/2WcxC0ywR1ghDkKw4mk8RscnoTPA/7DnacrA0YEmVkcjr+8KCbv5ubq90oMVr6g+pTpF/7LqWYxqpcM6whAln7YXzHzVjZzg+yi/mihXWvGNstvP5k0ftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619127; c=relaxed/simple;
	bh=cQNoY7GCF+8dP7AlXyh733Cm+Thv2UqXPBf8rQPTwx8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=glAkBiYVeLQggk6txfVo9UiGNgQc9Hp4bS7OanEtL8mdlwLLIh8fl/sBz4X7T5oSLPGmNsz7rbcJ2nA5/wnT9KBW0uTlwu8OIPmxPgmWHgB/VL6raf4YU9LKcGa3Yj/D9JyxKL0iRo0/tOEe88H0ubdzMhXVvMjtEyU/pgzL1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdXHQJ6+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdXHQJ6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7641F000FF;
	Sat, 10 Oct 2026 07:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791619126;
	bh=ihM+8OF/a7XmMt1k/YOV5m6YdEX835YCfzjT9xgUihI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PdXHQJ6+jFAi7Q0fuGEhU6RIwL2UCbG47pKaUKkTkGAVRMIZwqJKvpioOmZYl0M22
	 wCYDOCPyK6E1UBjtZtgH1ojZG/dZwMtj3CTV9wqMxrP2rJHCtoS3S+YrYriwbF7AG8
	 P0AfOYjdj7Sd9mv7BJBE+6PTHVHjNzPiLj9IFYslhjk7zFRjyt1pawGGJv6ZvAD0ZV
	 YybNv6fhAlRgPdWzBXRF06aicJtdjwSkWcwc9rwVtprSqlsHNN56q+AVzWfmqbnltp
	 P9GRJ7SrNE+IVyjF+6jgpLbsYFKOQZjOycLfhglZGCHXsGuN1L10ZEDzYvdnxUe9mh
	 PnPIckmC8Z44w==
Subject: Re: [PATCH net-next v2 5/6] net: ftgmac100: Add AST2700 upper DMA
 address support
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 07:58:44 +0000
Message-ID: <179161912453.434549.9464928131713010335@kernel.org>
In-Reply-To: <20261006-support_ast2700-v2-5-36de51fb8066@aspeedtech.com>
References: <20261006-support_ast2700-v2-5-36de51fb8066@aspeedtech.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] struct ftgmac100_txdes in
  drivers/net/ethernet/faraday/ftgmac100.h still says `__le32 txdes2; /*…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but TX
  completion has no consumer-side read barrier to pair with the…

--

net: ftgmac100: Add AST2700 upper DMA address support

This patch programs the high RX and TX descriptor ring base registers on
AST2700. It also stores DMA address bits 34:32 in rxdes2/txdes2 and
rebuilds the full address from both words before unmapping. A 35-bit DMA
mask is requested, and all of this is gated by the new
FTGMAC100_QUIRK_DMA_35BIT match-data quirk.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 2d029d1262e6f..af2e272f32f2d 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c

[ ... ]

> @@ -672,9 +686,14 @@ static void ftgmac100_free_tx_packet(struct ftgmac100 *priv,
>  				     struct ftgmac100_txdes *txdes,
>  				     u32 ctl_stat)
>  {
> -	dma_addr_t map = le32_to_cpu(txdes->txdes3);
> +	dma_addr_t map;
>  	size_t len;
>  
> +	map = le32_to_cpu(txdes->txdes3);
> +	if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
> +		map |= (u64)FIELD_GET(FTGMAC100_TXDES2_TXBUF_BADR_HI,
> +				     le32_to_cpu(txdes->txdes2)) << 32;
> +

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. The new
txdes2 read goes through the same TX completion handoff as the existing
txdes0/txdes3 reads, and that handoff seems to have no read barrier on the
consumer side.

ftgmac100_hard_start_xmit() fills tx_skbs[] and txdes1/2/3, sets OWN in
txdes0, and then publishes the producer index:

	dma_wmb();
	first->txdes0 = cpu_to_le32(f_ctl_stat);
	...
	smp_wmb();
	...
	priv->tx_pointer = pointer;

On another CPU, ftgmac100_poll()->ftgmac100_tx_complete() runs:

	while (ftgmac100_tx_buf_cleanable(priv) &&
	       ftgmac100_tx_complete_packet(priv))
		;

ftgmac100_tx_buf_cleanable() loads priv->tx_pointer. After that,
ftgmac100_tx_complete_packet() loads txdes0 and tx_skbs[pointer], and
ftgmac100_free_tx_packet() loads txdes2/txdes3. Nothing like smp_rmb()
sits between the tx_pointer load and the descriptor loads. The smp_mb()
after the loop runs too late to help.

On weakly ordered SMP CPUs such as ARM/ARM64, can the txdes0 load be
satisfied before the tx_pointer load? If so, it could return the stale
OWN-clear value left by the previous completion, and the slot would be
reclaimed while the device still owns it.

That could unmap a buffer the device is still reading. It could also
dereference skb->len through a stale NULL tx_skbs[] entry.

ftgmac100_poll() keeps NAPI scheduled while ftgmac100_tx_buf_cleanable()
is true, so completion can run on one CPU while xmit runs on another.
Would an smp_rmb() after the tx_pointer check in the completion path be
needed here?

[ ... ]

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
> index 8c35c895b1465..0c244b1c0a351 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.h
> +++ b/drivers/net/ethernet/faraday/ftgmac100.h

[ ... ]

> @@ -226,6 +229,7 @@ struct ftgmac100_txdes {
>  #define FTGMAC100_TXDES1_TX2FIC		(1 << 30)
>  #define FTGMAC100_TXDES1_TXIC		(1 << 31)
>  
> +#define FTGMAC100_TXDES2_TXBUF_BADR_HI	GENMASK(18, 16)

[Severity: Low]
This isn't a bug, but struct ftgmac100_txdes still describes this word as
reserved:

	__le32	txdes2; /* Reserved */

With this patch, ftgmac100_hard_start_xmit() writes the upper buffer
address bits into txdes2 for the head descriptor and for every fragment
descriptor. ftgmac100_free_tx_packet() reads them back to rebuild the
address passed to dma_unmap_single()/dma_unmap_page().

Could the comment be updated to describe the new field? Otherwise a later
change might zero or reuse txdes2 based on that comment.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-support_ast2700-v2-0-36de51fb8066%40aspeedtech.com
