Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B093469F6
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727756; cv=none; b=gnEzJHgrqnb27lyXRFTYYEz0HJih0O2E41NELDPDEhKb8KSX6MLM/mkATtpLWjpD6fpAuiMLINsTPD0dYHv+VB68ULtGmU3cUC0HODVgjlQVqJTF4vKZxoQl/Yci9UHDiHOeijjAqBv0Fs4rk9mTgLYxJ/OXNRIN1SEU+sClZ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727756; c=relaxed/simple;
	bh=unnADqaTU1dRYfmFaX+uucXakN3LWRA8pDHDO/e1y74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiTriM8w/1ItElSnjbYH772z2vOX439iGHHIQQt1IDitws6XMW1+rDyi0WEgow6OnohWsR48DJKYP/HD+ihHRY22orFPKIMOE7WB/7WsIhosEjerSq8wK5A8bfEh/liA/yFcuK/qmY6J+Oi/F5eDHyyc9FI1+pKRk1cRSGvqXeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+LnQTHm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+LnQTHm"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-472326ca506so9659137f8f.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 06:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784727753; x=1785332553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Z26QFDyzqFkZ51F4bjWLHBoSU2djhcQ9bvuZ8iw9R0=;
        b=i+LnQTHmaD4IvCZ3zb5jb/IkCBP3+yTOI5xzWaNDIgfCXOEf77ECamlS/lfuGUymRX
         p/M0CUEtm5/Go8v/XPRebhyU5IdMIBvPCJpdAz19BNxd/07/rUKSegxzTh1mpESLCuqf
         qitLMo1jzOlX8+BhPgZk71DGlUYh53h9NFaSuePMA/3UPqpNFPQZg36poNVfAdBRQoEK
         KowxbYAxKU8GWdbX7maQmOO0NWFaYE1rhTXS/e9xHcLAhPPbPK8I/3o4XkliATo6PiBr
         tlDpR6xFLGyRVOF+9uxHDpT/yM7nEzekymb0VZdSgPILI7WijZn45rVQCK6+cA5FNRtw
         OpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727753; x=1785332553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Z26QFDyzqFkZ51F4bjWLHBoSU2djhcQ9bvuZ8iw9R0=;
        b=DJRSOQ6WolH8/jVqnluQmGUEfiq/+jU11gmnl+mdW/ojtS2Wk21Si3G7lwWLc93BHo
         1OXyLduZp5o7G8aHKyctxnVApc3zkSY6c8cOnxkw41qgUDRbVdItThHR6YU2ApLG9LD3
         q3HqHHuc00UR3zH+9mA+sq/Zv5h/ckav30E4hGF/ZRH/97iT+yvH+hkzOvY1M/MRO2nb
         Mp6yVRUrRsetnoIy/cAVLkefadCdbvP82IA/0vjLkvU9wNIE74oB1O3ONfA6FCJwCf91
         rHsbwJgm/xWcAfOlTODgTRY380yFmuZip8HiLjbdgph6XPBEUxwaymWj/pZnIJUu84oU
         Sbzw==
X-Forwarded-Encrypted: i=1; AHgh+RoeVtl90bT/hObnE1aKn1DieVECDJPTTilMPb5lK8BZsOhBuyClvM65q6jYH+OffwxOd/yUQA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySXy4L+FwhTY4HVC53qiTvH6Smc6Tn2rjPSzqA4LipYQjCplQd
	w3zUkiVtAN6HxjQbFKNGxWQPyVpKSVhRh7RZLV1M76+Yu+ASDTeLAR8k
X-Gm-Gg: AR+sD126W8fyJnISNQRV5cbSDXOVZg8omWzAtVFNxHVdRlOHPJ02QBl5VHfUhWM0EKC
	IftpHTeMKsvMaLMWvJKrzaCO79TEn3O8PE/rU/sSg5dp6U71HMeJSAD/yJTkg1N1hbH5hVHVviK
	lziFvCCFJk0AKDrg13lH5EcDnJiBIwW2Kc1VRhDHewGi6p47PRKOdUMBdKLuh0UzsecBdjuK7zg
	/WXi1lJ1KHg81pl3cflfQ6fsS6+BL5x42LItmEQejFg2JQbiC86Y4jx/olq1gprxIgsSWg+Vy6v
	lXPWxm6n6bwr47UUIpCauoB3PMEma+evucH2e5YBLCyAueaB3nNqL2o6KFenxSlhgFDCWQJ34B6
	zqlfTzJvJEROioaCrIfTxhSA8pSPBBwzTjbzFy5SACfi+rK0pwe1Rjz+fgLFVoKH7TVuwk2T/X3
	JeM7HXJJc5pk5KDpUoLX6NAKsjojdG3LZ/R9io3pkPZxVu88cY8dKMmjJg/5yPo+IW0gCHQw==
X-Received: by 2002:a05:600c:4e8d:b0:495:54e9:c080 with SMTP id 5b1f17b1804b1-49554e9c2bbmr82960225e9.31.1784727752888;
        Wed, 22 Jul 2026 06:42:32 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:c15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a63fb10sm73403015e9.13.2026.07.22.06.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:42:32 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@meta.com>
Subject: [PATCH io_uring-7.2 1/3] io_uring/zcrx: drop "notif" from stats struct names
Date: Wed, 22 Jul 2026 14:42:15 +0100
Message-ID: <6a39676b6f71b67d3f89c6ebab7a3739873834a3.1784726895.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1784726895.git.asml.silence@gmail.com>
References: <cover.1784726895.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep zcrx statistics generic and don't stick "notif" to its uapi
definitions. Stats dosn't need to be bound to notification details,
it makes it cleaner and more readable.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/uapi/linux/io_uring/query.h | 6 +++---
 include/uapi/linux/io_uring/zcrx.h  | 4 ++--
 io_uring/query.c                    | 4 ++--
 io_uring/zcrx.c                     | 4 ++--
 io_uring/zcrx.h                     | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/io_uring/query.h b/include/uapi/linux/io_uring/query.h
index 1a68eca7c6b4..708bcdd585dd 100644
--- a/include/uapi/linux/io_uring/query.h
+++ b/include/uapi/linux/io_uring/query.h
@@ -66,10 +66,10 @@ struct io_uring_query_zcrx {
 struct io_uring_query_zcrx_notif {
 	/* Bitmask of supported ZCRX_NOTIF_* flags */
 	__u32 notif_flags;
-	/* Size of io_uring_zcrx_notif_stats */
-	__u32 notif_stats_size;
+	/* Size of zcrx_stats */
+	__u32 stats_size;
 	/* Required alignment for the stats struct within the region (ie stats_offset) */
-	__u32 notif_stats_off_alignment;
+	__u32 stats_off_alignment;
 	__u32 __resv1;
 	__u64 __resv2[4];
 };
diff --git a/include/uapi/linux/io_uring/zcrx.h b/include/uapi/linux/io_uring/zcrx.h
index 15c05c45ce36..99e56ec26ead 100644
--- a/include/uapi/linux/io_uring/zcrx.h
+++ b/include/uapi/linux/io_uring/zcrx.h
@@ -76,11 +76,11 @@ enum zcrx_notification_type {
 };
 
 enum zcrx_notification_desc_flags {
-	/* If set, stats_offset holds a valid offset to a notif_stats struct */
+	/* If set, stats_offset holds a valid offset to a zcrx_stats struct */
 	ZCRX_NOTIF_DESC_FLAG_STATS = 1 << 0,
 };
 
-struct zcrx_notif_stats {
+struct zcrx_stats {
 	__u64	copy_count;	/* cumulative copy-fallback CQEs */
 	__u64	copy_bytes;	/* cumulative bytes copied */
 };
diff --git a/io_uring/query.c b/io_uring/query.c
index d529d94aa8f4..2e48fddd8d3a 100644
--- a/io_uring/query.c
+++ b/io_uring/query.c
@@ -50,8 +50,8 @@ static ssize_t io_query_zcrx_notif(union io_query_data *data)
 	struct io_uring_query_zcrx_notif *e = &data->zcrx_notif;
 
 	e->notif_flags = ZCRX_NOTIF_TYPE_MASK;
-	e->notif_stats_size = sizeof(struct zcrx_notif_stats);
-	e->notif_stats_off_alignment = __alignof__(struct zcrx_notif_stats);
+	e->stats_size = sizeof(struct zcrx_stats);
+	e->stats_off_alignment = __alignof__(struct zcrx_stats);
 	e->__resv1 = 0;
 	memset(&e->__resv2, 0, sizeof(e->__resv2));
 	return sizeof(*e);
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 49163f9c39df..53dcb5110719 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -863,12 +863,12 @@ static int zcrx_validate_notif_stats(struct io_zcrx_ifq *ifq,
 	used = reg->offsets.rqes +
 	       sizeof(struct io_uring_zcrx_rqe) * reg->rq_entries;
 
-	if (!IS_ALIGNED(stats_off, __alignof__(struct zcrx_notif_stats)))
+	if (!IS_ALIGNED(stats_off, __alignof__(struct zcrx_stats)))
 		return -EINVAL;
 	if (stats_off < used)
 		return -ERANGE;
 	if (check_add_overflow(stats_off,
-			       sizeof(struct zcrx_notif_stats),
+			       	sizeof(struct zcrx_stats),
 			       &end))
 		return -ERANGE;
 	if (end > io_region_size(&ifq->rq_region))
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index fa00900e479e..a8d301b6191f 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -80,7 +80,7 @@ struct io_zcrx_ifq {
 	u32				allowed_notif_mask;
 	u32				fired_notifs;
 	u64				notif_data;
-	struct zcrx_notif_stats		*notif_stats;
+	struct zcrx_stats		*notif_stats;
 };
 
 #if defined(CONFIG_IO_URING_ZCRX)
-- 
2.54.0

