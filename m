Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00243A1E81
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944377; cv=none; b=AytARHilATHrTChUsvenWMMizGSP0oJkWWtJnwGkgRrMbMRm/zzXueYaKj44vxnAUyb/Avwk9BP3srtSiqqJS1loR2mjJ2ohVVMFqBIbZSkwIxxEtode8WLmaJo3YJjcxgt8h//b81DJa72KVePofKbg0TDw5CFadP7/Oh+PElY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944377; c=relaxed/simple;
	bh=27LQRrgZZ98xFLBbkLQoOsXFbW4PK97TbdQkCpI6mOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QLbgWwFBloQUxkl1DxR8jL4OxY2oeVUjuPQ+f+vbXJb7S9lYIo9AePIO+P0my6y96majkHRtvikaXeelfwx2VdlRdJV2rYuDfdDZLS0tUDnUzWwZ2Y/gPlqpjl9Xy9cmULjSWXNYSB2x06ug4BT0MHKR3LXdj1SYT+s2n9ECl/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKB1j/4g; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKB1j/4g"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e5eso3983361a12.3
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790944373; x=1791549173; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KMnT9tnKIr4z3v4TIEVF9/oB1jlp4P1gDc0jXZXLL1c=;
        b=PKB1j/4gc9gMSCxC1Txv1vyjCg+N0Ji3ngyvmOX/vqYUAoYBGk00rxTYxAx93vtJVI
         USjUhwEmBS5y8lUmqkPZjZzwYpEBUsf23tALLLWGKJNeNXliaAyp8HNi7kycMZGfpQ/D
         HlHLyenRnyUM5MjPXhTW3S0fjU5SpPzqOeakrTpefmy6msJtr3UxsSfIHWS3to22QGxj
         99hnnyASezalbAb6uWathQtgGU3rp+n28MmW24AOkbR/9QWgVqdoo1/a/paeZeqSJn/5
         J6vdA69j5njvEQmo9SGnpFitQxLzlQ3sQmORWk0l6l6/+6kJmnwRs3H7V3K3kDsbR+IU
         KEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790944373; x=1791549173;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KMnT9tnKIr4z3v4TIEVF9/oB1jlp4P1gDc0jXZXLL1c=;
        b=h7fXz5+1tss+lkEnQEcN/jFU1udlkaXhJkARbJkKaFpQcASEomZh3A8okexaLRArGh
         2nv8mq+G0XUGAQ6VWrR5Q5uez6jKTK7VHs3z3Ohjvy5kakLZcei4/0CsudlU82epHPY2
         2yRJUYBe6q60Ol5wW7UqinCjm0ylWwLwqjpvcX9Pvaf3Sai0bgr8YlKMLRC+T99jgJPT
         K0Xlaglmrw4mXwfs9ez9YRXnI1hgmK/sBS5JkeSCZXG420iAENXPpHOfsaj5Ta6C2AHx
         w5d5sQFngg9B7mUSpgdli8o7Tjc57P6dwOLdbjvFMkLwdqTZMUXS4G9YPee67E4v2Tlq
         qtMw==
X-Forwarded-Encrypted: i=1; AKwUvBxoIi0one+MfB8m6tjHpUUt6BktKF4WrrCIYfM67WJFTpGYU/Sw/UFm2b9eW7c7hqAcZRhvEno=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEaz5Oc8mLvcRgCSwVTGKIm/r+7nRkjfKMJsc+dWRl/FUfYZmq
	a1GQFzg3TpUSRTKIaWsdpOi4vhWI2cdRpQLn/3CH81YeKfAh9eEsbD/IIG4lNwN7
X-Gm-Gg: AYBFou3An8ECZzhExP7bs04CZe3b7peF86eEIjT397vKvD3/R9X9mG51nkKyq/U/awD
	QWyfwyrK2WCKt1Sd7+D4y6Wf0d5VVBC7AjFYnF614/dk829TFnNsGj2EwWs1ddP2kd+epcPefG8
	zvwe+wj4JA7FvzA5QEZu8jKa+yntw74iDRaw0e1FUP3AO21tHilI1D+mVVwbuKd9QLa9tQsfe2S
	YiGtLUDgIUhYvCvn9nxMxReneAV+YYYmQSHzChMsjO0Oq0tvQVuDUBek8WOzJDWUWuNKpRmuJaB
	dulPQ1vK61TdkN6vuLJxk2hTRDHNd3L+VkksYIWOvmejhAUvp9TtrvktMDhpoi1rClfkkv02mPM
	BMP2VORh9POcgtSJf8Uclw37YKo0xcjmWC3oCWXCBudqslOgbNpAuuAJ/3by46WXFfQBi3742y5
	vh98QmasJ/YR4GIx3CDBimYK6HW1gtU8vhoshVAkBppZRlWLSj8Rh2eXNC1kXQmxMuKiewgMEFD
	qhEGdtn
X-Received: by 2002:a17:90b:4acb:b0:3a0:9640:803a with SMTP id 98e67ed59e1d1-3a6ce3a97camr2815467a91.5.1790944373031;
        Fri, 02 Oct 2026 05:32:53 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd1a0c1esm1523877a91.4.2026.10.02.05.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:32:52 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Fri, 02 Oct 2026 21:32:48 +0900
Subject: [PATCH RFC iproute2-next v5 1/2] uapi: sync lwtunnel.h and add
 seg6_mobile.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-seg6-mobile-end-map-v5-1-92ac9b315d23@gmail.com>
References: <20261002-seg6-mobile-end-map-v5-0-92ac9b315d23@gmail.com>
In-Reply-To: <20261002-seg6-mobile-end-map-v5-0-92ac9b315d23@gmail.com>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=27LQRrgZZ98xFLBbkLQoOsXFbW4PK97TbdQkCpI6mOs=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqv6Rx6B96UF8ZPDNl1zpgCP7ftSBmhH6ZOiOY+
 bmPJZ9r4I6JAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCar+kcQAKCRAq19F1Kl0b
 TVpcEADBLxZde0Dje9DlzH7iSBi4yAzuKyz4xABtgJWke1bUoV4vQf0lHuMo/KYmtMULZG1zGwb
 7iXPxGQRz6vZOPljt9/k53GjkF+IhjjLmf5oI8zGI1yvsFfpfo3zDChZ/d2fmKuI6SsbgXFaljp
 NYjI4xPGT0JJo8/GF+UaLJwkip3EFzbeXeQOqLSt43U70Sf/VdEj0l1E1hD4SrdxKLsKyutMJP0
 DPYcNHE7LwadjHe+JMuraY2vCjbcfiZwUCMz43xEZFexaXmM9IjdNnRznJavjVnut+d4OO0AFoi
 45MV9j9zpAd7jjV7k/+buhAEwHeNpkXxW2sYLwUvEuAm/MfqEMZQFHhmMNDU4VmNqH+20SvP5Re
 7NI2QQQVB3cCMCiQJLh1Z0CPTQnj/PoaNIM9+hVFlon0Lh4C/A2/bV8U57oLLpeup8+MC4KCd3B
 gNQ6hTj/K7lFU2w0xTOkTVEjycWqL2OcjPtDVNrhKPYwUBmCUYiJIHNCy95MY1dP9JF3aRonrN8
 x0DB40K2Msw8cqTAJD5dOv/5WkVByuHXOwxV4wvz8FHhOiyfmD9M9rSsedJJTL6Y5XELXosfGcJ
 9SdRFgIdvIbOzIwKmBKqc6G7uA9bZ/g1jDfpRI+DD4QNXNWkoMvTDL2PKNUiTW9ICuyhtsxGJu2
 eYTuv9Fmr5Q2BsA==
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

