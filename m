Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321035;
	b=O+IfvwWnT8gw/Rp1EF2As2TJntG6R5yBtYxu4EJDeyVb/Rlwa2FaHaL83D84MB0G81tW
	 BL9LvnRZxQ6iGSUA/iO72YDzXeAckyTSjXYpRAuZ0l14X2f3chtDyDcUW5uizODGHLzA+
	 XPaeeZccrLSdqUYfIXV26HZzd6rh9x9F8TSWSSIa/3UUFKWs5PVT9SQHL4AiaX9JdEw0H
	 2MGA9JGNA+RN2HdIY45KMNLLsFw8hBNGDuc5L+wWrTwBSg/ik/9V0GSnnNV9Ue+v5wXF6
	 NZVxHv+EVp6CoZAel0krb9qYS9QNqUe1+lRfPgULLaK9bGfWBfeQaOCIqS1lIvubl/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6/CXb4XAs6m7Y388P2LyinUrq14d6Ww5jL1xjGTpGAA=;
	b=IVPYqf6a2eBlU/8x24jKI7tqo2WXzXnJ75Vw45LhzxdMBYVeb5I7Hi7RGFz09Hbyk/pF
	 /1Vdm2z4tMao9d07+llAPHjBrKrNnwfzb3F6uzmU8m4nVBqpGShamTiEJPljUbgcctWpd
	 Kcjt+G40B8WttQsr1SAp0EtwIU3MMt3HSpq71ZW93TB/xzyaRXO0qE5cFyBIkzx9Oe9FT
	 V3JO9uNLkKa7WbqlRv3vK8dEwJ4+73JmddO9DA3Co1ZbPaLdpUkv94JBf9gAxp6B2jpUD
	 7RMrBCyc/KrfLL9qRsKlZ/KDKyEcatARkw05H56NPHjtwue7HMfuD6UOr5iMQcWbQwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=JhzTb3yk;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDFE606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EDFE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=JhzTb3yk
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b315dd057bso15325447b3.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794321033; x=1794925833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6/CXb4XAs6m7Y388P2LyinUrq14d6Ww5jL1xjGTpGAA=;
        b=JhzTb3ykbX11lJSAIZbVscW5EaGa/+mr7Y7zxwC7ObWFtP/W1xxUi7zSpH9YZtyJiE
         LrhPv1r4xwBer2rGx5z0wRcVQBw1mk3HJdUMN0eJOleaj/lU2qM+dhBnOekKKZuPudx7
         0w72nEnKT3jf84Z0LtzKPC0VcjLzjEiNrN9JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794321033; x=1794925833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6/CXb4XAs6m7Y388P2LyinUrq14d6Ww5jL1xjGTpGAA=;
        b=gf5g+D7n1bU7KnItRlGD9oDMSaD8PvzyIlj82WfaREcccKEbfUARIKerTxoGufPzYa
         +YpvxZRSP8ars9dEdlUNvtnQdKymPI8SWLq0YuKb+N8BKf+KNpsu2VDCaMnEtvioZUs/
         zWWlR3SgbTeIwbRClYQnmpNaNAfrdThSnQZ+WFxL3BRnvLDGE16uQJ9mMSoawVgNgCqO
         6MukRH8fmSXBA/dZ2FRUsq9OlqAHnu7NjNvD6f+ZE6QKiLLfwOWqKY4kzzfGAzgzUOKr
         zraCmtqXOWdLB3cwxtYi9AKnQlVuqL4uCC9+YBBtRrJP5Ru7QbTWQGCHMUTtPamMw456
         2wrQ==
X-Gm-Message-State: APuU4Z+wYjzxLDRkF2VtRNJDLDP3mOizMTcPOMmw0nZDHDv5z5UjeIW6
	FsTRSJlbtYcocJuril0tzOPd+Fj7ErerdoOLrnvBQ/MYQWGnRZx2kc/FlRIwrSuxArbQEdGi+Rw
	ukZk=
X-Gm-Gg: AYBFou39oj3f2YMJ6RU4MZi5hiQVETpAdN+a51cu8HroMhPzdkxSAhwvFEwwW5QBDE4
	ow7j7iRfOiKZ8HhT8REU8oMaYuLLa64BZ4yBG+E135Z9V60w662yrHTgH/OnwXkhfTd1PJXZs02
	BZzPVS/YqMjHPTTpgfjIGBzYYhSuu91e1Ee5J2yNuHJKJ9AGvXqMsGVUgkx963csaK4bYw6LH4e
	JPMErkHN0dDCkhwjmgXmEju48YFZFs+u75byAOrcKsy05zPkNMnFOtwyP6ooQRyi48xu+1cGPaF
	5khQuP04/SQj+usiXVxWoxmTmxoEzDq7hFQ8lzKQu6uOra3Ubimq34FDJgnRXwIGB80fO5w6cWq
	puDQ1IGZZQ1Uy8YhUrZUL6zb2nDJ80ksWsDOwwH59/pHOWUs0WURVw3+p1diTBmoQf3BuLSMGmp
	WVbgNEf4k0WED9hhC/ixM3af7h50J9bHHpw2aezTL32fQTwQD338fz8I3B4HI1iCBuLrMgfE8+x
	RuCF3Y5ITFNFqhr9XWqtARUXLMU1/sbJspkHmB7LFspz0j8R6QV5H7UAs0lZeh+Qko4t5ICsV6o
	QfJYj/Z66EAQ
X-Received: by 2002:a05:690c:113:b0:8b3:34b6:4bb6 with SMTP id 00721157ae682-8b39290d62amr19146297b3.5.1794321033236;
        Tue, 10 Nov 2026 06:30:33 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4d67::1c9d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393479120sm20091647b3.45.2026.11.10.06.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:30:32 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 0/3] net/sched: bound the deficit-refill dequeue loops
Date: Tue, 10 Nov 2026 11:30:22 -0300
Message-ID: <QDISC-TIAE.v3.r0.20261109173518@mojatatu.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRR, ETS, sfq, fq, fq_codel and fq_pie refill the head entity one
quantum at a time until it can send. With a size table that inflates
packets to 1 MiB and a quantum of 256, one dequeue can loop thousands of
times under the qdisc lock. This series skips the rounds in which
nothing can send, so a stalled round costs O(N).

1/3 fixes drr, ets and sfq.
2/3 fixes fq, fq_codel and fq_pie. There a flow can still fail to send
after the skip (throttled, or dropped by the AQM), so a setup built to
change state on every refill is still slow.
3/3 adds DRR and ETS tests for the refill result and service order.

v2 -> v3:
- drr, ets: a class quantum change takes the tree lock, so the round
  count and the refill use one snapshot.
- drr, ets, fq, fq_codel, fq_pie: the skip is repeated after a bulk
  refill, so a child that exposes a longer head or changes state leaves
  the fast path after one more pass instead of falling back to the
  one-quantum loop for the rest of the dequeue.
- 3/3 is unchanged.

About the request to fold the loops together: the three dequeue loops
read different data structures with different eligibility rules (DRR/ETS
classes, fq bands and flows, fq_codel/fq_pie flow lists), so a shared
helper would add an indirect call to the dequeue path without removing
any of that logic. The common shape is described in the commit logs
instead. cake_dequeue() has the same one-quantum refill, but its
dithered quantum makes the right fix a different one; it is not part of
this series.

v2: https://lore.kernel.org/netdev/QDISC-TIAE.v2.r0.20261015163454@mojatatu.com/
v1: https://lore.kernel.org/netdev/QDISC-TIAE.v1.20261008110502@mojatatu.com/

Victor Nogueira (3):
  net/sched: drr, ets, sfq: skip empty rounds in the deficit-refill
    dequeue loop
  net/sched: fq, fq_codel, fq_pie: skip empty rounds in the
    deficit-refill dequeue loop
  selftests: tc-testing: pin DRR and ETS deficit refill semantics

 net/sched/sch_drr.c                           | 57 +++++++++++-
 net/sched/sch_ets.c                           | 53 ++++++++++-
 net/sched/sch_fq.c                            | 87 ++++++++++++++++++-
 net/sched/sch_fq_codel.c                      | 80 ++++++++++++++++-
 net/sched/sch_fq_pie.c                        | 74 +++++++++++++++-
 net/sched/sch_sfq.c                           | 41 ++++++++-
 .../tc-testing/tc-tests/qdiscs/drr.json       | 82 +++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/ets.json       | 54 ++++++++++++
 8 files changed, 519 insertions(+), 9 deletions(-)

-- 
2.43.0

