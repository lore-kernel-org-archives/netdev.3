Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAF239E9DD
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944677; cv=none; b=hwzPIYqgHkOA2Kx8TJrorLJ1M2IgcMBzA+RJ4CUC2lvdQ6T8NDwSViJfC1jQo9wvN8AWTNs+9XaOAoC70DGvYRtQLazbHUsGNvJVvKbpJHzJcpbQcUAxH+c8EzH6pTIXkTzuek6tcK0T7DlrLkPMNVJrfKMBfXKXNTJn2YwnxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944677; c=relaxed/simple;
	bh=GWXc7aqz+JP/62ObxFDdswrcYFvTCyfgsbz2ENpfWG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f7CgUfSmofuG65p/07DbFoqjLhq2oYOE78RjSOmA99F2EBLEmXGIzUZ5QufWno86rayeMFMSXFELqkKFLVND9LohB+/6tkGsuEV5dStX5+r6pnZ95fL0b6iMMKovg/Ym74s516aG40lOoCjWc6DVk2c9l/GslwauOwjW4roQrug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QjxKVWDj; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QjxKVWDj"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e315287c9so287153566b.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790944674; x=1791549474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kPQTISOHvgDFG/D95e14Nk4IcEq4M+yFBnxlnHIdm/8=;
        b=QjxKVWDjLz7xiil9/CJMWH3v1jXphTFP0odrkm3EZ677L2NR6RQ9waDX/u6iGBxd4y
         6iOWCwsTonam2NRH/M/OpgyNCrWu6zAR6jvWT0Ar0ffA8LYmxOno+sf15dlaFGHz6X71
         Goznv5p/TypvXVTRzmk4We+PcghBu8zXMFGccBKS15pUNQquzXDX9LWIIiYDpcpJMmFh
         +9vRlT6muUIHPP9Hntw9mZxFI5bI7qnksrmEnoD6yh/Mx7qnvMYCAHUQrxFlYwgq9YSy
         YNEufGXhOIz5H8AHhVbzy3y/E1ejHjSZ4ROkluSEso2mx3fg9ZFlc7tt6NRaNsyNDuQh
         CKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790944674; x=1791549474;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPQTISOHvgDFG/D95e14Nk4IcEq4M+yFBnxlnHIdm/8=;
        b=1r2McNosqJ4skGlZVyGs+/cKB+Bm3MzNuBNEL50XeEt1Juk4mbR8it27nt4KGnoQj6
         2HaSll/DRBK4YEGCh6sD1vlIzxlaKEXVey1dq08n6HSAEpb1ri4w26hBHTxxHIsfrQxz
         pNEOHhVZ/I7wGbLzvqhHGjYDOe1KGaDOIKW1TZpMHDvepsgwuFRlKWaz/bnq+9u67Ung
         Z9aI9eOo3jPjcSH+OmiQ3uyBQm7w7Tm1PBPw/YgbJdteJVAjCZdJECttccWj/wXwWgUp
         ZENggqYVgaAVJXjxHotxxktoU8hyCOUFKkrN7eKEvBLywrtkuYhC1gpRPZwC2ghHZkfd
         bY3A==
X-Forwarded-Encrypted: i=1; AKwUvBxU6v+zPfv3tDj2XXEM3DKfGCWkVCb/HHbm4E760y0ULMpRjY4SZPY65DvbK555Too9XzgmaIA=@vger.kernel.org
X-Gm-Message-State: AFuF++nOYkehBu8/+RytJzkDQFrRIhDbQTwUOVtuYRL6SwL+1kKx9b/S
	8/7hx3Faytnrh6FG05tO5ok/cUZjpWnOlCTnLyucM7PnUzA0dWgdE3qiQhTebi7an8M=
X-Gm-Gg: AYBFou3otMFW5q1Syu9uCZtfwwXEYD4TJLLxNiniGlbQJTn1Gk2MPqUVUraIjhTV7bH
	mzdhR9nq0A1BeI/i2uTu/tbm6lpxF0MoUrNvnwFX6okHFdN2mH7gnNMo8f9r7JzmbAsa3XmRXF1
	sqRydxXMFJw+JhdsRXwO4V6txvh4HqVSc7pdZOtSnigq5Yj3SbPVtkR+rmRRfSP0Ckb589skHJf
	cSXuIC1uxPdeShx/BNgUO/wMqLVYLeW8TdAQBge5QyCheVZNAJ+zjgH7aHxH9o2LC3QXcAuN+/a
	JHc33ybLhavZbEBVSWDsYzPSUzOpkqSdXrTY/0dkZZ0oQ2Ft+8t9daOr6VHAUPJAS3kPsMxepni
	0pp2ng12uAGdoUtd4XU+6OYUKfjZs+/qwm4zoa84bH6FXr9pojdKa/Vhx10kxWVTCryXYCZSnFV
	nS2qItnVFfV+RhaBHtd38My7Cs5++U+0KGAN6m3vzMFmroL+qSHTaVKe5w+owEbFENGBu6YqfH
X-Received: by 2002:a17:907:7a13:b0:c2a:c6fd:ec6c with SMTP id a640c23a62f3a-c2e4adbbb01mr209234366b.30.1790944673795;
        Fri, 02 Oct 2026 05:37:53 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4ca4e2d0sm84749966b.4.2026.10.02.05.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:37:53 -0700 (PDT)
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
In-Reply-To: <DLSJ0UIY3DSY.3JWS6CS3TX0IP@gmail.com> (Alexei Starovoitov's
	message of "Wed, 30 Sep 2026 09:00:23 +0000")
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
	<20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>
	<DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com>
	<DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com>
	<20260925121849.2ac5150b@kernel.org>
	<DLONQQN0RB03.1NVWVFHGRRWV4@gmail.com>
	<20260925132004.171b751e@kernel.org>
	<DLOOI89GKM5B.W4XPBNJUXRV1@gmail.com> <87jyo5bcgs.fsf@cloudflare.com>
	<DLR2ZT65RKF3.3KZ8O8P4VKTI2@gmail.com> <87ecebbxy5.fsf@cloudflare.com>
	<DLSJ0UIY3DSY.3JWS6CS3TX0IP@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 02 Oct 2026 14:37:52 +0200
Message-ID: <87ik3kl1lr.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 09:00 AM GMT, Alexei Starovoitov wrote:
> On Tue Sep 29, 2026 at 8:32 PM UTC, Jakub Sitnicki wrote:
>> Everything pushed to:
>>
>> https://github.com/jsitnicki/skb-metadata-bench/tree/main/profile
>
> looks like you had lockdep on, so all the data and conclusions
> likely do not correlate to production.
> Pls fix and remeasure everything.

Thanks. This makes much more sense now.

1) Lockdep was on. Fixed. Configs published to [1].

2) Switched from mpstat to bpf_stats since bpf-skb-ext cost was so low
now that it was drowning in the noise. skb extension teardown is not
accounted for.

3) With rhash, I noticed churn from auto-shrinking in map_update_elem
(can be seen in gtpchurn profile [2]). LLM suggested a one-line fix to
set min_size from map_extra hint. Benchmarks ran with this patch [3].

New results (prog runtime from bpf_stats in nsec):

 ~/bench $ just bpfstats
python3 tools/bpfstats.py --agg results-1 results-2 results-3
variant          prog              results-1  results-2  results-3    total=
 mean =C2=B1 spread
---------------------------------------------------------------------------=
----------------
ext-cnt          cnt_ingress            35.9       35.6       35.5      106=
.7 =C2=B1 2.2
                 cnt_egress             70.3       73.5       69.2

ext-ext          ext_write             199.3      198.9      203.0      263=
.8 =C2=B1 1.9
                 ext_read               63.1       64.1       63.2

gtp-cnt          cnt_ingress            34.4       34.3       34.6       94=
.6 =C2=B1 2.5
                 cnt_egress             59.9       58.1       62.7

gtp-gtp          gtp_write             531.0      555.9      567.2      920=
.9 =C2=B1 34.5
                 gtp_read               85.1       87.5       91.2
                 gtp_skb_free          267.1      283.9      293.9

gtp-gtpchurn     gtp_write             784.9      782.6      830.6     1190=
.8 =C2=B1 44.2
                 gtp_read               82.5       82.3       88.6
                 gtp_skb_free          297.5      294.7      328.7

gtp-gtplru       gtplru_write          394.9      391.9      394.5      542=
.8 =C2=B1 1.1
                 gtplru_read            48.2       49.4       48.9
                 gtplru_skb_free        99.9      100.4      100.5

gtp-gtp is with nelem_hint+min_size hint set.
gtp-gtpchurn is without it (map_extra=3D0).
perf reports and flamegraphs also updated [4].

[1] https://github.com/jsitnicki/skb-metadata-bench/tree/main/configs
[2] https://raw.githubusercontent.com/jsitnicki/skb-metadata-bench/refs/hea=
ds/main/profile/perf.gtp-gtpchurn.svg
[3] https://github.com/jsitnicki/skb-metadata-bench/blob/main/patches/rht-n=
o-shrink-churn.patch
[4] https://github.com/jsitnicki/skb-metadata-bench/tree/main/profile
