Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3985368D4A
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428540; cv=none; b=Jsj8pC1CPubxMBwUhkjzzfiT00wQV2fl260EJk53LlinHQaGDexKnLWWM9d5lr5iwPZ0jteu4H+uOS4C8B+mNX3tjuAO2ZYC/obTWNP5ozTm4qBi32z424pnB6P3NlC7FioLfDYwbewTc90ghm5O3Wn5nrzjNlQdgYgZI6iL2eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428540; c=relaxed/simple;
	bh=M3PTJqDCQA1BXV4LzCNUeCnnbEkKeELK+aNvFvWOOWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aTuEjPIR2B/Kr+XxhjzTOMn7om+kKrfzZr1ID35nTj6xuSIIfLyefQXuhX1ymoDcknH7UtQM9qIbfY0aoKj5Fo+5JufjOqaQkApgh3phDzozJabCrGRdyU2cp2eleBe9YaavJNZXEPhfNaWSxEduTyiE3TIYePTdYO0O5CMdvK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ezdgeyTb; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ezdgeyTb"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92ed19f4d60so117895685a.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 12:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787428538; x=1788033338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6HrdUaz7lkWm6/+aWbGhNRgT19l/HZ5BPcrR7RGLnE=;
        b=ezdgeyTbjiLxnAsxzXBW7ONzXlgGJD/SA5jPCAtG9EGWVPHNHTFpzv0J49nJc3LfLJ
         cQlW7ot06sfwgdqnxh+nSwsIPJGmYUmhuWKcCk8p+4tT5wAMkOIO2f3HZ0fjP9pTYZgO
         KQcOZ0U1jxPoXToKp24UVM9dV0iPBRdIuHtbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787428538; x=1788033338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6HrdUaz7lkWm6/+aWbGhNRgT19l/HZ5BPcrR7RGLnE=;
        b=jFod2vExq67HGKb41gIg2kpa5Wvy0f94k3nS9OTFLyknsxbc2O5Jpo4Z06ztjevHw/
         BAn4TmisfF2RbKslU10KdfnZpzo/OkngzRIGzhXjfQRaDtd7sxVTFn/rfUuFiywfGGEw
         8I9CLE5J8gTgGGMb3PhTU06jDaQ+Gr/6AY53g6LPcs5VQeu95x7zjlb29BsXq65rYcAH
         3ZGOlAvbYDU6v8JJnLx+GRcGUXHNkcdLE6YHbxasiFixhIHLfbbIx6UVTdQHE40TEFYc
         QyXCOsR5FfuW7p/Nn6LXnxkzPOIlzqZalrFDBwI9OPvBoQ1F7q75DqgAdChX71tWlf0f
         aXdQ==
X-Gm-Message-State: AFuF++nh1jD6CK6U5FYRGr/Asxph3wdoEdj6yROts+SBZQ9rzQ5pJzIY
	Xn0Z28zJ+kjhwvMKPIYdCxYtXNXawPfGDeL7J5F7mMStK6VpP9Z/ZJikamsn8PI6y7fLdjMCote
	xwS4ORw==
X-Gm-Gg: AR+sD11cI1ABOSqbvB/ISfj6PQT3MxFJWvUYt5aZv+yVtCPd8kDUg+FLD8NjU8adTf+
	EGIEbJkzLiKNE9xgoE3BdWR4cvCfbK5Qu1rw6skxF9QlPQG8v/UyNUPZOf6kt2kcUfIlr4NvnVO
	FZywCVtAspTm4NCcvp82h1LmxVBFP1xZ+Zyyw6NyCc036vXqQpzoaK/enaekSBp4PhzQdha1Esj
	wiao9muG2aaLJPDOIzqSUwZmbqZ0PIQwODKvE15MLjUuaS1zu+QblJY0tKfvScso7tja+qYKcuI
	Ie9Emd+xCh/1QhoCI17w+YxKjZtFTcyub6vvJMV33w/k0WMommAQoAexR6x+qv1J/jVnvf8EocL
	PLXdvI4vz8lcB77McdHSBWgYuLUx894gzoMX7mcsvDYSTnxJZ0ByZ0/ADDXjRpSv0VDhErvYtuR
	otr16Ee5feHSP0gtI8F1xCju0AtfTgxS5Ke1twE99MPVsw9L+qcyvsZ7O5I3vy4UM=
X-Received: by 2002:a05:620a:294d:b0:936:a184:3cf3 with SMTP id af79cd13be357-9372840f584mr2180174085a.10.1787428537718;
        Sat, 22 Aug 2026 12:55:37 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749adef4csm172997385a.11.2026.08.22.12.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 12:55:36 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Terry Lam <vtlam@google.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v3 5/6] net/sched: hhf: clamp quantum before hhf_change() to avoid overflow
Date: Sat, 22 Aug 2026 15:55:08 -0400
Message-Id: <20260822195509.112717-6-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260822195509.112717-1-jhs@mojatatu.com>
References: <20260822195509.112717-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hhf_init() sets q->quantum = psched_mtu(qdisc_dev(sch)) with no overflow
check. A device with a huge MTU (e.g. dummy with max_mtu == 0 accepting
MTU 2147483634) makes weight * quantum overflow the signed deficit in
hhf_dequeue(), spinning forever.

Clamp q->quantum before hhf_change() so both the opt and !opt paths see
a sane quantum. Without this, bare "tc qdisc add ... hhf" succeeds with
a clamped quantum but "tc qdisc add ... hhf limit 1000" (any option
present) fails with -EINVAL because hhf_change() re-validates the
unclamped default (sch_hhf.c:559). 256 matches fq_codel's floor and is
a sane minimum for a DRR quantum.

Conditions to recreate the bug: a device whose MTU (plus
hard_header_len) wraps psched_mtu() into the sign bit (e.g. a dummy
device with max_mtu == 0 accepting MTU 2147483634). Requires
CAP_NET_ADMIN in a user namespace.

Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_hhf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index d85cb0263b67..96acab6a8da0 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -624,6 +624,10 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
 	q->hhf_evict_timeout = HZ;      /* 1  sec */
 	q->hhf_non_hh_weight = 2;
 
+	if ((int)q->quantum <= 0 ||
+	    (u64)q->quantum * q->hhf_non_hh_weight > INT_MAX)
+		q->quantum = 256;
+
 	if (opt) {
 		int err = hhf_change(sch, opt, extack);
 
-- 
2.43.0

