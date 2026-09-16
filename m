Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB03B83FE;
	Wed, 16 Sep 2026 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522550; cv=none; b=q9T/cy4203Q/0RUliluPQdbnYKWzB/pLXy7LNkofCr2s7oTjEKHUDQQL7kPyZK/6i0pb6X6H35VbXRst4NFgDP5Ahird7fgditQovLuGVwyHcXRzhaemL/Gjt0G4AOUrUEpPqg48BjT+PZNwTFe+kebwE0bdI2P036SYHAoA98U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522550; c=relaxed/simple;
	bh=ROPiQSIwv3xQU7D8gWJS0717yYoXlOjMRWTtuPxplzM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=piQ6yM27YG8ys+L3Dahih9Ys+GaXTkGaztouKldo1Fnu61UXylfJki0zBJsA0u5AMd24FdlcJfWpWaFsHDuuEXTqv9FMbk9aMUKt/deHm4HBic5gkQMgzf1lftTK89MsXolQR780GsvKlA5RctnievHawON8SMd9neCA514QI3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4pfHXER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4pfHXER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D93F1F00893;
	Wed, 16 Sep 2026 01:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522533;
	bh=dZJ7QNXdOtUPLSZh4nHpG5qz/wjlrArTyCFkINwLWvo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D4pfHXERW8Dg02w9q1ndsgtnDNJNMlg8gx9OUZYriqVgWnGGfA9Cxnih4KH4adOAH
	 yyWR/+XSMwc4Do8bBrJUZLNqjlkht3oR+HMpBusOmmoYuBoh0CtOE8WM2/c0MS1EI1
	 FLtaDpz7DkBFvrbnjxFSagqiYy7WwBX0nptnWN8uLC7kUp0bwcJvXu3s3Ap7Icrfhv
	 mPpmTkuQCcSE/70AYoj/nv6QmZqJaVAfKNVP4nuagfX9aQ+hFeJajNerTI6hjxx3Zv
	 1TYXWamQKcNv3YYx4M8H0fo54l8gwlW0jQkAJd2DRCrMYQOCQP3JIxo5P5hHT/PygQ
	 kzLvn/ctLuQgA==
Subject: Re: [PATCH] net: prestera: return error on hash table init failure
From: netdev-bot+sashiko@kernel.org
To: enachman@marvell.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, yevhen.orlov@plvision.eu,
 taras.chornyi@plvision.eu, oleksandr.mazur@plvision.eu,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, error27@gmail.com
Date: Wed, 16 Sep 2026 01:35:31 +0000
Message-ID: <178952253180.22033.10137454952622538480@kernel.org>
In-Reply-To: <20260914112026.2822222-1-enachman@marvell.com>
References: <20260914112026.2822222-1-enachman@marvell.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 1 · High: 0 · Medium: 0 · Low: 0

- [Critical] Double destroy / double free of rhashtable bucket tables on
  the prestera router teardown path.

--

net: prestera: return error on hash table init failure

prestera_router_hw_init() ran its rhashtable cleanup labels but returned 0,
so a failing rhashtable_init() was reported to prestera_router_init() as
success.  The patch changes the final return in the error path from 0 to err.

Link: https://lore.kernel.org/kernel-janitors/aqT9h61WBcslE0gJ@stanley.mountain

> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c b/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
> index ccf6cf98920f2..4785fcb62735d 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
> @@ -93,7 +93,7 @@ int prestera_router_hw_init(struct prestera_switch *sw)
>  err_nexthop_grp_ht_init:
>  	rhashtable_destroy(&sw->router->nh_neigh_ht);
>  err_nh_neigh_ht_init:
> -	return 0;
> +	return err;
>  }
>  
>  void prestera_router_hw_fini(struct prestera_switch *sw)

[Severity: Critical]
The commit message describes the bug being fixed as "dereferencing of freed
memory 'sw->router->nexthop_group_ht.tbl'".  Is a very similar dereference
still left in prestera_router_hw_fini() itself, on every teardown rather
than only on the init error path?

drivers/net/ethernet/marvell/prestera/prestera_router_hw.c:
void prestera_router_hw_fini(struct prestera_switch *sw)
{
	rhashtable_free_and_destroy(&sw->router->fib_ht,
				    prestera_fib_node_destroy_ht_cb, sw);
	WARN_ON(!list_empty(&sw->router->vr_list));
	WARN_ON(!list_empty(&sw->router->rif_entry_list));
	rhashtable_destroy(&sw->router->fib_ht);
	rhashtable_destroy(&sw->router->nexthop_group_ht);
	rhashtable_destroy(&sw->router->nh_neigh_ht);
}

fib_ht is destroyed twice here, and rhashtable_destroy() is only a wrapper
around the same function that already ran:

lib/rhashtable.c:
void rhashtable_destroy(struct rhashtable *ht)
{
	return rhashtable_free_and_destroy(ht, NULL, NULL);
}

rhashtable_free_and_destroy() does not clear ht->tbl after freeing the
bucket table:

lib/rhashtable.c:rhashtable_free_and_destroy() {
	tbl = rcu_dereference_raw(ht->tbl);
restart:
	...
	next_tbl = rcu_dereference_raw(tbl->future_tbl);
	bucket_table_free(tbl);
	if (next_tbl) {
		tbl = next_tbl;
		goto restart;
	}
}

and the free is synchronous, with another dereference of the table inside
it:

lib/rhashtable.c:
static void bucket_table_free(const struct bucket_table *tbl)
{
	if (tbl->nest)
		nested_bucket_table_free(tbl);

	kvfree(tbl);
}

So does the second rhashtable_destroy(&sw->router->fib_ht) read tbl->nest
and tbl->future_tbl out of an already kvfree()d allocation and then kvfree()
it a second time?  If the object has been recycled by then, could the
garbage value read from tbl->future_tbl send the restart loop into freeing
an unrelated pointer?

The destroys of nexthop_group_ht and nh_neigh_ht look fine, since those two
tables were only rhashtable_init()'ed and never passed to
rhashtable_free_and_destroy().

The same duplication appears one level up for kern_fib_cache_ht:

drivers/net/ethernet/marvell/prestera/prestera_router.c:prestera_k_arb_abort() {
	rhashtable_free_and_destroy(&sw->router->kern_fib_cache_ht,
				    __prestera_k_arb_abort_fib_ht_cb,
				    sw);
	...
}

drivers/net/ethernet/marvell/prestera/prestera_router.c:prestera_router_fini() {
	...
	prestera_k_arb_abort(sw);

	kfree(sw->router->nhgrp_hw_state_cache);
	rhashtable_destroy(&sw->router->kern_fib_cache_ht);
	prestera_router_hw_fini(sw);
	...
}

Both of these run unconditionally on device unbind and module removal, and
prestera_router_hw_fini() is also reached from the init error label:

err_kern_fib_cache_ht_init:
	prestera_router_hw_fini(sw);

which is the very path this patch makes reachable with a non-zero return.
Should the redundant rhashtable_destroy() calls for fib_ht and
kern_fib_cache_ht be dropped as part of this fix?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914112026.2822222-1-enachman%40marvell.com
