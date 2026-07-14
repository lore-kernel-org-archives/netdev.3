Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2EC2F12AB
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050886; cv=none; b=oytATA+aO5zXDDv2onKGROwqR2TCX3e6qyn0kVsyDPj/ik8LptF6x4KyIo2jR6cVco7029PWvyflGaVSALujsVYv2P5E3PBSLp4KGbU7GfXg+xpJ6WTfAFWS92Guj9tPLtLauF6/YZ7SH5+dz5S+nVAIg944bMR0lVHaLcSBqVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050886; c=relaxed/simple;
	bh=uwYEAAseGuiIqJKLvH0j4d0K5nxF8ikHm9QDZEG7tls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6vXN0ax8Sf9hqZQusLmV/71u8hdK6mKLY1vzI14XWiHuc9Rt8RnkhZoN+g9LWXPiKg9vvJrIxixMDwImY8FqJAdWuJeHBLlph3pNKEWKHRM0NzZVDUGwMgAu0LVDAkOziXFpyzb1C8wLQwGOP4YseIqtGoWNr9c3eicwoy8inQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es1qqCFz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es1qqCFz"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3847e8b0f3aso3843296a91.3
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784050881; x=1784655681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtAAp1v2R1o5+64p5FOI9tTm+W9MNlFWebATHzuqp8E=;
        b=Es1qqCFzTZa+y9cY4OP1PWSnjIwDi/N0ORq2RyugmEOm4IEP6Myk3dcY6cBAzJH8Lt
         A6ZHjfyM8Up0KwYLqVm55m3y3X2bPIByrR8+j0g+118aUGREd9gHFufNoiHWGcwmPkKU
         XeYtH/UDXOwbGg9zalz6n0fjz1J/8umotVZ0UTNlYxNTuSBYTuiv46QttH/uy/TCjQgx
         CygQEYz330DFJtJH9pikqMkkT+Gzzr71f8ZxXVR+YgtqLou5IdR/NCNAjmD0Y+NDUhJC
         39PemLbZMWfvcsxtPmD28LwD0e0p51TkP9H76mR7np8NPCwEHNxZ4xpFQ0fwS9C9UFJV
         eslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784050881; x=1784655681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YtAAp1v2R1o5+64p5FOI9tTm+W9MNlFWebATHzuqp8E=;
        b=FqglEOPUnKfyofHTD8sYbRtNZWKeHeYngKFPCtnR9nlR2s+9/J1a7VGmwcQMNQP50X
         5VVXPeqf0fY/n8GImFjrZb0v8LyG01gdSbfvWJRt371BmAtCfrT4PoNBYvnhdNwvtMSl
         WO0jTx6puRB5f0zB6pkXpYYPEQyB+uFXwUHEfHzxSp0h+oeHbY3sTJ/6oZbGpkDs4DUX
         lbH6apmhL2XsgXdnB5moifwRx2BFbKnDnYDdhwMMrxwpbD3ePMjSNKeVVMqk/Tbf0oI3
         xI66iHWoGrbm6kGPyvxrKSLjjo5yvt4e0MdIVx46PlT0v6XnPqNv+wjZK1L/mol6+pOi
         LaWA==
X-Forwarded-Encrypted: i=1; AHgh+Rqdu/M8OppAXNECNbo02jjzAx8cAsIIm1FXSnAEsUYGnVXK1ykEIlbSZ3zh3IWLt/NKbYfl7i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywI7yuT/du60QroNARoKiZH7Za8zL2g7ZpSMLT0zSmiq8SWiLq
	NEKTRghhB31mTgqTwCFDQLkiqfIkHmukFkjBV4FNkb0MyFAxQ3HHXoRWxZ5bh7xI
X-Gm-Gg: AfdE7cl6WOaNtw6NV1LsPXONPEB1w0p/Ov3xr8mKB035KN/6d1RoEioxTjCXxY7tQj0
	5w1W4ldbR+mtVRs669CdgSEDI284Lk8vjYHeEd6cJk71+oEnRIXuVBMhf6QhB6Cbr6bhSRKYO3T
	jFoylOB3o3mikTJ8mIo64sa+RZN6pYks0EuDpchTxBt3ENrPE+KyjBF5PDWPImtF1QWJITTdYgN
	0++myA7U2BUdDEyBrVKIOENVPI1wrCFNZ7vGoStQbcSnF5B2+Bh4zgogy3ydBY8W8GInqCxKxmk
	zZX0bAPxvXXCt5TepLEiwL0YLqeXy+vTi7j3VtWVHqhSHwUV1VU+x/Gajxz0zcnFnM7Wa0vhQza
	4U/1CQ40Y3mNrT2jZT1FmJ2xl1fHgR4FHgGSTwxmmKgKNte/51PPtt5XYTxtlxcyEsALEF27k4/
	m4q74MwwqRgryw8mleLPPrQ29hGoARL+b7r10osC5Dfxu2GMSniAxAtsSn3w==
X-Received: by 2002:a05:6a21:730c:b0:3bf:6c08:fb94 with SMTP id adf61e73a8af0-3c110a207b0mr17047615637.54.1784050881193;
        Tue, 14 Jul 2026 10:41:21 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b87b92b27sm38055954c88.6.2026.07.14.10.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:41:20 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hoang Huu Le <hoang.h.le@dektech.com.au>,
	Xiang Mei <xmei5@asu.edu>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v3 1/2] tipc: guard against empty list in tipc_node_xmit()
Date: Tue, 14 Jul 2026 10:41:09 -0700
Message-ID: <20260714174110.1571033-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714174110.1571033-1-bestswngs@gmail.com>
References: <20260714174110.1571033-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tipc_node_xmit() passes @list to tipc_lxc_xmit(), which dereferences
buf_msg(skb_peek(list)) without checking, so an empty list causes a NULL
pointer dereference. named_distribute() can hand it an empty list when a
bulk allocation fails. tipc_link_xmit() was already guarded in commit
b77413446408 ("tipc: fix NULL deref in tipc_link_xmit()"); guard
tipc_node_xmit() itself so the tipc_lxc_xmit() path is covered too.

Fixes: f73b12812a3d ("tipc: improve throughput between nodes in netns")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/tipc/node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 97aa970a0d83..fc241e7b0c1f 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1695,6 +1695,9 @@ int tipc_node_xmit(struct net *net, struct sk_buff_head *list,
 	int bearer_id;
 	int rc;
 
+	if (skb_queue_empty(list))
+		return 0;
+
 	if (in_own_node(net, dnode)) {
 		tipc_loopback_trace(net, list);
 		spin_lock_init(&list->lock);
-- 
2.43.0

