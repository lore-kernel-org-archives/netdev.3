Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F573AEB29
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255285; cv=none; b=I08Wvg8D0uAyGUHtqlzsmuMUHqvkh02nPKmHOn7k4ANaTNos4jVyqqQx1Ud9fvRk97Fn8f1vpXlAxrzIwtwZLosgHljLYwbEbL/qRYK0GJ/D14nGhI5IJo9tFUssn0/6KVAMC/H953yKTy3PveBKl69IF7BnjHYHZxoSlXYQcGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255285; c=relaxed/simple;
	bh=3NNCGH5ryw+BpbquvEdcLuzcP9h3hRy3kqLMJgFGGJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4H0BSK0VG6spg6NoSurfTrddaQTgwZIo+TRTj7Nkf1SmPc715Kha6wSnPtDezqOXQIl/3gSQtig7LTxj3x14dwJPizORtpOgg9s2IL3x0Fq2QdFZSyn0kUDkpGxX4/etZF4XTVznsliYmg1n+I5Kib07RICf9b2Qi4mGpViKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGOQD4vF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGOQD4vF"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d6d28aa26cso2823385ad.2
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255283; x=1792860083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WG4JK4jcwaSqli0Rkxkj+xPO6Y6Xri8N8nem+swVpHc=;
        b=cGOQD4vFGBi2YY8q3IX5vSNFLWsQNxU5t51wXnVOl2fHCDf6UMleDi5OTxlaDwelwm
         eveFkJghzKprLmkmPwMbJhamdGIaUbreK3KPy9F5MA0MI2hdpJAmycY3jStiBxecxxUU
         7ON5cVasZwpaww/EEntp8Utj95WCuWl1g8fUzsJp6t7S7NEu7YHr1fI3xI8gjoa0bybj
         uJFaNBw2CRMw+OLt70VVEsIcUbp27/m14UWmhIL91HA6HrtE/boJOs7mFyYIzGxfFc64
         BaRnXz2qjwcOtyu5JyReKiLPt6/57SjmZLAzMozP+JwY9afaCEv/DRBcPsMwSlZ6bs4v
         KVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255283; x=1792860083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WG4JK4jcwaSqli0Rkxkj+xPO6Y6Xri8N8nem+swVpHc=;
        b=q7p3xwBJeaME4kOsArza3WWp4lQkmPzZQ6tFMR2Uu9dldWwOqAZUWk3vvLFoxAq3Ev
         HN94/k0ueMZRy5GQBvPfp5Z9DsPDpKjNVndClzw9+aSLUYXL3oBeOCFvZyVJbn7aTvNu
         zUoA9O+g9gF6UTy+xVuLGSimDG1yEFrRZKIXRGOGEXSgTH4R08OR8Jisvtt4QfVrrw8E
         BECi/sT8dvvN+n18l9iMsrOfCEsJE7az7XrA/tk4C87BNKlm72zaPOojBbW9nGgPAw8p
         7ZcoXmNM0cmJrITfdOTNWXUIMWcMv7UUQre6R3N3JRN6gfozb6cHwAZN2Dl7Nr8By88w
         xYSA==
X-Forwarded-Encrypted: i=1; AKwUvByBo7lsjUbXfRrzf3XhPipQZPVAWQuqqjCse6krj0M6ORdIOp1Xk8gDpe6ie5x4jXkcUFWX00c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJduXEoAiuw0DXLMux17RlXNJfcYiylz/+3TO6TNsQszbsoO9c2
	or1CyUcTL3Y8z6cSKUSQRB9M314890og0u2C62O/dZ8m+ghJqINQ4Opz
X-Gm-Gg: AYBFou33mRGAbTvYqBBh5o6XMZelIgHBGV5jQFbO7/PhUD+i9ZzIEluvSZq48kKVhoE
	UK0D+OxJq4ebupcVErntnkXv3GVmbbjp1wa67mCnw2YKeE6mMOpPUo9P5jxNbW3cmbHKNoIPsoR
	9lEXsLLjIwefe5soo2t2iPie4W0yFjaIRze9sjjfe5RXFNnLzpYhpk/JMbxx2quhYVlbBws7B5X
	QWzXzMY3hfviDjl+WEp9ZRL65iSRxBWBvhs4iLC8345vRYVeNgQkeLHiKIPv8qBEKpnfqXHKmsZ
	fT6xkVMP2uOw3UWpWpNQLWgvQzHpUy9c2uQGPgi4RleiQ2zHxLE7JCB8jOHsjnBGZAV6GVQBb2o
	Uwug3me1W/MpykROn0jMNjSramyfHm7bMG9J+wtlHTdoR9rMXzbfrw1WE/EdTtzTkpV2Yc9KB3b
	x/iDnVHkEE52rO03iOGINAOFD0v4DVW26eziMkhkGaIgVRYayUyoBSEzLYq6+d9gYTtiYksanUr
	dw/qigEUE+l6aBGOiTsZSQN8khP1QZ5+v3Ka0aL39qu+bA6RnOB687GXh8PkbOgt7Nelce6FV4f
	w98BTHMqGfBbAenJ3R9fEBTZvrpk1f922fueBARmHJw=
X-Received: by 2002:a17:902:c401:b0:2e9:87a2:b4f8 with SMTP id d9443c01a7336-2e9a6c001b3mr32352275ad.29.1792255283111;
        Sat, 17 Oct 2026 09:41:23 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e99797ad28sm19074415ad.44.2026.10.17.09.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:22 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 35/43] bpf, cpumap: Hold the device of frames in the queue
Date: Sat, 17 Oct 2026 16:37:37 +0000
Message-ID: <20261017163745.3341787-36-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

A frame that is redirected to another CPU waits in the queue of the cpumap
entry with a plain pointer to the device it came from, and an skb from
generic XDP with skb->dev.  Nothing keeps that device.  Closing and
unregistering it waits for its NAPI and for RCU, but not for the kthread
of the entry.  If the kthread is late by more than that, since its CPU is
busy with something of a higher priority, it builds skbs for a device that
has been freed and hands them to the stack:

  BUG: KASAN: use-after-free in dev_gro_receive+0x1f51/0x2b30
  Read of size 8 at addr ffff88800a7340b0 by task cpumap/1/map:1/54

Take a reference to the device for each entry of the queue.  The kthread
cannot drop it at the end of the batch, since its GRO node may keep the skb
for longer.  Let it note the devices and drop the references behind a full
GRO flush, which it does whenever the queue is empty, and from now on also
when it has noted about 2048 of them.

A device whose frames are stuck in a queue is now unregistered only when
the kthread has got to them.  RTNL is not held meanwhile, but if the device
goes with its network namespace, the cleanup of all namespaces waits.

Fixes: 1c601d829ab0 ("bpf: cpumap xdp_buff to skb conversion and allocation")
Fixes: 11941f8a8536 ("bpf: cpumap: Implement generic cpumap")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/cpumap.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 5e59ab896f05..eb87131b1bef 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -45,6 +45,7 @@
  */
 
 #define CPU_MAP_BULK_SIZE 8  /* 8 == one cacheline on 64-bit archs */
+#define CPU_MAP_HELD_DEVS 2048
 struct bpf_cpu_map_entry;
 struct bpf_cpu_map;
 
@@ -74,6 +75,13 @@ struct bpf_cpu_map_entry {
 
 	struct completion kthread_running;
 	struct rcu_work free_work;
+
+	/*
+	 * Every frame and skb in the queue holds a reference to its device.
+	 * The kthread keeps it until nothing is left in GRO.
+	 */
+	struct net_device *held[CPU_MAP_HELD_DEVS];
+	u32 nr_held;
 };
 
 struct bpf_cpu_map {
@@ -129,9 +137,11 @@ static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 		WARN_ON_ONCE(1);
 		if (unlikely(__ptr_test_bit(0, &ptr))) {
 			__ptr_clear_bit(0, &ptr);
+			dev_put(((struct sk_buff *)ptr)->dev);
 			kfree_skb(ptr);
 			continue;
 		}
+		dev_put(((struct xdp_frame *)ptr)->dev_rx);
 		xdp_return_frame(ptr);
 	}
 }
@@ -311,7 +321,7 @@ static int cpu_map_kthread_run(void *data)
 		void *frames[CPUMAP_BATCH];
 		void *skbs[CPUMAP_BATCH];
 		u32 i, n, m;
-		bool empty;
+		bool empty, full;
 
 		/* Release CPU reschedule checks */
 		if (__ptr_ring_empty(rcpu->queue)) {
@@ -344,10 +354,12 @@ static int cpu_map_kthread_run(void *data)
 				struct sk_buff *skb = f;
 
 				__ptr_clear_bit(0, &skb);
+				rcpu->held[rcpu->nr_held++] = skb->dev;
 				skbs[ret.skb_n++] = skb;
 				continue;
 			}
 
+			rcpu->held[rcpu->nr_held++] = ((struct xdp_frame *)f)->dev_rx;
 			frames[ret.xdp_n++] = f;
 			page = virt_to_page(f);
 
@@ -398,10 +410,13 @@ static int cpu_map_kthread_run(void *data)
 		/* Flush either every 64 packets or in case of empty ring */
 		packets += n;
 		empty = __ptr_ring_empty(rcpu->queue);
-		if (packets >= NAPI_POLL_WEIGHT || empty) {
-			cpu_map_gro_flush(rcpu, empty);
+		full = empty || rcpu->nr_held > CPU_MAP_HELD_DEVS - CPUMAP_BATCH;
+		if (packets >= NAPI_POLL_WEIGHT || full) {
+			cpu_map_gro_flush(rcpu, full);
 			packets = 0;
 		}
+		while (full && rcpu->nr_held)
+			dev_put(rcpu->held[--rcpu->nr_held]);
 
 		local_bh_enable(); /* resched point, may call do_softirq() */
 	}
@@ -738,12 +753,14 @@ static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
 
 	for (i = 0; i < bq->count; i++) {
 		struct xdp_frame *xdpf = bq->q[i];
-		int err;
 
-		err = __ptr_ring_produce(q, xdpf);
-		if (err) {
+		if (__ptr_ring_full(q)) {
 			drops++;
 			xdp_return_frame_rx_napi(xdpf);
+		} else {
+			/* The device cannot go before the flush, from now on it can */
+			dev_hold(xdpf->dev_rx);
+			__ptr_ring_produce(q, xdpf);
 		}
 		processed++;
 	}
@@ -807,11 +824,15 @@ int cpu_map_generic_redirect(struct bpf_cpu_map_entry *rcpu,
 
 	__skb_pull(skb, skb->mac_len);
 	skb_set_redirected(skb, false);
+	dev_hold(skb->dev);
 	__ptr_set_bit(0, &skb);
 
 	ret = ptr_ring_produce(rcpu->queue, skb);
-	if (ret < 0)
+	if (ret < 0) {
+		__ptr_clear_bit(0, &skb);
+		dev_put(skb->dev);
 		goto trace;
+	}
 
 	wake_up_process(rcpu->kthread);
 trace:
-- 
2.55.0

