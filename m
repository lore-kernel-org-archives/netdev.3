Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466BC49AA55
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594765; cv=none; b=Haz85Oxs7yhbEPS6vWwv7kP4i87j8eE4SvAX6sW7iWNTDlnSwHJNxeQvFQTWrsyM9PaqSGMkgiyr0/BYzobGlJcuOx5O1g5QP+hzkHw5T9Y1TpEwRxaQdT2mLogeT8/i8ZzCYzbeSF+GaJWSfF0//aRXpmsnSHRWXDqm8XnXEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594765; c=relaxed/simple;
	bh=XyPgmXYcgvV/DLqHCosmxaUVQ5BwF9J1yYeqgm/0Lec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N3PWOmGkSbyJbtLHteFwajP9x4iX5BCcen5LityFiuHeAFBkBwLE37YK6MYmImk3yOTHnhEP57KLC0icngpo2zKzl+ZAMmcFtp4BGGQ1xypG7EzbLE9i6I+zRZCiDpgmp1kS9p4BxHomypM+Jcv4fc224JnhmmQTUgnqImb1Y0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3VL7Jfh; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3VL7Jfh"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f9bso1581555ad.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789594745; x=1790199545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eFilEKsLwnikxiYGZ3iB1+9LCClnyCyX843YsPT30gI=;
        b=a3VL7Jfh0oCBX0jY2jEhQiAxczTisLcJVyN2Fbo/8GR4yHrDATYUKz5/KNjcwxKzIN
         j2mmoCX94NJ7UFYFtZX3t3Shme2aPg0CeywXJvkDeF3Yv3Q0wP+yNZ8zsffTSieQXgWU
         BaDsNJAZD62TG5EAUJDt1PTNVhDtjUV1FWc4wmPH41SGhHNkElqeYoq+qoCabTY31jMk
         KejkiHPzO0ONIwUrnSpnMujCFgvMFI0TgZ3Pwr/I+H8KppCshGVMwzrSRy8Dp57dBtIh
         rFQ8FogQY7WLowheyTBNN8Zf4p9bHYGYg4JMfh6qt/DgfhQo4Nte0wC+/kVmXNor1LMW
         kF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594745; x=1790199545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eFilEKsLwnikxiYGZ3iB1+9LCClnyCyX843YsPT30gI=;
        b=qKkui+P3Xgbtk/UUPUUtg5BcKb9Z38FTeo0jkIUBYcl2NmTq9tzq///gBA5JVvIYyq
         y+zn8HrQVUoPTkrPCcoF0tNL4gtWBs6H3B0QEzP/iK4FPMi0qMifadgjISbfLOWqHy0F
         ISvDNRuMdqT2FIOXWW5/PVd9aeBusrs5fRs8x9ZLTzdTJB1jmAgcp/wKyPgDHZx5RafR
         tDu5KVBRSFo2dE25jGHuLFqr2ltdFPtB365Z15BsIKnGzIBazA761PclBYOJwF27qb4a
         ypnGYmsTTBuUNvaE+S9/PjMBQ0y9mjHbs4LbIATym5VZIKWarebkJavsqItwiAXjVmry
         DiRg==
X-Forwarded-Encrypted: i=1; AKwUvBzlTAH2Q4ZgiIyJDc2ZW+5HZq/u6lvR1Bd/rvHK/uXEDOid+03Q1jDb6dcdK+DGoaD0WdYoxUI=@vger.kernel.org
X-Gm-Message-State: AFuF++loIQvnNYO2A1KqaC7tJT4gSg2Tgy+ViS2faK4kgyXsT+jBUDI9
	cuPYMO9J9HcahtlMyX/18hsaMpFXQOLwJDkAUuIU2hlm111eTjxFZ5tN
X-Gm-Gg: AYBFou22XVaWW3aoxdEkJOfAP1Sw1d1xfZ2hoYIRC2S/sy9bp9g9ldVUPG3SxyoLTPj
	qUIxiROUoYUa86UEQiQJ9LhwgpZf9BUjbBdSgf77bSrB38bvudmUsKlEnuxaoSqF/XjE4RpTPvY
	Qq4kG2q6G/Wvcu6C/0xYm0vGQdrXsJviESZnn7neNBzwAX4/6JExC9hEkVoE2xtSiwbaEW5Inol
	0gzjoOmf99R0AvIc+2J30ta5KzL3BoUE6087a+HOprC0GzIxvOAeGjqg9/VnEZrcyGNBnddOOk2
	4328/Ssq2DwfqEpx6SNFUJ9hSKRvUyMVBEjBtcFE/RyfUsGTcw4sdyyDhpDy8k4Z8qN9MzGzB5/
	YfAxMQejBdFcIyjzkuU7bV1TrslRfuoAeHKaUJmLOk+4R9JYvDO+CKIkn1SfH/LJXVAp+8jgdU3
	/dr2pxyo1VGj31GQCqKg1HYPDd1ZPI4WrsIu6Dy71X1inrTdtfqgnY8UOoTA4AZZKjEu4IeU0PM
	8zDPetZ2vM=
X-Received: by 2002:a17:902:da85:b0:2dd:89b1:7fd3 with SMTP id d9443c01a7336-2dd8dc06d6amr83475435ad.4.1789594745554;
        Wed, 16 Sep 2026 14:39:05 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d8fe15sm17650445ad.1.2026.09.16.14.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:39:04 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Thu, 17 Sep 2026 06:39:00 +0900
Subject: [PATCH RFC iproute2-next v3 1/2] uapi: sync lwtunnel.h and add
 seg6_mobile.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-seg6-mobile-end-map-v3-1-7fd02b8b0577@gmail.com>
References: <20260917-seg6-mobile-end-map-v3-0-7fd02b8b0577@gmail.com>
In-Reply-To: <20260917-seg6-mobile-end-map-v3-0-7fd02b8b0577@gmail.com>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2808;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=XyPgmXYcgvV/DLqHCosmxaUVQ5BwF9J1yYeqgm/0Lec=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqqwx1KXDWbpHpCDKRDf4c3M380e5cPs4LEuuD4
 Rnft8iCN96JAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCaqsMdQAKCRAq19F1Kl0b
 TT47EACCl8uiZ0I7r5OD1uUmLaf58Gi7mDcQ4SZcWbWrcixRDgpCVk3lH00VvrWNQd9VHImixEX
 YnWaZvAgm7ZQIiQu+W1Hp9oVdlsjROqaNzQc8aU/J3NAMAA9Pljdje3skevH7MDCTJyWv978xQQ
 oeOH8iVh8m7Cn+cZ6pgFoEv00mrHfrDnxb+BDYqEtYKiGffwm66mZd60OnQYZv5oE6C5MT68JpE
 wiXLfExepK9x+JrgeHLoruGEAIgLU+iIBEQpPiLXGVnvMyWqZJBqw70hazgKX3rS4UfaiSIyHGV
 8+rfdk3I2TbiDlcTf4IFFN3g3BitRSVt0q9Fw3abOPggru3fPBxwzbHOs130jHWEn2afUwMuKec
 +OIkmuAFJQDJPNphJA0heA/AlrvBJBvNOWj/rAOzkAt9uYUVsJfctweBEy1E2QnWZ9NPtJhben1
 uiFiNA99hp4cuPk8FcEvPh+cKEWx2Zj/Gk9z04gex5yH+TaalKO4Uf8f3UsF0U18n2HvA0G2YyM
 o7wty4ypNbP97zT9SuKIOKaNAfejdq0Q4gmi/QG4CaL+32+3MClW3+tWGKD31EGR9GuvLxQz1MY
 Lxz7ZvE3J4QXKu1SDyZZ39TxERWTP4nvVlVkM/AUkaffw5ycBQcjZShJcXXyIrxPXLtGsPrZztz
 N/o1vrr+gWC1noA==
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

