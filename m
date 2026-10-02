Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4AC39C657
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790963405; cv=none; b=dOkDd0wvRPPCi6Rko7kDw3nSZZ8WwV7FVmZlRMiEkNiZZBGXoHrnnRBETmLD3mtPKUwhoFkn9kFt1ATiLRyeTJjfToswmbE7LpaThfo3WvH/fs8Ol6iIyzFGl5nrNyqJ4AsltDaFjMxa2O9Qx7U5TLHQJ9Mkcz4BAmQRrW0CSqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790963405; c=relaxed/simple;
	bh=Sx/vtWMk+G8OfUh4/fjBOYktpttzk6kJjKQTjsii3KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohS++n7sNzOpIBMFyCHzi57sYOgEobgbWiK7LvbT8DdWpOpfxKwu4sf68vsZm2uKGV+8gwGHvXsOZ2h5zstNc+PS9U9f6K135YH9AiITLPfhA8MejfoAO46Tf6arVwLDeLPBJ55z4gRgT0xWe4FZnmdAavTnfy2lu7CB8zS4Wvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=ibK0vntK; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="ibK0vntK"
Received: by dvalin.narfation.org (Postfix) id 0AFE81FDE9;
	Fri, 02 Oct 2026 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790963395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W0Ot1BcMTpNK+kbIGvFUu40hssPJaulyeB7ZBsnDB0k=;
	b=ibK0vntKL0fpbYO/LiE2omQ7Bwj5BXWxvZgiat4TIaVTab4TOQffOsUnA137kO5SJkQAdJ
	BC+qv9IlXN/bsSWIpsy6uQKWm2NIx56kg/s1IGbvE0SDizOKFknHTmj7iYhsZuWANXuKOb
	+7jG8koT3mBVmvVrQ5gt1UpkEKHPDcI=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject:
 Re: [PATCH net-next 6/9] batman-adv: tt: queue local DEL event under bucket
 lock
Date: Fri, 02 Oct 2026 19:49:49 +0200
Message-ID: <1891658.TLkxdtWsSY@sven-desktop>
In-Reply-To: <179084942939.434549.10348803956240291735@kernel.org>
References:
 <20260930094558.3723766-7-sw@simonwunderlich.de>
 <179084942939.434549.10348803956240291735@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9737943.rMLUfLXkoz";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart9737943.rMLUfLXkoz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Fri, 02 Oct 2026 19:49:49 +0200
Message-ID: <1891658.TLkxdtWsSY@sven-desktop>
In-Reply-To: <179084942939.434549.10348803956240291735@kernel.org>
MIME-Version: 1.0

On Thursday, 1 October 2026 12:10:29 CEST netdev-bot+sashiko@kernel.org wrote:
[...]
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index c904d67791f8f..c229c51cafa72 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -1427,13 +1427,20 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
> 
> [ ... ]
> 
> >  static void
> >  batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
> >  				  struct batadv_tt_local_entry *tt_local_entry,
> >  				  u16 flags, const char *message)
> >  {
> > +	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
> > +	u32 i;
> > +
> > +	i = batadv_choose_tt(&tt_local_entry->common, hash->size);
> > +	lockdep_assert_held(&hash->list_locks[i]);
> 
> [Severity: Medium]
> This is a pre-existing issue, but the code that clears
> BATADV_TT_CLIENT_PENDING doesn't follow the rule asserted here. Is the
> add path safe against batadv_tt_local_purge_pending_clients()?

You are inferring here something which is not written down like this. You are 
just assuming that another code path unrelated to this one must have the same 
rules. This is only partially correct because this is not yet the goal of this 
commit but might be something which could/should be the case at some point.

Overall: Outside the scope of this patch. Added a ticket about this for the 
actual maintainer of this code. Maybe he wakes up at some point. 
https://www.open-mesh.org/issues/476


> [Severity: Medium]
> This isn't a bug introduced by this patch, but what happens if the
> change node allocation fails here? batadv_tt_local_event() returns
> silently:
> 
> 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
> 	if (!tt_change_node)
> 		return;
> 
> By then batadv_tt_local_mark_removed() has already set
> BATADV_TT_CLIENT_PENDING and will return true, so
> batadv_tt_local_remove() skips the immediate removal. No DEL is queued
> and local_changes isn't incremented. The void return leaves no way to
> undo PENDING.

And it also shouldn't undo the pending. Instead, the correct approach is to 
make sure to announce a changed CRC.

> If another change makes local_changes non-zero, the next commit's
> batadv_tt_local_purge_pending_clients() drops the entry from the table
> and the CRC. No DEL is ever announced.

The not announced DEL seems to be OK for me here. Of course, in an ideal 
world, we would have infinite RAM and never have allocation errors. But 
falling back to a full sync is a viable option.

The only thing I don't like is the delayed recalculation of the CRC on an 
allocation error. And this is caused by the precheck in 
`batadv_tt_local_commit_changes_nolock` which depends on `local_changes` 
instead of a flag which announces any potential change (even when the 
allocation for the changes announcement list failed).

Overall: outside the scope of this patch: https://www.open-mesh.org/issues/477

[...]
> [Severity: Medium]
> This is a pre-existing issue, but now that the bucket lock is taken here,
> should this also check that tt_local_entry is still hashed?
[...]
> batadv_tt_local_remove_now() already guards against this. It queues its
> DEL only after batadv_hash_remove() confirms that this exact object was
> unlinked. That check came from the earlier series commit "batman-adv: tt:
> only queue local del event after successful unlink".
> 
> Would a hlist_unhashed() check under list_lock be the equivalent here?

Ok, list_lock is already held, so it could be a worthwhile addition. 
But outside the scope of this patch: https://www.open-mesh.org/issues/478

[...]
> [Severity: High]
> Is the bucket list_lock enough to serialize this against
> batadv_tt_local_commit_changes_nolock()?
> 
> The lock only orders this code against the
> batadv_tt_local_purge_pending_clients() pass over this one bucket. The
> later phases of the commit take no bucket lock:
> batadv_tt_local_update_crc() walks the hash under RCU, and
> batadv_tt_tvlv_container_update() drains the change list. The only thing
> holding those phases together is tt.commit_lock, and
> batadv_tt_local_remove() never takes it.
> 
> That seems to leave two windows with the result the commit message says
> it avoids.

No, it doesn't say that. It never mentions batadv_tt_tvlv_container_update. 
This is outside the scope of this patch: https://www.open-mesh.org/issues/479

> [Severity: Medium]
> This isn't a bug introduced by this patch, but the immediate purge
> branch has a similar ordering problem.

Outside the scope of this patch:

* https://www.open-mesh.org/issues/475
* https://www.open-mesh.org/issues/480

Regards,
	Sven
--nextPart9737943.rMLUfLXkoz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCar/uvQAKCRBND3cr0xT1
y2r4AQCUFsIlCLRkWvAZZ9n4FFZ7ptzzqxuljezHbV6R/70aQwD+NKl10RLbqHhi
S7kcEQk5KqSF20Pm5ypn+3Y+Mju3Kwo=
=V/Zp
-----END PGP SIGNATURE-----

--nextPart9737943.rMLUfLXkoz--



