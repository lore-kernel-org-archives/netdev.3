Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813C43B3C0E
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790316244; cv=none; b=X1e6BuSOBojM3QLLwrq1e9Vc6Bl9NQ6XrWZh0Bbrhr8QK8h2ApC/ZkxnWaeeREm2GH2vefkAOSOXFNL4nXTLx4l9lgEra57cgMS5HH8mSdM16gN9iD/7qgV91rfjhiO7BMLyuq6XGsOkQs1KJL5lBSFkWjwRNhIe5fII4x+GXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790316244; c=relaxed/simple;
	bh=27LQRrgZZ98xFLBbkLQoOsXFbW4PK97TbdQkCpI6mOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eonJAQL+/5PfHS0Xkmkx9sJ32MlN2fQp0y8opglkGqq+LdENQ2m/b66ghgJIOKqwsDU7WCeU8lMOtSpdyRqyr9lr1xm1LxhhqD6GuZqKUgEp6/CQV/dKBmHwDzKiYKQltI00qh6JAn5kscJPBH0chhjefaZh30NBJG+JwZGFyE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6UXSP3o; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6UXSP3o"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0aa9d356eso456860a91.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 23:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790316243; x=1790921043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KMnT9tnKIr4z3v4TIEVF9/oB1jlp4P1gDc0jXZXLL1c=;
        b=r6UXSP3onx3ewjQCNFXL1uNHUDQCoFyAYHgmW8p8CpFEm7jpC5HQQcSAdaHFdG2apN
         mTM/TilgXFDFvpRMdsNT1JFU+9Vd8uCp74DtldQXnQ2xc+0Xg7V/q6RkRohRXiqFQP7Y
         cxCeGBDhcttJvsLul7CBHup4NiuByHWUQZWEnMRK/HHsRJMdt1EXe8yIUjjz/exaul5c
         J4Y2gKxnUYR717e4mv1JZWQjLyQQA/3OkSYlaRdWcpWaRmdy1J3Qk8SHgUbLYrMHLvjd
         fHlY4JK2wdG/D+cfXOjmuByLZj8ycb97At/w2W6W3/z2DW4EZ2Z7y+xoakjJWChyfwP6
         vYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790316243; x=1790921043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KMnT9tnKIr4z3v4TIEVF9/oB1jlp4P1gDc0jXZXLL1c=;
        b=kcPHYs5JrjFwLLTKy8AvIYWOnQXOf4eIo0yk9h7fw2ul6w2qvI3tO6Y9QaugGp52ar
         tIr8ApnOtw4SdXZ5KN8tXpBMI0ViV0qdwHsxqm7CJRhydzY43qEtSIqRQOb8WXJnPfbE
         2cfzIrjFLTReXCR8itEWjowGmX8skfifvlLf23T8BJNigtu58QRHQ7s7xWCpjBUo18IX
         EUN2qqRZEsRl4X4pab4UsIwMkl9q64Ck9gSBp73my0erkY5f4lm3xvr82eO4yhm3gudf
         V2i8IH5e/d0bdSzUuDSNarKp05gpdmUKzO+1D3J+bPIkcFvltsFYMb74qv6OffJm7udT
         CP2w==
X-Forwarded-Encrypted: i=1; AKwUvBw4VmuUhpOk6XcJ+CZ0z7H0eOaZM/6in+3vFt7y795nuKZCUr0Z/HS95wST9X1ZRJtNMzhAokU=@vger.kernel.org
X-Gm-Message-State: AFuF++n07grf1RRG6oaXM0MZvQbeZs9QA0R95rU1HwfDcZ7NUsSKvSHl
	UWP62bF4u4q8eFK0rAwsOYzvIU6IS8NiS/DWvvNfemnJGwCJM/7TykMw9SuHTRyx
X-Gm-Gg: AYBFou1jsfq73aBgRANLprE+qfGp1tPxhq5WJE1sShUd3QQTS7q72hU4iIZkDcOo7oV
	3+v+vA1mnFCziXHYWoNwr64BJld1qrkAc/QoQ3J3PwjTY+rOSqFK+exPOz90MSrEhwWM3dNL1k8
	/5IZKhwGTho4MZV0RSfvmuo3ZiLEBY3EySTSjAr8xWQ3ZCVHMs5Si4KtKxic+T6E3oovA/sPsmN
	Y5N7dASBa374oshVbEwsumsD55yrBLNaSLQvz26YYTUCCIfQCpOXVXW3gBtazziim/6ofXAJGSM
	/Um7iBIfTcsMO7d/q6i7Y62hU99oCt6kcJtKxrHzoFRvezAA6BXVo2axXrWWWq+0uNMFciNMPly
	f9nNBF8bte83MmGzr0bY9buCOUWi8jF/fuY0AoshGK6XZdnqqH9Z1PW839a8MYitSMGXGwk9Ptt
	6lze4EqtjtGzoxog5Ob66HmJJucc1HJJyT7lW5zqJeZ5GXKrEdXIGUZ2HAeQJj0cg2XrbWUH88x
	TrJ6Uty
X-Received: by 2002:a17:90b:3c0f:b0:39d:eda9:febf with SMTP id 98e67ed59e1d1-3a098da4171mr4845849a91.18.1790316242730;
        Thu, 24 Sep 2026 23:04:02 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b898cabesm2467490a91.0.2026.09.24.23.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:04:02 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Fri, 25 Sep 2026 15:03:58 +0900
Subject: [PATCH RFC iproute2-next v4 1/2] uapi: sync lwtunnel.h and add
 seg6_mobile.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-seg6-mobile-end-map-v4-1-ba4951d28871@gmail.com>
References: <20260925-seg6-mobile-end-map-v4-0-ba4951d28871@gmail.com>
In-Reply-To: <20260925-seg6-mobile-end-map-v4-0-ba4951d28871@gmail.com>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=27LQRrgZZ98xFLBbkLQoOsXFbW4PK97TbdQkCpI6mOs=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqtg7OPGlj4IO0x+kyK8XGJ/zpk+oOF9zjwLTYL
 33arMMCjMyJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCarYOzgAKCRAq19F1Kl0b
 TWsMD/9eTn853p6ybDQaLa7CSKdTBOJut1opq2H/0bTT2KC/lmAVCIN/klf+sLquIn/AnbgYMdL
 m/5YQQ1x6+5C4wIPTqasT9wk8OoJBvBgqJ/VxTGvh6DIsHnvILufTLJJTq+thUD6WfM6J6BpWPG
 zVebsTUl1fcT4DXxXacSErr3dcqWYuVXp/XsN2jlF0WySspOwcIUKfBXK05kt+UyJ/nINFWXlz5
 xSr7YW0feQogL5mIH8vCo3Rpqm+uxDf+gIj09zTIPRbk3E98PYKcHbbvCNA9hYm80gKOh+LRuhq
 Bco0NbgbasBFBgehQ5PT3ZCQDXMQnpdHKVaTx7FYkVlw/Vxe+snX47Hlq7aYjo+a2gg+9t4R9d5
 1COUbBIpL3h3s9AtQjv9coY/lo/Sv8CcplRXQWwfk1Y2w/jO8fheyxPcfxprnZcNu/3lOHw6Keh
 amK6+Jgzfjevyj21Pxh0BEQ5y6p+dY0m7l2mwBlUts9w2QjpXWdQJiPIc6FQnfj57vwDy7Kej3z
 da9yG80vdYHajD0UGP5dQMWqezOVx3wOWa8Cu9f9JOuNexmAuurKlVyn7X6l2vq2FIcqRmTJ8jU
 82UBQdCesRVp0BF3JFlBH3YIW8HPcwl1bNoX+Dtn4wtUC+nZ4EuNwQDfYfXqbGreeBbC7xGyVNe
 Gk7gsk7dUcooFkQ==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

Assisted-by: LLM
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

