Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4083403F4
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673728; cv=none; b=kUte5lmrR3Z33XRy8USCysYkekEKoI3kZOh+BG/7MpnPqCmHN2uYEnW+yUizA/ShAciuELcZphpn1dospzdXM4ZwsCbiam9pV3ediY0FVWqMDv12JH4lF8//vikdRmeZu8UH9hzxewepEhHm8AevmyrsfQnGj3IreHsjVAhdFLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673728; c=relaxed/simple;
	bh=pY5j+Vq+5LkAJlmQoSIKrUXCOS3FlYHbpzp5tKBSp8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EZWJNepfodRQ/QdEhsXcm2+x1WxGsbya/uqzMgSJTuTaTqqoT+tP8Hwzn0dPgbZx7cps+ppvaoK4iCL0Tgytzuo4oFmx/Xn5GodAGty1v5UWJSDSsHf+9xPdVIuI2HyixmBca9i9vkj2nKE4JG0Mc7z2fx5PjtKFavGwHC8ZpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LWWaNvD5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LWWaNvD5"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c20fb91ed0fso770685666b.3
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787673724; x=1788278524; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fKeiEayzkO9Rp9j6kUWzKZyRL+GV+bNNS+hHBCkwNcM=;
        b=LWWaNvD5y/ZQv3fqAtPNP1AhmftS8HoXjvjnv5DAsJXOawsXjJa16DjqQZm9rEWIpb
         kUeRKNgP++snh49E4m5RwJGW67d/rMplctAxV/CPKsv3tSmM2qgTpN6rmegXQ3bfIvLb
         twpgMEsR609g/YXcRLzOpFQLGSHStr6s+fHSxxlFTRe4LShcQpLVIU94nS/ruH7B7pE4
         3Dz3D+O7uz7uI6W6AvzqDgLYRfmDeTnit8j/jxxI4SnkMqceHsWFoA6PEgChTjxiGRiZ
         /FRac9X7FIomzrGXEyBC79kYgsXlFYwV7ZpZb7UYaAZP4J48jFRBJcuHEEFqMKeG/iq7
         ENjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787673724; x=1788278524;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fKeiEayzkO9Rp9j6kUWzKZyRL+GV+bNNS+hHBCkwNcM=;
        b=B+4gnHQI9kY7JpgOWXE5fKs8GKwWpatT3pbQVnJy88JmYBS6rNKzh1i9ezjtWbMxPE
         pHu6KIFXZjK7FuEEgFw17o7HrWOr8FVg1zlwWJc6m2qd6Jk0Bq8AwYhBv5TeYI98i8y9
         kndMjQlGs6NCVShjRG8zokepjy0X6Fa8Jx8AqN6Yf+nhNanHbA1wt2DZ85u3pbb0VBf/
         1Ltllo7LMSNBSMcc80NylTJx1PSKkD6A6SN6I87AbMYByl9UStydIzRh27HWuOoA/MQT
         wbWhPwGlCy92MQRNCoZSGSCMv50zyt74VqryLxvkJ+qc60CuVJFsg6DhBHJFgIZqQITu
         Q+Aw==
X-Gm-Message-State: AFuF++lJbMrUzS2JMZz5+IeUiksHWIFvFk/d8TqF1kGOCaOrcPa9zL+8
	s6U8VgeII3TYiYppBJ/A7Ff4mlhb4RwzDoQ1ifladmSplf8DlNBwKO/GKq4egctWZ18Xe/vZygV
	96+2JhLQ=
X-Gm-Gg: AR+sD12HxoerwCztIRCpXcX4UIpx3dGmfEYnuLGloJb3QSA4zC7uB3+gog6zBKCMIMD
	LUDWdFFHYvo8bArioBSNSONnpapyLPTZxz07CI4nVqu2UlJGI1z8XvUyJodjuTdmFV+VTCUuaV+
	Sd3fIp5+weLtQOSqiAMzc1572ucvlXmuWPz8EjnWryN2M/LjXk9fc/EJQA7YpusLrxp/wJG7wW7
	om4taY6ic160nOrn/sB9LukpfywNLOVahSKo2At6urruUmINZu91D5d5Fp9c6jMxJxDeQi8EUW7
	ubiEqY2/esXNMuA5A2EwemV4juJnjgHhAQ6L5+P50CGTkzqBLPOrltWjtVQ3cvp7Z3vxdc69M4l
	aLEkJC7pqMiIoGa2ha74OHyHWiMxJ+XDBrHmZWoOCa4FMU73Oo6Qmw5EdCpbWPjpMtRpWTEDBVX
	Z5la97vxAcG4u6k34ytvQYQiRNzS05CfhK2VgOkOf0ebIa0Pqvos6YOHvPVjD4bTmtnqi1OswXO
	WDIekZFi7vWvRog2ccIUuPqEbVzUEbj5A7ATy2m
X-Received: by 2002:a17:906:a353:10b0:c1c:5c90:1bb0 with SMTP id a640c23a62f3a-c246a353d2emr2883200466b.8.1787673724141;
        Tue, 25 Aug 2026 09:02:04 -0700 (PDT)
Received: from cloudflare.com (79.184.120.97.ipv4.supernova.orange.pl. [79.184.120.97])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5dea8388fsm337390a12.19.2026.08.25.09.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 09:02:03 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 25 Aug 2026 18:01:50 +0200
Subject: [PATCH RFC net-next] net: Use fixed slots for skb extensions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-rfc-skb-ext-fixed-offsets-v1-1-8050ff33bec9@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAG28jWoC/yWMQQrCMBRErxL+2g81tNG6FTyA2+LCpBONQir5s
 RRK726Cy8fMeysJUoDQSa2UMAcJUyyw3ylyz3t8gMNYmHSjTXPUHSfvWN6WsWT2YcHIk/eCLOz
 aVhtrukOPnor/SaiH2h7oejmriMyxeHT7r/K1L7hc87RtP7VnrWuLAAAA
X-Change-ID: 20260825-rfc-skb-ext-fixed-offsets-c4426b6579e9
To: netdev@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>, 
 Steffen Klassert <steffen.klassert@secunet.com>, kernel-team@cloudflare.com
X-Mailer: b4 0.16.0

Replace the dynamic skb extension allocator (->chunks + per-object offset[]
array) with fixed per-id slots with offsets computed at compile time.

The runtime-computed offsets seem to be a leftover from the initial
posting [1], where skb_ext memory was reallocated when a new extension was
activated.

This can make extension delete-then-re-add unsafe, as pointed out by
Sashiko [2]: with bump allocation, re-adding an extension appends a second
copy, eventually overflowing the skb_ext chunks area.

While this does not happen today, because all extensions get dropped on skb
scrub, the BPF metadata skb extension work aims to preserve an extension
across skb scrubbing, which opens the door to this scenario.

[1] https://lore.kernel.org/all/20181210145006.19098-3-fw@strlen.de/
[2] https://lore.kernel.org/all/20260815081452.0DB521F00A3E@smtp.kernel.org/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
I'm not sure if there is another easy alternative. Moving the skb ext
chunks around to close the gaps would involve making sure that nobody is
holding a pointer to them. Looking for feedback & ideas.
---
 include/linux/skbuff.h | 72 ++++++++++++++++++++++++++++++++-----------
 net/core/skbuff.c      | 83 +++++++++++++++++++-------------------------------
 2 files changed, 85 insertions(+), 70 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 95184183180f..5a5143e47b30 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5011,45 +5011,81 @@ static inline void skb_set_nfct(struct sk_buff *skb, unsigned long nfct)
 }
 
 #ifdef CONFIG_SKB_EXTENSIONS
-enum skb_ext_id {
+
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
-	SKB_EXT_BRIDGE_NF,
+#define SKB_EXT_X_BRIDGE_NF	X(SKB_EXT_BRIDGE_NF, struct nf_bridge_info)
+#else
+#define SKB_EXT_X_BRIDGE_NF
 #endif
-#ifdef CONFIG_XFRM
-	SKB_EXT_SEC_PATH,
+
+#if IS_ENABLED(CONFIG_XFRM)
+#define SKB_EXT_X_SEC_PATH	X(SKB_EXT_SEC_PATH, struct sec_path)
+#else
+#define SKB_EXT_X_SEC_PATH
 #endif
+
 #if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
-	TC_SKB_EXT,
+#define SKB_EXT_X_TC		X(TC_SKB_EXT, struct tc_skb_ext)
+#else
+#define SKB_EXT_X_TC
 #endif
+
 #if IS_ENABLED(CONFIG_MPTCP)
-	SKB_EXT_MPTCP,
+#define SKB_EXT_X_MPTCP		X(SKB_EXT_MPTCP, struct mptcp_ext)
+#else
+#define SKB_EXT_X_MPTCP
 #endif
+
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
-	SKB_EXT_MCTP,
+#define SKB_EXT_X_MCTP		X(SKB_EXT_MCTP, struct mctp_flow)
+#else
+#define SKB_EXT_X_MCTP
 #endif
+
 #if IS_ENABLED(CONFIG_INET_PSP)
-	SKB_EXT_PSP,
+#define SKB_EXT_X_PSP		X(SKB_EXT_PSP, struct psp_skb_ext)
+#else
+#define SKB_EXT_X_PSP
 #endif
+
 #if IS_ENABLED(CONFIG_CAN)
-	SKB_EXT_CAN,
+#define SKB_EXT_X_CAN		X(SKB_EXT_CAN, struct can_skb_ext)
+#else
+#define SKB_EXT_X_CAN
 #endif
-	SKB_EXT_NUM, /* must be last */
+
+#define SKB_EXT_FOREACH(X)	\
+	SKB_EXT_X_BRIDGE_NF	\
+	SKB_EXT_X_SEC_PATH	\
+	SKB_EXT_X_TC		\
+	SKB_EXT_X_MPTCP		\
+	SKB_EXT_X_MCTP		\
+	SKB_EXT_X_PSP		\
+	SKB_EXT_X_CAN
+
+enum skb_ext_id {
+#define X(id, type)	id,
+	SKB_EXT_FOREACH(X)
+#undef X
+	SKB_EXT_NUM,
 };
 
+extern const u8 skb_ext_offset[SKB_EXT_NUM];
+
 /**
  *	struct skb_ext - sk_buff extensions
  *	@refcnt: 1 on allocation, deallocated on 0
- *	@offset: offset to add to @data to obtain extension address
- *	@chunks: size currently allocated, stored in SKB_EXT_ALIGN_SHIFT units
+ *	@present_extensions: bitmap of extensions stored in @data
  *	@data: start of extension data, variable sized
  *
- *	Note: offsets/lengths are stored in chunks of 8 bytes, this allows
- *	to use 'u8' types while allowing up to 2kb worth of extension data.
+ *	Each extension id occupies a fixed slot within @data, located at
+ *	skb_ext_offset[id] chunks of 8 bytes. Storing offsets/lengths
+ *	in 8-byte chunks allows 'u8' types while allowing up to 2kb worth
+ *	of extension data.
  */
 struct skb_ext {
 	refcount_t refcnt;
-	u8 offset[SKB_EXT_NUM]; /* in chunks of 8 bytes */
-	u8 chunks;		/* same */
+	u8 present_extensions;
 	char data[] __aligned(8);
 };
 
@@ -5087,7 +5123,7 @@ static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_buff *src)
 
 static inline bool __skb_ext_exist(const struct skb_ext *ext, enum skb_ext_id i)
 {
-	return !!ext->offset[i];
+	return ext->present_extensions & (1 << i);
 }
 
 static inline bool skb_ext_exist(const struct sk_buff *skb, enum skb_ext_id id)
@@ -5106,7 +5142,7 @@ static inline void *skb_ext_find(const struct sk_buff *skb, enum skb_ext_id id)
 	if (skb_ext_exist(skb, id)) {
 		struct skb_ext *ext = skb->extensions;
 
-		return (void *)ext + (ext->offset[id] << 3);
+		return (void *)ext + (skb_ext_offset[id] << 3);
 	}
 
 	return NULL;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c82a1472a5ea..8e5db579725d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5134,47 +5134,32 @@ EXPORT_SYMBOL_GPL(skb_segment);
 #define SKB_EXT_CHUNKSIZEOF(x)	(ALIGN((sizeof(x)), SKB_EXT_ALIGN_VALUE) / SKB_EXT_ALIGN_VALUE)
 
 static const u8 skb_ext_type_len[] = {
-#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
-	[SKB_EXT_BRIDGE_NF] = SKB_EXT_CHUNKSIZEOF(struct nf_bridge_info),
-#endif
-#ifdef CONFIG_XFRM
-	[SKB_EXT_SEC_PATH] = SKB_EXT_CHUNKSIZEOF(struct sec_path),
-#endif
-#if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
-	[TC_SKB_EXT] = SKB_EXT_CHUNKSIZEOF(struct tc_skb_ext),
-#endif
-#if IS_ENABLED(CONFIG_MPTCP)
-	[SKB_EXT_MPTCP] = SKB_EXT_CHUNKSIZEOF(struct mptcp_ext),
-#endif
-#if IS_ENABLED(CONFIG_MCTP_FLOWS)
-	[SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
-#endif
-#if IS_ENABLED(CONFIG_INET_PSP)
-	[SKB_EXT_PSP] = SKB_EXT_CHUNKSIZEOF(struct psp_skb_ext),
-#endif
-#if IS_ENABLED(CONFIG_CAN)
-	[SKB_EXT_CAN] = SKB_EXT_CHUNKSIZEOF(struct can_skb_ext),
-#endif
+#define X(id, type)	[id] = SKB_EXT_CHUNKSIZEOF(type),
+	SKB_EXT_FOREACH(X)
+#undef X
 };
 
-static __always_inline __no_profile unsigned int skb_ext_total_length(void)
-{
-	unsigned int l = SKB_EXT_CHUNKSIZEOF(struct skb_ext);
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(skb_ext_type_len); i++)
-		l += skb_ext_type_len[i];
+struct skb_ext_layout {
+	u8	header[sizeof(struct skb_ext)] __aligned(SKB_EXT_ALIGN_VALUE);
+#define X(id, type)	type f_##id __aligned(SKB_EXT_ALIGN_VALUE);
+	SKB_EXT_FOREACH(X)
+#undef X
+};
 
-	return l;
-}
+const u8 skb_ext_offset[SKB_EXT_NUM] = {
+#define X(id, type)	[id] = offsetof(struct skb_ext_layout, f_##id) / SKB_EXT_ALIGN_VALUE,
+	SKB_EXT_FOREACH(X)
+#undef X
+};
+EXPORT_SYMBOL(skb_ext_offset);
 
 static noinline void __init __no_profile skb_extensions_init(void)
 {
 	BUILD_BUG_ON(SKB_EXT_NUM > 8);
-	BUILD_BUG_ON(skb_ext_total_length() > 255);
+	BUILD_BUG_ON(sizeof(struct skb_ext_layout) > 255 * SKB_EXT_ALIGN_VALUE);
 
 	skbuff_ext_cache = kmem_cache_create("skbuff_ext_cache",
-					     SKB_EXT_ALIGN_VALUE * skb_ext_total_length(),
+					     sizeof(struct skb_ext_layout),
 					     0,
 					     SLAB_HWCACHE_ALIGN|SLAB_PANIC,
 					     NULL);
@@ -7083,7 +7068,7 @@ EXPORT_SYMBOL(skb_condense);
 #ifdef CONFIG_SKB_EXTENSIONS
 static void *skb_ext_get_ptr(struct skb_ext *ext, enum skb_ext_id id)
 {
-	return (void *)ext + (ext->offset[id] * SKB_EXT_ALIGN_VALUE);
+	return (void *)ext + (skb_ext_offset[id] * SKB_EXT_ALIGN_VALUE);
 }
 
 /**
@@ -7100,7 +7085,7 @@ struct skb_ext *__skb_ext_alloc(gfp_t flags)
 	struct skb_ext *new = kmem_cache_alloc(skbuff_ext_cache, flags);
 
 	if (new) {
-		memset(new->offset, 0, sizeof(new->offset));
+		new->present_extensions = 0;
 		refcount_set(&new->refcnt, 1);
 	}
 
@@ -7111,6 +7096,7 @@ static struct skb_ext *skb_ext_maybe_cow(struct skb_ext *old,
 					 unsigned int old_active)
 {
 	struct skb_ext *new;
+	int i;
 
 	if (refcount_read(&old->refcnt) == 1)
 		return old;
@@ -7119,7 +7105,12 @@ static struct skb_ext *skb_ext_maybe_cow(struct skb_ext *old,
 	if (!new)
 		return NULL;
 
-	memcpy(new, old, old->chunks * SKB_EXT_ALIGN_VALUE);
+	memcpy(new, old, SKB_EXT_CHUNKSIZEOF(*old) * SKB_EXT_ALIGN_VALUE);
+	for (i = 0; i < SKB_EXT_NUM; i++) {
+		if (old->present_extensions & (1 << i))
+			memcpy(skb_ext_get_ptr(new, i), skb_ext_get_ptr(old, i),
+			       skb_ext_type_len[i] * SKB_EXT_ALIGN_VALUE);
+	}
 	refcount_set(&new->refcnt, 1);
 
 #ifdef CONFIG_XFRM
@@ -7156,12 +7147,8 @@ static struct skb_ext *skb_ext_maybe_cow(struct skb_ext *old,
 void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
 		    struct skb_ext *ext)
 {
-	unsigned int newlen, newoff = SKB_EXT_CHUNKSIZEOF(*ext);
-
 	skb_ext_put(skb);
-	newlen = newoff + skb_ext_type_len[id];
-	ext->chunks = newlen;
-	ext->offset[id] = newoff;
+	ext->present_extensions = 1 << id;
 	skb->extensions = ext;
 	skb->active_extensions = 1 << id;
 	return skb_ext_get_ptr(ext, id);
@@ -7184,31 +7171,23 @@ EXPORT_SYMBOL_NS_GPL(__skb_ext_set, "NETDEV_INTERNAL");
  */
 void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id)
 {
-	struct skb_ext *new, *old = NULL;
-	unsigned int newlen, newoff;
+	struct skb_ext *new;
 
 	if (skb->active_extensions) {
-		old = skb->extensions;
-
-		new = skb_ext_maybe_cow(old, skb->active_extensions);
+		new = skb_ext_maybe_cow(skb->extensions,
+					skb->active_extensions);
 		if (!new)
 			return NULL;
 
 		if (__skb_ext_exist(new, id))
 			goto set_active;
-
-		newoff = new->chunks;
 	} else {
-		newoff = SKB_EXT_CHUNKSIZEOF(*new);
-
 		new = __skb_ext_alloc(GFP_ATOMIC);
 		if (!new)
 			return NULL;
 	}
 
-	newlen = newoff + skb_ext_type_len[id];
-	new->chunks = newlen;
-	new->offset[id] = newoff;
+	new->present_extensions |= 1 << id;
 set_active:
 	skb->slow_gro = 1;
 	skb->extensions = new;



