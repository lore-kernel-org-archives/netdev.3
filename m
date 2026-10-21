Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598556;
	b=kjrfzD5bOK1jA9ElzqnoWF2ysqJ2/0GhlCgy7YYLoxRcOHsO6+QWuOYPnHTrlwWDYeoV
	 TM5xA2wriYnXX+Lp/WLqzkQsPArXhFy1/OzaKTxBFexa9nKfargf0N5CIweCn1cCTmzp4
	 mhi4PtXNARuE9RUpRP8hs342KAYb8TxJX8KlO2klS/71yR8ZrJ/agbAjqy5ZvXzA/5jgH
	 LtAtxLenxfFmkT3ovVmxBHOPMR4aCeyOdcBs4FPJaLh1QYpWXlN9K8qnUjBLeEtmWKx80
	 TUR+/4ZvE8ZWJ5SzOZotmgrJ0PujGQRTzozq8QC7z5uhd5VgtuwbBOe8Fg+MOQUJxNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598556;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=unxGjNmWjmKxPVMKqet4dyFVIr42sVktbDhjna/G2Pc=;
	b=bvxEMAV8uowXSycGnzpY8yGe+XpjkGmKjq75KCLygM7JaTuthnk1U263w5awafC18SFY
	 UR1tHiyYwhZEwtSC1sVREQ3qVmwT2YOV3+YOiN1sBYpVsE2ZI6+ND14IX7IwUBpn40RmZ
	 Xkvxaop4ydkvsnlfC7EK5OW5IjJaJXf3jSBwzgxX76eC7b0bY6bqN4y3LkwoVAdV6h6Ao
	 +/ptnu68ANu/0nizARxASn66l2pCi9iup/cRx7HD+e0Db4sYD7UOL3AGPHauc9SEjaSMV
	 pdv+ZdGP04CDLRcxPXl8o6K1M0CwuAF40N3701xWfacbUYla1NpSrqdKlCMeJIm2Rxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQsRAULx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2075606A31B;
	Wed, 21 Oct 2026 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQsRAULx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE791F000C1;
	Wed, 21 Oct 2026 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792598555;
	bh=unxGjNmWjmKxPVMKqet4dyFVIr42sVktbDhjna/G2Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZQsRAULxEa/l3F/yq6G1Yt82l82Ck8dOZ+nripXtrStRgDFpEvDZYS/36sjMjodmG
	 mPDa9un02h8rngivsJ8E3f9Wgr3LbIdoXzdnz9lsyK28zSzOPw7Iz5wSI/5CEPJ3WZ
	 e2DFbPB3PWLpP8184K5cllTwXqwbb0/wjk3HFCAJCS7H6fb27jbPZPYGvOLRYmm/e+
	 QNVbwuiiwD4URsg9ncptrsvenCu68WlIfBzpzfkXDVeksfK+HEES6E5uD5XQQFNZUt
	 JSyOWIoLSJeiII0tZvsfOHPPXELdhqaEpiBivqWf78n7WqD/ZyTtVe7O8GTq/wXJ1T
	 weiX3dP9wO57w==
Date: Wed, 21 Oct 2026 17:02:31 +0100
From: Simon Horman <horms@kernel.org>
To: Binbin Deng <18983559317@163.com>
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] tipc: fix use-after-free of broadcast reception
 link at node release
Message-ID: <20261021160231.GC708417@horms.kernel.org>
References: <20261019104352.488347-1-18983559317@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019104352.488347-1-18983559317@163.com>

On Mon, Oct 19, 2026 at 06:43:52PM +0800, Binbin Deng wrote:
> When the last reference to a tipc_node is dropped, the node itself is
> deferred to the RCU callback tipc_node_free(), but the nested broadcast
> reception link, n->bc_entry.link, is kfree()d synchronously in
> tipc_node_kref_release(), before call_rcu(), and the pointer is never
> cleared.  Readers that obtained the node from node_list and then
> dereference bc_entry.link deep into the link (tipc_link_name() in
> tipc_nl_node_reset_link_stats(), bcl->name/stats in
> tipc_nl_add_bc_link() on the link dump path) therefore touch freed
> memory although the enclosing node stays alive for a full grace period.
> The sibling per-bearer links get "kfree + NULL" under the node write
> lock in tipc_node_clear_links(); the broadcast entry was missed.
> 
> The race is reachable through the node cleanup timer: once a peer has
> been unreachable for NODE_CLEANUP_AFTER (300 s), tipc_node_timeout() ->
> tipc_node_cleanup() unlinks the node under the write lock, and the
> final tipc_node_put() at the caller runs outside node_list_lock, so the
> kfree executes in timer softirq context, concurrently with genl dump/
> reset walkers that hold only rcu_read_lock().  (A netlink "peer remove"
> cannot race those walkers itself: tipc_genl_family has no parallel_ops,
> so all doit/dumpit calls serialize on the global genl lock.)
> 
> Reproduced in a QEMU/KVM guest running v7.3.0 with KASAN and
> PREEMPT(full): 10 TIPC peer namespaces on veth bearers, bearer removal
> staggered so the 300 s node cleanup timers expire while other tasks
> loop link dumps with the broadcast filter and reset-link-stats lookups.
> KASAN hit within two cleanup cycles:
> 
>   BUG: KASAN: slab-use-after-free in strlen+0x85/0xa0
>   Read of size 1 at addr ffff88800b54a004 by task poc_eth/371
>    strlen+0x85/0xa0
>    tipc_nl_add_bc_link+0x2f9/0xd40
>    __tipc_nl_add_node_links+0x10c/0x140
>    tipc_nl_node_dump_link+0x8d5/0xd50
>   Freed by task 0:
>    kfree+0x121/0x380
>    tipc_node_timeout+0xa33/0xcf0
>    run_timer_softirq+0x144/0x250
>    sysvec_apic_timer_interrupt

For reference, it is preferred to provide stack traces decoded using
scripts/decode_stacktrace.sh as the information provided easies the
work of review.

> 
> with the freed object being the kmalloc-1k tipc_link allocated by
> tipc_link_bc_create() during peer discovery.  The same defect fires in
> strcmp() called from tipc_nl_node_reset_link_stats().
> 
> Move the kfree of n->bc_entry.link into the tipc_node_free() RCU
> callback so the broadcast link lives exactly as long as the enclosing
> node.  All readers are covered: the netlink walkers are inside
> rcu_read_lock(), and the packet reception path reaches the node via
> tipc_node_find(), whose kref defers kref_release itself.
> 
> Found during a static-analysis-assisted audit: candidate sites were
> surfaced by a Coccinelle rule, and the reader/writer paths were
> confirmed by LLM-assisted (GLM-5.3) code inspection.
> 
> Fixes: d25a01257e42 ("tipc: fix crash during node removal")
> Assisted-by: GLM-5.3 coccinelle
> Signed-off-by: Binbin Deng <18983559317@163.com>

Thanks for the analysis and patch.
This looks correct to me.

Reviewed-by: Simon Horman <horms@kernel.org>
