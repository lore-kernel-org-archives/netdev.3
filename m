Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429375;
	b=evcXOqmhdH8drJxJG2asb+NFVnr8HSizOd4O/z8PTXR+1etHWKFv3WO2uFDIi73mBBtO
	 tBYfUu7+C4/KO9pw8bpV17k9v+R8aPV6eEv6hSQZHev9bysquFf8tKAEMzW4NCXdVTj9Q
	 n/yLGoXv8NbWmhznbd2xyee+cyAWzJYOYIJ/EJqQBuV6FJQfVBs83H3teF5XrY6Tsd0Qc
	 6X8KN7pvBzJCFL+ruL01b8Q75omFlDfkZm0aelEBa3A0QOkRGa0pDWA3+Vubw+A77AcVE
	 my+S1HT42EwA2tU6ZldXptg4xARLfOO70iU80cYI/GurTI2HmPVN/flpIn/yJNLDJ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BIfyqA5AbmeLJ89zRooXyOk4Vu38p10es+1yAcp1pZA=;
	b=pPmDLyzy9kEXwGBaD2GItYerDeX18G4AdJrX13fQGaI3m31Plu6sqbPU4l4f8//TBBSA
	 l+clAAh2Jlqw92HZJfNR6ca0zaTPoQqPa2JPBTgpUeThJ2twCipWvcja8nncBFOa4vRRG
	 pwK6P8X5fOTK7x0JhPdDrwlfwUVrty74hr6pD1m9Snbstsgx1Pk03NoByxoc/ITYiggVu
	 rP3EVSmyqDy5QhwnV32lbZRb+TUdW/pZPct57vrs8+/cgFBdn86/+kivj4IQ5EAxoRiWk
	 4MfWHwV+LoL/aZpQwIf965OGAfAiYjmMOLm/g2p3/0Fmpv67O0NaR8DCB1vHmJC70Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gKRvHBFp;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5933D606A324
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5933D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gKRvHBFp
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1d8944cb0so3313583a12.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429374; x=1793034174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BIfyqA5AbmeLJ89zRooXyOk4Vu38p10es+1yAcp1pZA=;
        b=gKRvHBFp53SqVVvz8uwI6Jz5jkiG9a6mLRDuJlp/poPdq2AfjPK4jPsrqlyEqajWCw
         TqRjuSUtLby4mmYtf3cyhS2HJgAyOuaqA1+y2ewJsncBg2p2NnrVlU3O487Y35ihWdOM
         Aft0kI0iOQ5DnVUVUlG15THQ6vge9boTyKUFYoKbVGfRWjDhmULmY5bXv74vsFAFlksK
         W44yxIkKBnur2fkDoCc3f5m3Spa8QQVMsOu7IW+uAvdEi8/lwOvNZBGrA9a1oKJtaJlN
         JBTCHfedY0GAuDs1HTVnkoWWs/CLTHF/tCRZSbBqiKKFFYBOIMSAQba3P7cA0zNf4pB8
         ZCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429374; x=1793034174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BIfyqA5AbmeLJ89zRooXyOk4Vu38p10es+1yAcp1pZA=;
        b=A8MYIY3EUlzD5NRh3FppRCnMcpFk19zdByZ2eS5q2Rol8PHJwlh+tveHbiULITGODF
         Jau5NsdL6GyZNkbXa8BsF3/wrJ/73nneu4UzA9Ay7xUliN2Tl5ohAeUyj7MowJ4mZqZb
         dZEW6V7DPsZZVB9C9f++USBMUrDLh61nvz+wxhbw8qEYDkPm/5m/UORuTHww3L232OyT
         h2s25IKDW5b5kjRIQCBferuerpViZzXWgYl1Ip7E1j1INZVLraXBOLBlRnHDcLBpWYvm
         rlHjy6gU2CDw5lzQQ73OWZTdE9UG5sbdJ8JVEcrRrlb+tQqiKo9MyOx9W3NUGKm7j75W
         o/2g==
X-Gm-Message-State: AFq9FYLUqyO5jX/Z8XtrAU8EnAQlsGwQvjAYgPWO4AjonDXEIHLQnPq0
	gunB+Uj+c2E2Hmn4mnSROctpgAaO59uwRPpq168oja8nNDdz5ag1C7yELXYx5DncjA/XnQ==
X-Gm-Gg: AYBFou1e703mbzXet4fbL/BqfLC5zbgId+HE77L47at1koRwkePrwzT28XpzbKcCOKr
	sf8kmUQUydjOIgrtyqyRLX6Tnurb9uhri2PntN/Drw+FTtjfnrfLVJRG//Gh/FdGNv+nQe2JICo
	HFrtBpS+uFfdfpcDf1Jk35W8LODaUPhP19/lXC0P3z0swu34Fe/Uz93JU2d9G2pN45RfKlr6AM1
	k1+WY3QTNCqLIgxf3cUE1Ax1yiiUucxyncsaQU1v5+eXDpB4TQqJtuwWcLp0egnyRANzh1Ac+Cc
	R//6+5HpEd+ekrqQDdnB1rRlz4mkRSnK3Tn5r13G/z7cKYP2bRAGGkk+4Xlmskn2IJMgt+Nqail
	NH2jzbcZwROlCVBLiAAwJmP/T8G1A9JXBpz2ceekdXGqGXKQBmSYs49VL2j6yn/rCel6ls1rhWf
	SDoCm6csgq4s/kAOiCmgBsiYSnlIxSrhjsaKlpMUzJEKsRt64t9four8wN91e3kx3V
X-Received: by 2002:a05:6402:450a:b0:6b1:b97b:745 with SMTP id 4fb4d7f45d1cf-6b3a8186737mr5328588a12.29.1792429373535;
        Mon, 19 Oct 2026 10:02:53 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:47::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1b113dsm4084132a12.10.2026.10.19.10.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:02:51 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Davide Caratti <dcaratti@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next 2/2] net/sched: Don't wait for RCU when unregistering the qdisc lockdep key
Date: Mon, 19 Oct 2026 10:02:25 -0700
Message-ID: <20261019170225.729789-3-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019170225.729789-1-vlad.wing@gmail.com>
References: <20261019170225.729789-1-vlad.wing@gmail.com>
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

Since commit af0cb3fa3f9e ("net/sched: fix false lockdep warning on
qdisc root lock") every qdisc except ingress, clsact and noqueue
registers a dynamic lockdep key, and destroying it calls
lockdep_unregister_key(), which waits for an expedited RCU grace period.
Replacing an mq root destroys one qdisc per TX queue under RTNL, so a
single "tc qdisc replace dev eth0 root mq" waits for that many grace
periods, each of which IPIs every CPU that is not idle.

The wait is not needed here: __qdisc_destroy() and qdisc_create() free
the qdisc with qdisc_free_rcu() after unregistering, which already
keeps the key's memory valid for a grace period. Use
lockdep_unregister_key_nosync(), and free with kfree_rcu() in the one
qdisc_alloc() error path that used kfree().

On an x86_64 KASAN + PROVE_LOCKING kernel (64 vCPU KVM guest, 64-queue
netdevsim device, 214K lock chains) this removes 5.3 ms of grace-period
wait from each of the 65 qdisc destroys in "tc qdisc replace dev eth0
root handle 1: mq".

Suggested-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/all/CANn89iLvu_ijSV+FnrZ6qei_Ty2c9V-RjwLMk24+oOS91bNjaQ@mail.gmail.com/
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
 include/net/pkt_sched.h | 3 ++-
 net/sched/sch_generic.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 90d3e7943b19a..1f4195dabaa57 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -323,6 +323,7 @@ static inline void qdisc_lock_init(struct Qdisc *sch,
 	lockdep_set_class(&sch->q.lock, &sch->root_lock_key);
 }
 
+/* Free @sch only after an RCU grace period, e.g. with qdisc_free_rcu(). */
 static inline void qdisc_lock_uninit(struct Qdisc *sch,
 				     const struct Qdisc_ops *ops)
 {
@@ -330,7 +331,7 @@ static inline void qdisc_lock_uninit(struct Qdisc *sch,
 	    ops == &noqueue_qdisc_ops)
 		return;
 
-	lockdep_unregister_key(&sch->root_lock_key);
+	lockdep_unregister_key_nosync(&sch->root_lock_key);
 }
 
 #endif
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6f6a6f0d5eb0d..28791d4fe35b1 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1033,7 +1033,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 	return sch;
 errout1:
 	qdisc_lock_uninit(sch, ops);
-	kfree(sch);
+	kfree_rcu(sch, rcu);
 errout:
 	return ERR_PTR(err);
 }
-- 
2.53.0-Meta

