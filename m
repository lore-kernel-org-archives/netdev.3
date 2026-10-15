Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD72518136
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060380; cv=none; b=dA+JAIrayQK3D7gYhQyNIX0Dn+q9zH34rbdfamhpGnx6wFsk289DpTVJMyqZKElFAr1VC84zqlKbANOUD0MxAXfieca3QCxgAUSdmxZuP8aor431LPzvTBAXTh5vFAie0X0Oj6inKun4rWzcY7v33tIaOIlgKXByUk8oaPExfsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060380; c=relaxed/simple;
	bh=UB/Ep/Y03qwRUvcPr1dSXyXBAS78olg0lyaVWKpQXV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9J4KgThoo8fN/3XP5uaVnglKlCMv/UB8jLFzgcmcbrTt2u3BIfJF68ZBdxMWRtIU286L+KQ8Q/A45EtpeiJFYJdnTsK+XLDW7yG0PKZCPl0qdTjqnsQhmdLRAzsgFIOBZibwSen3nyRblxg3Xqp0mTZbBzxr98FL8S76XWllv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=jjMeNhu9; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="jjMeNhu9"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917a6dccc60so58454596d6.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 03:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792060378; x=1792665178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y9jp0yKWerzGGX31FqxEYfZ6VZBQv+aNm4Z29B71O1o=;
        b=jjMeNhu9HiboLMwciqr49V2k0zQs39w1NnfeYe3odMlis6LE1GJZlGjiHm9PJJwhrk
         ArlujUMutTv0HHI5uaLHtAeU5lKzdKvyI7TKY5T2x0qSHySaRcG229E0sqsyQdgFqihB
         EuPvRFzxeYzZufDGjybGXWI/AHmNP6dK1rYdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792060378; x=1792665178;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y9jp0yKWerzGGX31FqxEYfZ6VZBQv+aNm4Z29B71O1o=;
        b=F26ul7p3yVuHaBfV/hqCVotdlWL2Bq74PQ2Gq7kQqKTzbkCZ1gMJqJsFxhbvOvYbHW
         Bg50hBSqM3fdBuW04pbp6z5qU2/bLkYbWGR2NFAIpb6TLPUiT/O9CzlR4uGfoNoE3GNW
         YlL2ycPg0leXKL5ff72xTNdV1K74nXmB36GCZCohc5ferF4ksl6VKLplRqkD6WPEnvY8
         H5DTEnwXcH2ypDy6eat5MzRS64krZGzbpiN2kYTxCDGT9dBw9d5KPuNRwMiKoOXBYhiC
         N6fVM1EwvYqTcke+KRKZAI3ZOnwb8/AVbb5FTVJfac/yn9PGM2YscevHR04V9YtC+DC4
         rWbQ==
X-Gm-Message-State: AFq9FYI/ie8AnvWPEhEIJBhnBonl4+4aubeNyhxs939ifrzaqVJUHC76
	pOtS+JRS2oFefhVX4kgM4ecJouqDrVgetrRuavkdD/1iIc00+2s6uuMhdF5lWIJ0mGoKZHFr/cB
	hC+c=
X-Gm-Gg: AYBFou0TSfxSI7qdpa1Cb8lC8XNIBLMEk60rA9gd2NOVE5O73WbPfA293AwewM+ruKz
	igfKRjHBO3QnzH9wSWQHXnSUOa21aY9vl0vOPsi4QYR2yWJFrev0yHS6kF8+SOxAL8dy0U4/+Mk
	q2ZVaJP7IR/hDZSZ9B4TaqvlkV7vA2fK+WN3vFXrdyYEq7yDCtU708ir/GHTX9v3I5lgoeoGdgc
	9ngB8rTjB3yG78tnVZ+YPW25sQ+5m3wnE4lMJ0a5xHZTaPV33XSy/FqAeGfj0zhagW3T22blvWe
	xZnYayztQ23fVHLfn6VVLazPtLTbpzhk++QiRia1EjYrl+Fmnx6eq+bCPClcTcJnUKrlucvIXiQ
	n/qqadMIWEzb3bXVJl/GkysuNmDZyQtjbRoC8jtRDEXrduZz9KyYYyaAgCLgSIG+/o1Ya/9C8UO
	TevqvtSbpYylH4EA0lEzrta2AXPbe9zY8rEF30G+l7hcCxRZ4U0Pf1/TNH56F3v5TCkDiAy0AW6
	VVxBs0rw+yzZ/H8DvGTuECcxXagPwUnZZEF4brNPOzL
X-Received: by 2002:a05:6214:5004:b0:914:48c8:6961 with SMTP id 6a1803df08f44-91b5d57c1b5mr306941696d6.17.1792060378263;
        Thu, 15 Oct 2026 03:32:58 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ba684f404sm55261936d6.31.2026.10.15.03.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:32:57 -0700 (PDT)
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
	Victor Nogueira <victor@mojatatu.com>,
	cake@lists.bufferbloat.net
Subject: [PATCH net-next v2 4/4] net/sched/sch_cake: drop dead nla_nest_end() error check
Date: Thu, 15 Oct 2026 06:32:45 -0400
Message-Id: <QDISC-5RTM.v2.r0.20261015051735-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-5RTM.v2.r0.20261015051735@mojatatu.com>
References: <QDISC-5RTM.v2.r0.20261015051735@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cake_dump_class_stats() closes the TCA_STATS_APP nest with

	if (nla_nest_end(d->skb, stats) < 0)
		return -1;

nla_nest_end() never returns a negative value: it has a single
`return skb->len;` and no error path (that is why the overflow-aware
nla_nest_end_safe() helper was later added). The '< 0' test can never
be true, so the 'return -1' is unreachable dead code.

Drop the check and close the nest with the bare statement, matching the
sibling cake nests in the same file.

This issue was discovered while fixing a bug on the gate action, see:
https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatatu.com/

Conditions to recreate the bug:
- not runtime observable: the issue is found by inspection.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Link: https://lore.kernel.org/netdev/87v77csd5q.fsf@toke.dk/
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2:
 - No changes to this patch. Re-sent as part of the
   series_cake_clear_tin_backlog_underflow v2; it keeps Toke's v1
   Acked-by, carried forward.
 - Subject version tag bumped to v2; Message-Id re-baked.

 net/sched/sch_cake.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 4caf9718c9bd..124f552023f8 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -3211,8 +3211,7 @@ static int cake_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 						       READ_ONCE(flow->cvars.drop_next))));
 		}
 
-		if (nla_nest_end(d->skb, stats) < 0)
-			return -1;
+		nla_nest_end(d->skb, stats);
 	}
 
 	return 0;
-- 
2.43.0

