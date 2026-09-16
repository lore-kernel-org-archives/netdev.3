Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6CE49DBBF
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562399; cv=none; b=A70aiuLBCVLnwFeGh1Zd9m4NuZgoSaKI+GK5c9ovKHQpqhujbeD7StaTx0wowdNUIINEJ5r5mEbzKZCkpiBYOTOn0/ObZepmHVTgBsg/MlWWjOcN77JvmyJjOGiVKCLo8TIt05DJoq/KL+QcruRmdxPKTOilbfnZSdzsdWwTBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562399; c=relaxed/simple;
	bh=obbFqjsqQURuuAHQWNSkuAlWX86upgongf34c6qMYbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVNT1SJjXpnrsFakOANCKsOzO9wGJYUztOMYPHNQNK+51ceyrZ0thWqRUaDD/nRS4OgTgwl+8NuQVVH5mXLeru5Wr0f6aYAvErKYuy3m8kuWe2AuVW+4oqiAAt+/EHMAJDpqk0fc1bDSktrNQPUlMt//wIVBRfIwLCk6HMyluIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJiT8+XG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJiT8+XG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6461B1F000FF;
	Wed, 16 Sep 2026 12:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789562398;
	bh=rWVOzU/2+C0cR+TBJ0RERl5URTwYNBV6yjGd33DBYv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EJiT8+XGPZBLvzp69vVOdVafxFunskKAyqg8MjiTWCwvZqnMkY20CewqIa9ge1SwT
	 SRtACzrbqwq7o57C9/SNMIylRQsqh0esYf78tnP9ftbBtgP1hOomaxEUW0LMvlKnz2
	 A3ucx0o2ZYOXTw0rR7Yf11cE/y6S6QF+0ppXF6P42jbhfJi3dLn62bN+AygWv8pome
	 VmsDVxyYsiLSV1JE61XpoHR4Vdqn/7YSWQDKYu1ATiny620WLml3fovC7Gw//p3OOy
	 Ma1VPaMoQnTQa0xYekKLBXQ9/jHEmNj7Cl3ZaZUemECbEka3NquYaWkimmM/gWT7Ox
	 qsuXGWx59BBCA==
Date: Wed, 16 Sep 2026 13:39:54 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Jungwoo Lee <jwlee2217@gmail.com>, Wongi Lee <qw3rtyp0@gmail.com>
Subject: Re: [PATCH net] net: lock the socket in sock_gettstamp()
Message-ID: <20260916123954.GF51261@horms.kernel.org>
References: <20260915043055.3441600-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915043055.3441600-1-edumazet@google.com>

On Tue, Sep 15, 2026 at 04:30:54AM +0000, Eric Dumazet wrote:
> sk->sk_flags must only be changed while holding the socket lock,
> because sock_set_flag() and sock_reset_flag() use non atomic
> operations (__set_bit() and __clear_bit()).
> 
> sock_gettstamp() is one of the last places where a bit of sk->sk_flags
> is changed from a syscall without owning the socket lock, through
> sock_enable_timestamp(sk, SOCK_TIMESTAMP).
> 
> sk_set_memalloc() and sk_clear_memalloc() also change sk->sk_flags
> without the socket lock, but their callers (nbd, iscsi_tcp, nvme-tcp,
> sunrpc, wireguard) need a careful audit, this will be addressed in a
> separate patch.
> 
> Jungwoo Lee and Wongi Lee reported an UDP socket use-after-free
> caused by this bug: a SIOCGSTAMPNS_NEW ioctl racing with bind()
> can cancel the SOCK_RCU_FREE bit that udp_lib_get_port() just set,
> because both threads perform a read-modify-write on the same word.
> 
>   CPU 0 (bind)                        CPU 1 (SIOCGSTAMPNS_NEW)
>   --------------------------------    ----------------------------
>   read sk_flags = F                   read sk_flags = F
>   compute F | BIT(SOCK_RCU_FREE)      compute F | BIT(SOCK_TIMESTAMP)
>   store F | BIT(SOCK_RCU_FREE)
>   sk_add_node_rcu(sk, ...)
>                                       store F | BIT(SOCK_TIMESTAMP)
> 
> After the lost update, SOCK_RCU_FREE is clear while the socket is
> visible to lockless UDP receive lookups. sk_destruct() then frees
> the socket immediately instead of waiting for a RCU grace period,
> while the receive path still holds a reference-less pointer to it:
> 
>  BUG: KASAN: slab-use-after-free in ipv4_pktinfo_prepare+0x30/0x410
>  Read of size 8 at addr ffff888008806610 by task exploit/207
>  CPU: 0 UID: 1000 PID: 207 Comm: exploit Not tainted 6.12.95+ #1
>   ipv4_pktinfo_prepare+0x30/0x410
>   udp_queue_rcv_one_skb+0x51c/0x1180
>   udp_unicast_rcv_skb+0x109/0x350
>   ip_protocol_deliver_rcu+0x14b/0x310
>   ip_local_deliver_finish+0x29d/0x390
>   ip_local_deliver+0x24d/0x2a0
> 
> Only grab the socket lock when SOCK_TIMESTAMP has to be set,
> to keep the common case lockless.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Jungwoo Lee <jwlee2217@gmail.com>
> Reported-by: Wongi Lee <qw3rtyp0@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

