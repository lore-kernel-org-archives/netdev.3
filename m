Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794129495;
	b=bufTcLQtOZjvadDqND4IEbNQ/R8GzPsKfiezY8tJRWrLQZCEY7A5uAkv3BcIE+Oke4je
	 cnGQh2bxcoI18t+lgAX/jp10bbE5knMhT06NE47Z0B6DH2tNbIp4GwG88SHpoShxQ6r4e
	 XAGu3yQjIbaFwTzgngmHqn+UantzW4rBVKQOjzgKUpOoY4HrfwIL6t/kVvnQb6WZAXhvy
	 2msSBDl0hro8CZK/BCjj/ymNyO+gGm+rTgoGvXQxGrzGlGQWSGLuVoyMZu6Py/maLBEkw
	 zFyiasl5px3+eZ5BCBafqfxHYBox4OfNeOsi7pEnXTLnL8aI2AxJdWvt2bBE7hdeeWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794129495;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zpxSOdlAtwld7vl6zVwDIIolzT332EE7xiqkORE+dzo=;
	b=ermRkGOVRtlwziNr7WuemiYmHf7yId7covFVhj17TAjOTmgns/1W9KBiLsXyLAHWA5Yp
	 Q59llKLhlwDLhx7f34riNjY9dAndLPfkGIDHdmFXkSb4gMOKzWVsuq00XW1bXSC+TJ3zQ
	 05uODyngKEBWcpAcjfrxDwsMHkob8fftUGpfYpSjMKdbduGwDHijwyYt0a3oSY+dIYF8R
	 7KCKtZ7xIKpMNsBaw7qyq7XjOMOW9CSrZtN5eOuspxkXPWL2pJMGux09I5vLiHwu8HU4n
	 L/r8JSPj+IWkha1GWPaV2Gcv68sYEOWLP7SH14SNfuc4p8uzCx0Z82sT3qX7wgvzKqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FsW/C4KN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E335606A31C;
	Sun,  8 Nov 2026 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsW/C4KN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585EB1F0089F;
	Sun,  8 Nov 2026 09:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794129495;
	bh=zpxSOdlAtwld7vl6zVwDIIolzT332EE7xiqkORE+dzo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FsW/C4KNsjzpA/qZb0Zw+Zn4369ldJXuqZ3XvEifnnoESuC8B1uXKiyo42rgM3+rl
	 5RwpTiYaKgVwWsKloCGIn7EB7r+Xgnm4JSc09iRNbsDVYdUfW1dUDYSORIJUgEB7mD
	 Bd8Zp1KKnX+1hqrtc/lHice4hVMqcbeucPzFZufgdsiqH+WHgzMedHcvZJN2LVG2bu
	 HvuR+8DBABxvsZm886V8y9G+ZJhTsLcyC7c9jJLpKKdumRvrrfGAqRhEFiwXJXIS0V
	 R/+O9+J2JrOYLBatRvxUCgrhRb2gvfK0lQ5mMVnDm0ghUsO/iNaMcnBOamY13jHOWs
	 7nUvHNsYF+gUA==
Subject: Re: [PATCH net] tipc: don't count unjoined publications as receivers
From: netdev-bot+sashiko@kernel.org
To: shawnq1@163.com
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 09:18:13 +0000
Message-ID: <179412949370.994134.17074313226442265798@kernel.org>
In-Reply-To: <20261107082422.900347-1-shawnq1@163.com>
References: <20261107082422.900347-1-shawnq1@163.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch takes MBR_PUBLISHED out of tipc_group_is_receiver(),
  which removes the gate that held a new joiner's sends until each…
- [High] Changing tipc_group_is_receiver() also changes what
  tipc_group_find_dest() and tipc_group_cong() return, which affects…
- [Low] The new branch in tipc_group_open() opens the group whenever the
  member is MBR_JOINED, is not on small_win, and the group is closed.
- [Low] The changelog reads like a cover letter or bug report and is not
  a commit log.
- [Low] tipc_group_create_member() still adds every member's node to
  grp->dests regardless of state (tipc_nlist_add(&grp->dests, m->node),…

--

tipc: don't count unjoined publications as receivers

This commit removes MBR_PUBLISHED members from tipc_group_is_receiver(),
so publications from sockets that never join the group no longer hold
group senders on the small window list. It also lets tipc_group_open()
reopen the group when a member reaches MBR_JOINED, even if that member
was not on small_win.

> Hello,
>
> A local process with no capabilities can block sends from a TIPC

[ ... ]

> HEAD: commit c03c1a14507dfaf8b856c2608f9ac216021fc222 ("Linux 7.3")
> git tree:       upstream Linux, local branch master
> source version: Linux 7.3.0 (v7.3)
> compiler:       gcc 11.4.0, GNU ld 2.38
> QEMU:           6.2.0
>
> Raw reproduction files:

[ ... ]

[Severity: Low]
This isn't a bug, but the changelog reads like a cover letter or a bug
report. The greeting, gist URLs, toolchain and QEMU versions, local
branch name, HEAD reference and build/run instructions would all end up
in git history. Could they move below the --- line?

The changelog also leaves out several behaviour changes in the patch:
senders are no longer gated on the JOIN handshake, unicast to a member
still in the handshake now returns -EHOSTUNREACH, and anycast behaves
differently.

> diff --git a/net/tipc/group.c b/net/tipc/group.c
> index 0c6a762000b02..c55daebc6cb38 100644
> --- a/net/tipc/group.c
> +++ b/net/tipc/group.c
> @@ -105,9 +105,12 @@ static void tipc_group_proto_xmit(struct tipc_group *grp, struct tipc_member *m,
>  static void tipc_group_open(struct tipc_member *m, bool *wakeup)
>  {
>  	*wakeup = false;
> -	if (list_empty(&m->small_win))
> -		return;
> -	list_del_init(&m->small_win);
> +	if (list_empty(&m->small_win)) {
> +		if (m->state != MBR_JOINED || *m->group->open)
> +			return;
> +	} else {
> +		list_del_init(&m->small_win);
> +	}

[Severity: Low]
The new branch is aimed at the JOIN handshake transitions. However,
tipc_group_open() is also called from the GRP_ADV_MSG, GRP_RECLAIM_MSG
and GRP_LEAVE_MSG cases in tipc_group_proto_rcv(), for example:

	case GRP_ADV_MSG:
		if (!m)
			return;
		m->window += msg_adv_win(hdr);
		tipc_group_open(m, usr_wakeup);
		return;

The group may be closed for an unrelated reason, such as pending
replicast acks (grp->bc_ackers != 0) or congestion on another member.
In that case, won't an ADV or RECLAIM from any JOINED member that is not
on small_win now set *grp->open = true and *usr_wakeup = true?

tipc_poll() reports EPOLLOUT based only on tsk->group_is_open. That
would give a spurious POLLOUT followed by -EAGAIN on a nonblocking
send, and spurious wakeups of blocked senders. The existing small_win
branch already reopens without checking those conditions, but this
change extends that to members that were never congested.

The two departure paths also behave differently now. GRP_LEAVE_MSG
calls tipc_group_open() while the member is still MBR_JOINED:

		tipc_group_open(m, usr_wakeup);
		tipc_group_decr_active(grp, m);
		m->state = MBR_LEAVING;

so the new branch can fire there. The TIPC_WITHDRAWN path in
tipc_group_member_evt() sets MBR_LEAVING before calling
tipc_group_open(), so it cannot.

Should the new open be limited to the actual transition into
MBR_JOINED?

>  	*m->group->open = true;
>  	*wakeup = true;
>  }
> @@ -145,7 +148,8 @@ u16 tipc_group_bc_snd_nxt(struct tipc_group *grp)
>  
>  static bool tipc_group_is_receiver(struct tipc_member *m)
>  {
> -	return m && m->state != MBR_JOINING && m->state != MBR_LEAVING;
> +	return m && m->state != MBR_JOINING && m->state != MBR_PUBLISHED &&
> +	       m->state != MBR_LEAVING;

[Severity: High]
Does excluding MBR_PUBLISHED here also remove the gate that stopped a
new joiner from sending before each existing member had processed its
JOIN?

Before this patch, tipc_group_join() did:

	rbtree_postorder_for_each_entry_safe(m, tmp, tree, tree_node) {
		tipc_group_proto_xmit(grp, m, GRP_JOIN_MSG, &xmitq);
		tipc_group_update_member(m, 0);
	}

This put every PUBLISHED member (window 0) on grp->small_win, so
tipc_group_bc_cong() blocked the sender until the peer's JOIN arrived.

With this change, tipc_group_update_member() returns early for those
members and small_win stays empty. tipc_group_bc_cong() now returns
false right after setsockopt(TIPC_GROUP_JOIN).

Take socket A joining while member B already exists. A's GRP_JOIN_MSG
reaches B synchronously on the local node. tipc_group_proto_rcv() then
creates A as MBR_JOINING with bc_rcv_nxt set to the syncpoint. A's
TIPC_PUBLISHED topology event reaches B later, through the topsrv
workqueue:

tipc_topsrv_queue_evt()->queue_work()->tipc_topsrv_kern_evt()

If A broadcasts before that worker runs, B sees this in
tipc_group_filter_msg():

	m = tipc_group_find_member(grp, node, port);
	if (!tipc_group_is_sender(m))
		goto drop;

B drops the message without advancing bc_rcv_nxt. When the PUBLISHED
event arrives, tipc_group_member_evt() moves A to MBR_JOINED but leaves
bc_rcv_nxt unchanged.

Every later message from A then hits this check. That includes
unicasts, because tipc_send_group_msg() stamps bc_snd_nxt via
msg_set_grp_bc_seqno():

		if (more(msg_grp_bc_seqno(hdr), m->bc_rcv_nxt))
			break;

The message stays in m->deferredq. B never reads these messages, so it
never sends GRP_ADV_MSG, and A's window for B eventually runs out.

Can this leave A's broadcasts and unicasts to B blocked permanently?
That is the symptom this patch sets out to fix, but here it is
reachable by an ordinary join followed by an immediate send.

There is also a side effect: tipc_group_update_bc_members() now skips
members that A still sees as PUBLISHED. No window is charged and no ack
is expected for them, even though the broadcast reaches their node
through grp->dests.

[Severity: High]
tipc_group_find_dest() and tipc_group_cong() both use
tipc_group_is_receiver(). Doesn't this change unicast and anycast
behaviour as well?

For an MBR_PUBLISHED member, tipc_group_cong() now takes this path:

	m = tipc_group_find_dest(grp, dnode, dport);
	if (!tipc_group_is_receiver(m)) {
		*mbr = NULL;
		return false;
	}

Previously it returned true with *mbr set.

For unicast, tipc_send_group_unicast() to a member still in the JOIN
handshake now fails immediately instead of waiting for the JOIN:

	if (unlikely(!mb))
		return -EHOSTUNREACH;

For anycast, tipc_send_group_anycast() was written for the old
behaviour. The inner loop breaks on the first cong == false, and then:

		/* Start over if destination was not in member list */
		if (unlikely(!mbr))
			continue;

This uses up one of only three outer lookups (while (++lookups < 4)),
and after the third one the send fails:

	if (unlikely(lookups >= 4))
		return -EHOSTUNREACH;

tipc_nametbl_lookup_group() hands out candidates round-robin from
sr->all_publ. It filters only by scope and the excluded port, not by
group membership.

Could an unprivileged process bind three or more ordinary (non-group)
sockets to the group's type/instance and make group anycast fail with
-EHOSTUNREACH, even when a joined, uncongested member is reachable?

Before the patch, these phantom entries reported cong == true with mbr
set, and the inner loop moved past them to a real member. So the
problem described in the changelog seems to remain reachable through
anycast, with the symptom changing from blocking to -EHOSTUNREACH.
tipc_send_group_mcast() also still counts phantom publications in
dstcnt.

Would non-member publications need to be filtered out, rather than just
classified differently?

[Severity: Low]
tipc_group_create_member() still adds every member's node to grp->dests,
whatever its state:

	tipc_nlist_add(&grp->dests, m->node);

MBR_PUBLISHED members, though, are no longer receivers. Suppose the
only peers matching the group are unjoined publications.
tipc_send_group_bcast() then passes this check:

	if (!dsts->local && !dsts->remote)
		return -EHOSTUNREACH;

tipc_group_bc_cong() returns false because small_win is empty. The
broadcast goes out with zero accounted receivers, and the non-group
socket drops it in tipc_sk_filter_rcv().

Meanwhile tsk->group_is_open starts out false and only becomes true
through a JOIN or a GRP_ACK, so tipc_poll() never reports EPOLLOUT:

		if (tsk->group_is_open && !tsk->cong_link_cnt)
			revents |= EPOLLOUT;

Is it intended that sendmsg() succeeds while poll() says the socket is
not writable? Also, should a send to a group with no joined members
return success rather than -EHOSTUNREACH?

>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107082422.900347-1-shawnq1%40163.com
