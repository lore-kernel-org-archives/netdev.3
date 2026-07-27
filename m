Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D10D233723
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 05:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785131316; cv=none; b=mqlEzozUoWgQP2kU64pvWWIgvqHWib+waiJgimb+2ymHP1IHU4X/wGe1B9RbTVy1s0rtb97ToRlH6FP4UMURfdCv2ONcVaDqogX7CCFM3/+hGEj+1ZQWkUDFbKsuDKm26Qdlmo2sNJ03rTyyi+rwS+l7ugaXYUVGowuA8s8s6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785131316; c=relaxed/simple;
	bh=jYdrv5aLTGoq6MVHdBhKqdOC5Emi1SDW6/+dotr+YZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ql8MKxFIf5Dj6xdn1KQGGNwc2Yc7sVjjHbGUgOn+E1Dww/NCR13TrGGR10I86XrR0809D8ybO/Tn3X+KMLPZq3gbJ0aVlNkeIroebAIpEMi4XjUO5XhN2qsMnCHEUZ3UXvrX1GTeHTrhYbzgmAco1hmNfsGae/7rL33OTElIXIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz2X8XPD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz2X8XPD"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84830c774a0so2239663b3a.1
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 22:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785131314; x=1785736114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+P1l48Cfs9m3W+Af7BHX+7RVWzaGG0yiwW8zKxNko4U=;
        b=Lz2X8XPD9+AHqeQIcC1509/bLaCOAFxFb6h0ySKu0EeVD7K6fJsOGNaOlnSl1O+Cez
         5kWkP+qVoAQewHIG08koik180zPsjxAygPumuEBRg6YF26bFbFs63I24yWtWk5lC/zNP
         UD6vXo8mSmtxW2s5XYt6G9UULKLOo8hWlW3a2XL+RV0cEvcLnjv2EbqYTtwdT7+DkhVw
         5psKigBPTecgTiQJI+KClrjrOX1cGeeR8iNU+FKLhs+wENm+aLEwG4gVFD6TcLMriIPQ
         uTRPEr+ul5ifklVmu+hC6YmU47LQAIbfy7WqqwHokthhiTphSrhIisFcyx8FLCB0pP68
         oddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785131314; x=1785736114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+P1l48Cfs9m3W+Af7BHX+7RVWzaGG0yiwW8zKxNko4U=;
        b=rJEG5brbFWHudC/2QJXKoe25loAdq1xGZsbSWfD56+rfCCOIrE+9r/jTqjyoixOtKV
         TL83UN08jsNvL7gZ6d3Um+NbZvhuZl8QJ0l+liIFabaACWRlpizg1E8zG4ZdDVn1dgGE
         7aZqp+AY/eat04MmG0OJfs9w1czHsvT5XPa3v4SM6+2YXefqQdsWM6TGtp6UyQ/Up1lS
         A9tUbYGiF6LWvdFFsDfVHQ0gNr/TODWh0Mas59rx1akreCpJvgBPDM+IqMe9nTWUydB5
         kcxl2gfXmHuiS/BuijKnG2sTdVuGttRfJ8RFYa9G3iOvUZqsjOdXovAsiLiGM1siN0SJ
         kOoQ==
X-Gm-Message-State: AOJu0Yw1fOAAM79imA/8rTlHyCa9J1ko/WPe0YWsmV8oCTYmmdAyKBtB
	MdlS9TT8SfftXbtCb7H+Z+rT+wNUoi+PgoBzacZzTj7ru5WegPbXC9dS4KWZ+3/4
X-Gm-Gg: AR+sD11fMw7ZFcUeILVY+vRk8eOvYL8de9xvdwUf8wugGsuCdoCnAoXWwhdJD2IExD5
	QGt2VbCA1irNQL3006BfVDLIOYxTh4IrI8NyAaWM5AJDf+j6XiVmnbbumAkvRsUruwYnbnhNBB6
	uyppsYf399ufUwZg0Vg12k5WwaeS42GwJ27TFEK2dqf1iJT2bXiumX9lxmNJsh8qUxS7TErSDqa
	2BSHQhYT2B7usqAGA/r3+1ABh5vscpAVnMzfxSlK2AaTRenxwEwAUKED3wxKj/9f3hoU0i2tkD/
	BneCetbLwuulRMV+LuMNZC6JsQbo/AGwVGkf5m6D2gKd9XPGVwlrgp/7dkge1HdLl7r2uKq/lrv
	vbTt+T2l2f3XsDp2leozpBs8EzxFEP0ZtrN0n+FS79ny04wengK5vYbOwriha/lSioFmaMGauwn
	imUU+havMKdzA=
X-Received: by 2002:aa7:88c9:0:b0:848:6dd1:8195 with SMTP id d2e1a72fcca58-84e5947debfmr5484549b3a.34.1785131314448;
        Sun, 26 Jul 2026 22:48:34 -0700 (PDT)
Received: from gmail.com ([140.123.97.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5346dc8bsm2514476b3a.61.2026.07.26.22.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 22:48:34 -0700 (PDT)
From: ArBin <eric91102091@gmail.com>
To: netdev@vger.kernel.org
Cc: 3chas3@gmail.com,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Xiang-Bin Shi <eric91102091@gmail.com>
Subject: [PATCH net-next] atm: remove unused exported helpers
Date: Mon, 27 Jul 2026 13:45:38 +0800
Message-Id: <20260727054538.196437-1-eric91102091@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiang-Bin Shi <eric91102091@gmail.com>

Commit 6deb53595092 ("net: remove unused ATM protocols and legacy
ATM device drivers") removed the remaining in-tree users of
atm_alloc_charge(), atm_pcr_goal(), sonet_copy_stats() and
sonet_subtract_stats().

Remove these unused exported helpers and their declarations. The
removal of the SONET statistics helpers also leaves
include/linux/sonet.h without users, so remove the internal header and
its MAINTAINERS entry.

Signed-off-by: Xiang-Bin Shi <eric91102091@gmail.com>
---
 MAINTAINERS            |  1 -
 include/linux/atmdev.h |  3 --
 include/linux/sonet.h  | 20 -----------
 net/atm/atm_misc.c     | 79 ------------------------------------------
 4 files changed, 103 deletions(-)
 delete mode 100644 include/linux/sonet.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 60cff00953dc..e7ebe79843cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4279,7 +4279,6 @@ W:	http://linux-atm.sourceforge.net
 F:	drivers/atm/
 F:	drivers/usb/atm/
 F:	include/linux/atm*
-F:	include/linux/sonet.h
 F:	include/uapi/linux/atm*
 F:	include/uapi/linux/sonet.h
 F:	net/atm/
diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index fe21d2f547b5..92c2e20e7416 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -229,9 +229,6 @@ static inline void atm_dev_put(struct atm_dev *dev)
 
 
 int atm_charge(struct atm_vcc *vcc,int truesize);
-struct sk_buff *atm_alloc_charge(struct atm_vcc *vcc,int pdu_size,
-    gfp_t gfp_flags);
-int atm_pcr_goal(const struct atm_trafprm *tp);
 
 void vcc_release_async(struct atm_vcc *vcc, int reply);
 
diff --git a/include/linux/sonet.h b/include/linux/sonet.h
deleted file mode 100644
index 2b802b6d12ad..000000000000
--- a/include/linux/sonet.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* sonet.h - SONET/SHD physical layer control */
-#ifndef LINUX_SONET_H
-#define LINUX_SONET_H
-
-
-#include <linux/atomic.h>
-#include <uapi/linux/sonet.h>
-
-struct k_sonet_stats {
-#define __HANDLE_ITEM(i) atomic_t i
-	__SONET_ITEMS
-#undef __HANDLE_ITEM
-};
-
-extern void sonet_copy_stats(struct k_sonet_stats *from,struct sonet_stats *to);
-extern void sonet_subtract_stats(struct k_sonet_stats *from,
-    struct sonet_stats *to);
-
-#endif
diff --git a/net/atm/atm_misc.c b/net/atm/atm_misc.c
index a30b83c1cb3f..c9d7609da184 100644
--- a/net/atm/atm_misc.c
+++ b/net/atm/atm_misc.c
@@ -7,7 +7,6 @@
 #include <linux/atm.h>
 #include <linux/atmdev.h>
 #include <linux/skbuff.h>
-#include <linux/sonet.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/atomic.h>
@@ -22,81 +21,3 @@ int atm_charge(struct atm_vcc *vcc, int truesize)
 	return 0;
 }
 EXPORT_SYMBOL(atm_charge);
-
-struct sk_buff *atm_alloc_charge(struct atm_vcc *vcc, int pdu_size,
-				 gfp_t gfp_flags)
-{
-	struct sock *sk = sk_atm(vcc);
-	int guess = SKB_TRUESIZE(pdu_size);
-
-	atm_force_charge(vcc, guess);
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf) {
-		struct sk_buff *skb = alloc_skb(pdu_size, gfp_flags);
-
-		if (skb) {
-			atomic_add(skb->truesize-guess,
-				   &sk->sk_rmem_alloc);
-			return skb;
-		}
-	}
-	atm_return(vcc, guess);
-	atomic_inc(&vcc->stats->rx_drop);
-	return NULL;
-}
-EXPORT_SYMBOL(atm_alloc_charge);
-
-
-/*
- * atm_pcr_goal returns the positive PCR if it should be rounded up, the
- * negative PCR if it should be rounded down, and zero if the maximum available
- * bandwidth should be used.
- *
- * The rules are as follows (* = maximum, - = absent (0), x = value "x",
- * (x+ = x or next value above x, x- = x or next value below):
- *
- *	min max pcr	result		min max pcr	result
- *	-   -   -	* (UBR only)	x   -   -	x+
- *	-   -   *	*		x   -   *	*
- *	-   -   z	z-		x   -   z	z-
- *	-   *   -	*		x   *   -	x+
- *	-   *   *	*		x   *   *	*
- *	-   *   z	z-		x   *   z	z-
- *	-   y   -	y-		x   y   -	x+
- *	-   y   *	y-		x   y   *	y-
- *	-   y   z	z-		x   y   z	z-
- *
- * All non-error cases can be converted with the following simple set of rules:
- *
- *   if pcr == z then z-
- *   else if min == x && pcr == - then x+
- *     else if max == y then y-
- *	 else *
- */
-
-int atm_pcr_goal(const struct atm_trafprm *tp)
-{
-	if (tp->pcr && tp->pcr != ATM_MAX_PCR)
-		return -tp->pcr;
-	if (tp->min_pcr && !tp->pcr)
-		return tp->min_pcr;
-	if (tp->max_pcr != ATM_MAX_PCR)
-		return -tp->max_pcr;
-	return 0;
-}
-EXPORT_SYMBOL(atm_pcr_goal);
-
-void sonet_copy_stats(struct k_sonet_stats *from, struct sonet_stats *to)
-{
-#define __HANDLE_ITEM(i) to->i = atomic_read(&from->i)
-	__SONET_ITEMS
-#undef __HANDLE_ITEM
-}
-EXPORT_SYMBOL(sonet_copy_stats);
-
-void sonet_subtract_stats(struct k_sonet_stats *from, struct sonet_stats *to)
-{
-#define __HANDLE_ITEM(i) atomic_sub(to->i, &from->i)
-	__SONET_ITEMS
-#undef __HANDLE_ITEM
-}
-EXPORT_SYMBOL(sonet_subtract_stats);
-- 
2.34.1

