Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D805C3DB31A
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098116; cv=none; b=IT4N3FtlNBXG2eDM0cgdEa63cGFFCyPMS+l1r2xkPDLU8KdKVCOAFO/VZD5iNqjbaEHIaLSfeUvRxpnYmANwPqgiDw0Fr9SKe6KGscn2+jJiXZ9v/IO1nSuk6SVoLFahg6C11mG+dvB41CYspaFDdlM56rUIQCZkybJ/Pu+Kkyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098116; c=relaxed/simple;
	bh=RK8wWGxFMtwRcRjhHVoz9puVSwZ9bJgLm5vkNrU3rzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DclN29tVCKeJhiDL61n0efwBOFNa+Jx28ehaCQm7oJO+QSGN1aGL0hDrMwbY0qX52wlXmWuaWspXsTp3svL8GlClUrMLpS2f+p+T1KeXRCDVKhfTDSokC+F+oM9erJpOK9FY8VQbZiR76SiX/6f+LkCOnpydH/P1KJFRvo8stQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=NODTGREu; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="NODTGREu"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-59c627b53a0so2271820e0c.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781098114; x=1781702914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1KTNQKnIBsF7yMH8+FFRCErdAUhCfRkd/uWZiQWXKdg=;
        b=NODTGREu2YWJzJYSjfP366A97GSupYMBDpRBuuK2r4Zmn110RRDFOtS974557ZMiDY
         8nJcz6TiHNXx6nS04542iY8wzTi8dNr9NKhEC3CYYVbKbQpX7D8LwAZy0/gXOOY2FwMU
         vA7KCXR+yG35LbbhLtrTTvd8F+1Kjfn5BdDVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781098114; x=1781702914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KTNQKnIBsF7yMH8+FFRCErdAUhCfRkd/uWZiQWXKdg=;
        b=dcJsuQdKbo/xR8e9UTuhpr3PNiWf0w9fay6xFUc66XMrMYd7W0JtQBZk1/0FLbEMxv
         kcy9DoFSvx3o/NauSC3nGMnUZ3qmhwwu7Cw2QT/m6QHCQ7mrF54XZJAbloGqTOfjUp1x
         E6CgkzCrlAPDcn+aH5Ae5PSeDOVfsdLpAdPfx2AGvlZZOPtFSeAMMU/3VJYw2Hnh14qI
         n7vVRUW7jjDnhlmSeksSyyPdd7Q7CLZuOfycuqC4qTtPEgHDhGU6Y22DZTwDc6L6lgQz
         WieoUEUdxFurdwtTI1pI0QmTMnNC68HSnyPzh3WNcuCBrlbEOk1KSwUlP5jc+mUynA17
         zuFA==
X-Gm-Message-State: AOJu0YzuNkJmcGhCMvksWyYtIZ3L34gLrHw+IB3xxrSJYTpAguo0eNR/
	qYzhn4uoCrWyOmI4H4XfCbeZb4a4LERbOrw4JWvN36HH53QtTU9BadSl/aP2UCH/Qg==
X-Gm-Gg: Acq92OH0F/bkx6Emei4INixTvy9PDd0xmUgL0D6b27XWeq9YayyyrbXy8vSI2Dq4ni+
	n/fa5cvMEQjt9bSYT4JET3BEMIS/ZOaP39PWnDzRMbrPJ9UdI6+QVZa275FqmzG3Av2g4cpGRFw
	kTQL4kcdaK5EcJPhCtqoBYI8fWnzr52vC5+NY+9/dHQn7+V776yrC4WRFAuPnW2RX+bEi78TdGx
	1ENv/vZUF3WBmU2BwBYlS9FFFNf/EMo/mx1Fd5T3i8e+/vfTs9IkEr1izKTB0K2hUh1RvgOFZsr
	sOZ44rgeVMFbJ4zIPK3Sa5eL6Js3JKDFY/lbydtiho5VR/KFWQtXTule3IxmvPGRC07n+8j/1T9
	NzebnUrfCfhO6sZhGNkVqCqPTvy4FYkUOkSFHZCUPR/KWJ0H8an/qEC/ZomCEoAIBv3jY96VR1m
	rtYZGpa0+zCKq1ndl907luOoTu4pRvOiD2jA==
X-Received: by 2002:a05:6122:7c6:b0:5a4:c20a:ba4d with SMTP id 71dfb90a1353d-5ac4ee91209mr13590522e0c.4.1781098111010;
        Wed, 10 Jun 2026 06:28:31 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67:f17:d82a:d5b8:20a])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96413f5b33bsm18500947241.2.2026.06.10.06.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:28:30 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	anirudhrudr@gmail.com,
	pctammela@mojatatu.com
Subject: [PATCH net] net/sched: sch_hfsc: Don't make class passive twice
Date: Wed, 10 Jun 2026 10:28:24 -0300
Message-ID: <20260610132824.3027549-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update_vf() is called from two places for the same class during a single
dequeue when the class's child qdisc (e.g. codel/fq_codel) drops its last
packets while dequeuing:

1. The child calls qdisc_tree_reduce_backlog(), which, now that the child
   is empty, invokes hfsc_qlen_notify() -> update_vf(cl, 0, 0) and turns
   the class passive (cl_nactive is decremented up the hierarchy).

2. hfsc_dequeue() then calls update_vf(cl, qdisc_pkt_len(skb), cur_time)
   to charge the dequeued bytes.

On the second call the class is already passive, but its child qdisc is
still empty, so update_vf() arms go_passive again:

      if (cl->qdisc->q.qlen == 0 && cl->cl_flags & HFSC_FSC)
              go_passive = 1;

The leaf is then skipped by the cl_nactive == 0 check inside the loop,
which does not clear go_passive, so the stale go_passive propagates to the
parent and decrements its cl_nactive a second time. A parent that still
has other active children is driven to cl_nactive == 0 and removed from
the vttree, even though those siblings are still backlogged. They are
never dequeued again and the qdisc stalls.

Fix this by only arming go_passive when the class is actually active, so an
already-passive class no longer triggers a second passive transition. The
byte accounting (cl->cl_total += len) still runs for every ancestor, so
dequeued bytes continue to be counted exactly once.

Fixes: 51eb3b65544c ("sch_hfsc: make hfsc_qlen_notify() idempotent")
Reported-by: Anirudh Gupta <anirudhrudr@gmail.com>
Closes: https://lore.kernel.org/netdev/CAN2cbVe79oj0O9==m4+4x3v+O+qzRagA=2=wkrp9i9=CqYvyZA@mail.gmail.com/
Tested-by: Anirudh Gupta <anirudhrudr@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_hfsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 83b2ca2e37fc..6552c0c4e7b3 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -753,7 +753,7 @@ update_vf(struct hfsc_class *cl, unsigned int len, u64 cur_time)
 	u64 f; /* , myf_bound, delta; */
 	int go_passive = 0;
 
-	if (cl->qdisc->q.qlen == 0 && cl->cl_flags & HFSC_FSC)
+	if (cl->qdisc->q.qlen == 0 && cl->cl_flags & HFSC_FSC && cl->cl_nactive)
 		go_passive = 1;
 
 	for (; cl->cl_parent != NULL; cl = cl->cl_parent) {
-- 
2.54.0

