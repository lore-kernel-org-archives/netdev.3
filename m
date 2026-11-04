Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780461;
	b=1H4O0CJ/xPqo1bKLy6AloeS70BLF9DJgRwpdesxNfx6AwAGcwkqZ0mX5fEUTYlCAFE+w
	 y7SrxE1RmhOM3a3CkCqJIdbSab0NpRVfVSKh44QTNZwsEoIFRQXHkG1NUBFizjI/ld56p
	 MB3AZ9+bhfOJTiFM45FVtF3JfgUgaIEYK4q0rPtXEmO7HYo5toAYS4AZ6wqvdKfrV0JZ+
	 FVhrHo0sgTiTyrb1fQLdt5EBxh5+dfE0N2nScFAfQa6i2kz2kMBf4048TCTtItEXgG1aH
	 7XiV32hh3MSoqwNoo7qSwk85heVyDimx978RJIMbhToFht/ExG/8q0eIU/up3YBoZBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=iYtcs8Sbgt/mAGlPAOtTJUNavU/oK8TvQ0CPJNVaXu8=;
	b=MsWnFnIX6Wm+sw2HR4ESYLvz7IfDWSeDZuBtePH08dLf14H4jeN+MXJ+uZqtwchGNAgv
	 fojCS6k9rEYszIWwvedJ/RMGgV4XQou5CpJ9q4lHLmRpQbmF1yv7mCktFI+kdvHd0mrgw
	 HY9jYqWkP5+6KRWa4BV+zauE5Igl4KeMg5c3FSArsfbSMTWSLJRbwTik+fneU/j91sn6k
	 QyZNq4kR2flooD3kFVi9rDIQaomXT9cePpvvsw70RTKCYOO106VCax9vRcqanOiusQu52
	 7/ZiCewojvk0+SOHnMZwD8SUGeWAPlwjpBa2RtxhBshLemfP+L0RQDeyVV0q5cvRyjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bDb5LU2O;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC782606A32C
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 08:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC782606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bDb5LU2O
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ea63087d79so5321485ad.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 00:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793780460; x=1794385260; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iYtcs8Sbgt/mAGlPAOtTJUNavU/oK8TvQ0CPJNVaXu8=;
        b=bDb5LU2OoGCHX3hRQbY8L1Y3m8mR1bTaSmMPomByeTklD9mhkXQYAdghXG128jAanV
         5H9trdbP5+aS8HYuH7P9Iug62Lhtg9RhMBvTodtZYOKwFHRFusxgSKy9yugi/iQRLD3K
         +qWbxwXAheaCroRG3Ti4tVEOBgcLCE3OipTZfKNPlbPARhdXoGpV+p7ZI80trcAeKE0X
         lzdxXPA9+9e6SVGhUJh/DB+gPC/2AFA2oMcX7sYD7ZGwc4i4Aye+xoQNZEirm8pW3btC
         WbpoH6SdOtIaC4wUJk8kLJu/FtO6ivv3+2blY5kSl0uzqBJQaz4Pm5NUpoBiXpuhwR8A
         Z4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793780460; x=1794385260;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iYtcs8Sbgt/mAGlPAOtTJUNavU/oK8TvQ0CPJNVaXu8=;
        b=vsfDX5DUyYkVMuo/pl+BOT9XR7n0MuyMZA3xBfdqmlrD+Xxc0yqzFfUdx9OOo/myb+
         oLrw41KQgRWInJAecmBG0vVxllYdrVOSZdo/DNCANfyVTE9G1eGlzoYkzonrKvdKuW4W
         ptM3arfoMo8FdbcRQHx4Io9oIEzvSJkVjIqOdl7Ob5cOfWPdk2etzyh5dDDQA39GxU/R
         arcGON/AlPBRUQGHsakDOf+tyRMidl5PMlCbk+LtxlTeBpqMg/Z6cStfXMRlIeam3B4x
         7bABpL0K/tJupkGcsP97CjA0sQs3TYSyN38pSrBUCuCbL/g2iwHQ8zpibMbv2p9S5onn
         /dIg==
X-Forwarded-Encrypted: i=1; AKwUvByL8M5kVrfortYPzG0EKmTPio1Nh9rUuyaVs3h6klBHpKUvBWgfjvVLD37FKzadck/XGPyKvAI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fF+5CCsOVHeP8G3t43O5jt/Vs6elY8uQYNlcTSVHZDDS1zVbo
	FbvpVbBvxneDDd1MXBC5foCP5jIbgXlaDFDEJj5+pPQU/76ePgTho8PdKN3p4eS0NKqG2veAqjI
	dzm/oGg==
X-Received: from plbkt8.prod.google.com ([2002:a17:903:888:b0:2e5:9026:72f2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec4:b0:2e9:851a:7188
 with SMTP id d9443c01a7336-2eb3649c631mr148863365ad.23.1793780459902; Wed, 04
 Nov 2026 00:20:59 -0800 (PST)
Date: Wed,  4 Nov 2026 08:20:55 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104082058.452188-1-kuniyu@google.com>
Subject: [PATCH v1 net] af_unix: Convert unsigned long to u64 for GC.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Lim Chanyoun <onleaf322@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Lim Chanyoun reported that unix_vertex_max_scc_index could
wrap around on 32-bit kernels, which confuses GC into purging
a live socket receive queue.

I apparently designed GC with u64 in mind to avoid wraparound. [0]

Let's make it true on 32-bit kernels.

Note that unix_vertex.{out_degree,index} are converted for
consistency; they are bounded by the number of allocated
objects and do not exceed UINT_MAX on 32-bit kernels.

Fixes: 4090fa373f0e ("af_unix: Replace garbage collection algorithm.")
Link: https://lore.kernel.org/netdev/20240228030508.31297-1-kuniyu@amazon.com/ #[0]
Reported-by: Lim Chanyoun <onleaf322@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/garbage.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index da774f56ca64..a0b515354e8b 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -78,9 +78,9 @@ struct unix_vertex {
 	struct list_head edges;
 	struct list_head entry;
 	struct list_head scc_entry;
-	unsigned long out_degree;
-	unsigned long index;
-	unsigned long scc_index;
+	u64 out_degree;
+	u64 index;
+	u64 scc_index;
 };
 
 struct unix_edge {
@@ -148,8 +148,8 @@ enum unix_vertex_index {
 	UNIX_VERTEX_INDEX_START,
 };
 
-static unsigned long unix_vertex_unvisited_index = UNIX_VERTEX_INDEX_MARK1;
-static unsigned long unix_vertex_max_scc_index = UNIX_VERTEX_INDEX_START;
+static u64 unix_vertex_unvisited_index = UNIX_VERTEX_INDEX_MARK1;
+static u64 unix_vertex_max_scc_index = UNIX_VERTEX_INDEX_START;
 
 static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
@@ -372,7 +372,7 @@ static bool unix_vertex_dead(struct unix_vertex *vertex)
 }
 
 static LIST_HEAD(unix_visited_vertices);
-static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
+static u64 unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
 
 static bool unix_scc_dead(struct list_head *scc)
 {
@@ -450,14 +450,14 @@ static bool unix_scc_cyclic(struct list_head *scc)
 	return false;
 }
 
-static unsigned long __unix_walk_scc(struct unix_vertex *vertex,
-				     unsigned long *last_index,
-				     struct sk_buff_head *hitlist)
+static u64 __unix_walk_scc(struct unix_vertex *vertex,
+			   u64 *last_index,
+			   struct sk_buff_head *hitlist)
 {
-	unsigned long cyclic_sccs = 0;
 	LIST_HEAD(vertex_stack);
 	struct unix_edge *edge;
 	LIST_HEAD(edge_stack);
+	u64 cyclic_sccs = 0;
 
 next_vertex:
 	/* Push vertex to vertex_stack and mark it as on-stack
@@ -553,12 +553,12 @@ static unsigned long __unix_walk_scc(struct unix_vertex *vertex,
 	return cyclic_sccs;
 }
 
-static unsigned long unix_graph_cyclic_sccs;
+static u64 unix_graph_cyclic_sccs;
 
 static void unix_walk_scc(struct sk_buff_head *hitlist)
 {
-	unsigned long last_index = UNIX_VERTEX_INDEX_START;
-	unsigned long cyclic_sccs = 0;
+	u64 last_index = UNIX_VERTEX_INDEX_START;
+	u64 cyclic_sccs = 0;
 
 	unix_vertex_max_scc_index = UNIX_VERTEX_INDEX_START;
 
@@ -582,7 +582,7 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
 
 static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 {
-	unsigned long cyclic_sccs = unix_graph_cyclic_sccs;
+	u64 cyclic_sccs = unix_graph_cyclic_sccs;
 
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
-- 
2.56.0.385.gac671c819a-goog

