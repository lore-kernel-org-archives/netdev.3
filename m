Received: from mail-pj2-f20.google.com (mail-pj2-f20.google.com [74.125.227.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CB553E313
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695503; cv=none; b=cgGwHw50NKZyPMViwepGq2HqzJiRrnpKBGGVcXVGVEZoF62lKJD33QIMkU0O0ucuKkX96uV6OnYhYIvt8ngpt+0rC8I1K0QFuzc+7joSkYoX+rOuNcK69hLgBzfJdznbTOMMglgz7EYsJGsv4VFheKAeMBCMC2sKRuJ6kVCsVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695503; c=relaxed/simple;
	bh=ljRvTa1FKA++fXKqZkWKN8lwihjtnE8tip6RujlYs5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FU5EM+g3Q84BNLIOiNm4H2ONsp8cx2GzFWFEVSagi5iun7gXQflvVS7tMSr7tNSwWAQmFbBlsRMjxbKWWJjMsoGlGD4nu0F/1OyndLfmdaoCz0/BnL4ok8d/meIzgUdnRcFw9YIIjto/q/iFn4zJFW2ucCvjdqP15qNG7eLvuNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWBdaA3e; arc=none smtp.client-ip=74.125.227.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWBdaA3e"
Received: by mail-pj2-f20.google.com with SMTP id d9443c01a7336-2d747ed9866so31617495ad.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695490; x=1791300290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eFyOFPjEEQvNyGsovA6lNcMTRXqLjejzL5M22wl797U=;
        b=FWBdaA3egrMft8kpUEphfyrKPxWf6GoTUZp6iTGqRaMbh5E31wMk2NloOo1Z0omw7Z
         t45n7eKwLosFe3dc953EXsx3iVqpjkKJvyjPIP22uSx9j5K4K22xfZ1zwiHM3HS1V7n8
         FRTwzTufhgHfiqLg3UojiM0J9MyFKzd4P8fOsZ+8zt3P1kXkxtBnEQEn8bs6yf6xySgL
         5+tYFkN8x8FDaoqNEaD8BHTlA2YSlG17kLDmpbgExCCgkBmIbPfZyfwn2bDUUgxjy2Ot
         JfXBxcDlt+uhiEgMFSAXXJe2zGnlAlqG+vipDayHt3wduVkqleG7Y57TPwdtQBdRfv4v
         aaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695490; x=1791300290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eFyOFPjEEQvNyGsovA6lNcMTRXqLjejzL5M22wl797U=;
        b=yxvruwJrLm/2KEQZ/osNN9uRsNwK6SPSDhUZhYPulrWr/4/YAuL4u8tKzVPHtu/pJE
         pzQS3zOuLFnydJcWMMSRHOBJyys3QsX7gGfYVifMbquvaYwRBbQIemuZfjTEHeQMQyvF
         s4k86FEEsfQ7hKGLAvxDNT5PApTAngQ7WUT7thdvyIFiLbaRducyfUxZFQCxFcnkmSw/
         vJ0bkMZRsIcs6wxdWIjORPukXg9iFQVtLYqHUgaqVCANLMI9TmYlwRmaUIZHYaZP8BfA
         /4SqQ6ZZiWtocRoE+4ZL6KYkfqmgWlSfDOdvN6Sf70k1uDR/oiJTUSmGhxHHHnyJwgSd
         jSqg==
X-Forwarded-Encrypted: i=1; AKwUvBy8KbEMgzcCBc7tp7rzYBx/m1aK9ToEk44wc44QD/qqYKv5h4hN2//8hmFO71uS2Rq9JjQPLd0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgTXKKbJq7YgfYpQ29j/WZVeIsktz1eIhQZvDJSmpIhvSukfNf
	fB+rg0NGbgvcUoXFgelZqWMJZK1TJ7N8qvjPxJ7BNwLiX7FN7fJw35XL
X-Gm-Gg: AYBFou3s3MEPZgHt5sfj1s9Ok5BNf7l7E1MG1vtoCKYVYLecYb5owJwNkMvahsT3bM8
	dOa4iUk+1diLqUB3fnsahIVH/HePLR3gmAHeTeEyKKrQg72bnfp0Oqg1gESr3U7wsFAo05jpahF
	VyErsZlJ3AAdin37oAMkaqdSfoJkncr8928IMcTAqBouXvK5Bs/NZtgqQqkPka2grSh5pOGYgPW
	27Ha1ZApYsdoJiA1bVqpwcz6386KaEFaTZ+lsWZ2LTFqt9fKSMVm1+5z9qnBPwMQB+ZZPVUc2fR
	RVgVIGlBgyL3B4/j0CfN/GTkVf91Plmsy34sSKRZcYoL2fWyiz7fXSxaaNfJTFxjfu/bb3+GwTP
	vFZsDSnCG6aSBgDset3iiCiWTZZdM+qNCI8yOvd7jxEg6qm5RVX5qYTh1j4FPZnqV0f1EN7oyMv
	tK2p8c5Udaw7ED0jBoqlqp6MDF02jlpI8Ls8ypw08QthivdWScHYMnGVEOXRALAOrO9lFBanqW7
	cwP2ik+0u80Z389cWgl6HffKGw8YpbbxkeU32gkblTUpt95SOnrbTT76h/Ot8BEnIvwc06V4m5g
	U7TemgPOyk5hsGGWq2pg
X-Received: by 2002:a17:902:ffcf:b0:2df:b55a:5039 with SMTP id d9443c01a7336-2dfb55a53fdmr69446205ad.41.1790695489583;
        Tue, 29 Sep 2026 08:24:49 -0700 (PDT)
Received: from NV-9MNJ414.tailae2068.ts.net (2001-b011-2005-5b75-0412-f652-3152-53f1.dynamic-ip6.hinet.net. [2001:b011:2005:5b75:412:f652:3152:53f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91476bb4sm59762255ad.83.2026.09.29.08.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:24:48 -0700 (PDT)
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
Subject: [PATCH v2 1/4] rbtree_test: use rb_add() and rb_add_cached() for the basic tests
Date: Tue, 29 Sep 2026 23:24:36 +0800
Message-Id: <20260929152439.91443-2-s921975628@gmail.com>
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

insert() and insert_cached() open-code exactly what the generic
rb_add() and rb_add_cached() helpers do.  Use the helpers instead.

Besides removing duplicated code, this makes rbtree_test cover the
helpers themselves, which is what most in-tree rbtree users call
nowadays.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
Assisted-by: LLM
---
 lib/rbtree_test.c | 37 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
index 768c5e6453f37..c1386d328cfb1 100644
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -30,41 +30,20 @@ static struct test_node *nodes = NULL;
 
 static struct rnd_state rnd;
 
-static void insert(struct test_node *node, struct rb_root_cached *root)
+static inline bool less(struct rb_node *a, const struct rb_node *b)
 {
-	struct rb_node **new = &root->rb_root.rb_node, *parent = NULL;
-	u32 key = node->key;
-
-	while (*new) {
-		parent = *new;
-		if (key < rb_entry(parent, struct test_node, rb)->key)
-			new = &parent->rb_left;
-		else
-			new = &parent->rb_right;
-	}
+	return rb_entry(a, struct test_node, rb)->key <
+	       rb_entry(b, struct test_node, rb)->key;
+}
 
-	rb_link_node(&node->rb, parent, new);
-	rb_insert_color(&node->rb, &root->rb_root);
+static void insert(struct test_node *node, struct rb_root_cached *root)
+{
+	rb_add(&node->rb, &root->rb_root, less);
 }
 
 static void insert_cached(struct test_node *node, struct rb_root_cached *root)
 {
-	struct rb_node **new = &root->rb_root.rb_node, *parent = NULL;
-	u32 key = node->key;
-	bool leftmost = true;
-
-	while (*new) {
-		parent = *new;
-		if (key < rb_entry(parent, struct test_node, rb)->key)
-			new = &parent->rb_left;
-		else {
-			new = &parent->rb_right;
-			leftmost = false;
-		}
-	}
-
-	rb_link_node(&node->rb, parent, new);
-	rb_insert_color_cached(&node->rb, root, leftmost);
+	rb_add_cached(&node->rb, root, less);
 }
 
 static inline void erase(struct test_node *node, struct rb_root_cached *root)
-- 
2.34.1

