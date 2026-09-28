Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19834AB3D4
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595627; cv=none; b=IItga3Bq1C+7Qrd7yh1pkw3AuH0H4xI7vak40BXfyHUSUGSqN0uGlAjffdM/Izc+jrO4jYQS06QTyTf2kW7H+zNiomwPtM+E/YmnkB0OhYb9sN9ePjIpzJMtMEx9YBW+G8tH2gT9blZbijwYNt5RAA4XbEKw8pVGumly7/MaIVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595627; c=relaxed/simple;
	bh=BN5QIfhCOfJT8qizCSFHHUYyXWZp4qGwJfodbyc0FUQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ae8NqLPk9S4aD44ldkSP5yz5XLRD9DebeVwTkSxR3BjRB+ncUEzXxUeeEFu10YYcYKM8OlvACtiLH/Isa819yWra9TvxRAueGbfG/g/poxjkFNavSzfYtD50RIZ89MIaIcCTX1mhzfb/QMRTXsRUlb68epSdz0AhrGrdm35T1ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Tp4JCkwc; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Tp4JCkwc"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2dc50c6edfso147702066b.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595624; x=1791200424; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NFEK3ubBPi1IZBwmUcsJb/U5KJU3Jv/GzmZN0pbsg6c=;
        b=Tp4JCkwc9y/kwRnNwAhHUvvFkSf8Yo338Umg4Q9H7mGw069ewAx8pn1BFvrZnpgEsU
         gFDmMYB2Ajz7WcUL/XFLFodX3vKAXZ76sJpNO1WhuIwcIlI+mSYECQrZHZ1CqU2LEutk
         gT5qhcVOfzOP+SM0vRvRDWudz1hPAoASa9oMnY1AZX+4ZXl/EYpo0/MK9m4TCW0w98sp
         AdkNg0ilJYILszf5qHUQ32wwbOtJIBlyGd0NQbAlgMkR5CZfn1/Dh7wFuNmgM6SIg0bi
         x90T0GscimETFtwm3X4j+ytHYulkIjwvN7MUMe8mm2imkpJWP8TvNZhBoe/Ubg42dzAL
         WDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595624; x=1791200424;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NFEK3ubBPi1IZBwmUcsJb/U5KJU3Jv/GzmZN0pbsg6c=;
        b=yncZNaYbVpkMQ2nNec71FnZPf8ArnPbvJkDuPSEAOXly5RJQKL66dRPKeCRLEL6kAx
         A4OP22qLY2YNkZs/IDVFYuBijn/2yzJFkBtblQi7l/jfK4QOCiOfByLS5eUgnXk1yzgD
         Bhz5ZzZ82H5r6jqZJd5gK04e3cBDXGMpU3ZjDeJ2OSdlg06XO8tGQFUwhdC4MugTLwks
         myoBTCAUUfc7+d4ZlxiKzUf4n/Ygvn5vgk+mGxX0/Bm+n1nIrLJzYAkYfCZngb2H60sH
         BJJvSyLxAN5pIS06vjG9eB9LiT5T6C09PwBocpz2jnoNecKqyUd63BW/1saFMW+HP+FL
         1ylQ==
X-Gm-Message-State: AFuF++mySIjZqN06i8kMwX4DoOlkupQIQub02jIlONR0TI6JWS4V1fTr
	1TK1lkAoaISxuZoJ7P3haY1lGBsyJLA4LlAS5x8SKeoP5tX1uKMJ6dU+18x+cJlvIa8=
X-Gm-Gg: AYBFou2JXmmpOO4dq0CYjuvdYWxbLKFVUngSFFNImhiYUrBW6ItrGcA7wGUWa9xfGWu
	n6T4YUyUZC5g/+y78AVpHzuk6ZGqpXAbqkO4Zn5CKhxwJWiqvmYTepWRjw4ut6EnTDAgq4UQzYd
	4+fxjryXiN80akuRjdDlwMWmfr0PnvOjt0SkyR5eabUYNOMslgJa2zeS3F+bj5Vw9kZBWsdCsbS
	F6Pnw3QabQPKJ2ZGybRbgRAgx5MOIeug7UZ2weOUSr8yJV1LkRMLtFdaVPirWzu4rFfybqqMBVw
	ukXLG3mal/xRqCaeV7TMOkzGs8F+shATIDPJ7fzVNS41I+Kaqbo2YVyxFeh0DAHxdRlFMw+3rdN
	bvammfHqG80s4nJqqnl5/Xw3fP4KDtiKJgbX7bc9+BYJHRQOPwYVUoOtYqMbLei1OSAtbszFAaJ
	GygNrSDtm8SWDhs8urke9ewQkQtQYGgVqWqg5Bl4m2dO+i6WaKlMhA/0sSeHXFS1oG1TNSisa6+
	eZ7DqrMGrhYJrzYBfND1L6F+uDz30mn56GuK6JyyKkXXMbW7lE/nZjksmhmqgrnN4Ph9wCv5Iiw
	RcVlBSYAUJ1x
X-Received: by 2002:a17:907:3d08:b0:c25:2a78:15ed with SMTP id a640c23a62f3a-c2ac22db502mr1037605366b.6.1790595623924;
        Mon, 28 Sep 2026 04:40:23 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-491b-1300-c0dd-2af4-566b-b23f.aa.ipv6.supernova.orange.pl. [2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dec4cec91sm24711666b.28.2026.09.28.04.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:23 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next 00/15] Gated tracepoints for skb lifecycle
 (free+clone)
Date: Mon, 28 Sep 2026 13:40:17 +0200
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACJSumoC/yXMQQrCMBBG4auUWTuQ1lDRq4iLNPlTRzANySiF0
 rsbdfl48G1UUQSVLt1GBW+psqQW/aEjf3dpBktoTYMZRnMeLE858hPqeHaKwFqcR14kaWXrTsc
 +BoM4WmpALoiy/vArJSgnrEq3/6mv6QGvX5v2/QNMHqygiAAAAA==
X-Change-ID: 20260924-bpf-meta-gated-tracepoints-4a731fd0ef64
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

This patch set implements Alexei's idea of gated tracepoints for skb lifecycle
events, which offers an alternative to an skb extension for BPF metadata [1]. I
have kept it down to a usable minimum - patches introduce gated tracepoints only
for skb consume/drop and clone/copy.

* Implementation

... is pretty straightforward. Please see patch 1 description for details.

One note - at first I tried to use of skb extensions - the free bit left in
skb->active_extensions and the skb_ext_reset/put/copy code paths. That turned
out to be a wrong direction. A "special" skb extension that doesn't require
space allocated in skb->extensions slab makes the logic messier.

Hence, I went back to simplest possible approach of having a dedicated bit
directly in sk_buff and adding callbacks directly from core networking code.

* Performance

Early results I've posted on Friday [2] were wrong. I owe a correction. They
were heavily skewed by KVM halt polling being enabled. That led to some
nonsensical numbers sometimes - like a plain TC packet counter measuring as more
expensive than TC + skb extensions.

New, stable, reproducible results tell a different story - gated tracepoints are
~2.5x more expensive than skb extensions:

| variant           | Δ busy         | ns/pkt @146k |
|-------------------|----------------|--------------|
| gated tracepoints | +16.4 ± 2.8 pp | ≈ +1125      |
| bpf skb ext       | +6.6 ± 1.1 pp  | ≈ +450       |

Setup:
- 146k pps spread over 3 flows,
- 36B UDP msgs over loopback,
- 6 measured vCPUs on pinned cores clamped @ 2.7 GHz,
- per-packet metadata on every packet,
- KVM halt polling disabled on host.

I've published full benchmark results + setup + code on GH [3].

* Final thoughts

Even though gated tracepoints are more CPU intensive, I think they offer a
better building platform for users. Every user/tenant manages their own metadata
stash and they can select an allocation strategy that best fits their use case.

There is extra CPU overhead, but the fact that we need to pay it only for
packets that we're tracing makes it palatable. As I mentioned earlier, we attach
metadata to less than 1% of skbs today. Naturally, we would be looking to lower
the gated-tracepoints cost.

There is also potential for giving users finer-grained control over metadata
lifetime in the future by adding tracepoints on skb scrub, GRO merge, or TCP
coalesce/collapse.

While we can make either solution work because we don't have tenants with access
to BPF in production, others might not have that luxury. Now would be a good
time for folks operating K8S environments to speak up.

Looking forward to feedback,
-jkbs

PS. I'm prepping for Plumbers this week so probably won't be able to circle back
to this until next week.

[1] https://lore.kernel.org/all/20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com/
[2] http://msgid.link/87fqyypp67.fsf@cloudflare.com/
[3] https://github.com/jsitnicki/skb-metadata-bench/blob/main/REPORT.md

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (15):
      bpf: Add gated tracepoints for skb life-cycle
      bpf: Add bpf_skb_fclone_orig() kfunc
      bpf: Accept trusted pointers to kern ctx type for kfunc ctx args
      bpf: Allow access to bpf_sock_ops_kern->skb
      selftests/bpf: Basic tests for metadata passing with gated skb tracepoints
      selftests/bpf: Test passing metadata across veth and GRE
      selftests/bpf: Test metadata passing to cgroup_skb and sk_filter hooks
      selftests/bpf: Test passing metadata to sock_ops and LSM hooks
      selftests/bpf: Test passing metadata to kfree_skb tracepoint
      selftests/bpf: Test passing metadata to TCP egress
      selftests/bpf: Test passing metadata to netfilter hook
      selftests/bpf: Test passing metadata to/from LWT hooks
      selftests/bpf: Test passing metadata to seg6local End.BPF hook
      selftests/bpf: Test passing metadata to sk_skb stream verdict hook
      selftests/bpf: Use non-trivial test payload in xdp_context tests

 include/linux/skbuff.h                             |   38 +
 include/trace/events/skb.h                         |   57 +
 kernel/bpf/verifier.c                              |   22 +
 net/Kconfig                                        |    9 +
 net/core/dev.c                                     |    1 +
 net/core/filter.c                                  |  112 ++
 net/core/gro.c                                     |    1 +
 net/core/skbuff.c                                  |   25 +
 tools/testing/selftests/bpf/config                 |    2 +
 .../selftests/bpf/prog_tests/socket_helpers.h      |    1 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 1399 +++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  395 +++++-
 12 files changed, 2049 insertions(+), 13 deletions(-)

