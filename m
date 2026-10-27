Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136312;
	b=xU9cGF/LkFN5SHZQGLjI592QgB/kMSBqS4LD9fBaOurPqFWdSBiaI06UmdK6dLp1klHY
	 sTNyyfXJ+Q5THSPDNu9Z1eusDn8o/keN2WPHbqU24BpnWeKdnV8p8evKBAiUhVF/Hk6RK
	 uyJ9jxBc65YZmIbBA5ZjBPdaMk2mgsXBdv6DEI+eZY+QVbeK3maoPSwsocgeRcdM0oeFB
	 vKmD8Ucf8iYpYBtFRt0x0UYx92IiGCw6bnCxnAM0YY6esQRjhUn/VzTHOz7aG2rXVb3GD
	 sjvplxI4/GNz4JX/M6QgDwpfSu1nP97LzxbTbPNStuw1UrauLhEW9WXjYR5YePq+6NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136312;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3vFEN7PFwFFQ6/hRJhhbKH2RiV/zoV2ai61tKhc4PRc=;
	b=eI0g2gTUCPoFJmi/ForL3liCagzNvoLt7wl24H+93Na2L4Z6jaG7VvOTu1HuUTJnstfL
	 KLgG+KPDKgLko0SHmNPb5bmennPsbzYOo0TmM2xt2xXzyKvDfIkaMf2Xz7poCrcF3C9jP
	 SOMT5B3PIXKP41zdn8WHZ2DsUIGpMj0zFSyN/U6yUQ7dQvlhlgZ+pvGTSyFeZq0aauftI
	 p5zlQw66p59x87viko4j0g2x20xornZVZPQVRBKT1NhR8sEv598uq5pr3Jws/2piun0Lx
	 6FNDGEOD5ziRIMWANrRnTerQB61bOK7XU7OHu6QaeoxW9KYobFJvjVOpfaKyGS+gIqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nerv6PK2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5188D606A320
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nerv6PK2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C8F1F01825;
	Tue, 27 Oct 2026 21:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793136312;
	bh=3vFEN7PFwFFQ6/hRJhhbKH2RiV/zoV2ai61tKhc4PRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Nerv6PK2dzlkxdF7onOndkaTWQEaIxqFXN8XZ0z72Cg95/nlfgJtA8/QV30zPSFup
	 r06PBT05gv0Ji5bdxaYOoXBxtTUQwJzgPehQO6gbmolqX4MO7rDQ12Noo6+ngcLSj1
	 WvAe6IkEHj+z+Cis/8WTqW0YP4ObxJmL9jOpPmiFsosRWQrK6CjLER9Lc+ONErcIJ5
	 9rHd21FTZBunfU8Epk4t1V64cleh9Q6cD1iRHO3RjShAP9fPeAsUqftY2c5T5Nu9L6
	 +Alkgzn7XHdJAInB1FKIQRS06Uj2RTdi/a+VXXrj8D/M1fX8DMREXPjZF9MrQ9yZFp
	 KeVqV+j9EFXCA==
Date: Tue, 27 Oct 2026 14:25:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, Aaron Conole <aconole@redhat.com>, Eelco Chaudron
 <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, dev@openvswitch.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Ren Wei
 <weir@nebusec.ai>
Subject: Re: [PATCH net 0/5] net: fix eth_type_trans() crashes on skbs
 coming from the stack
Message-ID: <20261027142511.5b00207b@kernel.org>
In-Reply-To: <20261027082604.1485903-1-edumazet@kernel.org>
References: <20261027082604.1485903-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2026 09:25:59 +0100 Eric Dumazet wrote:
> eth_type_trans() assumes ETH_HLEN bytes are present in skb->head.
> NIC drivers always provide this, and they should keep using the fast
> version, without an extra pskb_may_pull().
> 
> Devices looping skbs from their transmit path back to their receive
> path get skbs built by the stack instead. tc actions (act_vlan pop_eth,
> act_ife decode), BPF helpers (bpf_skb_change_head() before a redirect)
> or OVS actions (pop_eth followed by pop_mpls/pop_nsh) can leave fewer
> than ETH_HLEN bytes in the linear part, and eth_type_trans() then hits
> the BUG() in __skb_pull().
> 
> Instead of fixing every producer, or adding a check to all
> eth_type_trans() users, fix the few consumers exposed to this:

Bot says:

BPF CI (bpf-ci) is reporting a consistent regression with this patch
applied: every single job variant (x86-64/aarch64/s390x, gcc/llvm,
no-alu32/cpuv4/ASAN) fails the exact same selftest subtest:

  #135 empty_skb

Specifically, the "veth ETH_HLEN+1 packet ingress [redirect_ingress]"
case in tools/testing/selftests/bpf/prog_tests/empty_skb.c now fails:

  test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress [redirect_ingress]
  unexpected ret: actual 1 != expected 0

That test redirects a minimal (ETH_HLEN+1-byte) skb to a veth's RX path
via bpf_clone_redirect(..., BPF_F_INGRESS), which goes through
dev_forward_skb() -> __dev_forward_skb2(). Before this change the skb
was forwarded successfully (ret == 0); after switching to
eth_type_trans_careful() it is now dropped (actual == 1, i.e.
NET_RX_DROP).

Could you take a look at whether the new drop-on-failure behavior in
__dev_forward_skb2() is intentional for this previously-accepted
ETH_HLEN+1 packet, and if so, update the empty_skb selftest's expected
return value alongside this change? Right now the selftest and the new
kernel behavior disagree, and it's failing 100% of the time in CI on
every arch/toolchain/config combination we run.
