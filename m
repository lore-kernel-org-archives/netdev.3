Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909553;
	b=JZGE1a26R7UJHQlNnnkKyWgG5mEQIb7Y/HnoU7uIgRQt1IltBnWFpSc//9rsMVUqSAix
	 Xqz48sZyJJ8G3SmiV47XPw0eKUhuHbjrDGO4gvRe+ZTnNB2XJEa1Nc3KDnFsEQNGbYIN2
	 MhxsYxsD8tSU7U6ZTv9k7Pr5NO5R8vQgnfzZhQhnn327Ln/N+e+ksagodRgAkvGhuuPr9
	 bgI/CT4AEzRJOFzrkFC7OZcrU0b1bkhQFr02T/ngHnYGfYhHiAIgymE5DkqYwT2ItHPh+
	 Xpzg7r7KSZH2NEglXMHsucmGw/B05X89PzRe+mgkXmrEnulrW+36IedMWscYlHhopVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=DmHJ0V4exjwBz9V28uEi3iXjCzwogxDe6V7LTEOBJ0M=;
	b=qGn84lIszbMEORk6t0Id+uBAwhR+z6RKmdxN7tTcnTX2zkSjjPR50g9isLdfv5W1jtZ8
	 qRvpViKSR7k1jlDCLe0rfmTD91+65xHFKJ5VSIeRf0G3QGH//aGu+imR0fBLJXt5RJBTL
	 5Jzat2IuMR8gwEYIwBnHUrg3FMP0ATbC+15fc2PjbQzZExeycCprQ/VB64Nij44lO1xmI
	 Bx2fGSVjkmj/GNCUHR4O68IElJqUEtPjmbN/G3zbDCTBbE3fAkQDJt6gehP5+d6q0u+lE
	 mnb9q8yzlb+Zu8cbjfV3FlJenKWMT0/eaRnPXa+GpSw4HYgbR3v5Fj5Ej1blp/UUiEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FY8oqZ+m;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0718C606A33D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 20:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0718C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FY8oqZ+m
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e94f72fb9fso22311215ad.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 12:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793909552; x=1794514352; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DmHJ0V4exjwBz9V28uEi3iXjCzwogxDe6V7LTEOBJ0M=;
        b=FY8oqZ+mXllXeHf3/Zb3VlGDzRq0rzuxG8VyEI2T5z2sI8SlIIV7P5EHcYblXHbPBm
         7ih0LmbDYT7PThRTteIAcb0th2D5PPSbchpsqJZPOyx2v4zsgY9KFwOU5IcbNyHBs+Qr
         i7pZxW9HQKOrP7vv4MdUCVJCJG9NqJXhMLRyPn5usNYTQOxtuIfYtX0Oi2C+cPwv+BSk
         XSzxhZjrlRBMRXvWW4Ed8X8AxU/mFyD3k0+TVNvMdb4BXJLtwpGGz7DMxmW7DWRc0W+M
         VPWuEDW2CTfWwJoaRZ99dV5LBUPQ7lw7QAlW8rguaUR0uwKqSCOlIsgaHOWKPKnYfua1
         Oa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909552; x=1794514352;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DmHJ0V4exjwBz9V28uEi3iXjCzwogxDe6V7LTEOBJ0M=;
        b=h7p4UfNn/vVbfep0jwEnZHTjSRlnzUCBOdEFZSQJvRSLf+zmWcTWZU1Nf6GIAJBD8L
         N+AGzoWgnMtCxPBTR0fKHB6fEnvyW+rZQVAmnhHv4B3X1tXjFXIlsDcaeoUx28k/+Z8P
         y4/XVqo7+UufgF5KxkvqYnwyn5wNmvYGhHRnaxAo2aDuD1ZB4eioPKVyscqq3AxWgS39
         gvgEii+OH+3L1hAPVqwlmhCXDNwxD4SZiiuficVR6rl59HIgwef4l6Y/0H1+k++Zvwlh
         q35k7HXgaVeuTFVpGK/jhRPOyducxFEtIEedRYVch0rzBUVrr8nM6Px8h+k7sTt6810P
         dvGg==
X-Forwarded-Encrypted: i=1; AKwUvBxsutF9LVYs3VwckyI6+ad2Y7nqDAAy05eZuBemvY15GYtz7DdaWy5TkW48Mh3zFStU4YiONrI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WxCOg7mNeoo1EnsbpiPJiGKl/EyStjIhUt9BgRyDc4zSNx2F1
	gC9DVou/6SIPMncrrSyGZiIX0ZuQyVckTemhjnjChLEIxWRCgwuTCrb3a4Ml9pEpav/Mnflym2Y
	HIfOe4g==
X-Received: from plic5.prod.google.com ([2002:a17:903:3705:b0:2ed:2ecd:f0ad])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37c6:b0:2eb:a1b:e9e5
 with SMTP id d9443c01a7336-2ed40e24c49mr6579765ad.52.1793909552160; Thu, 05
 Nov 2026 12:12:32 -0800 (PST)
Date: Thu, 5 Nov 2026 20:12:14 +0000
In-Reply-To: <20261105124043.1543405-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105124043.1543405-1-edumazet@kernel.org>
Message-ID: <auzi1Wg4r17fWXDf@google.com>
Subject: Re: [PATCH net] tcp: rate limit receive queue collapsing
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, 05 Nov 2026 13:40:43 +0100, Eric Dumazet wrote:
> When a socket is over its receive buffer limit and its sk_rcvbuf can
> not grow, every incoming segment that needs memory goes through
> tcp_prune_queue(), which runs tcp_collapse_ofo_queue() and tcp_collapse()
> on the receive queue. Both walk their whole queue, even when there is
> nothing left to collapse.
> 
> A peer can trigger this walk per packet, without refilling memory:
> 
> 1) The segment lands last in the out-of-order queue. Since commit
>    b0e01253a764 ("tcp: refine tcp_prune_ofo_queue() logic"),
>    tcp_prune_ofo_queue() drops nothing, the segment is dropped and
>    the queues are unchanged. The peer can send it again forever.
> 
> 2) The segment lands second to last: one skb is pruned, and one small
>    segment fills that space again.
> 
> 3) The out-of-order queue is empty and the receive queue alone is over
>    the limit (application not reading). Collapsing frees nothing,
>    the out-of-order segment is dropped, and the window is not closed.
> 
> 4) Collapsing frees just one skb, enough to queue the segment. The next
>    segment is over the limit again.
> 
> Only allow a collapse if at least 1/8 of sk_rcvbuf of new memory was
> queued in the receive queues since the previous collapse. This restores
> the "12.5 % of the queue capacity" amortization of the 2018 SegmentSmack
> fixes (CVE-2018-5390), using the same unit as the sk_rcvbuf limit, so
> that peers sending small (bloated) segments are not penalized.
> 
> The credit is the net growth of sk_rmem_alloc in tcp_queue_rcv() and
> tcp_data_queue_ofo(), so that:
> 
> - Coalescing a segment into the tailroom of the previous skb charges no
>   memory, and earns no credit.
> - An out-of-order segment replacing or covering queued skbs only earns
>   the memory it adds.
> - Duplicates earn nothing.
> - Data moved from the out-of-order queue to the receive queue
>   (tcp_ofo_queue()) is not credited twice.
> 
> In-order data is credited too, so that a receive queue filled by
> bloated in-order segments can still be collapsed when a hole appears.
> 
> In-order segments are rate limited as well: a peer could otherwise send
> small in-order segments that each trigger a collapse freeing a single
> skb, enough to queue the segment, while the out-of-order queue holds
> many skbs that can not be collapsed.
> 
> The credit is tracked in a new u32 tp->rcv_collapse_credit, placed in a
> hole of the tcp_sock_write_rx group: no other field moves, and tcp_sock
> size is unchanged. tcp_queue_rcv() now samples sk_rmem_alloc, and
> writes the credit until it saturates at sk_rcvbuf, so that the fast path
> stops writing it after a full buffer of new memory. Saturating at the
> goal would not work: sk_rcvbuf, and the goal with it, can grow later
> (for instance in tcp_clamp_window(), just before the goal is checked),
> and a socket over its limit can not earn more credit until the
> application reads.
> 
> When collapsing is not allowed, tcp_prune_queue() goes directly to
> tcp_prune_ofo_queue(), which is cheap in the cases above.
> 
> A regular flow can see a difference when it goes over its limit before
> 1/8 of sk_rcvbuf of new memory was queued since the previous collapse:
> out-of-order skbs can be pruned (even for an in-order segment filling a
> hole), and an in-order segment that still does not fit is dropped,
> with a zero window advertised, where a collapse might have made room.
> 
> Fixes: b0e01253a764 ("tcp: refine tcp_prune_ofo_queue() logic")
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
