Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F5243F09C
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213307; cv=none; b=NmfICQQVKs9ewXRx/eVpEZnIzamSNvyzxCcSvCGgk02OILBd39orLEobRoG1Xwzk1MBBWrsNReMd0MHYXfBI04udGTe5NnuAgx/jZidDVIspT9cLgnfJh/C3AcmiBa2CpDfl19hundartlQwGauVKih22gg0Fi0zjjLNgV0u6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213307; c=relaxed/simple;
	bh=PzPOdtSRatLk2sh8Cin6RJmQhl9Sn1TENBs38WGDcuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctUOI4OzRKUEvYn26cN789XcwHo/wwa4YTr5BlcVjVyy1iTE9oFwu/lC/uskNcA1T697ztfsioJ3VFTAoNne8hnuc/4bId+lSXG7WNSKRMjAvYutrOHlJ0Jst6xn3wNOMxSsems4tokaVHyHNZy1UdvywM8QxXw8NX3CGufUb2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEdJlId/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEdJlId/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB9A1F00A3A;
	Thu, 16 Jul 2026 14:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213306;
	bh=Czf14k7ftTZS6V7j8Avn7JQU90cJziYv4NIRJzJUa48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TEdJlId/wyp24ItXGbIjbusAOe/q+F0O9dN0qsaI8F4vcb6jg0a5GaBJ5kqr3UcFx
	 OKnaHlRcu3FMkO1OyUsQiUpudQBowuUQ1pwd1Lr950pflch4XCQmBWH8C8Y9nMrWle
	 KCXUrMt0UQDuc/Ix8ksIclH0sseXtFrHv1sKH7pn3LmjUqWJE9MMVHTpEbr6k/p/e9
	 9DUvE887PYfm1tMb2oKxYMwgtYffCU79qEg3Tg6P2rvmADG1RLB1MZWklFj9pZoqdV
	 +hNX2L+DgrTlvmKi5buh3PIjJpM96B6M7yY+0AUe3PLGHBvraJGn02JCkslhmCYUIz
	 5tp2ucegHIE0w==
From: Simon Horman <horms@kernel.org>
To: alice.kernel@fastmail.im
Cc: Simon Horman <horms@kernel.org>,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lucien.xin@gmail.com,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	dsahern@kernel.org,
	razor@blackwall.org,
	shuah@kernel.org,
	stfomichev@gmail.com,
	andrew+netdev@lunn.ch,
	fw@strlen.de,
	netdev@vger.kernel.org,
	alice@isovalent.com
Subject: Re: [PATCH net-next v9 5/9] udp: Validate UDP length in udp_gro_receive
Date: Thu, 16 Jul 2026 15:48:06 +0100
Message-ID: <20260716144805.336424-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710134242.216538-6-alice.kernel@fastmail.im>
References: <20260710134242.216538-6-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [5]: [PATCH net-next v9 5/9] udp: Validate UDP length in udp_gro_receive ---
commit f1316d873c7549e0a49dc98d7614be1dc5b0f66c
Author: Alice Mikityanska <alice@isovalent.com>

udp: Validate UDP length in udp_gro_receive

This patch adds an early check for malformed or padded UDP packets with
len=0 at udp_gro_receive to exclude them from GRO, moving the check out of
udp_gro_receive_segment.

> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 4f9a3922937cc..8f77c8788f6db 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c

[ ... ]

> @@ -782,8 +778,14 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  	struct sk_buff *p;
>  	struct udphdr *uh2;
>  	unsigned int off = skb_gro_offset(skb);
> +	unsigned int ulen;
>  	int flush = 1;
>  
> +	/* Do not deal with padded or malicious packets, sorry! */
> +	ulen = udp_get_len_short(uh);
> +	if (ulen <= sizeof(*uh) || ulen != skb_gro_len(skb))
> +		goto out;
> +

[Severity: High]
Could this early return bypass inner GRO flow matching for padded UDP tunnel
packets?

When a padded UDP tunnel packet, such as a small TCP ACK inside VXLAN or
GENEVE, arrives in net/ipv4/udp_offload.c:udp_gro_receive() while previous
packets of the same inner flow are held in the GRO list, the
ulen != skb_gro_len(skb) check evaluates to true and triggers the goto out.

Because the goto out path yields pp = NULL and flush = 1, dev_gro_receive()
passes the new padded packet to the network stack immediately, leaving older
packets stuck in the GRO list.

Before this change, the packet would reach inner GRO handlers (like
tcp4_gro_receive()) which would detect the sequence or padding mismatch,
set flush = 1, and return the held packet via pp = p. This ensured older
packets were flushed to the stack before the new padded packet, preserving
delivery order.

Will bypassing this inner flow matching lead to out-of-order delivery for
the inner protocol, resulting in duplicate ACKs and throughput degradation?

>  	/* We can do L4 aggregation only if the packet can't land in a tunnel
>  	 * otherwise we could corrupt the inner stream. Detecting such packets
>  	 * cannot be foolproof and the aggregation might still happen in some
