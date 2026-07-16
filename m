Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372FE328616
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226781; cv=pass; b=X4NDZHwpbJ20DwfTtVHv6FugmF7tqHYYiGbDx8UHEgtc3Q34BXVXLw/p9MhSKG2WY1x9vfWb7opLB0M1r2sM7MixBCqe2FuW07CtjnWq/gnmpyDnupgxYQqc5f++Ap178wzeC5NMfdASHHOwYJIRR4VVy83Siy+DvyCYr9VhKxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226781; c=relaxed/simple;
	bh=ajwTxekkF3zV1IRBLCIVWPkHfTOXCaPPKAh0nXr72VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjJuke0RR1zfJeEhmACP/7ERC89X7YyrjBjW7oDEcOk/OTrD7fvjNlac+PnATFnThvSYhLU016FXj0ZM/f+n2agh5zqVCY7u3+UscBYxZ7bX4k24WA1CrFdCgy8Wr5l6ARTVVYEQKTAZOFJ7An7uB2Lg0ONGspMCWvF7fy6ygrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=YwW0548H; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="YwW0548H"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso633295a91.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 11:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784226778; cv=none;
        d=google.com; s=arc-20260327;
        b=UxCsFGcMXXNFPJPLVAIxQ+nNlLsYYD4gzUKbVitSS21Pp1DDfPaapH2fO1RdHyvDcV
         rz1xrGRHbEuf7X8WVnry4wQHbupoqccCaSU6P1L7oM46p1/r1la4lbUaaB6kSQQnGGb8
         z3IYMfvf9LHnr3rxrsclweQK76/Qxiv8xVdyHjNN6Vmp3aARSuh6BcJARgzTRbLBEoXn
         jScaUbIR6ZoFh1iQNGooOnMQ4obVxAFTKOezG0sO59jnXYFwKFStEPVrjB3E8JZH6F0H
         /v0sA1obz4GRU0T8GajpCeLALzVBAmYS+33Rhm23cHn3O2lyG+OihDr8NBuF/JQrajQo
         aJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sFLi2SejFpMDhey9kvFVKWRtUJVSV+cPwvwGIcXMgGU=;
        fh=cxfyBmHHqMkCuZ3Hle3smpR2GPDqof5Wp4ihBjK/MNc=;
        b=ATezBJijPYGfT5v7dkYTNa63A/uAqGcWEuCQa23GE0WxH1nxXs77ivEVYVtVt4q073
         JVybcVwFQx++E0UZZ0WGkGHQkIAIw6KO03VmTRjMxgTCsFf60NudF//T8lXfChDm5MgZ
         zVifT6a0xexR/LSnfNkZ4kNkw4F610bk8qHQCv/US6U/Vesaa9qgbl1uBARiyY6TooFv
         MuVgCEFYhD5qwFFgw3M2cDkdEK09KLRwKp2N2dfGC1fZHtpFzb1DYTdrwEsDAyFTJhpm
         dmm4WV8EXd8Y57GNyRpfT9/cvyrlldK2Ucrbo2GAJGlNG7LooWvyo9JOYi5HeTkpxxjL
         nw1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1784226778; x=1784831578; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sFLi2SejFpMDhey9kvFVKWRtUJVSV+cPwvwGIcXMgGU=;
        b=YwW0548HsBJZiIfjnP6d+7IShGzpp2heaMcf3mtgxb56eVwZ9EA/tZAthdmvH7mALC
         17/7YpfGMENpmpRv0O95zQeb5pLLl45dIIRT2LVFXd71rxx7ZChv9L1gXSX1AFpU6g0j
         ipht62ZEUO2yaMGlfydhhI67vtlNu7U4QZPk4EiU7//3q/BMFGw4qnFc9VwVEqkwl3Fo
         apQ49UE9fFJbY5OsCc5xoau9qyXCXCTgTknQNJBH+bLE/TvAObRwIZaNHuKFMEyCpwBg
         gpSIpirREkzKqpXdAYb3uA54YjtsYwVhCjK0vkpVvEwgXjyYPuajDvwDt+GomKjTWrKQ
         4RzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784226778; x=1784831578;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sFLi2SejFpMDhey9kvFVKWRtUJVSV+cPwvwGIcXMgGU=;
        b=CQsHK4/Wnpu/j/4FkMWDNywjE4xlbq8l0qrjOJlAFSEAKLcqOYFrMRJnpMLbls3Oaq
         uE3VAZmQZhgB/UQhhsOp830q8+Il7jG5W37hXfPrl8wehvegCJfYSb3bU9pSryDCgTaa
         OI8Lx2UEUzk38QWbNJXyt+shgxOWcr4MckHBQqJ5W/y6gS1vJXbLcy3rNUcZbdPe4iq+
         sbHpI+rSLUZXXPaI9C2fXdcl/dS2T+Ee9IREWl998ynla3HAlelG8NrEAC+sPEXrIgap
         TsOqCYp1atAeZFCaYBrMhe/n4S1qgU+kckrgoyaJoiP3wS04QeXgTLNlxsMUjLveX0o4
         p0uA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6ueZtJ6LMt6JD9BeWjwl1RpOdUlAhnl6JMARqrxFpnUoX/3DweuLJXwGBjPAhK0j7nh4Z32w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMq2UB8KNj8omCdFPo1IV8JtOf6UK9bjwpdqOexAsRlvBjuzme
	byRMJHGsaqBl1iqhLaUijxzecjYfIwkXcwhfeFry9K8nTyrqnZs503qyfmHShXycwA0Ha3b6U5y
	7J9kuiJAlprmGnbCE6HYGwsuLVycvoUOFlXnWZDk0Mg==
X-Gm-Gg: AfdE7cnzGJHiNEXvYcYD1hQoviUyveHsfdI44kuYn0ljlecJV2Zyvz4z2C4QD++9wKY
	CR2KrQYE7brlvKm/are+kwkRFOIICsZ2onsMtxB9AqnzRrR1jDvBf/x3Yg0GnH02Gr7dUwSHlWy
	bbs90eSnkVjFKzCk9GA7OsxCI8vWTTevWFPjkBe/mnkkZZI1Z+WRtJBv2i1ixSi+fNTj9o9AUgH
	y9zNfZh6c6FpcP+SiMGJz6kmbPtADT2WhQpk1ViUPYF9apA7sQVZIpMUNGS0gYJMxjaEfEgqWAu
	qMr7s3Y6Shiv400x9EGjRHW6NubqBoBZYMARPOlXd4jlN6rX
X-Received: by 2002:a05:6a20:cc0b:b0:3bf:a0e5:999f with SMTP id
 adf61e73a8af0-3c3a5aee53dmr396730637.22.1784226778301; Thu, 16 Jul 2026
 11:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710134242.216538-6-alice.kernel@fastmail.im> <20260716144805.336424-2-horms@kernel.org>
In-Reply-To: <20260716144805.336424-2-horms@kernel.org>
From: Alice Mikityanska <alice@isovalent.com>
Date: Thu, 16 Jul 2026 21:32:40 +0300
X-Gm-Features: AUfX_mzfjspddebkNRtKmT3XCaxUwLoWF092aSdvFX4Dp51fQcHl4pBtKL816JI
Message-ID: <CAD0BsJVNtu3ENqpqQFfO0J69gBZxoN8iMWRUnF-GdrZ2uaAy7A@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/9] udp: Validate UDP length in udp_gro_receive
To: Simon Horman <horms@kernel.org>
Cc: alice.kernel@fastmail.im, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lucien.xin@gmail.com, 
	willemdebruijn.kernel@gmail.com, willemb@google.com, dsahern@kernel.org, 
	razor@blackwall.org, shuah@kernel.org, stfomichev@gmail.com, 
	andrew+netdev@lunn.ch, fw@strlen.de, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 at 17:48, Simon Horman <horms@kernel.org> wrote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> --- Patch [5]: [PATCH net-next v9 5/9] udp: Validate UDP length in udp_gro_receive ---
> commit f1316d873c7549e0a49dc98d7614be1dc5b0f66c
> Author: Alice Mikityanska <alice@isovalent.com>
>
> udp: Validate UDP length in udp_gro_receive
>
> This patch adds an early check for malformed or padded UDP packets with
> len=0 at udp_gro_receive to exclude them from GRO, moving the check out of
> udp_gro_receive_segment.
>
> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > index 4f9a3922937cc..8f77c8788f6db 100644
> > --- a/net/ipv4/udp_offload.c
> > +++ b/net/ipv4/udp_offload.c
>
> [ ... ]
>
> > @@ -782,8 +778,14 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
> >       struct sk_buff *p;
> >       struct udphdr *uh2;
> >       unsigned int off = skb_gro_offset(skb);
> > +     unsigned int ulen;
> >       int flush = 1;
> >
> > +     /* Do not deal with padded or malicious packets, sorry! */
> > +     ulen = udp_get_len_short(uh);
> > +     if (ulen <= sizeof(*uh) || ulen != skb_gro_len(skb))
> > +             goto out;
> > +
>
> [Severity: High]
> Could this early return bypass inner GRO flow matching for padded UDP tunnel
> packets?
>
> When a padded UDP tunnel packet, such as a small TCP ACK inside VXLAN or
> GENEVE, arrives in net/ipv4/udp_offload.c:udp_gro_receive() while previous
> packets of the same inner flow are held in the GRO list, the
> ulen != skb_gro_len(skb) check evaluates to true and triggers the goto out.

Min Ethernet payload size is 46 bytes. Outer IP (20) + UDP (8) + VXLAN
(8) + inner Ethernet (14) + inner IP (20) + inner TCP (20) is already
way bigger than 46, so "a small TCP ACK inside VXLAN" won't be padded.
This check should only trigger on actual malformed packets.

> Because the goto out path yields pp = NULL and flush = 1, dev_gro_receive()
> passes the new padded packet to the network stack immediately, leaving older
> packets stuck in the GRO list.

The early return does bypass inner GRO matching, but it does not
normally deliver the packet immediately. We call skb_gro_flush_final,
marking the current skb for flushing. dev_gro_receive then classifies
it as GRO_NORMAL, and gro_normal_one queues it on gro->rx_list. At
NAPI flush, gro_flush_normal first flushes held GRO aggregates, then
submits the normal list, preserving order in the normal case.

Of course, gro_normal_one might submit the normal list early, if
gro_normal_batch is reached, but it's an edge case, and we are talking
about receiving malformed/padded packets, not something that should
normally occur in high-performance TCP traffic.

> Before this change,

...the same flush mechanism was used for UDP GRO packets, when a
malformed one occurred. It could hit the same edge case (when
gro_normal_batch is reached), and reordering is more unpleasant for
UDP.

> the packet would reach inner GRO handlers (like
> tcp4_gro_receive()) which would detect the sequence or padding mismatch,

The inner TCP handler won't detect padding at the outer UDP layer, it
would be done in inet_gro_receive, which will mark the packet for
flush.

> set flush = 1, and return the held packet via pp = p. This ensured older
> packets were flushed to the stack before the new padded packet, preserving
> delivery order.

If this edge case is important, I can send a follow-up that addresses
both the existing case (UDP GRO) and the new case (TCP in UDP tunnel)
by separating ulen > skb_gro_len and sizeof(*uh) <= ulen < skb_gro_len
cases. In the latter case, I can mark the SKB for flush, but proceed
with the inner GRO handlers, so that they could return the held
aggregate via pp.

> Will bypassing this inner flow matching lead to out-of-order delivery for
> the inner protocol, resulting in duplicate ACKs and throughput degradation?
>
> >       /* We can do L4 aggregation only if the packet can't land in a tunnel
> >        * otherwise we could corrupt the inner stream. Detecting such packets
> >        * cannot be foolproof and the aggregation might still happen in some
