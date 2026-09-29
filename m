Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC934C141
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713959; cv=none; b=SeYQuXPjZpRRUNWso+oBH1a1wJ6zZZRjeB/6DmH0Y47nLcFbTBerwmFLy2MI2GaUL2taLnWt6xwlD93hBTT54xVv8bzX9YTjWHfdNyrdTDO5whYKndMzjpZJ31qMy9UfsymvGQVp2Jn8mFSC/+/NfBJO3EUba4AY40mwdOgeSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713959; c=relaxed/simple;
	bh=hYcGHr5ibKDvDmCykNx3vX7gSuYkKSXK1bPrWSMxwts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CEm4mblGZekk1MuVEQTp1knX1mYluhzRHA4u9Oe+cnLGSltZADXesswKH2gN5bSfk24T0S8/phdrohkp3d0r+gz1NEY8yRMH2zFvI+viNkTrTsWMRgqZguYkpO+23prwWxcyt9EOzh5HX75QG+vBTqa3XlETAU1lnFG0YSwQWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Z9Tj+asr; arc=none smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Z9Tj+asr"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ab0d9260baso4749395a12.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790713956; x=1791318756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gjn3XbTkyEC/r4PvE0helBeSNrh316D5NMR1L4m81x0=;
        b=Z9Tj+asrbbs0RuzbTnAQsw1Huz0kGBQDMSK0kq5VFktUawva3tgu/lJvAkMZUdJzNt
         E2E+7sJAkZQzOQjXup7r6FEoHhL65jamaXJs9saPvbYMO0lR6kewaVlVvb0RqbgpKNgR
         IyCkFKr4mgPTehfyzyb+RyhlrtHdBJzgR7Omj0eFWgrpSauqHW71iyokUFUKcmz/zhoK
         YfPmwgv6v5xO56LIVADTTbrb17iG/FclEACAs8jhLrpJx7crhaVqypgEHTJvOU8vRNRH
         7D1Maqb6iFxpdK9ZFhLHzg96p4RojLFt9RqLxEnwA9f9NxJh+wN4wbbZUKNQKZKL6EgH
         hrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790713956; x=1791318756;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gjn3XbTkyEC/r4PvE0helBeSNrh316D5NMR1L4m81x0=;
        b=rXogEcRdKzc1uWVSK1tBhRNwLMEGFtSC3cGyaDgHEqLjHnvxiCLmjofbCEGgMHV+1R
         1GG6SjKpQB5pjHyCDAKrvdghueB0Y/78hCUi88/dEMan2S0ENZkFfbsS06DKgtAnRWqk
         /2eK/dNwymISVtQBxOTqbgYmbtII2QLeMKDQa2byitZeoyf/8ZmRDWu8lDpIMWhoxcYF
         dLs/tyVdecNQb37GxGD82quWx0+Y6AK68bz+JfpzGXzsO3SLzZkPs/r4DSyXszmcu0Fp
         tQ31kdkB23WqUXcy1EBB5Hr1hDNf8f5MDoYzuo8L1AVQU03vVj/jJ93m1yjdUbhNTKrK
         kA4g==
X-Forwarded-Encrypted: i=1; AKwUvBw+UOZ6ylI6rH2M9tFGeH4QIcc6GbVVrgnxmmBnokCADaWl4pYvhhQbLxMQ4N+yO70deWB3e0s=@vger.kernel.org
X-Gm-Message-State: AFuF++k6Wg8ThCoXSEgIXZM/oH7lLiO4oGEIYiBEtHRvWTfBSu7KiW9g
	6MO4v9WSFONecbYn0CdCWl6ox9+JIMJmZ/9GZi78y1jzjbE/DPZCkV4pUS3cZdAM6ys=
X-Gm-Gg: AYBFou19uor0TkCeOX1rvFMuUQz/yZGurib/DwIGHyMas5ALlT/cPAVb4kTvMaDhFYY
	g+p24sxkMrsOkhNDbkwir7xvJDzguXacD8xxrMx7MvLySAubadTKq7nn/2glySzD05Be52cp2YJ
	W3PC5XLUmvRXjl89OmfXToXEGCde1Gn8CfpKA2hGHjUIDpfOw6xlbU7xZjDn4hlcUzce9lPJq9r
	d5RxqWAWtp0vKKpl9gZ9chbo7Nyx/wS8SHPTcv2ElXxbWc158wza9aFuUv3LTgCrdUb1zRa8soX
	oernuZ0oPoOmV59j7Q5uCOvfEixqYNYEnFkHk5e20Fnroey1K9YeGgWClmZ9DYNZkNEBztww0hk
	lUhzljnWrbfnIgpeXc6dO7UbGz7s8lN+3msLbL4ACT8PEozIrWX2V8NlWU/VtgpsgUlHcFOdT50
	pMwd/VVuoeAg0zWUWw/f9cswkt/Wq1ngkWs1RrklUyiceBsq+d/GoWUM+Epl6/CfkQG8vvQD6H
X-Received: by 2002:a17:906:c155:b0:c29:286e:2e3e with SMTP id a640c23a62f3a-c2e15e255eamr43800766b.38.1790713955825;
        Tue, 29 Sep 2026 13:32:35 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e1330d7c0sm25660466b.44.2026.09.29.13.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 13:32:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>,  "Daniel Zahka"
 <daniel.zahka@gmail.com>,  <netdev@vger.kernel.org>,  "Kuniyuki Iwashima"
 <kuniyu@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Stanislav
 Fomichev" <sdf@fomichev.me>,  <bpf@vger.kernel.org>,
  <kernel-team@cloudflare.com>,  "Daniel Borkmann" <daniel@iogearbox.net>,
  "John Fastabend" <john.fastabend@gmail.com>,  "Andrii Nakryiko"
 <andrii@kernel.org>,  "Eduard Zingerman" <eddyz87@gmail.com>,  "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>,  "Martin KaFai Lau"
 <martin.lau@linux.dev>,  "Song Liu" <song@kernel.org>,  "Yonghong Song"
 <yonghong.song@linux.dev>,  "Jiri Olsa" <jolsa@kernel.org>,  "Emil
 Tsalapatis" <emil@etsalapatis.com>,  "David S. Miller"
 <davem@davemloft.net>,  "Eric Dumazet" <edumazet@google.com>,  "Simon
 Horman" <horms@kernel.org>,  "Jesper Dangaard Brouer" <hawk@kernel.org>,
  "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,  "Florian Westphal"
 <fw@strlen.de>,  "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
In-Reply-To: <DLR2ZT65RKF3.3KZ8O8P4VKTI2@gmail.com> (Alexei Starovoitov's
	message of "Mon, 28 Sep 2026 16:14:04 +0000")
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
	<20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>
	<DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com>
	<DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com>
	<20260925121849.2ac5150b@kernel.org>
	<DLONQQN0RB03.1NVWVFHGRRWV4@gmail.com>
	<20260925132004.171b751e@kernel.org>
	<DLOOI89GKM5B.W4XPBNJUXRV1@gmail.com> <87jyo5bcgs.fsf@cloudflare.com>
	<DLR2ZT65RKF3.3KZ8O8P4VKTI2@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 29 Sep 2026 22:32:34 +0200
Message-ID: <87ecebbxy5.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 04:14 PM GMT, Alexei Starovoitov wrote:
> On Mon, Sep 28, 2026 at 05:52 PM Jakub Sitnicki <jakub@cloudflare.com> wr=
ote:
>> The correct results - as in reproducible and with lower variance - are
>> the other way around - BPF skb ext is cheaper CPU-wise than gated skb
>> tracepoints. Please see:
>>
>> https://patch.msgid.link/20260928-bpf-meta-gated-tracepoints-v1-0-844dbf=
3e1edf@cloudflare.com
>
> I don't think these numbers measure the mechanism either.
> cpustats.py divides busy by ncpus, so +16.4 and +6.6 are the mean
> over 6 cpus, while 146k pps is the total of 3 flows.
> So it's 6.7 usec vs 2.7 usec per packet and not 1125 ns vs 450 ns.
> That's a lot for one kmem_cache_alloc/free and a 16 byte copy.
>
> Pls share perf report for both and rerun.

My mistake. Per-packet cost shouldn't have been normalized to CPU count.

I grabbed the perf reports and flamegraphs, and added another variant to th=
e mix
with per-CPU LRU hash instead of rhash to get an idea how much overhead com=
es
from locking. Gated tracepoints + per-CPU LRU hash sits in the middle with =
~1.5x
the cost of skb extension:

| variant                        | =CE=94 busy (mean/6)    | ns/pkt @146k |
|--------------------------------|--------------------|--------------|
| gated tracepoints (rhash)      | **+16.4 =C2=B1 2.8 pp** | **=E2=89=88 67=
50**   |
| gated tracepoints (percpu LRU) | **+10.0 =C2=B1 3.3 pp** | **=E2=89=88 41=
00**   |
| bpf skb ext                    | **+6.6 =C2=B1 1.1 pp**  | **=E2=89=88 27=
20**   |

% of perf samples breakdown looks like so:

| component                              | cnt  | ext  | gtplru | gtp  |
|----------------------------------------|------|------|--------|------|
| tc dispatch (`tcf_classify`+`cls_bpf`) | 0.08 | 0.25 | 0.34   | 0.88 |
| skb free path (`napi_consume_skb`)     | 0.05 | 0.09 | 0.16   | 0.31 |
| TX chain total (`udp_sendmsg`)         | 2.51 | 2.53 | 2.98   | 3.27 |

Everything pushed to:

https://github.com/jsitnicki/skb-metadata-bench/tree/main/profile

If the numbers look fishy, after Plumbers I can set up a proper
experiment in production to see what the CPU overhead is like on bare
metal.
