Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F3A413791
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267880; cv=pass; b=qci/GJxeQ1KJza0jVIDD1yx3yjL2sVk3DRPYTLwyd7mD6/pQ71nB/jjHdJ3jKkY7J1R4FRLFjTBSqf/lxb6jOi5WWY+8IjHTKKGT0g3SofJIUjn1sxC/FF0o5yP7RCYXc82tQjJZ3Gkun86eJYZi56GKtr+K8fwwm90w8yEelAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267880; c=relaxed/simple;
	bh=8DhApwnuG2SUXRqEGXwamkFlChUC9h4uRKP2o2goLGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bi6YDCyx+qMAnn05mz/+ijtL7Yt6Ty385NwyK/xCKvcC9JYR02+30g9kb0vihRrYsZPiQKCwH2FdV4ArwXFE2SvJsRTtYEEal/YvuSOWq6aY0pRmremPUvoxibjMlSKAGRElBEtkrOM3k6aiC1JF7NQ0nP1OX3bUu3EHmfGB2BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eu2aeafy; arc=pass smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eu2aeafy"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532d63f434fso377111cf.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790267878; cv=none;
        d=google.com; s=arc-20260327;
        b=L8ajOWpBo9C/sx0+lN2rcDrkmfhBQYbX1W0wGe9xabV4SrYlLIlIEv0oefVDcqzfAx
         ZclJKvIVl1teugjtJZ53ohX73LVis0k5f9sBcWqH/Su2ITVVteU0EftuPgYSew2MmJph
         /UxNLrQuzkimy0bql4W6aZupfIpGYxPHyM5mm2Qv7QEqIQ/IvDIdtDtoERpvVrFx2EpD
         cm0BytNYFXXPG3LsRolioH0pfN47+Wfv0asoAMAouQZCT8OmhNcIznR2H+gx3dRA2avb
         LYMHi+sxZH9JluU/keDGsZ1FklbvJts5uPApqUeJ1QAZD1OYzM7mIFrsZlTGR8CocWuw
         CuAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0t7BSzswocE9VaUuD88aROz/tY5wZD53opr7p8td3kE=;
        fh=vYhXJBt0TLy/SNVbCdUZdIyxCOuKMGkYGhpDbLLCPJQ=;
        b=AIpgXty5FvqxIoKd9HwO84qeXGWyqP+zxUG4ju9m94uK4J8LyIT4b/7uJRsrzIJKuE
         2QxdR5c91uMdTbcJfqTDUkzVKpvhAwcBbYSbBqdpAsf+kJWiyJfqbUI0guA6lzDneii9
         ILdrfxEZEDBjXex1g9gv4avOWGnmeam2KSRpNcNEn6KMMkAgLY8KqQMVlVDVO78kAftu
         eAAY4EeX3qOKGoDt6UnYaAIGQbvUrEY4H8mxhzJCRCxbDF9HrdjPWwlvxDm+lfK2vhx7
         QSf7kWMjRHxBFWPBSJMnuSRFiJMlRZ7X5sOmDTaOhpr6vkR2v17ci7FA8gKWemCwDh/b
         9/AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790267878; x=1790872678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0t7BSzswocE9VaUuD88aROz/tY5wZD53opr7p8td3kE=;
        b=Eu2aeafyf4TKHbjA1fT89Xz0b30d/45EfZoA4kJxDvf14RUhyqv0qYBGdN3VkvML5O
         KK569ZYCi/MdAMUdOg5tl/+0YFG9tDI/A5NyTBF0yW8dlGfNo9st8mmR/bkFPDwsP3Xz
         PylIZj4523BRvHXne9K63sxaCp3bBxeLGuymqnHxnm7AewMDSWryzTqKcIjmoAvUWByk
         lzx9ndQeZAqOuYBJ+BKNoOodlrnfJj4Nkkg3FKi5GHwS4ez5A5+LLiovzAtIF2xv2e39
         vEPAccQYSYL6XfKV7/n0yCKBQS7Qdw4XO2A438VQBxAWp9xo9ZkJHWC44tEhHSTkoRcF
         4HaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267878; x=1790872678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0t7BSzswocE9VaUuD88aROz/tY5wZD53opr7p8td3kE=;
        b=Pbk1pN7YbkHaZaXACvkvVfP2a84Jwz5cc9J5pqw4/2FH2yPstJrkvoIzatW1+qbtPJ
         vEl/96ISkEEdxwNzJ2JEbfU0YlHpM+vDws7txvzmzOyK+OFbm0BzFblIhqybc/UUuLII
         RmJj+4CPeGy5F1zYehCPIxUPK8c7cyo+7saPDHmIuLOkNPgvAtcxn6k8Wcyws8hhEvJI
         PSboo271J9f2PT6ful3S8xV/bHHGHdXLCruZ1dj0FZcUpgPsUG19wbY3bKMrMQi12fmv
         yvzQAokF4LaltWn1H6I/1Ngglp6MSSREcCKG4jLhpcGVZGwlkK7ob1TLh9AfTTmV+jxC
         3//A==
X-Gm-Message-State: AFuF++nW+MrHJahXxca3lDFkOtcjuvMx1ZhtKQOj6Hm43gP/mREZyex3
	r+Fq70/4EBpCvqUdy/70Bmqm1/qW/EXVtS7nQcwg1oCHZ3d68lZX/0omDORlnRbfVWzsQ5DNjLS
	p1GsbDctNOQYwtU6kgkY7UshXEnsrUhUBM+C5TWNIfbfpM++S3OLp0DDO
X-Gm-Gg: AYBFou0r3GZFpDbkzXpHdObji4IeNPPB5O/wF5hHszfsAXK8l61IlKP180lKD9fcw7G
	9/FqpeH2jVZkqJKuvHOAnndHHgcj1O1r7Nlr7icpLSzcu1LKgtdXMi0rq6S0kVE8vDD9UMpgcfC
	q3981Yt8S6R6vyZk/E/Mrmm7GEhvxZFrCNm7lt/Hv+QbNj8n0eA44tfhjSiabqu0hA59Qs/UzsO
	c6bVe18TkP9AdzXbD4EYcwt5x8TQ3/LCIQTOj/VnuqmxNw6Iwlu2/rFqzNeNSFO0ZTzBWywrl1O
	zhB7+Nr1/3ASZYcGWxnBj7KmmFqtV55VosN1Z/mDK66Awoarx2HqC+k/5KqHendZWNBW2lVKZMV
	iGWxVBc+60lGAnslESkdDXOwhVEBVQgbhr1FMomGG4x6q6LvKU1ExmDDnUbMdbMKHzpU4
X-Received: by 2002:ac8:5f0e:0:b0:532:e4bc:b81b with SMTP id
 d75a77b69052e-532feb5ac3dmr31404411cf.46.1790267877634; Thu, 24 Sep 2026
 09:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924154427.953800-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260924154427.953800-1-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Sep 2026 18:37:46 +0200
X-Gm-Features: AclHuK_p6hC3gQAmvi0ifLB2kr_OPUO-K3WBvQ9rf3FXHeGGU6WjgCdFPaSV-XY
Message-ID: <CANn89i+b=8F-1uoDW1Cdx7EVAtjDgCGtamQfF4wkiSXmSPq0TQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: prevent collapsing skbs across boundary in rtx queue
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, dzahka@meta.com, 
	john.fastabend@gmail.com, sd@queasysnail.net, 
	Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 5:44=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> tcp_write_collapse_fence() sets TCP_SKB_CB(skb)->eor =3D 1 on
> tcp_write_queue_tail(sk) to prevent skbs queued after a switch to
> device encryption from being collapsed into earlier skbs.
>
> The fence is a no-op if all earlier data has already been transmitted
> when the switch happens: sk->sk_write_queue is empty. The not yet
> acknowledged earlier skbs wait in sk->tcp_rtx_queue with eor 0.
>
> On a subsequent retransmit or SACK shift, tcp_retrans_try_collapse() or
> tcp_shift_skb_data() can then merge an skb queued after the switch into
> one queued before it.
>
> Both users of the fence are affected:
>
> - psp: devices only encrypt skbs with skb->decrypted set. The merged skb
>   keeps decrypted =3D 0 from the earlier skb, so merged data sent after
>   psp_sock_assoc_set_tx() is retransmitted in cleartext.
>
> - tls device offload: the merged skb straddles the start marker set in
>   tls_set_device_offload(). The software fallback (fill_sg_in() returns
>   -EINVAL) and the mlx5, nfp and funeth drivers cannot handle such an
>   skb and drop it. Every retransmit rebuilds the same skb, so the
>   connection stalls.
>
> Fix this in two places, for defense in depth:
>
> 1. Fall back to tcp_rtx_queue_tail(sk) in tcp_write_collapse_fence()
>    when tcp_write_queue_tail(sk) is NULL.
>
> 2. Check !skb_cmp_decrypted(to, from) in tcp_skb_can_collapse(), as
>    tcp_skb_can_collapse_rx() does on receive. skb_shift(), which both
>    collapse paths call, already has a DEBUG_NET_WARN_ON_ONCE() for this
>    condition.
>
> Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!
