Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537B547F2E0
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327588; cv=pass; b=U5+PXwCqJI9uaer6lXfCGy9VaCtlX5bu5PpJ0BdUmRNSpX79ToopAhGh9cIBg/hmctwUmqhtoR4l0s20D9AXgQ+XK42rPv27qASkFKmarV1Z0m6T3gC+ocpRFU7l8ddX7n2KyVuJmkax/o9wz06WHYU0o3CSyX+9yjYNp32SOL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327588; c=relaxed/simple;
	bh=rTqLLUWRtbA/RwBQluKV+S7yx2zqLIkP0uuMUp6VrBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3IOBIgdw/2tcosSoHkZwBxJDW6wRz+iVq/WxBWm8+hzkMjJEdHczbwiCWBikP7J9xam4vifFgxl8d3epZaev2PhsNBMgCLHGC1+OXlPqaKKjMpsvUvDmkz7OZvjuE1Mcc8MyK6W9Zr/LbteAAByGW6nqdaES7i5nU5BD2zFyF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SC5tEHrp; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SC5tEHrp"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb766bfd3so5916361cf.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 02:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790327585; cv=none;
        d=google.com; s=arc-20260327;
        b=eXe4W3mFCWLJYXF1oXSIDAZ+LlObhY+KJrBr7lFADNqja7hmMQPdHfHDOXcPF7nU4h
         SNFcesbGhTlZDWgSEjP+Ok6L59ZN0T/yAekAtDuD4Tq+Sd/20wdQvw3I8F+yba5PubPJ
         SSjE7WTClPeFarB+ulRwybIc08L2Px5fN1QmDgDzinZVwol8DNSCVo4Z3FrMRD8LXlAk
         LN0KPnADlLsWpsC5ptqXPW6XhKrrm5fSW+O62fGZwrvf4W5bTyIA0yHXdq0zFde/7X+A
         ZsR8o9RSl5ZPPe1xkqH047n3z5C3OMxfBgZbZszzEsOHAHYf+OFgcuoEPRnMoEI4RV5C
         V4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bz9SxP4paTpewO3BSBe/LM1NQKvc6CcYHS65zRhQj14=;
        fh=Wj0YEqSJg7Dhhip2gJnvksj1lCh3dEEgy1VoHdYgBNk=;
        b=lq4wZYxrmxOdcZ2lJ1SO3kzG/Iz7qO1joUBfQ6y8fdGGLYKB2d27Y18DidHb5o7JAA
         5ctVcwN5jZ8D12VooqXjr+wsa0NFZPzdxjj/o8vKiK3KV6+5CWngJs/P5VXR7SdqqCwA
         zDET18sdcPFMyPB7WHrHroO7WBodG+tHkUTE6jn8W9/sY0fwZYJ90JO9v6KDXHZDFWeA
         w0dwvzC9z8bc0M5FVIPYd4QYwy0jZOOeDN4veg+CYqe22Z0D1LoAO3IUpp5u/R3nVZwR
         T/B09Ahusu7tWKa9/ziDpLmpeapU7mvvKcup3pyGNwWAZELu1zhcO/knu6hRQsa8w8X9
         Fv4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790327585; x=1790932385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bz9SxP4paTpewO3BSBe/LM1NQKvc6CcYHS65zRhQj14=;
        b=SC5tEHrpUax3L25yJbOza42AQb73mv+Ik1zXgVNr++hDFIYb/FTuegnEdcOVRv6Onm
         Et4VtNMAiRLdFzfOrVBZOmVZFV/74bRRSBfWTTt1nFbtejKHkMmm8g+u4aYtTQPLZa23
         LqRQVWPOBfhCqsPkt1gRlY/FXqZiH83uk7St8FNAzGDwAQFup2z8i/kV7XC8cutzjjMJ
         5g4Rx5Cn4Nc/WUpTGlMH3tFMp2vA70nJRPDnoYvdqbXDtsP5ophnY7CgMJfvluDNCseY
         bHCv7/f6G2Jkt7S6Juq1gXmwdy0OJkeQAI5gwQ6I/RcxYBNgpNMH4NRkwV3g1qLEAZgp
         ByGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790327585; x=1790932385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bz9SxP4paTpewO3BSBe/LM1NQKvc6CcYHS65zRhQj14=;
        b=anK/qGd6hi4cNcHCkOSkPngUB+YYQ1cPd1Eg+cnXSeEjZW80+V7hSA3iIM13BnsOFR
         SPdc1QA7uBreJFvEck8CR4PvAoXFXb2xV0fzAIAAaUYs2JYP3p1PyZxKayy+L71ZRNhz
         xEDbFll1xiEYRa09Sso0+X6Eqt+KtFuQpVVIPx8yPH9BvfJzluNuPag73AIHnuhWHJGN
         QsKXObUM1OvZUUnxXHv8JMl57O58cHn3SxNLA8RTRPVhr3ubuVNBiFwzq6IHMNLKLOZd
         eov257R32Z5SmYQhw3nx+01m87wJpzJNXTDDfcnQubMQGlJjLqLJBfvHXEvxUYvT8FXj
         2IDw==
X-Gm-Message-State: AFuF++nazCLba8EaQtFMhZMMFAxqjjZGJ9+R+ZAc+RotQSlW5O7+iXsU
	pz7pC/itHsVNMd13DiFdSTWKOcoM0YwfLidHyAOtyD13zxDrsFretJO6Qsfe8z2ontpMVIpwfcg
	isaY32BH2yw9if7dO24mhSEXG1VK/jyrVGMG6BQLE1pA2pQbGZBrhknb8
X-Gm-Gg: AYBFou1F24QjiR1pMxmGlVfqRpXZa82cTMFXaQVQ3fkrnjZnOJ+9Ib0X6ZTE1JSUgfY
	5XM4fd0XhlGvjZX+RoAjcsumtdIACoMotwa9+eaGMJpGckp73a71YFQerGuCLxGF+NYiREZy6wq
	eGHCXLmf9anqbxWZX2pRCHX4Qp+K1PEuUrL6eafEbPAS6Ob9nenAlrXC9IfxjAF0zYNtP1fJpkJ
	OoKhQnmG1FN9ZaKM0W6peIblXlPhEoQAG+qPyxWfU2mR0R3rkMluMtkQ6/Ad5gYBECyxaVPJSkv
	ZeY8pAJu2YTdT61G7n4NgQPA8Jet7DCTbXfMFa6iS6CeUGa27CZGJyRYZK4p/H3tl29EXmOcnu8
	5PP2ZDwVtNuSdS5JCPHD+tvcY/tT0YYBbdMUGicKG2uCkbNWpLxnYdJTeKfFPSS+wSgg/
X-Received: by 2002:a05:622a:156:b0:530:d429:c70a with SMTP id
 d75a77b69052e-5330b5f31bdmr29787901cf.26.1790327584464; Fri, 25 Sep 2026
 02:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-BA27.v1.20260922092618@mojatatu.com>
In-Reply-To: <QDISC-BA27.v1.20260922092618@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Sep 2026 11:12:53 +0200
X-Gm-Features: AclHuK8GCiEqq2_4rQ3AwZboOt1ZnIczmCQY-4PqwzAjbQfTPZ2smYUW_vtZ6Bk
Message-ID: <CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: fq_codel, cake: widen backlogs to u64
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	cake@lists.bufferbloat.net, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, hybris <hybris@mojatatu.ai>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 10:54=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> This is a follow-up to commit 8f735d64382d ("net/sched: bound
> qdisc_pkt_len to prevent qdisc soft lockup"), which capped
> qdisc_pkt_len() at QDISC_PKT_LEN_MAX (1 MiB). That cap bounds the stab
> amplifier but leaves the per-flow backlog counter u32:
> fq_codel_enqueue() accumulates qdisc_pkt_len(skb) into q->backlogs[idx],
> so a flow can still accumulate 4096 packets of 1 MiB each and wrap the
> counter mod 2^32. After a wrap, fq_codel_drop() sees a tiny maxbacklog
> and drops from an almost-empty flow, and the dequeue-side subtractions
> corrupt the counter further.
>
> Widen the fq_codel backlogs table, the fat-flow scan (maxbacklog/len) and
> the drop threshold to u64. fq_codel is not lockless: every writer runs
> under the root qdisc lock, so plain u64 arithmetic keeps the WRITE_ONCE
> publish / READ_ONCE-consume pattern. The dump path
> (fq_codel_dump_class_stats) stays a lockless stat-only read.
>
> CAKE accumulates the same generic qdisc_pkt_len(skb) into its per-flow
> b->backlogs[] and per-tin b->tin_backlog and consumes the values for
> longest-flow pruning (cake_heapify/cake_heapify_up) and for the shaper
> staleness check, so it shares the bug. Widen those counters and the heap
> comparison locals to u64; the class/tin stats keep exporting the low 32
> bits through the unchanged uAPI fields.
>
> Conditions to recreate the bug: CAP_NET_ADMIN in a user namespace;
> CONFIG_NET_SCH_FQ_CODEL=3Dy.
>
>   ip tuntap add tun0 mode tun
>   ip link set tun0 txqueuelen 32 up
>   ip addr add 10.99.0.1/24 dev tun0
>   tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
>       fq_codel flows 1 limit 4200 ecn drop_batch 4096
>   # hold the tun fd open without reading (IFF_BACKPRESSURE) so the qdisc
>   # backlog persists, then send at least 4300 packets (the wrap starts
>   # at 4096 resident; the over-limit drop that reads the wrapped
>   # threshold fires past the 4200 limit): backlogs[0] wraps at 4096 x
>   # 1 MiB and the fat-flow threshold reads the wrapped value.
>
> With a 1 MiB qdisc_pkt_len cap the counter wraps at 4096 resident
> packets. At limit 4200 the first over-limit enqueue (the 4201st) sees a
> wrapped 105 MiB (half-backlog threshold 52 MiB, a ~52 packet drop burst),
> where the u64 counter sees 4201 MiB (threshold 2100 MiB, a ~2100 packet
> drop burst).
>
> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026081810113=
0.16203-1-jhs@mojatatu.com
> Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.=
com/
> Tested-by: hybris <hybris@mojatatu.ai>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---

This makes no sense.

These qdisc have been developped to address bufferbloat issues.

Storing 4GB in a qdisc is absolutely insane.

Let's drop at enqueue if the current backlog is approaching 4GB (this
can later be a new config/attribute in net-next)
