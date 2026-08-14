Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780E9434E30
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695272; cv=none; b=uwvvkqBwMENolX1fEW/MWPNKJJVhA4AKOPMIs9aObtmz8SPckYQK1t4r/RmdyR8TfGP11oUDkqOpW4uJtTxlGcEyH//DSSmVRks5cPQ+m88L1teLlPYf/vTJiKNIPbkWfp4Z6SNqrE5ijXu+W4p+rimZ8Ds5llZV68DQK6OXIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695272; c=relaxed/simple;
	bh=bHZsfLLl5vwCbNfcZaQIZTl5GdjBuDhT51CRLHiccZE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LmhTbikzupj0J60BYeMSRG+25pTB2zJkqDl50P/ulx0BEdX7Em2DpgpRWhVx+RGxRqeP81MoZcExX10hPjvYzZlYnfCw0Y48+CbhPNm9TftHZ/8LXQ2EjoOeVC/6R/Z/RqDQlyh1LcjPSpMkOMaMd9VWJ+RnlPT9DveRgzfHxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SBf1sa+f; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SBf1sa+f"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so1093527a12.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695261; x=1787300061; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yPXr0G+xg2fjcvTsT5qtmvvWszHpLn8rkkUHyiWVWks=;
        b=SBf1sa+fJYMgtQZbA/Pr/WGeqXN4SH0tI/lCt1mGSZmzIfSnq60UKTBm6XMav+1PPr
         oXGNFxQ27tmH6Mfy2X14H/44rMFqhy1QFEay/6i4xvYc8kVUozS+s1Mp48Lt2foT8m5E
         jTxSwPWTZXCP36GXehDCrMelb8fFZk2H54TQglHx9XoH1Cy07bKX8cWR1OCb/s7gMdly
         MU/UvMBL/+EbolRCrGV88JfS6qDgrnWmajoDvfn05vSiBnwSyZPfGGvAB5k28Z6ZJvcv
         LS67IcdxSdCbe8PvPZQZPinyEz8kHjgPa55XBgV0b8oPdNIO2ZOfX7w7UQSd/60oVpfS
         mUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695261; x=1787300061;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yPXr0G+xg2fjcvTsT5qtmvvWszHpLn8rkkUHyiWVWks=;
        b=KIHC4xphBH34PdK0fMXavataXzxpbPVPKEC8aceyMHe7KJ4tlaIT79I/kMJzd2EAkE
         xpdphb4CHVM3nTPPJpLQXehApHbVMYy6zY/rvESmaxOl9MtD1y48yAzNUUu5OCUTeJql
         dtrDgMyCfcAs54tX5UVwcdhZ5MMz3Qv5I+tmgO9QenIMCfgmsTsKP2izcuDdmb9/PFvt
         ojjUFCXesZA8ju+GM4ZX17R4YU8haYyl+wAmDMTaKp2UT/OICUtuODgejCn2Oo2kipA9
         rBiqHTno815sKa8fVrxPtCa1xeJ48yZuC+Flh8/j5RKzf+lbCk2PeQq/lMeaVne3NnL5
         0yIA==
X-Gm-Message-State: AOJu0YxS49w4h5klml6ElxibRKhZn75g6A8jtqV8m+6fYddBhSYQmWht
	xFxIAqfJxhNhavj0LXdqr170+gqaLc8CYjWtxRrLxsVYhqihyCHJZMHufW5xpJFc3CI=
X-Gm-Gg: AR+sD13KvSRNmpEGMIR9rP0V176p6/NJQY4KQt4zc+d93EM8C5XIuLmRnGE+9QaoIK4
	MZhs/5wsI2QwE8hFCF2r/9EWhS6ah4w6+K0MoPvNnIGLZPSZKWknMKS2ewyn2dCQiL+3VewS0sz
	4+aRa9mzcCGHeGg59DM/UlkxoJEXW3pSDMrO3dQEj1cRQmnly7RYochXN+eFWuuEop1kRTCP1n1
	qvy9ucStl1fDIbnbLxUQfVjPcd3e19RvxVVKXFmG5Efhr7Ke1lfWrdFpTmu5QkzBFFcdvacpH2G
	/kGYV9uuZP4RuKakUKWSHuCnJrErThNhuPa4RBxwyZSGu/0GOYmG79se+uEiEN++rooIR/3eNnW
	wPwvof+FBo8QMN4K4/YtCSXGJYchmmpxyYTjFo2suOvGKakI6bs0gOczkEOUe9+sbSRrZ+CI451
	5pnIVFToD5EWQw1sT4FCcef0mGGuNGhHOkZmfDwPFJHAUIVbJYE4AOYBObyDUTtj16MHxS8zcPg
	Xsay+S+VBsXuQ0Tfi0DTStsI3WViHx65B7iHA==
X-Received: by 2002:a05:6402:3894:b0:6a3:6d6d:2296 with SMTP id 4fb4d7f45d1cf-6a38a8f5391mr1871067a12.5.1786695260946;
        Fri, 14 Aug 2026 01:14:20 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a38c9d7f0dsm520559a12.3.2026.08.14.01.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:19 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next 00/14] skb extension for BPF metadata
Date: Fri, 14 Aug 2026 10:14:01 +0200
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEnOfmoC/3WOQQ6CMBREr0L+2m9oVUBX3sOwKO2vVKElbSEYw
 t0tuHY5mXkzs0AgbyjALVvA02SCcTYJdshAtsI+CY1KGnjOi7zgJ2wGjT1FgcYGowjDu0GaI2r
 NmbyyiiqpIdGDJ23mvfkBliLalIL654SxeZGMW/GWbU2Izn/2ExPbiX2vZOe/exPDHC9VyWRei
 kqp4i47NyrdCU9H6Xqo13X9ArNmfKDfAAAA
X-Change-ID: 20260623-bpf-meta-inside-skb-ext-ff21c918e8cf
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: b4 0.16.0

[I realize net-next closes soon. Posting only to collect more feedback.]

Please see the RFC cover letter for the overview [1].
I will focus here just on the latest developments.

1) Based on feedback from the RFC - the BPF skb extension is *no longer
scrubbed* on tunnel encap/decap or veth traversal. There is also *no
mechanism* to enable scrubbing as we don't seem to have a use case for it.

2) Since the RFC I've enabled access to BPF skb extension for the remaining
BPF program types which operate on skbs, namely netfilter, lwt family, and
- everyone's favorite - sk_skb.

Outside the patch set, two things happened:

3) At NetConf 2026 Kuniyuki presented effectively the same idea with a use
case in mind to attach metadata to packets on egress (IIRC). Hoping for
feedback if this meets your needs as well.

4) At BPF Summit 2026, Alexei asked - I'm paraphrasing: What percentage of
skbs will carry metadata in our workload? This determines if the cost of
attaching a tracing prog to consume_skb gets amortized. We've run
experiments and have some answers.

If bpf skb ext existed today, we would adopt it to attach metadata to
incoming TCP connections and ingress UDP packets to CDN to identify flows
that have been forwarded from one PoP to another.

Based on stats from a production node where we've been testing this patch
set, the fraction of skbs that would carry the metadata is <1% (~0.7%):

```
923m16$ sudo perf stat -a -r 10 \
            -e skb:consume_skb -e skb:kfree_skb \
            -e probe:skb_ext_add -- sleep 1

 Performance counter stats for 'system wide' (10 runs):

           334,256      skb:consume_skb                            ( +-  1.63% )
             1,525      skb:kfree_skb                              ( +-  4.09% )
             2,218      probe:skb_ext_add                          ( +- 18.58% )

           1.02305 +- 0.00243 seconds time elapsed  ( +-  0.24% )
```

I expect that even if we adopted bpf skb ext for other use cases we have in
mind, like labeling egress CDN packets with a customer identifier, we would
attach metadata only to around 5% of all skbs in flight.

We've run an experiment to evaluate this patch set - bpf skb extension -
against the alternative - using a BPF map keyed by &skb (LRU_HASH) to stash
metadata plus consume/kfree_skb tracepoint programs to clean up the
entries.

To do that we've modified the CDN component that labels the incoming
connections forwarded from another PoP:

- with bpf skb ext, BPF progs involved in processing consumed 7.5..10 CPU%,
- with BPF map + consume/kfree_skb tp, the overhead was between 15..20 CPU%

Not surprising considering the low fraction of skbs we attach metadata to.
(For graphs see slides 30 & 40 from our presentation at Netdev 0x1A [2].)

Note that we have not tried using RHASH as a BPF metadata stash, to see if
that could bridge the overhead gap, as that would involve deploying a
non-LTS kernel ATM.

Thanks,
-jkbs

[1] https://patch.msgid.link/20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com
[2] https://github.com/jsitnicki/talks/blob/5d64c151f4dc0c38b2832fdcbce7284ec93fdca2/Netdev%200x1A%20-%20Thrice%20the%20charm%20-%20an%20skb%20extension%20for%20BPF%20metadata.pdf

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v1:
- Don't scrub BPF skb extension. Remove F_NO_SCRUB flag. (Stan)
- Allow calling bpf_dynptr_from_skb_ext from NETFILTER, LWT_*, SK_SKB progs.
- Reorg tests into smaller commits. Add missing coverage.
- Link to RFC: https://patch.msgid.link/20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com

---
Jakub Sitnicki (14):
      bpf: Introduce per-packet metadata storage for BPF programs
      bpf: Allow access to bpf_sock_ops_kern->skb
      bpf: Make BPF skb extension survive packet scrubbing
      selftests/bpf: Add tests for bpf_dynptr_from_skb_ext
      selftests/bpf: Test skb_ext on cloned skbs
      selftests/bpf: Test skb_ext survival across veth and GRE
      selftests/bpf: Test skb_ext read from cgroup_skb and sk_filter hooks
      selftests/bpf: Test skb_ext read from sock_ops and LSM hooks
      selftests/bpf: Test skb_ext read from kfree_skb tracepoint
      selftests/bpf: Test skb_ext read from netfilter hook
      selftests/bpf: Test skb_ext from LWT in, out, and xmit hooks
      selftests/bpf: Test skb_ext read from seg6local End.BPF hook
      selftests/bpf: Test skb_ext read from sk_skb stream verdict hook
      selftests/bpf: Use non-trivial test payload in xdp_context tests

 include/linux/bpf.h                                |  10 +
 include/linux/filter.h                             |  26 +
 include/linux/skbuff.h                             |   5 +
 include/uapi/linux/bpf.h                           |   5 +
 kernel/bpf/helpers.c                               |   7 +
 kernel/bpf/log.c                                   |   2 +
 kernel/bpf/verifier.c                              |  15 +-
 net/Kconfig                                        |  20 +
 net/core/filter.c                                  | 135 +++
 net/core/skbuff.c                                  |  81 +-
 net/ipv4/udp.c                                     |   9 +-
 tools/testing/selftests/bpf/config                 |   1 +
 .../selftests/bpf/prog_tests/socket_helpers.h      |   1 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 988 ++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 489 +++++++++-
 15 files changed, 1772 insertions(+), 22 deletions(-)

