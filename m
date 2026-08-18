Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036873B6BF4
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787048263; cv=none; b=JGzes62gNyclhWTD04R9ewCiAo63QiI+6n81OUhT5eZRpxUibLPxMmM/WRqadZSx1Ldww5mxmLGX+qYOW7p+Y8tr3sCeYC5smq0knPaKloGO71W08d55TxkzYD+THGNirNIbY9oF8gldb33Lr7pU0ku9MKeflLOdPKvT//RltEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787048263; c=relaxed/simple;
	bh=PsZSjY3nKTv0UBfsn+/xUSAeSFImVT8zFG7CaYg5bck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vDKnKHyBY7M74aFizQcMRN5U/JohKZjSvVf3/2yTFipO9fU/4+TwqaQDeG0Lda3ZiS/+iM4rcEpPOPHfbAOqFygxlf2iArfY2ARmW1EKa06mnVd6zNde/P2XIIM/xqrxFenM+SmNAab/xWPHwvYiHG1tjt/naZ6+tqCvEr3A/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=F1CI5ESz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="F1CI5ESz"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e99ef0902so219738185a.2
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787048261; x=1787653061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uXLEFrJeiYa1zJxHzcs8UOhualbeMtxu7j0/N8xRs0M=;
        b=F1CI5ESz1B4SHn9HtYPS94NayJi5tsy3u9DMbeR4KrvRJxLUe6Jjtk4tVC3vR7GALW
         xKLzPmTWKRU+OLKGC+cO3E8j0HkzkRoKJIc2UFs3Tf4QMG8nsr5/fm1r10ncVH2SslPO
         Ok6k0KBaxrYR6lmwk0zCa82jdYopY7lNq03RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787048261; x=1787653061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXLEFrJeiYa1zJxHzcs8UOhualbeMtxu7j0/N8xRs0M=;
        b=k8k8OtugcbjXuNJKqGR8qA+kHetP7l0/JkpBHuNsRdjhUAkhLCRXk+IJxQx2AjG5aK
         s4F0/jSg9y9u5s4ECXBEn5DFbkcVQYOHU8J9FH8c2qn0Kv9ItaYAD27gg+LwII4Dmw9r
         1nqSfG0Uhpv5bOcl6MR2h5FhSGUMPnu239ZlQmoUuUYika8sItmhC9FNut7ETZdTCi4y
         meUhPHUs6FD6qiX32mPZRsYSzFidJAIeJLVyD6/5F3LNhNN6CdFnzCwDFStSszk29Hrp
         nD33sz6DKsT8NG6b4CKiPOScCPj+nYBFQmeyOqUplQdtokePJ/pJPhWVxigm1CXTA6hy
         KSrg==
X-Gm-Message-State: AOJu0Yzj2oDQgfYyWjJ2ZSiNIemKxg7txUTuePwiWsqfHQzbdh+nHmml
	4eWS9pUZZJxhHxfVPjLMLjBmJmWwL2oA3jsqVqAuh/mqKD/kxHiVucE0S6+CUDwa6Phiga+foXm
	4jEmaCA==
X-Gm-Gg: AR+sD11avQQuofAwLWh/ifNIeLiKMYXksR2NLSXya3KwN50YhPBxIULJXlmhO0hxdxx
	0UwbFyXvxdIwOMtqXxpHg7FF85LlkyQxO0FU4hmNCtkTfIpBdavJ9dovHfmcwdcMyExu1RrQ13F
	kRD9/9/KF/g1GsNgYWYKR1rGFSDheuU1C47XVICaIFWDs7+2VL9QRQYpMi5bH+DCrpt+6KVE0nE
	g7cVjVsqEVbMFsckzQ/MzAk2D9FRA1id4Tprnd+MBj5lXA2FUKWZsxyAbLA/85H04V+tm/Bmxom
	fJg2ArTc0ekaleh4eH1j8rqYWnwhEMyJowFykNfMJZfFPclTuJ7WQFXCP4eAWdw/TxjGNxHJ/ZE
	tc3v7MdAe5zJxy4npgcmDpRg7kYWdrgipEfj9KQpaalBL5P0bJz79WxqrgZ42/3/wdMszZy1Lq4
	0CvOxuTjLAEoKhmVNhucR3RfGImMEC3KLsT3moKWEKyLiXPdySB1mNtJH1mPoHkICZpo63l5PIe
	l5z7xlwkQD5dWhbMRICc+vAtSA6BukrUE9IkKl6TUIi2w==
X-Received: by 2002:a05:620a:2a13:b0:936:86d9:e1c5 with SMTP id af79cd13be357-93704b0d83cmr671382385a.18.1787048260861;
        Tue, 18 Aug 2026 03:17:40 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937010e7fc0sm299346985a.20.2026.08.18.03.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:17:40 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 1/2] net/sched: bound TCA_STAB overhead to prevent qdisc soft lockup
Date: Tue, 18 Aug 2026 06:17:34 -0400
Message-Id: <20260818101735.16655-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qdisc_get_stab() copies the TCA_STAB_BASE overhead from userspace
without bounding it. A huge overhead (e.g. 2147483000) combined with
a small DRR class quantum (1) makes qdisc_calculate_pkt_len() set a
~2 GiB accounting length, so drr_dequeue() spins ~2 billion times
adding quantum=1 to the deficit under the qdisc spinlock with BH
disabled, producing a soft lockup / RCU stall.

The same unbounded stab overhead also lets qdisc_pkt_len() overflow
the per-flow counters of other qdiscs (fq_codel, hhf, sfq), which
were recently clamped per-qdisc; bounding the overhead at the source
closes the root cause for all of them.

Reject overhead > 65535 (matching QFQ_MAX_LMAX and the max single
skb length) in qdisc_get_stab(); legitimate L1 overheads are a few
dozen bytes at most.

vega@nebusec.ai provided PoCs for both DRR and ETS demonstrating the
soft lockup.

Conditions to recreate the bug:
- require CONFIG_SOFTLOCKUP_DETECTOR=y
- Create a veth pair (or use lo) and attach a root qdisc with a
  TCA_STAB overhead near INT_MAX, e.g.:
    tc qdisc add dev veth0 root handle 1: \
        stab mtu 2048 tsize 0 overhead 2147483000 drr
  (or ... ets bands 1 strict 0 quanta 1 priomap 0 0 ... for ETS).
- Add a class with a tiny quantum of 1:
    tc class add dev veth0 parent 1: classid 1:1 drr quantum 1
- Send one small packet (e.g. `ping` or a single UDP datagram) on the
  device; the ~2 GiB accounting length makes the deficit loop spin
  billions of times under the qdisc lock, tripping the softlockup
  detector (panic with kernel.softlockup_panic=1).
- Reachable as root, or from an unprivileged user in a fresh user+net
  namespace (`unshare -Urn`) with namespace-local CAP_NET_ADMIN
  (Level 2).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/pkt_sched.h | 1 +
 net/sched/sch_api.c     | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 18a419cd9d94..a4c1b7b0263d 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -12,6 +12,7 @@

 #define DEFAULT_TX_QUEUE_LEN	1000
 #define STAB_SIZE_LOG_MAX	30
+#define STAB_OVERHEAD_MAX	65535

 struct qdisc_walker {
 	int	stop;
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 65b35528d125..cdcf861c85f5 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -544,6 +544,11 @@ static struct qdisc_size_table *qdisc_get_stab(struct nlattr *opt,
 		return ERR_PTR(-EINVAL);
 	}

+	if (abs(s->overhead) > STAB_OVERHEAD_MAX) {
+		NL_SET_ERR_MSG(extack, "Invalid size table overhead");
+		return ERR_PTR(-EINVAL);
+	}
+
 	stab = kmalloc_flex(*stab, data, tsize);
 	if (!stab)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0

