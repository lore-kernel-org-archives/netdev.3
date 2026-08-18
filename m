Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E2D45FFBB
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052067; cv=none; b=t3I45/l1w7d2mDK5shqFBV24Zk/ZeDdkNwjPIdK43hzT1/AuEsLdPlOGxyd0XNoFF9jJEYalCcjoVs90sod7PtPRchFBcoWx7XSAYu4cMGnUUiSYWjCVXp2AS9X74xc1MKpDzDRwjcF4rBqDD+tLXr76BqpEL7OWMx7GBF0VJCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052067; c=relaxed/simple;
	bh=oMl69QoTwidG8+9IbnUrxYh2/9sNNcenMME488S+qZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRXPqUkQeagboRHVnoIuzqisTKBZe8Yp1B2QXN/2oBqKhfRJaQN+jglM+fNLPZrtQwvH5bhG/ijD3I0UAZs6eIXJ2yenfnaTSAA70XMoJo/vAEisG7xzSUUKqDQFS+UgjJCPtnachFigjkMbE0JAVO8Y3I4fDbP9lXeGQwfAgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVL8fYmd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVL8fYmd"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4956869750eso30326095e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 04:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787052064; x=1787656864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Z0dzK4w68ythfmK6QEQnE8LmKloTewpTcrJwR2BUmM=;
        b=jVL8fYmd5MCt7SI9g+IjYrF7WyAXq04FvqQSeb8iGOXniVPUXzpq0v7fowfDKYZK7Y
         FXB/lf//FRMS0STuOCHVknrKhsclN56ZY06zc/dyBkiWdJ+1PcWIugLFV7MLet5zk0VK
         p1FVcGyigtIE+NalJIvbVbCmIcP4YRSaVSsRSaaoUZ1VYwe8sqInWMki+epe5yi0n+ST
         GDd/WnJ0IWiwGKAdpZGbMMJM+MTHC9QUJqtKeNeUbRvueB5gDPBWC+AbjrSctGFs8wpO
         akKn6A6W+Ru6p17yoMAhVkrmoMc6DkwGQmJiEBWMS5qPtg+Z005Rm5OrKs8txNgQCmFy
         3uJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787052064; x=1787656864;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Z0dzK4w68ythfmK6QEQnE8LmKloTewpTcrJwR2BUmM=;
        b=flfQCw4wAG0dpApfYFeFjAV5ugIyBsEuN2Whq2HpOn8dGYuYdNtHSlXokwod/TU2yR
         +J0gCqZozXLmmjgVGkphXhIuxT1K4/SySE0Ksz3dlKn/yzmMntDbt43Q05rVwkvFsXsr
         kCrIZGCeG/PAetjeH6pj65rFoM1KUOFjm8lowCQaNvfTw6wY8EWpMK8gJBgFK169vEJ8
         UUWmbRDilzvh4gnpWpDkrlt8KTyC5vhW0ap4RVvAJ1i0Hx52bFgYd4iTMtGt5hOOCSHo
         AYnqIi9h6C2dyTUrZ9jj+AxiHuumc+Lphl/sOgD5Pl+Imd6O8S0Os89N3uGdftNXMeZ8
         1Org==
X-Forwarded-Encrypted: i=1; AHgh+RrMF7NCqMSNvz3Q7U0org/2MptSp3Drb1MPWnaNDvl/VxEf89fuCHPiGylcNMavhBnJyvQrGnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhkPzsnvODnyKVXka0wDp+fV0Y8QxX500krU2Kwj2kGbelkBJ5
	ax+43Vws1yDxHqbk0aq+QG/7GUg4RHxWy7wvVvq1iAGhoenjrkcmh1mV
X-Gm-Gg: AR+sD12L83oN8bb/08e+/67wDjOiYogI0K1lWwhgG9c8lgeGGT+/DUPu8rdrif/9HKL
	Kr6+JJnHikIY5yL0daMdpJ4pT1M4KH40rzXgFTD4KCjeSmRL51/osATCjiKF6OJlK3sFYEErMtt
	tDJMaFUE3dE0dVf281Hx9rb/eKcpGrDLlkPyBzTEkls4V0Y0jEmRDEji16k44n7p/dBoIiBr3Dg
	ky2dAeQeOJPfrSb9CjGk5RlfMUygopSYW409H/cXxPgmTQTu+g9/5S9A1jTOmOC7xScqcg2tFYS
	N7rELMoTGEwtQMCHuqQLw0W8SZcyZZLTia6e32MzaPQrUfEe2YSiKYNmvTUWQ7ky6P8eB0JG47F
	RXLGq4xPSEchRYNWx8w+yl3mmkWXjcf1hDJylFzYngw19aAO3POcxTEFs/IEQU8xFwt+PjkjD+R
	ux/ZYjJXNT9MgJhtpUV/++WLVXZSNZyRZvd/y/b8Ilmrj+tYMK305asmuKi0o4qoBH3McO
X-Received: by 2002:a05:600c:3049:b0:499:781e:25fc with SMTP id 5b1f17b1804b1-4998792e359mr343515685e9.3.1787052063882;
        Tue, 18 Aug 2026 04:21:03 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d061637sm114096035e9.1.2026.08.18.04.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:21:03 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+d3bc2f2eb498a0175940@syzkaller.appspotmail.com
Subject: [PATCH v2] xfrm: fix suspicious RCU usage in xfrm_nlmsg_multicast
Date: Tue, 18 Aug 2026 14:20:24 +0300
Message-ID: <20260818112038.56788-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aoLLSiD7yjcaH_BI@secunet.com>
References: <aoLLSiD7yjcaH_BI@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

xfrm_nlmsg_multicast() dereferences net->xfrm.nlsk via
rcu_dereference() and is documented as requiring the RCU read
lock, but 11 of its 12 call sites in this file do not hold it.

Move the RCU read-side critical section inside
xfrm_nlmsg_multicast() itself instead of adding it to each call
site individually. This is safe: xfrm_get_translator() takes its
own nested RCU read lock internally, and nlmsg_multicast() is
called with GFP_ATOMIC, whose only conditional yield() in
netlink_broadcast_filtered() is gated on blocking being allowed,
which GFP_ATOMIC never permits.

The redundant rcu_read_lock()/rcu_read_unlock() pair in
xfrm_notify_userpolicy(), the one caller that already took the
lock, is removed accordingly.

Reported-by: syzbot+d3bc2f2eb498a0175940@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d3bc2f2eb498a0175940
Fixes: 21ee543edc0d ("xfrm: fix race between netns cleanup and state expire notification")
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
v2: Added Fixes: tag pointing to the commit that introduced
xfrm_nlmsg_multicast() and its RCU-locking contract, as requested
by Steffen.

 net/xfrm/xfrm_user.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d6db63304..1f683516f 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1622,31 +1622,35 @@ static struct sk_buff *xfrm_state_netlink(struct sk_buff *in_skb,
 }
 
 /* A wrapper for nlmsg_multicast() checking that nlsk is still available.
- * Must be called with RCU read lock.
+ * Takes the RCU read lock internally around the multicast.
  */
 static inline int xfrm_nlmsg_multicast(struct net *net, struct sk_buff *skb,
-				       u32 pid, unsigned int group)
+				      u32 pid, unsigned int group)
 {
-	struct sock *nlsk = rcu_dereference(net->xfrm.nlsk);
+	struct sock *nlsk;
 	struct xfrm_translator *xtr;
+	int err;
 
+	rcu_read_lock();
+	nlsk = rcu_dereference(net->xfrm.nlsk);
 	if (!nlsk) {
+		rcu_read_unlock();
 		kfree_skb(skb);
 		return -EPIPE;
 	}
-
 	xtr = xfrm_get_translator();
 	if (xtr) {
-		int err = xtr->alloc_compat(skb, nlmsg_hdr(skb));
-
+		err = xtr->alloc_compat(skb, nlmsg_hdr(skb));
 		xfrm_put_translator(xtr);
 		if (err) {
+			rcu_read_unlock();
 			kfree_skb(skb);
 			return err;
 		}
 	}
-
-	return nlmsg_multicast(nlsk, skb, pid, group, GFP_ATOMIC);
+	err = nlmsg_multicast(nlsk, skb, pid, group, GFP_ATOMIC);
+	rcu_read_unlock();
+	return err;
 }
 
 static inline unsigned int xfrm_spdinfo_msgsize(void)
@@ -2536,9 +2540,7 @@ static int xfrm_notify_userpolicy(struct net *net)
 
 	nlmsg_end(skb, nlh);
 
-	rcu_read_lock();
 	err = xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_POLICY);
-	rcu_read_unlock();
 
 	return err;
 }
-- 
2.55.0
