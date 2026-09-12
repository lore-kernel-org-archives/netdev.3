Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF8F23BD1D
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 03:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789182537; cv=none; b=DhS8PUHe8Nkaw63WFPaf4AtFeMRdRhvKjEQz5WWDa36lyXiRyvhv0n0gu0wxaYxK1AF3x5nBYlVdQsHMjGpupXmi2CQ5yoPmMdTCbF/uAig7JgIDQSbWZJOy8MXakslZxExLyXDwHRwblD9XMkcLjWezqmnwW+UIAVeC5+voggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789182537; c=relaxed/simple;
	bh=cGhZ3VyWD2W+LfozAohjtUUaI0RxojIsXkDYDLg4/5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=li3duWgz1EdNiuhIsXZ1tNu2ZOLmebflac1D8qGwBBs+6ED3cd4y6KTr4+blwEfE0+tNVRl3bSAZjKACm/4/QbneAMdEG/yDMJeruylzZOiY6kisggAnoHOBc0+CxhjIUwDJz6HN5BIdQ4xyPVncvepqSaav+0PEWw9ZOiwFodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uw6ka1Rr; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uw6ka1Rr"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so2911543a91.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 20:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789182535; x=1789787335; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UVO0xSGg2Th2w9mNPO8BewbLAAqbi98tJB792UvWfqU=;
        b=Uw6ka1RrB0cHYxydReV5PPWP3g826WQ4mUFfroCNWKfjK1WAZMczVjHlhRIiGAXHjg
         v5bW9aOPAyBv9DGGs/TUpB4FJmlEhzXRNfjZpupKFQamA8s1HcgSkwwzHIqWJh+pRrYk
         lrU9WytAs4mc4KAqlBM9FmRWZGxtHpTj8f+yga9hRw8k02n0J064oOri2iorYDbk1Few
         q/N2k5GB/VwikKVpy+74SkpqDhIVDatbIFgjtYi+Lf1fVvczHs7ERFLbQkD7PRjWc63E
         RggJWacY68F/T0Moo0omvL+gSxUUijRjCsf1SFmTMnjIy4sSu8EP2jr3DlrC6eExtXjN
         OONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789182535; x=1789787335;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVO0xSGg2Th2w9mNPO8BewbLAAqbi98tJB792UvWfqU=;
        b=rTiJ+sFxAflJMCTBxnhEd0vmTc9ETKc3vMKFYCMdqWkAdSI+/6u2JUiMzPssnr8NGj
         C4hd4a+jrdU0/A/Gk5fphbK4LECkM/h7ZnEMmnm++H+bF8TVm7+cHr7M9FgtKju7JcdS
         Qns7UKhr6WHN478XwAKMy3p+lT/bm5QnYPWDSZ6a0Cvv2s8SNjWoiaOYnN4+cCyI0/2O
         zMcph9om6C2JXlpzZtxWE4lNrchZX6ECKMXdelnbOIIuwCPV/HC2uWwHPnmXb3k9rHba
         bWugn1JcoXZTBtg97EDWCdVf4a9U1iaKbiVzJhYB90Q1dY0oIILVi1W3wuM5sVwupKj4
         fR1Q==
X-Forwarded-Encrypted: i=1; AKwUvByPg5LcpgSObKpd/s52cIccH5AAEUYxrkU4BN+Ii0LkeIIDP7GgI0zLLdNwsxnlmih7M1c5i0c=@vger.kernel.org
X-Gm-Message-State: AFuF++ngeq+oAT2FRBXkLqIry/CouUcNfpdYRxNiTFFcHlL4Z+nl4vi6
	cH5N34XX+fby2bwF0DBNsIONNXtLX0k17a6rCHGEL2QTAzLtIILYuxLmnHq3iU5xS810zDfTgS5
	/ijjraw==
X-Received: from pjbjx9.prod.google.com ([2002:a17:90b:46c9:b0:38e:b97a:cfa1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:540d:b0:380:fead:448d
 with SMTP id 98e67ed59e1d1-39d9c0aad1fmr11682798a91.13.1789182535177; Fri, 11
 Sep 2026 20:08:55 -0700 (PDT)
Date: Sat, 12 Sep 2026 03:07:51 +0000
In-Reply-To: <20260912030852.1467872-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912030852.1467872-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912030852.1467872-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/2] af_unix: Unify scc_index when finalising SCC in __unix_walk_scc().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	James Burton <jamesburton@meta.com>
Content-Type: text/plain; charset="UTF-8"

Commit bfdb01283ee8 ("af_unix: Assign a unique index to SCC.")
changed Tarjan's algorithm to update lowlink with lowlink,
which is called lowpoint (unix_vertex.scc_index).

unix_vertex_dead() assumes all vertices in an SCC share the same
lowpoint, but this is not always true if an SCC has two or more
back edges, depending on the order of DFS.

For example, the graph below has two back edges from B to A
and from C to B.

  A --> B --> C
  ^    | ^    |
  `----' `----'

If DFS walks through A -> B -> C -> B (-> C -> B) -> A (-> B -> A),
each index and scc_index will be updated as follows.

  A --> B --> C    C = (3, 3)  (index, scc_index)
                   B = (2, 2)
                   A = (1, 1)

  A ... B ... C    C = (3, 2)<-.
         ^    |    B = (2, 2) -'
         `----'    A = (1, 1)

  A ... B ... C    C = (3, 2)
  ^    | .    .    B = (2, 1)<-.
  `----'  ....     A = (1, 1) -'

Then, unix_vertex_dead() thinks that B is passed to another
SCC with scc_index 2, and the SCC is not garbage-collected.

This does not happen if DFS walks in a different order below
or starts from B.

    1      3
  A --> B --> C
  ^    | ^    |
  `----' `----'
     2      4

Let's unify scc_index across the SCC when finalising it.

Note that updating v->index was previously done in unix_scc_dead(),
when called from __unix_walk_scc(), just to save one loop.  Since
__unix_walk_scc() now iterates over the SCC anyway, the update is
moved back to __unix_walk_scc() and 'fast' argument is dropped.

Fixes: 4090fa373f0e ("af_unix: Replace garbage collection algorithm.")
Reported-by: James Burton <jamesburton@meta.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/garbage.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 9fcaaf55cba5..da774f56ca64 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -374,7 +374,7 @@ static bool unix_vertex_dead(struct unix_vertex *vertex)
 static LIST_HEAD(unix_visited_vertices);
 static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
 
-static bool unix_scc_dead(struct list_head *scc, bool fast)
+static bool unix_scc_dead(struct list_head *scc)
 {
 	struct unix_vertex *vertex;
 	bool scc_dead = true;
@@ -386,10 +386,6 @@ static bool unix_scc_dead(struct list_head *scc, bool fast)
 		/* Don't restart DFS from this vertex. */
 		list_move_tail(&vertex->entry, &unix_visited_vertices);
 
-		/* Mark vertex as off-stack for __unix_walk_scc(). */
-		if (!fast)
-			vertex->index = unix_vertex_grouped_index;
-
 		if (scc_dead)
 			scc_dead = unix_vertex_dead(vertex);
 	}
@@ -521,6 +517,7 @@ static unsigned long __unix_walk_scc(struct unix_vertex *vertex,
 	}
 
 	if (vertex->index == vertex->scc_index) {
+		struct unix_vertex *v;
 		struct list_head scc;
 
 		/* SCC finalised.
@@ -530,7 +527,13 @@ static unsigned long __unix_walk_scc(struct unix_vertex *vertex,
 		 */
 		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
 
-		if (unix_scc_dead(&scc, false)) {
+		list_for_each_entry_reverse(v, &scc, scc_entry) {
+			/* Mark vertex as off-stack and assign a unique ID. */
+			v->index = unix_vertex_grouped_index;
+			v->scc_index = vertex->scc_index;
+		}
+
+		if (unix_scc_dead(&scc)) {
 			unix_collect_skb(&scc, hitlist);
 		} else {
 			if (unix_vertex_max_scc_index < vertex->scc_index)
@@ -588,7 +591,7 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
 		list_add(&scc, &vertex->scc_entry);
 
-		if (unix_scc_dead(&scc, true)) {
+		if (unix_scc_dead(&scc)) {
 			cyclic_sccs--;
 			unix_collect_skb(&scc, hitlist);
 		}
-- 
2.55.0.1007.g17ff1f9808-goog

