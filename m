Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C63395AE2
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853800; cv=pass; b=s706PT/+/LzyhUhSM+UrY91u9XcBktaU1McXbPCAh4A5gLj7wLkny8R0ODUQAkiV1tZiiKrxwRhGuDS5WHBFu23ote4sf0gt/nOMqEooJEbNxIEQM/dU8U10b4ii1DAMQik4B5w0CH2uugegC/3xPnKd0nHojVZz0uAS4KLdTy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853800; c=relaxed/simple;
	bh=i0DWmTYAtfV+cns3aEVTHLRchCbS+UcefAa0V2oCdAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIfW0+fgrfjriDo/yoHZsxT64yefXOLCleFvQh8D3qUDu+v71uMW8wSsjuihVuDlUDIKYOGGg6mN8J+vCFoAGVVkxfTMQoe6g7gHr6ybgWS+YScl7HO0iNib0xLyeXUjSk/+EOd15jHB29YaJnTeQVA3FAJxhwXgJntCk+wClq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C13dhO/1; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C13dhO/1"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35834f72d94so4278258eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791853798; cv=none;
        d=google.com; s=arc-20260327;
        b=e4c/i/vCoft+KyZGCxDGbon8CXJkeQCJuDYwAV2FNHkJV6VTatGo8PHy2hk0i8t9E7
         mrOOyYVGjEswvCG36LzbXLVjDiwtxVuLHYlb621TvO37ubp7IL2sPV+psGgdYLYqpD4p
         3YlgZVTC3YpyVaPUQOfAZJgpbCBrv8K+TbbzDPgpv1pMvVLGDA7H5xmi/iwhbpl3gg7E
         C59/UGXo5k85XJUNMTEQ7xivqo+oHL2gKQ6ZSZd5YvSd2KWD1jGVx3/ppMnUKJn9Mb+i
         qhaguAbGMFGgZqGFyRmGaM2ZWZetwkJrZeERq/JRsd2h37Lm26wWklL0ENickbE3vARA
         RFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7fs8uWBBMtxpRd0lPBTZUzl/FrS8pqSC9R9fko4Ff24=;
        fh=8exDqYcwGku5M9Fwm0FRc8ou3+mA6saTEFebfAoTjMk=;
        b=DvPeF4gM3dS/MeOdYCnZCJIwmhisnKgENlOvsnAUGPpI3myZiVIs7eZa74pRiPTpZ6
         y9xq6t9saSXhFP5QHExY1dg7yEwinYxiyoWsT8+FIk2n3qJ9mOYU67HTV9LVX7RLZlMj
         2TeIESS/cZckQ8ygjMzrPRh41PkSTtm7XQJiQTjhLl4lL6yq6wRkj/B3HxbNrMb5V+TB
         TkLzfhd8FjdtIsUOljNrBwHHijIA0dgLJ3hpT0aaanSNQaU1KCmQ8Vdls/DVGhXdZwdp
         g02cDCEQEv9PW6VM4VehQB7z7Oamq3V89UzRlpYs4KmRtdaKreoapdhyIo7yeWgSO8Ug
         Qs8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791853798; x=1792458598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7fs8uWBBMtxpRd0lPBTZUzl/FrS8pqSC9R9fko4Ff24=;
        b=C13dhO/10y7pVnQh9oxIOVrQpWp7Qdq6fV6boLlS+4YsYGqtAzvF0GPcoeyypLTham
         9VSs5GxrXTckSQ5A10mSwmjH9ELflFOovchc0aULd2c7iW5hhb+Kw7bptATrHIhVKPnx
         ZqqcXdD/2/+NgVvrSrHjIWZCVEXCtUVrcHuPKGcpSFst8AIwmB5a+sxN6lw847ia52Zf
         RGWMf6cNPk7UNaWv0EKCRyT8cZ1WqYV6od//CntmTBMb/2s94iJeaz3/O/YVy7015pB3
         f9Z+e72udlSYP54L5JwBLqqiEsjZyo4r22rjWGSY3AR00tCoxLhp/4O3oUJBkRa+938X
         phCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791853798; x=1792458598;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7fs8uWBBMtxpRd0lPBTZUzl/FrS8pqSC9R9fko4Ff24=;
        b=Za3uEB8RXbFJY1J1XQJK+1+n0lsg/2VxhLJG+PgxSlFqiusankh7oJnz0dOQoMgge/
         x4TE/WXy7xuYedEvfKq6aWXayVu+HzxUWEHek6NtAAEqx9MV9QI3lVVhfVhvy+zrtROc
         AvflVDyP802y2PsRgi93+ylbp50bv0pmhKgcgdLGzHt6uN3rl30brriuCHC3SikyXknz
         jc1mkoneAIZYElkX2a7vOKI4gAGYLhkEt7k5drX3Vtm0fSz9SFS3Wp1mBno3f3Vx8/rs
         gFzLz9zmqyi1FNZt+sfVa5lJJdtmwosXcUuplssXkId6v0etQKHgvpA4dPOIwYPtrtLj
         dNCQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5IPDIyEHUIGRwBSMoKOLvLxLZc44GtAZ5nZ9OKi60kODV87IBxy0L15uDqLTADNSRmEw9RuA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsUsjwX5dqRgqdUU9dHZ444K7cl9ym4rTTCqRcUBzSl8sP2yKj
	3H2u6kLauBYI59eXyuBaKZNgTzP7MVNsBzSqtZwqW0MPMHEC/Hzbxsw4ZhEwbsqr24+nMh/kN7R
	Ap/TLdGeE5ahzV62INFks0XG9ovPMAkIuSgtUQvZD
X-Gm-Gg: AYBFou2Gv9BwcgucqHk2rzw642M9+QInUgMIb4Q5p1Iy4I8bKZAGk5tgUteukfXSCcT
	MeHqvmUWh1YwViaYzqH5XW5W4P4OzV3TDIvuauA82oIqfVXLd7SAo19eiZf4DexPr0MG4qtDj7u
	fKT28JbVBrGhDiGhFrZlvLSYKy7y6wkvSvWAfFi/bOnBpJ+SKcy2dnTiEiQMFUPpRKa7NlRCBf1
	nzppTvPmYP3m0Q7CP4RJBA9V4Ls9hQzSTvn9w+9NxD4HajwXypAwZYJJKQH0T9oh44VPpgkwZ52
	oEvH9+jWKM2WBvRaKx4MdqHC/LVEiWl+049bK56FjRAuKegwbZJ9prpRd/kXLa7G6uomdIdUsFD
	sEWKm9uXQp+zqh+8/40W1w81r2f0g+pBYpvXPTtXz16Hs5kue+mBSUtN8Sp+03X0CYmpS
X-Received: by 2002:a05:7022:1584:b0:143:4d12:396d with SMTP id
 a92af1059eb24-16a61a6def5mr21613050c88.26.1791853797020; Mon, 12 Oct 2026
 18:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012101029.927296-1-edumazet@kernel.org> <20261012101029.927296-2-edumazet@kernel.org>
In-Reply-To: <20261012101029.927296-2-edumazet@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 12 Oct 2026 18:09:45 -0700
X-Gm-Features: AclHuK8e1RXjUScu7b0NNviyINJWXx6LHo_At2Q6yp8sfNFDa-fGQFAyq6B10KE
Message-ID: <CAAVpQUC9QqCWKz-HChiJ8OsA4JbGZNpnJ7ECxAgodtsH=+eG+g@mail.gmail.com>
Subject: Re: [PATCH v3 net 1/2] net: use the full socket in sk_mc_loop()
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, 
	Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 3:10=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> From: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
>
> sk_mc_loop() is called from ip_mc_output() and ip6_finish_output2()
> with skb->sk, which is not always a full socket:
>
> - Since commit ca6fb0651883 ("tcp: attach SYNACK messages to request
>   sockets instead of listener"), a SYNACK is attached to its request
>   socket.
>
> - Since commit 79636038d37e ("ipv4: tcp: give socket pointer to control
>   skbs"), an ACK or RST sent by ip_send_unicast_reply() on behalf of a
>   TIME_WAIT socket is attached to the timewait socket.
>
> When such a packet uses a multicast route, inet_test_bit(MC_LOOP, sk)
> reads inet_flags past the end of the request or timewait socket.
>
> This happens for instance when a SYN with a multicast source address
> reaches a listener, after being looped back with its dst attached, so
> that ip_rcv_finish_core() skips the martian source check. A raw
> IP_HDRINCL socket sending to a local address does this, as does
> re-injection by nft dup or the iptables TEE target. The destination
> can also come from a source route option, or from a route of type
> multicast covering a unicast prefix.
>
> BUG: KASAN: slab-out-of-bounds in sk_mc_loop+0x111/0x170
> Read of size 8 at addr ffff88800f2b7f10 by task repro-raw/470
> Call Trace:
>  <IRQ>
>  sk_mc_loop+0x111/0x170
>  ip_mc_output+0x355/0x930
>  ip_build_and_send_pkt+0xb87/0xc50
>  tcp_v4_send_synack+0x500/0x6f0
>  tcp_conn_request+0x2135/0x2d90
>  tcp_v4_conn_request+0xa5/0x210
>  tcp_rcv_state_process+0x136e/0x6920
>  tcp_v4_do_rcv+0x339/0xb10
>  tcp_v4_rcv+0x34ab/0x3ab0
>  ip_protocol_deliver_rcu+0x6e/0x3e0
>  ip_local_deliver_finish+0x34d/0x510
>  ip_local_deliver+0x1bc/0x310
>  ip_rcv+0x390/0x410
>  __netif_receive_skb_one_core+0x199/0x1e0
>  process_backlog+0x239/0x680
>  __napi_poll+0xb5/0x650
>  net_rx_action+0x980/0xd60
>  handle_softirqs+0x17f/0x590
>  do_softirq+0x3f/0x60
>  </IRQ>
>
> The buggy address belongs to the object at ffff88800f2b7d60
>  which belongs to the cache request_sock_TCP of size 312
> The buggy address is located 120 bytes to the right of
>  allocated 312-byte region [ffff88800f2b7d60, ffff88800f2b7e98)
>
> Use sk_const_to_full_sk(), which restores the behavior from before
> the two commits above: a request socket uses the setting of its
> listener, and a timewait socket gets the default (loop back), as the
> per-cpu control socket used before had.
>
> Fixes: ca6fb0651883 ("tcp: attach SYNACK messages to request sockets inst=
ead of listener")
> Fixes: 79636038d37e ("ipv4: tcp: give socket pointer to control skbs")
> Signed-off-by: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.=
com>
> [edumazet: rewrote the changelog, added the TIME_WAIT case]
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
