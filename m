Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267066;
	b=teAWmnwz6PQAIgzhSeFUBjnhEHKOI1upeLBniD18NpXfq5+YTCMGPua0pJzn1jGcZSJB
	 y3WAxrzQUB7wBF7690yzsLilil9hxZIiWV4Bjxa7JlW2X2LxWXtIxhCl6H726h5yqxfk4
	 KzS7skAfY194ZJIqDA6TD97xshJOI6qTzsJn62m9vssbOsAxOhk2W7p2lC6sLgHrCozWB
	 TdAJG9+ztDICsJzEMILxDCHBLYBwFJkneMRYqCPPnNDuX15G3f5NYNM7SdyOUjHoSSsT0
	 nPW2tj7z+YKjiOmA/ErZjJvaUvz9ARCvvcLdGsPxve5fJmSVlHzvHPggTX3CZogzKLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267066;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wrgYekDEGb+/CScRnM3QnFImaZtADuXTOFCk5mwUwis=;
	b=GHH3s4PdXNV1xowGOXWWmoA7Gzqr2HT3jtCzQVyciZe80lHCpNMqx8WglUjzMWcXPk2J
	 hHNBOJcyoOyfhU+WylQwPnkR64HWq98yCyzWrqlUs1O/mo93DcX+qLcW+0YkKfkn1/W7a
	 AQuszzpvvUmnEBbll935oKoZHYlG14WtB7u0mWLlq54F3kukpO40ue3cc5DF9uYsJOdDP
	 lG1cfhPjj6SdymWRwf3101hnXBQQkAnCGtBplf/zMF3ZuElRED9QdS4vuvkcEG4oLbp+O
	 bqJM0RvU+GTgxUQmi6NRjgTx68Xoj9veGNBTkw4Wwzz5DwlZqjXRc02vVi8/XaGcZ6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iuOSxdg5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A323606A325;
	Mon,  9 Nov 2026 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iuOSxdg5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810D51F008A3;
	Mon,  9 Nov 2026 23:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267066;
	bh=wrgYekDEGb+/CScRnM3QnFImaZtADuXTOFCk5mwUwis=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iuOSxdg53IAew4vpvEq5weZybvyz4gJmTPGXO+7GwL/UVC7r1lkxwkYTM5Kxri6Wj
	 tx3g4U5VjibgOu6KrFptTVG4r5cZIe/YEkwE+hUoW1ifqVVMrsj+0Pmbl9qS8YRhzI
	 S/8kwZQSc9s6M3drjXBiHtQbZmOSUCWPbbDFrpUPICQFQkuasPlps0itIv8w+3CdQO
	 PVIGSYMMkxNNEby6lO4WfX3qv34wtxYFOsp/CO3enjCgf0rOspG0jd9u1uM5+Ly9nY
	 JopS5jZ4TxOzYn4mqhLYxQ5kyNUJ51O3/5Iov6zD5InIk27fuZxR0wAlLSVbZjvPPG
	 zF7FzrtQQptsA==
Subject: Re: [PATCH net-next 2/6] eth: mpnic: Rx checksum offload
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, dimitri.daskalakis1@gmail.com, mohsin.bashr@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 23:31:05 +0000
Message-ID: <179426706505.994134.14903670095120167303@kernel.org>
In-Reply-To: <20261106-mpnic-lso-v1-2-e943ff1493e4@gmail.com>
References: <20261106-mpnic-lso-v1-2-e943ff1493e4@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The CHECKSUM_COMPLETE value in mpnic_rx_csum() is only right
  on hosts of one byte order.
- [Low] mpnic_rx_csum() (drivers/net/ethernet/meta/mpnic/mpnic_txrx.c)
  sets skb->ip_summed = CHECKSUM_UNNECESSARY and ignores the full-frame…

--

eth: mpnic: Rx checksum offload

This commit adds Rx checksum offload to the mpnic driver. When the
completion descriptor's l4_csum_unnecessary bit is set, the driver reports
CHECKSUM_UNNECESSARY; otherwise it reports the l2_csum field as
CHECKSUM_COMPLETE. It also exports csum none/complete/unnecessary counters
through the netdev qstats API.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index edb087b12a1e2..680625810ec03 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> @@ -655,9 +655,34 @@ static void mpnic_put_pkt_buff(struct mpnic_pkt_ctxt *ctxt, bool napi)
>  	page_pool_put_full_page(page->pp, page, napi);
>  }
>  
> +static void mpnic_rx_csum(u64 rcd, struct sk_buff *skb,
> +			  unsigned int *csum_complete,
> +			  unsigned int *csum_unnecessary,
> +			  unsigned int *csum_none)
> +{
> +	skb_checksum_none_assert(skb);
> +
> +	if (!(skb->dev->features & NETIF_F_RXCSUM)) {
> +		(*csum_none)++;
> +		return;
> +	}
> +
> +	if (FIELD_GET(MPNIC_RCD_META_L4_CSUM_UNNECESSARY, rcd)) {
> +		skb->ip_summed = CHECKSUM_UNNECESSARY;
> +		(*csum_unnecessary)++;

[Severity: Low]
This isn't a bug, but should mpnic_rx_csum() prefer CHECKSUM_COMPLETE here,
since the same descriptor also carries MPNIC_RCD_META_L2_CSUM?

The commit message says l2_csum is reported for every frame, and
mpnic_csr.h doesn't define a validity bit for it. The comment in
include/linux/skbuff.h says:

 *   - Even if device supports only some protocols, but is able to produce
 *     skb->csum, it MUST use CHECKSUM_COMPLETE, not CHECKSUM_UNNECESSARY.

With the current ordering, every TCP/UDP packet that the device validates
goes up the stack without skb->csum. Anything the hardware L4 engine did
not check then needs a software checksum. One example is the inner
payload of a UDP tunnel when the checksum conversion path doesn't apply.

The in-tree fbnic driver uses the same pattern in fbnic_rx_csum(), so
this may be intentional. It still doesn't match the documented contract.

> +	} else {
> +		u16 csum = FIELD_GET(MPNIC_RCD_META_L2_CSUM, rcd);
> +
> +		skb->ip_summed = CHECKSUM_COMPLETE;
> +		skb->csum = (__force __wsum)csum;

[Severity: Medium]
Is this skb->csum value correct on big-endian hosts?

mpnic_clean_rcq() converts the descriptor to host order first:

	rcd = le64_to_cpu(*raw_rcd);

So the u16 that FIELD_GET() extracts from bits 47:32 is the same number on
every host. A __wsum, however, is computed by csum_partial() using
host-order 16-bit loads. The correct value therefore differs by a byte
swap between little-endian and big-endian hosts, and storing the raw
field can only be right on one of them.

The MPNIC Kconfig entry only has:

	depends on 64BIT || COMPILE_TEST
	depends on !S390

That still allows ppc64 BE, sparc64 and mips64 BE builds with PCI_MSI.

On such a host, would every good packet reported as CHECKSUM_COMPLETE fail
validation in __skb_checksum_complete()? That would end in
netdev_rx_csum_fault() and "hw csum failure" messages. Decap paths such as
skb_postpull_rcsum() and pskb_trim_rcsum() would also adjust from a wrong
base.

Would a conversion that keeps the device's byte layout help here, for
example (__force __wsum)(__force u16)cpu_to_le16(csum)? Alternatively, the
driver could be restricted to little-endian hosts in Kconfig.

> +		(*csum_complete)++;
> +	}
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-mpnic-lso-v1-0-e943ff1493e4%40gmail.com
