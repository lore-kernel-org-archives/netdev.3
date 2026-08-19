Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E73B995F
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150028; cv=none; b=k1uwg4ERF5MLv9u0vplpO/t1dQve7DsldzEpntgWwIq1VEntvXqC0H1vDITiHpQHqBUjmgm9Gq6smvrA5MtepVczjaebyczVXUImsfzTaXhjmcnQi2arKvMcQ4h8pDXYL2A693XXT4MbX4I58kbHjMO6PDcD0g/s1dAh/qBsMC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150028; c=relaxed/simple;
	bh=vOX6ffyG/ieT0WE8b5wbPDo0xpG31cy3dM5nOQq2zn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ay/QUzgYL/yzi7qSmW4YDbwjUnrjdzgjTfeUWMVaJDZyEZSy2GVS8En2E9/ruVb5lFpM0A058JsLGY3kCqTr5mM0c9Q4KYB9oiEis+rXNELlFXLkbjnatkCR8Zx+c+VF5WcE/B48Mn4HaWpX/WGbwpDS7/RyMIaQfW823ZHC6iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=DQKDRwzF; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="DQKDRwzF"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c0ecfaee7so6966601cf.0
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787150024; x=1787754824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ejuOPt68qhDY4noBlNOcm7rYGgb1gdrrIu92QM8wUXg=;
        b=DQKDRwzFvE514r1SSQSu57hX4Gvr+7mmyVFOZ9iVCcKAPbYaNd9TkkfYldQD8fTVGf
         mJhZ+TFhTv101fwOKct1vblnP97euy+fr+OQAnl8vfrQ1h/qfY2KLrlNaNZIvzJx4eqb
         dt5U3+HcZ7MMcNFoBKYg+Pxn9DfuBmhcNa8kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150024; x=1787754824;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ejuOPt68qhDY4noBlNOcm7rYGgb1gdrrIu92QM8wUXg=;
        b=cXyQsn9/2Qx1aCV1piHpKi+E8yJ5WE6678bb+r7FpVGxJ6BRfpaSuRSq9dgXiZ0+AJ
         nJkIj1n5Ubo/Gx5cJHUAUOJ16XwH+CtngtqiZp1jgTRLBaMQluiJDM5xNOhxw/DXK2XY
         9B9GeSS0vXx92pO6Nmkrv1WUxJSIcs4hZB8D2hEHYN7kk8jGhX4kzxRcaK3r0KEyYgpi
         L8uqC1xHMTIbQ4Rgo3fj246+5HYaSEg6PEW+Qa8fkMSHKdKIBCu73E3s+a8sDPsGOx+H
         W6nqH48TJgyI7B+9CAcXNryKHItyq4lsHxhcIRT4cKLqPNh7gdbtxhHbjFqAG6y/2YQm
         Xp+A==
X-Gm-Message-State: AOJu0YwZmu+jqzMAsdxeq2GXzyAiPgweF1Ha3uEBgqPm6MgAzJ67+SJD
	kl8eMlRMHPTr2pibpeMbBqVuKpaCmSuR23xtj1kLgsHZXzDurBnRBnrD9fAo7aj8TabYnvLy0kY
	KzG63Jg==
X-Gm-Gg: AR+sD111gBg9yqcr7hIhuzerfoC4t7hApfkLmtACR86ptaNPC1ogLSGj6ZdWNCmftE8
	yd732AozS5Uiy6PBKbwB6Hz/I6KtmiiAI3DBcXk8v0bHVRiYUSB4tQkq0mzLWm04MYZ77zthjgu
	CB1GJbKJWhkVnMXRiX8MX2TxMgyTxHqs3XzY/NWo+mnSerD2efRqNXYaXhxAmLdqnfQbcQGsLie
	Xed644eC/eVihgJ33OONsMEW+gOoKv834iy6JI7Bgh5frvJVZ9VUQ6Xcz3ySI0sfMLhDq63wF0l
	aDQnsY518XQId3HNdTVLvqJWcxW4ApIzbY8E6GDRp93rKupCZSJF8ykpv6NzUsLj1W7WZCvr0Xb
	+P/9fCTIBBwVtWhFhpuk4lkIgoQduSx4994S5ONhr3Z5evO9PlFQLM7j2PgU+8ZZLBVJQv2RhGK
	yJEzZHcXAR3JJ1TRpYYOPbGagFaeLnVQ5g4wFhqAFzRO/4jfp6iYG+
X-Received: by 2002:ac8:7dd2:0:b0:52d:824c:4856 with SMTP id d75a77b69052e-52dd5c5358amr45530651cf.31.1787150023966;
        Wed, 19 Aug 2026 07:33:43 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd872f61esm11871901cf.23.2026.08.19.07.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 07:33:43 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2] net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup
Date: Wed, 19 Aug 2026 10:32:13 -0400
Message-Id: <20260819143213.57401-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

qdisc_get_stab() accepts a user-supplied size table, and
__qdisc_calculate_pkt_len() amplifies qdisc_pkt_len() through the
overhead, the size-table data (u16), and size_log (up to
STAB_SIZE_LOG_MAX).  A crafted stab can therefore set qdisc_pkt_len()
to ~1 GiB for an ordinary skb.  Per-flow deficit schedulers such as
DRR and ETS replenish one quantum per loop iteration; with a tiny
quantum (1) they spin billions of times under the qdisc lock,
producing a soft lockup / RCU stall.

Cap the final qdisc_pkt_len() to GSO_MAX_SIZE so the size-table
amplification cannot drive deficit schedulers into an unbounded loop.
A legitimate size table (e.g. qfq's overhead 999999999, which is
handled by dropping) is still accepted.

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_NET_SCH_DRR=y (or CONFIG_NET_SCH_ETS=y).
- Attach a DRR (or ETS) root qdisc with a crafted TCA_STAB that
  amplifies qdisc_pkt_len to ~1 GiB (e.g. size_log=15, data=[32768]).
- Add a class with a tiny quantum of 1 and send one small packet; the
  deficit loop spins billions of times under the qdisc lock and trips
  the softlockup detector (panic with kernel.softlockup_panic=1).
- Reachable as root or from an unprivileged user in a fresh user+net
  namespace (unshare -Urn) with namespace-local CAP_NET_ADMIN.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2

1. Sigh. The v1 overhead cap broke the existing qfq tdc test 5993, caught by
   running the whole tdc.sh instead of affected qdiscs reported reported by
   poc. That test legitimately uses stab overhead 999999999 qfq and expects
   the qdisc to be accepted (exit 0) with packets dropped.

2. Better Fix: cap the final qdisc_pkt_len() to GSO_MAX_SIZE(524280) in
   __qdisc_calculate_pkt_len() per sashikos[1][2] suggestions

3. Given existence of tdc 5993 we dont need the tdc test created earlier
   since the essence of that test is covered in tdc 5993.

[1] https://sashiko.dev/#/patchset/20260818101735.16655-1-jhs@mojatatu.com
[2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101735.16655-1-jhs@mojatatu.com
---
 net/sched/sch_api.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 65b35528d125..ad4f117ff55a 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -610,8 +610,11 @@ void __qdisc_calculate_pkt_len(struct sk_buff *skb,
 
 	pkt_len <<= stab->szopts.size_log;
 out:
-	if (unlikely(pkt_len < 1))
-		pkt_len = 1;
+	/* A size table can inflate qdisc_pkt_len() beyond any real packet
+	 * (via overhead, the data table, or size_log); cap it so deficit
+	 * schedulers such as DRR/ETS terminate their refill loops.
+	 */
+	pkt_len = clamp_t(int, pkt_len, 1, GSO_MAX_SIZE);
 	qdisc_skb_cb(skb)->pkt_len = pkt_len;
 }
 
-- 
2.43.0

