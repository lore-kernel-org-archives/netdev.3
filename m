Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD6A357CF3
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727760; cv=none; b=fRga/UwZ2EM02C0kWemtvLEiyhcwXrZg8UsrlsNtW3vS0yYbuIT6JF25NDOtnBu4hd7qj+QkCpTFgmEm1PUONg/vPyA94aud8lfAzVYe9QOCFCSoWqZa4qMcIZsdylodNgybKz7kD+gz3bm9VnwapkuVP9DoE+K0+lZZXMZ8r94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727760; c=relaxed/simple;
	bh=K9oDCxNi0xnKoPKPfKgLm5oHn5+WT3p+hx7vhoxAdl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldTCcxOYbXVhSouH/49A4y5yiC3/FgWvlzic/mzz2+jCDI7HDg0PwGroxT9gOUMIPkU8o8Zj5dlBOx0OPdo46EWxY69VIqhggybyVbmHWCMR64p03jXl7TvrvH+n6+pWflyT5MplxK/Pf7QKsUtfco7Asa9FmiN5ARpMYETlriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFPkVhSx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFPkVhSx"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso26292125e9.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 06:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784727756; x=1785332556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V1dOKUcwpUhtcAjpmeTJAswabzZD1izIB2KOWytWXtU=;
        b=dFPkVhSxCzpspMr2SEZHQuyAusXl485oQ3osRrDvUXHmKsRyX+ZTzCIqeJyisIY45C
         t0p7A+/phstnTMBDqUN/r/5VIK0JKlRYAntrScEMMnYv39uK5dmUZyI1CCFxKbbrO7xe
         r5XWUzIcxwqSdwfwq2XX0rOD4wqncVnZWXWVTFTu8SLW7hiDlPug3EdJ3MIk28QO+7yT
         5sID6L3T6XmPRybpwZvp/BUMIM5HqZKl1qJN8Fx9QwYwjHaMXpOVBr1CgfhwXvVTPk2R
         EPMXQ5Ot+sy3tbmiH7SU/0dgRRRbR6kcgikrn22zXzx9tyA/ZBvDzxFBhSLpoPqKxgX4
         PNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727756; x=1785332556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V1dOKUcwpUhtcAjpmeTJAswabzZD1izIB2KOWytWXtU=;
        b=sJCHiSunmwxe//0EdjE1wd/l7T1KRvglH48Rh7TL0D3i3BMDgbL6EhPmmZAUfX7zE0
         vYSOyYFsuEg0LqMBeN0+BKXNwmzSPgcG5dwU9qmjvnPHLIXGtexuUxJ2PWcKuQw5a59R
         5p4e6jQdB7KJNYuS18kdUVaGQvFGsdafqrVptta+T8KNJDhHB2z7vRLQLIQGyejZ9+Vw
         d+OU0zUTzZum5Pk2hpzRtUGLRXuqNkfMP1fa7kAz2mVV2nU0dSa7K0ANyMHqaco+iXps
         G3eVj2BklgWv/MW2mhJ15sBUKq9VTe803n5o6CH2Eh17CvLtvN7dxtMUOAsHGlYQhe1/
         2BAg==
X-Forwarded-Encrypted: i=1; AHgh+Rrg+GGHOLLxNYcNbokcjKS3WXFIFuWrrjUxANogcbU1igVpALUCT96pYDOEVPuY94wAgjdDEdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgU1GfHhHOyZeoZwHMV+mX8WK8lq1F46jwUuOb38kfSDA9joqK
	SZntLOH4pO4NEXE0aE6/eHhTNyMutWZLdCrc7V1L8Qmf4w06t3WG41uF
X-Gm-Gg: AR+sD104OW1jWkPQBOjndewbwHHjFB3hObfu0+SgQRrvtDg151fscWYfuSsXxxW6R58
	qAiwgumxgXTAMyx4tcEtCD0vSu9sz2fBb0zeryKTPED/N6tXAePg3WkzI8NuEe2m2BXwHTE1JmC
	prc57WGYRKa37LA4n0v/nRl0jMtpjSGUZOLWr9XP290WmlTZ+hVH2RxluLKCWt5Q9s/ebXFQtdF
	EhvtIrmG4GOcKhFkpUMJ/hFCAfx5ehCLYtLiWPJEFzmwP3Aa0nbXpIkkscOLRFInRffd649p0Y5
	wqYKBkFMutqh5NfkwRWb8aWFMj0u3cwKOuFDY3i54Hs4kgmsNKF2DjjHz3Yo6q4l1WlKjiUzWD7
	CkvMN+ayVIN1umLAdnDknlY//heF0gBuJmMZDDoFI9Zd93ntpWNZxZpm0e3YLrGRFOK10oka8/v
	Pn1KjrOhkJkJSqpYRXvEnp2wmwPzDr1wAnZPuKwiwDovkfAJbDNktWJIJDl80=
X-Received: by 2002:a05:600c:4687:b0:495:5845:fb2 with SMTP id 5b1f17b1804b1-495584510afmr190964425e9.38.1784727756263;
        Wed, 22 Jul 2026 06:42:36 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:c15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a63fb10sm73403015e9.13.2026.07.22.06.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:42:35 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@meta.com>
Subject: [PATCH io_uring-7.2 3/3] io_uring/zcrx: rename notif to event
Date: Wed, 22 Jul 2026 14:42:17 +0100
Message-ID: <f95ca6717da3c8d3649a1a7f0d883a563f545052.1784726895.git.asml.silence@gmail.com>
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

"Notification" is too long and the abbreviated version is used in
several places, which is inconsistent and more ambiguous for users.
Rename it to event, which is easier to keep consistent. To keep the
change small, only change uapi/ + do necessary fix ups, and the rest of
internals can be adjusted in the next release.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/uapi/linux/io_uring/query.h |  8 ++++----
 include/uapi/linux/io_uring/zcrx.h  | 28 +++++++++++++--------------
 io_uring/query.c                    |  8 ++++----
 io_uring/zcrx.c                     | 30 ++++++++++++++---------------
 io_uring/zcrx.h                     |  5 +++--
 5 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/include/uapi/linux/io_uring/query.h b/include/uapi/linux/io_uring/query.h
index 708bcdd585dd..e6493e4a7a4d 100644
--- a/include/uapi/linux/io_uring/query.h
+++ b/include/uapi/linux/io_uring/query.h
@@ -23,7 +23,7 @@ enum {
 	IO_URING_QUERY_OPCODES			= 0,
 	IO_URING_QUERY_ZCRX			= 1,
 	IO_URING_QUERY_SCQ			= 2,
-	IO_URING_QUERY_ZCRX_NOTIF		= 3,
+	IO_URING_QUERY_ZCRX_EVENT		= 3,
 
 	__IO_URING_QUERY_MAX,
 };
@@ -63,9 +63,9 @@ struct io_uring_query_zcrx {
 	__u64 __resv2;
 };
 
-struct io_uring_query_zcrx_notif {
-	/* Bitmask of supported ZCRX_NOTIF_* flags */
-	__u32 notif_flags;
+struct io_uring_query_zcrx_event {
+	/* Bitmask of supported ZCRX_EVENT_* flags */
+	__u32 event_flags;
 	/* Size of zcrx_stats */
 	__u32 stats_size;
 	/* Required alignment for the stats struct within the region (ie stats_offset) */
diff --git a/include/uapi/linux/io_uring/zcrx.h b/include/uapi/linux/io_uring/zcrx.h
index abb898d59a4b..e01bc0e34b24 100644
--- a/include/uapi/linux/io_uring/zcrx.h
+++ b/include/uapi/linux/io_uring/zcrx.h
@@ -65,19 +65,19 @@ enum zcrx_features {
 	 * value in struct io_uring_zcrx_ifq_reg::rx_buf_len.
 	 */
 	ZCRX_FEATURE_RX_PAGE_SIZE	= 1 << 0,
-	ZCRX_FEATURE_NOTIFICATION	= 1 << 1,
+	ZCRX_FEATURE_EVENT		= 1 << 1,
 };
 
-enum zcrx_notification_type {
-	ZCRX_NOTIF_ALLOC_FAIL,
-	ZCRX_NOTIF_COPY,
+enum zcrx_event_type {
+	ZCRX_EVENT_ALLOC_FAIL,
+	ZCRX_EVENT_COPY,
 
-	__ZCRX_NOTIF_TYPE_LAST,
+	__ZCRX_EVENT_TYPE_LAST,
 };
 
-enum zcrx_notification_desc_flags {
+enum zcrx_event_desc_flags {
 	/* If set, stats_offset holds a valid offset to a zcrx_stats struct */
-	ZCRX_NOTIF_DESC_FLAG_STATS = 1 << 0,
+	ZCRX_EVENT_DESC_FLAG_STATS = 1 << 0,
 };
 
 struct zcrx_stats {
@@ -85,10 +85,10 @@ struct zcrx_stats {
 	__u64	copy_bytes;	/* cumulative bytes copied */
 };
 
-struct zcrx_notification_desc {
+struct zcrx_event_desc {
 	__u64	user_data;
 	__u32	type_mask;
-	__u32	flags; /* see enum zcrx_notification_desc_flags */
+	__u32	flags; /* see enum zcrx_event_desc_flags */
 	__u64	stats_offset; /* offset from the beginning of refill ring region for stats */
 	__u64	__resv2[9];
 };
@@ -108,14 +108,14 @@ struct io_uring_zcrx_ifq_reg {
 	struct io_uring_zcrx_offsets offsets;
 	__u32	zcrx_id;
 	__u32	rx_buf_len;
-	__u64	notif_desc; /* see struct zcrx_notification_desc */
+	__u64	event_desc; /* see struct zcrx_event_desc */
 	__u64	__resv[2];
 };
 
 enum zcrx_ctrl_op {
 	ZCRX_CTRL_FLUSH_RQ,
 	ZCRX_CTRL_EXPORT,
-	ZCRX_CTRL_ARM_NOTIFICATION,
+	ZCRX_CTRL_ARM_EVENT,
 
 	__ZCRX_CTRL_LAST,
 };
@@ -129,8 +129,8 @@ struct zcrx_ctrl_export {
 	__u32 		__resv1[11];
 };
 
-struct zcrx_ctrl_arm_notif {
-	__u32		notif_type;
+struct zcrx_ctrl_arm_event {
+	__u32		event_type; /* see enum zcrx_event_type */
 	__u32		__resv[11];
 };
 
@@ -142,7 +142,7 @@ struct zcrx_ctrl {
 	union {
 		struct zcrx_ctrl_export		zc_export;
 		struct zcrx_ctrl_flush_rq	zc_flush;
-		struct zcrx_ctrl_arm_notif	zc_arm_notif;
+		struct zcrx_ctrl_arm_event	zc_arm_event;
 	};
 };
 
diff --git a/io_uring/query.c b/io_uring/query.c
index 2e48fddd8d3a..88a325736992 100644
--- a/io_uring/query.c
+++ b/io_uring/query.c
@@ -9,7 +9,7 @@
 union io_query_data {
 	struct io_uring_query_opcode opcodes;
 	struct io_uring_query_zcrx zcrx;
-	struct io_uring_query_zcrx_notif zcrx_notif;
+	struct io_uring_query_zcrx_event zcrx_notif;
 	struct io_uring_query_scq scq;
 };
 
@@ -47,9 +47,9 @@ static ssize_t io_query_zcrx(union io_query_data *data)
 
 static ssize_t io_query_zcrx_notif(union io_query_data *data)
 {
-	struct io_uring_query_zcrx_notif *e = &data->zcrx_notif;
+	struct io_uring_query_zcrx_event *e = &data->zcrx_notif;
 
-	e->notif_flags = ZCRX_NOTIF_TYPE_MASK;
+	e->event_flags = ZCRX_EVENT_TYPE_MASK;
 	e->stats_size = sizeof(struct zcrx_stats);
 	e->stats_off_alignment = __alignof__(struct zcrx_stats);
 	e->__resv1 = 0;
@@ -96,7 +96,7 @@ static int io_handle_query_entry(union io_query_data *data, void __user *uhdr,
 	case IO_URING_QUERY_ZCRX:
 		ret = io_query_zcrx(data);
 		break;
-	case IO_URING_QUERY_ZCRX_NOTIF:
+	case IO_URING_QUERY_ZCRX_EVENT:
 		ret = io_query_zcrx_notif(data);
 		break;
 	case IO_URING_QUERY_SCQ:
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 872d5794d3de..7d9fcf34539a 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -766,7 +766,7 @@ static int import_zcrx(struct io_ring_ctx *ctx,
 		return -EINVAL;
 	if (reg->if_rxq || reg->rq_entries || reg->area_ptr || reg->region_ptr)
 		return -EINVAL;
-	if (reg->notif_desc)
+	if (reg->event_desc)
 		return -EINVAL;
 	if (reg->flags & ~ZCRX_REG_IMPORT)
 		return -EINVAL;
@@ -855,7 +855,7 @@ static int zcrx_register_netdev(struct io_zcrx_ifq *ifq,
 
 static int zcrx_validate_notif_stats(struct io_zcrx_ifq *ifq,
 				     const struct io_uring_zcrx_ifq_reg *reg,
-				     const struct zcrx_notification_desc *notif)
+				     const struct zcrx_event_desc *notif)
 {
 	size_t stats_off = notif->stats_offset;
 	size_t used, end;
@@ -883,7 +883,7 @@ static int zcrx_validate_notif_stats(struct io_zcrx_ifq *ifq,
 int io_register_zcrx(struct io_ring_ctx *ctx,
 		     struct io_uring_zcrx_ifq_reg __user *arg)
 {
-	struct zcrx_notification_desc notif;
+	struct zcrx_event_desc notif;
 	struct io_uring_zcrx_area_reg area;
 	struct io_uring_zcrx_ifq_reg reg;
 	struct io_uring_region_desc rd;
@@ -928,14 +928,14 @@ int io_register_zcrx(struct io_ring_ctx *ctx,
 		return -EFAULT;
 
 	memset(&notif, 0, sizeof(notif));
-	if (reg.notif_desc && copy_from_user(&notif, u64_to_user_ptr(reg.notif_desc),
+	if (reg.event_desc && copy_from_user(&notif, u64_to_user_ptr(reg.event_desc),
 					     sizeof(notif)))
 		return -EFAULT;
-	if (notif.type_mask & ~ZCRX_NOTIF_TYPE_MASK)
+	if (notif.type_mask & ~ZCRX_EVENT_TYPE_MASK)
 		return -EINVAL;
-	if (notif.flags & ~ZCRX_NOTIF_DESC_FLAG_STATS)
+	if (notif.flags & ~ZCRX_EVENT_DESC_FLAG_STATS)
 		return -EINVAL;
-	if (!(notif.flags & ZCRX_NOTIF_DESC_FLAG_STATS)) {
+	if (!(notif.flags & ZCRX_EVENT_DESC_FLAG_STATS)) {
 		if (notif.stats_offset)
 			return -EINVAL;
 	}
@@ -970,7 +970,7 @@ int io_register_zcrx(struct io_ring_ctx *ctx,
 	if (ret)
 		goto err;
 
-	if (notif.flags & ZCRX_NOTIF_DESC_FLAG_STATS) {
+	if (notif.flags & ZCRX_EVENT_DESC_FLAG_STATS) {
 		ret = zcrx_validate_notif_stats(ifq, &reg, &notif);
 		if (ret)
 			goto err;
@@ -1244,7 +1244,7 @@ static netmem_ref io_pp_zc_alloc_netmems(struct page_pool *pp, gfp_t gfp)
 
 	allocated = io_zcrx_refill_slow(pp, ifq, netmems, to_alloc);
 	if (!allocated) {
-		zcrx_send_notif(ifq, ZCRX_NOTIF_ALLOC_FAIL);
+		zcrx_send_notif(ifq, ZCRX_EVENT_ALLOC_FAIL);
 		return 0;
 	}
 out_return:
@@ -1398,16 +1398,16 @@ static int zcrx_flush_rq(struct io_ring_ctx *ctx, struct io_zcrx_ifq *zcrx,
 static int zcrx_arm_notif(struct io_ring_ctx *ctx, struct io_zcrx_ifq *zcrx,
 			  struct zcrx_ctrl *ctrl)
 {
-	const struct zcrx_ctrl_arm_notif *an = &ctrl->zc_arm_notif;
+	const struct zcrx_ctrl_arm_event *an = &ctrl->zc_arm_event;
 	unsigned type_mask;
 
-	if (an->notif_type >= __ZCRX_NOTIF_TYPE_LAST)
+	if (an->event_type >= __ZCRX_EVENT_TYPE_LAST)
 		return -EINVAL;
 	if (!mem_is_zero(&an->__resv, sizeof(an->__resv)))
 		return -EINVAL;
 
 	guard(spinlock_bh)(&zcrx->ctx_lock);
-	type_mask = 1U << an->notif_type;
+	type_mask = 1U << an->event_type;
 	if (type_mask & ~zcrx->fired_notifs)
 		return -EINVAL;
 	zcrx->fired_notifs &= ~type_mask;
@@ -1420,7 +1420,7 @@ int io_zcrx_ctrl(struct io_ring_ctx *ctx, void __user *arg, unsigned nr_args)
 	struct io_zcrx_ifq *zcrx;
 
 	BUILD_BUG_ON(sizeof(ctrl.zc_export) != sizeof(ctrl.zc_flush));
-	BUILD_BUG_ON(sizeof(ctrl.zc_export) != sizeof(ctrl.zc_arm_notif));
+	BUILD_BUG_ON(sizeof(ctrl.zc_export) != sizeof(ctrl.zc_arm_event));
 
 	if (nr_args)
 		return -EINVAL;
@@ -1438,7 +1438,7 @@ int io_zcrx_ctrl(struct io_ring_ctx *ctx, void __user *arg, unsigned nr_args)
 		return zcrx_flush_rq(ctx, zcrx, &ctrl);
 	case ZCRX_CTRL_EXPORT:
 		return zcrx_export(ctx, zcrx, &ctrl, arg);
-	case ZCRX_CTRL_ARM_NOTIFICATION:
+	case ZCRX_CTRL_ARM_EVENT:
 		return zcrx_arm_notif(ctx, zcrx, &ctrl);
 	}
 
@@ -1584,7 +1584,7 @@ static int io_zcrx_copy_frag(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 			zcrx_stat_add(&ifq->notif_stats->copy_count, 1);
 			zcrx_stat_add(&ifq->notif_stats->copy_bytes, ret);
 		}
-		zcrx_send_notif(ifq, ZCRX_NOTIF_COPY);
+		zcrx_send_notif(ifq, ZCRX_EVENT_COPY);
 	}
 
 	return ret;
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index d16206eb9e30..c1005f23caff 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -10,8 +10,9 @@
 
 #define ZCRX_SUPPORTED_REG_FLAGS	(ZCRX_REG_IMPORT | ZCRX_REG_NODEV)
 #define ZCRX_FEATURES			(ZCRX_FEATURE_RX_PAGE_SIZE |\
-					 ZCRX_FEATURE_NOTIFICATION)
-#define ZCRX_NOTIF_TYPE_MASK		((1U << ZCRX_NOTIF_ALLOC_FAIL) | (1U << ZCRX_NOTIF_COPY))
+					 ZCRX_FEATURE_EVENT)
+#define ZCRX_EVENT_TYPE_MASK		((1U << ZCRX_EVENT_ALLOC_FAIL) |\
+					 (1U << ZCRX_EVENT_COPY))
 
 struct io_zcrx_mem {
 	unsigned long			size;
-- 
2.54.0

