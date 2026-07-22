Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA964C0426
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715369; cv=none; b=TmnECkTecq9os/rh5K39RwVPkzIe2l8ZZQh8jLbPzIzsIgUl9m4Lz5wfvadNWYcvRwTMdVyGzI9nJJFDERii83nFHXRU03CTnBJDoSFKxwU9NWng/YaeOYhWRm/HxlL38NymKaqSfL6YWm4deR62bNxnbP23nQ4kmFok6Ol5P8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715369; c=relaxed/simple;
	bh=x4mo26zfUHCBiqJ4mR+22Ghid7JtNBj+6pGWK/pEq/s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mxiv4lxcJIZZ97LiSgvA3Lh1qg4DVeMEqMZiVb1gzciW8/DpX/F6ogs9ywqChCa3ENSFoc2knWPVP+dx2hPqNw1QEY9lMk+/4O9UeL+m1IWO/7Dqviysj7xTvGDEeF2JBa6/WkxYTUriaNKjmLJzbI+yGM/OLIoZkN9Wc/rfdrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YBW/ClKK; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBW/ClKK"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92ea24a2db9so270462185a.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 03:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784715367; x=1785320167; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pO27D2dm2dNec2dTa60SEoOy20QATAPxLHtoffkE+Ac=;
        b=YBW/ClKKFpG11pBlvi9LE62ljbCJTXRyWjLKrjWFlT0a1maxQrr3nSAPCD/AEQxSu0
         Aj8Je/o00O1jcNc3O4Bfphlq5VIyDgKBLqJhHjrn/l0YZdlIs0KCh5f2witaicIALtpv
         Rp3k2+dVGc3PFArbLFJow8Njur0vdSMhL8a5oHe+28BTjZ11H53pUitm6uncX+ZSuL/q
         w0RGMlDeQ/6dK3wpn+ZDBnhnpFooYBVRswnel2fEHKnCGOjeynRAg8NWp9rPkGdUOzxS
         imHKa2BqtqcpIFjupkmd3TdXCzyiKDpl7vjhzDwayXAJOgfj4+SXI2/YCrEjxedUP6Gw
         mDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784715367; x=1785320167;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pO27D2dm2dNec2dTa60SEoOy20QATAPxLHtoffkE+Ac=;
        b=LdQzxiQYfegatiKT7K69yJsCBG2g0yoYNnGkYNgg6Lro9Iz35t9Sa+VmDtjZJWU7Gu
         oqxjmRCYBGB5weiamz2TRnXXwkCFGDnuozF9eTw+sfSbuvNH2laRqYpqpzMkDhT9z1O1
         0qCpjzxvEWc0gZ+u5N3TkvgJ5ahuWzhBl9ADx6JCFYsBF+/tlj/Jkrdk7xDoiAOE42yp
         xCD/HK36HNcGqNLdzmE3hschiIPBsPIR3AJgjQ/s1OT2j25t1uImj0Zf70EeHGyDNkTU
         vIxrxDixEmUCGY9kjl5r5QCbDMNU4PCYkc3bNLtvyYVdy+Fhi0Vma7gxPg5jIR9ERHcC
         HbBA==
X-Forwarded-Encrypted: i=1; AHgh+Rpt+edCVfCfGuiuUpiV/jmxUW9gzTKEppnwsVDruEb9obhXaRj+ii6XzzbmZOdMjbpw+JhSrfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC8CqiGInZBiyAHvCXeJJ1eNsEBfXkr2C3IdqAQTHWY5dUrE77
	QDH5hlG6pzgnGegAiJG8MTuboseTmAkquS3oZMtm6S5ItAgZM0cNLkpwhr7jaMxqetMOoa0UjKx
	hJDrv1P/bYt5bbQ==
X-Received: from qkhp28.prod.google.com ([2002:a05:620a:22bc:b0:92e:5f51:748b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8005:b0:915:abc4:b580 with SMTP id af79cd13be357-930b416d26cmr2128348985a.49.1784715366530;
 Wed, 22 Jul 2026 03:16:06 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:16:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722101605.2868548-1-edumazet@google.com>
Subject: [PATCH net] ppp: annotate data races in ppp_generic
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Qingfang Deng <qingfang.deng@linux.dev>, linux-ppp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Several fields in struct ppp can be read or updated concurrently
from multiple CPUs without synchronization, causing data races:

1. ppp->mru is read concurrently in ppp_receive_nonmp_frame() while
   being updated via PPPIOCSMRU ioctl. Protect ppp->mru updates in
   PPPIOCSMRU with ppp_recv_lock(ppp).

2. PPPIOCGFLAGS reads ppp->flags, ppp->xstate, and ppp->rstate
   unlocked. Wrap the read in ppp_lock(ppp) to get a consistent
   snapshot.

3. ppp->debug is updated via PPPIOCSDEBUG and read concurrently on
   fast paths. Annotate reads with READ_ONCE() and writes with
   WRITE_ONCE().

4. ppp->last_xmit and ppp->last_recv are updated on TX/RX data paths
   and read via PPPIOCGIDLE32 / PPPIOCGIDLE64 ioctls. Annotate with
   WRITE_ONCE() / READ_ONCE() and use max() to handle jiffies
   subtraction.

5. ppp->npmode[] is updated via PPPIOCSNPMODE and read on TX/RX
   paths. Annotate with WRITE_ONCE() / READ_ONCE().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Qingfang Deng <qingfang.deng@linux.dev>
Cc: linux-ppp@vger.kernel.org
---
 drivers/net/ppp/ppp_generic.c | 50 ++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index ef54e0a0462a175bb989db8dda895e9ae755965f..cacc4c3a37d2cda0aea2e176e5d0638f959e18a3 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -810,7 +810,9 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case PPPIOCSMRU:
 		if (get_user(val, p))
 			break;
+		ppp_recv_lock(ppp);
 		ppp->mru = val;
+		ppp_recv_unlock(ppp);
 		err = 0;
 		break;
 
@@ -831,7 +833,9 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		break;
 
 	case PPPIOCGFLAGS:
+		ppp_lock(ppp);
 		val = ppp->flags | ppp->xstate | ppp->rstate;
+		ppp_unlock(ppp);
 		if (put_user(val, p))
 			break;
 		err = 0;
@@ -855,7 +859,7 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case PPPIOCSDEBUG:
 		if (get_user(val, p))
 			break;
-		ppp->debug = val;
+		WRITE_ONCE(ppp->debug, val);
 		err = 0;
 		break;
 
@@ -866,16 +870,16 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		break;
 
 	case PPPIOCGIDLE32:
-                idle32.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
-                idle32.recv_idle = (jiffies - ppp->last_recv) / HZ;
-                if (copy_to_user(argp, &idle32, sizeof(idle32)))
+		idle32.xmit_idle = max(0L, (long)(jiffies - READ_ONCE(ppp->last_xmit))) / HZ;
+		idle32.recv_idle = max(0L, (long)(jiffies - READ_ONCE(ppp->last_recv))) / HZ;
+		if (copy_to_user(argp, &idle32, sizeof(idle32)))
 			break;
 		err = 0;
 		break;
 
 	case PPPIOCGIDLE64:
-		idle64.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
-		idle64.recv_idle = (jiffies - ppp->last_recv) / HZ;
+		idle64.xmit_idle = max(0L, (long)(jiffies - READ_ONCE(ppp->last_xmit))) / HZ;
+		idle64.recv_idle = max(0L, (long)(jiffies - READ_ONCE(ppp->last_recv))) / HZ;
 		if (copy_to_user(argp, &idle64, sizeof(idle64)))
 			break;
 		err = 0;
@@ -916,7 +920,7 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			if (copy_to_user(argp, &npi, sizeof(npi)))
 				break;
 		} else {
-			ppp->npmode[i] = npi.mode;
+			WRITE_ONCE(ppp->npmode[i], npi.mode);
 			/* we may be able to transmit more packets now (??) */
 			netif_wake_queue(ppp->dev);
 		}
@@ -1454,7 +1458,7 @@ ppp_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto outf;
 
 	/* Drop, accept or reject the packet */
-	switch (ppp->npmode[npi]) {
+	switch (READ_ONCE(ppp->npmode[npi])) {
 	case NPMODE_PASS:
 		break;
 	case NPMODE_QUEUE:
@@ -1790,7 +1794,7 @@ ppp_prepare_tx_skb(struct ppp *ppp, struct sk_buff **pskb)
 		*(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_OUTBOUND_TAG);
 		if (ppp->pass_filter &&
 		    bpf_prog_run(ppp->pass_filter, skb) == 0) {
-			if (ppp->debug & 1)
+			if (READ_ONCE(ppp->debug) & 1)
 				netdev_printk(KERN_DEBUG, ppp->dev,
 					      "PPP: outbound frame "
 					      "not passed\n");
@@ -1800,11 +1804,11 @@ ppp_prepare_tx_skb(struct ppp *ppp, struct sk_buff **pskb)
 		/* if this packet passes the active filter, record the time */
 		if (!(ppp->active_filter &&
 		      bpf_prog_run(ppp->active_filter, skb) == 0))
-			ppp->last_xmit = jiffies;
+			WRITE_ONCE(ppp->last_xmit, jiffies);
 		skb_pull(skb, 2);
 #else
 		/* for data packets, record the time */
-		ppp->last_xmit = jiffies;
+		WRITE_ONCE(ppp->last_xmit, jiffies);
 #endif /* CONFIG_PPP_FILTER */
 	}
 
@@ -2154,7 +2158,7 @@ static int ppp_mp_explode(struct ppp *ppp, struct sk_buff *skb)
  noskb:
 	spin_unlock(&pch->downl);
  err_linearize:
-	if (ppp->debug & 1)
+	if (READ_ONCE(ppp->debug) & 1)
 		netdev_err(ppp->dev, "PPP: no memory (fragment)\n");
 	DEV_STATS_INC(ppp->dev, tx_errors);
 	++ppp->nxseq;
@@ -2502,7 +2506,7 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 			*(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_INBOUND_TAG);
 			if (ppp->pass_filter &&
 			    bpf_prog_run(ppp->pass_filter, skb) == 0) {
-				if (ppp->debug & 1)
+				if (READ_ONCE(ppp->debug) & 1)
 					netdev_printk(KERN_DEBUG, ppp->dev,
 						      "PPP: inbound frame "
 						      "not passed\n");
@@ -2511,14 +2515,14 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 			}
 			if (!(ppp->active_filter &&
 			      bpf_prog_run(ppp->active_filter, skb) == 0))
-				ppp->last_recv = jiffies;
+				WRITE_ONCE(ppp->last_recv, jiffies);
 			__skb_pull(skb, 2);
 		} else
 #endif /* CONFIG_PPP_FILTER */
-			ppp->last_recv = jiffies;
+			WRITE_ONCE(ppp->last_recv, jiffies);
 
 		if ((ppp->dev->flags & IFF_UP) == 0 ||
-		    ppp->npmode[npi] != NPMODE_PASS) {
+		    READ_ONCE(ppp->npmode[npi]) != NPMODE_PASS) {
 			kfree_skb(skb);
 		} else {
 			/* chop off protocol */
@@ -2771,7 +2775,7 @@ ppp_mp_reconstruct(struct ppp *ppp)
 			seq = seq_before(minseq, PPP_MP_CB(p)->sequence)?
 				minseq + 1: PPP_MP_CB(p)->sequence;
 
-			if (ppp->debug & 1)
+			if (READ_ONCE(ppp->debug) & 1)
 				netdev_printk(KERN_DEBUG, ppp->dev,
 					      "lost frag %u..%u\n",
 					      oldseq, seq-1);
@@ -2820,7 +2824,7 @@ ppp_mp_reconstruct(struct ppp *ppp)
 			struct sk_buff *tmp2;
 
 			skb_queue_reverse_walk_from_safe(list, p, tmp2) {
-				if (ppp->debug & 1)
+				if (READ_ONCE(ppp->debug) & 1)
 					netdev_printk(KERN_DEBUG, ppp->dev,
 						      "discarding frag %u\n",
 						      PPP_MP_CB(p)->sequence);
@@ -2842,7 +2846,7 @@ ppp_mp_reconstruct(struct ppp *ppp)
 			skb_queue_walk_safe(list, p, tmp) {
 				if (p == head)
 					break;
-				if (ppp->debug & 1)
+				if (READ_ONCE(ppp->debug) & 1)
 					netdev_printk(KERN_DEBUG, ppp->dev,
 						      "discarding frag %u\n",
 						      PPP_MP_CB(p)->sequence);
@@ -2850,7 +2854,7 @@ ppp_mp_reconstruct(struct ppp *ppp)
 				kfree_skb(p);
 			}
 
-			if (ppp->debug & 1)
+			if (READ_ONCE(ppp->debug) & 1)
 				netdev_printk(KERN_DEBUG, ppp->dev,
 					      "  missed pkts %u..%u\n",
 					      ppp->nextseq,
@@ -3161,7 +3165,8 @@ ppp_ccp_peek(struct ppp *ppp, struct sk_buff *skb, int inbound)
 			if (!ppp->rc_state)
 				break;
 			if (ppp->rcomp->decomp_init(ppp->rc_state, dp, len,
-					ppp->file.index, 0, ppp->mru, ppp->debug)) {
+						ppp->file.index, 0, ppp->mru,
+						READ_ONCE(ppp->debug))) {
 				ppp->rstate |= SC_DECOMP_RUN;
 				ppp->rstate &= ~(SC_DC_ERROR | SC_DC_FERROR);
 			}
@@ -3170,7 +3175,8 @@ ppp_ccp_peek(struct ppp *ppp, struct sk_buff *skb, int inbound)
 			if (!ppp->xc_state)
 				break;
 			if (ppp->xcomp->comp_init(ppp->xc_state, dp, len,
-					ppp->file.index, 0, ppp->debug))
+						  ppp->file.index, 0,
+						  READ_ONCE(ppp->debug)))
 				ppp->xstate |= SC_COMP_RUN;
 		}
 		break;
-- 
2.55.0.229.g6434b31f56-goog

