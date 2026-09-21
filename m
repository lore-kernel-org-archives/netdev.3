Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7EA2F8E95
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980471; cv=none; b=hAXwRCgzl2QfxCV33pzBPiQz9gN5KhVw2xIa6R2vr+xATVAfbTc+98yYImnyFB9G6fvlwuFwXCIeqiS5CDbdgHvqyN1NvwWBguoR/DGv3PxfLhWgvJHbYiMb5s5kSux/AlCh+FodGcPhgdeEb7aSNQNPMIkCTsmQFiFVcC6lMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980471; c=relaxed/simple;
	bh=4boxTj4HgoKOGbDDCUVz3plfhT7tOw1OccKKwO0JDfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R7dZj5a0V5mUcsZ6g5crBlIUd/hZM+FKB4hcS/0uCznrjVn+59f6agDIfTcr6V8gym1N8B2W3ZiggeCIWAzvhWBsFaTLGDKTbetI+/hZHGU7VxYCwEiO/VNm484xvHjNQiClraY35BdjOZPawZ361EbU7FwLc25yVer+g5NtC1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR49+OWN; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR49+OWN"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so2336624a91.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 01:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789980469; x=1790585269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Urx5VAzeW0SAsBCzvqpIJ50QnXWRUXM3fTUbLQfQHzE=;
        b=BR49+OWNMoKX05FV139aG8X2fX1I9Jp0fQmhWb5jS7+zbgtku+ejd82iQtiPWlvdMP
         8bN/e8f8/jG1rT5BNDW1yxGgMSrinRqn7UnfI0W5w891k5jYNxbGr/mROrDgxvf5dMmn
         2hgkDHUK+H/6/cDvdedK1w5qWa9929Vt/3/0XltrTWuW7L+lSsDpGAEjwnTEZdtNZqX2
         2zJnMpen0yF6sjhLN7FK7wtN4BpsForhZAh/8BlJFQ0dTL04urAkfkejX6f4YCbIqB6M
         Pqcd0ogowo98A0jKrE54pq1Jvzza8J2u9mOE03lRtoHTU9JgjK/FE7jtVWKc+pahhO8T
         xvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789980469; x=1790585269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Urx5VAzeW0SAsBCzvqpIJ50QnXWRUXM3fTUbLQfQHzE=;
        b=2iWNfM/KSFqVa4w5uZpDKawYjXTHSpz86lM9OmxoyT0IzHJRNh2QZM7/k+9RPzx5rK
         nfDKrG6c6mJBnoTYuUSgsoTWPq3iVxBrMGvdvwB3G0Y4wdOAwg7LAGxQX9NKITRL7LyF
         QGL8tJWYPxOt2QAwiGJQ0PXVcrHwNvR947imH5ErCoJkM8Sen0AI6Ru0MnZI1KMrxWSg
         Xb7FII9qlbxYmNwHRnyfBZ7FVlefx7KAipiHQdfJGPvv02ApbebW5rzRX3JjUJfvMUhV
         klQV3UO/4vUUBifNi1Q8lHIN0rRSIjnsY+BQJK4lPRzXfpFaw498SnI8r+BkULC8G3ST
         gBFg==
X-Gm-Message-State: AFuF++nUwYUfbzGfUXcc7RUdDFl/g2cQ5bQglbhKSaBsBjDu45lPYwLY
	2Oe38C16vbaCQn+CHi6yU0N0PxbuZ4SJ87EaZSZoi3I2Dw8RyxuzsNF8fr6S3oIE
X-Gm-Gg: AYBFou1BrZNYLWfStCPI2ebpfmZmoFA8bBQOaFe+9S6WHyQJdQDhtmmnHJC2419F0Tv
	CkATOh8JoYFj3Vl8Qqx7B3S0pCRlT9rvX9N2znQkrSxI8xPMVObfLgx37NV7eI2aRowAul1r+FH
	wKECKdAhuJczfkoZOJ89qZ1ZwzFklvk0twql8LD8OGSKL2MEOH7vdlEjeqyF3W7wtbp6wLU9FZ7
	HqqZNnK9U8bB6ljHHg75HeaMenRqiyHztxrQsYScxA7FPjR4xMQCWh+qRHIDW/BFAboyD3VUDN4
	qob6KVpNctGlK9XG/n2a25AzzXveb02EW180dmiRbtJAOib+3hkwINo5PODm9Wz5EMGhB7xatF3
	6twfnizh4CV3eZnNZEq8v9CDzmtaSulmwnJpkJEtD8zbwyYXTu6yjdRc0ObqQvFTtE1CA4ILDB8
	dVh7U+7wJzMtw+J5qyw73S33oFfIxjpRAeZz3HiLLwVltCTuAMFBNqromqFtodpy+PpsBST5Q=
X-Received: by 2002:a17:90b:6c5:b0:3a0:295e:6e58 with SMTP id 98e67ed59e1d1-3a0295e7719mr6593413a91.2.1789980469218;
        Mon, 21 Sep 2026 01:47:49 -0700 (PDT)
Received: from fox.. ([43.242.224.196])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55e8954sm34064422c88.14.2026.09.21.01.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:47:48 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	chopps@labn.net,
	shubham@octane.security,
	robert@octane.security,
	gio@octane.security,
	roshaen09@gmail.com
Subject: [PATCH v2] xfrm: iptfs: hold a device reference while packets are queued
Date: Mon, 21 Sep 2026 14:17:43 +0530
Message-ID: <20260921084743.817859-1-roshaen09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPTFS receive may retain skbs past the return of iptfs_input(): out of
order outer packets are parked in the reorder window (w_saved) and a
partially received inner packet is kept in ra_newskb until more data
arrives or the drop timer fires.  The retained skbs keep the pointer
to the ingress net_device that was copied from the tunnel packet, but
no reference is taken on it.  If the ingress device is unregistered
while any of these skbs is queued, the later processing in
iptfs_drop_timer() and the xfrm_input() restart path dereference a
freed net_device:

  BUG: KASAN: use-after-free in xfrm_input+0x45d6/0x59c0
   iptfs_complete_inner_skb
   __input_process_payload
   iptfs_input_ordered
   iptfs_drop_timer

Take a reference on skb->dev when a packet is placed in the reorder
window or kept as the in-progress reassembly skb, and drop it when the
queued skb is delivered back into the stack or freed.  The drop timer
and the reassembly queues are bounded by the configured drop time, so
the extra reference delays device unregistration by at most that
amount.

Reported-by: Roshan Kumar <roshaen09@gmail.com>
Reported-by: Shubham Antil <shubham@octane.security>
Fixes: 6c82d2433671 ("xfrm: iptfs: add basic receive packet (tunnel egress) handling")
Signed-off-by: Roshan Kumar <roshaen09@gmail.com>
---
v2: take the reference on the incoming packet at the reorder dispatch
site instead of inside __reorder_this().  __reorder_this() is also
called with an already referenced buffer from the window shift path,
so taking it there could leak a reference.

 net/xfrm/xfrm_iptfs.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 597aedeac..0a1a823f6 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -701,6 +701,8 @@ static void __iptfs_reassem_done(struct xfrm_iptfs_data *xtfs, bool free)
 
 	/* We don't care if it works locking takes care of things */
 	hrtimer_try_to_cancel(&xtfs->drop_timer);
+	if (xtfs->ra_newskb)
+		dev_put(xtfs->ra_newskb->dev);
 	if (free)
 		kfree_skb(xtfs->ra_newskb);
 	xtfs->ra_newskb = NULL;
@@ -837,6 +839,7 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
 			goto abandon;
 		}
 		xtfs->ra_newskb = newskb;
+		dev_hold(newskb->dev);
 
 		/* Copy the runt data into the buffer, but leave data
 		 * pointers the same as normal non-runt case. The extra `rrem`
@@ -1153,6 +1156,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 			spin_lock(&xtfs->drop_lock);
 
 			xtfs->ra_newskb = skb;
+			dev_hold(skb->dev);
 			xtfs->ra_wantseq = seq + 1;
 			if (!hrtimer_is_queued(&xtfs->drop_timer)) {
 				/* softirq blocked lest the timer fire and interrupt us */
@@ -1467,6 +1471,7 @@ static void __reorder_future_fits(struct xfrm_iptfs_data *xtfs,
 	}
 
 	xtfs->w_saved[index].skb = inskb;
+	dev_hold(inskb->dev);
 	xtfs->w_savedlen = max(savedlen, index + 1);
 	iptfs_set_window_drop_times(xtfs, index);
 }
@@ -1602,6 +1607,7 @@ static void __reorder_future_shifts(struct xfrm_iptfs_data *xtfs,
 	/* We've shifted. plug the packet in at the end. */
 	xtfs->w_savedlen = nslots - 1;
 	xtfs->w_saved[xtfs->w_savedlen - 1].skb = inskb;
+	dev_hold(inskb->dev);
 	iptfs_set_window_drop_times(xtfs, xtfs->w_savedlen - 1);
 
 	/* if we don't have a slot0 then we must wait for it */
@@ -1633,8 +1639,10 @@ static void iptfs_input_reorder(struct xfrm_iptfs_data *xtfs,
 	}
 	wantseq = xtfs->w_wantseq;
 
-	if (likely(inseq == wantseq))
+	if (likely(inseq == wantseq)) {
+		dev_hold(inskb->dev);
 		__reorder_this(xtfs, inskb, list);
+	}
 	else if (inseq < wantseq)
 		__reorder_past(xtfs, inskb, freelist);
 	else if ((inseq - wantseq) < nslots)
@@ -1691,13 +1699,18 @@ static enum hrtimer_restart iptfs_drop_timer(struct hrtimer *me)
 
 	spin_unlock(&xtfs->drop_lock);
 
-	if (skb)
+	if (skb) {
+		dev_put(skb->dev);
 		kfree_skb_reason(skb, SKB_DROP_REASON_FRAG_REASM_TIMEOUT);
+	}
 
 	if (count) {
 		list_for_each_entry_safe(skb, next, &list, list) {
+			struct net_device *dev = skb->dev;
+
 			skb_list_del_init(skb);
 			iptfs_input_ordered(x, skb);
+			dev_put(dev);
 		}
 	}
 
@@ -1737,8 +1750,11 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 	spin_unlock(&xtfs->drop_lock);
 
 	list_for_each_entry_safe(skb, next, &list, list) {
+		struct net_device *dev = skb->dev;
+
 		skb_list_del_init(skb);
 		iptfs_input_ordered(x, skb);
+		dev_put(dev);
 	}
 
 	list_for_each_entry_safe(skb, next, &freelist, list) {
@@ -2743,12 +2759,16 @@ static void iptfs_destroy_state(struct xfrm_state *x)
 
 	hrtimer_cancel(&xtfs->drop_timer);
 
-	if (xtfs->ra_newskb)
+	if (xtfs->ra_newskb) {
+		dev_put(xtfs->ra_newskb->dev);
 		kfree_skb(xtfs->ra_newskb);
+	}
 
 	for (s = xtfs->w_saved, se = s + xtfs->w_savedlen; s < se; s++) {
-		if (s->skb)
+		if (s->skb) {
+			dev_put(s->skb->dev);
 			kfree_skb(s->skb);
+		}
 	}
 
 	kfree_sensitive(xtfs->w_saved);
-- 
2.43.0

