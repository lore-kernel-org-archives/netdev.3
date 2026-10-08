Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D93A16BC;
	Thu,  8 Oct 2026 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476018; cv=none; b=Ngex0Uk4uoc0DEKFnA4s4N4D9BnOMRWGZhm1WiA0bpXaH6ybcQCk+LUHT43usS+YsnsDzSP56ZXaDAgz3avxyVThL+nxTXjOP6gAXl+jUqwoRRQnCzhxrGX0j0COrEneXql0/j0zOyY0fE8r0FeKwiqWhr4j0iS5rKskG1YFoSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476018; c=relaxed/simple;
	bh=kvNXIo4SaRlxomA7jdOnL/2uMN6SwvsWPMll1Wb0KKY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=crhsgNYRaa4Eqk0YXU0wnVECQKKBak/jnYv+8iB6MaOCJVUg4Oif30kRWg96HO4c2rpMkE+seWq6PV7xEZMTVN6A7BDIZl3JeZwzHlUmPpcyndHzHETU/Ih21eocWbVWfhiQZqpebvT/8cldXRMa3snQHGaJbZW5Uf+MAAfpVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcob3tth; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcob3tth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBFE1F0089B;
	Thu,  8 Oct 2026 16:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791476013;
	bh=1qz2zs17muwa4xmBznSqvYurFQSuqOe1Jw2rB762q0c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bcob3tthhVWUWTwyTPHVtz89KadvCQD3vwvxL1YsEOpmDNDOzG8QaoW+JNgT59kjY
	 Cz1ycVhgf7N2HwNx+r6YT8e3SenySxPsr8P/uCrOQ6up9J3gVdWmZySYEgcsxY8nNX
	 qWa3NNcqPfuAu3bcoVKpXJdlpvg30dPDRiJSGEevGNgs7jqxvo+uMvmY8saCwVIxb4
	 MeF0HfbP+qytN7fMp3uN90n78Y0vOkP07L4FcTuaZiOWjfXo9s6ahpH6ThnbWCemhv
	 1UNobuJa7d/LANTlwBEpemsW0r02FbG/hcfAnvdxRNtBdX8VNMLIk8rUzPX4DAmLN1
	 GO3ghtrNg9oHg==
Subject:
 Re: [PATCH net v12 15/15] rxrpc: fix use-after-free in rxrpc_poke_conn()
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
Date: Thu, 08 Oct 2026 16:13:32 +0000
Message-ID: <179147601260.434549.9609551545594958700@kernel.org>
In-Reply-To: <20261006133011.531806-16-dhowells@redhat.com>
References: <20261006133011.531806-16-dhowells@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes the new guard wrongly.

--

rxrpc: fix use-after-free in rxrpc_poke_conn()

Before this patch, rxrpc_poke_conn() took a reference on the connection
without checking whether the refcount had already reached zero. That
could saturate the refcount and leave a freed connection linked on
local->conn_attend_q. The patch replaces rxrpc_get_connection() with
rxrpc_get_connection_maybe(), so the poke is dropped if no reference
can be taken.

> Guard rxrpc_poke_conn() with the same liveness/refcount check the sibling
> rxrpc_queue_conn() uses before taking the poke reference, so a connection
> past its last-active point is not poked/requeued after teardown began.

[Severity: Medium]
Is this description accurate? The patch and rxrpc_queue_conn() seem to
check different things.

rxrpc_queue_conn() in net/rxrpc/conn_object.c gates only on the active
count and takes no reference:

    if (atomic_read(&conn->active) >= 0 &&
        rxrpc_queue_work(&conn->processor))
            rxrpc_see_connection(conn, why);

The patched rxrpc_poke_conn() calls rxrpc_get_connection_maybe(). That
function only does an increment-if-nonzero on the refcount and never reads
conn->active:

    if (__refcount_inc_not_zero(&conn->ref, &r))

The two predicates are not equivalent. rxrpc_service_connection_reaper()
moves active from 0 to -1 on its own, before it drops its reference:

    active = 0;
    if (!atomic_try_cmpxchg(&conn->active, &active, -1))
            continue;

So a connection with active == -1 and ref > 0 can still be poked after this
patch. Also, a client connection can reach ref == 0 without active ever
being set to -1.

The refcount check looks like the right fix for the use-after-free. Only
the wording seems off.

Could the commit message say instead that the poke reference is now taken
with refcount_inc_not_zero(), and that the poke is dropped once the
refcount has reached zero?

As written, "the same liveness/refcount check the sibling
rxrpc_queue_conn() uses" and "past its last-active point" suggest that an
active-count gate was added. An active-count check alone would not close
this use-after-free, and a stable backporter might copy that check instead.

> diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
> index 0ece717db0f85..1be50e0c9cee5 100644
> --- a/net/rxrpc/conn_object.c
> +++ b/net/rxrpc/conn_object.c
> @@ -34,7 +34,10 @@ void rxrpc_poke_conn(struct rxrpc_connection *conn, enum rxrpc_conn_trace why)
>  	spin_lock_irq(&local->lock);
>  	busy = !list_empty(&conn->attend_link);
>  	if (!busy) {
> -		rxrpc_get_connection(conn, why);
> +		if (!rxrpc_get_connection_maybe(conn, why)) {
> +			spin_unlock_irq(&local->lock);
> +			return;
> +		}
>  		list_add_tail(&conn->attend_link, &local->conn_attend_q);
>  	}
>  	spin_unlock_irq(&local->lock);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006133011.531806-1-dhowells%40redhat.com
