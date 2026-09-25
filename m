Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A901DDF0
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341413; cv=pass; b=FSReQXUrCFo4dQHn0OEPnCj1CuD2rzSU6rzhcpwen9nNwFQrpTDz8DvIS9m9HK7yIe53ChcwZLeNgUdMj43M4m9A1oAi7bKnDq9Ig+bo8qjqd8ePH1FeUjCsJgN4GNVaQubbbCAFPuaVHGqUJ0YNLvTbdNCKKCLpknGKoc15z4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341413; c=relaxed/simple;
	bh=1/z3RaQY5Gq8oJw9qe2hvlm2CcMhAD1aEdBgittgcH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNoW4kjeUdZd0kqhL+iWbxwMNefswZO4N5UqbQ3k7pokAq5FKz3IURIUaPsGr3nqgiz2BqlqFHX4vxWtD8r6iqAwKMK5Jy07jJB4weQeTZW0q1khOJkWPUUeiCd2lz1xSPkBOWeTBGYV+l0eeKqlhWdolC5wtLpM9q9c4r0G+wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OTHVJgVR; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OTHVJgVR"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5308fc4b716so6406251cf.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790341410; cv=none;
        d=google.com; s=arc-20260327;
        b=lOAJtf4xYpshXNnnw69+ThHv3vvOUIpBkKwEHOZYhMZLtaqOQvSTifIMNMiYhSNvex
         fQgcKy71HtIc6tvhBttQ6lslXFTTgWzl3N18oi5Zg1iwAfpORb19pvDqmZLFerXWhE/h
         gorS1Vsny0jKJlL1DW608pW9/3KUh+ceTroQvBf+2Qn22UFq3uAUyty2HtUlaagZE2wM
         nQoyUThCPerMxv8hgH5Emk1ih0SGWjFlxrZBlqSc4R3be/tyzRufnZCqDMrEB1JR4W/X
         ea1rDeaZuW6PuRSZ84R+3FXqzoygnosezz/5sD0Y5sb87rgVWSMi8chAqHVMleev9Hfb
         J86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LO1mJQEWTKJy4KW79SYHwagOhWlUVH2rxVMnkykeDXc=;
        fh=Wj0YEqSJg7Dhhip2gJnvksj1lCh3dEEgy1VoHdYgBNk=;
        b=N9F0/VAxFnCk7OYX95xxU2WXsqY9rJ4GDrDvo9MwZax1RYRdnUQrNpNPaw/d+UOW2w
         bFORnncwhM0NSjwMnnLwTdZhWec2sK3hVPSGjuOkrFE9xCtxT6WuqePciWy+KPqDl22+
         IJFM8EvhWZdTPgcAhoy6XZqlcmOTHA4bhzaoeECxeQsqNpP1vlxBYgr9lbUuOtCMYDZI
         Cv7cYbMt2JQPlhhEc+HDYGwl+3ZgUBUNM345dtVO1NDSFDC05UgCm2O5Q0kPiNTNF/ff
         2nCrZL1drC2PAljaY2fXXhQpQV7drq+VThfFOBPwDDqN6eYs/pC5gfwuryVzuxY0CtkA
         floQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790341410; x=1790946210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LO1mJQEWTKJy4KW79SYHwagOhWlUVH2rxVMnkykeDXc=;
        b=OTHVJgVRJHeU/e2bh7E2eBsfxCqEFRWFaxjyz9aSZNFBrWYUhQ+vq45zhZmAtsdAW+
         To9a2/nu1KS+fiAvE6NDWpDkcA+HbbQi7c/rY7Brt3jCofl6q2xBpZuYUqBwKshOxrTv
         wweGnidWdnp4/imatkhOXUp0M3uHnBIVv3zSJxAEppaZYUwY2Y9t2PrPIjmg+sln/lJk
         xlaGn9AVJ018IwGki28CdZpR8IeDLlikaMnAXV5+OXi6szBbOb9XZXZ7YiJcPRniOSpC
         bE0EG7cxNuT8m7IQrApA5itNysyBsjkbpVdfh3UVXseze4CJpUtquRKqkhMrcnLf3miA
         aQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790341410; x=1790946210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LO1mJQEWTKJy4KW79SYHwagOhWlUVH2rxVMnkykeDXc=;
        b=EJa17p+ywLqZTqRb43sgZdjFlsz2EYLQNcitpcbq/zjqn/W/mvMUR07exTPGKeiXv1
         H3FCq4PiQbGUYmZjq9ErsvJj3LLYCB4g/NRchvyN/7xH93+aKAlqoLtWsdkNaHejBxeT
         vUyf1OMuslhwEodTciQsbUUHVKNJ/rPlNt38lvvv9I/zN7l2Eip2/Ki08AVcnijCMyTF
         sh081n/lkYQzD+oWbnR+SDBFsMtx2w2jnvVgbAxPxHYABxozivrePcd3mHbg5cxyEtVm
         IbB1+ALl/PsoC7GvHLMjpiS9Q/96Pk3WogdBsdHvQXCHvJYMDkKLRLFVtG5ln6MAJyP0
         t0AA==
X-Gm-Message-State: AFuF++k1YlosDdm6CJzVpnUtyNvWeuWPt9BUnCXbutfA/9CNbzwFPbAJ
	yg4NY1F7PHNGDqR3GBiVpuHBTVZWWmjnbWJU9JozVCdcnC5cTXa3ZGfulYP9AlHa2WLTFviQz89
	JTiASJbtJUrOa/NKKqnCuAhZjv94p8DSKZn4pNxCM
X-Gm-Gg: AYBFou0mEy12d+HbjP2IuFUijCv8I49CvwBA19iOBU5M5wZUVxXN3oK69YQMhTT/znQ
	e/PEd6+2792AIdt/WiUnqfny1IiQhNqGPMeE/ZIPNTNZ/01a0DoCLZlhSAqPFFv5Sh4VZKKUGMh
	sghz96V6gLVlC39ep21LWJ4jj+Ml7ljbCkSE7bV/tMWIDucLM0aG7tfjKE7dE+yDEzhT5Qi27Uu
	T2q/CRUEt8JpSCyNYWykkvn3qe7lvlp1Vx84k0CavarPPjyWWsnfXNR1dr/X+gscLZlx/zNq519
	EucefdMH1H4LBF8InkgsY1FKM3U2FEFIN6lZTotl1zjU7BeSQR12OdVcZYhkrxAngSFMwYuSvvP
	qO7KhnKA7MYuLkQ/2MfgwVgaYoQH16OcGd4sGRvlVrQIYjRx0aVdsHnQzqtgYyR7wSq0h
X-Received: by 2002:ac8:7d12:0:b0:532:9c48:ec59 with SMTP id
 d75a77b69052e-5330b5d38dbmr44896871cf.18.1790341409488; Fri, 25 Sep 2026
 06:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-BA27.v1.20260922092618@mojatatu.com> <CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com>
 <CAM0EoMn8_MVUHa2Jym7wKvd6Oo-JvNJ7GPvRJi2DsJCnQFmW+w@mail.gmail.com>
In-Reply-To: <CAM0EoMn8_MVUHa2Jym7wKvd6Oo-JvNJ7GPvRJi2DsJCnQFmW+w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Sep 2026 15:03:18 +0200
X-Gm-Features: AclHuK-NpnkDVkhOVSxyv-HafVdDr-7CKXQ9rlYmLbL4LxpC386K5WFRODf_xz0
Message-ID: <CANn89iL3jBMczB4txC4oDusfpDoem-wdTOFVrujTbC0ArNhGqQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: fq_codel, cake: widen backlogs to u64
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	cake@lists.bufferbloat.net, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, hybris <hybris@mojatatu.ai>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:28=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Fri, Sep 25, 2026 at 5:13=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Sep 25, 2026 at 10:54=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > This is a follow-up to commit 8f735d64382d ("net/sched: bound
> > > qdisc_pkt_len to prevent qdisc soft lockup"), which capped
> > > qdisc_pkt_len() at QDISC_PKT_LEN_MAX (1 MiB). That cap bounds the sta=
b
> > > amplifier but leaves the per-flow backlog counter u32:
> > > fq_codel_enqueue() accumulates qdisc_pkt_len(skb) into q->backlogs[id=
x],
> > > so a flow can still accumulate 4096 packets of 1 MiB each and wrap th=
e
> > > counter mod 2^32. After a wrap, fq_codel_drop() sees a tiny maxbacklo=
g
> > > and drops from an almost-empty flow, and the dequeue-side subtraction=
s
> > > corrupt the counter further.
> > >
> > > Widen the fq_codel backlogs table, the fat-flow scan (maxbacklog/len)=
 and
> > > the drop threshold to u64. fq_codel is not lockless: every writer run=
s
> > > under the root qdisc lock, so plain u64 arithmetic keeps the WRITE_ON=
CE
> > > publish / READ_ONCE-consume pattern. The dump path
> > > (fq_codel_dump_class_stats) stays a lockless stat-only read.
> > >
> > > CAKE accumulates the same generic qdisc_pkt_len(skb) into its per-flo=
w
> > > b->backlogs[] and per-tin b->tin_backlog and consumes the values for
> > > longest-flow pruning (cake_heapify/cake_heapify_up) and for the shape=
r
> > > staleness check, so it shares the bug. Widen those counters and the h=
eap
> > > comparison locals to u64; the class/tin stats keep exporting the low =
32
> > > bits through the unchanged uAPI fields.
> > >
> > > Conditions to recreate the bug: CAP_NET_ADMIN in a user namespace;
> > > CONFIG_NET_SCH_FQ_CODEL=3Dy.
> > >
> > >   ip tuntap add tun0 mode tun
> > >   ip link set tun0 txqueuelen 32 up
> > >   ip addr add 10.99.0.1/24 dev tun0
> > >   tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
> > >       fq_codel flows 1 limit 4200 ecn drop_batch 4096
> > >   # hold the tun fd open without reading (IFF_BACKPRESSURE) so the qd=
isc
> > >   # backlog persists, then send at least 4300 packets (the wrap start=
s
> > >   # at 4096 resident; the over-limit drop that reads the wrapped
> > >   # threshold fires past the 4200 limit): backlogs[0] wraps at 4096 x
> > >   # 1 MiB and the fat-flow threshold reads the wrapped value.
> > >
> > > With a 1 MiB qdisc_pkt_len cap the counter wraps at 4096 resident
> > > packets. At limit 4200 the first over-limit enqueue (the 4201st) sees=
 a
> > > wrapped 105 MiB (half-backlog threshold 52 MiB, a ~52 packet drop bur=
st),
> > > where the u64 counter sees 4201 MiB (threshold 2100 MiB, a ~2100 pack=
et
> > > drop burst).
> > >
> > > Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> > > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/202608181=
01130.16203-1-jhs@mojatatu.com
> > > Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojat=
atu.com/
> > > Tested-by: hybris <hybris@mojatatu.ai>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> >
> > This makes no sense.
> >
>
> As absurd as it looks that code is reachable ;->
>
> > These qdisc have been developped to address bufferbloat issues.
> >
> > Storing 4GB in a qdisc is absolutely insane.
> >
>
> The counter wrap is not because we stored 4GB, rather it is because
> "tc .. stab overhead ..." inflates qdisc_pkt_len() for a 64B pkt to
> 1MB. So ~4K packets (put in other words a few "real" KB) makes that
> backlog[0] cross 2^32.

Kill this stuff ? Who is still using this, for what reason ?

Really, it is time we stop adding code only for fuzzers.

> Result is pruning the wrong flow..
>
> > Let's drop at enqueue if the current backlog is approaching 4GB (this
> > can later be a new config/attribute in net-next)
>
> Note, this is net-next already. Enqueue is fast path - are you ok with th=
at?
>
> cheers,
> jamal
