Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273384;
	b=0uLsPz893mEM+Dkyf8AB3GyY1gOrePfPZwnQZWzWJRO+aTXtmuGYPExhe89TEasQRM4U
	 BSNpe21WXATCwq3PPCNPet73eyKbknseXJmq8GlOC8SW3R4E36ukNlLM9O5ij79oTXEit
	 9flqfVIl+gBeuDRdno0v90TGBAdBg7bA9vnuI36nZkxsYzpbRZLJdZv8o/nlrfuMGBO3c
	 enXZxZVT42uzeLZPNYTLFQ2Bw/5Kp+AExTlURZ/vEkFOjHpRFoBBAMoUC9Xp8ZtGzyGa1
	 Id7v7kGDCWjOigg2DI8HF9kh4QLzkk2H/Iuln33U1hvnhlAvymbktYaP9UJDTrxAEhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273384;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8gdsAac7EZ5+OsPs0/iF0968xFaiXNDS5Q1WdBd14vI=;
	b=mIQRxBSucgWnaY+zj7z2hFjAh2LdldIe1TgfTvRHvf86iurxtFwbvZ63KwuajBwRYmxe
	 3I+ozBHMmzkSN8vebM2tfjf3iK5SsnUOhGY4Bp//nKNnvoARSGJZ6nv75niucXTH1KQ3Y
	 oHRFDrAmdrHDl9HiuxicSjiXsxim/YgFP78PngZ8Fw+u/K4Nq3WaAvbb6Nnthjx+f5aQQ
	 Z5GCKtdjD5RiRvxQWwO/yjrxba0omBDiWnPdKfHEr+EXp9nvtCvLY/ojbao91g+ytpdy/
	 rnRpWKruRcnl8fn/58L7Ox8vkuNL5htUpy2JWmqLPvsjQTLwmjQc7vsNFfubXL5wk4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTRvFRJv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A32060A2621
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTRvFRJv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25361F008A3;
	Tue, 10 Nov 2026 01:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273384;
	bh=8gdsAac7EZ5+OsPs0/iF0968xFaiXNDS5Q1WdBd14vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QTRvFRJvoIz73nL+QfsKwibX47lCk4d++i0Mz32Ys9nnUjAjNT5jUqyhOSpX13f2O
	 7n9zRWNJFl6CaZJvMXU2L4pcBnr31L74cTkv3xBqfixDNF6zRWZtm18Kfwz614DQ+v
	 CNyjucvd5TC9EKcn8GxyzzC18eDZmaPOuCTjbWpdUyn19c9QIUI3p0lcrIkUdjQmKu
	 zkdrT5GuSK8t/3XeXVHlUls9DEiVGOWUk+yQdAkAzIT8PbYkXd2LfUE6yLEUK7FMrW
	 6w8HNeIL5afJC6mVQ7mEl/q8tcKVSx3K/M1TnDv3T8ssefw4vjRPHuAqkKbDXe+LXs
	 IlgL4i5/5MB5Q==
From: Jakub Kicinski <kuba@kernel.org>
To: linusw@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	ulli.kroll@googlemail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com,
	mirq-linux@rere.qmqm.pl,
	mhun512@gmail.com,
	edumazet@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 14/15] net: ethernet: cortina: Scope RX statistics updates
Date: Mon,  9 Nov 2026 17:16:23 -0800
Message-ID: <20261110011623.1733622-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-gemini-ethernet-fixes-3-v6-14-c4b5ff8a65d8@kernel.org>
References: <20261103-gemini-ethernet-fixes-3-v6-14-c4b5ff8a65d8@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: ethernet: cortina: Scope RX statistics updates

This patch narrows the rx_stats_syncp writer sections in gmac_napi_poll()
so they no longer span gmac_rx(). The writer sections now wrap only the
individual counter updates in gmac_skb_if_good_frame() and gmac_rx(). It
also adds u64_stats_init() calls for the tx, rx and ir syncp objects in
gemini_ethernet_port_probe().

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 5e89057bb2fb6..c32e9574c8c95 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -2863,6 +2872,9 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
>  	}
>  
>  	port = netdev_priv(netdev);
> +	u64_stats_init(&port->tx_stats_syncp);
> +	u64_stats_init(&port->rx_stats_syncp);
> +	u64_stats_init(&port->ir_stats_syncp);

[Severity: High]
This patch didn't introduce this, but since it touches tx_stats_syncp:
can the TX reader loop in gmac_get_ethtool_stats() write past the end of
the ethtool stats buffer?

drivers/net/ethernet/cortina/gemini.c:gmac_get_ethtool_stats() {
    ...
	/* Racing with TX start_xmit */
	do {
		p = values;
		start = u64_stats_fetch_begin(&port->tx_stats_syncp);

		for (i = 0; i < TX_MAX_FRAGS; i++) {
			*values++ = port->tx_frag_stats[i];
			port->tx_frag_stats[i] = 0;
		}
		*values++ = port->tx_frags_linearized;
		*values++ = port->tx_hw_csummed;

	} while (u64_stats_fetch_retry(&port->tx_stats_syncp, start));
}

The loop resets p at the top of each pass, but the body writes through
values++ and never uses p. After the first pass, values points at the end
of the GMAC_STATS_NUM u64 array.

ethtool_get_stats() allocates that array with
vzalloc(n_stats * sizeof(u64)). If u64_stats_fetch_retry() forces a
retry, the next pass writes another TX_MAX_FRAGS + 2 u64 values (144
bytes) past the end. Each further retry writes another 144 bytes, and
nothing bounds the number of retries.

Gemini is 32-bit, so the seqcount is real there. A transmit that runs
during the read can bump tx_stats_syncp and trigger the retry, for
example:

gmac_start_xmit()->gmac_clean_txq()
    u64_stats_update_begin(&port->tx_stats_syncp);
    port->tx_frag_stats[nfrags]++;
    u64_stats_update_end(&port->tx_stats_syncp);

ETHTOOL_GSTATS is one of the commands that does not need privileges.

This loop has two more problems. port->tx_hw_csummed is read under
tx_stats_syncp, but gmac_clean_txq() writes it under ir_stats_syncp:

	u64_stats_update_begin(&port->ir_stats_syncp);
	...
	port->tx_hw_csummed += hwchksum;
	u64_stats_update_end(&port->ir_stats_syncp);

So this reader has no protection against torn reads of that counter.

Also, the reader clears port->tx_frag_stats[i] = 0 outside any writer
section. That races with the tx_frag_stats[nfrags]++ in gmac_clean_txq()
and can lose increments. It also resets the counters on every read.

Should the loop write through *p++ like the RX and MIB loops above it,
read tx_hw_csummed under ir_stats_syncp, and stop zeroing tx_frag_stats
from the reader?

>  	SET_NETDEV_DEV(netdev, dev);
>  	port->netdev = netdev;
>  	port->id = id;
