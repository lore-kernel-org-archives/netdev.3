Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C672C21DD
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 02:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293451; cv=none; b=Z2J6RKVRlZvnoQcthOgExYUBB87eDX0WyDeq85KgyY5l+BiTVcVtD4j/UfprsS2RNkXYwAYlEQ97cljM1Xsb3BNBi+0Q18K/wEa+/X2dHbXFMCL1mvKdOvMlB6brN1EJ7UIGdufk0238pViqRR6A5IOqPXywN8nx1L1wLnnniGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293451; c=relaxed/simple;
	bh=rPJFZkGtwrX2pQMhRZZMHDDU08eWfWAGLeoxNKOZH68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdnwdSmJfCUzjLrPSEjC3oSPZkXzh8ss49sQa9p9Z8BA7IJ6OYp+SyFr1bnQKoQjhdlLgxZxnGITAcLe3iK5wDV5DgQ9823bErNcbycttnWNYX+PpwoKB/mRGQCap0cC9aIkuFw4v2epD+zkqPoj0Cid+Gkta213gOJnRlMKNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTzX5kpV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTzX5kpV"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ad135063so21644385e9.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 19:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778293448; x=1778898248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1b4LBBskxvqPCdKTAUNKqKkfrowzZ4UTM+xyHgZ7qXE=;
        b=PTzX5kpVwC/F0KVK+tu/DLeXCp5qOIWQPrk/60YvBhUJNaY6wrddYC6lBMu+PKuBwi
         lYvoo0d7jUATVuy2DAxCXeQyeXum9f/l7LXZUFu3EkNJX3HXl+aAcMZUPGwis/rj7GVl
         TDxl12jRt5rxKX1zJINh/8QcX9LFfuS6CK9MtgtAfUNchC0iNUJ7gH3jVnrA/ynkO307
         HCwtTm4YwsI5TKssBYr7R/EhPgvsxWpVnb8C4hdcHcLybsbjAlyml0Q400vbReMF/ZyQ
         cEeZb1ABXrr2Nk6UXsyf2oj/sU8nCzcejOq6N30vJndiaGST/3WGD+afsuTX9Dhfahzo
         Rxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778293448; x=1778898248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1b4LBBskxvqPCdKTAUNKqKkfrowzZ4UTM+xyHgZ7qXE=;
        b=RZVLEpiu+tmiMjDmE/Ef2XGuRdESj5yB6SJcqAZ/8Eu6EJvXfhbGj2UevNf9AU7rrn
         aVDgcr+/5KRsbmTH/kQ6Hnwilts/J0wt1F23cw8//iruoOTBtmf2DfAy0fNQzRGfzSD5
         g4X1xkEqGKDnINsNcgRkj5H2rUbQJZ5p+ofW+KHuhfq53n67H1qNO98o2UUgcnDkrHqT
         7WFauz37wZ7clGJMYZH2siEDmaCIn/NRrAOhj1zJ3uMyiWVKkUxjZfFetkjGLNYxn5Rl
         QJdzPGI8HudLvIB1l9E+E4TnANysX3Nc3VslWLjR8kDTeqYWNtKIOkTMLQl+A5IZDbNV
         kVkg==
X-Gm-Message-State: AOJu0YzaMmbI5m/kueY1DtnNVouCh1NHlaJrmyXuk3xFOVSGsOur8ca0
	CVs0Pb+6X6rjdZF2bsosEfqXLV2FWnzJkueEvcfYpPIjdkg2aVpWc9dZ7D4poU+d
X-Gm-Gg: AeBDiesG1RdqhalukDS6fzTvGPNghRenWrB83meaIIum4BQgsExtc6FyWi316DG0PV4
	hMeqo43LplYjqnNkLqvX5IeDuerHxKlmOKW6ufDIFdRrh/7n3Y5y9zAO2q7tutsFfeuauOi3ky5
	nP73B8PevN8lJ/64dF8+ZskzNgbgCODv0srg7TfPlnoI9EElnm+8AlLcl7irOwpiwyQLKCrghDY
	9ThrfBb/FU/RZEJ+aEBUA2OZ0TIq+oCxbmYFcInBq3IhuJiXwjv6fx78cB5R0U+OsOAWXkH1Q/b
	KS7zxerR5h9zlHol0LUU3T2ySTGOxDcbVNyhBn0pTM6KyFW227bdFhmLmYGYx1P12Cb/xoAiN/I
	gpExHwo4QWd1OQieEmAAxcEjPbU3YnbVYHkoDNSbghxJmG7mVVeISAKBxzdbZ7LMDZ5JPf0QESX
	qxn/KeuC26cy2NyvJhE0cOq6tYAOJsYqQ=
X-Received: by 2002:a05:600c:c058:b0:48e:6db3:ff33 with SMTP id 5b1f17b1804b1-48e6db40058mr27484335e9.14.1778293447565;
        Fri, 08 May 2026 19:24:07 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1f::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e0c70sm15266355e9.6.2026.05.08.19.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:24:07 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [PATCH iproute2-next v2 3/6] netshaper: Extend show output with parent, bw-min and weight
Date: Fri,  8 May 2026 19:23:50 -0700
Message-ID: <20260509022353.3470738-4-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260509022353.3470738-1-mohsin.bashr@gmail.com>
References: <20260509022353.3470738-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohsin Bashir <hmohsin@meta.com>

Extend print_netshaper_attrs() to display parent scope/id, bw-min,
and weight fields in the show output. Replace the switch-based
iteration with direct attribute checks for cleaner output formatting.
Use print_rate() for bandwidth display so that sub-Mbps rates
like 100kbit render correctly instead of truncating to 0 mbps.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 netshaper/netshaper.c | 100 +++++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 35 deletions(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 186076a1..83bfd2f6 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -71,53 +71,83 @@ static int parse_rate(const char *str, __u64 *rate_bps)
 
 static void print_netshaper_attrs(struct nlmsghdr *answer)
 {
-	struct genlmsghdr *ghdr = NLMSG_DATA(answer);
+	struct rtattr *handle_tb[NET_SHAPER_A_HANDLE_MAX + 1] = {};
+	struct rtattr *parent_tb[NET_SHAPER_A_HANDLE_MAX + 1] = {};
 	int len = answer->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);
+	struct genlmsghdr *ghdr = NLMSG_DATA(answer);
 	struct rtattr *tb[NET_SHAPER_A_MAX + 1] = {};
-	struct rtattr *handle_tb[NET_SHAPER_A_HANDLE_MAX + 1] = {};
-	__u32 bw_max_mbps, scope, id;
-	__u64 bw_max_bps;
+	__u32 scope, id;
 	int ifindex;
 
 	parse_rtattr_flags(tb, NET_SHAPER_A_MAX,
 			   (struct rtattr *)((char *)ghdr + GENL_HDRLEN),
 			   len, NLA_F_NESTED);
 
-	for (int i = 1; i <= NET_SHAPER_A_MAX; ++i) {
-		if (!tb[i])
-			continue;
-		switch (i) {
-		case NET_SHAPER_A_BW_MAX:
-			bw_max_bps = rta_getattr_uint(tb[i]);
-			bw_max_mbps = (bw_max_bps / 1000000);
+	if (tb[NET_SHAPER_A_IFINDEX]) {
+		ifindex = rta_getattr_u32(tb[NET_SHAPER_A_IFINDEX]);
+		print_color_string(PRINT_ANY, COLOR_IFNAME, "dev",
+				   "dev: %s ", ll_index_to_name(ifindex));
+	}
 
-			print_uint(PRINT_ANY, "bw-max", "bw-max: %u mbps\n",
-				   bw_max_mbps);
-			break;
-		case NET_SHAPER_A_IFINDEX:
-			ifindex = rta_getattr_u32(tb[i]);
-			print_color_string(PRINT_ANY, COLOR_IFNAME, "dev",
-					   "dev: %s\n",
-					   ll_index_to_name(ifindex));
-			break;
-		case NET_SHAPER_A_HANDLE:
-			parse_rtattr_nested(handle_tb, NET_SHAPER_A_HANDLE_MAX,
-					    tb[NET_SHAPER_A_HANDLE]);
-			if (handle_tb[NET_SHAPER_A_HANDLE_SCOPE]) {
-				scope = rta_getattr_u32(handle_tb[NET_SHAPER_A_HANDLE_SCOPE]);
-				print_string(PRINT_ANY, "scope",
-					     "scope: %s\n",
+	if (tb[NET_SHAPER_A_HANDLE]) {
+		parse_rtattr_nested(handle_tb, NET_SHAPER_A_HANDLE_MAX,
+				    tb[NET_SHAPER_A_HANDLE]);
+		if (handle_tb[NET_SHAPER_A_HANDLE_SCOPE]) {
+			scope = rta_getattr_u32(handle_tb[NET_SHAPER_A_HANDLE_SCOPE]);
+			if (scope <= NET_SHAPER_SCOPE_MAX)
+				print_string(PRINT_ANY, "scope", "scope %s ",
 					     net_shaper_scope_names[scope]);
-			}
-			if (handle_tb[NET_SHAPER_A_HANDLE_ID]) {
-				id = rta_getattr_u32(handle_tb[NET_SHAPER_A_HANDLE_ID]);
-				print_uint(PRINT_ANY, "id", "id: %u\n", id);
-			}
-			break;
-		default:
-			break;
+			else
+				print_uint(PRINT_ANY, "scope", "scope %u ", scope);
+		}
+		if (handle_tb[NET_SHAPER_A_HANDLE_ID]) {
+			id = rta_getattr_u32(handle_tb[NET_SHAPER_A_HANDLE_ID]);
+			print_uint(PRINT_ANY, "id", "id %u ", id);
 		}
 	}
+
+	if (tb[NET_SHAPER_A_PARENT]) {
+		parse_rtattr_nested(parent_tb, NET_SHAPER_A_HANDLE_MAX,
+				    tb[NET_SHAPER_A_PARENT]);
+		if (parent_tb[NET_SHAPER_A_HANDLE_SCOPE]) {
+			scope = rta_getattr_u32(parent_tb[NET_SHAPER_A_HANDLE_SCOPE]);
+			if (scope <= NET_SHAPER_SCOPE_MAX)
+				print_string(PRINT_ANY, "parent-scope",
+					     "parent scope %s ",
+					     net_shaper_scope_names[scope]);
+			else
+				print_uint(PRINT_ANY, "parent-scope",
+					   "parent scope %u ", scope);
+		}
+		if (parent_tb[NET_SHAPER_A_HANDLE_ID]) {
+			id = rta_getattr_u32(parent_tb[NET_SHAPER_A_HANDLE_ID]);
+			print_uint(PRINT_ANY, "parent-id", "id %u ", id);
+		}
+	}
+
+	if (tb[NET_SHAPER_A_BW_MAX]) {
+		__u64 bw = rta_getattr_uint(tb[NET_SHAPER_A_BW_MAX]);
+
+		print_string(PRINT_FP, NULL, "bw-max ", NULL);
+		print_rate(false, PRINT_ANY, "bw-max", "%s ",
+			   bw / BITS_PER_BYTE);
+	}
+
+	if (tb[NET_SHAPER_A_BW_MIN]) {
+		__u64 bw = rta_getattr_uint(tb[NET_SHAPER_A_BW_MIN]);
+
+		print_string(PRINT_FP, NULL, "bw-min ", NULL);
+		print_rate(false, PRINT_ANY, "bw-min", "%s ",
+			   bw / BITS_PER_BYTE);
+	}
+
+	if (tb[NET_SHAPER_A_WEIGHT]) {
+		__u32 weight = rta_getattr_u32(tb[NET_SHAPER_A_WEIGHT]);
+
+		print_uint(PRINT_ANY, "weight", "weight %u ", weight);
+	}
+
+	print_nl();
 }
 
 static int do_cmd(int argc, char **argv, int cmd)
-- 
2.53.0-Meta

