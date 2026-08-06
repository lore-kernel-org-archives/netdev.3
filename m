Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F2483BD9
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037343; cv=none; b=SVsCHLnSXn46eJmwENHHtFB/PSE+7n+ewAxFk5C9jXlt5fkDUxEAZcQqO7hiXZSQlPC1BJBNhiYzfdDE6UbrsWM0WNCTzivq7kWgepcqvIMNjMRvXH0NPJUvnV7WS7jqutkFMaXZb2YyPnsamPN/SaaLlIhoaoFiWMoiIrBJALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037343; c=relaxed/simple;
	bh=OeeQgs+s5EEkSB1DyFUhIlSkYlxagPwri27qFQvrZig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mm49BdggRqO/WiyPUcqBu3hY1ZoXlWYQ3QQO49HV8zwKGDqaW716zwSKW5mVkbVwN3T+6NXKliSSAFjL3TPI6ru8x3enG9TwwBZbKK1+UCAumGR78+7oOJMHTw9xOLSZ65tj/7UEhklaIaPFv4b8cMXxP5ijYSC/keJtcNwDQ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuTbpl7E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuTbpl7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF721F00A3A;
	Thu,  6 Aug 2026 17:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786037341;
	bh=7pIaPeD22oCEvYbUCFVmoeAuHjBxVUeDI7QonlC4Gnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GuTbpl7EeB9jSBYiTlvyx1fhoJHolfVJwHpibwaeJt1Jo5yGHKRfKcW5gzIsJCxE5
	 EJdOzeFMOSwQRVTTYUapm4gtMjbrf5AlMMn9/C3wj/JOSeRu9lTGHpNe8ERrQUp9Hk
	 4OHoEdesm4+n4kLpkjKMViI4JiIxCHyORe5tMhEXxl0+c+2qjbUSb+2KMTZ+zrkzmZ
	 13achVBV1nd195VuxpLNA6711GgVIW8QUvWxCiH6/MDdgjRk4woXd1UF1ZiWncNljC
	 gG5R6ZJsUjm8430EtiqO6/b7GvaLgnH6WjHXg0MDKwO6+aUvPSLGPCUAxF3+UeArKR
	 /Y1BycUoMf7Kg==
From: Jakub Kicinski <kuba@kernel.org>
To: kuniyu@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	kuni1840@gmail.com,
	netdev@vger.kernel.org,
	kylebot@openai.com
Subject: Re: [PATCH v1 net-next] af_unix: Unlink scc_entry in unix_del_edge().
Date: Thu,  6 Aug 2026 10:28:59 -0700
Message-ID: <20260806172900.2962014-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804002155.2233594-1-kuniyu@google.com>
References: <20260804002155.2233594-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "I meant to send this yesterday, damn. This is completely
separate right?"
---
af_unix: Unlink scc_entry in unix_del_edge().

A vertex whose out_degree drops to zero is moved to fpl->vertices and later
freed by unix_free_vertices(), but it stayed linked in the circular
scc_entry list built by __unix_walk_scc().  This adds a
list_del(&vertex->scc_entry) so a following unix_walk_scc_fast() no longer
walks into the freed vertex.  Reported-by: Kyle Zeng <kylebot@openai.com>,
Fixes: 4090fa373f0e ("af_unix: Replace garbage collection algorithm.").

Two questions below, one about the changelog wording and one about the
cyclic SCC accounting that the described remnant vertex feeds into.

> af_unix: Unlink scc_entry in unix_del_edge().
>
> Kyle Zeng reported that GC could free a dead SCC partially.
[ ... ]
> However, X's SCC forces the next GC to call unix_walk_scc_fast(),
> and it iterates over A through B's scc_entry.

[Severity: Low]
Could the changelog name what "iterates over A" means in practice?  A's
vertex has already been kfree()d by unix_free_vertices() at that point, so
the fast walk reads and writes freed memory:

net/unix/garbage.c:unix_scc_dead() {
	list_for_each_entry_reverse(vertex, scc, scc_entry) {
		/* Don't restart DFS from this vertex. */
		list_move_tail(&vertex->entry, &unix_visited_vertices);
	...
}

net/unix/garbage.c:unix_collect_skb() {
	list_for_each_entry_reverse(vertex, scc, scc_entry) {
		...
		edge = list_first_entry(&vertex->edges, typeof(*edge), vertex_entry);
	...
}

The summary says "GC could free a dead SCC partially", and the words
use-after-free or list corruption do not appear anywhere in the message.
Since the trigger is ordinary unprivileged sendmsg(SCM_RIGHTS) plus close()
on AF_UNIX sockets, would it help stable triage to say explicitly that the
pre-patch behaviour is a use-after-free on the freed unix_vertex?

> This itself is not a problem since the next GC run will judge
> B as dead as well and free it finally.
>
>        X -.   A <.> B -.
>        ^--'         ^--'

> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 0783555e25266..9fcaaf55cba5d 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -186,6 +186,7 @@ static void unix_del_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
>  	if (!vertex->out_degree) {
>  		edge->predecessor->vertex = NULL;
>  		list_move_tail(&vertex->entry, &fpl->vertices);
> +		list_del(&vertex->scc_entry);
>  	}
>  }

[Severity: High]
This isn't a bug introduced by this patch, but the surviving remnant vertex
that the changelog accepts as harmless looks like it unbalances
unix_graph_cyclic_sccs.

__unix_walk_scc() only counts SCCs that are still alive:

net/unix/garbage.c:__unix_walk_scc() {
	if (unix_scc_dead(&scc, false)) {
		unix_collect_skb(&scc, hitlist);
	} else {
		...
		if (unix_scc_cyclic(&scc))
			cyclic_sccs++;
	}
}

so the {A, B} SCC that the full walk judges dead contributes 0.  But the
fast walk decrements once for every ring it finds dead:

net/unix/garbage.c:unix_walk_scc_fast() {
	vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
	list_add(&scc, &vertex->scc_entry);

	if (unix_scc_dead(&scc, true)) {
		cyclic_sccs--;
		unix_collect_skb(&scc, hitlist);
	}
	...
	WRITE_ONCE(unix_graph_cyclic_sccs, cyclic_sccs);
	WRITE_ONCE(unix_graph_state,
		   cyclic_sccs ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC);
}

Using the exact scenario from the changelog, with X's live cyclic SCC plus
{A, B}: the full walk collects {A, B} and stores unix_graph_cyclic_sccs = 1
for X.  Because the purge runs with fpl->dead == true, unix_del_edge()
deliberately skips unix_update_graph(), so B survives as a self-linked
singleton ring back on unix_unvisited_vertices and the state stays
UNIX_GRAPH_CYCLIC.

The next GC then takes the fast walk, finds B's singleton ring dead and does
cyclic_sccs-- on a group that was never counted, taking the counter 1 -> 0.

Can that flip unix_graph_state to UNIX_GRAPH_NOT_CYCLIC while X's cyclic SCC
is still present?  After that, both entry points bail out:

net/unix/garbage.c:unix_gc() {
	if (unix_graph_state == UNIX_GRAPH_NOT_CYCLIC) {
		spin_unlock(&unix_gc_lock);
		goto skip_gc;
	}
}

net/unix/garbage.c:unix_schedule_gc() {
	if (READ_ONCE(unix_graph_state) == UNIX_GRAPH_NOT_CYCLIC)
		return;
}

Closing X's fd does not release the socket while it is inflight, so nothing
calls unix_del_edges()/unix_update_graph() to re-arm the state.  Does that
leak X's struct sock, its skb and the pinned struct file until some
unrelated sender happens to pass an AF_UNIX fd to an inflight receiver?

And if two such remnant rings are found in one fast walk while the counter
is 1, does the second cyclic_sccs-- wrap the unsigned long to ULONG_MAX?
The state would then stay UNIX_GRAPH_CYCLIC, so unix_walk_scc() is never
selected again to recompute the counter, and this makes every fd-passing
send take the synchronous path:

net/unix/garbage.c:unix_schedule_gc() {
	if (user && READ_ONCE(unix_graph_cyclic_sccs))
		flush_work(&unix_gc_work);
}

The counter and the unconditional decrement predate this patch (58b47c713711
and e29c7a4cec86), so this is not a regression from the one-line addition,
but should the accounting also be corrected for the remnant case?
