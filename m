Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAFE3E9580
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813205; cv=none; b=ufHWI5Ln9CBJLi7XfOlY3LE6HESZON6Udc3PuqTRZnMR8L1m6s51ax4QgHE1M1zR/UGcAPTZiZ6NvhJACi7HEbvM+FQBJii826kjNItHSPJnVGCpFPnYFMOyQM/I+ed9D2ZfPu5HVj3ZHkREIwa94icXp4yUfe7sF1ER7F8PxOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813205; c=relaxed/simple;
	bh=NrgThq6Y8uHhb3wAckmPMV55GlSGJaL3Mt7emHZURDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=czFuQWK4OQUoPGCdMLdhRwnILsAyAOJUp4ta/vDvC7V62YHDvz9+rlA+40JB+bIlcB+eGff75sCVP+X5F/84cBOWX7sNC8Hmhr8+A0C9CfuwWCLfaVP7aXsJTU8oaUnGMLfSi5pjzakwcbjKUE7Abgqs2YZcr5rr3zfA3RoDCWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mETh+2A6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eCtq1oI8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mETh+2A6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eCtq1oI8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687H89nR4183566
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 20:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UZdtDE9nITufoadjKmxDFYIwfAzWlsnkOtcwwliJ40E=; b=mETh+2A6Qi98H/cg
	JRlQd70yksouhVax3yQo4tKoAwbR1WgnoT1BAqTR2QGBq4/hdb5nIomQqD7IeAQI
	XDcrhGLS5Gu7X1H6/Yr9dewIfTsKabZ4t2jBfqGpabXYSiI4zDBgokDbQ9g2sPC5
	B8BFBqERcR3HUp2voKAxB1Eq79Zj8r3kpsVmaHtiko2B1tpKGXbr7cax8lSei9fW
	gv9MPruNUWrnR6v7LkgjIzFQn6xwBfefw+oJudvaS/tcTKpndavCt9yaaqcL8l3L
	y2LppiikVjbdz5Ni5DBDEfONJh8kUQhTojGIEkxaNQ/gDcC++21GV7PnsDPdDlMK
	pDIuYA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtfx2938-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 20:33:22 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso1798161a12.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788813196; x=1789417996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UZdtDE9nITufoadjKmxDFYIwfAzWlsnkOtcwwliJ40E=;
        b=eCtq1oI8oUTrjnlqvS30f4sw7IMCU5jNQKndbClgFH4eTotkq/6uEuWvxu08CYyEeh
         huxoUMxrD+hsLru4as6Q/nDXpGw+Gfim4/DPEoO2XVPYKhlsfnRw87aaXHCUqXkWwDws
         vGUImRmDFCkqU/oXOza6iNqvzxXuphmyFc/Lp/G4GKNxhI2oPh9jdO9jQjlhJYHwEUI9
         YS3PiIeJPqoFVY/4jWshrrJQIXA40gipBqPrKyStEcNAdQUsd6rvPBH4majFJTbNbbG6
         tNXWLnt3wTUUbWOfCDaUzYCnkZBUAgOUMrKVQbSO1kQRO6kzg7gzLGitVsOv/iYMAow+
         ef5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788813196; x=1789417996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UZdtDE9nITufoadjKmxDFYIwfAzWlsnkOtcwwliJ40E=;
        b=Kyns6CFJTb407301sxYh3Xbhbhs0lJfLZp+ctsWJA5a5QYsT/3OXItgjObbDn4R283
         nau+M/KPDix/0ozqByn42JPjO+b3sQbYH+pRve81N54jSLxRvj0hgNCsJnmP7+wMrKm/
         TryVNY4gL0hG8w8aB1ELTuRVHUHOTGG1MSbCLywDrqSE2UZC0ATht7V42g+PUI63AivJ
         1YBYIpT4Ek8qQG75H/jJu0vq9HXHsH+a9D3f0MlWoCvYIJofWIZG9Bx+9542xaFAeyG9
         nqRIKoOhq6FrfKyPrlQQlXkwtvmuJ2ydGety1znDS7l8qnLQTTlqI7Xgvhnu1y88e3Cr
         d85Q==
X-Forwarded-Encrypted: i=1; AKwUvByM7YabV91f3ZXhUgsmqPoh9g/HTTDw1B1O2c5NpjJUQPiWHlJqXSBxQaDxVeON32IA8pft5Fo=@vger.kernel.org
X-Gm-Message-State: AFuF++nLVt6H4mDpFuZD/NcVcPCqMAil/VUqnV/0DHy6HSlMxtpHYnQ7
	PZFE41Z3t+tNZtTxotPhEawboXy2wCieerRynviEkShmGqSdp6RbPrTKJ4RPcGnnGrZLm03Brjh
	FnHB9fxgnH7YqWFMZPTL+UlOSsPoqil/ivHgI1fw3XU8Q325PSBD3KM0FFA==
X-Gm-Gg: AYBFou3C3MFs5gAA9oF+/z5Mnk6Dd098X1WnznY53mTUUNLF8Tqhv0IIR5Xkk4ic1QY
	E2jjtj9tUn4HYjbhpa9Jxm41BomZH4qYiX8uB7CI+856LLvyJBPZpOcXrJXJ78z9mw3HvT4e84K
	loNIMoIFVpPJNNF/eWwQYoFAGYkQh6c3iUbj0i6l4xa2cIHivUdjwoQS1MTbYYJM7VLIGffCUue
	/CNJctOThDnNh4imQGqgE0dPleYLxerxR0oYMRjCYVwvbluPG+FbbxRqos3AFZkGAQ28oUNbrdp
	qODCHSMC4WkUV59cXF2yCNtqJViWiLJkp7TyZJ9lD8fganHp5HxSwNbhmhNwzW/fBA4zdvkIyd4
	2075E2JztVThO4JTVhhn6xtNqY2R+wwlAXdqNj0zio5mGvRtEn84xsOKStWIDBxb4Wo233P279v
	+JRzu4T0YCLuTNXtFL7/+WEA==
X-Received: by 2002:a05:6300:6710:b0:3d8:1f68:59ac with SMTP id adf61e73a8af0-3da3a15bfc3mr39225017637.23.1788813196022;
        Mon, 07 Sep 2026 13:33:16 -0700 (PDT)
X-Received: by 2002:a05:6300:6710:b0:3d8:1f68:59ac with SMTP id adf61e73a8af0-3da3a15bfc3mr39224968637.23.1788813195589;
        Mon, 07 Sep 2026 13:33:15 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm47841297eec.16.2026.09.07.13.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:33:15 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 01:59:10 +0530
Subject: [PATCH wireless-next 01/18] net: skbuff: Add SKB extension support
 to wireless drivers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-smd-v1-1-65ad4ab30fbd@oss.qualcomm.com>
References: <20260908-smd-v1-0-65ad4ab30fbd@oss.qualcomm.com>
In-Reply-To: <20260908-smd-v1-0-65ad4ab30fbd@oss.qualcomm.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Weg8rUhX c=1 sm=1 tr=0 ts=6a9f1f92 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=axc-8nxta6ncDHcsNdkA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: CfQAIbbv2CVAVL5Q3mABV30qoA1jnwXM
X-Proofpoint-ORIG-GUID: CfQAIbbv2CVAVL5Q3mABV30qoA1jnwXM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIyNiBTYWx0ZWRfX+N3UspXOnd6Q
 08PyBiSfNOeNnN5xx7lOMqFUlnzbbrxq2uN4sT5xOgiMXUGT0CPpqeHmhjD6V9DA8gWFp5g3uAV
 PIxDvM3cq/7l/+LD+Q5JZPCwBG+5dVk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIyNiBTYWx0ZWRfX6LKJVharFDyH
 5OMTk8bSzbIVspJ9Ds3ZifkF1nIWwTaszH2KFR6xGgf4RhaaQgOSO/i8VMwdPbuefeFvpfGPrQC
 THaANlzrDCn5AWyKadO6KboKtO1YsyBvunueSbaSCGP/6z3iJqS0BxRPC8Z+BUepKxs5Y+ZsMLZ
 bFYMOiUOxUcHVSf4OIQVj/j3DFliGJ3B1SIHZMJbJEdAaIQ4kZO8Jd/G9ctVUbOj56bHZ4YcQUo
 Z40QYpJnz46qUghv7Ws8YkVMaZROszbslpGTJWmi2H3dy229M8ySEA8CyDxKOD+x9mb07O1xISr
 7DZ/XCee84EumP1WqJVUw4w/uUAcaxOBF+e2Ipm/PyuMmxHDU4jxPLudlbhBWR+OZKTBgGP7eAx
 6xwXJSZH0lsU+ZeP3EkM2Lwgfjo7/LZdqRKf1mQ+ImrjHzvz5tlU1hyi/goRZU25rrumL6rxiFE
 NVhcUS2HtZV2g1ag95w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 suspectscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070226

IEEE P802.11bn/D2.0, Aug 2026, subclause 37.16, defines Seamless
Mobility Domain (SMD) BSS Transition, in which a station roams between
two AP MLDs within an SMD across two phases: Preparation and Execution.
During these phases, the receiving AP driver processes a query frame and
must carry the station's roaming context - per-TID sequence numbers in
downlink (DL) and uplink (UL) directions, packet number in DL and
per-TID packet numbers in UL, and per-TID BlockAck session parameters in
DL and UL, plus a variable-length driver context - up through mac80211
and nl80211 to userspace, which uses it to complete the transition.

This context does not fit in skb->cb (48 bytes). Carrying it separately,
outside the SKB, breaks when the SKB is cloned through the RX path because
the context lifetime is no longer tied to the frame; the driver would need
independent state correlated with the SKB at nl80211 encode time, adding
error-prone lifecycle management. SKB extensions avoid these problems: they
are reference-counted, copy-on-write safe, and freed automatically with the
SKB.

Add a new skbuff_wireless.h with a typed union structured to accommodate
future wireless extension types, carrying the SMD roaming context as its
first payload.

Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/linux/skbuff.h          |  3 +++
 include/linux/skbuff_wireless.h | 55 +++++++++++++++++++++++++++++++++++++++++
 net/core/skbuff.c               | 55 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 421f6fc45451..fb686024e97d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5061,6 +5061,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_CAN)
 	SKB_EXT_CAN,
+#endif
+#if IS_ENABLED(CONFIG_WIRELESS)
+	SKB_EXT_WIRELESS,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/include/linux/skbuff_wireless.h b/include/linux/skbuff_wireless.h
new file mode 100644
index 000000000000..2cb04bff061c
--- /dev/null
+++ b/include/linux/skbuff_wireless.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * IEEE 802.11 WLAN skb_ext definitions
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef LINUX_SKB_WIRELESS_H
+#define LINUX_SKB_WIRELESS_H
+
+#include <linux/types.h>
+#include <linux/refcount.h>
+
+/**
+ * enum wireless_skb_ext_type - type of data in wireless_skb_ext
+ * @WIRELESS_SKB_EXT_INVALID: uninitialized state
+ * @WIRELESS_SKB_EXT_UHR_SMD: payload is @uhr_smd_ctx
+ */
+enum wireless_skb_ext_type {
+	WIRELESS_SKB_EXT_INVALID,
+	WIRELESS_SKB_EXT_UHR_SMD,
+};
+
+/**
+ * struct wireless_skb_ext_smd_ctx - UHR SMD roaming context container in
+ *	SKB extensions
+ * @refcnt: reference count; one count per distinct skb_ext block that holds
+ *	this pointer. Plain skb_clone() shares the same skb_ext block and
+ *	does not increment this counter. Only skb_ext_maybe_cow() increments
+ *	this counter, when a COW produces a second independent ext block copy.
+ * @smd_ctx: pointer to the IEEE P802.11bn UHR SMD roaming context;
+ *	must be a kmalloc-ed buffer, freed together with this container.
+ */
+struct wireless_skb_ext_smd_ctx {
+	refcount_t refcnt;
+	void *smd_ctx;
+};
+
+/**
+ * struct wireless_skb_ext - SKB extension data for wireless module use
+ *
+ * Carried as an skb extension (SKB_EXT_WIRELESS). The union is reserved
+ * for future wireless extension types; only one member is active per skb.
+ *
+ * @type: type of data
+ * @uhr_smd_ctx: pointer to the UHR SMD context container
+ */
+struct wireless_skb_ext {
+	enum wireless_skb_ext_type type;
+	union {
+		struct wireless_skb_ext_smd_ctx *uhr_smd_ctx;
+	};
+};
+
+#endif /* LINUX_SKB_WIRELESS_H */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab195b99c853..f28ab7c3c888 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -93,6 +93,10 @@
 #include <linux/indirect_call_wrapper.h>
 #include <linux/textsearch.h>
 
+#if IS_ENABLED(CONFIG_WIRELESS)
+#include <linux/skbuff_wireless.h>
+#endif
+
 #include "dev.h"
 #include "devmem.h"
 #include "net-sysfs.h"
@@ -5169,6 +5173,9 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_CAN)
 	[SKB_EXT_CAN] = SKB_EXT_CHUNKSIZEOF(struct can_skb_ext),
 #endif
+#if IS_ENABLED(CONFIG_WIRELESS)
+	[SKB_EXT_WIRELESS] = SKB_EXT_CHUNKSIZEOF(struct wireless_skb_ext),
+#endif
 };
 
 static __always_inline __no_profile unsigned int skb_ext_total_length(void)
@@ -7152,6 +7159,16 @@ static struct skb_ext *skb_ext_maybe_cow(struct skb_ext *old,
 		if (flow->key)
 			refcount_inc(&flow->key->refs);
 	}
+#endif
+#if IS_ENABLED(CONFIG_WIRELESS)
+	if (old_active & (1 << SKB_EXT_WIRELESS)) {
+		struct wireless_skb_ext *wifi =
+			skb_ext_get_ptr(old, SKB_EXT_WIRELESS);
+
+		if (wifi->type == WIRELESS_SKB_EXT_UHR_SMD &&
+		    wifi->uhr_smd_ctx)
+			refcount_inc(&wifi->uhr_smd_ctx->refcnt);
+	}
 #endif
 	__skb_ext_put(old);
 	return new;
@@ -7256,6 +7273,36 @@ static void skb_ext_put_mctp(struct mctp_flow *flow)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_WIRELESS)
+static void skb_ext_put_wireless(struct wireless_skb_ext *wifi)
+{
+	switch (wifi->type) {
+	case WIRELESS_SKB_EXT_UHR_SMD:
+		if (!wifi->uhr_smd_ctx)
+			break;
+
+		if (refcount_dec_and_test(&wifi->uhr_smd_ctx->refcnt)) {
+			kfree(wifi->uhr_smd_ctx->smd_ctx);
+			kfree(wifi->uhr_smd_ctx);
+		}
+
+		/*
+		 * __skb_ext_del clears active_extensions but not ext->offset[],
+		 * so __skb_ext_put will call skb_ext_put_wireless again;
+		 * mark NULL regardless to avoid double free in __skb_ext_put.
+		 */
+		wifi->uhr_smd_ctx = NULL;
+		break;
+	case WIRELESS_SKB_EXT_INVALID:
+		/* data not yet set */
+		break;
+	default:
+		WARN_ONCE(1, "unknown wireless skb extension type=%u\n",
+			  wifi->type);
+	}
+}
+#endif
+
 void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id)
 {
 	struct skb_ext *ext = skb->extensions;
@@ -7278,6 +7325,10 @@ void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id)
 	if (id == SKB_EXT_MCTP)
 		skb_ext_put_mctp(skb_ext_get_ptr(ext, SKB_EXT_MCTP));
 #endif
+#if IS_ENABLED(CONFIG_WIRELESS)
+	if (id == SKB_EXT_WIRELESS)
+		skb_ext_put_wireless(skb_ext_get_ptr(ext, SKB_EXT_WIRELESS));
+#endif
 }
 EXPORT_SYMBOL(__skb_ext_del);
 
@@ -7300,6 +7351,10 @@ void __skb_ext_put(struct skb_ext *ext)
 	if (__skb_ext_exist(ext, SKB_EXT_MCTP))
 		skb_ext_put_mctp(skb_ext_get_ptr(ext, SKB_EXT_MCTP));
 #endif
+#if IS_ENABLED(CONFIG_WIRELESS)
+	if (__skb_ext_exist(ext, SKB_EXT_WIRELESS))
+		skb_ext_put_wireless(skb_ext_get_ptr(ext, SKB_EXT_WIRELESS));
+#endif
 
 	kmem_cache_free(skbuff_ext_cache, ext);
 }

-- 
2.34.1

