Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792444108;
	b=3bEsRp0LEshq2f1iIRS/vm8CAQ6ZUC+/rCI1dZ4MY52zrWkbDDYY16aRtcH902sl0p4C
	 lQBd0qOyMm+8DaXPuubF4hBv+WkMp7LAihZRNvCGQFH1pcDh/cSht/p0lThJ5UX7u5z+U
	 cLHqR5OiV/Cil69a+UWq3GykvTLOAmcQCVwFBekMI7vP6oLfVOgydO6IjnNmeiLKHol0C
	 XjSayTJNs132iYfBkQvZxYH9coLVotBDehRvy9OBkFqBLQCFiXRf3D2YuEo4NW/kkAB8H
	 iMYMG1/e0TjjZdWtayzicHkoBf7W+CE0+lKakU6G7PNl3Q9pi3EHL+jDVs7ditAVeGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=BQAlR8hJ+t0fEkcY1C90gZxc6fFNmtiyvrRw14WgVU4=;
	b=d/uzt49d07AwbhUVrm9aIqoso+QKqesIjkJfB1U0Q7u1hHJ2vMiroj05DNJ1mcHKulr+
	 yjci/S0usAGYhFhPrF+KbqR7aeQhXGs9UWTDnYoZzx1r5E/E7XRuLvC5QhGmHpaFAxf3M
	 NU4QTLsWx9r7SN9x1GAqo6DWXnZgcMSxerFGBcqqOAyC9UW3dm7DKXOjq8I1vkdsL5zHx
	 WIGH5kCmX+2N7FF2HcE78mAYexiFB6valT9PLMA6t0R6hACLvBqRHKsY32ktxscs0RrnE
	 VCwUgbmL4rtU6aDV2ojLdEf8cDBLljy5Ileimb5Vw17hYAJ2CJ+CWOGY+OJTFVmRDvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="AP/67oN8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529F1606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 21:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 529F1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=AP/67oN8
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-89f639ba307so823615b3a.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792444107; cv=none;
        d=google.com; s=arc-20260327;
        b=j9+KgleyAFi18SBFHTtF2BhVcGwsOSDhVWvDLdbfircukvhVpWT/CCK4mB0KgrYjWL
         IA+WhLG4WhSM8IMtQRqo02pW8yVfVnOHXroc62/9v6+Un6xUA/7Qi38BqvWHL8pyswc1
         WJgGyOE6t4Uh5pIjqxqbPMWBAe4FSK01B797bEUuESjJ+9+fRU7O1w0UOlKSH6oN/EEW
         C9VDc/yt6j0xY7NuNtQNXW3AsFD+Sp/kLRNHz6T2FUnmtUkNB2K/cC8vs5ir5RjN+cV4
         OrV/80kMSreP+FS7maRAL4Ci8RcRt1i1LVD9UfnGKaj84tgzUINYnNghqQwr4yv48dzz
         RG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BQAlR8hJ+t0fEkcY1C90gZxc6fFNmtiyvrRw14WgVU4=;
        fh=xmp1vX2ksVRtN/ju6J6bqhuSKfOgjk3q1XA6KuGu+8E=;
        b=mL9YDPjV+kPMvCHsxypZvuGXA7zdES88d+eTm1PvOzSrAVPano65euJoiR8HVyKZi+
         0HZqC1pH4umXWUVIYif3e0xnBeqD+JlYhsmHI8drQ4Oo5timyKkKsZqZp8I3x6C5Nq9Q
         M7TvMsDViPPHzA3oKWi4lpWwN/RRplVMkYgvQd7QU9fhycYuAUenpQDx1i/Hj89Iz9gp
         XVuXmzIOtu1mu6rDbN38XmbUuc0yJu9yx36RPbuYpgLI+zmtaWwz+CI8CHagHsGZ0VyM
         xLKpwKUxWxFEKLaIQO8zXrozLY2JhFqTyhIookG4MsQoNEszZtPFw62RymLxeS3NBdlm
         nsUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792444107; x=1793048907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BQAlR8hJ+t0fEkcY1C90gZxc6fFNmtiyvrRw14WgVU4=;
        b=AP/67oN8pb1PPtZb8ThsDJIrEV8za5MJXKPPwTf2NDwLNez7QFqcusoiqEeiU8IOsM
         FO387DBZSeH8cuh8Uf0j5qcmsQqx5ZcqZwJIDzXz8pK7of2V8g+VdfH5dsyLRbKL/Td0
         Kj2HU+H1tWP+NrSDMYY53b+v9agSYNn2ex9+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792444107; x=1793048907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BQAlR8hJ+t0fEkcY1C90gZxc6fFNmtiyvrRw14WgVU4=;
        b=NCf5OLpsrqoTdI7cV+V7iXZ8lFpYPr07MdgWvwoR/U0mf/Hc0p0/3Cz87s+PGQGuyE
         J6/K+5sar3kVdyeBYLgu9quYgQaRXNbrsFdmSAUI4Tf3LCuxFaw+hLvZXNfPb1yCF/AN
         H7xw0rodLr0c+YcEpleVif+8YTZ34w7tJjyX8fYs+W1ardeo7mGxGWEgbw24CdpuL9Eb
         Hp5I/QT0gsVK8pDheh3FW9uOojYAfx3+8fOQCDEhLD6xXE4qQkIBAYzYzzY3qzGmRZst
         H+o65ZSupQsH2/Tna1ocXCMoaGOo9Kj/LuxCw1Cvk8ObVLumYwWHP8+kHZLlUbbw46at
         FgMg==
X-Gm-Message-State: AFq9FYI+irGfccRGQMiuH4m045htuEcpHamTqat8cGwIT62rq6jEaELu
	5sqpgNhXF+JnCpwcMoVks1moHICVHviaOfFGVLQWIFcw/QEuFzAz31F6e8vhwUqmx3Abpivyi5s
	CjR5rox08nL4d06i4zpVZMTAUfj6KbaTmIj0Rjw/+
X-Gm-Gg: AYBFou0BdK8cVkhVNI9ohFD1X7FFTdYTsLNdt/eeupcgv4r6CnFhwnlss9XujXbdbpk
	VYaSBdQBckmpEQNnCiHDWJIlmchvAtGYXEkpYuzzLZbpPW3JGNSB9qg4K3hUPdPyl/9dwOmIm4j
	VSlc7bKpifecy3dM4NTEtgbZqTRNx2rpOUsxrcasR0IcZfmkdKU2IO4kp093j2fO8NIjqIw2cj8
	zPaPuoQcTmuseRWhKQXHM1ERNZzDMevvA+dh0HT8EelF7bnF8/yvkhqjQsSwJuHDtjZz4YF3owe
	eEo+TdTCFp0jXIs52ASbpdu3ATT9NvDsEcei/h9s2s70SerxcLHe85UodXWyDIWu3R28lATYNZc
	WaNYF6cFJLDxItO1SfEXH7qMHZ77bY6R8gw==
X-Received: by 2002:a05:6a00:2296:b0:878:34d7:699e with SMTP id
 d2e1a72fcca58-8a04caf967emr6870962b3a.46.1792444107445; Mon, 19 Oct 2026
 14:08:27 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-BA27.v7.r0.20261019115505@mojatatu.com> <QDISC-BA27.v7.r0.20261019115505-3@mojatatu.com>
 <87qzhlwo0a.fsf@toke.dk>
In-Reply-To: <87qzhlwo0a.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 19 Oct 2026 17:08:15 -0400
X-Gm-Features: AclHuK-QQl6EUrq2SbfmkjVQQT3-8KohZSlX-iqbzLfUmB0GFt2NA5_IPkxSmpQ
Message-ID: <CAM0EoMnzHpuvcF9RpNWBDNz_ooK9aFx5eGbmx_xymQXgWy26Aw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/4] net/sched: cap the accounted backlog
 before it can wrap
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	cake@lists.bufferbloat.net, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:20=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > This is a followup of commit 709f34f7c28d ("net/sched: fq: add overflow
> > bounds to quantum and initial quantum") as reported by Sashiko.
>
> The rest of this commit message is somewhat obtuse - too much run-on
> information. I think it can be pretty easily fixed by a couple of
> rearrangements and paragraph breaks, like this:
>

Sigh - i thought i took care of this (iirc, Stephen preferred the
shorter form as well)

Thanks for the reviewed by.
I guess i have to send a v8.

cheers,
jamal
> > The issue: fq_codel, cake, codel, pie, fq_pie, dualpi2, RED, pfifo,
> > plug and (non-WRED) gred account every enqueued packet's stab-adjusted
> > length into the 32-bit sch->qstats.backlog. A crafted tc size table
> > inflates qdisc_pkt_len() up to QDISC_PKT_LEN_MAX (1 MiB), and a dodgy
> > GSO skb can account even more through qdisc_pkt_len_segs_init(), so a
> > few thousand packets wrap the counter mod 2^32.
> >
> > The AQM then reads a small backlog and makes the wrong drop decision,
> > and the dequeue-side subtractions leave it corrupt (for non-WRED gred
> > it is the reported stats and the dequeue-side subtractions that go
> > wrong instead). In fq_codel a wrapped per-flow backlog can also make
> > fq_codel_drop()'s scan pick an empty flow, dereferencing a NULL
> > flow->head.
> >
> > The Fix: drop at enqueue once the stored backlog cannot represent the
> > incoming packet's accounted length.
> >
> > Ordinary packets (qdisc_pkt_len() at most QDISC_PKT_LEN_MAX) are
> > covered by a standing ceiling: drop once the backlog is within
> > QDISC_MAX_BACKLOG (U32_MAX - QDISC_PKT_LEN_MAX) of the wrap point, the
> > largest backlog one more 1 MiB packet cannot wrap, so there is no
> > per-enqueue 64-bit add.
> >
> > A larger wire estimate is checked against the space that actually
> > remains (len > U32_MAX - backlog): qdisc_pkt_len_segs_init() adds the
> > headers replicated on every output segment, so a supported small-MSS
> > BIG TCP aggregate can carry a wire estimate above 1 MiB while its raw
> > length stays within GSO_MAX_SIZE, and such traffic must pass on an
> > empty queue.
> >
> > qdisc_pkt_len() itself stays truthful for every input: it is not
> > clamped and the initializer keeps succeeding, so BPF
> > __sk_buff.wire_len, act_police and the HTB/TBF shapers read the real
> > length, and sch_handle_ingress() -- which ignores the initializer's
> > return value and reads pkt_segs for packet statistics -- keeps
> > complete metadata.
> >
> > Cover sch_plug and non-WRED sch_gred too: plug admits on skb->len
> > while qdisc_enqueue_tail() adds qdisc_pkt_len(), and gred bounds each
> > virtual queue but adds every VQ into the one aggregate. pfifo is
> > included because RED reads a grafted child's backlog into
> > red_calc_qavg(); it can be reached standalone or as the default child
> > of SFB. In RED, account the packet to the aggregate before handing it
> > to the child, because a duplicating netem child re-enqueues its clone
> > at the root while the stored backlog is still un-updated -- one guard
> > check must not authorize two additions.
> >
> > The guard bounds each qdisc's own enqueue path: a child that segments a
> > GSO skb (tbf, netem) can still grow a parent's aggregate through
> > qdisc_tree_reduce_backlog()'s unclamped byte delta, which is left to a
> > separate change.
> >
> > Conditions to recreate the bug:
> >   ip tuntap add tun0 mode tun
> >   ip link set tun0 txqueuelen 32 up
> >   ip addr add 10.99.0.1/24 dev tun0
> >   tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
> >       fq_codel flows 1 limit 20000 ecn
> >   # hold the tun fd open without reading so the backlog persists, then
> >   # send 6000 packets: the counter wraps and the unfixed kernel reports
> >   # a wrapped backlog, while the fixed one drops at the ceiling.
> >
> > Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojat=
atu.com/
> > Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026081810113=
0.16203-1-jhs@mojatatu.com
> > Link: https://lore.kernel.org/netdev/CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrc=
zkJjJEWN5sCuWd-ug@mail.gmail.com/
> > Link: https://lore.kernel.org/netdev/CANn89i+GOFH_8g+vSV0jUj0aBqLYVWuFO=
rHuDggZu9kPC_m6tQ@mail.gmail.com/
> > Link: https://lore.kernel.org/netdev/87a4oottcj.fsf@toke.dk/
> > Link: https://lore.kernel.org/netdev/87pkxks68f.fsf@toke.dk/
> > Link: https://lore.kernel.org/netdev/179231932946.3135.7497478990186385=
688@kernel.org/
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> With the above rewording:
>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
