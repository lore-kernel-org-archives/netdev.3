Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BAA3ED132
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786399843; cv=none; b=Du4JEy7LMCVl/+QZBzQ1mE+D86PRXz6q1730BGm6KtPukumhFX2rDTad5L052lPvdvQe4TIrZybathI3fO1BDb+gGLmXy8qD0M5YcEbWb9ZzJpyk2HwDOYFirpyYPa4NmMvaTUa4ZaKp7HCg2iAJiq8zf1ZsDR5y3AnAjOPKz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786399843; c=relaxed/simple;
	bh=+vyoAMTlwmEGbof4bMxmgk90RIXqVlKcKeRZlqjp1cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBwHbJDFg+8RPm2PbMwvaeCgzlJ8RFF4rIFIZG7eJBdsWRrLPjPSXLqN1QOOD9jMlxrHxF3qSQDuBOhWSqQPoPXNXThzpaXLWNvhBOR+n0sfTbhFLJJLFoAxjolwvr/SgIg8J9OqXWD5sk1pLcuKJ4QFq3Ej19MfDuGD28pzO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=OGP8BmVA; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="OGP8BmVA"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso3068961a91.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 15:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1786399841; x=1787004641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GMn9iDYzK+mzxIlQbYoX1t508noteCegqfO7arIOGKg=;
        b=OGP8BmVAJGzyRO8M/zxWo5ohbf41WJXFwU70H7eMQxXovcMWr1hAfF6g8avV+WuB0i
         MvVDmyLv01NZeRR+S2TFquHl2TehU6PdyT6TzJj4XXXhDMkNGRuXJnEPIwB/+sr7wXVv
         llPg/ieZPvXIB70zAGs+BGpxPkiMiga1ETSKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786399841; x=1787004641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMn9iDYzK+mzxIlQbYoX1t508noteCegqfO7arIOGKg=;
        b=E2+QS2IeXjTd3zIPO7frdxOeNhtq2eeUUFvMn9yGB/C6KhMXe/7U0ca2F/WL2gTs1l
         BBWoE4R/EV9myIwR8kVcoWicjJCulHBQZmdsQj3pb5o3Y/apS8mUPC7OMoulAgyA7O74
         ADWJzDmyreXY8C6BZr7uGbQY33syOB0DhoApV+o/BYoJwjYXAxUz3MKET3hWG9GgIWnl
         Pey6CUjkNqDssgpsPHLuGk+Eqy8FNfVssIrkHQ4Jx63oGO93O6bfnPOUC3pbz4SAQwol
         nSksJi9F4qKZ3WddNHPzh2xML/TCP8of5UDf1gCmHNchtPKVqduVa/D9FC+4EXaZJSsN
         RVgg==
X-Gm-Message-State: AOJu0YxxQzm3xulGxA1QEwN80Dywh9eibPTfRrX9fA+U+lKWU+fC1Tw5
	ajqXrqL4oHlJErMq0kJGP9u/6x4R/a+4qME5t65jgZBvaE2nCSvfQOmlUMrHT/OQkpBfOF7TytK
	xQjILKJ9wIg==
X-Gm-Gg: AR+sD13VI/A4uhNrXTU9RkoN2ezZfloGNhjSTUD/v3SfePQCG2m5JKCAzrrSuoipxmR
	SC8miaIHahfbwDg4b32v+1gZG4DZeYRL0ui7Art57Ci9P3KhpXB1zfj3gOSRDRVaccg9/6cUV1y
	OPO389JLCXM1PvXIg0Do+u4fdUqLr1Pmk4WnlX6VOg4MsMWr6yut8GHdvPC1ysTOVmIapQRu/IO
	mGzJO+LPFcqnmkuaHEJ1iLmQ26IQayqhFCSexNdHrnyH61QyQ6K30C9AUWZhqR+ogkfcBR/yNls
	p/v2X4BSN9jpdQqHAZ+gaSgNnpUf19ysGYYj5HK2ma8LArM321AItLOqn4ecZk9vfSWLcZvDm5Q
	0WMX8tL4pedhVYtgy8IXpgrwsZrMKg6hL9GaocC7VkIbmL+xr1zveatPPY9fvP9VqiLNPygWFD5
	qmFCkdUWb35UL2Sc0kIfxRExti5QEd4MElrWImU4joOXYQQSMKgJUwS16DCkHQ3e3SSsE/kJqBC
	pZ/87gvo6jNvadMAIevLmVmamivvf1WUOEHAyPRoZXKfV9yZutusLmW+wdbnMjh
X-Received: by 2002:a17:90b:1d47:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-39261f724admr30384368a91.1.1786399841085;
        Mon, 10 Aug 2026 15:10:41 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b7b39bsm38509700c88.14.2026.08.10.15.10.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Aug 2026 15:10:40 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] ipvs: reject invalid states in connection template sync records
Date: Mon, 10 Aug 2026 15:10:34 -0700
Message-ID: <20260810221034.33751-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPVS sync receivers validate protocol states before creating or updating a
connection. For connection templates, however, they only log states outside
the template state range and still store the value in the connection.

A template can be returned by ordinary connection lookup. TCP and SCTP then
use the invalid state as an index into their transition tables.

Reject invalid template states in both sync protocol versions before
looking up or modifying a connection. The version 1 path handles both
IPv4 and IPv6 records.

Fixes: 275411430f89 ("ipvs: add assured state for conn templates")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Kyle Zeng <kylebot@openai.com>

diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 93038ab..6f0c2a4 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1002,10 +1002,10 @@ static void ip_vs_process_message_v0(struct netns_ipvs *ipvs, const char *buffer
 					pp->name, state);
 				continue;
 			}
-		} else {
-			if (state >= IP_VS_CTPL_S_LAST)
-				IP_VS_DBG(7, "BACKUP v0, Invalid tpl state %u\n",
-					  state);
+		} else if (state >= IP_VS_CTPL_S_LAST) {
+			IP_VS_DBG(7, "BACKUP v0, Invalid tpl state %u\n",
+				  state);
+			continue;
 		}
 
 		ip_vs_conn_fill_param(ipvs, AF_INET, s->protocol,
@@ -1162,10 +1162,10 @@ static inline int ip_vs_proc_sync_conn(struct netns_ipvs *ipvs, __u8 *p, __u8 *m
 			retc = 40;
 			goto out;
 		}
-	} else {
-		if (state >= IP_VS_CTPL_S_LAST)
-			IP_VS_DBG(7, "BACKUP, Invalid tpl state %u\n",
-				  state);
+	} else if (state >= IP_VS_CTPL_S_LAST) {
+		IP_VS_DBG(7, "BACKUP, Invalid tpl state %u\n", state);
+		retc = 40;
+		goto out;
 	}
 	if (ip_vs_conn_fill_param_sync(ipvs, af, s, &param, pe_data,
 				       pe_data_len, pe_name, pe_name_len)) {
-- 
2.53.0

