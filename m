Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A673051B195
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168376; cv=none; b=hWkWrdexl3TEegCu2Yj6K1guxOAuAWvN0fb65dfVbLyHbWMU49iTOhJ1isZS1mkmU+OLlm+4bHtUXNgCCIdlMyy7zbxZDieZSkrETxYTMsSl/RMaUKsDT0SVGyilrFKKR1z8iN7ScsrjRnY6VF7pYDP/mctyG+ODvy6Mh2phagg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168376; c=relaxed/simple;
	bh=0CBL+pom1u0pNH+W7eLyJzGkNWiqt5wnfGYLlKW8QG8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/MZKwEhC+wiGsW97nbEmIAD/9VCsKHwcvkOFORxz1T/V8lheCnX5d9xJ/qNzygQSEEJ+aOJ7vawR9wpIKg6ycEiSg6RHtT4uClqe+8A23iVKnyFSbHroyxn5LOIRdYEPGfML7xDE2Ij+McWmvnKPgcr+eKgo5FUI7xJZ7s7i3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EejvhAec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EejvhAec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D251F000FF;
	Wed, 23 Sep 2026 12:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790168372;
	bh=ri5FOf6W8DtlGM+5JaB8o0lwjRnfMAniA7bzDEq9Rrk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EejvhAecNq3pXvGpM9WXdhjkhIx1h9GUfccogplEN1Q2AnqWa6azC9U5m+Fp4QNsB
	 uOhy3j8oBv3R4J/4zPYzE/7GGqdO3vHF9V1B6ZI4hnaLCglr9ixC3LkjgXcOZl/5V5
	 5oIFdtmA6WYeeZ82Q2M7Sh2TjwBTQGMwVNH8Y4yhJQcD2R5CEOCsxpQYOV/9FLbrX2
	 woRQ7xa/1wBhXEgnltnanLjOOQbgQoWn7YDdNbp3CXSNFMCXpv6pPduziTD0LOUdfw
	 36jCs4mh1wnT7aciDqCYfAsaA+kr0Bw7KyMvZFjSbaiZ0njtl5878Y2aHmOo1nRvSM
	 57yCuiBy1eduQ==
Subject: Re: [PATCH net] udp: restore hlist_nulls for primary and secondary
 hash tables
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 willemdebruijn.kernel@gmail.com
Date: Wed, 23 Sep 2026 12:59:31 +0000
Message-ID: <179016837127.2160803.11508533385406825812@kernel.org>
In-Reply-To: <20260922095747.3059954-1-edumazet@google.com>
References: <20260922095747.3059954-1-edumazet@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch converts every UDP primary/secondary hash bucket to
  hlist_nulls and makes the nulls-value restart mandatory for lockless…
- [Medium] udp_lib_rehash() (net/ipv4/udp.c) gains an IPv6+SO_REUSEPORT
  tail-insert branch that did not exist before: the pre-image is an…
- [Medium] The newly added tail insertion defeats the very nulls-value
  check this patch adds, because a node can leave a bucket and come back…
- [Low] udp_lib_rehash() now calls hlist_nulls_add_tail_rcu() for IPv6
  SO_REUSEPORT sockets while holding spin_lock_bh(&hslot->lock) with…
- [Low] The patch renames sk_for_each_entry_offset_rcu() to
  sk_nulls_for_each_entry_offset_rcu() in include/net/sock.h and updates…

--

udp: restore hlist_nulls for primary and secondary hash tables

This converts udptable->hash and udptable->hash2 back to hlist_nulls while
keeping SOCK_RCU_FREE, and adds a get_nulls_value() based restart to the
lockless lookup helpers so a reader that follows a relocated socket into
another bucket retries instead of terminating early.

A few questions about the conversion below.

> diff --git a/include/net/sock.h b/include/net/sock.h
> index 60ea55dc18854..78626aba52dca 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h

[ ... ]

> @@ -965,18 +969,19 @@ static inline void sk_add_bind_node(struct sock *sk,
>  	hlist_for_each_entry_safe(__sk, tmp, list, sk_bind_node)
>  
>  /**
> - * sk_for_each_entry_offset_rcu - iterate over a list at a given struct offset
> + * sk_nulls_for_each_entry_offset_rcu - iterate over a list at a given struct offset
>   * @tpos:	the type * to use as a loop cursor.
> - * @pos:	the &struct hlist_node to use as a loop cursor.
> + * @pos:	the &struct hlist_nulls_node to use as a loop cursor.
>   * @head:	the head for your list.
> - * @offset:	offset of hlist_node within the struct.
> + * @offset:	offset of hlist_nulls_node within the struct.
>   *
>   */
> -#define sk_for_each_entry_offset_rcu(tpos, pos, head, offset)		       \
> -	for (pos = rcu_dereference(hlist_first_rcu(head));		       \
> -	     pos != NULL &&						       \
> +#define sk_nulls_for_each_entry_offset_rcu(tpos, pos, head, offset)	       \
> +	for (({ barrier(); }),						       \
> +	     pos = rcu_dereference_raw(hlist_nulls_first_rcu(head));	       \
> +	     (!is_a_nulls(pos)) &&					       \
>  		({ tpos = (typeof(*tpos) *)((void *)pos - offset); 1;});       \
> -	     pos = rcu_dereference(hlist_next_rcu(pos)))
> +	     pos = rcu_dereference_raw(hlist_nulls_next_rcu(pos)))

[Severity: Low]
This isn't a bug, but .clang-format still lists only the old name in
ForEachMacros:

  - 'sk_for_each_entry_offset_rcu'

After this rename that entry matches no macro in the tree, and
sk_nulls_for_each_entry_offset_rcu is not listed at all, so clang-format
formats the two converted loop bodies in net/ipv4/udp.c and net/ipv6/udp.c
as call arguments rather than loop bodies.  Should the entry be renamed
along with the macro?

> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index b090bd1f59e86..309220bf2fba9 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c

[ ... ]

> @@ -440,10 +443,14 @@ static struct sock *udp4_lib_lookup1(const struct net *net,
>  {
>  	unsigned int slot = udp_hashfn(net, hnum, udptable->mask);
>  	struct udp_hslot *hslot = &udptable->hash[slot];
> -	struct sock *sk, *result = NULL;
> -	int score, badness = 0;
> +	struct hlist_nulls_node *node;
> +	struct sock *sk, *result;
> +	int score, badness;
>  
> -	sk_for_each_rcu(sk, &hslot->head) {
> +begin:
> +	result = NULL;
> +	badness = 0;
> +	sk_nulls_for_each_rcu(sk, node, &hslot->head) {
>  		score = compute_score(sk, net,
>  				      saddr, sport, daddr, hnum, dif, sdif);
>  		if (score > badness) {
> @@ -451,6 +458,13 @@ static struct sock *udp4_lib_lookup1(const struct net *net,
>  			badness = score;
>  		}
>  	}
> +	/*
> +	 * if the nulls value we got at the end of this lookup is
> +	 * not the expected one, we must restart lookup.
> +	 * We probably met an item that was moved to another chain.
> +	 */
> +	if (unlikely(get_nulls_value(node) != slot))
> +		goto begin;
>  
>  	return result;
>  }

[ ... ]

> @@ -2291,13 +2315,18 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
>  
>  			if (hslot2 != nhslot2) {
>  				spin_lock(&hslot2->lock);
> -				hlist_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
> +				hlist_nulls_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
>  				hslot2->count--;
>  				spin_unlock(&hslot2->lock);
>  
>  				spin_lock(&nhslot2->lock);
> -				hlist_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
> -							 &nhslot2->head);
> +				if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
> +				    sk->sk_family == AF_INET6)
> +					hlist_nulls_add_tail_rcu(&udp_sk(sk)->udp_portaddr_node,
> +								 &nhslot2->head);
> +				else
> +					hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
> +								 &nhslot2->head);
>  				nhslot2->count++;
>  				spin_unlock(&nhslot2->lock);
>  			}

[Severity: Medium]
The pre-image here was an unconditional head insert.  Is the new IPv6 plus
SO_REUSEPORT tail insert part of the hlist_nulls conversion?  The changelog
only describes restoring hlist_nulls and adding the traversal restarts, so
this chain ordering change is not mentioned.

reuseport_detach_sock() clears only sk->sk_reuseport_cb, not
sk->sk_reuseport, so the new branch is taken on every hash2-changing rehash
of an IPv6 reuseport socket.

With CONFIG_BASE_SMALL=y (udp6_lib_lookup4() is a stub and udp_has_hash4()
returns false) the new ordering looks like it can misdeliver persistently:

  socket A: IPv6, SO_REUSEPORT, bound to [X]:P, left unconnected
  socket B: IPv6, SO_REUSEPORT, bound to [::]:P, then connected so that
            its selected source address is X

udp_v6_rehash() -> udp_lib_rehash() now appends B behind A in hash2 bucket
hash2(X,P).  For a packet from B's peer, udp6_lib_lookup2() scores A first
(compute_score() returns 0 for A, which beats the initial badness of -1), A
is not TCP_ESTABLISHED so inet6_lookup_reuseport() returns A from its
one-socket group, reuseport_has_conns(A) is false and A is returned before B
is ever scored.  __udp6_lib_lookup() then takes

	/* Got non-wildcard socket or error on first lookup */
	if (result)
		goto done;

and never falls back to udp6_lib_lookup1().  Is B's connected traffic then
delivered to A for as long as this setup exists?

In default builds udpv6_connect() -> udp6_hash4() places B in hash4 and
udp6_lib_lookup4() resolves it before udp6_lib_lookup2() runs, which hides
this.

If this is repairing a separate soreuseport ordering problem, would it be
clearer as its own patch with its own Fixes: tag?  Otherwise, should the
rehash site keep hlist_nulls_add_head_rcu() as before?

[Severity: Medium]
Can this tail insertion defeat the nulls-value check added elsewhere in the
patch?  hlist_nulls_add_tail_rcu() does:

	for (i = h->first; !is_a_nulls(i); i = i->next)
		last = i;

	if (last) {
		WRITE_ONCE(n->next, last->next);

so the re-inserted node's ->next becomes the same bucket's nulls marker,
while __hlist_nulls_del() deliberately leaves the removed node's ->next
pointing into the chain.

Consider hash2 bucket A holding [S, T], where S is an IPv6 reuseport socket
and T matches an incoming packet.  A reader in udp6_lib_lookup2() or
udp4_lib_lookup2() has consumed S but has not yet loaded S->next.  Another
CPU runs connect():

udpv6_connect() -> udp_v6_rehash() -> udp_lib_rehash()   /* A -> B */

and then disconnect(), which for a wildcard-bound socket holding
SOCK_BINDPORT_LOCK without SOCK_BINDADDR_LOCK calls sk->sk_prot->rehash()
from __udp_disconnect():

	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
		inet_reset_saddr(sk);
		if (sk->sk_prot->rehash &&
		    (sk->sk_userlocks & SOCK_BINDPORT_LOCK))
			sk->sk_prot->rehash(sk);
	}

						 /* B -> A, tail insert */

S now sits after T and S->next is the nulls marker of bucket A.  The parked
reader loads that marker, never visits T, and

	if (unlikely(get_nulls_value(node) != slot2))
		goto begin;

does not fire because the bucket index matches.  If the truncated lookup
still returns a lower-scoring socket, __udp6_lib_lookup() takes
'if (result) goto done' and never runs the udp6_lib_lookup1() fallback.

Is comparing bucket identity alone enough once a node can leave a bucket and
be appended back to the same bucket?

[Severity: Low]
This path now does an O(N) chain walk with softirqs disabled.
hlist_nulls_add_tail_rcu() walks the whole destination chain:

	for (i = h->first; !is_a_nulls(i); i = i->next)
		last = i;

and here it runs under spin_lock_bh(&hslot->lock) with nhslot2->lock nested,
where N is the number of sockets in the destination hash2 bucket (a whole
reuseport group sharing address and port hashes into one bucket).  The
previous code used the O(1) hlist_add_head_rcu().

An unprivileged task can repeat this without creating sockets, by looping
connect()/disconnect() on a wildcard-bound IPv6 reuseport socket, since each
pair changes hash2 and performs the walk twice.  The same O(N) walk already
exists in the bind path through udp_lib_get_port(), so the magnitude is not
new, only cheaper to repeat.  Is holding the primary bucket lock with BH
disabled across that walk acceptable on the rehash path?

[ ... ]

> @@ -2525,7 +2554,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
>  	hash2 = 0;
>  	hslot = udp_hashslot(udptable, net, hnum);
>  	use_hash2 = hslot->count > 10;
> -	offset = offsetof(typeof(*sk), sk_node);
> +	offset = offsetof(typeof(*sk), sk_nulls_node);
>  
>  	if (use_hash2) {
>  		hash2_any = ipv4_portaddr_hash(net, htonl(INADDR_ANY), hnum) &
> @@ -2536,7 +2565,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
>  		offset = offsetof(typeof(*sk), __sk_common.skc_portaddr_node);
>  	}
>  
> -	sk_for_each_entry_offset_rcu(sk, node, &hslot->head, offset) {
> +	sk_nulls_for_each_entry_offset_rcu(sk, node, &hslot->head, offset) {
>  		if (!__udp_is_mcast_sock(net, sk, uh->dest, daddr,
>  					 uh->source, saddr, dif, sdif, hnum))
>  			continue;

[Severity: High]
Should this walk also validate the terminating nulls value?  The lookup
helpers converted in this same patch restart with

	if (unlikely(get_nulls_value(node) != slot))
		goto begin;

but sk_nulls_for_each_entry_offset_rcu() only stops on is_a_nulls(pos), and
neither __udp4_lib_mcast_deliver() nor __udp6_lib_mcast_deliver() looks at
node afterwards.

Both expected indexes are already in scope: udp_hashslot() above derives the
primary index from udp_hashfn(net, hnum, udptable->mask), and the hash2 walk
uses the local hash2.

This runs from udp_rcv() -> __udp4_lib_rcv() -> __udp4_lib_mcast_deliver()
under rcu_read_lock() only, with no hslot->lock.  If a concurrent
udp_lib_rehash() (connect() or disconnect() on a wildcard-bound socket), or
udp_lib_unhash() followed by bind()/connect() -> udp_lib_get_port() ->
sk_nulls_add_node_rcu(), moves a socket out of the bucket being walked, can
this loop follow the moved node's ->next into the other chain, stop on that
chain's nulls marker, and skip the remaining multicast listeners of the
original bucket?

And when the chain it lands in is the hash2_any chain, can those sockets be
visited a second time by the

	if (use_hash2 && hash2 != hash2_any) {
		hash2 = hash2_any;
		goto start_lookup;
	}

pass, delivering the datagram twice?

One complication: by the time the jump could be detected, skbs have already
been cloned and queued, so a plain 'goto begin' restart like the one in
udp4_lib_lookup1() does not seem usable here.

For completeness, __udp4_lib_demux_lookup() and __udp6_lib_demux_lookup()
were also converted to nulls iteration without the check.  There only the
first chain entry is inspected and inet_match()/inet6_match() revalidate the
4-tuple, so the effect looks benign, but the new contract is applied
inconsistently across readers of the same buckets.

[ ... ]

> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 93478d1ad5769..f14132d400671 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c

[ ... ]

> @@ -979,7 +1000,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
>  		offset = offsetof(typeof(*sk), __sk_common.skc_portaddr_node);
>  	}
>  
> -	sk_for_each_entry_offset_rcu(sk, node, &hslot->head, offset) {
> +	sk_nulls_for_each_entry_offset_rcu(sk, node, &hslot->head, offset) {
>  		if (!__udp_v6_is_mcast_sock(net, sk, uh->dest, daddr,
>  					    uh->source, saddr, dif, sdif,
>  					    hnum))

[Severity: High]
Same question for the IPv6 side: this walk covers either the primary bucket
(offset sk_nulls_node) or udptable->hash2[hash2].hslot (offset
skc_portaddr_node), both of which udp_lib_rehash() and udp_lib_unhash() can
change without an RCU grace period, yet get_nulls_value(node) is not
compared against udp_hashfn(net, hnum, udptable->mask) or hash2 here the way
udp6_lib_lookup1() and udp6_lib_lookup2() now do.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922095747.3059954-1-edumazet%40google.com
