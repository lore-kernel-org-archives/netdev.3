Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E964DDB5F
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849437; cv=none; b=GT4HmKw7PjZHaxLDkCQmRTo2IsBc/1p0TseGsPP3YJaGlwSql2njMKRK4B/U5zHQn3b8/pvL65AQIjCO2M5ksxCQv6l4Wt77PlqU5P6EUnIae+fDwz46NE+aCBOix7TE34LdINE/u1UhX2tw1b97Rohvk9RlP2kmwdUpdd59vaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849437; c=relaxed/simple;
	bh=/ZUefTHFWUVOSvzO+XOZACKXxAm0Uou0sSLQIAzCx10=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CgPv45DZsXf7y9iKY91bJwJy0jhZWKVsTi/uK4YKtApP/inr8PEJ86GHB34ZJmPpAMPxuJpbB5CT9zhyD9fOc9qCgLAFKUcBGc8xZ5Vy5pV1Wo7gl89bbOHuxy1OKj7YKZ3jn7b/78BKx7oCxsFvPGaVZ1wcScrrinctVCU3hK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSfCFWiQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSfCFWiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AC31F0089B;
	Thu,  1 Oct 2026 10:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790849431;
	bh=mYCwVZ86pk4vf/57gZPBZ3UBch9DOIJqfwIhHYuihbY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eSfCFWiQ9shRsqAnZXXUua0xTEtxnAT6x+0Ue7Rj+F11RDVEJoDN15ZYWWwaVwME8
	 SNkElTiHhGCmw3ishFw7zu4IldDTqYvQu/ja1mETLVsx6uBWpYA72K9N/1/giKGiKi
	 tClfTNd//5BbG2HfSAwZZMwcs2H21jK7tjyV3GjY2x5G2oRNUbJSGw9E7h74BEcHPK
	 t3S8nbr8/7EqpJrU3/snEy8oFdw/3ktybPBncDyEXCMJzQKuQqV58aoOcMuQGQNR36
	 Sd17jnNlzPH2sfDfRNR5s1ar6BscuCzwmjob+/WcLFmm3cdPsuQlyKRat4n8LZV+37
	 0CjMBk20hmILw==
Subject: Re: [PATCH net-next 7/9] batman-adv: tt: queue local DEL event before
 marking entry as pending
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Thu, 01 Oct 2026 10:10:30 +0000
Message-ID: <179084943057.434549.7181634875043920373@kernel.org>
In-Reply-To: <20260930094558.3723766-8-sw@simonwunderlich.de>
References: <20260930094558.3723766-8-sw@simonwunderlich.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix covers only one ordering of the set_pending vs. re-add
  race.
- [Low] Stale locking rationale in the new kernel-doc.

--

batman-adv: tt: queue local DEL event before marking entry as pending

This patch restores the original order in batadv_tt_local_set_pending(),
so the DEL change is queued before BATADV_TT_CLIENT_PENDING is set. It
also moves the NEW check, the event queuing and the PENDING update into a
single flags_lock critical section. The goal is to stop a concurrent
batadv_tt_local_add_existing() from leaving the PENDING state and the
queued changes out of sync, which corrupts the TT CRC on neighbour nodes.

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index c229c51cafa72..481dc6afaaba1 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c

[ ... ]

> @@ -1420,28 +1433,37 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
>  }
>  
>  /**
> - * batadv_tt_local_set_pending_event() - trigger events for TT pending removal
> + * batadv_tt_local_set_pending() - mark local TT entry as pending removal
>   * @bat_priv: the bat priv with all the mesh interface information
> - * @tt_local_entry: local TT entry which was marked as BATADV_TT_CLIENT_PENDING
> + * @tt_local_entry: local TT entry to mark as BATADV_TT_CLIENT_PENDING
>   * @flags: TT change flags to announce together with the pending removal
>   * @message: debug message describing the reason for the change
>   *
> - * Schedule the TT change announcement for the entry. The caller must already
> - * have added BATADV_TT_CLIENT_PENDING to the @tt_local_entry and must hold the
> - * hash bucket list_lock of @tt_local_entry since setting the flag.
> + * Schedule the TT change announcement and set BATADV_TT_CLIENT_PENDING on the
> + * entry. The entry is kept in the local table until the next TTVN increment
> + * so that a consistency-check response can still be answered.
> + *
> + * Next to the flags_lock of the entry, the caller must hold the hash bucket
> + * list_lock of @tt_local_entry. Otherwise
> + * batadv_tt_local_purge_pending_clients() could remove the entry before its
> + * change was queued.

[Severity: Low]
Is this rationale still accurate after the reordering?

With this patch, batadv_tt_local_set_pending() queues the event and then
sets BATADV_TT_CLIENT_PENDING, and both happen inside one
common->flags_lock section:

    __batadv_tt_local_event(bat_priv, common, common->flags | flags);
    common->flags |= BATADV_TT_CLIENT_PENDING;

batadv_tt_local_purge_pending_clients() only acts on PENDING after
reading it under the same flags_lock:

    scoped_guard(spinlock_bh, &tt_common->flags_lock) {
        if (!(tt_common->flags & BATADV_TT_CLIENT_PENDING)) {

So it looks like purge_pending_clients() cannot see PENDING before the
change is queued, whether or not list_lock is held.

The updated batadv_tt_local_mark_removed() kernel-doc has the same
problem. It still gives the old order ("marked as
BATADV_TT_CLIENT_PENDING and the (roamed) DEL change is queued"). It also
adds a claim that list_lock prevents batadv_tt_local_transition_new() from
clearing BATADV_TT_CLIENT_NEW after it was checked. As far as I can tell,
that protection comes from the NEW check and set_pending() sharing one
flags_lock scoped_guard. The commit message says the same thing.

Could both comments name the single flags_lock section, together with the
queue-then-mark order, as the invariant? A later change could otherwise
move __batadv_tt_local_event() out of the flags_lock section while keeping
list_lock, and bring back the ADD/DEL misordering this patch fixes.

>   */
>  static void
> -batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
> -				  struct batadv_tt_local_entry *tt_local_entry,
> -				  u16 flags, const char *message)
> +batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
> +			    struct batadv_tt_local_entry *tt_local_entry,
> +			    u16 flags, const char *message)
> +	__must_hold(&tt_local_entry->common.flags_lock)
>  {
> +	struct batadv_tt_common_entry *common = &tt_local_entry->common;
>  	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
>  	u32 i;
>  
> -	i = batadv_choose_tt(&tt_local_entry->common, hash->size);
> +	i = batadv_choose_tt(common, hash->size);
>  	lockdep_assert_held(&hash->list_locks[i]);
> +	lockdep_assert_held(&common->flags_lock);
>  
> -	batadv_tt_local_event(bat_priv, tt_local_entry, flags);
> +	__batadv_tt_local_event(bat_priv, common, common->flags | flags);
> +	common->flags |= BATADV_TT_CLIENT_PENDING;

[Severity: High]
Does this close only one ordering of the race with the re-add path?

The add side still changes the flags and queues the ADD in two separate
steps. batadv_tt_local_add_existing() clears PENDING inside a flags_lock
scoped_guard and returns. batadv_tt_local_add() then queues the ADD after
that lock is dropped:

    if (added)
        batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
    ...
    if (batadv_tt_local_update_flags(bat_priv, tt_local, iif_is_wifi, mark))
        batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);

batadv_tt_local_set_pending() can run in that window from the RX path:

batadv_tt_global_add()->batadv_tt_global_purge_local()->
  batadv_tt_local_remove()->batadv_tt_local_mark_removed()->
    batadv_tt_local_set_pending()

Here is one interleaving, starting with DEL#1 already queued and PENDING
set:

  CPU1 (TX)                         CPU0 (RX)
  batadv_tt_local_add()
    batadv_tt_local_add_existing()
      flags &= ~PENDING;
                                    batadv_tt_local_mark_removed()
                                      batadv_tt_local_set_pending()
                                        DEL|ROAM merged into DEL#1
                                        flags |= PENDING;
    batadv_tt_local_event(NO_FLAGS)
      ADD cancels DEL#1

There is a similar case with no earlier DEL. batadv_tt_local_update_flags()
returns true on CPU1, CPU0 queues a new DEL and sets PENDING, and then the
ADD from CPU1 cancels that DEL through the DEL+ADD case in
__batadv_tt_local_event().

Either way, the entry would be left PENDING with no DEL queued. At the
next commit, batadv_tt_local_purge_pending_clients() would remove it
locally, but neighbours would never receive a DEL.

Wouldn't that give the same CRC mismatch and full table request that the
commit message describes? Would the ADD also need to be queued inside the
flags_lock section that clears PENDING or updates the flags?

>  
>  	batadv_dbg(BATADV_DBG_TT, bat_priv,
>  		   "Local tt entry (%pM, vid: %d) pending to be removed: %s\n",
> @@ -1460,7 +1482,8 @@ batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
>   * An already announced entry is marked as BATADV_TT_CLIENT_PENDING and the
>   * (roamed) DEL change is queued. Both happen under the hash bucket list_lock
>   * of the entry to prevent concurrent batadv_tt_local_purge_pending_clients()
> - * from removing the entry.
> + * from removing the entry and batadv_tt_local_transition_new() from clearing
> + * BATADV_TT_CLIENT_NEW after it was checked.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de
