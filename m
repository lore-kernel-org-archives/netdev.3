Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ACC3921F0
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991178; cv=none; b=ViiYUkaRY5oZjae53rj1Q0ipO9VD3+OvtoEIjBXEDDy96PUfEm5kS4NaVgYs8irW4O3QLqQFXr3N3ltFs6tWBzcpPKFMe2PInA9vM/nt6zqX4K1hM+vTl6hl+Rl28Baz7ZUNjwUoxgX7L+BZg+7i3cCo8Eb83qL2OBh8zNXhQrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991178; c=relaxed/simple;
	bh=xJJq+qu59CIgAFBX70OoZF0QMFnunCrjGpr/OQ2qaXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AW5IqaOa41bC3OGA0Jx854ReXJBEEjV8+iCUJ7PbRCWufEDRomjkgZKC7UVYD7VnkS06Xcfp3rVDLJBdiMEMzwDZir3yVrEAULrMcfZTXWqy1KvtI81eKH7DyorI0Ar1y+eBxEFJh3L2UTUCCvVwdz8vcge7a+Oso6A/5HVTjvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=baSNxptB; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="baSNxptB"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e85499ffbso137493785a.0
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 01:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991175; x=1788595975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ewXN4Cy/MCA25PIkx/8RR/jYTJiHRqM+WzCcLA5hBW4=;
        b=baSNxptB5iJVR6ROiaOWy2OqrwodyJ3wVZJmsE1Jeg/bydKwjXM0eAuMJt98TMcX60
         Q57ehHG8jEK4zPXPtTTWoCSYhQcgEfUCSJfXNbEY02tTaRfPyEn+j3gkdFRoxmF76NjO
         8pKNQVApOXeZwO4s/zqmYEy/gMgro9Hmwrx8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991175; x=1788595975;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ewXN4Cy/MCA25PIkx/8RR/jYTJiHRqM+WzCcLA5hBW4=;
        b=en/U7O00nIdetj5TMzGGxecH5rAtRcuQeM9B3Ysa13WkSga+iPA5AEeQ2F+cUbuJH7
         z6AMvOT0YXRpqQjdOGsnvCCSY8r9qxD1nzt2txEupaTghD2e9UMHv2Wcq6+d6I6c63gP
         tmtYHl+NdDyavUXnVUSQZUVG/lioqP79n2ms9X1ydXUKeg8ms1xzCFuj0uZdy3XnBKiq
         AcgvnOU0mtHWfkp5ZTff/40DZegPwGHI9qVUA+PQtPEnku82kaRcRMeRrmdzC0MA2QFt
         734ixzSu26lpJQBCTPki5XPGugTd07+NNMu9F2JdH6jTjjEGq1Yr1y3OWyarYa/czViC
         CHnQ==
X-Gm-Message-State: AFuF++mnTjCs675zYjEAFGcMz4L0+Oe9jvfWjrsukDSrb4O292CYQYdi
	eXr30p/xu3qgJPPuccGl+VW0AJkFSns8Fy01Ei6vlQPvH+/8dtgXTpbm6NnGcRUXkjDhiw1NSEm
	1x9IP5w==
X-Gm-Gg: AR+sD13K9FURCKje9Lae4Nolsxn4LFwGlGmRiHDJIvPNWTyj1KISicpjlqlCyWZHK9x
	QF0//O7bZzuQVQUouWOGg74f8ltU9JYqVoUDex1u3EIOYXyw6gy4aCuVJ5tywAN3xrCuY/Uy4kP
	FhePl56ksT6J/cI/ywn5/EbD8rZ2lP7YAYrWZkCvIa+IAZBQz77FWYEIfKxsNyriAlS7o56nFId
	3WhbJsYTHVF2I1NsvahHEUMHq2ijR5laabLNMTnPqqKqN1kq0lhFE+5x14Z2KgK5KMtAAit39Hm
	8Gla5tFXDcF/fXZemXrte3vN2pcqyU8vS5juLgshqvpV3nL3sHnemTiKDV/97kpfQTqEq6F91fT
	FF0aJt1prg+uoHDf5Dva+79w4WUe+WuKgwq804x7Nbk3jkJq2qKTL6uzlIf4pRNrAM6xq4Yjc6W
	bzmE4U7+fVBNNT+LztqFt+z+Xruv0Lkaopo8eLwoaNwnz56RVCfQt7w347PLXK+AtLHtSS959n1
	RiQGrg3Da0Pvo4zp1PaGjGeofG+N5XytSNAcZUvNe4aMLq8CW3U3YKnnIAIivbT8I/BRcMkFkGF
	OQmBsfbM3CXV5Y74dZ1PHfQeVk4v38pn1nQIoA==
X-Received: by 2002:a05:620a:4553:b0:934:970a:beb2 with SMTP id af79cd13be357-93913904111mr1384267085a.26.1787991175573;
        Sat, 29 Aug 2026 01:12:55 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:54 -0700 (PDT)
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
Subject: [PATCH net v2 7/8] net/sched: drr: clamp quantum in change class
Date: Sat, 29 Aug 2026 04:12:28 -0400
Message-Id: <20260829081229.81708-8-jhs@mojatatu.com>
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

drr_change_class() rejects explicit quantum==0 but falls back to
psched_mtu() with no floor. With a crafted size table qdisc_pkt_len
reaches ~2 GiB, so quantum=1 (or a zero psched_mtu on a headerless
device) makes the deficit-refill loop spin under the qdisc lock.

Add clamp_t(u32, quantum, 256, 1<<20) after the zero reject and on the
fallback path. The explicit-zero reject is preserved.

Conditions to recreate the bug:
  CONFIG_NET_SCH_DRR=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root drr
  tc class add dev dummy0 parent 1: classid 1:1 drr quantum 1

Fixes: 13d2a1d2b032 ("pkt_sched: add DRR scheduler")
Reported-by: vega@nebusec.ai
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
---
 net/sched/sch_drr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 91b1ef824afa..8621d057edd9 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -82,8 +82,9 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 			NL_SET_ERR_MSG(extack, "Specified DRR quantum cannot be zero");
 			return -EINVAL;
 		}
+		quantum = clamp_t(u32, quantum, 256, 1 << 20);
 	} else
-		quantum = psched_mtu(qdisc_dev(sch));
+		quantum = clamp_t(u32, (u32)psched_mtu(qdisc_dev(sch)), 256, 1 << 20);
 
 	if (cl != NULL) {
 		if (tca[TCA_RATE]) {
-- 
2.43.0

