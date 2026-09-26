Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13203BD638
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790415825; cv=pass; b=rSEenfBtL4DF3pOxxPwh8Op7rFkQKoyR0VYVXLTwf4g8en5aQp0GoJ6oEcXjWLmIhwvygcL7htQQOrUVtQUoLskwqyd4VcZoV1k9raCX19N6EUQFr0RHo529VOShO2yidqOogRMu4i1EloRslUFKCI7mbNA/jlsrEDIp8AbssWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790415825; c=relaxed/simple;
	bh=sKxjYk+bOO9hXs2DbfRFHUfBMmMvQ697tDXJGD3Fi3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4k/MtsXknqrdfmMv/yQBAlTlVtpff4uDCE7h5V20tBmzDD+KJEuyUzMzd80/lfCbMtoCR1OFSpu76pjMVWI2rOSZypy0WiFaDIkRgcr36foIHex/9hOEb5aMsgp1Z0B0U8HGRj15o46FzVVvzMzmE4Fv1kro2dAUDZ+QCiWx3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=YQ6QLZrU; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="YQ6QLZrU"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1450541ab18so1760411c88.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 02:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790415821; cv=none;
        d=google.com; s=arc-20260327;
        b=Q+jno2vlzROMvzlEjDVGwsu9scNxs7GwPMQqy6gSlU3GWp39CdKxOgqwsFrMywJsGB
         9q2aQN0/YF8AnVKdb6Urtmw4N3Wg0ywPH9joOBLADO+NsYoPdho6yn/08VqtYmnwR2gC
         wdTzl8hrw34BVZUGwtX0KrZlMx80ysRQb793R1aA3MZX7iOJGZ+0ifyZrP8SQE8e6DVQ
         RIVF7XHaKhj8r5S7mcb8e2IDyFUDDdAdidOXQDZttKV40g36HHzLPG2DI/vPwkE6yOu6
         g2eqk+VPHRsmtRlgB0iH6l3kuG44KuEZ0Jfn7qUnq/KG+kgNAwvH6syekFylHJqoXwaE
         sj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SzvWQLkWxwpiX7qLxPQTvx30y630CcfiVhKwC04gV5k=;
        fh=C7xtPMEM8IIdAPncDyf4pzDTMRgokd4f6qTeg1KKljM=;
        b=p7Y6BIidHLPB/pyS+cvdPJuYrFCEKo8tfgAmPmje3AqFMsiJzSDBouCcP+LNFUUGdv
         7vFowONY5fR757LDH1R0fn/sBamwn/3eMe1tHJg7eate/T+3jwuBCsVoMSn8Mx8d8JOB
         dhJ3gsIZEA+2/mfVnxRIyzB/z70ZiwClyj95oyEX9V9GeG+29w+uDHAZFInRAh/cuL5M
         8j/47gtoR7FLwun1/0Vy5DrN0Fhvhs7ZuvIBNxIRxw3eFh2qpE9dl+kSxJt4Ni2V5vsB
         Xu8d2D+E5lw/GWwwhRdBaLkCHuRnolsEsPGeeMZc6UBE7K5Zi3RBdUVgb6XQgEVn3ffh
         7kZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790415821; x=1791020621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SzvWQLkWxwpiX7qLxPQTvx30y630CcfiVhKwC04gV5k=;
        b=YQ6QLZrUzoVahUATE+9Fe+CBtTlAWxsuhvqpDD8qgxPqJ6tx3drlBZuvwIp5V2y41e
         OCNK9MiN1N1BFjmpzE8+GJK2pxZkrY69iCJgupmyTI4mgtUyyYlVYvTi2K1+TJpU1lAA
         SfLVVJnPdfARM7pSW6F56a0g1JaMv6j0k2Joo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790415821; x=1791020621;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzvWQLkWxwpiX7qLxPQTvx30y630CcfiVhKwC04gV5k=;
        b=r4pL17il05bbCmOMohtbudb2pmgYZVB5ogLm/U3HFL/JVaYJleve7FmQ/P+whlSeXd
         TuBwm5Cs3iIdUGyIHlOWlr2KcMQRL5yKBlXH1+bPjt4L2XjwmZE3QEpeDHISGIFvxUtm
         XGhNlsw6YGw6Ev7EDb+bYMpfrt8xpt2AfTolqzOxnLR0U6PQYfPKAKdt7dzKAtQwmP9J
         UZvaMINQBQ4CLHLM23rW2CL7eZhK0obFnQMwatn1Q9HAmNOW807g9/RpJTfWxcahfDno
         mvjlubVRrIpxPT0gWnGzht3ErpN6x0Tc7Wlr7IUqheHPTPJ2BBFfQ4tso6bdbD4s3tib
         1o9w==
X-Forwarded-Encrypted: i=1; AKwUvBx3bGw5j4ZOUoQuTe7EpB4E/8EW7oYMm80qOg4gSpZHPTwQztSHMhYevST1/TxzZHnr8EZSBEw=@vger.kernel.org
X-Gm-Message-State: AFuF++nIPg1HatYN/zutDuyvuJFJG3QKD1J1V7GQS/7vxA4E1LrGjX1y
	Ycfbipdh9Vxo33WNobVoGAZCkpmmfRoQNuxT/nMZohl7RZ+5X8OhGPqo61zKhx9PXayMFy5T2O3
	nZzeYbLhdZL5sWApvGhz9WWloMcqNodSY7qFwHpGs
X-Gm-Gg: AYBFou1hJqx57bY4dCb63VDzFCJwU/Uia2kbB1uJGG3B3ctXEIOfNvc2mtfX0PnAzEe
	K7njt6MqcQMru6puTgkN72R5oSshBAOD1efCv66vBYlQvkB6tZuh7+w0F6i9q3R8MShz3kamTzD
	rNtDZLxvYm3TK/vhPkiDU4w9u0f2yyeQ5AOc0shaC/Sl1MAB5nvLZBypjstuQ/M4Xqy95dv9Z6D
	RcKImtIk3dFiq1qBJqavq7+/3fxm5uxUGkRd8LLhlElhCEVo7GHAGXV9/SFIRZ4Z6EyKlR6Gij8
	trSpwI76JcGWfWn0g5jWiTKWRSHIy1cwE643uasJdbeXoWf6OkL2PfZpyYNT0nAguTXfeUTa38J
	sz8yy2KwkaB80CnYDl6XezJ9lL1V2c052Crsr0ZZeQcdCq6RN+6/fEz/ovGJBquALWauV9iLVSK
	/RDapoEhmGmoOJzMZTwz4=
X-Received: by 2002:a05:7022:ea8b:b0:146:5f73:d419 with SMTP id
 a92af1059eb24-146ce680e33mr2627989c88.14.1790415820581; Sat, 26 Sep 2026
 02:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-BA27.v1.20260922092618@mojatatu.com> <CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com>
 <CAM0EoMn8_MVUHa2Jym7wKvd6Oo-JvNJ7GPvRJi2DsJCnQFmW+w@mail.gmail.com>
 <CANn89iL3jBMczB4txC4oDusfpDoem-wdTOFVrujTbC0ArNhGqQ@mail.gmail.com>
 <68BE1514-828D-4184-84E4-90F2EB3F035D@gmx.de> <CANn89iJtHuwybsSLy32GzH2c9cGmP1bL7ardxPjxPOj2xGLZPA@mail.gmail.com>
 <67EA1744-69D7-4A64-9117-D6A79A3A93E4@gmx.de>
In-Reply-To: <67EA1744-69D7-4A64-9117-D6A79A3A93E4@gmx.de>
From: Jamal Hadi Salim <hadi@mojatatu.com>
Date: Sat, 26 Sep 2026 05:43:28 -0400
X-Gm-Features: AclHuK9nIZVvB4vxvUGaioGgnYIENDgkjJUY57GgKyB5XSUjBc0sRzpTlg5iQVs
Message-ID: <CAAFAkD_U8PGfdJAgSLsh3ku+tTBvQYB012k7jEUacfm6HothyQ@mail.gmail.com>
Subject: Re: [Cake] [PATCH net-next] net/sched: fq_codel, cake: widen backlogs
 to u64
To: Sebastian Moeller <moeller0@gmx.de>
Cc: Eric Dumazet <edumazet@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	cake@lists.bufferbloat.net, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, hybris <hybris@mojatatu.ai>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 10:03=E2=80=AFAM 'Sebastian Moeller' via
Hyper-Yielding Back-end Review & Insight System <hybris@mojatatu.com>
wrote:
>
> Hi Eric,
>
>
> > On Sep 25, 2026, at 15:43, Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Fri, Sep 25, 2026 at 3:30=E2=80=AFPM Sebastian Moeller <moeller0@gmx=
.de> wrote:
> >>
> >> Hi Eric,
> >>
> >>
> >>> On Sep 25, 2026, at 15:03, Eric Dumazet via Cake <cake@lists.bufferbl=
oat.net> wrote:
> >>>
> >>> On Fri, Sep 25, 2026 at 1:28=E2=80=AFPM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> >>>>
> >>>> On Fri, Sep 25, 2026 at 5:13=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
> >>>>>
> >>>>> On Fri, Sep 25, 2026 at 10:54=E2=80=AFAM Jamal Hadi Salim <jhs@moja=
tatu.com> wrote:
> >>>>>>
> >>>>>> This is a follow-up to commit 8f735d64382d ("net/sched: bound
> >>>>>> qdisc_pkt_len to prevent qdisc soft lockup"), which capped
> >>>>>> qdisc_pkt_len() at QDISC_PKT_LEN_MAX (1 MiB). That cap bounds the =
stab
> >>>>>> amplifier but leaves the per-flow backlog counter u32:
> >>>>>> fq_codel_enqueue() accumulates qdisc_pkt_len(skb) into q->backlogs=
[idx],
> >>>>>> so a flow can still accumulate 4096 packets of 1 MiB each and wrap=
 the
> >>>>>> counter mod 2^32. After a wrap, fq_codel_drop() sees a tiny maxbac=
klog
> >>>>>> and drops from an almost-empty flow, and the dequeue-side subtract=
ions
> >>>>>> corrupt the counter further.
> >>>>>>
> >>>>>> Widen the fq_codel backlogs table, the fat-flow scan (maxbacklog/l=
en) and
> >>>>>> the drop threshold to u64. fq_codel is not lockless: every writer =
runs
> >>>>>> under the root qdisc lock, so plain u64 arithmetic keeps the WRITE=
_ONCE
> >>>>>> publish / READ_ONCE-consume pattern. The dump path
> >>>>>> (fq_codel_dump_class_stats) stays a lockless stat-only read.
> >>>>>>
> >>>>>> CAKE accumulates the same generic qdisc_pkt_len(skb) into its per-=
flow
> >>>>>> b->backlogs[] and per-tin b->tin_backlog and consumes the values f=
or
> >>>>>> longest-flow pruning (cake_heapify/cake_heapify_up) and for the sh=
aper
> >>>>>> staleness check, so it shares the bug. Widen those counters and th=
e heap
> >>>>>> comparison locals to u64; the class/tin stats keep exporting the l=
ow 32
> >>>>>> bits through the unchanged uAPI fields.
> >>>>>>
> >>>>>> Conditions to recreate the bug: CAP_NET_ADMIN in a user namespace;
> >>>>>> CONFIG_NET_SCH_FQ_CODEL=3Dy.
> >>>>>>
> >>>>>> ip tuntap add tun0 mode tun
> >>>>>> ip link set tun0 txqueuelen 32 up
> >>>>>> ip addr add 10.99.0.1/24 dev tun0
> >>>>>> tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
> >>>>>>     fq_codel flows 1 limit 4200 ecn drop_batch 4096
> >>>>>> # hold the tun fd open without reading (IFF_BACKPRESSURE) so the q=
disc
> >>>>>> # backlog persists, then send at least 4300 packets (the wrap star=
ts
> >>>>>> # at 4096 resident; the over-limit drop that reads the wrapped
> >>>>>> # threshold fires past the 4200 limit): backlogs[0] wraps at 4096 =
x
> >>>>>> # 1 MiB and the fat-flow threshold reads the wrapped value.
> >>>>>>
> >>>>>> With a 1 MiB qdisc_pkt_len cap the counter wraps at 4096 resident
> >>>>>> packets. At limit 4200 the first over-limit enqueue (the 4201st) s=
ees a
> >>>>>> wrapped 105 MiB (half-backlog threshold 52 MiB, a ~52 packet drop =
burst),
> >>>>>> where the u64 counter sees 4201 MiB (threshold 2100 MiB, a ~2100 p=
acket
> >>>>>> drop burst).
> >>>>>>
> >>>>>> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> >>>>>> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/202608=
18101130.16203-1-jhs@mojatatu.com
> >>>>>> Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mo=
jatatu.com/
> >>>>>> Tested-by: hybris <hybris@mojatatu.ai>
> >>>>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >>>>>> ---
> >>>>>
> >>>>> This makes no sense.
> >>>>>
> >>>>
> >>>> As absurd as it looks that code is reachable ;->
> >>>>
> >>>>> These qdisc have been developped to address bufferbloat issues.
> >>>>>
> >>>>> Storing 4GB in a qdisc is absolutely insane.
> >>>>>
> >>>>
> >>>> The counter wrap is not because we stored 4GB, rather it is because
> >>>> "tc .. stab overhead ..." inflates qdisc_pkt_len() for a 64B pkt to
> >>>> 1MB. So ~4K packets (put in other words a few "real" KB) makes that
> >>>> backlog[0] cross 2^32.
> >>>
> >>> Kill this stuff ? Who is still using this, for what reason ?
> >>
> >> tc-stab? Same as before, if you need want to model a remote bottleneck=
 with a local traffic shaper tc-stab is the generic solution (off the top o=
f my head I only can enumerate cake as having its own traffic shaper that h=
andles overheads).
> >> One could argue that the "virtual" length should be accounted against =
cake's memlimit or fq-codel's memory_limit somehow...
> >> In sane?/typical configurations overhead is expected to stay relativel=
y small, so this would not limit the actual queue size too much, while pote=
ntially silencing this issue.
> >
> > linux qdisc are in the fast path, for nearly all packets sent over this=
 planet.
>
> Tip of the head to the linux network experts that enabled that and that t=
ake care of it being efficient!
>
> > They aleady consume GW of energy.
> >
> > Modeling / network emulation should incur zero cost on these
> > production grade qdisc.
>
> It is not modeling in a scientific sense (sorry I used inappropriate term=
inology here), but simply the fact that to shape traffic to avoid filling r=
emote queues one needs to be able to take the properties of that remote que=
ue/interface/link-layer into account.
> And that can be surprisingly close by. Last time I looked the kernel on s=
ay eth0 added the 14 bytes of ethernet related overhead it handled itself t=
o the packet size on top of the payload (no complaints that makes sense) bu=
t that is insufficient to properly traffic shape e.g. the same ethernet int=
erface... (as the relevant ethernet L1-frame overhead contains more bytes, =
like the FCS, preamble and SFD). And that gets worse with stuff like DSL, c=
able or fibre modems that are connected via ethernet to a linux router.
>
> >
> > netem could be one answer, I do not know, or a special
> > CONFIG_NET_SCHED_EXPENSIVE_EMULATION
>
> Well, tc-stab (or cake's overhead accounting) is already optional, so onl=
y those incur the cost that actually use it (and only those users are affec=
ted by the reported issue, it took tc-stab to cause the problem and arguabl=
y in a configuration that is "insane").
> I might be trying to explain the internet here to people that make the in=
ternet work, so apologies in advance but I want to make this as explicit as=
 I can.
> TTraffic shaping without proper overhead accounting will not work as expe=
cted (at least if the expectation is that the traffic shaper will honor the=
 set gross shaper rate). For a fixed packet size the lack over overhead acc=
ounting can be papered over with reducing the shaper rate, but the amount o=
f the required "over-shaping" depends on packet size (smaller packets requi=
re more over-shaping), so generally that is sub optimal, because either the=
 shaper's guarantee is brittle or the over-shaping quite extreme (think the=
 header to payload ration of minimally- and MTU-sized packets).
>
> All I am saying is, we do still have use cases for tc-stab and proper ove=
rhead accounting, at least on the leafs of the network like home internet l=
inks.

I am working on a v2 that drops at enqueue once the accounted backlog
crosses  (U32_MAX - QDISC_PKT_LEN_MAX), so no counter can wrap.
That is Eric's original suggestion which preserves the point you raised.

While looking at this closely for this update i noticed more qdiscs
which for different reasons also suffer from ((u64)backlog + len <=3D
limit idiom.
So far it's clear from bfifo, gred and plug are the only ones safe
because their limit is in bytes (as opposed to others which are packet
counting)

Eric: Unless i hear otherwise from you, the configurable byte ceiling
you mentioned (a good noun seems to be CONFIG_NET_SCH_BACKLOG_CEILING)
is a follow-up;

cheers,
jamal

> >
> >>
> >> I might be off my rocker, in which has ignore (or preferably enlighten=
 me).
>
>
