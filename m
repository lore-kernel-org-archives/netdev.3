Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4B34D09FE
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695507; cv=none; b=qwWbQsm5LRenZpmfogue11z+J8OhE1Xq9ZLQn/R03ri577w4Omn4Gg/uX0bpgK4QyGuS0PtK2KlL9NHgOEteOW/JY7e23EUsIJo0q2OQ/Cn3N2H79l2qaYXygr79pcBCkiziymTPhMWBfI8KrmAe5/CD6RCLrUhPGdxeN6KH3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695507; c=relaxed/simple;
	bh=+cEEr6znaNoigBam8Uz4P3hHrN1WO+xiS9Xy1l2461g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g9O4SY1xTOluWsgdSSQ+Y4wS9rWpqB/b4rZcmofiaJU5TnM4y40QSlZztlNhjRnV8yLHEc+LjHegtBR5ntQPaQdBF8bC3oqWkkcC40+h/gmB0wOmRUiGGEaC4aXwTXTW0vVNZgFpGkMhE8oNfIj178YgJku0GLXoXszgJBkOz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r2A/V9iL; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2A/V9iL"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df4aa80a73so27260585ad.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695501; x=1791300301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Avi89gTSEr8pephIlQG3FXl3Hk0q/RUFdATAtng+nto=;
        b=r2A/V9iLUr7hnQULU6G44Xtoap9OJvFZGWqm2BCHKd2X2EJOV/qpdbDJLxHNfAthKa
         XthnPpuXebFycydcQXBuXC3dw08tyccB+hJs8eqNDVKK9zfm2ue6HluwhitQJt41l2dx
         Sjs8N11dxzGUXofhk+FDP5QvBXnUjCbxrVpdvwDyhVT5jvJDW0dvs5pDqcRikhq6e6PH
         QCjo0Twu802fOz5q1NbFeh4THeGSbDRBfSGqwYWFZA2NEwVkduKJxsJjccJfuKfa0P3g
         URWYGJbeiWiQK28AI6bpB6JhHoAqFTciwjR2WHb1+aOn3XjMBFmds4GAMbmSggveAWub
         k4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695501; x=1791300301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Avi89gTSEr8pephIlQG3FXl3Hk0q/RUFdATAtng+nto=;
        b=2yu6Nu0Sdv07wHSjRIuJSBDbGOfc7Dt/3/DdaWKlCVEmv+UBUH9YfobaciwA1vpcET
         CERzgUU0RSNZRGTVfb5nZONNyNy505VS4UWBZpmuX19AmeHNpUV5geOl4OTzg9H/Sr0l
         uY/+Sb8OqJeNMXBOTJ6GG8gbVHJNgnE0yvsg6+3XI0KhxbKiUtzhtwDWufoNxPssAFjJ
         8xPqwR+OJjZQRbu7x4G5LmOitS/IKwLeEptBHNz20S+uEZeNlicKY6LGi2NYi+bxtkWc
         2vniTe0JPGwDld00FonVnL3LDhBGOMx8h70+9rYp/7r0bkTdgDf/ziq3zl/7WYq3HAI2
         VGPA==
X-Forwarded-Encrypted: i=1; AKwUvByIe7Gd3uYidsnzC+UUrLJz2m1hnZcQIYhhm5MaDrYIOE7o4Lxnzu2zvzmZnXpxGUH3StwN578=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFL76zFb78ceoKhPOelJaG3Lfx6AKNHFOVX1cV0ZdZGrXcB+rU
	1T3R//d7wXzuUjNt3tCcZFEM+y4xjtBCcrZWZ9gUOAXy9b3425VoZdxR
X-Gm-Gg: AYBFou2Npq+BecgR7kyX/eX3m/fp1PlIz00Z3APm/X4BeBibDsAtVVQeDD6qDjOq+x8
	MfcTac4qsYLpQo8CbN8vSocbXrmL6IfOweDD40cjvZpLLrF8B8ukR/nAh238xq6iUfIXGcZ3fgR
	4F9Tnxuo0rPyTXc8zYqCzv5Vf4w3wxIQ5EfXmvUXYFu5qebhsqzPDXkp6XiOTiscjtKZSrOrV9Y
	pV27a45HN/3EFjvNqOCkvOKYcle1Zib3Y7Ul12CdbcvB3gPS+8q7rDPTHyLsQudqDzvOYx2kazf
	x99JrPA9uA43QPBKPeceza1jJp2OH+AggsQQPVuyBoS1b6scW6PJXgY8IsN5KY4ukWwG9v/i6hb
	pEEP3CdMnaQp0oxtENDjZ6VJIBphIk348K7Uf8IywMIDoohisb80hMb5eEFbm6bIfajzW/poAze
	BEylEa8Y+f3L9mFqSGlRGfQlevq6zhClF1GmGlqESEN0P7Z0lcBg4i05utgUN9FC/OFH0x8Zv5Y
	gmLY4AGhLk3XrNx728yf3JnsfQvlC8CtH6wNesqUSpKcQ/GaZP1XBWy6z01eoZTCP4VVZhIK3Ka
	hBifWhZdqlMSeVVfFN/Y
X-Received: by 2002:a17:902:fc86:b0:2e2:c604:b436 with SMTP id d9443c01a7336-2e2c604cbbcmr25400595ad.49.1790695500578;
        Tue, 29 Sep 2026 08:25:00 -0700 (PDT)
Received: from NV-9MNJ414.tailae2068.ts.net (2001-b011-2005-5b75-0412-f652-3152-53f1.dynamic-ip6.hinet.net. [2001:b011:2005:5b75:412:f652:3152:53f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91476bb4sm59762255ad.83.2026.09.29.08.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:24:59 -0700 (PDT)
From: Yiwei Lin <s921975628@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Yiwei Lin <s921975628@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jon Maloy <jmaloy@redhat.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] rbtree_test: use rb_add_augmented_cached() for the cached augmented test
Date: Tue, 29 Sep 2026 23:24:39 +0800
Message-Id: <20260929152439.91443-5-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929152439.91443-1-s921975628@gmail.com>
References: <20260929152439.91443-1-s921975628@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

insert_augmented_cached() open-codes the descent that the generic
rb_add_augmented_cached() helper provides.  Use the helper instead,
so that rbtree_test covers it: it is what sched/eevdf relies on and
nothing in lib/ exercises it today.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
Assisted-by: LLM
---
 lib/rbtree_test.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
index c1386d328cfb1..00f62e4f9d10e 100644
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -89,29 +89,8 @@ static void insert_augmented(struct test_node *node,
 static void insert_augmented_cached(struct test_node *node,
 				    struct rb_root_cached *root)
 {
-	struct rb_node **new = &root->rb_root.rb_node, *rb_parent = NULL;
-	u32 key = node->key;
-	u32 val = node->val;
-	struct test_node *parent;
-	bool leftmost = true;
-
-	while (*new) {
-		rb_parent = *new;
-		parent = rb_entry(rb_parent, struct test_node, rb);
-		if (parent->augmented < val)
-			parent->augmented = val;
-		if (key < parent->key)
-			new = &parent->rb.rb_left;
-		else {
-			new = &parent->rb.rb_right;
-			leftmost = false;
-		}
-	}
-
-	node->augmented = val;
-	rb_link_node(&node->rb, rb_parent, new);
-	rb_insert_augmented_cached(&node->rb, root,
-				   leftmost, &augment_callbacks);
+	node->augmented = node->val;
+	rb_add_augmented_cached(&node->rb, root, less, &augment_callbacks);
 }
 
 
-- 
2.34.1

