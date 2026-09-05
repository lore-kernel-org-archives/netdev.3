Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF435BDC7
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788620118; cv=none; b=IoZM8sNyU216r38jrRClWiwy4qBwxP5r9NMeGjUWOZpq9hvTKsk2RLq2oKTKhYbvTjLwSBOvQsVxe4+ZuMuUq+TpWhJVahyp1NVTeq7AlbZM+VmdR9VF5rtzyUJ+uvMgtAcwVXaw4h+wAefURlRqEB9bfATiU3UU/wuJ7EHBDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788620118; c=relaxed/simple;
	bh=bHoc5z3JbgIk7kQOVBSsQZbepVSzOCx4tKoGlnOY1Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4SFi0vedPELzQhVAbPwAShqZkYfzAB29eIjQWXTlH+JluNTi6PBKloRDRskIPiacdQpoXcszGM7nsX857GKFO+0tfI7xWyw1j2XvVoGZpBULqW038EUA0aYJhuY70SVVvfDlCbeQQGhITjv9QmxM+uISox1cah65zQwmTVRul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TofL0pz6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TofL0pz6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D12B1F00A3A;
	Sat,  5 Sep 2026 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788620116;
	bh=6rn0BteBoe7+IZlbBKqhLm1T8fHj3oMMR9k22JYHpIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TofL0pz6ofiHZ5Il2Q5Rd0ce61xp6fQDzxDAH9Q/3ha0SmOLZ50qWIOEFUKp4FZaz
	 dQcz1E72G/ofmJt42PlZcb1hDt2YqSFmKv2qoSjc+3RoKiX5R0ZD9j30AxzgCWW4D3
	 e3SuPkNr1OzcAgHeP2ZrwgKsfWusaJSdtBQXN30GwAgEbzHOsihaAjIO0aeIbMpvFB
	 ZtV64PF6HOfvI83OGp/PhlZnaJKf0dlqrd0lMmgQtWnQMbzXldR/8CmZXh2e9Ezp3K
	 67LFnnpORNy3gSUMCdnC18s64NE1v5dSdWLljM+tUGgjZWR8yMnfcpZUqQym9fTFeg
	 dR+ntUQEA6jaA==
Date: Sat, 5 Sep 2026 15:55:12 +0100
From: Simon Horman <horms@kernel.org>
To: Seungwon Bae <qotmddnjs@ajou.ac.kr>
Cc: dhowells@redhat.com, marc.dionne@auristor.com,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: fix use-after-free in rxrpc_poke_conn()
Message-ID: <20260905145512.GA40544@horms.kernel.org>
References: <20260901051045.58252-1-qotmddnjs@ajou.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901051045.58252-1-qotmddnjs@ajou.ac.kr>

On Tue, Sep 01, 2026 at 02:10:45PM +0900, Seungwon Bae wrote:
> rxrpc_poke_conn() takes a reference on the connection with no liveness
> check, unlike its sibling rxrpc_queue_conn() which gates on
> atomic_read(&conn->active) >= 0.  The per-connection timer is armed with
> no reference held for it, and rxrpc_put_connection() cancels it with a
> non-synchronous timer_delete() only after the refcount reaches 0.
> refcount_t saturates rather than resurrecting, so the connection can be
> kfree()d while still linked in local->conn_attend_q (nothing in teardown
> unlinks attend_link).  The rxrpc I/O thread then performs a UAF write
> (list_del_init) plus UAF reads and indirect calls through conn->security.
> 
> Reproduced on a KASAN + PREEMPT kernel: 56 "refcount_t: addition on 0"
> saturations at load, escalating to
> 
>   BUG: KASAN: slab-use-after-free in rxrpc_io_thread   Write of size 8
> 
> AF_RXRPC socket creation (rxrpc_create) has no capability check, so this
> is reachable by an unprivileged user.
> 
> Guard rxrpc_poke_conn() with the same liveness/refcount check the sibling
> rxrpc_queue_conn() uses before taking the poke reference, so a connection
> past its last-active point is not poked/requeued after teardown began.
> 
> Verified before/after on KASAN+PREEMPT at equal timer volume: 56
> saturations + 15 KASAN reports unpatched vs 0 and 0 patched.
> 

I think a Fixes tag is needed here, citing the patch where
this problem first manifested.

Perhaps this one?

Fixes: f2cce89a074e ("rxrpc: Implement a mechanism to send an event notification to a connection")

If so, there shouldn't be any further action required to that end.
But if you do re-post for some other reason note that
there should not be a blank line between the Fixes and
Signed-off-by tags (or between any other tags).

> Signed-off-by: Seungwon Bae <qotmddnjs@ajou.ac.kr>

...
