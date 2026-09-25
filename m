Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB074A3F29
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343828; cv=pass; b=a4hdxZtgeAHwIOd1UHLcDOb9phst34uRPA+qHOaVE3sRM7suqCZgGrexck84Ut31R9LUI8qKbK1xY9JSitsRmW+KjlLK27sudSSYy6b/ARuTQr2ggXkRfaDwoch2bFct3t0L90i8WmnHvx1b//QccoTF536eAchb5qv4t0w7/zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343828; c=relaxed/simple;
	bh=7ZcDjW38nk6HlL8BIcY3yuIRSCfgWuGB2fSEkI6IXEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cB9E3xEHKzlvFy417qTcZGsTf+crp01D9rW1O1BUrS5Xc9efJci5h2itbQ2liYaktbFlG9+k9HoqXV17tb5mh1zNU0jVnIXNi0Q57Aggw+hI8iXa4kMpL/2yr51gKCfYkhmmlYNgizI+rCPz+PRhiEUtYHfSaalTWBl0TrXBUmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDf6at5W; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDf6at5W"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76ef1d0so8672941cf.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790343825; cv=none;
        d=google.com; s=arc-20260327;
        b=FaPJIb7QnHBrvcs5ZLjPwLFnY8svb+IK1uthaMObIHUVu2+QHmmXA4vMa7/cGOmjbP
         ffYr67LHk6pPhSfWwWaIDpdchqQxapfTn/+/lSi7b87XIXX79LESRvxZ6Xbec9e06ssa
         XdNxa8NDQF8hhnuok3y+ih2o6PUWTjuGtbKBGKOfkvBs5DTfwC7SAx77NqVTPW30fYpg
         wmDsR6+xMR1yB+9H4VB63pOEDN9xs3K0FA5cFJ4NHHsxVgI6gPoxtIb+AF9mVMfLvtSR
         loPtOxFMWU7GNgw6kiqSG1JOpQbv+iebNKk9FaMLy/KQrRBB8MZLykjozjReUWJz8QKC
         gxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aS8QAswde3y4iU7Q8F3Yth5T0bAE/PRbpFF/5Gg231k=;
        fh=f3W5UWXix8mBiZKjrOrZKrLOukBY5P2fKInbz4pI6WU=;
        b=IRvKQPTYLGE7C1LBkCqE0JrYg/wxMTOO4vpf2OSIoGFTedxEH3LfVfikV2CQ/vIEss
         en6ntznrat8HqfBKn80rFrn0XV2XpZl9Mx6qSwg7vKZDTxjGMMuoWIwBwNWgROgbJLwa
         Lim2Vwd3M4RmGcmlSqt24/0TqWuC+1S0J8Yo8HJJE73ygDFFoKCOhBk95nGfTeIY4k4x
         X7zofAO13eTy86WQxi9ID+d6oE2EGaRvmfpTSHrUtCDtVjj+Hb875G7KW81PPZ0Gvlj0
         4mIrjZIuqZfBNXM97ZMNDBPSwMWzuKtAEmk+8KTEFL1CzaKLgBAbCUyn1QAAOSE68V8J
         pXtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790343825; x=1790948625; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aS8QAswde3y4iU7Q8F3Yth5T0bAE/PRbpFF/5Gg231k=;
        b=tDf6at5W9qGSRLm8ErtpsxMxhvmbDZapJWyLqO15QOoXkRcIaXAz3GfLqC6yGkaYN+
         5G5JMnzeZa+CN92zEzp0r5KvNXH3lXRhQMZIbyOR5dzWxsgxfen5bvCIXZbo79P6dLXi
         1MmWn122VSbx23+0gRAAClJa8OnXh8eHlb67jnAaCXJ+jy8Gss2qIJegskeKIcAIdscs
         WNxuE7jzFB0d9gFZViqHHjnvVEszd7xnuBwblKWfReF+IVmWtsE54olJO+L+5GcOlD9s
         P6bhrvrF5HeNFk1VGfov1nWiObONcd8cZ+5boPzvwchEpfz63qfVY3s3rpPrkVwPBiKC
         VYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343825; x=1790948625;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aS8QAswde3y4iU7Q8F3Yth5T0bAE/PRbpFF/5Gg231k=;
        b=akdAyfIsBM6O1Fjt0ZhB89DdqaT/ak8u7WafoUw+cRuEMNLYsHOA5Yb3jjg5gCCd6F
         08PmDKzmPqS0DnyuAt3rGFNsPMRHrmGSvMknwHivavPEZXC+HHeM1D3L1jFe852XZZA4
         1rLEAINJE+9OTgNrmtMcdIeJ2HWdAiQ/Jko9dW2+xMeEjJjsXncwAvwRWGNiWoXTX2s8
         3D0SbFf0u4FtapzrwRZpQgG6R+MYmZztFBAcutItVg0stqJgKQR7QLYNrBbdVCDE57ts
         1OO6Ws9bzSOzMeCuy2b25mfHxXzaogFDzpbNeK7WFP2CJM+Zl4EN2OvVlcidhyk/FYmj
         bjaw==
X-Forwarded-Encrypted: i=1; AKwUvBxDyqW+2jM7AYWVAdUd4W91xPOfN2MYDnmKOUG+jJhNbwNUNaZPmEvmdKXs9s6gGe/Jek3Rprw=@vger.kernel.org
X-Gm-Message-State: AFuF++lZPlknAXANx/7FaD3NWwrTpNgfwHDIvAi75akHNuyje7hJXa2z
	EpGiO+8DtHh0Q56lwcn5+xz8ukLOWgUm87qodYAZ3SXH4ZtOmN2suHbvtOUmo+C/EX8rFldC/gh
	9bhlYEUNqt1pi58ACq++YE6oS/Vdn7gULVSTXx2VvNbbsGcK9yu10LleC
X-Gm-Gg: AYBFou3R4OW28/Dek8TZXby0A5QDyYm+CaqG8/Jk5NeOyF0/VmqOftpn9POQkMeQcGJ
	FH9h0xsTIDgxP462nhz4Csw4OxcnYDKQCCYtu3bALOnl0aW7kV6YOoMBpXDUq/d757gwlO9RJTp
	9+jVbD5DS3R464WmHTzVNIjcrgQAx5ziGMLlX6OR+MBJZySGM0xNI7TFaKIvv1rpxRsNNMLHNQX
	BycNJpDTdL0FfQgGXnMdAf1UjO0jx/YspdWO8dIZNlY+iKm9giMZizdpXUcC0O/4cMURQ/lZ1WS
	WiZzo/KaDG5tPwBjib0GyTDSUh3wTUuDRDfzNNsthZndP8oydloy/pKbAgaZq8orFs9GCT0Zw1I
	OhWJfIMF0AtfFRHvpeSNW7LktcKGl65vEtLM0RhZsPOZ51yef2EwFRnulQ/0xVIJY2Xe0
X-Received: by 2002:ac8:5f52:0:b0:530:b2e2:903c with SMTP id
 d75a77b69052e-5330b705d24mr42685811cf.60.1790343823975; Fri, 25 Sep 2026
 06:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-BA27.v1.20260922092618@mojatatu.com> <CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com>
 <CAM0EoMn8_MVUHa2Jym7wKvd6Oo-JvNJ7GPvRJi2DsJCnQFmW+w@mail.gmail.com>
 <CANn89iL3jBMczB4txC4oDusfpDoem-wdTOFVrujTbC0ArNhGqQ@mail.gmail.com> <68BE1514-828D-4184-84E4-90F2EB3F035D@gmx.de>
In-Reply-To: <68BE1514-828D-4184-84E4-90F2EB3F035D@gmx.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Sep 2026 15:43:32 +0200
X-Gm-Features: AclHuK9vscudfvim8sMExKqr7dvfM9Zf6NqeO_k_orfeFHTKqq4bkpBTUJtLB8U
Message-ID: <CANn89iJtHuwybsSLy32GzH2c9cGmP1bL7ardxPjxPOj2xGLZPA@mail.gmail.com>
Subject: Re: [Cake] [PATCH net-next] net/sched: fq_codel, cake: widen backlogs
 to u64
To: Sebastian Moeller <moeller0@gmx.de>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	cake@lists.bufferbloat.net, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, hybris <hybris@mojatatu.ai>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 3:30=E2=80=AFPM Sebastian Moeller <moeller0@gmx.de>=
 wrote:
>
> Hi Eric,
>
>
> > On Sep 25, 2026, at 15:03, Eric Dumazet via Cake <cake@lists.bufferbloa=
t.net> wrote:
> >
> > On Fri, Sep 25, 2026 at 1:28=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> >>
> >> On Fri, Sep 25, 2026 at 5:13=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> >>>
> >>> On Fri, Sep 25, 2026 at 10:54=E2=80=AFAM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> >>>>
> >>>> This is a follow-up to commit 8f735d64382d ("net/sched: bound
> >>>> qdisc_pkt_len to prevent qdisc soft lockup"), which capped
> >>>> qdisc_pkt_len() at QDISC_PKT_LEN_MAX (1 MiB). That cap bounds the st=
ab
> >>>> amplifier but leaves the per-flow backlog counter u32:
> >>>> fq_codel_enqueue() accumulates qdisc_pkt_len(skb) into q->backlogs[i=
dx],
> >>>> so a flow can still accumulate 4096 packets of 1 MiB each and wrap t=
he
> >>>> counter mod 2^32. After a wrap, fq_codel_drop() sees a tiny maxbackl=
og
> >>>> and drops from an almost-empty flow, and the dequeue-side subtractio=
ns
> >>>> corrupt the counter further.
> >>>>
> >>>> Widen the fq_codel backlogs table, the fat-flow scan (maxbacklog/len=
) and
> >>>> the drop threshold to u64. fq_codel is not lockless: every writer ru=
ns
> >>>> under the root qdisc lock, so plain u64 arithmetic keeps the WRITE_O=
NCE
> >>>> publish / READ_ONCE-consume pattern. The dump path
> >>>> (fq_codel_dump_class_stats) stays a lockless stat-only read.
> >>>>
> >>>> CAKE accumulates the same generic qdisc_pkt_len(skb) into its per-fl=
ow
> >>>> b->backlogs[] and per-tin b->tin_backlog and consumes the values for
> >>>> longest-flow pruning (cake_heapify/cake_heapify_up) and for the shap=
er
> >>>> staleness check, so it shares the bug. Widen those counters and the =
heap
> >>>> comparison locals to u64; the class/tin stats keep exporting the low=
 32
> >>>> bits through the unchanged uAPI fields.
> >>>>
> >>>> Conditions to recreate the bug: CAP_NET_ADMIN in a user namespace;
> >>>> CONFIG_NET_SCH_FQ_CODEL=3Dy.
> >>>>
> >>>>  ip tuntap add tun0 mode tun
> >>>>  ip link set tun0 txqueuelen 32 up
> >>>>  ip addr add 10.99.0.1/24 dev tun0
> >>>>  tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
> >>>>      fq_codel flows 1 limit 4200 ecn drop_batch 4096
> >>>>  # hold the tun fd open without reading (IFF_BACKPRESSURE) so the qd=
isc
> >>>>  # backlog persists, then send at least 4300 packets (the wrap start=
s
> >>>>  # at 4096 resident; the over-limit drop that reads the wrapped
> >>>>  # threshold fires past the 4200 limit): backlogs[0] wraps at 4096 x
> >>>>  # 1 MiB and the fat-flow threshold reads the wrapped value.
> >>>>
> >>>> With a 1 MiB qdisc_pkt_len cap the counter wraps at 4096 resident
> >>>> packets. At limit 4200 the first over-limit enqueue (the 4201st) see=
s a
> >>>> wrapped 105 MiB (half-backlog threshold 52 MiB, a ~52 packet drop bu=
rst),
> >>>> where the u64 counter sees 4201 MiB (threshold 2100 MiB, a ~2100 pac=
ket
> >>>> drop burst).
> >>>>
> >>>> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> >>>> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818=
101130.16203-1-jhs@mojatatu.com
> >>>> Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@moja=
tatu.com/
> >>>> Tested-by: hybris <hybris@mojatatu.ai>
> >>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >>>> ---
> >>>
> >>> This makes no sense.
> >>>
> >>
> >> As absurd as it looks that code is reachable ;->
> >>
> >>> These qdisc have been developped to address bufferbloat issues.
> >>>
> >>> Storing 4GB in a qdisc is absolutely insane.
> >>>
> >>
> >> The counter wrap is not because we stored 4GB, rather it is because
> >> "tc .. stab overhead ..." inflates qdisc_pkt_len() for a 64B pkt to
> >> 1MB. So ~4K packets (put in other words a few "real" KB) makes that
> >> backlog[0] cross 2^32.
> >
> > Kill this stuff ? Who is still using this, for what reason ?
>
> tc-stab? Same as before, if you need want to model a remote bottleneck wi=
th a local traffic shaper tc-stab is the generic solution (off the top of m=
y head I only can enumerate cake as having its own traffic shaper that hand=
les overheads).
> One could argue that the "virtual" length should be accounted against cak=
e's memlimit or fq-codel's memory_limit somehow...
> In sane?/typical configurations overhead is expected to stay relatively s=
mall, so this would not limit the actual queue size too much, while potenti=
ally silencing this issue.

linux qdisc are in the fast path, for nearly all packets sent over this pla=
net.
They aleady consume GW of energy.

Modeling / network emulation should incur zero cost on these
production grade qdisc.

netem could be one answer, I do not know, or a special
CONFIG_NET_SCHED_EXPENSIVE_EMULATION

>
> I might be off my rocker, in which has ignore (or preferably enlighten me=
).
