Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619930F523
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784366768; cv=none; b=D3v0vjcAwm0qM+D8S0XbORHLAwkB5Vp9hXPhOHStcdT1VcB3QLscmW9hj3/X8vZZ5N4B9x7NlCFUMaFI2j3B965A8pQCISNgKNKQoHWiCJYeGR+bdZFADMYCzfqEJpSMsxo8iquaPv7AavYGLf8xeZAnG6noFac5Qao0ZZQfDRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784366768; c=relaxed/simple;
	bh=U1dSyGmpO4jyK0gdMbi0zGrAKcDsiwvzn2p+5O8OCHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZDrgxRjArYy+b5K7/WbgN1iAL2A9v5skOOmBM9BvdqgQAmAUpVHwf0AyYHhMl7uwWrAvV9/hhDxCEZEmAvwNTmk4TuXrgzm/GJK2CaQoPXP/J709+LYpqKq08MR1I6Ni4gABBlRAheLntFLVsDMbmmlD18cJvXN/rWrihP6ic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzpPje27; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzpPje27"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8484a0b998fso7988564b3a.2
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784366767; x=1784971567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nz7xYB5+RsFyTrGLAYiyXPfONarJ2CKVSQ+VTT23UHc=;
        b=LzpPje27LWVOKeMzU8vFL2LtS3Y3KXz+NuaorAXsP0H72rTF47KfnuJ2gC2tde6Uql
         mYO63RRGtzR6a3Me+S32DNkl0EKIfoFeE0GsI/jLG0fAzvWVJ+qv9nGdA8AcV1dv2ivR
         JJvAHV3ysGx0QoG+SeOb/1B7bQgTy5tVUpk2Bn/leorF24Up5kLUCJZHJHoPqT4ZJUFU
         c6ZN1ftmoJZulY2QdZqr2MZzWxVJQjhj6KVwUYFlE1NdFMQ9oJ8rHELajQ6nJU7WIpPn
         wTjKt0RgmYpYxneBDtcn9s2YI1PuvE2Cp7VOfTr38pjSQ169GssyIPXvuPHSsVvE1wg9
         ACSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784366767; x=1784971567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nz7xYB5+RsFyTrGLAYiyXPfONarJ2CKVSQ+VTT23UHc=;
        b=EnQm9NJH8Ec1BOhwXSNX/eUXZF1PcOrqnr65YRR8nRGEp9ipOW5Vrkta1s6AszlT/O
         hgA8UdzTMK0tM1e0aKw3F6AG9+ddx8hVqssyZIUpZI2CjfgJpRHGWnmh6coHDauhnxy6
         JO2IkeMxt3ztsmm177o0W9csyONf6vitzXCW27T76TxsDFa5uQKoq2uWxXB1pOZkTn+i
         v+akr4K94EpMSsL7cdpQKa92ZZDh8GY4HFeULj1omeGNOcDiKkTcBlZdVT11h3Z0sc9J
         TyUUQVUCR+Iqi0cCX6ncdkEUrwJY3s+acV/7yalJe9WCYnxHKpRwgvntS27NTNIu+idq
         s8kg==
X-Forwarded-Encrypted: i=1; AHgh+Ro6lzvEG+JZuk1o4gqa85aCk4KazersB3RpOniw1Mz3GCUtzCdNc1L8GYtL17LFntQLjmZypO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBlJXz+Kdkdhw9k1BnoDwLCgUCH9VcD4NFkSI9M4uPfRFpt+4k
	CTofO2gRD87UapZZveWwP9RGzILET5QiPW1bRk72oKOK5Z8JTevMnozY
X-Gm-Gg: AfdE7cnfePV/K82wmWhyx19TpRt22H6w7/0Ssnr/hNBQhoMxcWDk9kst1PBGMZtlWBy
	kTKNcRdM1w2HX9HejYCQcma2Mi6k18YuH6d8mLr5F7d93WXeBs7pVsA1V6hhLkJ6iVd9ZggQMcX
	ptNAQNmkraqZ3YVP1lUJobJR8ku5yUqcc3kr3Q9VbVLIPSgCFbX8DLgPbEpWOLmJ74oHqUX4bI5
	XQzRnAURfLBcA+92nZ8XiJiEoVrHDE4maisU0Y2tX1h7ZPP3wwT7JTlsnHbg2Mu2Zj2OSc2e5nl
	GLxuu7PJ4ZWffRrjB9pSRl/r/tCdHgJW+25v2Le1/dnbZ4mtkFrZx09/gIBhsbphkJf4ualdKSh
	URFt9200sVrw5t1hwzdtseJLeK/EmXYhOt7W+ZIO7tYWSZjY0B+COBLMWS3wpI+XIi7EdoJERM1
	8F/DX+WZQMjF5FolGyCjNZ+/mo7ST9LK8iw5TRfw==
X-Received: by 2002:a05:6a00:451c:b0:842:6004:3fda with SMTP id d2e1a72fcca58-84c292e057dmr6396793b3a.25.1784366767174;
        Sat, 18 Jul 2026 02:26:07 -0700 (PDT)
Received: from kimi-bug-hunter.. ([47.84.186.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c30fb62fesm1950464b3a.29.2026.07.18.02.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 02:26:06 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v8 3/3] tipc: fix node reference leak when defer work is already pending
Date: Sat, 18 Jul 2026 17:25:43 +0800
Message-ID: <20260718092544.785289-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718092544.785289-1-bestswngs@gmail.com>
References: <20260718092544.785289-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tipc_node_write_unlock(), TIPC_NOTIFY_NODE_UP with an empty
cluster_scope takes a node reference and schedules n->work. If the
link flaps down and up while that work is still pending, the next
NODE_UP takes another reference, but schedule_work() returns false
and the extra reference is never dropped. The tipc_node structure
leaks.

Verified by flapping the bearer while the work is pending: one
reference is leaked per repeated NODE_UP, while the work is put only
once when it finally runs.

Drop the reference when the work was already queued.

Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/tipc/node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index f757722d15be..f826347b5870 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -447,7 +447,8 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 		/* Defer bulk distribution to work queue */
 		if (rc > 0) {
 			tipc_node_get(n);
-			schedule_work(&n->work);
+			if (!schedule_work(&n->work))
+				tipc_node_put(n);
 		} else if (rc < 0) {
 			/* Bring the link down to start over bulk distribution
 			 * when the link is up again.
-- 
2.43.0

