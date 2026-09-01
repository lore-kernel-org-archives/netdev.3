Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CC21B6D08
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228556; cv=none; b=lziuKZantomxxHySp+Bv7RaqNVK1xNT0ifhl3/Y1r4lZwpri4gSxubgVoFs4bJs4rExKVHFlWlpq4MKZzmHdRIZ8xIwrkUNWAm1uDrNFDyRcsbRFqiukU9pB/HpvaR5hgVPLMcfBR81w9HM5I1HT4jIO2UgWTiW6lCOB1U2OHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228556; c=relaxed/simple;
	bh=XyPgmXYcgvV/DLqHCosmxaUVQ5BwF9J1yYeqgm/0Lec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sib2lcAD7rMjOyxy4wOZXNA/Hs2tg+p2qtb7iZPAXwXK83OlxGR4HbJrO86ikiU6ts6f+wpshBSJ2mgym6SCGa4H7qhmdhGLzfpa0FhuJgqz/elzulrJA/c4MPNgL+knaKWB7DXzsMOS9loQrZ7/cK3CPL9SP5RXh2rEIuifdNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9BksXhE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9BksXhE"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-382ef647e20so4322040a91.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 19:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788228544; x=1788833344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eFilEKsLwnikxiYGZ3iB1+9LCClnyCyX843YsPT30gI=;
        b=C9BksXhEPmcWzFYIr++GW+XXshJpw5RTP3JPdXnOcbsap4GkrkSldHHDTv/+QuXWhG
         KyZ2N4phnRAprmiA7540xdzTWDHGYCxmw3twXFvZIU70Q+/KBmvaTQifodJO/xVXj7Ou
         oM9kFoWHmfZ2DvbnTf8Kvm9vQpM9F0EiND6FNmvaOs9hqVF5BqoTRYn1ipxYK/jc6yLy
         CTXb3nksOj5Q+HoQf5HHRWn3yBmPUbYOZWYQNDQ+cuT5CVANPfzlrtWCztHlZZN1LXVe
         yqz/GWQyk3qZsj++N7uc+qjE37CB4ocnpPw5f8N4Ej9Egb4OOVsXVO7rZ3VWm0fO/a1R
         I28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788228544; x=1788833344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eFilEKsLwnikxiYGZ3iB1+9LCClnyCyX843YsPT30gI=;
        b=Z58OnhH1yTmC2y1nPVnqMAZA6hWQ/TEYWm4ztc9yP64WWvcFzlatEsY/GY4eRQdmRT
         XB6jdfMFv4rZqpjefJ+s3wYBbsCGgohsazPbAnIRxRcczIT9LI7ygsTU/V18JcSL6gR2
         VB1i9u083j8w4DkyiHz8r9dICMAi1dqct7kX7BOPbpMqGFwbEWzJbn7qjRej4d2SuaxH
         h05VLaWRT+VSSYH42PwQEy1rkd5Sd+Ae+ZMcGUJR+KwbBPwNXFYi3Hwopqpo8uw0x53E
         ADsehFEB+OqhmiMm0QlBCZ4uXTg6IjnksBg5g67ZsS+2sDzsul/EbiMGmQOegeEJgNet
         VBXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzm2y4dHS0YlO7aWujzjfscvGeugzAlRsCAB21ffa0/TAwqw37gHDFQh5uQJhAWWDikWRrtdjw=@vger.kernel.org
X-Gm-Message-State: AFuF++lQQd4hF0WmNC12r+YFV64pojhAEcHynVNonlpXmDdFj5FgukRM
	PxXmvxu3kQVH5i6a8b/ZO4BoYJEgCiFGe0bOvbMwGn3MN1vDdhXtrBQS
X-Gm-Gg: AYBFou3XeGlXBhZ1PfO1raaU6s9ZhnDNnpmz/MM58OhcUvAqMIJ0VSG/j1e3HijFTpb
	lFLyyhyvf3UaZPWxnO58hNy0JpsxwoD3zLXZu1QPmsoNDy0AQvqD3EhOXot4DHismHarMAiZIAt
	qW+7I5KsJwhUQ+w31OT8PicIzEp4XXjx9OEzzedu46jel2PT1safeqyEonNsjs8vwVsfv4fVKhO
	OD7nvdjB32uoy58LzOkF93ed7FfE8MsMPkoMC58T5cfWnSS8ImOFbj/uuOMRtEkl+R5PGA3RkJO
	qUhc5m1AXjneeG+krWe8dGwBGOCrnuI6JUxRBfH1OF1jn2qv8RcAi0x2TSTFz8EAI1ar9rwWV6M
	l7ntPJtp3bfv+PpfgqpcshlWj5lmJ2wHgp3k/6+J9sxJJYew/fqYgysFPO97B9SOvgG3TNpZkOx
	ujL8kG57RhpIc2eVEDXipnuvP0G3NjQ2QoRkS/SA/I+AiPCE8O517q/24XhbRfBErXfpZJH+k=
X-Received: by 2002:a17:90b:5890:b0:392:e5b1:d833 with SMTP id 98e67ed59e1d1-396d0f1a83fmr47236751a91.13.1788228544375;
        Mon, 31 Aug 2026 19:09:04 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d463798sm2569822a91.6.2026.08.31.19.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 19:09:02 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Tue, 01 Sep 2026 11:08:59 +0900
Subject: [PATCH RFC iproute2-next v2 1/2] uapi: sync lwtunnel.h and add
 seg6_mobile.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-seg6-mobile-end-map-v2-1-05b2ad78b922@gmail.com>
References: <20260901-seg6-mobile-end-map-v2-0-05b2ad78b922@gmail.com>
In-Reply-To: <20260901-seg6-mobile-end-map-v2-0-05b2ad78b922@gmail.com>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2808;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=XyPgmXYcgvV/DLqHCosmxaUVQ5BwF9J1yYeqgm/0Lec=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqljO7GD+CJdOWVIrPy1lYBiHn44WIna5GqllZm
 L+/jBMgvE2JAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCapYzuwAKCRAq19F1Kl0b
 TY03EAC6yF7XDBTLSeNfqd3UcGSBNHNK43zIpv5uzBp3ynLb1v+4BplvesYs/+OZto/K89CQcy5
 mrPdZJdZtmHXyJY3mmT+4mM9zHOO8ktF8+j4Xp9m8Kmq1bKYH7UH0MGYDbKKzUd1AiME52PGKQR
 6nhZQOQzLej9d9T3UU6zb5h07SqLmsb+SB4KDvVBY1pU7+b2NzkT9XfkYT8S7DSE2iHtwfGtxaz
 67gSB0+e0Z12DFqZGVMQ04MIVi7HsMt/XpGhaZzPiEUlzMg4gyYeN7SiCpOL7PzRnmgVhHd/qh4
 rEeHPaJxcqeHhJUKFHCkyhodSIr7xk0p0BYRFnEUPs8aDu4A2KcXX09QRrH6S0N6tOg0g4PAeJE
 N/EzojhfGSa6YDp2ZC3DUTXS8MqgjAxvxjy1jN32GZF1iIQLy/rlbBeUl8mEDGC2wOAE4q4lG8c
 u35XhrXBzN3WQl3FgBsVumoKrN/tbmXUbeTUFjx02TYkN2BIMmrYwlzLDXb3TBS1oAG7txpIZ/x
 6Ffv/fStYhJYuUL0YYd++sHIEvRFFf9o0rFfxMaotOzQXIVAoU2Nws3zYpIkXj3CeGsB+Kgf/kJ
 O5Z1e/Z6DVVxZs7S15i9XvlU5ClbVClUmtuK0JWF3pXzI18Tgq98LDgk6+lrf4IiUq5QzommQtG
 e0SePmNYwK1MFYA==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

Assisted-by: Claude:claude-fable-5
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/lwtunnel.h    |  1 +
 include/uapi/linux/seg6_mobile.h | 61 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/uapi/linux/lwtunnel.h b/include/uapi/linux/lwtunnel.h
index 9d22961be619..b5adca10a9f1 100644
--- a/include/uapi/linux/lwtunnel.h
+++ b/include/uapi/linux/lwtunnel.h
@@ -16,6 +16,7 @@ enum lwtunnel_encap_types {
 	LWTUNNEL_ENCAP_RPL,
 	LWTUNNEL_ENCAP_IOAM6,
 	LWTUNNEL_ENCAP_XFRM,
+	LWTUNNEL_ENCAP_SEG6_MOBILE,
 	__LWTUNNEL_ENCAP_MAX,
 };
 
diff --git a/include/uapi/linux/seg6_mobile.h b/include/uapi/linux/seg6_mobile.h
new file mode 100644
index 000000000000..551ec8e94884
--- /dev/null
+++ b/include/uapi/linux/seg6_mobile.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ *  SRv6 Mobile User Plane implementation
+ *
+ *  Author:
+ *  Yuya Kusakabe <yuya.kusakabe@gmail.com>
+ */
+#ifndef _LINUX_SEG6_MOBILE_H
+#define _LINUX_SEG6_MOBILE_H
+
+enum {
+	SEG6_MOBILE_UNSPEC,
+	SEG6_MOBILE_ACTION,
+	SEG6_MOBILE_MAPPED_SID,
+	SEG6_MOBILE_COUNTERS,
+	__SEG6_MOBILE_MAX,
+};
+
+#define SEG6_MOBILE_MAX	(__SEG6_MOBILE_MAX - 1)
+
+enum {
+	SEG6_MOBILE_ACTION_UNSPEC	= 0,
+	/* swap IPv6 DA with the mapped SID, leave SRH untouched */
+	SEG6_MOBILE_ACTION_END_MAP	= 1,
+
+	__SEG6_MOBILE_ACTION_MAX,
+};
+
+#define SEG6_MOBILE_ACTION_MAX	(__SEG6_MOBILE_ACTION_MAX - 1)
+
+/* SRv6 Mobile Behavior counters are encoded as netlink attributes
+ * guaranteeing the correct alignment.
+ * Each counter is identified by a different attribute type (i.e.
+ * SEG6_MOBILE_CNT_PACKETS).
+ *
+ * - SEG6_MOBILE_CNT_PACKETS: identifies a counter that counts the number
+ *   of packets that have been CORRECTLY processed by an SRv6 Behavior
+ *   instance (i.e., packets that generate errors or are dropped are NOT
+ *   counted).
+ *
+ * - SEG6_MOBILE_CNT_BYTES: identifies a counter that counts the total
+ *   amount of traffic in bytes of all packets that have been CORRECTLY
+ *   processed by an SRv6 Behavior instance (i.e., packets that generate
+ *   errors or are dropped are NOT counted).
+ *
+ * - SEG6_MOBILE_CNT_ERRORS: identifies a counter that counts the number
+ *   of packets that have NOT been properly processed by an SRv6 Behavior
+ *   instance (i.e., packets that generate errors or are dropped).
+ */
+enum {
+	SEG6_MOBILE_CNT_UNSPEC,
+	SEG6_MOBILE_CNT_PACKETS,
+	SEG6_MOBILE_CNT_BYTES,
+	SEG6_MOBILE_CNT_ERRORS,
+	SEG6_MOBILE_CNT_PAD,		/* pad for 64 bits values */
+	__SEG6_MOBILE_CNT_MAX,
+};
+
+#define SEG6_MOBILE_CNT_MAX	(__SEG6_MOBILE_CNT_MAX - 1)
+
+#endif /* _LINUX_SEG6_MOBILE_H */

-- 
2.50.1

