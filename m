Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988786;
	b=ENlNRplp0wILK/RbG29diDQJXKmZrusCsD+SXqS0xgDT51PgpnsZMBispseP2mjRP7ss
	 HxWizHJmbVWdsJIw/QRnS4wKGZGpB9shFdqZXbsBOpFySV1kZ5n5CJyglA7o2RxfiXRZ4
	 gQu+CRjbw4IvV1NTAmR+hR55tbYDp8ookHuCgNqBM7fhG5Rc28xNfcxPQBBd29snx3KF9
	 VK8z/sot/w21Eb3eTFf/+VYcEDW+dzKOh+75+driGMEeZ5XVCpfv/YrBN2SKyeZtBGYZH
	 rTsHvbOiCQpu338wNBp3J2efV6ecFOUUQtCBDD4iy9RQGZv378+vA8rszZxBDum+bRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988786;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5uW9Ehp+A9D3eXSKYh46ELliQ8ORQGcIYpLoOSQ/VQw=;
	b=dZ+y4NEFeIOG0cKR+1UXGqgBbu7AKmUSaFrRxT1ApomjFGBazq8AXj0CHpNFZ4ew8ZK4
	 6aBRQF3lMBMNb7rUtk+KS2HUVFLu7s0SsPda2PykNbbAv9XAE7yqCU8lLWqCvot7yqh4z
	 XvkPzgDq/3OYq4HYFZbdUPDNSJWV221INRLRINHEkoMbZZkGlJ9j6UHCD01UbSYktMru0
	 jykDFte23veoGxsSrouydgAL2DTysfYS+HUu0/+Nf6Br720P4qgjHFe8nEG29Fim8pKa8
	 cX5JUU8uqKPZi2L7LhR8QNL0MlHvlZIVl61Vl4hy0ZafU+mXI1ARWjTTuzEy1h02qGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bjfx1BE+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B1606A326;
	Fri,  6 Nov 2026 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bjfx1BE+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D901F0089F;
	Fri,  6 Nov 2026 18:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793988785;
	bh=5uW9Ehp+A9D3eXSKYh46ELliQ8ORQGcIYpLoOSQ/VQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bjfx1BE+rETzh/Pvou9EtopRmr6k9H4YPXvWhTJoTTJVIfUjsRy+PUIKIyJfTFZak
	 ury3s+gPOLNjHl7x626rAPkNW//X9y6xVzGHa1PmpmQqdll1hJe4dVh8zlqxLttGUh
	 aiVode3Hgr8mi3vApurA7n06cNCdM9sGYWwBthQ+/lHRcoyZGHBWKMuj2Cp8GRnvit
	 jjVioC8PmZaZ3SAsUYx6Heb1NZMYEr7qBui6pDDm8pzUKtGwzNxffnA9uYzWhnq5tu
	 znj/3NavQz9vMxbpJQQa1++SIzXizIOavM1UWmR1JBb6sKt3fJZjehoQH2JryzJ2tr
	 t3IhGTnqFB5Lw==
From: Simon Horman <horms@kernel.org>
To: qingfang.deng@linux.dev
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	manizada@pm.me,
	ericwouds@gmail.com,
	nbd@nbd.name,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] pppoe: queue unbound packets directly
Date: Fri,  6 Nov 2026 18:12:49 +0000
Message-ID: <20261106181250.1264364-1-horms@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103111711.28202-2-qingfang.deng@linux.dev>
References: <20261103111711.28202-2-qingfang.deng@linux.dev>
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
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103111711.28202-1-qingfang.deng@linux.dev?part=2
---
pppoe: queue unbound packets directly

This patch makes pppoe_rcv() queue unbound packets directly with
sock_queue_rcv_skb() instead of going through __sk_receive_skb(). It also
removes the now unused pppoe_rcv_core() backlog callback. Ordering with
PPPIOCGCHAN now depends on the synchronize_net() added in commit
92c1bf630abf ("pppox: drain queued packets on channel handoff").

> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index 5d5187e4976b3..51445fddb4d31 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c

[ ... ]

> @@ -417,11 +389,12 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
>  
>  	skb->dev = NULL;
>  
> -	if (likely(po->sk.sk_state & PPPOX_BOUND)) {
> +	if (likely(po->sk.sk_state & PPPOX_BOUND))
>  		ppp_input(&po->chan, skb);
> -		return NET_RX_SUCCESS;
> -	}
> -	return __sk_receive_skb(&po->sk, skb, 0, 1, false);
> +	else if (sock_queue_rcv_skb(&po->sk, skb))
> +		goto drop;

[Severity: Low]
This isn't a bug, but with this change PPPoE no longer calls
__sk_receive_skb() anywhere. A comment in ppp_bridge_gso_segment() in
drivers/net/ppp/ppp_generic.c still says it does:

drivers/net/ppp/ppp_generic.c:ppp_bridge_gso_segment() {
    ...
	/* skb->dev is NULL here (cleared by __sk_receive_skb() for PPPoE),
	 * and some GSO handlers (tunnels, IPv6 UFO) dereference it.
	 */
    ...
}

The NULL skb->dev precondition still holds. The explicit skb->dev = NULL
in pppoe_rcv() above provides it, and __sock_queue_rcv_skb() also clears
it on the queued path.

Should that comment be updated to say pppoe_rcv() clears skb->dev? As
written, it points at a function PPPoE no longer uses. Someone relying on
it could drop the assignment in pppoe_rcv() and bring back the NULL-dev
problem the comment warns about.

> +
> +	return NET_RX_SUCCESS;
>  
>  drop:
>  	kfree_skb(skb);

[ ... ]
