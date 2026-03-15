Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7601D7E41
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 00:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533839; cv=none; b=Q6Gs0BQeebFc4FqBdIjZl9y1F84RXT+pITAXmHJHaJkvti8grxMpNl220hVQjbVvLXK7vowADK2fTr6ENDHs6WLl7PCnFW/K+LCcvUiCTJK/h/33Ygl3OTfOfIAmvJPJceG9vJSgwlZysJ5Yvg4qH9tpX6ZlQ5Owae9SwXg0avI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533839; c=relaxed/simple;
	bh=z9ZkWr4/6KmjSNqfEwUkobNkiQJImmML6i7C7LkQ3B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCvUsYJ6CHHi/7QQ7CeusIIabjo/npS4WpkSu2JofM1Wm8jqzQUSQznGTnHCLVOafdrl+L/4KBa6GfwQgtxbWXcl9PD2P7H9MuhHnVxEjslwxrqkJ/7PWOItgep9Ei/b0m35d5vH62f3tJHEMi1TQvBcWH2vMtDYvJZXKAIC67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=vPxVQ0D6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="vPxVQ0D6"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad617d5b80so24132895ad.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773533837; x=1774138637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPejLfie2ytKDgXeraompNiMB5CFt4LEr1l8q89IPmA=;
        b=vPxVQ0D6U2vDfacu/S1WibMqtb9ljMlrHXF9eqs2PItF1T4nQo7SRsdf4ZpF0W35+g
         bwkzrPwq4ibz6oEs/Jx75CDBGceaMbS6QDwyrjPs5vLgm0vEtdHIrdWQagP45TYz+oTP
         nPaMeslKOUwnmX5yWumvufzGxODv9Jl9/pWVbmiapDKsi6xHIAZbQYULw2JcPJYBqVp0
         El7H8hlo3GwP2rwX3xhx/mRx2ArYtqbzuFIPQyRfnugfnXGjRsRkvEAUHLZr5xaEqGDA
         GrIR26jhcRQoiII9Gk84HzfGr3H0s51gi60dOKlHn+5edubOgwOYvo8YZYnrBWxpw+Vt
         w5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773533837; x=1774138637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aPejLfie2ytKDgXeraompNiMB5CFt4LEr1l8q89IPmA=;
        b=AH3jsyQ2X1ca3kA2G6v84eb3QMGX4S/ATSTZxwtaNQoharr2hpH0Df5y4ZE4kicUhw
         31xJYjkvzyRH4FGYF/rVseYI2eNIniwfHGKPJo501ZVRn0U05IGjN7zr97Qqq8NdNmLp
         mK9hnC92alDX+Xl75JbQUKadmstG2NetTAdtaWc4n98t55aGkIk59gaZrZsKfq0t/iP+
         TnazKGUCuXemwGGL7NtH4+/jNCDh/q3uu1tIogx8VKtPiRNHoMIUc9bBslA00eSeUvuH
         bLlkbAfCRa6DqzBZ3YANqtcPVDx82NoZvyFexQrAfs1U3L2xrUf74ySFNK9MHvAq4y0K
         j7gQ==
X-Gm-Message-State: AOJu0Yy7W7csmq7hLyv3Yf4QXBNm+QzwaBGyQoDbtKle1meeYGGeP9tF
	GPsZozaTlaAzLuMd6OLy5rMVXOPpLscaa86HFlROJJ/VrJ4MyqXEFpfqJHf3wYyrZDc4VBJQ6Rr
	eq+gR
X-Gm-Gg: ATEYQzzqSVcFrF1zXepE9dZ5xl5IaQ/W006cfGVdiiQIqxDrWcw+WmBa+6V3UKNvDKU
	Z1q7DKBcn/07PZKRwVs+323Ty2KGvFKsHMrQyP8XrDRymvuQMlZ0RpXrj5n8574Q9QXAUVHVZQj
	RjxGVOiKmE88pbF2h7Mo3k8LROmdOjb6E7NdLiDhU05XKLqeHloGqmUtCju0koBfSPCQGRfbbrI
	RduenoQm191SzFTM+EH6ZxwKaJNmvBHu3tEaHy8UFbBCeDr+LpjwvGQFYf1pTW8jBHBP/OUqkVf
	zIe/b4VvOtSE3dzXG4X+puCM1pMQiOqhyEd+ghu+5CZdJZM1ZGLn7Oy/Bg/5j4aJkLlhoL/ZKSU
	Q4fFxXfijNeJ9+KfDSMaEaH5cTc6lgfPBrnrY5WDA2TiuVOo2csNloyCe7tsyYQSk/XnMWyZ+Yz
	nCuASk4FKC2ac5R8Gu2yxBV+rJWxoTYe1Y
X-Received: by 2002:a17:902:ea0d:b0:2ae:6887:5c13 with SMTP id d9443c01a7336-2aecac7680bmr85592555ad.48.1773533837210;
        Sat, 14 Mar 2026 17:17:17 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece86b12bsm74252425ad.91.2026.03.14.17.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 17:17:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net v2 07/10] net/sched: netem: fix queue limit check to include reordered packets
Date: Sat, 14 Mar 2026 17:14:11 -0700
Message-ID: <20260315001649.23931-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315001649.23931-1-stephen@networkplumber.org>
References: <20260315001649.23931-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The queue limit check in netem_enqueue() uses q->t_len which only
counts packets in the internal tfifo. Packets placed in sch->q by
the reorder path (__qdisc_enqueue_head) are not counted, allowing
the total queue occupancy to exceed sch->limit under reordering.

Include sch->q.qlen in the limit check.

Fixes: 50612537e9ab ("netem: fix classful handling")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index aa0d578b5f0e..6a91693bd89b 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -543,7 +543,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			1<<get_random_u32_below(8);
 	}
 
-	if (unlikely(q->t_len >= sch->limit)) {
+	if (unlikely(sch->q.qlen >= sch->limit)) {
 		/* re-link segs, so that qdisc_drop_all() frees them all */
 		skb->next = segs;
 		qdisc_drop_all(skb, sch, to_free);
-- 
2.51.0

