Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172549;
	b=dJNBZlchvV81QvL4pdTIoUGEmI1h7TqIY2hUUso31MKVHktXAga0ou9Km+k4m8FD0o2X
	 PVHO2V7E7zz68VLiB2xGObNrYJufi3gkt35DQ1OGrAPxuu3zuprc95tvoZ86WCtKtyapM
	 m9fDPqKiJFcInB2YNg/NGNQKnO49oGNcteGS1gR1d/Oeeugixr04IjmhzNQz4xjPEWskT
	 +whXbI2x/bvkuTZd0oifCj2cVg809pYRXJNbvQrIrHuGjyJ1f591mQ/gMr2osiO0phn0t
	 hcFuYcK1rvLUPMTuwpWKQaAVsnzqG16KJH5C7WI3kvj7O7LqU63aQs3PG6an577CHVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172549;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Iu4QoDLYgmOS+/MkA8YJr1ISuxuT+bHJCCK8i0TgHrQ=;
	b=aQBgCTmVBnpt+ySeNNZdmexwzAb0QzGdpz/AMffLZdU48KQCmDuv29OmBy+QC6hlHVTS
	 Pr1Ip4rreBZxTP5ZAPumGkqA/JHLQCEKm3NEEmyA5/iPe12vlXP8VvP2O3zAvd3WVr5gI
	 yX6B/KLKHm6l4opAZxFp3eia/pvTFrKAHtZlowekrYdHrkLBgiCZP8RuSpDX7u1o3/jZH
	 X6ZqERVZN5c7MwVhakEh38HDy0BT6PE4cVgaTheLlNxU67ki7le4Dalxj6uNq0zDbcqoq
	 niBCGU9WnfbaLf6evP6Gy5qMBLYKpt9+pAGO3+sKw123olGzJ+f+e3oHUBJ/itzzwaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=o92o7PzT;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84050606A31C;
	Sun,  8 Nov 2026 21:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84050606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=o92o7PzT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794172543; bh=Iu4QoDLYgmOS+/MkA8YJr1ISuxuT+bHJCCK8i0TgHrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o92o7PzTPiCT8OZNd5FgitNTj1ag2yN0n6f8UfYoYFQRYDMpzPd1jIBgL9BwNogNP
	 liF+PZHUSeSfo60NwANo1fgmpQ5ObP4nIHyGpcxQ/yQcLdRo/Doxk6Q8ZnVp2xgSq5
	 3+8ENzfX/tmzIPsNp8CwauqrzAdgC5guNYA1aNFbvp55y8ZLxaefmu7FyBxgieWqrd
	 WrJWIqeRizwLBkNg3dSUUFzgsXjtKJHmH7SjZiiz0MFnjYMI35K1GtIzOgMk/7bZbW
	 WWgThmyvVSMOjWr9Jel+Ucd5UeX/u3M27VbP2OfF/EMl7exi7/8gc6Qnl5McBoedGn
	 B8tE1EuwSQaUw==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id CA2FD27A53FD;
	Sun, 08 Nov 2026 23:15:43 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: netdev-bot+sashiko@kernel.org, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: ethernet: mtk_eth_soc: add 9K jumbo frame
Date: Sun, 08 Nov 2026 23:15:43 +0200
Message-Id: <patch-85762b9476cfa21ef2c3e99899a3be9c@loljews.com>
In-Reply-To: <179408883078.994134.17583422873503660321@kernel.org>
References: <patch-cb77640ba129138f860134f54fa345aa@loljews.com> <179408883078.994134.17583422873503660321@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Thanks. All ten findings are valid; v3 fixes them.  The same applies to the
two findings in the review of 1/2.

- XDP: mtk_xdp_setup() and mtk_change_mtu() now compare the shared
  mtk_rx_buf_len()/eth->rx_buf_len against MTK_PP_MAX_BUF_SIZE, so a
  program can no longer attach when the rings have no page_pool, whether
  the large MTU is set on the same MAC or on another one.
- Every SoC: the RX buffer floor stays at 2K, so MTUs up to 2K keep
  working at runtime, DSA user ports included, and mtk_change_mtu() now
  rejects only a change that needs larger buffers (-EBUSY on growth), so
  lowering an MTU no longer locks the port out of further changes.
- MT7628: the 1518 max_mtu branch is restored; dropping it was not
  intended.
- Commit message: corrected. The series does not include the runtime
  reallocation, and mtk_hw_init() uses the shared length now, so the
  description matches the three call sites.
- PDMA RX SDL: the field is masked and replaced instead of OR-ed, so it
  no longer accumulates across opens.
- XMAC_RX_CFG2: read-modify-write, so the bits outside the length field
  survive.
- MAC limits: rewritten on every mac_config(), so a reopen after a
  smaller MTU narrows the MACs that still carry the old limit.
- Order-2 buffers: acknowledged as the cost of the downstream design and
  documented; the unused QDMA ring carrying half of it is a separate
  follow-up.
- Comment and commit text: fixed.

The page_pool gate in 1/2 is also changed as suggested there: it now
tests ring->buf_size <= MTK_PP_MAX_BUF_SIZE, since frag_size is computed
with the netdev_alloc_frag() layout and does not describe what the pool
can map.

v3: https://lore.kernel.org/all/patch-aad4cfa8d9522d1f7dbc9893ea12e813@loljews.com/

pw-bot: cr

