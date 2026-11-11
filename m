Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794373997;
	b=qZxqwG/TFC9HFtqPPIXXIiaEEmP6vjGwJiNuFMHLsXOeiOz3XU3rZToV/bLCPDBZT8D7
	 PqhV8YoJRYdmMzNuGd2i0U6W6zKB900U3aY2n75YfBftGpdcie6C3yV/5EoDFEbmtUfn/
	 1nzN6AZSGKlLItJ3aM3Jg5TvfJhh4dy4iucj21NgEPreXAv6Pq4rI1epGpmsxS5M+HwVQ
	 TKmZAB4eXwr7Cjpk1ZGaKbxQBfegNON9CwmCnZbivy9sq5n558gEJgoWN2yEc6kv8Uy0t
	 /99snVE6jDVPR8onwRXkJbBP0EC7oKcGLlbkBDLgCVQ188DXX4SZd7XMDovDRJ88nXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794373997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=0NG6UskJZnXLULFny7dGQngvAoak4lXjAToaONwQPqw=;
	b=Jb7YRK/91ptw/ioD2PH48d7OTdeCMynq4efpYmtoiMlu8c6e/6Bb41CmucgAaP9PRafd
	 7Ohn6P5tUBj9JFTrtMbb03e7gGqJn1lEEN9YUyoapFVsVlYf0wgIXvCvXVt/njwzr7ZsO
	 wn41vNICOUvU1I7OXVbBuqiO5Dc9GX5b0ZfXawpmhOt/to0JLeei6WPBimVvAN1XHto8x
	 jmqPBpw2ln+bh2oH+HHSlp5cJuecEKAQfLyue38KJxWLdsNYZqcinVCaOSP2fEtfsqXkE
	 flSBHj59ONKEtvu0P5Bpgips8JQEmdysHrwyHXzg9NhkhXTFfcy+gU5K5QSe2hGRvUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iU8Y5GF7;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E82606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 05:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02E82606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iU8Y5GF7
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e954d87b48so43162745ad.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794373996; x=1794978796; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0NG6UskJZnXLULFny7dGQngvAoak4lXjAToaONwQPqw=;
        b=iU8Y5GF7axDYomcZwrueQbbOLnOEokAi6WseF4J/K6WVgDZDNSwiQnyjDkAU8z0mQI
         jx8AWtSvmYLjhjI7xkt2ep1+C/eSERUYUo4cOucnM8d5WtFl0SprT4f/noFFYZvvcg1S
         8aNkX5kv9m+pFh5vySsVMAMD8v3ZK2lqD/sGRcuSGeiHXWlU1AtvgHVMCjW/EQJM+18k
         cjcw+/UINvDo6ehbp/dqnofFnlJL3j8+nF6gLmNYzoVoeMjD8mfDlOgfts79GMJsPemS
         oOdZROBJsBIJGPb23iKkOYWV5du0NM6h98+ML4yODbWOn92KzXE5hZliwTujRCp5MYez
         QvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794373996; x=1794978796;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0NG6UskJZnXLULFny7dGQngvAoak4lXjAToaONwQPqw=;
        b=LZI++ahSZPbVve9tJqLbYUWnfSrKqXh6YYZu3o+N/v9IEqmuJv72Z5OwkLadRH6aU9
         uaUQTuM084HPQyHslyZL8oQvYy2LuAD40XHNXBPTg3MsPGq+jEK9Xjt/rYYQHxKMsEWk
         VbIG//mFNK2EoV22aKtE230Xz5EJhWJUmaqHi3oxTQv3rfTcLoFZl8AszMFFhsj806NO
         I9sPYA18bTvtK3BhSFyenPcW375LlvIlzZ72+fdR9mk7QjUNokrBIfMc+51gAJMrfcxo
         WQq1mc8GxtUFcn4zIMCViV/wNFT8j3uPix5wzbhFMuePVopBb29gohr4pJjz3U/uVGAI
         K4ow==
X-Forwarded-Encrypted: i=1; AL+hErHY+JNpRtMx3X45DU71+FIw3jDjRBeqgaQD8PGu1F4uXF08oyzCRLUuJzexnduKMz4LsukbjUM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aeLuNQgWvJKeFJI1Ak5zsq+siOTN5CLYEEJyT3i/XzARA7jWq
	F9o2rz87TQoVm6/ir9xgkI2cNJM3GOsiBj+8UvS06+kWUJgq6V2aohTsMS+ErWTJX5Jo06PrZgF
	RRFgvIg==
X-Received: from plbkk12.prod.google.com ([2002:a17:903:70c:b0:2ed:2ecd:f0ad])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4cd:b0:2e9:5eee:e087
 with SMTP id d9443c01a7336-2edd79ffa35mr17633785ad.43.1794373996088; Tue, 10
 Nov 2026 21:13:16 -0800 (PST)
Date: Wed, 11 Nov 2026 05:13:15 +0000
In-Reply-To: <avFoNgJENLYu4t7X@v4bel>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <avFoNgJENLYu4t7X@v4bel>
Message-ID: <avP5PfDz6WfnvckT@google.com>
Subject: Re: [PATCH net] tcp: fix request_sock use-after-free during Fast Open accept()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, 09 Nov 2026 15:29:10 +0900, Hyunwoo Kim wrote:
> Commit e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
> made inet_csk_accept() check tfo_listener before taking fastopenq.lock
> to avoid taking the lock for connections that did not use Fast Open.
> 
> reqsk_fastopen_remove() clears tfo_listener while holding fastopenq.lock,
> then reads req->sk. If inet_csk_accept() concurrently observes
> tfo_listener after it has been cleared, it skips fastopenq.lock and
> drops the last reference to the request_sock. This can free the
> request_sock while reqsk_fastopen_remove() is still using it.
> 
> If the freed memory is reused for a new request_sock with req->sk ==
> NULL, the reset path in reqsk_fastopen_remove() can append the new
> request_sock to the original listener's list of requests that caused an
> RST. After the new request_sock is freed, the next append writes through
> the stale rskq_rst_tail into freed memory.
> 
> KASAN reported the following use-after-free when writing
> fastopenq->rskq_rst_tail->dl_next = req:
> 
>   BUG: KASAN: slab-use-after-free in reqsk_fastopen_remove+0x142/0x210
>   Write of size 8 at addr ffff888108230688 by task swapper/5/0
>   ...
>   Call Trace:
>    <IRQ>
>    ...
>    reqsk_fastopen_remove+0x142/0x210
>    tcp_check_req+0x96f/0xdd0
>    ...
>    tcp_rcv_state_process+0x19c/0x26b0
>    ...
>    tcp_v4_do_rcv+0x16e/0x490
>    tcp_v4_rcv+0x14a0/0x1af0
>    ...
>    ip_protocol_deliver_rcu+0x39/0x1e0
>    ip_local_deliver_finish+0x124/0x1e0
>    ip_local_deliver+0xfb/0x1e0
>    ...
>    </IRQ>
> 
> To widen the race windows, mdelay(5) was added after newsk = req->sk,
> mdelay(20) after the if (req) reqsk_put(req) block, and mdelay(100)
> after tcp_rsk(req)->tfo_listener = false. The KASAN report above was
> reproduced with this kernel.
> 
> For the lockless check, use tcp_sk(newsk)->syn_fastopen_child instead of
> tfo_listener, which reqsk_fastopen_remove() clears.
> 
> syn_fastopen_child is a field of the Fast Open child TCP socket
> referenced by newsk, not of the request_sock. It is set before the child
> socket is added to the accept queue. The paths that call
> reqsk_fastopen_remove() in response to a remote ACK or RST do not clear
> this field.
> 
> inet_csk_accept() uses this field to take fastopenq.lock only for Fast
> Open child sockets and rechecks tfo_listener while holding the lock.
> Connections that did not use Fast Open continue to avoid the lock.
> 
> Other bitfields sharing the same byte can be modified concurrently, so
> annotate the lockless read of syn_fastopen_child with data_race().
> 
> Fixes: e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/ipv4/inet_connection_sock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index e56beec438773..e5e7b844fed44 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -683,7 +683,8 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
>  	newsk = req->sk;
>  
>  	if (sk->sk_protocol == IPPROTO_TCP &&
> -	    tcp_rsk(req)->tfo_listener) {
> +	    /* Stable while reqsk removal can race; adjacent bitfields may change. */
> +	    data_race(!!tcp_sk(newsk)->syn_fastopen_child)) {

Are data_race() and !! necessary ?


>  		spin_lock_bh(&queue->fastopenq.lock);
>  		if (tcp_rsk(req)->tfo_listener) {
>  			/* We are still waiting for the final ACK from 3WHS
> -- 
> 2.43.0
> 
