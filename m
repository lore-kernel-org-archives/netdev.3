Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B183D435500
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213286; cv=none; b=IL+ioCuiog2zAkp9JENKr3pRzQgpgMnGvnZd1zPwPKRUMyuv+Ku/fRigjGHFK6d5BwV8X74Tx1Vh5UcOFhvgsYglY2um5aLDfQDhY3o4aNn4BZ+vLj47cp4Vo+GWVd9RZN3y3ogsKsMTQFQlXOVKAeSEZYyJu89VEEvTt+xBvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213286; c=relaxed/simple;
	bh=dS82IKxh6dT2vnaqyPxVpx/fNPns4Lb0Xn/fyK5/Uhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJwE3F9qrirxBRKZ1VlMmH2TOgvisBRMvTG2iTnJsrZo4HZvJfwQ8E+7hAVcVxE1zBTUOVbfR2HewWThIi8O4CCBzlj4AbVwgR9AKi/XjSjTwG8BAd6fZH4X5ILBdNRbltz0nu+bg1OekXimC8ZNFpYkRXJMcT6E/ogR/Xlt30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxGAc3qe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxGAc3qe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B76E1F00A3D;
	Thu, 16 Jul 2026 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213282;
	bh=TgTPCVhueAGzm5vXeDMT3JCCYmoJUmTV2+c8FcQueGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GxGAc3qeEF2mtzkFQC70GkaUTQNCxRx+o1Sf/07w/AoRn2mf+O8A3CEolZxzvRZKN
	 lii+II21XcbFQ0TOlzTJBy2q/JQvvl9oSUmBbE2H4uVQbiDx9OWi3ej3IsWHYoEuE5
	 XX/nORA/jAGzL7WEwdR2JJt0KveyAGIMZ2mD4B4AsRzWbwMBjOOSlndZp4YFrQKWfT
	 kv7pZ9260LehxhGfw0+/8lppnSkT83ex4Gftm+BQXwabiFwu9YnpAX1oesfvRqUSHa
	 dyKbJmGCwyWn6jMZldtVf01MIk69AGSZp7hWoiww8Gj1YwpeGBhpQxSRsoO8WG+4YP
	 6SeyxtD2ZQgdg==
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
Subject: Re: [PATCH net-next v9 4/9] udp: Support gro_ipv4_max_size > 65536
Date: Thu, 16 Jul 2026 15:47:43 +0100
Message-ID: <20260716144742.334586-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710134242.216538-5-alice.kernel@fastmail.im>
References: <20260710134242.216538-5-alice.kernel@fastmail.im>
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
--- Patch [4]: [PATCH net-next v9 4/9] udp: Support gro_ipv4_max_size > 65536 ---
commit 6dfda0f76318408b2e2b33603d561940b926529c
Author: Alice Mikityanska <alice@isovalent.com>
Subject: udp: Support gro_ipv4_max_size > 65536

This commit fixes UDP GRO aggregation for packets larger than 65536 bytes
by setting the UDP length field to 0 during GRO and restoring the true length
from skb->len in udp_rcv().

> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 493e2b9e16fbc..4f9a3922937cc 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -919,7 +919,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
>  	struct sock *sk;
>  	int err;
>  
> -	udp_set_len_short(uh, newlen);
> +	udp_set_len(uh, newlen);

[Severity: High]
Does setting the UDP length to 0 here (for packets > 65535 bytes) break
software segmentation?

In net/ipv4/udp_offload.c:__udp_gso_segment(), the code adjusts the
pseudo-header checksum by subtracting uh->len:

    check = csum16_add(csum16_sub(uh->check, uh->len), htons(newlen));

If uh->len is 0 for BIG TCP packets, this subtraction will fail to remove
the true 32-bit original length from the checksum.

Similarly, in net/ipv4/udp_offload.c:__skb_udp_tunnel_segment(), partial
GSO relies on uh->len to negate the old length:

    if (skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL)
        partial = (__force __wsum)uh->len;
    else
        partial = (__force __wsum)htonl(skb->len);
    partial = csum_sub(csum_unfold(uh->check), partial);

Will forwarding BIG TCP over UDP packets that fall back to software
segmentation result in corrupted checksums for all generated segments?
