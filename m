Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760425;
	b=wOPvCIC9Hbs6KpKVMfcv5DTCiiSOwa0k0pS6Qqh98KaiuOvV1nw1XMh28F8Yc3bvQnh6
	 PLDoeRraf/JxkANRpHKrdTrHcEAt0xkXzeEVSCQV8D5m1PWT9Xq3hqC0WOLupuqS56JhA
	 RfrAnCqKhf1cfyO0YSDZ/vCUt2GLf/ETAgX2SjAs3YzJhrdvtztZgDG1+kKrSjknpJB7k
	 A0MUEw+7WytLDoiXtNJdNorv1z+Ybuor6gHfo0bUlKrVMh0CCU8wLfp7s2I8ohsAG7dyU
	 yPdfFU1rp0hQsjN5f0YvzfP3Fdi4Ywecxbp4rO4jX+4mPmzd+Fayb7eKQLi+M3NMUrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760425;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Zl5pLkUydRuIR6YXYymKP7PujdRxecXVpxWXkRO589g=;
	b=Wy2uFBM2kr8HE5nSf2h3sx0c2bqnE9MgYM1GV1YQn6lAID7486xFuwP3JTyfsRXbtfJy
	 q+CfZCAObAX9egXgq46FQpkL7mPOG1TWeEzuLB1CTg2Guv/cZhY5UrkvDUv7pZONDv7a+
	 wkMWPR8ZfDPFigqtyR1ImiXMtYWGYSA3Ylq9RDT4s3jiH2I503Z/YfChLIrjZTidRV6WD
	 ALNgicu6YsAAsGeLMVUCJRiTtAvNK7COP1vkC8zT6j/Ddrec0BI4xrQXdtFyNKKZzjnXa
	 ckn9zKKHgc/U1QIrAQo3KbIO9g8uKY/N9gWyF1D7RwWa/hhrFNWthbcQ5DKCxCEp+Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0WgrZG+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7302C606A31E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0WgrZG+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425491F031E9
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760425;
	bh=Zl5pLkUydRuIR6YXYymKP7PujdRxecXVpxWXkRO589g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a0WgrZG+/FGfspkK7aqmYHFYSSMVPmRIWP6Dl2hoMcWRgBRlpjKIr+Pv061Icp0SE
	 BMWuCcyq24yIS0o9UYcZBrTk3XwABZBIDu8YFRkOmSBNdglR3arWjEiVQQxAQhlA89
	 R2XO3cKjRKcJF2i69pQhccVTRfqceWxCI+eJj4aMi2+nFOWb/wXZM6VvGdMubRSs9+
	 UM56Q09fTV52Cswz4XQp6Xk6x7rFVjyxW2j+BeQBC84pW2eNtCVDkjfxzNdA1HNMMM
	 v2vr2JASoJRsr3U3fPtdhbTcqixYZKl5BLZKkmbMQSHkalXWp7gc0bBNnOGcFOYLj5
	 vvcH1L96HnKYg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4a76f63b243so1417308fac.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 06:00:25 -0700 (PDT)
X-Gm-Message-State: AFq9FYLtZGN9DjeEvJ1VFpxuFALt6+DpKUorXhEVNceBZfGeHAETJtjY
	/EmwwBhnkBJGzy/V4ZxRpVPukRkWy2uBYTLjUBR+tfqJwAOhn7pxlPPfL0jDpFxpTMNfuQz02fG
	oS91uJqRJwiAf0/9yLT2jKtAcI8nYJpc=
X-Received: by 2002:a05:6870:8264:b0:470:e96b:43e2 with SMTP id
 586e51a60fabf-4a8223efc18mr814148fac.14.1792760424478; Fri, 23 Oct 2026
 06:00:24 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 23 Oct 2026 15:00:13 +0200
X-Gmail-Original-Message-ID: <CAL4Wiip2h1yRQ=WP6eL6Has0tK204PXDP1GnhmJc8Jvvz_o+7A@mail.gmail.com>
X-Gm-Features: AclHuK-s2_zfIqkfP574i6yy4BjuRsx0dQx-WTwQQlxkrc12tbwL7CENfyappz4
Message-ID: <CAL4Wiip2h1yRQ=WP6eL6Has0tK204PXDP1GnhmJc8Jvvz_o+7A@mail.gmail.com>
Subject: Re: [PATCH net v2 1/6] net/sched: act_vlan: pull the inner Ethernet
 header after POP_ETH
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Guillaume Nault <gnault@redhat.com>, Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, 
	Ren Wei <n05ec@lzu.edu.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jason Wang <jasowangio@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 23 oct. 2026 =C3=A0 13:59, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> The issue:
> act_vlan POP_ETH removes the outer Ethernet header and leaves the inner
> Ethernet header at the head of the packet.  A non-linear skb can have the
> inner header in a page fragment, so a following eth_type_trans() may find
> less than ETH_HLEN bytes in the linear area and BUG in __skb_pull().
>
> The Fix:
> Pull the inner Ethernet header into the linear area after skb_eth_pop():
> drop the packet only when pskb_may_pull(skb, ETH_HLEN) fails.  This keeps
> valid non-linear packets whose inner header sits in frags.
>
> Conditions to recreate the bug:
> - egress tc filter on lo: action vlan pop_eth.
> - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-linear
>   eth / inner-eth frame.
> - The inner header is in page frags; a following eth_type_trans() can BUG
>   in __skb_pull().
>
> Fixes: 19fbcb36a39e ("net/sched: act_vlan: Add {POP,PUSH}_ETH actions")
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.=
1782548651.git.bronzed_45_vested@icloud.com/
> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.38722ee638a21@=
gmail.com/
> Link: https://lore.kernel.org/netdev/CAL4WiipJLzZ9ywOPaFHZ+wePTOuO+6+aaRC=
VXMHz+xmmQm2hcA@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Thanks!
