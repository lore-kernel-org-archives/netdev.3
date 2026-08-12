Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726D744C4E3
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540377; cv=none; b=bZLYVBqtM/tmR885TkQDLz6C9i+e0GsmhHn9t6TuTPfhskQRO6on4Zr7sq/jG9OI5ZkXvWc/HdqMSdppXPS0/7ULjZgv1VCzE+Tpn24JPdOwpTsBqXcAcofL0CVY+zHY3y9wv+Yq29D8nijLhinjZWIRoi7k/W5jfF/LTvoI+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540377; c=relaxed/simple;
	bh=uR7tLD9tHL/cwz88WSK+sk6wlsliROfYasYpTO2rQBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skGrK+xikvAfZelpUpPTPc0huRllSVpbt4hWDab3jgF107t+N0P1AbwqrEqBoC2AGN6P/5KT2lJZi+oaNe3rVzA7xBdDhnG3jVz2+Ij9EFKZY/CrQSEuPxnrxtUjguXRy+piyJaqud1Tzzxpuur11iA6VZ12+j3I6G9xgJUQjvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rlSsSxAl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlSsSxAl"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf50c6f235so14511165ad.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786540375; x=1787145175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/5wq8SjRQDnjDD/nj5u1RP7jbzgzqJw5MxXBBo8cxuA=;
        b=rlSsSxAlG0gjWmCy1W5ZyiTTZX9LD5XFceMdtunowveKq50DOsfRxR/lPupGElkyUj
         AvOpt+wSKnEqkpeSDdp3YX4bMNssgp2pzBQL4NPogLeRCPSdAdxlMwnvLNdqtQD76/5q
         5MRVQjREDAoAwb4mKBbp63lXgeYXJQJ4D328cr6x+jHl2Y24wGrAyN+8XxbWRj9Ior0b
         obT3V/GeAGAbb5KrkiriEpBa9k8n8NZx3ZWi75oZgFRN88akimyCFiUJbZ1nvOLaRk+a
         96FrTBtICiEWbl394CjSxi0hDnYmw7CXoN2VCkmfdKcRwLT/09RjgAYAQrhvdJYDHqt2
         RRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786540375; x=1787145175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/5wq8SjRQDnjDD/nj5u1RP7jbzgzqJw5MxXBBo8cxuA=;
        b=DWV4mnCHFQDlSP/iPi/SywKTsndZ1KQdkJGPbUxQjAoo2XQq8gbws26q9giD0wBlLm
         uPdnGP6SUsGUdsXMpc24u/dJ+VtSLfoCo1Q34PlJQ6JqwEx2RmY+BOe6upqJdOFba3BJ
         jXZpqjiVSWD8GhI/Yy28OT8yE1DWBg++Icdbvk3IUOFKImTOk3z9otEIuK/7MaxeksHu
         zw4XWPENSxCmwKbTHqXLRwS4Lyei/9YPqWCGUoqxgyzU0dkfU1zre//86JhAf4x0XRD6
         1LU8onGppoWqyqWD3VG5RLaKvIzhcxXg9iML687M9SgIYZsI3eyuUw2tFyXX7ycitzps
         zS5g==
X-Gm-Message-State: AOJu0Yxdra4Jur9qyX59NeUK19AbuxL/qj0Csj+cTLKDL5WfgNZ5zrlg
	HSLosXPjM4pXe7T2eZCH+SlvRlX0qZYTlCzaNZQMwIhzGsGaeuF3UH7n
X-Gm-Gg: AR+sD10rqrwaqRDP5no2pYChBFvO8EBXqFeWYdrBmXeUJa7HK9c+4sUwPRjoQ5jdvTM
	kD5dpaNiTmkp1sbwPsTiA/q+yHjETzQNg2zJvqlYPrt+x/3x1Uvs2eSjDY4iyeVAyUyX7Dy3fou
	vasAXwN5EwOcs84UHB7VaznMPYfpUClAnwBy3x2tiRWRLMuwRKS/+0nVe8HF4XmCXr13xRDxqDr
	FxWlymiQRfoe1y+YRKgSXY3plaFmo0krHBjwS6CaCZ9ArRh3ErcZNhqZH/WfNBlY3B+490vnUKz
	UiLz2QJyxlttTDWDQOMQcN/1EUzEZradyJuL9I6ZkbSWEGwj7/qlQR3JwQ4B4ulXa0IZ0p2f/hW
	VcHRPQh4plDVFujeIaEdmM3S+gY4PKpXBmB3rYTdptjJ6kh8ml0ybYQabsimZK6pAUvI9rW0MZe
	cEZT5TekmBQerZtvU1TvCuGmacckXyRRhVGW6EOBtw0SVooxYc0GIS1lYpIie4qdjThIqTQIa/7
	+OyEHHRYDdnOA==
X-Received: by 2002:a17:90b:1b05:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-393012c841dmr4869497a91.11.1786540375411;
        Wed, 12 Aug 2026 06:12:55 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-392f94d30f4sm3834159a91.14.2026.08.12.06.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:12:54 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: tung.quang.nguyen@est.tech,
	jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH net-next v2] net: tipc: replace deprecated strcpy with strscpy
Date: Wed, 12 Aug 2026 13:12:23 +0000
Message-ID: <20260812131223.205450-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <GV1P189MB1988E14B7ED2564A4D8D0FFBC6DC2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <GV1P189MB1988E14B7ED2564A4D8D0FFBC6DC2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `strcpy()` function is deprecated and moving towards code-tree
elimination. Replacing it with `strscpy()` fixes potential buffer
overflow vectors by ensuring safe NULL-termination based on the
destination buffer size limit [1][2].

In `tipc_bearer_get_name()`, the 'name' parameter decays into a pointer,
meaning `sizeof()` cannot capture the underlying array bounds directly.
However, all parent callers allocate this buffer using the
TIPC_MAX_BEARER_NAME macro.

Replace strcpy() with strscpy() using TIPC_MAX_BEARER_NAME as the
explicit destination bound length.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Link: https://github.com/KSPP/linux/issues/88 [2]

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
v2:
  - Target net-next tree instead of standard net tree as requested by Tung Quang Nguyen.
  - No code changes from v1.

 net/tipc/bearer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887..951bb474c7d4 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -209,7 +209,7 @@ int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id)
 	if (!b)
 		return -EINVAL;
 
-	strcpy(name, b->name);
+	strscpy(name, b->name, TIPC_MAX_BEARER_NAME);
 	return 0;
 }
 
-- 
2.43.0

