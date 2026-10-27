Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091325;
	b=jXTLbfvJH7V/Y6YxpsdNFNhIi9k7jLxA06lew88h9+JRZUBjjt7AUfi5nOme2CHjB4Fm
	 4OVHzrmKuBigWVhnVMlOTOGS+MeGVSMfIZYkdA9G5pLl95EkYdKGbfkD4xb5b31by/uRo
	 r+RItU6545KCRltR35bBgV4MZsmZWpwBB7lwN0cJ+Dt7TbIb/JWSAZR5OPXXfuFTL3bGH
	 1iV5C/GiTEr6WpUswb1l/oj8IrV9ohxgO4ACkY289tdGm6QCZ0AmVDYPS0pXmvE5zS6bu
	 DP37oqhWrhAwt9x8P/88t/ALgkwPo6jrTWl2qNXqfW/UN6cOuRWnGUUGFCY4rkic0kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091325;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ycmHVLdjANaBXFri6M9YV7t1MVyiCkb/s4ogXc52uWQ=;
	b=fLWEmVzZp1bDb7q2dEHGtkOx5a+dQwC7z0gyRgP68jT4Ir5QnM7ln3wcsmP8paNjYS45
	 9l693ndxu9Ct2WQOO9x5Zwu4q2YbocPZD9ut+E21HDzV94uSfBl9goS6+OPoLl5YT/3cG
	 MwCzCez3XkuRp5EKnD2D38EcjZw16hql4Lrxu/Xz2Hb3B/yhgzMKIOyzNmnI1xy4zCl4L
	 BHZkhjv+89yHTrZFZTXFTZU5WVQPRzgo3GHkTqPEX8Q2Y3Ko630Q3wXZvvTYDKJSdbfQo
	 my9sb/XG3cH0Rw1ulARFQVdnn3GUkwAlfMAzNRuvcH4ZmAzkbBEvBOQD1UMNvFYGqqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mjLzc/83";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5CB606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjLzc/83
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161691F01825;
	Tue, 27 Oct 2026 08:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091324;
	bh=ycmHVLdjANaBXFri6M9YV7t1MVyiCkb/s4ogXc52uWQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mjLzc/83GJ1lfUwM1Lfz/D4T4mQgER5fRow8FC1vpLGlUr5RBakequEFuBnBxagug
	 4KV5ipVszdFPX8jyr2e1E2ndaYGaWa1jvcC+kf4IAwbAiorI1am5aXNJha59NLrvS7
	 pYRjvbuGs7qVtj91BjV+1zgxKjwHknd9BEbR5lObCIpHd0lLkGXcHV3k/WU1m7RyZi
	 v0MTvnwA+LAHD1fKjWQMaeUl3+j7lYu4Lg0NVnct4AczISPAafGSLHaeFwwZrWJCE3
	 pRcykk4+5fCKZ9wxJAGgBeLm7R9+0DZQIGFtnqESBqFsAdrb53lMWJ5q5LUV3xB6my
	 EQCSgyIDXnOPw==
Subject: Re: [PATCH net 09/10] batman-adv: tt: don't drop local events queued
 during TVLV update
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Tue, 27 Oct 2026 08:55:23 +0000
Message-ID: <179309132364.3134.18203109296409373363@kernel.org>
In-Reply-To: <20261026085309.1074911-10-sw@simonwunderlich.de>
References: <20261026085309.1074911-10-sw@simonwunderlich.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new `!tvlv_len` error path in
  batadv_tt_tvlv_container_update() drops the snapshotted changes…
- [Low] The new allocation-failure path in
  batadv_tt_tvlv_container_update() (net/batman-adv/translation-table.c,…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the window
  it leaves open has worse consequences than the commit message says.

--

batman-adv: tt: don't drop local events queued during TVLV update

This patch makes batadv_tt_tvlv_container_update() splice the changes_list
and read/reset local_changes atomically under changes_list_lock. Events
queued after the snapshot then stay pending for the next TT round. If the
TVLV buffer allocation fails, the snapshotted changes are now freed instead
of kept.

Closes: https://sashiko.dev/#/bug/linux-fc286ddd-5bed-4683-b842-ee7a307eeb19

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 24054077cf3db..6774484f1c573 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -1327,11 +1327,18 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
>  	int tt_diff_entries_num = 0;
>  	bool drop_changes = false;
>  	size_t tt_extra_len = 0;
> +	LIST_HEAD(changes_list);
>  	int tt_change_len = 0;
>  	int tt_diff_len;
>  	u16 tvlv_len;
>
> +	/* atomically get the list of changes */
> +	spin_lock_bh(&bat_priv->tt.changes_list_lock);
> +	list_splice_init(&bat_priv->tt.changes_list, &changes_list);
>  	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
> +	WRITE_ONCE(bat_priv->tt.local_changes, 0);
> +	spin_unlock_bh(&bat_priv->tt.changes_list_lock);

[Severity: Medium]
This isn't a bug introduced by this patch, but the window left open at the
end of the commit message seems to have a worse effect than described. An
event in that window can be lost, not just announced under the wrong TTVN
or CRC.

batadv_tt_local_commit_changes_nolock() makes its decisions from a lockless
read, before this splice happens:

    if (READ_ONCE(bat_priv->tt.local_changes) == 0) {
        if (!batadv_atomic_dec_not_zero(&bat_priv->tt.ogm_append_cnt))
            batadv_tt_tvlv_container_update(bat_priv);
        return;
    }

    batadv_tt_local_transition_new(bat_priv);
    ...
    batadv_tt_local_update_crc(bat_priv);
    atomic_inc(&bat_priv->tt.vn);

__batadv_tt_local_event() only takes changes_list_lock, not commit_lock.
Consider an ADD for a new client queued through
batadv_interface_tx()->batadv_tt_local_add()->__batadv_tt_local_event()
after that check but before the splice. In the ogm_append_cnt branch, the
splice takes the event, announces it under the unchanged TTVN, and sets
local_changes to 0.

Receivers see ttvn == orig_ttvn in batadv_tt_update_orig() and ignore the
attached changes. batadv_tt_local_crc() also skips NEW entries:

    if (tt_flags & BATADV_TT_CLIENT_NEW)
        continue;

So the CRC still matches and no table request is sent.

Later rounds see local_changes == 0, so batadv_tt_local_transition_new()
never runs for this client. Could the client then stay NEW, excluded from
the CRC and from full-table replies via batadv_tt_local_valid(), until some
unrelated local TT event triggers a commit?

Would either of these close the window: taking the snapshot in
batadv_tt_local_commit_changes_nolock() before the local_changes check and
passing the list down, or not consuming the list in the non-committing
branch?

> +
>  	tt_diff_len = batadv_tt_len(tt_diff_entries_num);
>
>  	/* if we have too many changes for one packet don't send any

[ ... ]

> @@ -1349,19 +1356,23 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
>
>  	tvlv_len = batadv_tt_prepare_tvlv_local_data(bat_priv, &tt_data,
>  						     &tt_change, &tt_diff_len);
> -	if (!tvlv_len)
> +	if (!tvlv_len) {
> +		/* the TTVN of the changes is lost and the other nodes will
> +		 * have to request the full table anyway
> +		 */
> +		list_for_each_entry_safe(entry, safe, &changes_list, list) {
> +			list_del(&entry->list);
> +			kmem_cache_free(batadv_tt_change_cache, entry);
> +		}
>  		return;
> +	}

[Severity: Low]
Does this statement in the commit message hold when the node is idle?

  "The changes can no longer be kept for the next round when the TVLV
  buffer allocation fails. But they would be sent with a skipped TTVN
  anyway, so the other nodes have to request the full table in this case
  either way."

When batadv_tt_prepare_tvlv_local_data() fails here, the caller
batadv_tt_local_commit_changes_nolock() has already bumped tt.vn to N,
updated the CRCs and reset ogm_append_cnt to BATADV_TT_OGM_APPEND_MAX. No
new container is registered, so OGMs keep carrying the old container (ttvn
N-1 with the old CRCs). That container is self-consistent, so peers take no
action.

local_changes is now 0, so if no further local event arrives the next
rounds take the idle branch:

    if (READ_ONCE(bat_priv->tt.local_changes) == 0) {
        if (!batadv_atomic_dec_not_zero(&bat_priv->tt.ogm_append_cnt))
            batadv_tt_tvlv_container_update(bat_priv);
        return;
    }

ttvn N is only published once ogm_append_cnt has counted down to 0, a few
OGM intervals after the failure.

Before this patch, the !tvlv_len return left the list and counter in place.
The next interval then bumped the TTVN to N+1, and peers saw the skipped
TTVN immediately.

With this change, can peers learn about the committed local changes several
OGM intervals later, with no TTVN skipped at all? Re-queueing the changes
isn't simple because __batadv_tt_local_event() expects at most one queued
change per (addr, vid). Would it be enough to force a TTVN bump or commit in
the next round instead?

[Severity: Medium]
Can this error path leave a stale bat_priv->tt.last_changeset that is later
served under the new TTVN?

Suppose round N-1 left last_changeset = D1, and new events D2 are committed
with tt.vn bumped to N. If batadv_tt_prepare_tvlv_local_data() fails here,
D2 is freed and local_changes is already 0. last_changeset still holds D1.

When ogm_append_cnt reaches 0, the idle branch calls
batadv_tt_tvlv_container_update() again with an empty snapshot.
tt_diff_len is 0, so it takes:

    if (!drop_changes && tt_diff_len == 0)
        goto container_register;

That skips the last_changeset refresh, and the container is registered with
ttvn N and the new CRCs.

A peer at orig_ttvn N-1 then sees ttvn - orig_ttvn == 1 with no changes in
batadv_tt_update_orig(). It sends a diff request, not a full table request.

In batadv_send_my_tt_response():

    if (tt_data->flags & BATADV_TT_FULL_TABLE || my_ttvn != req_ttvn ||
        !bat_priv->tt.last_changeset)
        full_table = true;
    else
        full_table = false;

my_ttvn == req_ttvn and last_changeset is non-NULL, so the reply is the old
D1 diff labelled ttvn N. The peer applies it through
batadv_tt_update_changes() and only fetches the full table after a later
CRC mismatch.

The new comment says "the other nodes will have to request the full table
anyway", but here the first request is a diff request. Should this path
free last_changeset and set it to NULL under last_changeset_lock, or force
the next round to bump the TTVN?

>
>  	tt_data->flags = BATADV_TT_OGM_DIFF;
>
>  	if (!drop_changes && tt_diff_len == 0)
>  		goto container_register;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026085309.1074911-2-sw%40simonwunderlich.de
