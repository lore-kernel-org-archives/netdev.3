Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323472;
	b=DrYGSaTenWXt3id4BfDFKyGExFD6wlYxqP4gALhdHaL0rec05RqUCMHeg+Xd/M2g1mp4
	 DlxW7eTLEY3IjBmQd2r/Zfgo1Adr7h2Bna//u+ifQcx09zcXSHqz+gRrD5A/JAM6qDbVw
	 KBEexba0EktTuqwH2QquF0euNGoOmd5cD/eeAQOBT2+rLn8yiwzFbQEplYTA/gNXUyKOF
	 1IrwUIWH/DoJTaEPwPOJ/EFflxgHdZ5D5rnciUHevKzSWNlk9gNxk96b/6+lu9kN+EEVl
	 Y7NWAkrmwPR0ZB3C84qKh56uv1RYFHw+o8ze+Ujt7/yG/cwV+j7+1R/BCjHOXSgquEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=W6z7e3dW4mp2FHGp4Wv7zZVkrXVosanAgrqH1yhT3tk=;
	b=gOuP9EFbNXb93Vy79QknrxT8jxeLDy5WlRymLmWrpqD3yyvjO+/g3DZC0lol5VgrvTjI
	 v2dcbTsb5dCkrNzqcaFITAd1yEvVeAOoAcjHgTUTrAoktgdyLncUorJLTHnrzEou+mrjT
	 XZorPB8WHreILJgqshlaLASCtfI7EoNyBEus5O7QGdfvJFtV83PdGuXzPek6yZ8vvrAgC
	 /NrIb/wy4YSFvrRqlXNjsqbQ/UJFYYCmurLNZfE8hVWQ7ICV2oe2RC8a1VUq2jFTd/Eqo
	 LLAA6s1yPvPJfsVz3mNQGEm4IaPUAMRYEaTuP64UXPQUNRytRR7FsXbi/c646S22Ufw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R3mOPevA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B174606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B174606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R3mOPevA
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-99be509f943so479122241.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:11:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794323471; cv=none;
        d=google.com; s=arc-20260327;
        b=ad7LLXDhElQDnI5rRi78WODO/QBKDpafscdp+dnO63noTWdNI/35cvj/aYyJL3V+zU
         Pd7QppI9VZ2uI4U0d72dTkSDlRl0plXIz+Xp6vN1gL7S/8Ju3O6E0UDBpL8NMabV004W
         r70J3HQUJbQGSMwb55B1lAIJUWXSONdHBnUkL3s93bw3nCQEuzkV4/lFtLvim386mkV+
         o+xO0vdJgGIgyWC4gQ1nPRrwhg2EBDF/UfR3L3/s5CibIOVsut/bv7+NIp1xPseFaf7t
         Fc9wpJJBHCknGMqbXveTMjGrXmF55UCE6zGFt5uk/ebalq/HznYxKz6DiKm5kfhBDbrq
         hAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W6z7e3dW4mp2FHGp4Wv7zZVkrXVosanAgrqH1yhT3tk=;
        fh=mr5048JX5xzE4igB+Sp/Ftr473CzloZHdTDdr2Wk+Qs=;
        b=GrYrhPpDdUe+5CYVZjruSmoz3qisrkG99Td2xAutgeD2lQfH3ROhDLHyyesJj6EXiF
         qUd1EaFbB95flvAAQ0DXtCbTQ4K8DI8zF26i8mtnopw7NaZD3gcd7HxzZaFZ3KpPQl58
         W/HaDwgspqt0HE3g5vEjoAKvkazqDzb7jpguN0gtiTGJUJLv5ysQv9PzCcVDmlc9RKgt
         zJ7MNKltVbNk+lAcjPPQn/EKejrswMPDCGhkWFq8UYebRpkSNDjGNay/kPrgalfl5vlz
         HEX3DA6wSH3JdKDccl1rg4NgO719PCwmh8HuHBLfWF7j56JIttF46Jlw0dG42ikRMnPI
         Zkvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323471; x=1794928271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W6z7e3dW4mp2FHGp4Wv7zZVkrXVosanAgrqH1yhT3tk=;
        b=R3mOPevAZ7M3aSBnsKq16hoySYLGfaI5yJUCH5GXNQs1FM29zQSTv1h/jQxwUzRjLH
         Ok6NGMWWQqBsR+BlbsSH8zfsFYjtYet8HABNxpsL1sDH0s/r4cKapFMvOq0ae2Oj5qBf
         zbTwXS1Aqfmx+A1DceEEORM9jXM4/qZLxaiuqX2dJZedD93VDszsRu6Tvb/+BMBiUapX
         AULumKrUlz9KgwMJ1985fLoNUkrLz+6rFmK2XrMvcHMEHsyOYgtHt2M8zfRsZpXJk+IQ
         910iyXRqof8fCk+/21+4chNobdOhcfbhvH9ppdp+QCfMVAv7Vgxds+i8gVShrbDOPQ5H
         /4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323471; x=1794928271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W6z7e3dW4mp2FHGp4Wv7zZVkrXVosanAgrqH1yhT3tk=;
        b=DWxgWvDw8efy193Gc+meOSNhYEfew1jXo4mZoG0RbWi2S4LPqHdeITYnExQ/W+PWmP
         iX4DEPgACUo8v+6VtV7cehr5kAs7pgHUL147G4+pCqV6Avvq6w5TurWeK8E66vqNZElV
         EVr0a49yJ0lCGZ+fIJsv+P0HCIlWGCUd9X7FfqZEHXz+6Mqg26loZ8Gx3TcJ5bgcY+bM
         EYFzRS4jhab6gDECj/87A7mGAIECv9UspTanyISb79FWuhyq4264500+uwPSyQyLjR7L
         x/Pbl6Te5AXmpuwSCiscVIVrVGwvUCyHDKIWS9W/AmlLKYZVgk0ftYRb4ZthiWQ7Qe5T
         xmsQ==
X-Forwarded-Encrypted: i=1; AL+hErFRQxKwVocjZM2bS6+h7ZqybjkK7/dJwndcxTwj9Q+fapahLHRvCraMKeOtAuRSLR49s8TPyWY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nH2M/E3Hd1RDFgePXI2d/3XFjHPyXws2BDq5pItHgALI3BZ6z
	QkwEgmQaUFQ9IH0EGA8hTYVcXs4S6hyJIRFI22w+Elk7QS1MU+XAY4dRU/s85jGQhT2oSkQ0cmE
	ImdDmnYPI7wTddEInBifCnvNSwQbi6VI=
X-Gm-Gg: AYBFou0u3FHQzsm/mGIBfQYy2gaqKRdnqycGi/61pILBGS4GuzxCE+S6+lrNt6v544e
	vlVsnTFjL1yF5IYbxPF1MVl8AHVRBE0tGOm+hG32dAC8ElrGi7flMFh5c1VQdrxgvtyS/u26YXM
	6zk/+c+nbCzA16+qf1rXSbKtBnVQHYOtJtq2jCgkqbccoJnz7cz1kvKCUVUB0QqRg1gagYNMC34
	CiKY1OluQZ6BRc8ZswG95narN9qSkm2Uy4vcrKe1/QOBVkj3r+TWStLAUBobqLAbLepKWphc1Ah
	qIqKCpEwXp5eB0pTZsCt2eYNAiOQMsl7e0Ct3uKJvVOqQTJbQpdXI+Prj7mhtaZv7yoXj1j1Ufo
	LHCixDOTvXIflsVjhyXbm0NyVNGW66dNLgqYwBkpdrkhhVH+F7+5M75P4QQGbHj9+weOp5bCspc
	gMGsSeIyRNbThTT2GFu+aapfi6S80YEKHaffb3AQ==
X-Received: by 2002:a05:6122:208a:b0:5ea:c214:b5cf with SMTP id
 71dfb90a1353d-5ee0cf0d54emr1101844e0c.1.1794323471135; Tue, 10 Nov 2026
 07:11:11 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104105507.62743-1-juny24602@gmail.com> <179413871612.994134.359540125574426236@kernel.org>
In-Reply-To: <179413871612.994134.359540125574426236@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 10 Nov 2026 10:10:58 -0500
X-Gm-Features: AclHuK89HgIbQyXWmaLQCesjdGtHdS-e5P_FfWBaym-EosoON5UnawsVLzWAcXE
Message-ID: <CADvbK_fUOSLtD2=r2UUU+YLCVCEOPYpH+S9Pnc12oO_YjjfHOg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: preserve stream scheduler across outq teardown
To: netdev-bot+sashiko@kernel.org
Cc: juny24602@gmail.com, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, junvyyang@tencent.com, 
	stable@kernel.org, corvus@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 6:51=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch changes how outqueue teardown behaves in the common
>   case, and the commit message does not say so.
>
> --
>
> sctp: preserve stream scheduler across outq teardown
>
> This patch keeps q->sched in sctp_outq_init() across the memset, so that
> sctp_sched_set_sched() can free the old scheduler's per-stream state when
> sctp_outq_teardown() reinitializes a live outqueue. Without that,
> installing a different default scheduler could read stale data through
> the shared union in struct sctp_stream_out_ext.
>
> > diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
> > index e92fb9da4647a..6cb4b4339d8b7 100644
> > --- a/net/sctp/outqueue.c
> > +++ b/net/sctp/outqueue.c
> > @@ -190,9 +190,13 @@ static inline int sctp_cacc_skip(struct sctp_trans=
port *primary,
> >   */
> >  void sctp_outq_init(struct sctp_association *asoc, struct sctp_outq *q=
)
> >  {
> > +     const struct sctp_sched_ops *sched =3D q->sched;
> > +
> >       memset(q, 0, sizeof(struct sctp_outq));
> >
> >       q->asoc =3D asoc;
> > +     /* Retain the scheduler to allow freeing its per-stream state. */
> > +     q->sched =3D sched;
>
> [Severity: Medium]
> The commit message only talks about the case where the installed schedule=
r
> differs from sctp_sk(sk)->default_ss. Does this also change behaviour in
> the more common case, where the two are the same?
>
> Before this patch, q->sched was NULL after the memset. That meant
> sctp_sched_set_sched() never took its early return, and every outqueue
> purge ran n->init() and n->init_sid() on each stream:
>
> net/sctp/stream_sched.c:sctp_sched_set_sched() {
>     ...
>         n =3D sctp_sched_ops[sched];
>         if (old =3D=3D n)
>                 return ret;
>     ...
>         n->init(&asoc->stream);
>         for (i =3D 0; i < asoc->stream.outcnt; i++) {
>                 ...
>                 ret =3D n->init_sid(&asoc->stream, i, GFP_ATOMIC);
>     ...
> }
>
> With q->sched kept, old =3D=3D n whenever default_ss matches the installe=
d
> scheduler, so the per-stream reset is skipped. The init_sid callbacks tha=
t
> no longer run on teardown are:
>
> net/sctp/stream_sched_prio.c:sctp_sched_prio_init_sid() {
>         ...
>         return sctp_sched_prio_set(stream, sid, 0, gfp);
> }
>
> net/sctp/stream_sched_fc.c:sctp_sched_fc_init_sid() {
>         ...
>         soute->fc_length =3D 0;
>         soute->fc_weight =3D 1;
>         ...
> }
>
> As a result, PRIO priorities and WFQ weights set through
> SCTP_STREAM_SCHEDULER_VALUE now survive a peer restart and a stale-cookie
> retry. Previously both paths reset them to 0 and 1:
>
> sctp_sf_do_dupcook_a() / sctp_sf_do_5_2_6_stale()
>   -> SCTP_CMD_PURGE_OUTQUEUE
>     -> sctp_outq_teardown()
>       -> sctp_outq_init()
>         -> sctp_sched_set_sched()   /* returns early, old =3D=3D n */
>
> For FC and WFQ there is a second effect. __sctp_outq_teardown() calls
> sctp_sched_dequeue_done() on every leftover data chunk it discards:
>
> net/sctp/outqueue.c:__sctp_outq_teardown() {
>     ...
>         while ((chunk =3D sctp_outq_dequeue_data(q)) !=3D NULL) {
>                 sctp_sched_dequeue_done(q, chunk);
>
>                 /* Mark as send failure. */
>                 sctp_chunk_fail(chunk, q->error);
>     ...
> }
>
> sctp_sched_fc_dequeue_done() then adds ch->skb->len to soute->fc_length.
> That used to be cleared by init_sid. Now it isn't, so a stream with a
> large unsent backlog at restart begins the restarted association with
> fc_length inflated by bytes that were never sent.
>
That's expected. purged chunks were queued on those streams,
so the fc_length stays consistent and converges as new data flows.

You may just need to mention it in the commit message when
addressing my last comment.

Thanks.

> Keeping the user-configured values may well be the preferred behaviour.
> Since this is going to stable, could the commit message describe it? If
> it isn't intended, should teardown reset the per-stream scheduler state
> explicitly, or at least the fc_length accumulated from discarded chunks?
>
> >       INIT_LIST_HEAD(&q->out_chunk_list);
> >       INIT_LIST_HEAD(&q->control_chunk_list);
> >       INIT_LIST_HEAD(&q->retransmit);
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261104105507.62743-1-juny24602%40gmail.com
