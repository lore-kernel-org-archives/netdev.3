Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794375798;
	b=yVhTpxZgtXuQPtB6MpJZD4lkA91oNkMXj4IJRF7YcqEdqNnDxQ19ygSxeB3c5jaekEMM
	 N6RDcww98jsPSb8Ur5SoNgRHPh9lx4VAouD6viBafsWbMGwEv6cZc9+GsYdVK7oxqowEd
	 gfHz/lRym15CgadHzyLm+mUn5PL4PAj4gPmxVKN2Qiiqo+a6KkABKxSIEtO0nGN9qQpBd
	 ZSLJp6AxgEbZBhdHjKOoqWyUmi0HLhCg8ATiTiF0bd+rN7GsE7xCeW45Qh68HsqWXH1NJ
	 8AV1a8Fy8510zyKXFaQ6Bjih1aidO1Q+Dmk5AiWwgTjsJaOvgLFlsb7X+2EkjJN4v1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794375798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=G6fRPvQEWhxg/M7/dlRuq81azLgYhDWTXKYxObOWTic=;
	b=WYznaM7Lw7nKLtGBoVLuFzS4ckmZXWlzHNXK5/MgnhHht1f+OAORehGChn7hSQvtd5bc
	 7P3BBF8TNP5MxhFE8SmAokO7MjDDIs2eGV2Q3XGwc3YdEnZF7EAxySwUuBmdJUVidxEpD
	 0aZ3EidGltkgCggH6WYD/2hQy3WfJao1ihuWueZDNlHkGIm6ci5EmD7QjyEg35YbhIBQ9
	 huKDFAPU+g8aSbX1UImelSPOx4GwAPQqvteP3cydVLJW9xjidGLg1QGnTmhpG9cBOuTYy
	 kQeCe1gGud3vRPokfjmLinRBaObWWjC7yU6eGQyzvRj32cq74BByb+3402Jt8JZ8hRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=krttHbm+;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB91606A320
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 05:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EB91606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=krttHbm+
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b179528d56so478414a91.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794375797; x=1794980597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G6fRPvQEWhxg/M7/dlRuq81azLgYhDWTXKYxObOWTic=;
        b=krttHbm+6DmYNlbjLSUXUJ6yZqZ73aoeI7GmhF/HeM0gWFiS+MfxrjLHXOtNQo7Voa
         PHOc5Fr9HzoPwBP0cc9qFkOKKyWU03bs5MpSaGBYKFzaZjnDG4wGdSsUMpuVSho/2IV8
         rcTMc+3YL2aGNf276a7LAcZs85+0wGqBhFT0VH8yL5Ixt0C8CMih7z82UOua1hrqxXFP
         TGBHvqkF7SRosLbX5QmHpz9pG+28MytpjntkThOLV00IVx1DP65FsVdGMBt3k7kmFltE
         c5mgXpUt2kcRwPx7waG7IoBcMglqVdttCHpkRTS6FE0e/wfB38ski08oatC+VmGoztNa
         bEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794375797; x=1794980597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G6fRPvQEWhxg/M7/dlRuq81azLgYhDWTXKYxObOWTic=;
        b=M9fwzKOt2Yt/isZbxh2lQUDB+p0bjiCU+p3B8W7gQDlU27jcygn0nrciVnn8SjTGwg
         oNlLQWllMHdC0fpOD4rzIGfC8dIxtIjc2OfQZLuFgFEeTci0wY57DFz2dbJb/ITkbHAu
         e4RtYWIbmm+oagmrvprNhXqcjCiSH2mLTbyiWvBKb8nmiq2tnTquN+sYtQzudqSp3Ic1
         ef47Eo1nsCuAESd+TUG8+48Gfefrt5TCsk+kBbeomEgkVSKhpUcB3/LlbNkQznuef7RD
         ddYUwLYlL61VA3WFRXLkE8ZqVETMDE2ZS1ISlsqM8tEUvIl56XO04J7yaZl8zkqzKSsW
         p+Rg==
X-Forwarded-Encrypted: i=1; AL+hErGFiQCF8mEAlfu1KcQmHlYpqmxjlA9NceF9haWVtpac7Zw4LeabGtkd165qd/N7W9sBEr/R4+E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+b6PS5wqAe+e+sxOeM/JOrX8SDpRFEvzvf3e802xONxKkqgq8m
	xWe5NX/DfiybPzVS0JIJ2bDfhAIEo4CsfoaLd1HjYHng/pomEXA9ydhD
X-Gm-Gg: AYBFou1Q4njH801uxiwXFxFJ404JpMA/5b41Ff30csSOv3m68Vrv2/xNY6TOU5MVtBq
	9tILRtsvGVOkGYHBOxIG80t08gZZjvzkas0LMu0/Av5iLcWAfJTy30BnhOiq0p0TGHBHXtQseSx
	xne+z2WwwuvsEgX9X1tYFwQiUcHePRJRGZRufnVJnrJLvlFhSsC0Eem0PRORK1hf3UDXergK1EM
	q87dq0XSuCvXSwW9Uc3PMP5HHVQ+iodJvj38zX1nY9Z6rIj0s6XFWhPXvfLCWHCRjOvGEqr5FvH
	/JsEqJT8T8gu2rfSRWYN4wgb4tkLoOQQa5s1YJu1slmv0WjWObvBVZ73Kjhmk4caxzjVwL8Z8lx
	zTwyYdBw8y/Iznio4aknOki/K+psGLkDL8RupvT1OBbIVSq4ywidCgWCacoucJncVDpoUchwqgl
	EGeV6SUS3n0EC0EoSKAD3J91USviKq86d4ZLZJ4XsrMlZf3N3Ha4CUuM823lsiyyspNrRa0bRJy
	L1hvQe9B54jopJ517ORZbd+TwSv7D+GaCNEoQPVdvrrb0l92HlBWKLqRBk/AjiRYzy0RfRaDxx/
	i7XS9sIQW9ZVDrd/XBeLqjlH2GAOlMNphh29fYuzbv1LD0uDq7lifqmcINFbq3xLrOqYJA==
X-Received: by 2002:a17:90a:d446:b0:3ac:a11a:7c7f with SMTP id 98e67ed59e1d1-3b182f1eedfmr1318832a91.23.1794375796835;
        Tue, 10 Nov 2026 21:43:16 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17e0d2b1csm2869997a91.6.2026.11.10.21.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:43:16 -0800 (PST)
Date: Wed, 11 Nov 2026 14:43:11 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net] tcp: fix request_sock use-after-free during Fast
 Open accept()
Message-ID: <avQAb-Gb7FRYNNgO@v4bel>
References: <avFoNgJENLYu4t7X@v4bel>
 <avP5PfDz6WfnvckT@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avP5PfDz6WfnvckT@google.com>

On Wed, Nov 11, 2026 at 05:13:15AM +0000, Kuniyuki Iwashima wrote:
> On Mon, 09 Nov 2026 15:29:10 +0900, Hyunwoo Kim wrote:
> > Commit e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
> > made inet_csk_accept() check tfo_listener before taking fastopenq.lock
> > to avoid taking the lock for connections that did not use Fast Open.
> > 
> > reqsk_fastopen_remove() clears tfo_listener while holding fastopenq.lock,
> > then reads req->sk. If inet_csk_accept() concurrently observes
> > tfo_listener after it has been cleared, it skips fastopenq.lock and
> > drops the last reference to the request_sock. This can free the
> > request_sock while reqsk_fastopen_remove() is still using it.
> > 
> > If the freed memory is reused for a new request_sock with req->sk ==
> > NULL, the reset path in reqsk_fastopen_remove() can append the new
> > request_sock to the original listener's list of requests that caused an
> > RST. After the new request_sock is freed, the next append writes through
> > the stale rskq_rst_tail into freed memory.
> > 
> > KASAN reported the following use-after-free when writing
> > fastopenq->rskq_rst_tail->dl_next = req:
> > 
> >   BUG: KASAN: slab-use-after-free in reqsk_fastopen_remove+0x142/0x210
> >   Write of size 8 at addr ffff888108230688 by task swapper/5/0
> >   ...
> >   Call Trace:
> >    <IRQ>
> >    ...
> >    reqsk_fastopen_remove+0x142/0x210
> >    tcp_check_req+0x96f/0xdd0
> >    ...
> >    tcp_rcv_state_process+0x19c/0x26b0
> >    ...
> >    tcp_v4_do_rcv+0x16e/0x490
> >    tcp_v4_rcv+0x14a0/0x1af0
> >    ...
> >    ip_protocol_deliver_rcu+0x39/0x1e0
> >    ip_local_deliver_finish+0x124/0x1e0
> >    ip_local_deliver+0xfb/0x1e0
> >    ...
> >    </IRQ>
> > 
> > To widen the race windows, mdelay(5) was added after newsk = req->sk,
> > mdelay(20) after the if (req) reqsk_put(req) block, and mdelay(100)
> > after tcp_rsk(req)->tfo_listener = false. The KASAN report above was
> > reproduced with this kernel.
> > 
> > For the lockless check, use tcp_sk(newsk)->syn_fastopen_child instead of
> > tfo_listener, which reqsk_fastopen_remove() clears.
> > 
> > syn_fastopen_child is a field of the Fast Open child TCP socket
> > referenced by newsk, not of the request_sock. It is set before the child
> > socket is added to the accept queue. The paths that call
> > reqsk_fastopen_remove() in response to a remote ACK or RST do not clear
> > this field.
> > 
> > inet_csk_accept() uses this field to take fastopenq.lock only for Fast
> > Open child sockets and rechecks tfo_listener while holding the lock.
> > Connections that did not use Fast Open continue to avoid the lock.
> > 
> > Other bitfields sharing the same byte can be modified concurrently, so
> > annotate the lockless read of syn_fastopen_child with data_race().
> > 
> > Fixes: e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/ipv4/inet_connection_sock.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index e56beec438773..e5e7b844fed44 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -683,7 +683,8 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
> >  	newsk = req->sk;
> >  
> >  	if (sk->sk_protocol == IPPROTO_TCP &&
> > -	    tcp_rsk(req)->tfo_listener) {
> > +	    /* Stable while reqsk removal can race; adjacent bitfields may change. */
> > +	    data_race(!!tcp_sk(newsk)->syn_fastopen_child)) {
> 
> Are data_race() and !! necessary ?

It was intended to avoid spurious KCSAN reports.

Still.. I agree that it looks a little odd. If you think it is 
unnecessary, I will send a v2 without it.

> 
> 
> >  		spin_lock_bh(&queue->fastopenq.lock);
> >  		if (tcp_rsk(req)->tfo_listener) {
> >  			/* We are still waiting for the final ACK from 3WHS
> > -- 
> > 2.43.0
> > 
