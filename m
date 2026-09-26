Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669426B742
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444266; cv=none; b=fTzmademETRdXHfqyqzUAXL0e46VjL0xYbPKqgv0TeK551EoVgePTNSKx6H02TGfgwa7MMIQ41nvMY7boflE6M3gidIFMEDV4oRqloLeHEHd9d8SUBTjte2knEWg2YqxQ7RMqUaXZ77hQHUojGJtWFKGfY7r9JBq2ChYVU2OllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444266; c=relaxed/simple;
	bh=APQg04EbOqw6WuFlMVIebqdDccEoyvB/T9cjBYBaxTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iv3vQZizCdVFgl7iC/lnIM4skRVpzKnDcSJVJABzL9ECEunC8rnn7Va7664p8DyCxeLv8Nb9tQVO/UG2w8Ksm7rIqfHRen+I65ocM2yXsBUOLI3kg/yN/POxJ8xSR/SAz2+iJqb8GDNMzd+geDZMbwu5hi5hZeQ6kehFt+Qmr4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRhbKj5Q; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRhbKj5Q"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-340f45daf45so185985eec.3
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790444264; x=1791049064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sj68eof1SkvaXluRfVn23Af/Irnh6iAg8HbyIE8d52k=;
        b=jRhbKj5QNfOK24sgjRLz3I8OstmuRr3oFb5aoA8RtXHo8TBZneNGRtdxJcglXYvT//
         Ru/VQdmzfY+YPvMjU5TdARZKK7aDvZpApRbd9fEo2dXoIrAFhlXuJa53/VQIRG4uu5wu
         0H6QAkmHVc32F3bshKtyj0oQphaRcduFSgP4Rxfiwmk+seqmTyqwHSOFwLSB1L1Wz01d
         YxusZ92Hkdt+r2xbWW6I2upH3YqUaXoHl/kuleJ9lQqSXtuN1nipPFvs2+3uPbcboMar
         m3U+0WPZ/QGTeM6CGg23GyYPzr5q8t0pUi/notOr0j8kyh4AsxeVpognPMsV4x02TmDw
         HdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790444264; x=1791049064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sj68eof1SkvaXluRfVn23Af/Irnh6iAg8HbyIE8d52k=;
        b=S+dk6JEehIm2pfGvFf521A4WAt9bgGtjkSOcoUQ+AxprX7j4vBf3po1XGjExhloIMU
         mEfpSyH4q8Cs16dNLaCoghvOg3z5M4hdGAueNHCVSiGgIs9mDAotxgX/mMduV5+7KF8l
         RwUR6/G4dpQfXhsPlafbnHDkKw9yJ7hLv7db1yxPVSP1IP7G5CAMHB0xB5j7YEzfTPEh
         /lTMfo22z3Avbfb1WNYMhfPVtClrubhtNsVUikpchqHIVNR4iEvBx/m/DoS2cUJsUmJT
         /gVTMcQR69tcOoZ0kEDPHZ44rELJ56cPvR3HcPCJQmZsg24EjFtInLvIOD15fK+Fv6tL
         EmDQ==
X-Gm-Message-State: AFq9FYKNMurK/FegSPIln82XK9RqBKrfkFSSj1YO//ExW9bNnNQ36o31
	jlV+W/GrdmpSRi8nnaXGqsOL8q2MwiQDlDiLSvxEvk09Fxhkkn+UVpNn
X-Gm-Gg: AYBFou0I16aNk+rPnpkB4bSkdEltefbYa19/2pWHAWN/nZ5gj0aW/9RRio+dzAKCw5P
	43iTHPXN6lL7ZbXCaRBnCRzbrv7zsSI+Qp/89XP8LqekaabazgdjMjPmaoJ4Q8OgvAekRQrgb4K
	4jarA/Otgpp5+59MkJQ9WauXuFiCFRIClRL/keMLy/Lfu6VstgziBm8zLfOue3YxES5KONfOMl5
	SvOGaGfR6yOPrlI7WYIDXeNDt9Fvt/vEB0h7SdomE1JMDwBpyq1RLNZP0cFmBN+eF+YrtFDTqFY
	tikjtCawjfASm0EFuHq1C7nU70pFmPIq6RevIsvtQruaXahm72utbeZYM/OTRgHqig8tFbqIadu
	LeA9wSEj2Tjlb3HA0pjvLGMBphUseYNQkI+Qs72klyMxoF2nXWLGuqbmB7EFngj6npLJXTlO9IO
	e9tVVSKBcHlezPs1g6lW5hLyFjaudQGTxx1Cwif13uMSEnDXi47Vco2i7ZRdKLAOysOLFu583B/
	/HTPDPhfLiuRl/B79NZzoKRNNsd7bF9iaZKyRGFnkrQ1WShPFa5TDf9Qfk0VT3n/w1Sdw==
X-Received: by 2002:a05:7300:cc93:b0:342:41f3:5b2f with SMTP id 5a478bee46e88-34271c886eemr5764166eec.2.1790444263607;
        Sat, 26 Sep 2026 10:37:43 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341460f5166sm17131257eec.29.2026.09.26.10.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:37:43 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH net] net: neighbour: Serialize proxy queue admission
Date: Sun, 27 Sep 2026 01:37:37 +0800
Message-ID: <20260926173737.2491492-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pneigh_enqueue() checks p->qlen before taking proxy_queue.lock, although
both enqueueing and the timer and purge paths update it under that lock.
The unlocked read races with those updates and allows concurrent proxy
ARP or NDP requests to bypass the queue's admission limit.

For example, CPU0 and CPU1 can both observe p->qlen == PROXY_QLEN before
either takes the lock. CPU0 then locks and enqueues, raising the count to
PROXY_QLEN + 1. CPU1 subsequently locks and enqueues using its stale
admission decision, raising the count to PROXY_QLEN + 2. The extra queued
packets consume memory until the timer or purge path removes them.

With a temporary 20 ms delay before locking and a queue-length assertion,
the kernel reported qlen=6 with PROXY_QLEN=4:

  WARNING: net/core/neighbour.c:1757 at pneigh_enqueue+0x4ee/0x650
  Call Trace:
   <IRQ>
   arp_process+0x1846/0x2060
   __netif_receive_skb_core.constprop.0+0x1524/0x2bd0
   __netif_receive_skb_one_core+0xa9/0x1b0
   process_backlog+0x1e5/0x5e0
   __napi_poll+0x9c/0x540
   net_rx_action+0x988/0xfb0
   handle_softirqs+0x18d/0x5b0
   do_softirq+0x3b/0x60
   </IRQ>

Move the existing lock acquisition before the admission check so that the
check and increment are serialized with all queue-length updates. Unlock
before freeing a rejected packet. Keep the existing > comparison so that
serial admission behavior is unchanged.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/core/neighbour.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 7448320f7ad5..e35ce26b4f8a 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1721,7 +1721,9 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
 {
 	unsigned long sched_next = neigh_proxy_delay(p);
 
+	spin_lock(&tbl->proxy_queue.lock);
 	if (p->qlen > NEIGH_VAR(p, PROXY_QLEN)) {
+		spin_unlock(&tbl->proxy_queue.lock);
 		kfree_skb(skb);
 		return;
 	}
@@ -1729,7 +1731,6 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
 	NEIGH_CB(skb)->sched_next = sched_next;
 	NEIGH_CB(skb)->flags |= LOCALLY_ENQUEUED;
 
-	spin_lock(&tbl->proxy_queue.lock);
 	if (timer_delete(&tbl->proxy_timer)) {
 		if (time_before(tbl->proxy_timer.expires, sched_next))
 			sched_next = tbl->proxy_timer.expires;
-- 
2.43.0

