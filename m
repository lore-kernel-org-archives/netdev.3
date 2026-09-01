Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BF436EA88
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245470; cv=none; b=KXDdxWMPUd+hW+1MmAZyiPXOK58uP/SZaQEQ2D13rS7Pi/FTNiVCV2NEZhMuG7JZk7jQN8LiNbM8GizQM4sLFy6kEajhxqT887u31vqVPKEroX57ZjUPHKR/aNj9+7aKAjyC01jNEAYRFZorI02nQdpVsGe24pH83veV6Y/3OLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245470; c=relaxed/simple;
	bh=LGdH6U9mAH6qxn/ShC1rVe7Dyu68vZHEmVilFJFaPo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCIvLYqXWPyhCPzEmzlla/QSSSUiW/ux/zwrZHABFqa5B8skRIOukOh9yrv6VTaVcKYhefQ5s9jvcPSA9STYQtN5dkTlisiVCv7jDGDSH18/QDcneF5JvjGd0+F4DQiiodJNFG3xbfCH+sTVeN7f6JDyRhQnDPjwQ+DuhyAWP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnoC3mTq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnoC3mTq"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso5463965e9.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 23:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788245467; x=1788850267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4SkfTWln0lL0sRW6IjxX7ZdRkCrrTOmOoXec0R/G5A0=;
        b=lnoC3mTqoFvZRDw+AJEowY34XSZjKfNpgozFcoA/HRwIm6DGb7ZzSCbB4s21ZH2aUo
         esIXEkfCGxKPzPoqj1fXYGZt7RX9ag9Q2Y9FGYrlDbBpDr6eF9snwhH1q74kAQtuNeSA
         kQqH/N7j9nY0NX9RSJD+3Ob8H5w5Fe1pitLHUvgPzSzkZhQsLj0OUQTWfq8XtISHT4Kg
         Py5eJgCFLmLr4upiYd8Otu6mS9BiPW9R7l0WbGCnNz+8pfXDuJ2QD9eyU9F4llb7AKsE
         Vql5DW3KYc3yKlH5JIMe8nA1lVoOR6aPHZe9iTcpZuxk1zl5QkyomOTCIPH2rMCclHjw
         mSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788245467; x=1788850267;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4SkfTWln0lL0sRW6IjxX7ZdRkCrrTOmOoXec0R/G5A0=;
        b=lC3ho3+jDPgHhgSPi1Luf4j8JayMZSGCtKQcuxgXjh48XJloyJkxe6IctUriO5hYMp
         B0TAgKUVAYliIOkCc6UTaUqFXJnzRfRWlRjeFMbX6ru1hz3HZAKgaggOxZSAOzdQtDDE
         NL9dXndm9jqjZBMbVh8zYbSlLklXEqhIuqNvbk+vMrEXITb83TJ1ROzh5ipJXTfWICCX
         fzHoLVFUE4TK+MBVBIPEjJVHjYINJOKzR/aptivJIAPsuYhKnZs/bjuWTFune8otaMBo
         YmFzpaODxxnlQwtxMiktsDlkG5P+jcvnrJ54QJA0yz9Tym2Iz2cEj9z/qbSXRBrUPWQI
         dN/g==
X-Gm-Message-State: AFuF++n0QMKgA1tZXzqsFMX4eQunE/ywiCS5q9TjBqdjxSlMJGJUFfRx
	9wVc2sAjLvv/BwgaG2Jfcnb1Ua8HKgFaXUGMuDMk+KphIfjGddrBq4DR/LOos5SX
X-Gm-Gg: AR+sD11/ca9eP9FV8gTp6GIM+/8wmntaGAORpsaBvlJTF7rjqPQZCqVnNKjk+9iA/ro
	r0qwuzu2lq2lXZ6vwOHxtbKL5rKzBYK40JJV8vV3y3kA4QiF8o8OQgqLqf2XqHjlFYQbY04n6Fm
	VZkf3IvWCtOpMqQ2CR6smqTpAg/1KWFA4BKKQLmBpyh7WLwAtYGFJKuxLs8zzY7RR20MSGmjIiq
	AGPn6lt2KUyuC2RbCJIlM3gqdzKp6dW2Z6XXjWP+WY/9xjWdixj12tzoIYHfGvbBOudcnCxbtX7
	Lo+4XLZAmC2x8GedS9RBHxr3shHE1cO+3knZ/e1e0RFh2wvp+GOqnRt9SrLid8A9e3q8Qo4vtM3
	IvfoWccBoviiDTgRurunY7TXZGwKH2Jjw1RfNJ5xuy5gp+lLOxvZYmYIejYkF2YycgZvN63euEl
	g4UyiHYmPNELJEvSurTZAxf6XFD0ZOXqphCHWbEkToSNXuxMidWD5g9w6j/NBSj1wrv4xmzFTnk
	Qn14pVmNXENeVTYXIA0OBWZmXZ8OceFmSMmpQ==
X-Received: by 2002:a05:600c:1393:b0:49b:12c2:104f with SMTP id 5b1f17b1804b1-49b91c2660amr443895025e9.1.1788245466246;
        Mon, 31 Aug 2026 23:51:06 -0700 (PDT)
Received: from gandalf.schnuecks.de (p5b2e278a.dip0.t-ipconnect.de. [91.46.39.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce199aasm47339235e9.11.2026.08.31.23.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 23:51:05 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 36698331E063; Tue, 01 Sep 2026 08:51:05 +0200 (CEST)
Date: Tue, 1 Sep 2026 08:51:05 +0200
From: Simon Baatz <gmbnomis@gmail.com>
To: Michael Cohen <michael.cohen3@mail.huji.ac.il>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
	kuniyu@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org,
	Tamir Shahar <tamir.shahar1@mail.huji.ac.il>,
	Amit Klein <amit.klein@mail.huji.ac.il>
Subject: Re: [PATCH net v3] tcp: reject completely old segments during
 sequence validation
Message-ID: <apZ12fl9ShgXBAGD@gandalf.schnuecks.de>
References: <20260831205611.2439538-1-michael.cohen3@mail.huji.ac.il>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831205611.2439538-1-michael.cohen3@mail.huji.ac.il>

Hi Michael,

On Mon, Aug 31, 2026 at 11:56:11PM +0300, Michael Cohen wrote:
> tcp_sequence() rejects an incoming segment when end_seq is before
> rcv_wup. Since end_seq is one past the last sequence number consumed by
> the segment, this misses the boundary case where end_seq is equal to
> rcv_wup.
> 
> A segment that consumes sequence space and has end_seq equal to rcv_wup
> is therefore allowed to reach later processing, including ACK handling,
> even though it should be rejected as a completely old segment.
> 
> Reject this boundary case for segments without SYN or FIN, while
> retaining the existing behavior for control segments and segments
> that consume no sequence space.
> 
> One consequence of the early rejection is that, in some cases, a
> completely old duplicate data segment will no longer reach
> tcp_rcv_spurious_retrans(). For IPv6, this may prevent a retransmission
> with a different flow label from triggering transmit-path rehashing.
> 
> We accept this trade-off because the segment is completely old and
> outside the receive window, and therefore should be rejected before
> normal ACK processing.
> 
> We consider preserving the RFC 793 and RFC 9293 sequence-acceptability
> boundary for such data segments more important than preserving this
> side effect of processing an otherwise unacceptable segment.

I think the RFC rationale needs tightening: RFC 9293's acceptability
test uses RCV.NXT and RCV.WND. It has no rcv_wup equivalent.

Strictly speaking, whenever rcv_wup < RCV.NXT Linux already accepts
more than the RFC check (and not just at the off-by-one boundary
this patch targets).  I take it that's deliberate: a segment can be
"completely old" as data and still carry fresh control data.

But that's equally true in the rcv_wup == rcv_nxt case, and it is
exactly what lets a non-SACK receiver reach
tcp_rcv_spurious_retrans().  For example, before the patch:

1. peer sends 1:1001, we ACK 1001; now rcv_nxt == rcv_wup == 1001
2. ACK is lost (e.g. a reverse path failure)
3. after RTO the peer retransmits 1:1001; the segment passes
   tcp_sequence() and tcp_rcv_spurious_retrans() is called from
   tcp_data_queue()

So the "unacceptable segment" isn't an obscure corner case.  It may
be the ordinary retransmission of the last segment, which is the
event tcp_rcv_spurious_retrans() is supposed to react to.  What makes
us confident that we may just drop that functionality?

> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Michael Cohen <michael.cohen3@mail.huji.ac.il>
> Reported-by: Tamir Shahar <tamir.shahar1@mail.huji.ac.il>
> Reported-by: Amit Klein <amit.klein@mail.huji.ac.il>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Michael Cohen <michael.cohen3@mail.huji.ac.il>
> ---
> Changes in v3:
> - Group the old-segment checks behind a single unlikely() branch to
>   avoid adding unnecessary cost to the TCP fast path.
> 
> Changes in v2:
> - Exclude SYN and FIN segments from the boundary-old check to preserve
>   existing SYN/FIN handling, including simultaneous connect
>   and retransmitted SYN+ACK AccECN processing.
> 
> Packetdrill reproducer:
> 
> // Off by one bug in tcp_sequence()
> // the negative test before(end_seq, tp->rcv_wup) has off by one error, since end_seq is SEG.SEQ+SEG.LEN,
> // whereas the RFCs require SEG.SEQ+SEG.LEN-1 (their positive test is RCV.NXT =< SEG.SEQ+SEG.LEN-1)
> 
> 0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> +0 bind(3, ..., ...) = 0
> +0 listen(3, 1024) = 0
> 
> +0 < S 0:0(0) win 12345
> +0 > S. 0:0(0) ack 1 <...>
> +0 < . 1:1(0) ack 1 win 12345
> +0 accept(3, ..., ...) = 4
> 
> // This is not mandatory for the phenomenon, we just do this to increment SND.NXT (set SND.NXT=101, retain SND.UNA=1) so we can show
> // later that the problematic segment is actually accepted (via the tcpi_accepted_bytes count).
> +0 send(4, ..., 100, 0) = 100
> +0 > P. 1:101(100) ack 1
> 
> +0 < P. 1:1001(1000) ack 1 win 12345
> +0 > . 101:101(0) ack 1001
> 
> // Now RCV.NXT=1001, so according to the RFC, a subsequent 1:1001 should be discarded.
> // But in Linux, 1:1001 is accepted(!).
> // Note that bytes_acked is incremented to the packet's ack number, which shows the packet is accepted.
> 
> +0 < P. 1:1001(1000) ack 23 win 12345   
> // +0 < P. 1:1000(999) ack 23 win 12345   // if you use this instead, you get an assertion error, as expected.
> 
> // this assert will succeed in the presence of the bug, but per the RFCs, it should fail because the packet should have been discarded
> +0 %{ assert(tcpi_bytes_acked==22) }% 
> 
>  net/ipv4/tcp_input.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index daff93d51..10e49e6e1 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4844,8 +4844,12 @@ static enum skb_drop_reason tcp_sequence(const struct sock *sk,
>  	const struct tcp_sock *tp = tcp_sk(sk);
>  	u32 seq_limit;
>  
> -	if (before(end_seq, tp->rcv_wup))
> -		return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
> +	if (unlikely(!after(end_seq, tp->rcv_wup))) {

In a connection that sends unidirectionally, this condition is
unlikely only on the receiving side.  On the sending side, all incoming
segments (pure ACKS) fulfill rcv_wup == rcv_nxt == seq == end_seq and
this becomes the likely case. Do we rely on header prediction
filtering out this case here? (this may be worth a comment if so)

> +		if (before(end_seq, tp->rcv_wup) ||
> +		    (seq != end_seq &&
> +		     !(tcp_flag_byte(th) & (TCPHDR_SYN | TCPHDR_FIN))))
> +			return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
> +	}
>  
>  	seq_limit = tp->rcv_nxt + tcp_max_receive_window(tp);
>  	if (unlikely(after(end_seq, seq_limit))) {
> -- 
> 2.43.0
> 
> 

-- 
Simon Baatz <gmbnomis@gmail.com>
