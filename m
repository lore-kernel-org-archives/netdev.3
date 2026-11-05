Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793915851;
	b=ZCfMxopFnIeJcVp8nIdYQ6gv6KVgNdRS294SOFDLc+KCaaHOYrL3w1mzc8dZLUhorLIZ
	 93anCpRsYr/u6OnHc59gIc1nJj2uewacwu8wPUFnMMxynOhNmOl5toRbhyGuT3F4qQG77
	 BZzdqFbuNccAPgqcfaVi3986rFsZ2qxaYkzikRS6urQfyPC+/ZCH2m/KLSEGxlAdG0hOv
	 KS8pfYVnG0qXhfpJvt9ZoT74+TovY+Z7PhvEVpMfhu+wVQomQX9Z1acm9zQHmGdHh6wJl
	 xq631E5FwQXhVhFPBLMkXQ9ZA3TV4XLBse+NqM72RE0SYFTrBoOObimUCyK8vcc83jA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KD+HMqgApJFfxfyeoNCl47S9DMY7qbDif5sGpR0MDSY=;
	b=BHg38CVfGfTdHoKvV17dZN70gioSL3FgEMMuUfR1J24qdRHtuXLR572YYZkJDLgdEJTB
	 2kj8rA8pfBOPaN9S1Pq5i2fuZdEVK+04xmDz2BNsEkXo8fdoyNQsTieohUvROGlHDv0EM
	 hKneE85mr2np/tULYrqu+ZWCe7rk5HRjPxtUwj7fs+AJ/wmWuv6yEjbHZD4bsm37eLZQ6
	 VvAYubrb0CnJq7EZkwt5xWRo0l1YxddMkLlBuJp67MQdjuIHpQ4xt805KXT3A0E9YR3/x
	 /pmFs5CpS1vZSXLmDNuXxlvreWuXbp5UL6Mcc2uuYNero81TmQdF8QjMyZtIhIS4Mtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="cCki/2zz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856C606A332
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 21:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A856C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cCki/2zz
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-54492d8a988so80631cf.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 13:57:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793915849; cv=none;
        d=google.com; s=arc-20260327;
        b=nrBWXs63SliYpouGyYF3KYv7yeUl3DFgyr8ccbVkLISee1P5r0ECDrLArtG2g727Od
         IGI4ga8aIyWxWAhcR7PsxmUZ3znWVsnwG0n/Ed8+u/OKO+50BXyCMhogb7/bbFUVaR1B
         KIjrLdN2YySIeW/d4DHFH1dBTdK6tv/ezaCSzsftWadGTKb5iKMOa6Jxfnydcpcq+sMn
         eOQgtzjyt91zfeHf3CU5R4BHww5LNwvmq38SoL6JD1SDeL5otMWCnKqo4ONhBvZAZSWM
         04s9QEu9UJzHsOuwLj4L4sqC+N8DxTiYkXWy/YIALgLjVLKMh7RnV8vINmN8hjvY7LcW
         nh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KD+HMqgApJFfxfyeoNCl47S9DMY7qbDif5sGpR0MDSY=;
        fh=h6kyyYms+9w9IuFrPIqZKH5+9K8FY7h78yYcEf9ZocQ=;
        b=YPMqaxZOCbrkWZTGh0McAd0AJFH3+aiJEfyBEhVuyokpq83IobvI3cQvz2K/FaFnqY
         wOnAckUJKzKJALxHTZRAzbU7ReIdp5c4+oXGJvkHXeDv6KmA9hUt7xVP5ccftSihLxNX
         v6HU6N6AijnC8e63QBRp10YgBsXg0rxABubYLXV2s94iOfx4/GelZDkXgCCYlZelxa4z
         Vs8U1onQJaa7ypZQ+WUvI1uqtxDnkbbJbgdr6xZ+6y+7QYMHcyaYsPmbEKp1+znmDj53
         hDq/FAekjwdkaWjC8cSkpyMD8Y1Kb9ZCN2JI8P+yGMjG2mBxDNWS5s84tKd7tdhdx+7R
         6epQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793915849; x=1794520649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KD+HMqgApJFfxfyeoNCl47S9DMY7qbDif5sGpR0MDSY=;
        b=cCki/2zzoT9QNlmwCEAoKTj3KzHzmvcTskoIfd911qu8uIUWqKj3Bp0F4cTXMhlnLP
         u/bByxmqo/TeTNmJq24DRmUI7a5NJh8ZEVHYYKUVRMeSx6PuuY0Gm6oTQvokBSZSKRVV
         WZ+4KOyTfbTyDcZXSF2Kj8g0gn3+ecogUEuayKEReB+H+zUlpnLNzYWElMEE/bfrBUGD
         ynHxzuETGRaFFN1qxRStE+rgmACnhNXQmUbYpYQFE0Q0/dHDCnLKfFaYlmfOAvN2v+aF
         RfdesGSPMS7l5SCcOmLLIPNMQ9K8Y3P3DC8XjAUMXb0i4Rnr6g/fkonXppKlCIJHDlDj
         MYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793915849; x=1794520649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KD+HMqgApJFfxfyeoNCl47S9DMY7qbDif5sGpR0MDSY=;
        b=CFI0FewprOynL3Jp/W2wSm2imMul7mrq/TMYwzs6ZNFe5oa+1HlefBLVjisM8fY8rt
         3nrXraDfMUVUV5Dys7hQ7hgQbi9fp0UJxo6O5dUZbfiQWzDfBcSIWuR4SqcUeQ04u2u8
         jxe8erB6WEMcGKZqSp/JHd3ypHRjFW7cNwy+Z9s61kdR0U/bvc5K4ob4TiIvOIM7sAM0
         pHAzCA7ZHWXh5UCq0fHvEBpLHxJK5oTC+ifN2Qxal8wvwEc2pZR8s2puyV0kmFJaeibt
         2L4R/fw7VxkLdEGgSywlvPMlUpq3Gcs46sV76hOU7DpH7wWF2xGphW6omrLNDbKnLa0z
         mjMA==
X-Forwarded-Encrypted: i=1; AKwUvBwQSQfqPfN5Af0Gl5O6Bxo48bAZfZg32iIdQ5z1xKHa3k7OdScPj/jW+b2fJdNnDn2qSok80wg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FIGS1+lal3U/VYHH5+Ttjk3Hi6UG/FVowsIhXkmUinZIjNwJd
	B2pGYkmgo+QAz7lCsFIGuMrevL1+ytcODFH2lRfVr62l/1XIXb3Ic4tFKakiCEr6NTnYHUK6ksG
	8nexIlmRUJfo8UNmGRqJ00fFyO9xI24r5DYfobjM8
X-Gm-Gg: AYBFou3h2GMpkYFtUYx+VGyDy6EB2Mr3HRJ+bpECz3wPghDdMMnRmxI1EU25G4VWU8t
	ZOmUw4fIemZ6vd9OHB0pU+T8xELcg1+sRwFIBdFo/XfrcUh53B1mgnY84qYpk7ZfOh1HBJLR8eK
	z+Ir4KIxRii+m+XEWpntQ3BrZb9BqpT8eYs9RquS7HilDj4BKkQmG1TBbhCAL1QHohdPRcY0SHI
	lGaNGap7vWaJs0SmcQLKUB6kbnOAcr/CQ52PPW5MNDmruL7X2anGG5jd4dUamVpOW/PKP6my9rR
	Ko4CPGK8/UtFyUIQiJ96ROySX84V/MF4wdjMOeLbX+xdifL2NWpzDmziJVLySXtYi+zTbRtNeOU
	jis7gvcV15FlY3lK5ZrIbx3rQ6ErVrfTnibotxthz57Dpi2UhYT56tT4HscdGubnyjdKLU7tqT5
	hEjY6111gA4T3rH949wFiiRhrH1jg=
X-Received: by 2002:a05:622a:2592:b0:530:e335:4ef with SMTP id
 d75a77b69052e-54e18df9098mr5089131cf.2.1793915848708; Thu, 05 Nov 2026
 13:57:28 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105124043.1543405-1-edumazet@kernel.org> <auzi1Wg4r17fWXDf@google.com>
In-Reply-To: <auzi1Wg4r17fWXDf@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 5 Nov 2026 16:57:11 -0500
X-Gm-Features: AclHuK8mNC5bNFH6RuqHnj4goE034qO97JeZWNfU34s09vNWCM7apdjHD_xJpeU
Message-ID: <CADVnQy=kDau3_yWS0K7S8+GqfWHzt1X2CqP_L8_g7_FpmSMdYQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: rate limit receive queue collapsing
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 3:12=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Thu, 05 Nov 2026 13:40:43 +0100, Eric Dumazet wrote:
> > When a socket is over its receive buffer limit and its sk_rcvbuf can
> > not grow, every incoming segment that needs memory goes through
> > tcp_prune_queue(), which runs tcp_collapse_ofo_queue() and tcp_collapse=
()
> > on the receive queue. Both walk their whole queue, even when there is
> > nothing left to collapse.
> >
> > A peer can trigger this walk per packet, without refilling memory:
> >
> > 1) The segment lands last in the out-of-order queue. Since commit
> >    b0e01253a764 ("tcp: refine tcp_prune_ofo_queue() logic"),
> >    tcp_prune_ofo_queue() drops nothing, the segment is dropped and
> >    the queues are unchanged. The peer can send it again forever.
> >
> > 2) The segment lands second to last: one skb is pruned, and one small
> >    segment fills that space again.
> >
> > 3) The out-of-order queue is empty and the receive queue alone is over
> >    the limit (application not reading). Collapsing frees nothing,
> >    the out-of-order segment is dropped, and the window is not closed.
> >
> > 4) Collapsing frees just one skb, enough to queue the segment. The next
> >    segment is over the limit again.
> >
> > Only allow a collapse if at least 1/8 of sk_rcvbuf of new memory was
> > queued in the receive queues since the previous collapse. This restores
> > the "12.5 % of the queue capacity" amortization of the 2018 SegmentSmac=
k
> > fixes (CVE-2018-5390), using the same unit as the sk_rcvbuf limit, so
> > that peers sending small (bloated) segments are not penalized.
> >
> > The credit is the net growth of sk_rmem_alloc in tcp_queue_rcv() and
> > tcp_data_queue_ofo(), so that:
> >
> > - Coalescing a segment into the tailroom of the previous skb charges no
> >   memory, and earns no credit.
> > - An out-of-order segment replacing or covering queued skbs only earns
> >   the memory it adds.
> > - Duplicates earn nothing.
> > - Data moved from the out-of-order queue to the receive queue
> >   (tcp_ofo_queue()) is not credited twice.
> >
> > In-order data is credited too, so that a receive queue filled by
> > bloated in-order segments can still be collapsed when a hole appears.
> >
> > In-order segments are rate limited as well: a peer could otherwise send
> > small in-order segments that each trigger a collapse freeing a single
> > skb, enough to queue the segment, while the out-of-order queue holds
> > many skbs that can not be collapsed.
> >
> > The credit is tracked in a new u32 tp->rcv_collapse_credit, placed in a
> > hole of the tcp_sock_write_rx group: no other field moves, and tcp_sock
> > size is unchanged. tcp_queue_rcv() now samples sk_rmem_alloc, and
> > writes the credit until it saturates at sk_rcvbuf, so that the fast pat=
h
> > stops writing it after a full buffer of new memory. Saturating at the
> > goal would not work: sk_rcvbuf, and the goal with it, can grow later
> > (for instance in tcp_clamp_window(), just before the goal is checked),
> > and a socket over its limit can not earn more credit until the
> > application reads.
> >
> > When collapsing is not allowed, tcp_prune_queue() goes directly to
> > tcp_prune_ofo_queue(), which is cheap in the cases above.
> >
> > A regular flow can see a difference when it goes over its limit before
> > 1/8 of sk_rcvbuf of new memory was queued since the previous collapse:
> > out-of-order skbs can be pruned (even for an in-order segment filling a
> > hole), and an in-order segment that still does not fit is dropped,
> > with a zero window advertised, where a collapse might have made room.
> >
> > Fixes: b0e01253a764 ("tcp: refine tcp_prune_ofo_queue() logic")
> > Reported-by: Chris Mason <mason@kernel.org>
> > Signed-off-by: Eric Dumazet <edumazet@kernel.org>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal
