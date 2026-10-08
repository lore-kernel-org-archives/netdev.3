Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5031B131
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480468; cv=none; b=WKTi29Y8zHLPbsdBupn+SWJKT7A7ZWn5X4/lzOzOjf+Rcrtmey2bJrt4PY6LjsWl7cxWxC0iOyVIvrvHO529HYUIRU12b3CHsnv1WzY87NGNFqtLhgo5bjtvZHIgfrd5MWCbxK7uBIoblRImUcXuohJs8Hd4UDLvKauqVir6vpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480468; c=relaxed/simple;
	bh=OpO105d9zGfIRx895C0RjH8c2LzLNeLFfbIu1iXysRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KCxDwg83knkFIEol+3VAzf/gkN4Q0QznO2Um+NVsZ/Eb6s71VPlNmQGadRYvYM4UShcDoHBb3XAj1fymesU3tT7KnnrSJ2YI3tJjAU6e2Wffl4e6hIwINd7dvrJDxWeXDEMRkoooKETDKgo14pNclx/XZEa+XNr2dJ2d1qxBwEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRLKw46c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRLKw46c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4491F000FF;
	Thu,  8 Oct 2026 17:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791480466;
	bh=DatlTiIrthNXew33ORAOMuftR1Dq/hvCr2cXvlz4oUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=HRLKw46cxR2AjVJwfYoTpDLg9ynhB8Kw2nu0nXZbOjE4ABIZC0qog0813lveNQs3c
	 esdHRvYrulC9wKR/V8KZO/u65j8loP29Obi8W8R55DNZi0MykgzbTXtQIBNR765kk6
	 z1V7sp2UeFXh03OJQBoKK/2DFG9WfCtlY6IHr7PVHa9HKKlxgk3ObJ5p04i5W3qGME
	 JbXLffXeTOlLWyQpVf0dIe2S12gPVO/MM6dLUM1N9hvnG8O4Rda+FS2CLqRm7yODce
	 E8jg4jCMaCTMZseJEEAkYLdBDdhYwrjqi9Y87Z6skjT/0ZJgeINIIbiQLI+8Lusj2h
	 1MktIlDRuAVPg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Naman Gulati <namangulati@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: bigeasy@linutronix.de, kuniyu@google.com,
 syzbot+f0661448aa9511ce744a@syzkaller.appspotmail.com, Naman Gulati
 <namangulati@google.com>
Subject: Re: [PATCH net v3] net: gro_cells: prevent enabling threaded NAPI
 on gro_cells
In-Reply-To: <20261006235113.2394030-1-namangulati@google.com>
References: <20261006235113.2394030-1-namangulati@google.com>
Date: Thu, 08 Oct 2026 19:27:42 +0200
Message-ID: <87o6d4rtkh.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Naman Gulati <namangulati@google.com> writes:

> gro_cells allocates a per-CPU struct gro_cell with per-CPU queues
> (cell->napi_skbs), per-CPU local_lock_t (cell->bh_lock), and per-CPU
> napi_struct (cell->napi). On !CONFIG_PREEMPT_RT, local_lock_t only
> provides lockdep annotation (and is a complete no-op when
> CONFIG_DEBUG_LOCK_ALLOC is disabled), relying on per-CPU locality and
> disabled BH context for mutual exclusion; it does not provide cross-CPU
> synchronization.
>
> When threaded NAPI is enabled on a device backed by gro_cells (e.g.
> gre0, vxlan, geneve) via sysfs, unbound kernel threads are created for
> each per-CPU NAPI. When gro_cells_receive() on CPU A enqueues a packet
> to cell_A and calls napi_schedule(&cell_A->napi) while holding
> cell_A->bh_lock, the woken kthread can run concurrently on remote CPU B.
>
> When CPU B runs gro_cell_poll(&cell_A->napi) and calls
> __local_lock_nested_bh(&cell_A->bh_lock), lockdep detects that the lock
> is already held by CPU A's task and triggers a warning:
>
>   WARNING: CPU: 1 PID: 377 at net/core/gro_cells.c:66 gro_cell_poll
>   DEBUG_LOCKS_WARN_ON(l->owner)
>   CPU: 1 UID: 0 PID: 377 Comm: napi/gre0-0 Not tainted 7.3.0-rc2
>   Call Trace:
>    <TASK>
>    __local_lock_nested_bh include/linux/local_lock_internal.h:92
>    gro_cell_poll+0x5aa/0x6c0 net/core/gro_cells.c:66
>    napi_threaded_poll+0x39b/0x600 net/core/dev.c:7048
>    kthread+0x71e/0x870 kernel/kthread.c:464
>    ret_from_fork+0x5d/0x90 arch/x86/kernel/process.c:167
>    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:264
>    </TASK>
>
> On !CONFIG_PREEMPT_RT kernels without lockdep, concurrent execution of
> __skb_queue_tail() on CPU A and __skb_dequeue() on CPU B without
> cross-CPU locks leads to silent queue corruption.
>
> Virtual per-CPU NAPIs cannot support unbound threaded NAPI. While
> gro_cells also sets NAPI_STATE_NO_BUSY_POLL (which skips napi_hash_add()
> and prevents configuring them via Netlink), NAPI_STATE_NO_BUSY_POLL
> cannot be used to reject threaded NAPI in sysfs because drivers such as
> WireGuard set NAPI_STATE_NO_BUSY_POLL on per-peer NAPIs while running
> them in threaded mode by default.
>
> Introduce NAPI_STATE_PERCPU to mark per-CPU NAPIs that cannot run in
> unbound threaded mode. Set NAPI_STATE_PERCPU in gro_cells_init(), and
> fail early with -EOPNOTSUPP in modify_napi_threaded() and
> netdev_nl_napi_set_config() when trying to enable threaded NAPI on
> NAPI_STATE_PERCPU NAPIs, while still allowing disabling (writing 0) as a
> no-op.
>
> Fixes: 25718fdcbdd2 ("net: gro_cells: Use nested-BH locking for gro_cell")
> Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support=
")
> Reported-by: syzbot+f0661448aa9511ce744a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6aad6d7b.0c43d342.320d00.0001.GAE@=
google.com
> Signed-off-by: Naman Gulati <namangulati@google.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
