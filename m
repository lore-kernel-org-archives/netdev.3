Received: from mail-dl2-f21.google.com (mail-dl2-f21.google.com [74.125.229.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01923E5A2B
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790517259; cv=none; b=O/nt5BZTA1N+LrHeVeOeRtR7AYGrWdEEZMpPu+VGScHRyT6fbZsEj/tvWwSEl7sSg54ZGBjsKyPLpENDAV196XTdxSUKsav3AmDrcWB8gPRrOWFcU/7J7INjNHNniz8bjpwYmr7+62twKm4Q/CEbwJYYEL564pikxtkDYiZdd5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790517259; c=relaxed/simple;
	bh=PM8dkF+8etKed18lFD/2Y9REotHc2O/UVajZjOn2QyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1t2tVR9zB2YSQy7sgTGKePNQv+4CILsG/2jybP757BDsSWh8tKM1tYAy44PpTHmHICCnvGvN9i9c2D8jzuDi+m+v7q4PrPN60Y+QK8v1jfdn3jervHokUjPIhGL2UvkTfDiOM33MbLWnzQOqpiIYZTPr3/H//7z/9mq2dqzAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQP83zJb; arc=none smtp.client-ip=74.125.229.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQP83zJb"
Received: by mail-dl2-f21.google.com with SMTP id a92af1059eb24-1438421d1f8so72475c88.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 06:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790517257; x=1791122057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ew/cE3p4ZACR2ABiKyvZI7K2codxGXMvh85xvLtScaU=;
        b=bQP83zJbvaHRkpOsgalkPL0RtTKuzVo9zZ6I4TMt4XnLdggSZQ1Q9qCqgaVW3Pvzra
         PzB8Zv++CIWn7gk4LZFDoaY1fcGgdMU8fpGVsQEBdUs4qGuiwzfoSanfNEhju/BG4LYu
         ezEc2R9KMXdHzfRRsZujNO1VluNgeeU4R72jQjA93ojagmjnnVO3zliMcAz21N3QtHIx
         7DyXmb1NQKxayxGXrQw+OzXIMRmNTgkTEAKGqXTkWCzYeeMb4KkmAeUvME6Jd0EBqAaX
         BpXsMJi5aoZQo4kiWQKaYQqn4dsqJQlWym2sQy+w+q0hl8IEbAh3asvnAxJY3QaL8wqy
         Yw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790517257; x=1791122057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ew/cE3p4ZACR2ABiKyvZI7K2codxGXMvh85xvLtScaU=;
        b=oSFTfbHuk1oQkHQZimCdLY1s/jtmqsMfk1ySLoyVAMP1dhS/yW+owMh/oSPHEuw+6C
         HpJ6pLbcfv1Db4Oe3DG2LFLkP3uvJEPVC/f7ltl9lPlWU1MQttaBn+y3TvYTLF/F/tFr
         tbHMM/6SPTsEVpA4VyPC2HE4ixXcXewYQPxxTjSK47uD9Cw4lkENnJEv08afM0Ohf5pD
         aT+OE44z+IkObWuKzeZ2/uwVFRAuaWgfeip5RC9hkxWCtucKUQywssuvMMcKn88f8gGi
         oqcQi8uAQhFgk3p2XwN6vdgKF03IMh3i69Yy+nXEWcTIIsYdVzVz9DmTkqtBSDh5/exN
         izFQ==
X-Gm-Message-State: AFuF++lQa6t+OlKOxgwtl34n+TjicHODzccHlmDBz83TC8kMX7ChMQdo
	9iD0Tlgt0XMNA6QX/l0CBz69L21bZ/uI0YyNMz5CARXyqfu/9NjvMttr
X-Gm-Gg: AYBFou0Wip/DK+bfCYi3JvgveK7TWwXgLQPBVSBoI4rUaaDVKK5WIz80kdwlANMLcuz
	CMEiR+4IUjE1DAkUQsiKidMQrIlOWX2OPc2/W58QjyM5XoSS8mL7VVSykS3ghYRVdKL/LGdwd2O
	dpCkOY6OcOeO1zOxmCmlnOzZB4kgb56qmA2RpbboxAe4t+2HIs6PhdvDfQ/biJ43I/LUcNnTt3V
	1jYe1mzRlGqQeVejESLQ1wuiYUVaAknLxqUz55hY4mIU8cYPDoK8qmbMtUuIgEmfLiRUQ0UHgw3
	qbGS040k2l3iZlC0gswmRzq+ISq0I6rgJvSwmXOFdvjK2pGIePgYAFP8LSaBd8SKM4x+JaaXwuo
	toPmC4EPE8fdPu1lE0nD7ABSAQRwVsSQVrlJ6iVLzyPh3Gwy/6JoNLYiGZS5ziAIedLkAAtCqtT
	CE6bXX7Ws4nPo9dRXuKtI9yILyRl25mfdBxyOkZ4XRkjeaT85RxFP65mWobXezTt7Ucy0Y2YfeI
	V9vOYF2g1yssw2x3qrLAJ+3YBO45jjb7TPAS0bQk8IVfF8qGNy3mjMdZlk1lPgAxBmbUDh30TpE
	/ufQ
X-Received: by 2002:a05:701b:4508:20b0:144:ff51:2d73 with SMTP id a92af1059eb24-146cfbd49d8mr9558498c88.2.1790517256737;
        Sun, 27 Sep 2026 06:54:16 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad4028a9sm16386411c88.11.2026.09.27.06.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 06:54:16 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH net-next v2] net: pktgen: return bool from __pktgen_NN_threads()
Date: Sun, 27 Sep 2026 21:54:05 +0800
Message-ID: <20260927135406.3969970-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers of __pktgen_NN_threads() only check whether a pktgen_dev was
found. Returning the pointer exposes it outside the helper even though
neither caller uses the object itself.

Return bool instead and keep the pktgen_dev pointer internal to the
helper.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v2:
- Rebase directly onto the current net-next tree, independently of the
  deferred RCU lifetime fix.
- Update the commit message for the current helper implementation.

Link: https://lore.kernel.org/netdev/20260825185313.239861-1-nicoyip.dev@gmail.com/ [v1]
---
 net/core/pktgen.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 7f81aed46672..a89cb0760821 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2024,11 +2024,11 @@ static const struct proc_ops pktgen_thread_proc_ops = {
 };
 
 /* Think find or remove for NN */
-static struct pktgen_dev *__pktgen_NN_threads(const struct pktgen_net *pn,
-					      const char *ifname, int remove)
+static bool __pktgen_NN_threads(const struct pktgen_net *pn,
+				const char *ifname, int remove)
 {
 	struct pktgen_thread *t;
-	struct pktgen_dev *pkt_dev = NULL;
+	struct pktgen_dev *pkt_dev;
 	bool exact = (remove == FIND);
 
 	list_for_each_entry(t, &pn->pktgen_threads, th_list) {
@@ -2038,10 +2038,10 @@ static struct pktgen_dev *__pktgen_NN_threads(const struct pktgen_net *pn,
 				pkt_dev->removal_mark = 1;
 				t->control |= T_REMDEV;
 			}
-			break;
+			return true;
 		}
 	}
-	return pkt_dev;
+	return false;
 }
 
 /*
@@ -2049,7 +2049,6 @@ static struct pktgen_dev *__pktgen_NN_threads(const struct pktgen_net *pn,
  */
 static void pktgen_mark_device(const struct pktgen_net *pn, const char *ifname)
 {
-	struct pktgen_dev *pkt_dev = NULL;
 	const int max_tries = 10, msec_per_try = 125;
 	int i = 0;
 
@@ -2058,8 +2057,7 @@ static void pktgen_mark_device(const struct pktgen_net *pn, const char *ifname)
 
 	while (1) {
 
-		pkt_dev = __pktgen_NN_threads(pn, ifname, REMOVE);
-		if (pkt_dev == NULL)
+		if (!__pktgen_NN_threads(pn, ifname, REMOVE))
 			break;	/* success */
 
 		mutex_unlock(&pktgen_thread_lock);
@@ -3835,8 +3833,7 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
 
 	/* We don't allow a device to be on several threads */
 
-	pkt_dev = __pktgen_NN_threads(t->net, ifname, FIND);
-	if (pkt_dev) {
+	if (__pktgen_NN_threads(t->net, ifname, FIND)) {
 		pr_err("ERROR: interface already used\n");
 		return -EBUSY;
 	}
-- 
2.43.0
