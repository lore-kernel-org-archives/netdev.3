Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14914534AD
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979773; cv=none; b=Xd7gGMs6zHjB680TDL9a20WvI0h1BRPcTOJcWgWnPJRTFMw4UcHMEla97BfnPXRuIeGWyDOWuT8d/LPqolHCLrIj+VpqfUxrF3nD2eCYRDXyv7y9K0lNkwNZFJXL1Ogsu1J7poE7PhgC1qdd/sNHQUMsMATQ3iPnzllArKSYlkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979773; c=relaxed/simple;
	bh=OdBNgb0PtwM4DWzdp2s9eZOPrAztVKM8tUWsHZwHw8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkeodnvzdJLlSXn84m3VZLOm0c648a+p2NbvO6mhnal7nq0QC/USOWwcIcdPic37rqlCklHb97Irj6VAEe27l7aaqmvud1XpZsWHxH1+mgfvWbV4AAYwcnjA3dZ2t2zPAGvBG494uQSN3Q5CBRBcHlz1JiAxzIBTzqiygmG/7yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geTVWfUD; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geTVWfUD"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso1914893a91.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 01:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789979768; x=1790584568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vDdpnAedBCd+PkUW1BZBEIgcTVJ4n1or/kvNujyh01k=;
        b=geTVWfUDPvO4sRwzoKMrVpAPcgnVejpzmaiJCO/ka5IJbvYHjycUSqHUPw0s7lp3Ni
         pxVcX5r7db5tLbLCGM4FEHAQxC3dVCqHnOlu4GH5YirYcWr3UHKh0+FPlw1qvvnzmwqm
         NwfbwS/Fet9NP8HAMBUsAV2lcZlqpKOgvo0ZqqiU44FEGd6vY+jTtheCkIPo8dICdNLK
         7iFD2jl31SzoamZa6nv/KWqVGaMMUBA8rcxKNpGUh9vAzVseSUuExI0Pm/DwIYbxsv89
         oG/TlkO03GPkuCP8MP8spqj5KveBl7sVKhCOF/XVIOHRelDH+CJ8HYiI/6VgverbDGHr
         5nIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789979768; x=1790584568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDdpnAedBCd+PkUW1BZBEIgcTVJ4n1or/kvNujyh01k=;
        b=EkIXxZ2vzqc7m3g/LwxWY+Mgj48dyuM4/T1Jvqfiv7xvIhig669+8qLmZTuIeJPvWV
         qG+EbckLNiVvVHLRL1rKWqwRNRxcbeCamf6QbSQIR12kGjzW/alAeC/ZbXNlR7fW9Iox
         eP0zWnCZYyM/T1svy/EFnjBfFjdbgGY9i2BfJBdeFOR3bnZ7lzONT97SpaHaWE6pLKsy
         MIgca81OegFSyLx6s1uErhDV+HzNoFV5yZbFnoGgj0eBizchtgXqMvQWmxdwdDscnwxp
         r/HJBdG3d9KHaUdQvfHmMzBQs6eoSZr/m2wLpnm7IRK6lFdoE8qRIyRpXsetmj3mMvmL
         Iwsg==
X-Gm-Message-State: AFuF++mF3trIJv4PNwnDzZrDVg3bH03FHH8Cs6POiBb4Hoobup0+y4xd
	6S4jQtTPy/3YxWetX8rh1se+0hayo8snD8oVSqT3ND+saGqPHCs2cGb3XDOLLUiE
X-Gm-Gg: AYBFou0rBSQBbnFvxHgYfgl/Fb4kkgNumhY2ifomoBEF+2zY09QVxCTHZPOeqlzYBfw
	F3Bi2QV6SpWgqpWqmXva5AIhvhhIpwGbNwoGW4z7zah7FVrPcpZW4JQNBYmuByCcYUvBLY0b/99
	0ejd2KeJRm5JCXPZhSN8HOhMaU9Q8mjiA4wx+VXP2AcAaaEF+89qPpAG9ERcTta3q6v+Q/LOBup
	EoEmDBxHV8iKHO9W5ilQuyE3nNIVyVs3pLqi8goHCXFyIOKX4wTaJAmg8pAbVjUyXyYgSKBvUTq
	zE0zNLB3NVoOWUsVbsigjzxMY5+M6782WOB1fJDgn/whFjAOUKmo4cAp5OnpLq3tGkDGCY2kL3X
	j7ZR6v2t8rqKdypre+9RtkbtcyBJJRHEAWudTSslmj9bv146GHKCfonEgiwxb/sGiSqtmhcxToe
	oPXIid2GAchry1QxU6RoBF18+kwDNaZKbJAtBoB1KWPGiUMHae+4qvE7aiCb8i
X-Received: by 2002:a17:90b:134b:b0:3a0:5413:49b7 with SMTP id 98e67ed59e1d1-3a054135a87mr1285742a91.42.1789979768228;
        Mon, 21 Sep 2026 01:36:08 -0700 (PDT)
Received: from fox.. ([43.242.224.196])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331aef90sm16595526eec.26.2026.09.21.01.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:36:07 -0700 (PDT)
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
Subject: [PATCH] xfrm: iptfs: hold a device reference while packets are queued
Date: Mon, 21 Sep 2026 14:06:02 +0530
Message-ID: <20260921083602.814584-1-roshaen09@gmail.com>
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
 net/xfrm/xfrm_iptfs.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 597aedeac..98de38d5e 100644
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
@@ -1373,6 +1377,7 @@ static void __reorder_this(struct xfrm_iptfs_data *xtfs, struct sk_buff *inskb,
 	u32 count = 0;
 
 	/* Got what we wanted. */
+	dev_hold(inskb->dev);
 	list_add_tail(&inskb->list, list);
 	++xtfs->w_wantseq;
 	if (!savedlen)
@@ -1467,6 +1472,7 @@ static void __reorder_future_fits(struct xfrm_iptfs_data *xtfs,
 	}
 
 	xtfs->w_saved[index].skb = inskb;
+	dev_hold(inskb->dev);
 	xtfs->w_savedlen = max(savedlen, index + 1);
 	iptfs_set_window_drop_times(xtfs, index);
 }
@@ -1602,6 +1608,7 @@ static void __reorder_future_shifts(struct xfrm_iptfs_data *xtfs,
 	/* We've shifted. plug the packet in at the end. */
 	xtfs->w_savedlen = nslots - 1;
 	xtfs->w_saved[xtfs->w_savedlen - 1].skb = inskb;
+	dev_hold(inskb->dev);
 	iptfs_set_window_drop_times(xtfs, xtfs->w_savedlen - 1);
 
 	/* if we don't have a slot0 then we must wait for it */
@@ -1691,13 +1698,18 @@ static enum hrtimer_restart iptfs_drop_timer(struct hrtimer *me)
 
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
 
@@ -1737,8 +1749,11 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 	spin_unlock(&xtfs->drop_lock);
 
 	list_for_each_entry_safe(skb, next, &list, list) {
+		struct net_device *dev = skb->dev;
+
 		skb_list_del_init(skb);
 		iptfs_input_ordered(x, skb);
+		dev_put(dev);
 	}
 
 	list_for_each_entry_safe(skb, next, &freelist, list) {
@@ -2743,12 +2758,16 @@ static void iptfs_destroy_state(struct xfrm_state *x)
 
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

