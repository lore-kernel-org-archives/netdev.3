Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65313254A5
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 04:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214383; cv=none; b=oClExH/E9rm/h7/v6HE7TT34fOHtNzwfHmO+lHhNgLuChVpWEbdJaold+EgzmvCz1f2UQQE3dbQ6UIlR29d2PXj2piO5M6lphxItIY4Ew/uY94dko48UHmBq042EKB83zKMvgOzJHFQ7xj1qmp3QvgV0dU/x7eCNgs22p9QCzX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214383; c=relaxed/simple;
	bh=zT2RqGd3nP3UCMWCKPndkuHNOyLMnz4Yhzwh6iq/cJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEoR44fIbb+ZWV9R5bZGFw0XLt2cF458lcrlSbzZVH+ymuHXaYpFHZnEHw6xQIaPtPjLz15lQGNTVBOxDWWSwxJNiSSlWTYq1pjtxouygAelCalArsJUIYJ8cjmljmbRBT7/NVn3jCRhYs3PAPFcmAHdb/eLXSHYn04WAnPloeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oboa1H9y; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oboa1H9y"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65c30aabe8dso161166d50.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 21:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778214381; x=1778819181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=oboa1H9y9JkluHs31N75DGBo/EYrt4cLte5nFuGwSo/M2hmW6wE9WXBMq7CHzzG3TD
         TPGm4jPb/vrVDGa821PwncYWgs351tJUV/Tah4x3bvvrCQ/uIzgnsOa7YZd00VKoj4P0
         AmRikE+/VnB+mv9+Gt6X0YPT3N8saDCbgttz1UJ0x+uGyfv6PCKBE+00ClV4VG6yvVho
         mu+H0bBnDsaCuAs3K7eu9htRkcWDN84xC4Y0ua19RahqYZxmfPoUH/M7Ztq5cVevT05I
         pBk/ioY1il0IZZbeNmjfuhNUB/ywBkI67BVBOX0mdhi7fOlnTVZuC3bKsxLvx4sRHL9U
         WSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778214381; x=1778819181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYF9EK7KgmEP8ho0Nd5jF1xsN/C9b5ZrS1epvozHDgQ=;
        b=KDpgXY6fbqgcYxWnYnnQ99VhVIl01XWY36NtGCvE1/cep5MQ8exEqns3rFrpd93OPO
         0JRUiNdRFGbryfrmvxF5ZEezHR3YBD+4mcuVwxRtCi3i9Tggek7gx9QcA0NOtQXD5Pi5
         n/p89GHcmc2VXDxbFkpKQ3eHgyF/8vVR/oDDmPauDbs2qzSiuuoABnSeDR3hjDqSmZ+K
         CipvEkahHpM8LyUmpOzCmkzRnH6qG4q4zoCWyjS2WX7LjTquzCgn4MTGgOUDdqRkEcQB
         PcTKc1f5cpVWO4ynETFpJ2DWVfJbqbSLg5Mye4tnbJSvwmCGQwVuRuTyTiRYr4IjJiBR
         zucw==
X-Gm-Message-State: AOJu0Yx3gO7Bgo42+rg07xwbu+AhQLsg02ATxuGi8oRXGy6Dme1axaqF
	8S7sHJCUv6z4vRdf4d8l4Re+5NU9Rnoanh2S+RZjiWk/e61cPPew7atCW0EyWA==
X-Gm-Gg: Acq92OGIxGjW4ew5ULmFl9bQH3UeyMGh0a0DVmVHGQzK4UTM1yo9ZuIpmAMzmKS4XJr
	oBA+/Z8iUz49uXHnrWUFTlaquzvpS0GFxYOFv0qbpik/qFQmrwTqo2EN2d/AY0Vxwyozhe7iHMF
	0kg2vEvF3zko26HT+ioTIz7xYdxxYWj6YEbfkXNTWlTO2L/DXX6kD4x5qg7GdWaCMrZJv6vU+15
	OqthWeWjPV4Vi+qGzxA2nFJqW4lvcaDesPpJvyZ8lIlrqGvft69Lb2I7n6gNfLQursz8lWZF4EU
	qFmI9XPP/42WUVGIECezJF6gZ33KQtcfoxGMirBlt5Jszmjj6ybH5yxX9cNKZlFshS3SV0OLyYK
	5Mu8i18dK6oSIYRk5o4hUmzKSUmiBcyf3i+PpksgL4Ex/38TM4eZhKDw2oSG4eXNFci/zVYe8nv
	8w/E2YYo0tXyWbtoJunUrdqHCcELiruVetm58=
X-Received: by 2002:a05:690c:6a0d:b0:7b2:1fd:8918 with SMTP id 00721157ae682-7bdf7a7ba8fmr65419307b3.0.1778214380591;
        Thu, 07 May 2026 21:26:20 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66891246sm102265447b3.46.2026.05.07.21.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 21:26:20 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v14 net-next 4/5] selftests/net: Add bpf skb forwarding program
Date: Thu,  7 May 2026 21:26:09 -0700
Message-ID: <20260508042611.130945-5-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508042611.130945-1-weibunny.kernel@gmail.com>
References: <20260508042611.130945-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Wang <weibunny@fb.com>

Add nk_redirect.bpf.c, a BPF program that forwards skbs matching some IPv6
prefix received on eth0 ifindex to a specified dev ifindex.
bpf_redirect_neigh() is used to make sure neighbor lookup is performed
and proper MAC addr is being used.

Signed-off-by: Wei Wang <weibunny@fb.com>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Tested-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 .../drivers/net/hw/nk_redirect.bpf.c          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c

diff --git a/tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c b/tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c
new file mode 100644
index 000000000000..7ac9ffd50f15
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF program for redirecting traffic using bpf_redirect_neigh().
+ * Unlike bpf_redirect() which preserves L2 headers, bpf_redirect_neigh()
+ * performs neighbor lookup and fills in the correct L2 addresses for the
+ * target interface. This is necessary when redirecting across different
+ * device types (e.g., from netdevsim to netkit).
+ */
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <linux/if_ether.h>
+#include <linux/ipv6.h>
+#include <linux/in6.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+#define TC_ACT_OK 0
+#define ETH_P_IPV6 0x86DD
+
+#define ctx_ptr(field)		((void *)(long)(field))
+
+#define v6_p64_equal(a, b)	(a.s6_addr32[0] == b.s6_addr32[0] && \
+				 a.s6_addr32[1] == b.s6_addr32[1])
+
+volatile __u32 redirect_ifindex;
+volatile __u8 ipv6_prefix[16];
+
+SEC("tc/ingress")
+int tc_redirect(struct __sk_buff *skb)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct in6_addr *match_prefix;
+	struct ipv6hdr *ip6h;
+	struct ethhdr *eth;
+
+	match_prefix = (struct in6_addr *)ipv6_prefix;
+
+	if (skb->protocol != bpf_htons(ETH_P_IPV6))
+		return TC_ACT_OK;
+
+	eth = data;
+	if ((void *)(eth + 1) > data_end)
+		return TC_ACT_OK;
+
+	ip6h = data + sizeof(struct ethhdr);
+	if ((void *)(ip6h + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (!v6_p64_equal(ip6h->daddr, (*match_prefix)))
+		return TC_ACT_OK;
+
+	/*
+	 * Use bpf_redirect_neigh() to perform neighbor lookup and fill in
+	 * correct L2 addresses for the target interface.
+	 */
+	return bpf_redirect_neigh(redirect_ifindex, NULL, 0, 0);
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.52.0

