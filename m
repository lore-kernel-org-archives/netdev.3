Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494014;
	b=05+jG2AMcU0QYHIBpaEuQVFThC/tD/e4V8miHGXVWQbeY9yn0ArZhsX1IeZZpWhrrOru
	 IdCfK8cu7iqvHvPMAGjHeP0trb5TUjmZKGUP7yyWA5X+64apF5itxkSZpi1hljwwaQO+5
	 AKjeW9I8GYhwBKUgqKI+gEbuRXL/r7BIHtnfcMQHv6cSVMEg99ZDe1T9BEh3GWqyIGSkC
	 y8HTgF1LgjqZz4ugAIUmk7yOvzZp/gEzN685gDmSXLN+LVAtutpk2/qUZZ2/wD5rVfMPr
	 JJFs2Q74eNxCYhtIJxyfec8E0bGxQnP/tOaJoXp+lAK6HIs0pbajRlckwDQgTNRTFpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KOzquRVJX7CuCnTjfd7MDQSX824d3kGTwCuJPFcsHFw=;
	b=XZCRABKizvEYj3DRupbIUG4kbt2ecenhRpdjTbTlxmJJSLNqyNVpxrmWH0mU3WFUO54N
	 bwZXMvtzh/aIyOuVYuH+P2pl0RIVUEsr9/X1DHC3cR2RfpRipw56VPQBLi9U7Q8zrBQsT
	 15RyvIt5NZSva9qkQQ5ibqBhBrM6NNwecI5FSCwXmsjii83AuwFmU8JEzBQMBye4Th20l
	 c9dNE2/FScP94RAKpYGLZ05iFrlsJzWlTMtex0kmNtC/Y61pOuORlY89naVXQcYBb+JeS
	 HuI47rDfJROG4SU238D7xGKUFpTCmx+gZ+AnhCNtZaic8qhXinwCNg9xpi5O7BcojQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=W3iOg25e;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF082606A327
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF082606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=W3iOg25e
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f22a8515eso286698985a.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792494013; x=1793098813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KOzquRVJX7CuCnTjfd7MDQSX824d3kGTwCuJPFcsHFw=;
        b=W3iOg25eukv4Ju9RqklfduXdwfUiupJuI0rYieV9xhm3gmDOW5qfuVrfBj2Phle1UY
         N5gWTxC+NUJ7kamJj8b7b3ps0JdbYkmOxo1jq0pVpYqKw3MWMnDDfGFzyU959ycqPab1
         7FzXVIlM8TGLyjNvsBjC3B4nySEJRodGnYUi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792494013; x=1793098813;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KOzquRVJX7CuCnTjfd7MDQSX824d3kGTwCuJPFcsHFw=;
        b=K83ziz/wQS9zXUJW2LxubFtbeHHcHyhgQxVANHb7KQ1zG72+75yTwrhsiSXbRh24/y
         gT/DpSuAO4VIcAK6lTsu3yySpMphmonC/y2o4foxuqxnFwuNYhEEv8d7PseaxqYOzgkp
         3dXqovLy7IZlO2SJi6K6nl/C5b8+Lz8sb3l7wN9Wenxx4sjStQ2+JkWLvi8zxwmqSWiG
         +p8Zz59OnVTbJwvt8U4CdYR2o+q4oHMjPRoCAsn37K/ib5rqHFlOyxnXxeZ+oCZtsIzs
         lRx5IFPZIaGFkd6IplZp5uutPgGFbklj+0jP1elEnb3UHrFDosvjuNXmpIFp0B7gr/tC
         B0uw==
X-Gm-Message-State: AFq9FYIhAwtEgt4/AZs3Rw+LvugmktxrWRpG0jE1O6BsbM2IxilTWf0J
	9K6FFDcZgIkkeSrjxG5BA1NGLFBQwnMqGLKOQ8AbfpqXjKa7SJseJH9g57Z3P0i7f8jqMsXoXq3
	Ae+g=
X-Gm-Gg: AYBFou3oUJsxNOQE+EmUGj3pUStDkF11EHMxbs73GlALVe0DXm9zApACMG3z85NmuyI
	z1RJbXyYlO/Z0g1kN4iAPtPMOeq/iw+fXWdDril3+gW96Cg5XbA6uk+j3rHe94zwjKku4VzinHb
	icQSO54Gd4e1R87+DHm0iMBZOM8zcBpEjz+7gUNCZHKx3yNbRPi53Ws23x5MDx+PHWyiyLJz+fV
	aofK9Fqtz00+htDdX8yViG9nFuE77kS/NYFsqUrgX6k2SQ0ElWeGLFgGCGxnD46zrR640yxeaRs
	gNzhh9zezT9Qa3J/oNKigFSPL8EK8opT2QKHfVHW9sHwe8jOa1UVJ3CjCz1GoKP6SP9BFf5TIFk
	+oDgq+iSIm16P0v4R9oKdjfXlcVG71+gTME6f+SAK3NZQN+/thK3zfmFpiWcw0YQ9qCZmIDPYnc
	+dBqhvP4J8kZ9/O7eCm9gWlz+fpqjXqDws9Nl7WzIvhgtUEcxAQXdBxyYHW1x9STOCfyheWf6r/
	jBBD3MjHXshb7nQFurr1VY1pYZ8jrOl/vq4W5apUJ/0
X-Received: by 2002:a05:620a:270b:b0:93e:623d:99ec with SMTP id af79cd13be357-93f29c94085mr1741356885a.13.1792494012590;
        Tue, 20 Oct 2026 04:00:12 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c040e6667sm23382356d6.39.2026.10.20.04.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:00:12 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v3 0/4] net/sched: sch_cake: fixes for accounting and reconfiguration
Date: Tue, 20 Oct 2026 07:00:04 -0400
Message-Id: <QDISC-5RTM.v3.r0.20261020053711@mojatatu.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Four independent fixes in the CAKE qdisc.  Three are follow-ups to the
autorate reconfiguration work around commit 7cbfb180945c ("net/sched:
sch_cake: fix autorate reconfiguration throttling") and the 32-bit
admission-counter wraps fixed in gred/bfifo/plug by commit 4c660ee8c809
("net: sched: fix 32-bit backlog wrap in gred, bfifo and plug enqueue");
the fourth is a dead-code cleanup found while auditing the dump path.

Patch 1 serializes a 'tc qdisc change' with the datapath's autorate
update under the qdisc lock, so the netlink writer and the autorate
writer can no longer lose the configured rate.  rate_bps needs no atomic
(it is only loaded and stored), so it stays a plain u64 with
READ_ONCE()/WRITE_ONCE() annotations.

Patch 2 propagates the backlog reduction of the reconfigure-time tin
purge to classful parents, so a CAKE leaf under HTB no longer leaves the
purged packets in the parent's qlen/backlog forever.

Patch 3 widens buffer_used and buffer_max_used to u64.  The u32
accumulator wraps once the resident truesize passes 2^32, bypassing the
over-limit drop loop while the configured limit is a u32 attribute; the
u32 MEMORY_USED export is clamped so widening the counter does not
truncate the reported value.

Patch 4 drops an unreachable 'nla_nest_end() < 0' error check: the
helper never returns a negative value.

All four are hardening for net-next (no Fixes:, no Cc: stable): the
counter wrap, the missing parent-backlog propagation and the
reconfiguration race all predate any contract we could anchor a
regression on.  Patches 1-2 were reported by Sashiko (gemini) and patch
3 comes from the gred 32-bit-wrap family; patch 4 is a static cleanup.

v2 -> v3:
 - Patch 1/4: reuse the rate snapshot in cake_dequeue() and
   cake_reconfigure() instead of a second READ_ONCE() per use, order the
   declarations longest-first (Björn Töpel), and scope the annotation
   claim: READ_ONCE()/WRITE_ONCE() do not make a 64-bit access
   single-copy atomic on 32-bit, so the lockless cake_config_dump() and
   cake_mq readers remain best-effort (Sashiko nipa).
 - Patch 2/4: no change; carries Toke's v1 Acked-by.
 - Patch 3/4: publish buffer_max_used as u64_stats_t under the qdisc lock
   and snapshot it with u64_stats_fetch_begin()/retry(), so the lockless
   stat read is coherent on 32-bit (Sashiko gemini + nipa).
 - Patch 4/4: no change; carries its Reviewed-by and Acked-by tags.

v1 -> v2:
 - Patch 1/4: drop atomic64_t; rate_bps stays a plain u64 with
   READ_ONCE()/WRITE_ONCE() annotations (per Toke's review: the accesses
   are plain loads/stores, so no atomic is needed).
 - Patch 2/4: no change; carries Toke's v1 Acked-by.
 - Patch 3/4: clamp the MEMORY_USED export to U32_MAX, so widening the
   counter does not truncate the u32 stat (Sashiko nipa Medium).
 - Patch 4/4: no change; carries Toke's v1 Acked-by.

Jamal Hadi Salim (4):
  net/sched: sch_cake: serialize reconfiguration with the datapath
  net/sched: sch_cake: reduce parent backlog when clearing a tin
  net/sched: sch_cake: widen buffer_used to u64
  net/sched: sch_cake: drop dead nla_nest_end() error check

 net/sched/sch_cake.c | 69 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 19 deletions(-)

-- 
2.43.0

