Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2595430CD9
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823251; cv=pass; b=EeBcifxo9ChpTmusB8/GU40vRHkwsyp14TWQUGO7hErmbT1yoXj6QO0wkjnkEfRxcCecclYV6P4sGQuFX2JihaP+ru2bAUHZ1R+qfF1e9Wa7LjW8qseuk/2AcKJHAhxNpA8nkYFFg7HNXOq5PEVlstT92JXntoOpl5lz4QQXq7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823251; c=relaxed/simple;
	bh=5EyTWGbrjpovbC1C8lOry3SsNkog3rmpA3AYwNnqkCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWF2w6SrgSGJWnmM/3lBRWbVgHfbSqSvJyLrz7dZTGd71sHmpAWmuJIXyQgPW6ZZNFldMlktrYlw2SyOkkNfkVtesP1IKJgt2gSYPQ6sFkRmAj8EbqI81k4VGI4ttHNR/ZZegW00qhPjfgqyyXLxNxHkVUzMeQsC9eeQiMxkOmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+ksQOUr; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+ksQOUr"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-857f1be346dso12634157b3.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 02:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787823239; cv=none;
        d=google.com; s=arc-20260327;
        b=H8F+KSZjPeI7UoXrCYEQm9MYEJNJBSJsYr8alw+pVP4otxSqEvcIep+bMA9agplp8a
         zaXANOncp3Sd9vzPNecPp50Lvm6jHm77i57V5GoCJYnSKXtgpIY1Y1Li5pIj0JlCXfmS
         9NTWPakdBOWOaaVQT00J+sRbpIVOQlNq03SGuyUl7qkcYayhbH8lX1AyX6VpdKN0D7go
         1adNWP5Sch+V02DaiPGoVh1hgCgua5d0LWB45pALWo05qX80p7crlMaXSVEbVVP2XpLv
         drHjJbE4Zb4ypHtShaxBPQQULMOHxZX9P+p8+wrHPGRPG71I4o2Emxan3wzTEboq7yi3
         tr9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=khqYCS3VgRg6NGeQDXOVHcDgNOpIHLNEKQsSVLXkNcc=;
        fh=JD1FOocgdHbOtVH8BP8bG2jq0g0EUdX58R+8656cQK8=;
        b=pRdC0zmL94NNekKyw38tiwfnSQ0VYr/R65IseNNxRROYDBVnsOITTgNC487agvo16V
         xj1B9VnOOH3m2ftFqtKiJAWIxRcVhwurGZJsCQJdnNE/bjIWgZS1hwAMNtNU1j64QGWV
         Pk9LF8lP0eDJYW9NHQZyE0bYntgh6ICEdsATAYDXQ9lqUSc216uYAfw+sTG/5/fsimNr
         7T0ttlsLfEBBSD22QlqCt166pYwiAvFvaS7oYGIrOlTVZqVVZGz6S/SQz6Lss7KJA8ZO
         ti1nczYzSHlNmyzpQBZyeb9nhvwxusaq9FGFKMV2LpH5QYWQd7k9FvzfRCkfbIsToZl2
         Ykig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787823239; x=1788428039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=khqYCS3VgRg6NGeQDXOVHcDgNOpIHLNEKQsSVLXkNcc=;
        b=G+ksQOUrWtjxciGsxtaz4Zk7MHgYd4q78DS8zxbaO3+X0P9rYKdXQ5JtJsW+WV6kSW
         P6ktIV4yQaKI9jhHXP2wbUrzCvb5kfNs2Q7hlTpaAyyGK+1CWviOq9ZxYlM+SdqmBIsH
         rNCaF4r8kQ/nICZEdJYwUe0fPHeoFRUqmbTJnT6HZCG2UVlN0CxeE8u4adMjkTf0ws83
         MYcZZPXvelAyq2cKsEMDZ9eLBZtUheWc/4To4DtsMO+62apXLttbilsQRTgghdbPZP4Z
         yrKlJ4Jjjvvs6FVY+hfQauPaNtWWeJXKDI2fjYaw5dzxC4UusmC7UX9Y9Y8m5zV+OI3r
         6qTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787823239; x=1788428039;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=khqYCS3VgRg6NGeQDXOVHcDgNOpIHLNEKQsSVLXkNcc=;
        b=BgntCy5sUR+uJCfgBAd7KM+XPaQQCfBgOt+BicXuQFvo5cQOKSDXj34+evXwOXa1A0
         uhXiYXyN3ov6Y7vaecBBLmnLn2TsUe27cmWowra8DViOmWqShlwll1e2DLYBYW+rYiWL
         oBZX82nwqu0m/X2t+p9VMN168uej0dCdy8RN1t/RwrNLPHLA7qE/Ba7s1wfqIyr+m9qi
         voXmsTepi1C8VOxaUXJ8Bf8GPUt4sMSxpgu4T501QdAdCHu0FkwvY68g5zVTB9pjm7S+
         h4udbfOimz1VTUOr39mr1NzS+UnWVf1JMXLgdjH/RS1IuyiZQ3PTx66LcJ+HYxKWs8q2
         FEVA==
X-Forwarded-Encrypted: i=1; AHgh+RrRa614hLD2aRNSCCuIx7VQn5IaK8l10l6wRY8EKfhfsjvlRmYNDTtWo+Zi46/Dej9O9XXPxus=@vger.kernel.org
X-Gm-Message-State: AFuF++lSiVDv1tvxCF9KlNywqNHux8cy5dHoALcnJGnXzUE0s0LHrSOH
	PI8Juwq9tAJdv2YWQa7EAFNvk1my9sGSWVHEPV7TTrTo/XvWismkcWNaAw8piBPgfaR41xKegc+
	sHlpCUAAT18Jgwd7gQRrlVM6vTk3r2M0FiqTWILepHRvtV0G2I4a14xiNYd0=
X-Gm-Gg: AR+sD13uDOCwv3nirJsUzQDq9es6ZbnUVBwSA9rH/aKgTgNkz2vqZXBRFzQ5Q0wLvAX
	h1+VaHin8SXFhKqRIfHbIDCjZpZnbGa9SJTzRyczD+VSQ+HcazL91npnk5WptxDDZFz8P+8uGSX
	KYJLImEJmP+T6qM2FtJp8H9yfyli409fF6AsDMFGKT4o6U9b59ofLZa1hrtNyuStphB9kVmeRkZ
	HYeYv93OQKDwUHM9LZcEjrcwDzB3Gq7V7ovOcu8N/KiWwW8i+/eYfm+4tZ5oKF5Yx8lFTT9IZ6E
	hUC7gnRZInGJJZPm2/saTdmjDY1Ly2ljfFMRfYImlkk4pmoeVPuZrv91woDxe9nXna//t6JpMIs
	arW8k4mBrBfvCz/KqEOAxfxiX5zqOJM8BVXyq23DPN0lYUbALRvfdhBTOZdw=
X-Received: by 2002:a05:690c:89:b0:857:b539:c43f with SMTP id
 00721157ae682-857b539d443mr51308057b3.26.1787823238543; Thu, 27 Aug 2026
 02:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825023614.1228551-1-edumazet@google.com> <9eeac695-ff8b-4473-b0ab-b3ad873b6915@redhat.com>
In-Reply-To: <9eeac695-ff8b-4473-b0ab-b3ad873b6915@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Aug 2026 11:33:46 +0200
X-Gm-Features: AcwNN1XYhx3hRg4LVwJvSrIcBaVev1T-bwMIfCGRTGzm4lw0Olf3zWhQouI82Uk
Message-ID: <CANn89iLb1qJ9asoisJzPmXQ-ZD7Xp6H5kfjOdMtjxYBuL_2sKA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: use GFP_ATOMIC in tcp_send_active_reset()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 11:09=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 8/25/26 4:36 AM, Eric Dumazet wrote:
> > tcp_send_active_reset() can be called from contexts where gfp_any()
> > (in tcp_disconnect()) or sk->sk_allocation (in __tcp_close() and
> > mptcp_do_fastclose()) evaluates to GFP_KERNEL, which includes
> > __GFP_FS and __GFP_DIRECT_RECLAIM.
> >
> > Allocating with GFP_KERNEL while holding the socket lock (sk_lock) crea=
tes
> > a lockdep dependency:
> >   sk_lock -> fs_reclaim
> >
> > This causes false-positive lockdep circular locking warnings with stora=
ge
> > subsystems (such as nvme-tcp) that acquire socket locks in block I/O pa=
ths
> > and invoke tcp_disconnect() or close sockets upon teardown:
> >   set->srcu -> sk_lock -> fs_reclaim -> elevator_lock -> set->srcu
> >
> > Active resets are small RST packet headers that should never
> > enter direct reclaim or block while holding socket locks.
> >
> > Hardcode GFP_ATOMIC inside tcp_send_active_reset() and remove its
> > priority argument since all callers now use GFP_ATOMIC.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> Sashiko has a bit to say:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825023614.122855=
1-1-edumazet%40google.com
>
> A couple of issues (the same lockdep chain still be present for
> regular transmissions, and SOCK_MEMALLOC being ignored) looks
> real to me. WDYT?

Thanks for the pointer; my local Sashiko couldn't spot this.

Regarding SOCK_MEMALLOC, that's a good point.
Using bare GFP_ATOMICdrops __GFP_MEMALLOC and misses __GFP_NOWARN.
We should use:
    sk_gfp_mask(sk, GFP_ATOMIC | __GFP_NOWARN)

I will squash this into V2.

All the remarks against nvme will be taken care of once this patch is merge=
d.

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 19a799e5d5ce3b55c57e2557d21a8d44982db714..3581384d097feea4cddc3c1f304=
04367aa93aaa8
100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3851,12 +3851,13 @@ void tcp_send_fin(struct sock *sk)
  */
 void tcp_send_active_reset(struct sock *sk, enum sk_rst_reason reason)
 {
+       gfp_t priority =3D sk_gfp_mask(sk, GFP_ATOMIC | __GFP_NOWARN);
        struct sk_buff *skb;

        TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTRSTS);

        /* NOTE: No TCP options attached and we never retransmit this. */
-       skb =3D alloc_skb(MAX_TCP_HEADER, GFP_ATOMIC);
+       skb =3D alloc_skb(MAX_TCP_HEADER, priority);
        if (!skb) {
                NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTFAILED);
                return;
@@ -3868,7 +3869,7 @@ void tcp_send_active_reset(struct sock *sk, enum
sk_rst_reason reason)
                             TCPHDR_ACK | TCPHDR_RST);
        tcp_mstamp_refresh(tcp_sk(sk));
        /* Send it off. */
-       if (tcp_transmit_skb(sk, skb, 0, GFP_ATOMIC))
+       if (tcp_transmit_skb(sk, skb, 0, priority))
                NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTFAILED);

        /* skb of trace_tcp_send_reset() keeps the skb that caused RST,
