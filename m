Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0F823E25B
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290522; cv=none; b=GfbXUl53tBzqkGqyp4Djnfu7UF4UK/5PzRysyaVmlf7bcFSbtMhrcq97lv5pBtDyRmgHI4zXfMYEYU87cqkV8bV5Y5mSknDuT/Sn7PexAZJMBIHIokYsit/ILPw0Rxb8mijzGz+WVo3LgubtOqT12KmCBtnFnWo1LZ0Q7KEuTrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290522; c=relaxed/simple;
	bh=OM786nDRUEhIiGOe7ExMRgAD0SuzsNWVZTSAYDw6oDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbekvzNGvLKw23KHHkiEzicKVEad87DkhCizKvFaTF2rNVXCiEavOkmGAz+726fQN+6Vvm8CEYSw6Ye+o8QOcX5aaect6EaQxvCc5NqZlR5vROA2ufdmYNVRDWga+Pw7YpM94E21moI99rSrEV1fZqJT0Hh/C0m5vsPG5Px0xB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=jX5W7SYT; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="jX5W7SYT"
Received: by dvalin.narfation.org (Postfix) id 0BD3620560;
	Tue, 01 Sep 2026 19:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788290514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xh7WvfJJBvUSs/BfiNX9iN+V4qE61g+1og4hSc41+kI=;
	b=jX5W7SYTV+GFk7jl+6To03TQKzQwib+ByBzELxo9ovJzAOZ68uGJ18M79qNKa/bpJuY9az
	l9e7J0gGKNBPQ/ZOG9ahs35+wCGGVK1gmhNonnunV9tIM4ZLsMTbLvlt0YdFVVrJMBlpiD
	eoFt79q1BSIzajZHNMrAC0dcGy5o1B8=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 12/15] batman-adv: tt: use protected flag modifications
Date: Tue, 01 Sep 2026 21:21:51 +0200
Message-ID: <23246653.EfDdHjke4D@sven-desktop>
In-Reply-To: <20260831135117.574836-13-sw@simonwunderlich.de>
References:
 <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-13-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8005540.EvYhyI6sBW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart8005540.EvYhyI6sBW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 21:21:51 +0200
Message-ID: <23246653.EfDdHjke4D@sven-desktop>
In-Reply-To: <20260831135117.574836-13-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D12


> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/transl=
ation-table.c
> > index fbe75e184153..163f90962306 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
>=20
> [ ... ]
>=20
> > @@ -633,8 +652,23 @@ static void batadv_tt_local_add_roam(struct batadv=
_priv *bat_priv,
> >  	/* Check whether it is a roaming, but don't do anything if the roaming
> >  	 * process has already been handled
> >  	 */
> > -	if (tt_global->common.flags & BATADV_TT_CLIENT_ROAM)
> > -		return;
> > +	scoped_guard(spinlock_bh, &tt_global->common.flags_lock) {
> > +		if (tt_global->common.flags & BATADV_TT_CLIENT_ROAM)
> > +			return;
> > +
> > +		if (!roamed_back) {
> > +			/* The global entry has to be marked as ROAMING and has to be
> > +			 * kept for consistency purpose.
> > +			 *
> > +			 * batadv_tt_global_to_purge() evaluates roam_at as soon as it
> > +			 * observes BATADV_TT_CLIENT_ROAM, so the timeout has to be
> > +			 * stamped before the flag is published. Otherwise the entry can
> > +			 * be deleted right away as "Roaming timeout".
> > +			 */
> > +			tt_global->roam_at =3D jiffies;
> > +			tt_global->common.flags |=3D BATADV_TT_CLIENT_ROAM;
> > +		}
> > +	}
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> Should the changelog mention this ordering fix, and should the patch carry
> a Fixes: tag?

I am not allowed to add Fixes: lines for patches targeting net-next. And th=
is=20
is not suitable for net or stable backports. See
https://lore.kernel.org/all/7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com/


>=20
> The commit message describes the change as lost-update hardening with a
> self-correcting symptom:
>=20
>     This problem can usually be fixed at a later point when the flags are
>     tried to be adjusted again.
>=20
>     To reduce the time the wrong flags are used, [...]
>=20
> But the new comment above documents something stronger: the store of
> tt_global->roam_at is now moved ahead of publishing
> BATADV_TT_CLIENT_ROAM, and batadv_tt_global_to_purge() is brought under
> the same flags_lock. The same reordering is applied a second time in
> batadv_tt_global_del_roaming().
[...]

The ordering is not too relevant because they are now both under the same=20
lock. Which is more important because roam_at is tied to the flag=20
BATADV_TT_CLIENT_ROAM. So I dont' seem why they should now be splitted or=20
handled separately.


> > @@ -1285,29 +1329,23 @@ int batadv_tt_local_dump(struct sk_buff *msg, s=
truct netlink_callback *cb)
> >  }
> > =20
> >  /**
> > - * batadv_tt_local_set_pending() - mark a local TT entry as pending re=
moval
> > + * batadv_tt_local_set_pending_event() - trigger events for TT pending=
 removal
> >   * @bat_priv: the bat priv with all the mesh interface information
> >   * @tt_local_entry: local TT entry to mark
> >   * @flags: TT change flags to announce together with the pending remov=
al
> >   * @message: debug message describing the reason for the change
> >   *
> > - * Schedule the TT change announcement and set BATADV_TT_CLIENT_PENDIN=
G on the
> > - * entry. The entry is kept in the local table until the next TTVN inc=
rement
> > - * so that a consistency-check response can still be answered.
> > + * Schedule the TT change announcement for the entry. The entry is kep=
t in the
> > + * local table until the next TTVN increment so that a consistency-che=
ck
> > + * response can still be answered.
> >   */
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> The kernel-doc of batadv_tt_local_set_pending_event() still says
> "@tt_local_entry: local TT entry to mark" and still claims the entry "is
> kept in the local table until the next TTVN increment", but the body only
> calls batadv_tt_local_event() and batadv_dbg() now - the
> BATADV_TT_CLIENT_PENDING store moved into both callers.

https://patch.msgid.link/20260901-tt-pending-event-kdoc-v1-1-0454b0799d48@n=
arfation.org

>=20
> > @@ -1331,12 +1369,14 @@ u16 batadv_tt_local_remove(struct batadv_priv *=
bat_priv, const u8 *addr,
> >  	struct batadv_tt_local_entry *tt_local_entry;
> >  	struct hlist_node *tt_removed_node;
> >  	u16 curr_flags =3D BATADV_NO_FLAGS;
> > +	bool pending =3D false;
> >  	u16 flags;
> > =20
> >  	tt_local_entry =3D batadv_tt_local_hash_find(bat_priv, addr, vid);
> >  	if (!tt_local_entry)
> >  		goto out;
> > =20
> > +	spin_lock_bh(&tt_local_entry->common.flags_lock);
> >  	curr_flags =3D tt_local_entry->common.flags;
> > =20
> >  	flags =3D BATADV_TT_CLIENT_DEL;
> > @@ -1351,10 +1391,17 @@ u16 batadv_tt_local_remove(struct batadv_priv *=
bat_priv, const u8 *addr,
> >  	}
> > =20
> >  	if (!(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW)) {
> > -		batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags,
> > -					    message);
> > +		tt_local_entry->common.flags |=3D BATADV_TT_CLIENT_PENDING;
> > +		pending =3D true;
> > +	}
> > +	spin_unlock_bh(&tt_local_entry->common.flags_lock);
> > +
> > +	if (pending) {
> > +		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry, flags,
> > +						  message);
> >  		goto out;
> >  	}
>=20
> Does this invert the publication order that the old
> batadv_tt_local_set_pending() guaranteed?
>=20
> Previously the DEL change event was queued first and
> BATADV_TT_CLIENT_PENDING was set afterwards. Now the flag becomes
> visible before batadv_tt_local_event() runs, and
> batadv_tt_local_remove() holds neither the hash bucket list_lock nor
> bat_priv->tt.commit_lock:
>=20
> CPU0                                    CPU1
> batadv_tt_local_remove()
>   spin_lock_bh(&...flags_lock);
>   flags |=3D BATADV_TT_CLIENT_PENDING;
>   spin_unlock_bh(&...flags_lock);
>                                         batadv_tt_local_commit_changes()
>                                           batadv_tt_local_purge_pending_c=
lients()
>                                             hlist_del_rcu(&tt_common->has=
h_entry);
>                                           batadv_tt_local_update_crc()
>                                           atomic_inc(&bat_priv->tt.vn);
>   batadv_tt_local_set_pending_event()
>     batadv_tt_local_event()   /* DEL queued only now */
>=20
> Can the client then vanish from the local table and from the CRC of TTVN
> N while no DEL change was announced for TTVN N, leaving the neighbours to
> recover via a full table TT request after their CRC check fails?
>=20
> The sibling caller batadv_tt_local_purge_list() does not have this
> problem because batadv_tt_local_purge() holds the bucket list_lock around
> it, but batadv_tt_local_remove() is also reachable from received TT TVLV
> and roaming data via batadv_tt_global_add(), so both sides can run
> concurrently.
>=20
> Would it help to set BATADV_TT_CLIENT_PENDING after
> batadv_tt_local_event() has queued the change, or to publish the flag and
> the event under a common lock?

The old code didn't guarantee anything and wasn't really ensuring the order=
=20
other callers see it. And it is unfortunately not too trivial as moving the=
=20
position because it is not known earlier if the entry is pending or not.=20
Something more like this would then be required:


diff --git i/net/batman-adv/translation-table.c w/net/batman-adv/translatio=
n-table.c
index 1fcbe417..b008c8b1 100644
=2D-- i/net/batman-adv/translation-table.c
+++ w/net/batman-adv/translation-table.c
@@ -1498,7 +1498,9 @@ batadv_tt_local_set_pending_event(struct batadv_priv =
*bat_priv,
=20
 /**
  * batadv_tt_local_mark_removed() - mark a local entry as removed
+ * @bat_priv: the bat priv with all the mesh interface information
  * @tt_local_entry: local TT entry to mark
+ * @message: message to append to the log on deletion
  * @roaming: true if the deletion is due to a roaming event
  * @curr_flags: pointer to store the flags of the entry before it was mark=
ed
  *
@@ -1506,23 +1508,46 @@ batadv_tt_local_set_pending_event(struct batadv_pri=
v *bat_priv,
  * ttvn increment, false if it can be purged immediately.
  */
 static bool
=2Dbatadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entr=
y,
=2D			     bool roaming, u16 *curr_flags)
+batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
+			     struct batadv_tt_local_entry *tt_local_entry,
+			     const char *message, bool roaming, u16 *curr_flags)
 {
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common =3D &tt_local_entry->common;
+	struct batadv_hashtable *hash =3D bat_priv->tt.local_hash;
 	bool pending =3D false;
+	u16 flags;
+	u32 i;
=20
=2D	scoped_guard(spinlock_bh, &common->flags_lock) {
=2D		*curr_flags =3D common->flags;
+	flags =3D BATADV_TT_CLIENT_DEL;
+	/* if this global entry addition is due to a roaming, the node has to
+	 * mark the local entry as "roamed" in order to correctly reroute
+	 * packets later
+	 */
+	if (roaming)
+		flags |=3D BATADV_TT_CLIENT_ROAM;
=20
=2D		/* mark the local client as ROAMed */
=2D		if (roaming)
=2D			common->flags |=3D BATADV_TT_CLIENT_ROAM;
+	i =3D batadv_choose_tt(tt_local_entry, hash->size);
+	list_lock =3D &hash->list_locks[i];
=20
=2D		if (!(common->flags & BATADV_TT_CLIENT_NEW)) {
=2D			common->flags |=3D BATADV_TT_CLIENT_PENDING;
=2D			pending =3D true;
+	scoped_guard(spinlock_bh, list_lock) {
+		scoped_guard(spinlock_bh, &common->flags_lock) {
+			*curr_flags =3D common->flags;
+
+			/* mark the local client as ROAMed */
+			if (roaming)
+				common->flags |=3D BATADV_TT_CLIENT_ROAM;
+
+			if (!(common->flags & BATADV_TT_CLIENT_NEW)) {
+				common->flags |=3D BATADV_TT_CLIENT_PENDING;
+				pending =3D true;
+			}
 		}
+
+		if (pending)
+			batadv_tt_local_set_pending_event(bat_priv,
+							  tt_local_entry,
+							  flags, message);
 	}
=20
 	return pending;
@@ -1580,24 +1605,13 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_=
priv, const u8 *addr,
 {
 	struct batadv_tt_local_entry *tt_local_entry;
 	u16 curr_flags;
=2D	u16 flags;
=20
 	tt_local_entry =3D batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
 		return BATADV_NO_FLAGS;
=20
=2D	flags =3D BATADV_TT_CLIENT_DEL;
=2D	/* if this global entry addition is due to a roaming, the node has to
=2D	 * mark the local entry as "roamed" in order to correctly reroute
=2D	 * packets later
=2D	 */
=2D	if (roaming)
=2D		flags |=3D BATADV_TT_CLIENT_ROAM;
=2D
=2D	if (batadv_tt_local_mark_removed(tt_local_entry, roaming, &curr_flags))
=2D		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
=2D						  flags, message);
=2D	else
+	if (!batadv_tt_local_mark_removed(bat_priv,tt_local_entry,
+					  message, roaming, &curr_flags))
 		/* if this client has been added right now, it is possible to
 		 * immediately purge it
 		 */

[...]
> Discovered by: gpt-5-6-sol =C2=B7 Missed by: opus-5, sashiko-gemini =C2=
=B7 Confirmed by: opus-5
> Can deferring batadv_tt_global_del_orig_list() until after flags_lock is
> dropped lose an originator entry added in between?
>=20
> The old code purged the originator list first and cleared
> BATADV_TT_CLIENT_TEMP / BATADV_TT_CLIENT_ROAM afterwards, so a second
> context still saw the flag and did its own purge. Now the cleared flag is
> published before the list is wiped:
>=20
> CPU0 batadv_tt_global_add()             CPU1 batadv_tt_global_add()
>   spin_lock_bh(&common->flags_lock);
>   delete =3D true;
>   common->flags &=3D ~BATADV_TT_CLIENT_TEMP;
>   spin_unlock_bh(&common->flags_lock);
>                                         spin_lock_bh(&common->flags_lock);
>                                         /* TEMP already clear, so
>                                          * delete stays false
>                                          */
>                                         spin_unlock_bh(&common->flags_loc=
k);
>                                         batadv_tt_global_orig_entry_add()
>   batadv_tt_global_del_orig_list()
>     /* drops every orig entry,
>      * including CPU1's fresh one
>      */
>=20
> batadv_tt_global_del_orig_list() takes tt_global_entry->list_lock and
> removes all entries:
>=20
> 	spin_lock_bh(&tt_global_entry->list_lock);
> 	head =3D &tt_global_entry->orig_list;
> 	hlist_for_each_entry_safe(orig_entry, safe, head, list)
> 		_batadv_tt_global_del_orig_entry(tt_global_entry, orig_entry);
>=20
> Both callers return true in that case, so does the route via CPU1's
> originator silently disappear until the next global CRC mismatch triggers
> a fresh TT request? batadv_tt_global_add() is reached from received TT
> TVLV data (serialized only per originator by orig_node->tt_lock) and from
> batadv_tt_add_temporary_global_entry(), so two CPUs can process
> announcements for the same client from different originators at the same
> time.

I really wait until you tell me I couldn't solve world hunger and all=20
conflicts on the world with this patch.
https://www.open-mesh.org/issues/474

>=20
> One more note, on the sibling patch "batman-adv: clarify cut-off in
> batadv_v_neigh_is_sob kernel-doc" in this series:
>=20
> Discovered by: gpt-5-6-sol =C2=B7 Missed by: opus-5, sashiko-gemini =C2=
=B7 Confirmed by: opus-5
> The kernel-doc of batadv_v_neigh_is_sob() in net/batman-adv/bat_v.c says
> the function returns true if the candidate throughput is "more than 3/4 of
> the @reference throughput", while the body computes:
>=20
> 	threshold =3D ifinfo_ref->bat_v.throughput / 4;
> 	threshold =3D ifinfo_ref->bat_v.throughput - threshold;
>=20
> 	ret =3D ifinfo_cand->bat_v.throughput > threshold;
>=20
> With integer division that is ceil(3 * ref / 4) and a strict comparison,
> so for a reference throughput of 5 the threshold becomes 4 and a
> candidate of 4 is rejected although 4 is more than 3/4 * 5. Should the doc
> say the cut-off is the reference minus reference / 4, exclusive?

Out-of-scope.=20

Regards,
	Sven
--nextPart8005540.EvYhyI6sBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapclzwAKCRBND3cr0xT1
y8GkAPwIeKefEzlKHBi1wGMNpjWV082a9TPsNKAv9gZr06JWJQD/TTaZC4f9D9Ll
D9cBmaavlXyfMoCYnRLnXQtN6Rz+Fw4=
=VlyU
-----END PGP SIGNATURE-----

--nextPart8005540.EvYhyI6sBW--



