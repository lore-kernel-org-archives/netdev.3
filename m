Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240AF38E8B8
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991176; cv=none; b=VBPKnclneIB9/ifNKOODUbAjFHvJAVlZBcv8zCEpN86awD6NT5evT5A6e48YQzM7k4ItMgskh1tCMoU0h2c1cUFZoX9vBllTmH+20So+O7QyPJgIzNeyRYN37Qby1JjiXHBoyIz7Wy1cYOoqrqjwVnCie2ENqGOHRHDjwsU/RXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991176; c=relaxed/simple;
	bh=NNiqIoW95J4VoaZIqNbNYxj62ObUv6XngGlQw+ysAyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJv6ao48dPUyTrsU2MilKWT6XzViiZ4OD4Tc3BxN2YXvgr5AVeLstCijOOnfD6O8HKZiCfm7Y3b7bxz/gpXPqrVmjsWTBbUYh3SDAFMowhvjOKhRTnqE8MqB5XaxNxAldB9zfb5spr7w4u19eLdqTIeFBjQGUzO6hLLsjL+T/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=tzQtrxMH; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="tzQtrxMH"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-9087fb771d3so13559096d6.0
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 01:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991174; x=1788595974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vH+5YsNTB/xDLOggySY7l0UJb0258tXEDEvScD3qwdE=;
        b=tzQtrxMHiVJGvh+9cUvqM+l7biNH1Vj29SaNNCFQz7nuWskfc7Ex4nkNp9Rc4H0GSh
         INAYH3PX5fiIYiRR1PrjL/XD6BAnEUjqr5Zla82b7HqAbNiW3ZE8i1ytTGW+4G0vO2ns
         wyxGrp2+v+nqmkz6wGqqBC+OxkaWb9g3rc630=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991174; x=1788595974;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vH+5YsNTB/xDLOggySY7l0UJb0258tXEDEvScD3qwdE=;
        b=dkpMkOlSlUKDllJ0w1xHRqnSF5ZTGfVCZKoK+ZMuvDFXMSD750I0xjpuB8gfREOUyd
         4d3a2+CtaULRoH63/PMinYIRBfFmOa1KrQgTqpSkmwZ6Jbt2C2sKrOjiFbgHU2r+sP0c
         gf0gOts4jvfDi23UdvYe/U3v4aD3XurQn09HyPKRivhDPZk5pblbzf0L/m5H8RKOMXTS
         n9hmaDEYmlsT91+pOUJeDPBEEqvPRaUZYOSqbcPdzaIcw6sUqag/qSwDwUbi9Cu/nfkr
         KZqK1wRxCr87Z+jiSOGk7Okarr6PLAgC9uSbpBC7jLQA3b5lznPJ65wVA7m2xiOQ5MBh
         v4+A==
X-Gm-Message-State: AFuF++mek15KNg/6FVGvcZ8mT4ACHpHAqKoJK6qEWDpRmalTXMsLcKKH
	Re7RkPz6cBdZAHCR9fj4L18ADkexVL0dt9Ph+nFLwWKwadbDua9IG3pRU/KDaqu/xgUlROs1JHi
	3qzLLrA==
X-Gm-Gg: AR+sD11zPRBvp7jXlKNllTklqodC2ZcdXv7p27PYqT/ABA5jVFbwVrcOIOnHioTlTA9
	xBcuTNJWKP05uqSCMYF9Cq4C4szueCfv7BnKY80I9F29870GUVn9VL/bxVe1a3outUn7rOHkqsv
	C9huh0H2xUbYvJu0BDWMKAhx3AF+VUA+mfgkbNpzR9Dz987RF+ybXPPaUQKUGtqWcMG7BGqfeih
	KM7Qs5nI3sQKzPHUCGTi2YrZJvnAWK8kIppikfXpt8p8T/UW181pBb/7A7R9AlmBJR2XwgBqet3
	9WWOdgiIpouvjquVXyFrJuXF0Y1pR1bCbdZIHhVUbZxy4RxduXiZ5/JFbbwwLwue7u0WnrO+rSd
	n9hlluVmL6XVuGtND6e1s8kmyUm9jHR3dFyrWnGlH+RBkaj25H5Zbb41YxBV4ih5LGy6N4YINWd
	QeJ2Vwj3lT++wJjGJZAKDwvlLvi4pM3rcsxP365z4FoS8HaQ41oBdAao8Xk29BaMKoUijb8Ri1V
	HvWYnQI14ea9qS/A9TUXWgaZs5/o/kvSPeCIqBbc4uMj8b4qn67+K8RbFf93R+X85l9QZ4QpBXa
	hU2KRlTj8IU0NeqE4NHGRZHtMlo=
X-Received: by 2002:a05:620a:7001:b0:92b:5408:b6be with SMTP id af79cd13be357-93913862520mr1228692585a.23.1787991173931;
        Sat, 29 Aug 2026 01:12:53 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:53 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	vega@nebusec.ai,
	stable@vger.kernel.org,
	toke@redhat.com,
	chia-yu.chang@nokia-bell-labs.com,
	subramanian.vijay@gmail.com,
	petrm@nvidia.com
Subject: [PATCH net v2 6/8] net/sched: pie: clamp psched_mtu in pie_drop_early
Date: Sat, 29 Aug 2026 04:12:27 -0400
Message-Id: <20260829081229.81708-7-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260829081229.81708-1-jhs@mojatatu.com>
References: <all>
 <20260829081229.81708-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pie_drop_early() calls psched_mtu() with no clamp. With mtu=0x80000000
the bytemode divide silently zeroes the drop probability, disabling AQM.
Clamp to [1, 1<<20].

Conditions to recreate the bug:
  CONFIG_NET_SCH_PIE=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root pie
  tc qdisc change dev dummy0 root pie stab data 32768 size_log 15 cell_log 0

Fixes: d4b36210c2e6 ("net: pkt_sched: PIE AQM scheme")
Reported-by: vega@nebusec.ai
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
---
 net/sched/sch_pie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index b41f2def2e2c..3b7863ffd284 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -35,7 +35,7 @@ bool pie_drop_early(struct Qdisc *sch, struct pie_params *params,
 {
 	u64 rnd;
 	u64 local_prob = vars->prob;
-	u32 mtu = psched_mtu(qdisc_dev(sch));
+	u32 mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
 
 	/* If there is still burst allowance left skip random early drop */
 	if (vars->burst_time > 0)
-- 
2.43.0

