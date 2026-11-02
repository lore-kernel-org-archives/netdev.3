Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634312;
	b=lcAt7WVUXGdy5ISu4AnHc0Lhf6MPR60qv021ZzHuiNwmjAtMKaOljX0YwnINt1Clp31M
	 tQGwWmeMWvXUPiwFqX0GvGV2kg043UKBx8VfRtfjzif7kp1JZMxfwecApEQq/qUBygg/h
	 w7iaSDqYlUE+56P9uBFkDi+nUvswB/78Bb2PMpg/wiCT/oVenponZ2cNANZ4vt7TWr56y
	 jJU7BGPUu5lf+GV00q3a8WnJowSa6i5txLPohJLTORSpt8XVMNtz6B6gJgw5v/AleydKR
	 xt6GnbtxVT1MWleUAYgHiLy5P2YFX6snCXvKM089jxaZT3DrMlP2yiiFOKYXqbQGwkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634312;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ct6oiKobvIrnIb3iAckehooF4cqkI6Sy4Yhkd14zx4o=;
	b=5JQBwX/AH4StonRwHxnoD6u+ZpQ3h9xBFNG2wJR4CV/cLtVb1VXc6Lo8AannLdBReIsr
	 M8y30hjJunRfdFLk/zQZ93CV1suxz7q3DN1l30sQD8saYYoxTJX5pNF1jhEgdcSVu88X0
	 uavK9ApjH++bX+B7U3+jbahw1tTG9fli6p35GPI6/PitMPgEH5uwSunkFEhirf81VzR/t
	 pYmnxd2dTb95YWHyRoPRPxGIZKQDRU1ZlRoXp1Q1QWHvcdHc4n8Q6u+AcTKorZIsTRzk6
	 ypEDsWovJV5cgHA3w+mRCrn0rkFystwMt0+Zi/RiMorGM1TFJXe+tlI2UqS05ro6kAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BnL/RawA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA16A606DE84;
	Mon,  2 Nov 2026 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BnL/RawA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8287D1F00A18;
	Mon,  2 Nov 2026 15:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793634311;
	bh=ct6oiKobvIrnIb3iAckehooF4cqkI6Sy4Yhkd14zx4o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BnL/RawA8PVd3wZPNOUOQ9pfnn6+Fw5OvGN2ySvL30gL26xhlxvMqcRKb1fR7Xu7D
	 jXr9gBAbPx5EGfNcASBPl2PDQ/2dLRRGq72OTBDKdUD5hiQtjT2pchHwXtaM225sxr
	 6B0ohf0eQpwT4y67Owg9rak6JWAkY5y3PSoDeHtWXvDd88nsM2y9Q3ehrNsRggqxcL
	 OijBSIzw9//OS5r1P+NIerTAZ6KC8iEXX2jt+zundY27cOYym15o5i94m52uzNkDOI
	 STOWFUEBQ6BMsjXua/ux0jd1wBPOzJZGPsqsW0X2W9aySKKpP/K/XLTJ7MQ551CZpe
	 RFTibNI0IAKSg==
Subject: Re: [PATCH net v2] tipc: defer local Nagle backlog receive processing
From: netdev-bot+sashiko@kernel.org
To: immersa.bartosz.chronowski@gmail.com
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 15:45:10 +0000
Message-ID: <179363431004.3131.12434594335457652597@kernel.org>
In-Reply-To: <657t6njsrgnpnfs2mc2lv776442fhv5zsosg3vxya5vqrtpag7@nq3uxt6ymw7s>
References: <657t6njsrgnpnfs2mc2lv776442fhv5zsosg3vxya5vqrtpag7@nq3uxt6ymw7s>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The deferral condition is broader than the subject and the in-
  code comment ('A local Nagle backlog may loop back...') say.
- [Low] Before this patch, an unowned socket handled CONN_MANAGER
  messages directly in tipc_sk_filter_rcv() -> tipc_sk_proto_rcv(), with…
- [Low] The new work handler tipc_sk_backlog_work()
  (net/tipc/socket.c:2435-2444) ends with sock_put(sk), which can drop…

--

tipc: defer local Nagle backlog receive processing

This patch targets a soft lockup that happens when a TIPC stream receives
a packet, pushes queued Nagle data to a local peer while sk_lock.slock is
held, and the looped-back delivery then spins in tipc_sk_rcv(). When an
unowned socket has queued output for a local peer, tipc_sk_enqueue() now
puts the incoming packet on sk_backlog. It then schedules a work item that
drains the backlog through lock_sock()/release_sock().

Link: https://lore.kernel.org/r/GV1P189MB1988F6301FA670CA9818F7FCC6DB2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM

> diff --git a/net/tipc/socket.c b/net/tipc/socket.c
> index 65cc0c4964b31..b03dd4a3d3ea2 100644
> --- a/net/tipc/socket.c
> +++ b/net/tipc/socket.c

[ ... ]

> @@ -2428,6 +2432,17 @@ static int tipc_sk_backlog_rcv(struct sock *sk, struct sk_buff *skb)
>  	return 0;
>  }
>  
> +static void tipc_sk_backlog_work(struct work_struct *work)
> +{
> +	struct tipc_sock *tsk = container_of(work, struct tipc_sock,
> +					     backlog_work);
> +	struct sock *sk = &tsk->sk;
> +
> +	lock_sock(sk);
> +	release_sock(sk);
> +	sock_put(sk);
> +}

[Severity: Low]
Can this sock_put() drop the last socket reference while the kworker is
still running TIPC module text?

If tipc_release() and tipc_sk_callback() have already dropped their
references, the final put goes:

tipc_sk_backlog_work()
  sock_put()
    sk_free()
      __sk_free()
        __sk_destruct()
          sk_prot_free()
            module_put(prot->owner)

Nothing in net/tipc flushes or cancels backlog_work. The only
cancel_work_sync() in TIPC is for tn->work. If tipc is removed with rmmod
at the same moment, could the module text be freed before
tipc_sk_backlog_work() returns?

A pending work item holds a socket reference, and so a module reference.
The window is only the tail after the final put. It needs root to unload
the module, and sk_free() is often emitted as a tail call. The existing
tipc_sk_timeout() also ends with a trailing sock_put() in the same way.

> +
>  /**
>   * tipc_sk_enqueue - extract all buffers with destination 'dport' from
>   *                   inputq and try adding them to socket or backlog queue
> @@ -2445,18 +2460,30 @@ static void tipc_sk_enqueue(struct sk_buff_head *inputq, struct sock *sk,

[ ... ]

> +		/*
> +		 * A local Nagle backlog may loop back into this socket while its
> +		 * spinlock is held.  Queue the triggering input for processing under
> +		 * socket ownership, which keeps a concurrent sender from overtaking
> +		 * the already queued output.
> +		 */
> +		owned = sock_owned_by_user(sk);
> +		local_backlog = !owned && !skb_queue_empty(&sk->sk_write_queue) &&
> +				in_own_node(sock_net(sk),
> +					    tsk_peer_node(tipc_sk(sk)));

[Severity: High]
Does the in_own_node() check cover every case where tipc_node_xmit()
delivers back into the receive path synchronously?

When the peer node is in another network namespace on the same host,
n->peer_net is set. In that case tipc_node_xmit() hands the list to
tipc_lxc_xmit(), which calls tipc_sk_rcv(peer_net, list) inline:

net/tipc/node.c:tipc_node_xmit() {
    ...
	if (node_up && peer_net && check_net(peer_net)) {
		/* xmit inner linux container */
		tipc_lxc_xmit(peer_net, list);
    ...
}

For that kind of peer, in_own_node() is false and local_backlog is false.
tipc_sk_filter_rcv() still runs with sk_lock.slock held. In
TIPC_ESTABLISHED this call chain looks possible:

tipc_sk_rcv(net1)                     /* takes socket A's slock */
  tipc_sk_enqueue()
    tipc_sk_filter_rcv()
      tipc_sk_filter_connect()
        tipc_sk_push_backlog()
          tipc_node_xmit()
            tipc_lxc_xmit()
              tipc_sk_rcv(net2)       /* peer socket B */
                B sends its Nagle ACK via tipc_node_distr_xmit(),
                or pushes its own non-empty write queue
                  tipc_lxc_xmit()
                    tipc_sk_rcv(net1) /* socket A again */

In the inner tipc_sk_rcv() the trylock fails, because an outer frame on
the same CPU holds A's slock:

	if (likely(spin_trylock_bh(&sk->sk_lock.slock))) {
		tipc_sk_enqueue(inputq, sk, dport, &xmitq);
		spin_unlock_bh(&sk->sk_lock.slock);
	}
	...
	continue;

Wouldn't this retry forever with BH disabled, inside the rcu_read_lock()
taken in tipc_node_xmit()?

Nagle is active for these peers, because tipc_node_get_mtu() returns
MAX_MSG_SIZE for peer_net connections. A two-CPU ABBA variant also looks
possible: each CPU holds one socket's slock and spins on the other's.

The setup is two namespaces linked by a bearer such as veth/UDP.
TIPC_NL_BEARER_ENABLE uses GENL_UNS_ADMIN_PERM, so an unprivileged user
with user namespaces could set this up.

Would the guard need to cover peer_net delivery as well, so that the
lockup described in the commit message cannot happen through the
cross-netns path?

[Severity: Low]
This condition doesn't check Nagle or the socket state. Is the deferral
meant to apply during connection setup too?

__tipc_sendmsg() clones the SYN onto sk_write_queue and sets the phdr
destnode to the target node:

	if (unlikely(syn && !tipc_msg_skb_clone(&pkts, &sk->sk_write_queue))) {

The clone stays on the queue until tipc_sk_finish_conn() purges it. That
only happens after the SYN-ACK has been processed.

During a blocking connect (sk_wait_event() drops ownership), or after a
non-blocking connect, the SYN-ACK reaches tipc_sk_enqueue() unowned. The
write queue is non-empty and destnode is local, so local_backlog is true.
The SYN-ACK then goes through sk_backlog and a work item on
system_percpu_wq.

This also covers SOCK_SEQPACKET, which never uses Nagle because
tsk_set_nagle() returns early for anything other than SOCK_STREAM. The
TIPC_CONNECTING case of tipc_sk_filter_connect() never calls
tipc_sk_push_backlog(), so it cannot cause the recursion.

Would checking for sk_state == TIPC_ESTABLISHED match the intent in the
comment and the commit message better? The commit message does not
mention the extra kworker round trip on every local connect.

> +		if (!owned && !local_backlog) {
>  			tipc_sk_filter_rcv(sk, skb, xmitq);
>  			continue;
>  		}
> @@ -2467,6 +2494,7 @@ static void tipc_sk_enqueue(struct sk_buff_head *inputq, struct sock *sk,
>  			atomic_set(dcnt, 0);
>  		lim = rcvbuf_limit(sk, skb) + atomic_read(dcnt);
>  		if (likely(!sk_add_backlog(sk, skb, lim))) {
> +			deferred |= !owned;
>  			trace_tipc_sk_overlimit1(sk, skb, TIPC_DUMP_SK_BKLGQ,
>  						 "bklg & rcvq >90% allocated!");
>  			continue;

[Severity: Low]
Before this patch, an unowned socket handled CONN_MANAGER messages
directly through tipc_sk_filter_rcv()->tipc_sk_proto_rcv(), with no
receive buffer limit.

When local_backlog is true, those messages now go through
sk_add_backlog(). If the limit is exceeded they are rejected later in
tipc_sk_enqueue():

		/* Overload => reject message back to sender */
		...
		if (tipc_msg_reverse(onode, &skb, TIPC_ERR_OVERLOAD)) {

On the peer, tipc_sk_conn_proto_rcv() treats any errcode as fatal:

	if (unlikely(msg_errcode(hdr))) {
		tipc_set_sk_state(sk, TIPC_DISCONNECTING);
		tipc_node_remove_conn(sock_net(sk), tsk_peer_node(tsk),
				      tsk_peer_port(tsk));

Could a CONN_ACK or CONN_PROBE rejected here abort the connection?

The limit for CONN_ACK is sk_rcvbuf << TIPC_SYSTEM_IMPORTANCE. For
CONN_PROBE it is sk_rcvbuf when TIPC_BLOCK_FLOWCTL is set. Hitting these
needs a very small SO_RCVBUF, or receive queue plus backlog above
sk_rcvbuf, which flow control normally prevents.

The owned-socket path already behaves this way. The patch widens the
window to every unowned period in which output is queued for a local
peer.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/657t6njsrgnpnfs2mc2lv776442fhv5zsosg3vxya5vqrtpag7%40nq3uxt6ymw7s
