Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378652;
	b=XXW70iym/Nd7dD3WgRsZnwtALtpBfHuEQ9h/16A+Zz0v30y9V6D+2+G+zlHVald81blq
	 uvJSZl+kGeGE8i00xTzWD5EnwwKohLvEMA34v386VqpoTK9NEhimPT2GOTMW7qJPSyN5M
	 nyFgTLwvO7aqzlaUgAO+L6gV2i3td5hDW3Kc4/RqVR42JPVvELPHs93Bl6eieye4wNt9V
	 SphUyhOYCyQkZYoo2HioHafRls6ylV0ysEEBFQWKIotOgmMe/jsqStOn2Q9rkxh0qU8ab
	 BmS+YYuZ9Blxx5jGsRSOQFxGmVZRzwB2hnCj1D28gEPYx57YM3CyMJ92HmL2SwfIavw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Z5VQjaww8K3oIypyKSd/lggTITaeC1OBxOopgd1XPvo=;
	b=ldb/Hp/NRfiQ5Zts2/JKEAHpGXbusht45XeKpAOeBkbMZy/n41bec9ckSqv6/pBUrpVf
	 VEtyKaXOEVhNrfyOml8igvwY4ALjDvYkoUrNeyyFwXj7MFCT91XklLzSDvNeajFqouxdU
	 kixWMkoVOWEg/FtfsWsI1aZAkcaA45/o1lgVoX0Wu1QxdG3bVrH89CKk7oZMf0IsRDqRw
	 4eqDaiMcueTIOv6nRQDq/oaS/9jbECj9iHQIsDQizY7AR4+p2IGGO4vYgvSf6XS//zUGC
	 FxS+4x+Nf8FUF6IIV1mJnNY6TetrXRf66nzrmZ2OKJtp7ekaHdzKlzNi1KfErrr3VoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I4GdVZTO;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21C606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF21C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I4GdVZTO
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3aed1b64104so4100854a91.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794378651; x=1794983451; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z5VQjaww8K3oIypyKSd/lggTITaeC1OBxOopgd1XPvo=;
        b=I4GdVZTOd98q7ZDIxmfuIjgtvGGGwuiKB9M29Nvzpq5PFjRgmb9h0LMmMSyo5NxMSK
         IDQ/0BJP3eBdBtOzM6vEDFDOO69/H73aC3cAIpplwBhUWkICqx787ZQN94czpIC9+C83
         Sbt5V3quR90idZ+QKGUksjBRZAKudwSZ76IjxjRCJdt0ve+/+EELzalU9UFiO8htsLbB
         iSpQ0DkH0We/eDeoIZJEjrUYAk+U3ySlU2Nd7npT6sXpuWWo6YEwfeqCMIbas5MPdCAh
         jhCa1NzvW2Vqwv6KFtA9jqnEmQDyNbwT8W7b8BICQ1hDTk3BfNNHNORtCrQQWLD8j+Tm
         VB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794378651; x=1794983451;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z5VQjaww8K3oIypyKSd/lggTITaeC1OBxOopgd1XPvo=;
        b=KpHX4ylsacSeuFb2o0VdyNwHjc4qB/oJiQ3EqYPDkKiAAgA9PHL6orsJtQbQh1Tr1B
         Gtbs1+KKfwgu4TRwzfV7IFDo1+hftsWLQeBKrawTlqvSrWkPyyjLkXMGkHitmcS2cm2I
         1flkxmQRVzuEhN8knruPGCFDfSXHhvUXJZbLe7qyVQ3i0BMmrIPrq8nx7AivqgU/iozr
         SPRx0ivXhdag995UmcIMCtOncOi7Q2DbMc8edAmKA1ytOYcYUp1vMbUzGJaQkXNt9pwh
         CjJbHpFK381OUb0XF4FgYZxjtiAD5qEwEejO7q5GgjBeSnVI1e3wk6DSGB21f6dhbDQP
         HpaA==
X-Forwarded-Encrypted: i=1; AL+hErEBjyN3c78ARwLxb6QXtcxW3f8gKc06lWNeKUgBa7k1ejEM341LVyeUHwRq7bYCeXJ3xEpg1hk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kNnEQngdaall0S8+5PVOFm65sd81LOxAfc0tFDa4dUNhRNr/s
	Gqdg7ZhjBYG+kd8YHjGSBaQ8Bql1ZhaosHsy5Yf5DcnHkpW+TBBJIzajyxpiwZtDWZia3R2iBIz
	Q3xWjeA==
X-Received: from pjbfr4.prod.google.com ([2002:a17:90a:e2c4:b0:3b1:8637:2aa9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a90:b0:3ae:2969:9031
 with SMTP id 98e67ed59e1d1-3b182f4512amr1637960a91.54.1794378650921; Tue, 10
 Nov 2026 22:30:50 -0800 (PST)
Date: Wed, 11 Nov 2026 06:30:50 +0000
In-Reply-To: <avQKA_YTAThtbsYU@v4bel>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <avQKA_YTAThtbsYU@v4bel>
Message-ID: <avQLjMicyDQBM6rt@google.com>
Subject: Re: [PATCH net v2] tcp: fix request_sock use-after-free during Fast
 Open accept()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, 11 Nov 2026 15:24:03 +0900, Hyunwoo Kim wrote:
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
> Fixes: e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
