Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B85449992
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192799; cv=none; b=Re0q76Sb4asLI8bxAJJFs2pHdoBvGKTNrrzY7hYKlRUU7s7ZQLv7gZ4xKlGJjZGY5QyA17TL5thlDOzp/1sautIKAIAYP8Im3Vk97Qgz2UFyYg4marJmMpHzbfCBwzuWeZY0Js75cFrq9V6Zi49zr4jVWORuMttOHTEvxjUIzGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192799; c=relaxed/simple;
	bh=ljRvTa1FKA++fXKqZkWKN8lwihjtnE8tip6RujlYs5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EIMpWLLxvEgW2t0qM1TOpmHuJms3NmLZ+aJq62hfxh/NOgh+UEP//kpEyYU+wlhdKpZJF7799aF/Zk8N8yMmj8M8SRbw0V2NxWnBAmP4pL7tv9+vCsYHQuNt203OR6ost2fhJeq/qJBOI6ptdowGR4+U/6J4/9vd+u3pbUUavw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+ANPpma; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+ANPpma"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7d1802740so758490a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791192787; x=1791797587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eFyOFPjEEQvNyGsovA6lNcMTRXqLjejzL5M22wl797U=;
        b=R+ANPpmasXczR4MLk/lqBpKV/9YLFrMBYhR/ZGE8e/r7kklNI5m36HYDzSkuC1xXUl
         jAMN22A0/t0hWR8He90N9ZA0tdthKTsMEyl/J/Oq2FftLCKQrwmZ0BZ/zYEm/p9r56C2
         T9BWHqW4VyIefG2pfhczQW0+80pvs4hUYTPp2tlw4iivy4rQSNvLon3juhR2P3k8jO0V
         2/ZEE3rTu0o/+agykz7YWbenf5o21z0tL55gsOZPrHF60Xx+sHA2X+cEwPnD5S1v3yoR
         bjhljdA58/3/cbBPJXTcEzePjCwOL4AmpGEzKQTZ3mAct6GISnKHri6W7qWvwcsL+ecO
         bVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791192787; x=1791797587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eFyOFPjEEQvNyGsovA6lNcMTRXqLjejzL5M22wl797U=;
        b=ZQE+dHITixMeH+O3SLeF29Ta8QiTReKEupARv+/Kqs5Eb3rhbY7oQzcgvadiWFQYKD
         Vapb3wEYtzFh9aV41atm7UMOx+/OqAjYFoFH1u0mQA12kyHeLzZm0ErreinMZkOfQbDt
         E6ojgQFqXg5Vhq+khTSMMHxC4kmCwN5mFKHIqGtKgircr+Pp4GDKXuopZt50H5nOfro1
         KzZ28Cqv3TVzsd7/GgtWoE48Wgcq0Exhxzm7rI62QC9vCnJBg0BcBFnY77DKEeN8Xykz
         aRQJ634r77wHozhqriLQ+BCM3ncukKUtoOSg38tPsKGvH9wdiyJ1JroO1r07lqXbrx2J
         NeOg==
X-Forwarded-Encrypted: i=1; AKwUvBwhmMR7umMuQXklf1iXeLQD+QJzkNHrRxSG0TZvPYkCNQrgp6ttedKmHLzE4q+ODSvD6pPLulY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgXbJwi9i2m2qZg46NT4bJkvrc9oIxjX8pjulfUaiccYm6ndSQ
	V7k7m2svVMVEQggGyU+MuiMct0jzfHBas43JGKYvzwdpDX48n0H9VjZ5
X-Gm-Gg: AYBFou1FY9ao/hRXhm4jsfdFviUE36Tyy/+voQCIzfc+BWqHJGP+kQoKrcd+vSdA6B5
	94Xj9NTerx1dHCkk1L0XfmzgiqEWtR5s6W5WB4/qgeIXN79zKt0hWxQxuVhUt9e9TSAel4vz+4B
	U6aBbTVqKKpPlxMmVmWj2ofps+/cfkzmwJzzIjNgwnOvVDkohkCbKBX4KoUEcUPBk/Q+5LC2HWr
	OHnT1uG8nRipS65qwFezDZLz1PKAhuxJX7E0pw0Tc5iRBnHg6kwxVNVvme7PxNN/iulAnim+ZzI
	93xUSf3+F8KZsgWKtjuzmfjgUM4uC4jV23eXoNg+5t1GUtaHRZWBKNIdo7+W15RFzzZr5+QGW/1
	He3PHw1M5ueuE8pyL7pSz3vIPHBAW95EfI/mesTtVgI+yYCazZNClxlvl1VTwXn9sPz9qkO3XNq
	Kn3sq4oNH1N8uSnS0qDY8vdcy+3X8L0IiU2APCOcbOcdHU94lw1XdoZ/qVPiEoTo8ywS8+I3xn9
	7f+XHJp/PFprMjbWmU=
X-Received: by 2002:a17:90b:1c12:b0:3a4:9f7f:8cc1 with SMTP id 98e67ed59e1d1-3a6ce75d149mr9261079a91.24.1791192787284;
        Mon, 05 Oct 2026 02:33:07 -0700 (PDT)
Received: from NV-9MNJ414.tailae2068.ts.net ([72.25.121.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7ad87874esm4527886a91.0.2026.10.05.02.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 02:33:06 -0700 (PDT)
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
Subject: [PATCH v3 1/4] rbtree_test: use rb_add() and rb_add_cached() for the basic tests
Date: Mon,  5 Oct 2026 17:32:33 +0800
Message-Id: <20261005093236.62702-2-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005093236.62702-1-s921975628@gmail.com>
References: <20261005093236.62702-1-s921975628@gmail.com>
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

