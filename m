Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AE738B7B0
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522347; cv=none; b=HX/64xjCBQXSCxSJBdPeHgo+yvDjtuaELHA4mGXqiW8aTr/8DVvG8wRkixyvo3qvypwQq9qGmAr9xmohHRMggM97OjWyjOl5NrfpXDuPH3N1Qe9Lq8Qe6x8eQqnMYhxG6mbTGhWFDUYE9nyZ7wBx5POYmtjCb4tDzErpuIpmIDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522347; c=relaxed/simple;
	bh=4DYiEOsZKjx/4f4PSXfRJejITB67NJXF4cNdrqZROfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XwLK7UqhPaiyG/Qdq31UnsyigYRO+tNAcyfrcHWdXYKsubWl8Y82knQlh3fp1U7j3ioO3n1DbfSiSMUD+2nI2HdVeq4JMd2fucCZ5UQP2K/U8/ggjdZ4kYEppIMw8jt2dqChvT4TBgyvkXzQ8cxgf1l52PC1GkSOJnOBs+OzE8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glMIBwnc; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glMIBwnc"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so1111326a12.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788522345; x=1789127145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ypdm6ycnQEZOWN8WJPUUE2HwMGTgKp4dCj8wtNt7vJI=;
        b=glMIBwncTttwvAe5mGxgfuLlNw2tGMxm8GK/vE00V2EV+D5nQR4OM6pDKnTCDJrarr
         VRIIWrSu6Be0a4wwUH4gjT8BU5fH1e37niqC+ldAEXYVqls70gcwILPRRkzbx7xiHlwo
         J1qS6IFF5XtXKY5Rf9gUlzA2eHQRg9qSOWhVh/M2Q/KayChmZdJnhnjGVCfLMD2Gx3qh
         qg6L6OBBKVIizJqTTuMEq6xrsiI95TFv0ww/I0nj3vRANAIJEwlWuWQ0w+elFtwMZxRN
         EGjA5Q8W5qjTrdOW4B0X1q3TpCr/6qsCZ1PLme9zvwwwKlzwtNqiVV3+IRDknIlfRDYA
         KJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788522345; x=1789127145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ypdm6ycnQEZOWN8WJPUUE2HwMGTgKp4dCj8wtNt7vJI=;
        b=Z5bgsv5FiDk01GKgBRN2Jo1ftDtqd+bqsaQO2yLauMuCbYEzACAdM7SYj+eheqe27t
         hF9dk1Qzv1wA7Epypdjc9szYlrNZEKNzoJ9lB6VNeTXwn3qRzz8d2LTdDGliCTYDzUOG
         uFRVgVTLRfoQ7/dBUcne+LJSPIbbZAaWth5fUe2KzqSFrwI0wb6fq9ViBV0RiyLLx6Zw
         s9VyR+jwiSs5ULDs0ar7kpMUaD1g4dRlI4IpgcT7CN3m+Grn3aTYrPgcjn5tqSmMtuLQ
         qTgrRedNKKKOVwk+cMZrB41E2C8SI5bD6bn5mUIJMIwMSMxb9r3I44BpQQcS4MJ/l7sZ
         xiYg==
X-Forwarded-Encrypted: i=1; AKwUvByW3SBd2bLpkdZIObaUySGoXCgFJOR3XdPpfzo2SxkmJTXaD7ViAW9uYFOYsAXs23UCdlh4qik=@vger.kernel.org
X-Gm-Message-State: AFuF++kE4vcTO2tCeaQSGww6LjfmCZxvYzo8Is45Q2bbHueQ4wJVvmHZ
	FqyCOSsW+CXH75npkNTrRMJaChYrGhD5Wm3B6VvyeDK8HicCNzMF46+D
X-Gm-Gg: AYBFou1hsr99k/GEpbf1dFPddvwRa/rIBh/onJKmCnQ2TLZMOW1d67vukYS4GdL98X6
	tOXXw+581/Ean9ySfdCJFKdCyEeXz/EKGTrsXGpN68Xyyu5egetaMkRqoqQbem47UgbcRW9Elu9
	p+HAdZtirmfZzKaqabIb434b8uAjB5f0pqagujei04m5Tn+vo+5NUeqsBic1422+11Th/bV4yXL
	0Kmk2LzHed3A/zhApnooF0puP8qp+gxwO2TaLuubW487eDsSWfusgsK+49J1Gx6rnGXTOVPG+yF
	h8ah6oWhjbpcSBCLIJ42VIzq0LuOx9QTz/sANy3kv5ASttZdBB4+wuNuJcKZAQ4J/K9wMWycTJa
	okHEEJkXMtirFniIPsrXEnqzV1gTa+Z4ijoVdl7Lxxhj3oksSaoCDs9CIJWTm0zXTsCudNa17Yr
	tbtFnnB5s4tezUI/U+ZAU1pJASSO+FWVlv3s+DTxpC9/2PowOxgOJ+uu6bQgF6/7j6JtQm3CmG0
	sYeVYTaEitYeeuMpqmbuUUwNw==
X-Received: by 2002:a17:90a:e7c2:b0:398:9be8:ea66 with SMTP id 98e67ed59e1d1-39b261da126mr7004862a91.19.1788522344797;
        Fri, 04 Sep 2026 04:45:44 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm7148372eec.1.2026.09.04.04.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:45:44 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH] net: netfilter: fix typo "specifiy" in comment
Date: Fri,  4 Sep 2026 17:15:36 +0530
Message-ID: <20260904114537.29953-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "specifiy" to "Specify", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 net/netfilter/ipvs/ip_vs_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index ea5fdd4f4ce7..5ddde3ab2e59 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1344,7 +1344,7 @@ static void set_mcast_pmtudisc(struct sock *sk, int val)
 }
 
 /*
- *      Specifiy default interface for outgoing multicasts
+ *      Specify default interface for outgoing multicasts
  */
 static int set_mcast_if(struct sock *sk, struct net_device *dev)
 {
-- 
2.48.1

