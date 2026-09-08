Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6215908D2
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887412; cv=none; b=rD9joMR5J2ejKGCGtj7GteGjnRIuRlcSLPn0mSVZlV5JsnQLBrxdVrA7uZQoEBEwDuIrw6IhYvM7BjeQndpUaFaaJZf1qLr3AjKIdTLZxClwF3oHx3qk+VUdNOlF9+KTHao4wEKG1hywkeHeCDYqeC1AokXm6iRUcTdm5ylPZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887412; c=relaxed/simple;
	bh=NrgThq6Y8uHhb3wAckmPMV55GlSGJaL3Mt7emHZURDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tS/taKIZgRicxRKMtUw1PSxzrdNERaOfWkrHoyqOQ3WfUBMN20VB5LDrzYHv5QxpNYhlhELmOxDqLavUBJYFDrkIQJcDKufKmAYFmb8HdAm8nO/qHUTl++5vHxYG+VZTr4GOQK82gwS+ZyMaz3rmZeSFILJr9a51q91PUZQkV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mbM6R92I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fgjDTlAx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mbM6R92I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fgjDTlAx"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FdwXR361123
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 17:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UZdtDE9nITufoadjKmxDFYIwfAzWlsnkOtcwwliJ40E=; b=mbM6R92IpOK5evsc
	mB1MtHjS76EOxfKfaWUgzbwllqe2qK8te+UJKcgClQbZu4hrivXX+gGxCBivQ8XT
	U7fdyMtVAqyUpvS4s6nVmPRu5ER2Bs5BY8KTtxM3YA7zgUG8eywFmeYQy+sRQCj0
	8ztVB2KG7i6Rg5k05cqwxbF6uGohb5f8j21/kOJrcEQZgN9LVICO+/6HTltnYOBF
	09kgPHZvdcYbrLulrRBmlfpzispybVSYWfd89Pgq/CWUrH30gZglneMcgCqymuzn
	mCfjt8SQO0pksuQ3Flbi9qXwwk7DfWxulqpX/Wz7irN4+wejdKw1GMMMmnFBXbik
	2f2Oww==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjb0pb9k1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 17:10:09 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84842381150so5320362b3a.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788887404; x=1789492204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UZdtDE9nITufoadjKmxDFYIwfAzWlsnkOtcwwliJ40E=;
        b=fgjDTlAxTpb94Gre70BDBVeim08n9s1hD15RfS8DUC6IUS6nX1KEyWH6jm3++6Gc36
         AA7HEXuJndZDoahkbmfwVTDgPcNH2ftpzQb7mbnvbAKyf+Z/8RliiLnthMLUcZsTRVqC
         AburXl8y0+vsmSnvrlwR0D4iCPqZLyR1AEuQHV9E+GwIG31a4UwsTyhn1jUl2QDhc5qY
         lGzH4lAcc8r4pRl72fxOq9uxbYWFJNPVwWsWABpzwJhGM2WIjZ0Fe7bnLaBOArhA0/5c
         en6A/I5Xj+pcmEWiumAnWcoRTYZm6lQzia8plNY/w7fFkDGIhyKAa+OIRUr1o0xxuZd1
         WMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887404; x=1789492204;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UZdtDE9nITufoadjKmxDFYIwfAzWlsnkOtcwwliJ40E=;
        b=qRQncuxwtTRiQ7EkNgdvl81y3HuWSk6QNA96+UG2D/7Wb+E7qTbEoY0ikv+Qcc3Td+
         jtuaeHz83/1ZHbbtxtfuM/goeVbR5PbncdOuYpQnu87+d9Qlqgme/9fLa/metMa0sIxp
         XgU+rc/bZmcUiUy5adnGWsMSO2F8ok8q+W8db8bQRyxDuMEmrhDawl4Y1KC4t0hrFopY
         SUPIjhOf1kK4sq6KAXS5Bc5AeOXnTbAwRUP9qn8PI336zdpySO0YmYaKhNkEqGinGFIW
         q9dIOjD4q0liziN5+Tf2CqCLZv1tf96rmyywN4D9/YnXEmOuw3XpqvYIszc32C+sr02O
         1xXw==
X-Forwarded-Encrypted: i=1; AKwUvBz1d6QXtkUZRFGkmeivdt9RwsbTioZMOnYKsy2qYGefMSjfWowKwyrp8iCqLdu5S6TguObx2HQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kLavwFduYMOdedv3Enyd/mgcVTotKVvrU6fl5fELwTS1A4DPUU
	oFbQw5o8iCOXuCDq+F/cA+1mixjyjRueYtmmhaE17AmkW3a+w+r6VVx46GDKgfoftp6Q0n4RJlK
	55krShdpZ/ghHwQAPUxtwOULlINc3q+lIHSHTrKFC6QsIE1medK8LKmjwoQ==
X-Gm-Gg: AYBFou0lxxs+IAH/dco2Qp6tISYD6TAuyFlaphPbW+G8hs3oJYf2tFixLISe24rF/+a
	Vs5NbLxpRmWfWajZDP8vDr+54652KXH61zwwwp9DymV93hWrROSpzlZjFtYkjHQHMsvZ2d80+Um
	lZsClPpFGOyAONlzFXhRgI3bL9brqFbo3FQhda8NuGeOCxvcjBNLAV00uL06uEftAdIJPWG31m+
	4Vlkci8eWBWeVEoUmpEThba4KnUQkxq4XdF5CT+MA0jhtTlAtat0MjaA8HCZWNsXKnVf6+CI323
	b5fe8G/W6b5ZfdB/sABBiEVCdAThnpySa0ms5qbuaF0wlo68tVHcNvmnYEXz2kAlPm7ruXMbp2P
	pU1DWAy2/PaJPg3oIEowBADD7Ut7UovC6oKi0digdSWynFYB2KPsi4IHli60FYFSfi3Y6QtpCXY
	fDmYsed4sJyzakCu/MFh+15g==
X-Received: by 2002:a05:6a21:7748:b0:3da:6bdd:2c74 with SMTP id adf61e73a8af0-3da6bdd6cfcmr27957439637.10.1788887404137;
        Tue, 08 Sep 2026 10:10:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:7748:b0:3da:6bdd:2c74 with SMTP id adf61e73a8af0-3da6bdd6cfcmr27957381637.10.1788887403611;
        Tue, 08 Sep 2026 10:10:03 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm31773675eec.4.2026.09.08.10.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:10:02 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Subject: [PATCH RESEND wireless-next 01/18] net: skbuff: Add SKB extension support to wireless drivers
Date: Tue,  8 Sep 2026 22:39:29 +0530
Message-Id: <20260908-smd-v1-1-9fd2d876a1fb@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908-smd-v1-0-9fd2d876a1fb@oss.qualcomm.com>
References: <20260908-smd-v1-0-9fd2d876a1fb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4XkZsCMbohAQRWr6W08RDeAZq5BtthF9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfXwZT/QjV8vbYg
 PK6T6MyHMCaGxjv2tnhMfPXwNeoDnuxhmFREAtFAISn437H3PcU5KrTt7sPxvLpCbMGowDDZDVp
 7PkoyO5UKIfqOH7l7+D8yZQA3Ke1Uw8=
X-Authority-Analysis: v=2.4 cv=HL3z0Itv c=1 sm=1 tr=0 ts=6aa04171 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=axc-8nxta6ncDHcsNdkA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 4XkZsCMbohAQRWr6W08RDeAZq5BtthF9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfXw0ivMXtd8AWZ
 nDxBrZQqlesK0mSUk0/i4xKV7JNFkJFQjslKWJ9yxhDEeGMjioPIitxj/cs5D4CjEFBQYNTy2pb
 eItl5/AxuWxnm0OJx6Rb5bSVS5nhjYbqyl+NEV3eI5B/fgnSoIYFqAS2eMIOBwYIAnSY2Uvug9C
 VmpayBGHzZewCZDvgADF8P0kGWnU8xdRq43d3EvhlrDCjUeU0nUGOGGshAWwx3d5csrILDv/kTJ
 1pT8SIqVOt79Dy7/3zrcIEGcPmGtrGYxKr+Pt04YW7W5SgIdaVhpQ1yKGncN1narGYsSrV3a1UW
 DrssIKBB3WX3LHJbiViTrZ49D00pk5BUTCiXeUZeTAUZxKamL+jptbWf15fN9vzz/eqkqb72//v
 XtPMghsc0S27Kl+qtJeQbBU5NjAdDU4FWtM2r37NKhBfrexWmeUaUZiTLtN8ex2lC3707BThgjo
 3LFw3539FTqYe8sGZDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080185

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

