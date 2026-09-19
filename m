Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05535C6AD
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828734; cv=none; b=h1MjRxSVu9AZJhTDGzEcUk9o9bp32r3E0y8cLwGOegusKOrK1EczilK2gGEusjUXTFDezJFv8bA+/jQY9rH1IEB8ORJ9j+pnrXJCcKK62qgs2CqlHLaCi/XlIf6yRB8Z3sJndaaxSsT2oIshKlTo/N7woggjJUalcGMvEQAlqmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828734; c=relaxed/simple;
	bh=a2K6ZG6x3TKKY3LgO8ZijoYeiMYTAI1mH6bFSowua58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fURUBy47O9FJHPmmRTVGmhEmaABu5Mi47IuLP5Mr7vaSAGpWXZDEztS2ZJZUGlDjp5cuKn4WG3QLth7gyzhSYRMO+A7bhYEfIlY3TXpjaJG58P7gutE5R9N0maTNiA9uzCLJQxBwuej7lhi6aOinf8SHSSLRlyIr/+NtbhFQArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J47PcVSo; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J47PcVSo"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso14165645ad.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789828731; x=1790433531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JH3YPzGIQgmqjKrtQ76Rj2IGnUf9RzTayZOBGCLjoZ8=;
        b=J47PcVSo4z9RiWJka691WLR8qUUEL22FQfQoUmgs8WuwAsVoujjhJA19cXBZNTvpXn
         9jS5m8O6JMPc/TINtJMn8s1jXQt3qdFpx1O/3TqCVWDj64SFS9q+LruBmN3XfzjBTNEp
         7Lm7MENKJCjxgECi3yI0taScX7L5ITHqqgoI8UIL+4ojjhW9GL1O+EkMpZcCtUtd3nGi
         P0BJyYb7/W8XPLHSvpOfSDpa8W68zmor2NVfAekf8gkHBscnUYW59xLO3wkpFwWG0dl/
         EiXdqqFmOhhZZOYf71ZdP9g3Em/LrJ3uReuNpssUTir1MZMSN0rpFHdCaiwjXbm/j/i5
         LyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789828731; x=1790433531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JH3YPzGIQgmqjKrtQ76Rj2IGnUf9RzTayZOBGCLjoZ8=;
        b=re0QhTjvYJZ8wW77rMUd+2GU4BhIhZae2KTlV/bdB/M2RoWO8fmwQXt6CTyxOgOIbP
         q+sMkVRsIO6W+lbKeZPSI7ctRx2/8+megsqVqTeOfwAo8ZC2L69F/0HC60JeVp0YzoJ9
         XzQo+AyI9L6yG9yQmF4LLcS1Ur3EA3NEpzlnql2ZHTP4Seq+UVa66TPKXlMX+Rv2Vvbi
         OWkitifbDKlRmuvbiJqT40FPV/ZUaER6k0EoSxLEuh8pgBJ5u33td66xTAD2pJ0bpwwt
         ubDI8EPWUDDdljmnzamoCoqr73OW67f3x/wrk/ycv2y5f8v7bP8Q+AFrnncuyEq8xMLz
         diUQ==
X-Gm-Message-State: AFuF++n1x6UqODv56lHDJhs2p77v6kHEEENlSO1o/EKjdZ5rQDof+Uqi
	90vGXt1m9wejxZTka776aK3mhd0n//a0yIN6Oozcbt08c65RQ7LSAxSX
X-Gm-Gg: AYBFou39w7t6Mv7il0sDstopfYFndnEtWjA85BqDz5sqN/rIY7f05I1gsXpMpCOxAwc
	h3hxeuainNSzZJ+Sbu86FPtGghJiDidGBpjI3IJO7BMBvDT2fcIB+UPAxqrRI+avoNQGAp4Y8N5
	1E0jjfd9bTtaQmsQmXFuOYGVtyDi3++zQk9mTolS2fLlQ+mX1kCLlzOAF9D7U1tZORagJtHB0pw
	R4JMnH1a+gLAJ6ASEZjGhZkMxi4K7FTjGQi/842IHWbg4axMJ3FARq6x8eyXx63Y1UktCCKYR4x
	2onGnobncqjgn7VrGAKEbogyje6LV4D4YOy5cPzPaS3djk2RHDmrabC372LRGHJcEgLs+0RTICc
	jvY+NOtVzdVp275vfwZVk/ZY572tnv+XxIgRCyVYOtPduaSCAXmb9psbjplOCKXDbiIlSGqp2r7
	U/CCg1FUeNUVyqIhInEk3Q9kJG7SeZ4so/8rr0SlsltEaARwNDN7PpqN8CJ6BjZNDDdNVeUbpoY
	R5a7qe319dSsrpRsd4BzL5fL66oidrPgaT7GgShA6Q2/5oo+2oUgHH0FO8ACb3bt659oRK4o9w8
	NhMnGi67vYjEZLiIDoALvt5NiY9DhcJoJN0V8QnzM/tyj2+x5F38B7r3i1A=
X-Received: by 2002:a17:902:f544:b0:2db:73fc:b57f with SMTP id d9443c01a7336-2ddb1adbb7bmr96814975ad.10.1789828730889;
        Sat, 19 Sep 2026 07:38:50 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ed79sm10711715ad.43.2026.09.19.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:38:49 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH RFC net-next 1/9] net: add bpf_setsockopt for SK_BPF_CB_TIMESTAMPING_V2
Date: Sat, 19 Sep 2026 22:37:24 +0800
Message-Id: <20260919143732.11772-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260919143732.11772-1-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a per-socket bit SK_BPF_CB_TIMESTAMPING_V2 for BPF Timestamping
V2, that allows a socket opt into recording a "start time" on every
skb it produces or receives, which should be reflected in the rest of
patches.

Add a static key to avoid normal traffic suffered from the performance
affect. It works exactly like netstamp_needed_key.

Use bpf_setsockopt(SK_BPF_CB_FLAGS) to toggle the feature that is the
same mechanism used by SK_BPF_CB_TX_TIMESTAMPING which is actually
version 1.

The whole feature is only reachable from BPF, not from user-space
setsockopt().

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  4 +++
 include/uapi/linux/bpf.h       |  5 ++--
 net/core/dev.c                 | 53 ++++++++++++++++++++++++++++++++++
 net/core/filter.c              |  7 +++++
 net/core/sock.c                |  5 ++++
 tools/include/uapi/linux/bpf.h |  5 ++--
 6 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 671c13494566..55ae1653a1cf 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4514,6 +4514,10 @@ static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
 
 DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
 
+DECLARE_STATIC_KEY_FALSE(bpfts_v2_needed_key);
+void bpfts_v2_enable(void);
+void bpfts_v2_disable(void);
+
 /* It is used in the ingress path to clear the delivery_time.
  * If needed, set the skb->tstamp to the (rcv) timestamp.
  */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 732b35cc08d1..40feea175a10 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7143,8 +7143,9 @@ enum {
 
 enum {
 	SK_BPF_CB_TX_TIMESTAMPING	= 1<<0,
-	SK_BPF_CB_MASK			= (SK_BPF_CB_TX_TIMESTAMPING - 1) |
-					   SK_BPF_CB_TX_TIMESTAMPING
+	SK_BPF_CB_TIMESTAMPING_V2		= 1<<1,
+	SK_BPF_CB_MASK			= (SK_BPF_CB_TIMESTAMPING_V2 - 1) |
+					   SK_BPF_CB_TIMESTAMPING_V2
 };
 
 /* List of known BPF sock_ops operators.
diff --git a/net/core/dev.c b/net/core/dev.c
index 38336858c168..4479fc87b789 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2440,6 +2440,59 @@ void net_disable_timestamp(void)
 }
 EXPORT_SYMBOL(net_disable_timestamp);
 
+DEFINE_STATIC_KEY_FALSE(bpfts_v2_needed_key);
+EXPORT_SYMBOL(bpfts_v2_needed_key);
+#ifdef CONFIG_JUMP_LABEL
+static atomic_t bpfts_v2_needed_deferred;
+static atomic_t bpfts_v2_wanted;
+static void bpfts_v2_clear(struct work_struct *work)
+{
+	int deferred = atomic_xchg(&bpfts_v2_needed_deferred, 0);
+	int wanted;
+
+	wanted = atomic_add_return(deferred, &bpfts_v2_wanted);
+	if (wanted > 0)
+		static_branch_enable(&bpfts_v2_needed_key);
+	else
+		static_branch_disable(&bpfts_v2_needed_key);
+}
+static DECLARE_WORK(bpfts_v2_work, bpfts_v2_clear);
+#endif
+
+void bpfts_v2_enable(void)
+{
+#ifdef CONFIG_JUMP_LABEL
+	int wanted = atomic_read(&bpfts_v2_wanted);
+
+	while (wanted > 0) {
+		if (atomic_try_cmpxchg(&bpfts_v2_wanted, &wanted, wanted + 1))
+			return;
+	}
+	atomic_inc(&bpfts_v2_needed_deferred);
+	schedule_work(&bpfts_v2_work);
+#else
+	static_branch_inc(&bpfts_v2_needed_key);
+#endif
+}
+EXPORT_SYMBOL(bpfts_v2_enable);
+
+void bpfts_v2_disable(void)
+{
+#ifdef CONFIG_JUMP_LABEL
+	int wanted = atomic_read(&bpfts_v2_wanted);
+
+	while (wanted > 1) {
+		if (atomic_try_cmpxchg(&bpfts_v2_wanted, &wanted, wanted - 1))
+			return;
+	}
+	atomic_dec(&bpfts_v2_needed_deferred);
+	schedule_work(&bpfts_v2_work);
+#else
+	static_branch_dec(&bpfts_v2_needed_key);
+#endif
+}
+EXPORT_SYMBOL(bpfts_v2_disable);
+
 static inline void net_timestamp_set(struct sk_buff *skb)
 {
 	skb->tstamp = 0;
diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753552..3486c5c2d170 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5468,6 +5468,13 @@ static int sk_bpf_set_get_cb_flags(struct sock *sk, char *optval, bool getopt)
 	if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
 		return -EINVAL;
 
+	if ((sk_bpf_cb_flags ^ sk->sk_bpf_cb_flags) & SK_BPF_CB_TIMESTAMPING_V2) {
+		if (sk_bpf_cb_flags & SK_BPF_CB_TIMESTAMPING_V2)
+			bpfts_v2_enable();
+		else
+			bpfts_v2_disable();
+	}
+
 	sk->sk_bpf_cb_flags = sk_bpf_cb_flags;
 
 	return 0;
diff --git a/net/core/sock.c b/net/core/sock.c
index 1ad41904db25..251c88e2ee45 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2364,6 +2364,9 @@ static void __sk_destruct(struct rcu_head *head)
 
 	sock_disable_timestamp(sk, SK_FLAGS_TIMESTAMP);
 
+	if (sk->sk_bpf_cb_flags & SK_BPF_CB_TIMESTAMPING_V2)
+		bpfts_v2_disable();
+
 #ifdef CONFIG_BPF_SYSCALL
 	bpf_sk_storage_free(sk);
 #endif
@@ -2550,6 +2553,8 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 
 	if (sock_needs_netstamp(sk) && newsk->sk_flags & SK_FLAGS_TIMESTAMP)
 		net_enable_timestamp();
+	if (newsk->sk_bpf_cb_flags & SK_BPF_CB_TIMESTAMPING_V2)
+		bpfts_v2_enable();
 
 	rcu_read_lock();
 	filter = rcu_dereference(sk->sk_filter);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 732b35cc08d1..40feea175a10 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7143,8 +7143,9 @@ enum {
 
 enum {
 	SK_BPF_CB_TX_TIMESTAMPING	= 1<<0,
-	SK_BPF_CB_MASK			= (SK_BPF_CB_TX_TIMESTAMPING - 1) |
-					   SK_BPF_CB_TX_TIMESTAMPING
+	SK_BPF_CB_TIMESTAMPING_V2		= 1<<1,
+	SK_BPF_CB_MASK			= (SK_BPF_CB_TIMESTAMPING_V2 - 1) |
+					   SK_BPF_CB_TIMESTAMPING_V2
 };
 
 /* List of known BPF sock_ops operators.
-- 
2.43.7

