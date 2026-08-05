Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012D2E3FE
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 00:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891211; cv=none; b=VxjqVsnW0NBh39SdnjuFmNHnbR8R/qGCPs8SSSHnXhilccDD0oT9hJA7OK7SFc0DwyBsvO6eiMJN7Gbg8z+jzKAbxATdg+SCpgF1gf4jBs3QKslJmIh1OXnL0sUQ+LvljQNM6YgNmAzTC4XZDBSCFtZMJey/Jj0xiIjYsqbu8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891211; c=relaxed/simple;
	bh=GD1I7pttjTyyEEcRZLrp/CGQvPUN6czovhL9ydwfeno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewOmAof2IQQ+K7O59CziV45zDKM1yCPxtdaWsKiMLhuXp9wlZ8JMPteELGNDiHI7gUl2Kx7HQACPziZVHzhi6UxaORG3Nl29M0FUYeDJi0WVgGTA6xZsavt71zSPAMwfQYpH5JVNoNGYm4oSGfvl26eSdqDDoLoqXfrr94Yt/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxE3L7M/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxE3L7M/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E421F000E9;
	Wed,  5 Aug 2026 00:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785891210;
	bh=FSVjQ1JDNUtU3KOD2qzNPg3xjMCpa1cImG2kAEjGvs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PxE3L7M/pEtlxBLpEwyFmVtB1X1I6tUeU/0H6tLt5OXOPHtYENarTBrhMDW33d36/
	 mvyteRBTRuRbrq0BHL5X6CrPpv5Ztmg4JBMPokSLJTxqksoDSJjx+b5J+Hnm1HDYTF
	 VDp22r9CdrU/yg1okmvQtwdRQuLVZcGEpQzuUGxMzX5cZlJ7TIFj5Lr7FmwKAV/vxX
	 BhtfWGx4Z1U7BHnOTN/lKbeTGRHhMNLRvz9VyprlLccV+s+Qa5a4zdBX6YBzJbSH3r
	 wNwk2otqi9fsFJQc+gr4M08Af1uSd67+1AWC2PDsRwdHhP7fMVMidSejeektI8jsRG
	 9RxtYyzs6B5Wg==
From: Jakub Kicinski <kuba@kernel.org>
To: zihanx@nebusec.ai
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	tim.bird@sony.com,
	luoxuanqiang@kylinos.cn,
	vega@nebusec.ai
Subject: Re: [PATCH net v2 1/1] llc: fix listener child socket leaks
Date: Tue,  4 Aug 2026 17:53:13 -0700
Message-ID: <20260805005313.4055148-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <0816efdb7d7ddf5ae74bd2dc90f62f69e9b39e02.1785386749.git.zihanx@nebusec.ai>
References: <0816efdb7d7ddf5ae74bd2dc90f62f69e9b39e02.1785386749.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
    llc: fix listener child socket leaks

The patch restricts passive-open child creation in llc_conn_handler() to
SABME commands, answers other listener traffic with stateless DM responses,
defers child creation for listener-owned SABME frames to llc_backlog_rcv(),
and adds a rollback helper that unhashes and frees an unpublished child if
llc_conn_rcv() returns an error.

A few questions below about the new paths.

Quoting the commit message:

>     Second, even for a valid SABME request, the child is created before the
>     connection state machine reaches LLC_CONN_PRIM. [...]
>     This closes both leak paths while preserving the existing passive-open
>     flow for successful SABME connections.

[Severity: High]
This isn't a leak introduced by this patch, but does the claim that "this
closes both leak paths" hold while a third listener-child leak remains?

A child that was successfully published to the listener's accept queue but
never accepted is never reaped when the listener is closed.  On the success
path the child is referenced only by the queued skb:

net/llc/llc_conn.c:llc_conn_state_process() {
	case LLC_CONN_PRIM:
		skb_get(skb);
		skb_queue_tail(&sk->sk_receive_queue, skb);
		sk->sk_state_change(sk);
}

At that point the child holds two socket references (sk_alloc plus
sk_nulls_add_node_rcu), a netdev reference from dev_hold() in
llc_create_incoming_sock(), and a SAP reference from llc_sap_hold() in
llc_sap_add_socket().

llc_ui_release() never walks the accept queue, and the listener teardown
ends in llc_sk_free(), which only purges the queue:

net/llc/llc_conn.c:llc_sk_free() {
	skb_queue_purge(&sk->sk_receive_queue);
}

kfree_skb() there calls sock_rfree(), which only uncharges rmem - no
sock_put() on the child, no llc_sap_remove_socket(), no dev_put().  Nothing
else in net/llc reaps such a child: there is no netdevice notifier in
net/llc, and the LLC_DISC_PRIM arm of llc_conn_state_process() requires
sk_state == TCP_ESTABLISHED while an unaccepted child is still TCP_CLOSE.

So bind() + listen(), a peer SABME, then close() without accept() appears to
leak the struct sock, the netdev reference (which then makes
unregister_netdevice() wait forever) and the SAP reference.  Would it be
worth softening the commit message, or handling the accept-queue children in
llc_ui_release()?

> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index 260460d50f54c..421f0d9935188 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c
> @@ -771,10 +771,55 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
>  	return newsk;
>  }
>  
> +static struct sock *llc_create_incoming_sock_from_skb(struct sock *sk,
> +						      struct sk_buff *skb)
> +{
> +	struct llc_addr saddr, daddr;
> +
> +	llc_pdu_decode_sa(skb, saddr.mac);
> +	llc_pdu_decode_ssap(skb, &saddr.lsap);
> +	llc_pdu_decode_da(skb, daddr.mac);
> +	llc_pdu_decode_dsap(skb, &daddr.lsap);
> +
> +	return llc_create_incoming_sock(sk, skb->dev, &saddr, &daddr);
> +}

[Severity: Medium]
Is skb->dev still guaranteed to be alive here?  The only caller of
llc_create_incoming_sock_from_skb() is llc_backlog_rcv(), which runs from
release_sock() in process context, arbitrarily long after the RX softirq
that queued the skb.  Backlogged skbs hold no reference on skb->dev, and
llc_create_incoming_sock() both takes and dereferences it:

net/llc/llc_conn.c:llc_create_incoming_sock() {
	newllc->dev = dev;
	dev_hold(dev);
	llc_sap_add_socket(llc->sap, newsk);
}

llc_sap_add_socket() then reads llc->dev->ifindex.  The lock owner can hold
the socket lock across a sleeping operation that does not drain the backlog
(for instance a copy_to_user() fault in llc_ui_recvmsg()), and the receiving
device can be unregistered and freed in that window
(unregister_netdevice -> synchronize_net -> netdev_wait_allrefs ->
free_netdev).

The listener's own bind-time reference covers only the device matching its
own MAC, while the frame can arrive on a different netdev (macvlan, bond,
duplicate MAC, or a null-address listener matched by llc_lookup_listener()).
Can dev_hold() here increment a refcount in freed memory, and can the child
then keep a dangling llc->dev for its whole lifetime (used by
dev_queue_xmit() from llc_conn_ac_*, and by llc_cmsg_rcv())?

llc_conn_handler() is safe for exactly the opposite reason: it runs in the RX
softirq that owns skb->dev.

> +
> +static void llc_release_incoming_sock(struct sock *sk)
> +{
> +	struct llc_sock *llc = llc_sk(sk);
> +
> +	llc_sap_remove_socket(llc->sap, sk);
> +	dev_put(llc->dev);
> +	sock_orphan(sk);
> +	llc_sk_free(sk);
> +}

[Severity: High]
This tears down the child while holding only the parent listener's
bh_lock_sock(), never the child's own lock.  The child was already published
into the RCU-visible SAP hash before the state machine ran:

net/llc/llc_conn.c:llc_sap_add_socket() {
	sock_set_flag(sk, SOCK_RCU_FREE);
	sap->sk_count++;
	sk_nulls_add_node_rcu(sk, laddr_hb);
}

Can another CPU processing a second frame for the same (laddr, daddr) tuple -
a retransmitted SABME, or any I/S frame, since llc_estab_match() ignores the
device - already have found the child via __llc_lookup_established(), taken a
refcount and acquired bh_lock_sock(child) uncontended, and be inside
llc_conn_rcv() on it while this runs?

llc_sk_free() sets llc->state = LLC_CONN_OUT_OF_SVC (0), and the state
machine only rejects the upper bound:

net/llc/llc_conn.c:llc_conn_service() {
	if (llc->state > NBR_CONN_STATES)
		goto out;
}

so the concurrent path reaches llc_qualify_conn_ev(), which computes

	&llc_conn_state_table[llc->state - 1]

and llc_find_offset(llc->state - 1, ev->type) with index -1, then
dereferences and indirectly calls the resulting transition pointers via
(*next_trans)->ev(sk, skb).  The missing state == 0 guard in
llc_conn_service() is pre-existing, but is this the first path that destroys
a hash-published child from RX softirq without the child's lock?

Related on the same helper: dev_put(llc->dev) can drop the netdev reference
while the other CPU is still transmitting with llc->dev, and the
skb_queue_purge() calls inside llc_sk_free() race with concurrent queueing
onto the same lists.  Should the child's bh_lock_sock() be taken (or the
teardown deferred) here?

[Severity: Medium]
Is calling llc_sk_free() from softirq with bh_lock_sock(listener) held safe
with respect to the LLC connection timers?  llc_sk_free() starts with the
synchronous teardown:

net/llc/llc_conn.c:llc_sk_stop_all_timers() {
	if (sync) {
		timer_delete_sync(&llc->pf_cycle_timer.timer);
		timer_delete_sync(&llc->ack_timer.timer);
		...
	}
}

__timer_delete_sync() does lock_map_acquire(&timer->lockdep_map), so this
records sk_lock.slock (class slock-AF_LLC) -> llc timer lockdep class.  The
timer callbacks establish the inverse order:

net/llc/llc_c_ac.c:llc_conn_tmr_common_cb() {
	struct sk_buff *skb = alloc_skb(0, GFP_ATOMIC);

	bh_lock_sock(sk);
}

on an AF_LLC socket, i.e. the same slock class, from inside the timer
lockdep map.  On CONFIG_PROVE_LOCKING kernels, does this produce a possible
circular locking dependency report from a path reachable by a received SABME
frame plus a GFP_ATOMIC failure in llc_conn_ac_send_ua_rsp_f_set_p()?

Before this patch llc_sk_free() was only reached from process context
(llc_ui_release() after release_sock()), and the state machine deliberately
uses the non-sync llc_conn_ac_stop_all_timers() in softirq.

Two details for the record: lockdep_assert_preemption_enabled() in
__timer_delete_sync() is guarded by IS_ENABLED(CONFIG_PREEMPT_RT), and no
timer is armed for a fresh ADM/SABME child (llc_adm_actions_2 arms none), so
only the lockdep ordering seems at stake.

> +
> +static void llc_conn_send_dm_rsp(struct llc_sap *sap, struct sk_buff *skb,
> +				 struct llc_addr *saddr, u8 f_bit)
> +{
> +	struct sk_buff *nskb;
> +	int rc;
> +
> +	nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U, 0);
> +	if (!nskb)
> +		return;
> +
> +	llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
> +			    saddr->lsap, LLC_PDU_RSP);
> +	llc_pdu_init_as_dm_rsp(nskb, f_bit);

[Severity: Low]
This isn't a bug, but this helper open-codes the ADM-state action
llc_conn_ac_send_dm_rsp_f_set_p() / llc_conn_ac_send_dm_rsp_f_set_1(), i.e.
the actions of llc_adm_state_trans_3 / llc_adm_state_trans_4 in
net/llc/llc_c_st.c:

net/llc/llc_c_st.c {
static const llc_conn_action_t llc_adm_actions_3[] = {
	[0] = llc_conn_ac_send_dm_rsp_f_set_p,
	[1] = llc_conn_disc,
	[2] = NULL,
};
}

The encoding matches field for field today, but the skb allocation, header
init, MAC header init and xmit are now duplicated in the RX path with
nothing linking the two sites.  Could the state machine action be reused, or
at least a comment added referencing llc_adm_state_trans_3/4?

> +	rc = llc_mac_hdr_init(nskb, skb->dev->dev_addr, saddr->mac);
> +	if (unlikely(rc))
> +		kfree_skb(nskb);
> +	else
> +		dev_queue_xmit(nskb);
> +}
> +
>  void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
>  {
>  	struct llc_addr saddr, daddr;
> +	struct sock *newsk = NULL;
>  	struct sock *sk;
> +	int rc;

[ ... ]

> @@ -795,11 +840,24 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
>  	 * in the newly created struct sock private area. -acme
>  	 */
>  	if (unlikely(sk->sk_state == TCP_LISTEN)) {
> -		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
> -							      &saddr, &daddr);
> -		if (!newsk)
> +		if (llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb)) {
> +			if (!llc_conn_ev_rx_disc_cmd_pbit_set_x(sk, skb)) {
> +				u8 f_bit;
> +
> +				llc_pdu_decode_pf_bit(skb, &f_bit);
> +				llc_conn_send_dm_rsp(sap, skb, &saddr, f_bit);
> +			} else if (!llc_conn_ev_rx_xxx_cmd_pbit_set_1(sk,
> +								       skb)) {
> +				llc_conn_send_dm_rsp(sap, skb, &saddr, 1);
> +			}
>  			goto drop_unlock;
> -		skb_set_owner_r(skb, newsk);
> +		} else if (!sock_owned_by_user(sk)) {
> +			newsk = llc_create_incoming_sock(sk, skb->dev, &saddr,
> +							 &daddr);
> +			if (!newsk)
> +				goto drop_unlock;
> +			skb_set_owner_r(skb, newsk);
> +		}

[Severity: High]
When the frame is a SABME command and sock_owned_by_user(sk) is true, no
owner is installed on the skb at all: this branch is skipped by the
!sock_owned_by_user(sk) guard, and the non-listen else branch (which does
skb_orphan(); sock_hold(); skb->sk = sk;) is not taken either.  The skb is
then queued with skb->sk == NULL:

	llc_set_backlog_type(skb, LLC_PACKET);
	if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))

RX skbs are orphaned, which is exactly why the non-listen branch sets
skb->sk explicitly.

At drain time the new compensating assignment in llc_backlog_rcv() only runs
when both llc->state > 1 and sk->sk_state == TCP_LISTEN hold.  If the socket
has left TCP_LISTEN while llc->state > 1, execution falls through to
rc = llc_conn_rcv(sk, skb), and the state machine dispatches on skb->sk, not
on the sk argument:

net/llc/llc_conn.c:llc_conn_state_process() {
	struct llc_sock *llc = llc_sk(skb->sk);
	...
	rc = llc_conn_service(skb->sk, skb);
}

net/llc/llc_conn.c:llc_conn_service() {
	struct llc_sock *llc = llc_sk(sk);
	int rc = 1;

	if (llc->state > NBR_CONN_STATES)
}

llc_sk() is a plain cast, so is this a NULL dereference on llc->state?

Can this sequence occur?  bind() + listen() leaves sk_state == TCP_LISTEN and
llc->state == LLC_CONN_STATE_ADM.  llc_ui_connect() has no TCP_LISTEN
rejection, and after listen() sock->state is still SS_UNCONNECTED, so only
the SS_CONNECTING/-EALREADY check applies:

net/llc/af_llc.c:llc_ui_connect() {
	sock->state = SS_CONNECTING;
	sk->sk_state   = TCP_SYN_SENT;
	...
	rc = llc_establish_connection(sk, llc->dev->dev_addr, addr->sllc_mac,
				      addr->sllc_sap);
}

If an incoming SABME is enqueued unowned between lock_sock() and
sk->sk_state = TCP_SYN_SENT, then llc_establish_connection() advances
llc->state to LLC_CONN_STATE_SETUP (2), and the following release_sock()
(from llc_ui_wait_for_conn() or the out: label, including the -EINPROGRESS
path) drains the backlog with llc->state == 2 and sk_state == TCP_SYN_SENT.

>  	} else {
>  		/*
>  		 * Can't be skb_set_owner_r, this will be done at the
> @@ -813,9 +871,13 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
>  		skb->sk = sk;
>  		skb->destructor = sock_efree;
>  	}
> -	if (!sock_owned_by_user(sk))
> -		llc_conn_rcv(sk, skb);
> -	else {
> +	if (!sock_owned_by_user(sk)) {
> +		rc = llc_conn_rcv(sk, skb);
> +		if (unlikely(rc) && newsk) {
> +			llc_release_incoming_sock(newsk);
> +			goto out;
> +		}
> +	} else {

[Severity: Medium]
Both new rollback sites treat rc != 0 as equivalent to "the child was never
published to accept()".  Is that equivalence enforced anywhere?

rc == 0 does not imply publication.  Publication only happens in the
ind_prim == LLC_CONN_PRIM arm of llc_conn_state_process(), while
llc_conn_service() can return 0 with no ind_prim set at all - for example a
fresh child in LLC_CONN_STATE_ADM receiving a DISC command matches
llc_adm_state_trans_3 (send DM rsp, llc_conn_disc, next_state ADM), which
sets no indication.  That matters mainly for the llc_backlog_rcv() branch
below, which creates a child for any LLC_PACKET with no SABME qualification,
so such a frame would leave the child hashed in the SAP with its netdev and
SAP references and unreachable by accept().  In llc_conn_handler() the child
is only created for SABME, and ADM/SABME matches llc_adm_state_trans_2 whose
action list ends in llc_conn_ac_conn_ind(), so rc == 0 does imply publication
here.

Conversely, rc != 0 does not by construction imply "not published":

net/llc/llc_conn.c:llc_conn_state_process() {
	case LLC_DATA_PRIM:
		if (!llc_data_accept_state(llc->state))
			sk->sk_write_space(sk);
		else
			rc = llc->failed_data_req = 1;
}

runs after the ind_prim switch that queues the child.  No current ADM/SABME
transition sets both prims, but should the rollback key off an explicit
"published" flag rather than off rc, so that a future transition change does
not turn this into a use-after-free in llc_ui_accept()?

>  		dprintk("%s: adding to backlog...\n", __func__);
>  		llc_set_backlog_type(skb, LLC_PACKET);
>  		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
> @@ -852,12 +914,22 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
>  {
>  	int rc = 0;
>  	struct llc_sock *llc = llc_sk(sk);
> +	struct sock *newsk = NULL;
>  
>  	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
> -		if (likely(llc->state > 1)) /* not closed */
> +		if (likely(llc->state > 1)) { /* not closed */
> +			if (unlikely(sk->sk_state == TCP_LISTEN)) {
> +				newsk = llc_create_incoming_sock_from_skb(sk, skb);
> +				if (!newsk)
> +					goto out_kfree_skb;
> +				skb_set_owner_r(skb, newsk);
> +			}

[Severity: Medium]
Is this new block reachable for an ordinary listener?  It is nested inside
the pre-existing llc->state > 1 ("not closed") test, but a listening LLC
socket has llc->state == LLC_CONN_STATE_ADM:

include/net/llc_c_st.h {
#define LLC_CONN_OUT_OF_SVC		 0	/* prior to allocation */
#define LLC_CONN_STATE_ADM		 1	/* disc, initial state */
}

llc_sk_init() sets llc->state = LLC_CONN_STATE_ADM, and llc_ui_listen() never
touches llc->state:

net/llc/af_llc.c:llc_ui_listen() {
	sk->sk_max_ack_backlog = backlog;
	if (sk->sk_state != TCP_LISTEN) {
		sk->sk_ack_backlog = 0;
		sk->sk_state	   = TCP_LISTEN;
	}
}

The only writers of llc->state are llc_sk_init(), llc_sk_free() and
llc_conn_service() (llc->state = trans->next_state), and the latter is driven
off skb->sk, i.e. the child, for passive opens.  So does
llc_create_incoming_sock_from_skb() - which has exactly one call site - ever
run for a normal listener, and does a listener-owned SABME still end at
out_kfree_skb?

If so, the commit message statement that the change preserves "the existing
passive-open flow" through deferred child creation does not seem to hold:
only the leak is fixed, and only because no child is created any more.

Separately, when the branch is entered it creates a child for any LLC_PACKET
with no SABME qualification, which differs from the rule stated in the commit
message ("Only create an incoming child for SABME commands") and from the
check in llc_conn_handler().  Should the two sites share one admission test?

[Severity: Medium]
Should this path also check whether the listener is being torn down?  The
backlog is drained from llc_ui_release() too, after the listener has been
unhashed, and sk_state is still TCP_LISTEN there:

net/llc/af_llc.c:llc_ui_release() {
	llc_sap_hold(sap);
	llc_sap_remove_socket(llc->sap, sk);
	release_sock(sk);
}

release_sock() -> __release_sock() -> llc_backlog_rcv() would then publish a
brand new child into sap->sk_laddr_hash with llc_sap_hold() and dev_hold(),
while the listener is freed immediately afterwards.  Nothing can accept or
release that child, so does this leak the struct sock, the netdev reference
and the SAP reference for a SABME that arrives just before close()?

> +			rc = llc_conn_rcv(sk, skb);
> -		else
> +			if (unlikely(rc) && newsk)
> +				llc_release_incoming_sock(newsk);
> +		} else {
>  			goto out_kfree_skb;
> +		}

[ ... ]
-- 
pw-bot: cr
