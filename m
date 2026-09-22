Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847663BB674
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078943; cv=none; b=sm1H+R4dHSNC78ue6kPPO0eeCQwgwVJ0rXXY41YiveQu0j3KuxjMHPW4M277th1bgQnO+fZDD++z1RTqU70X7U7vTGXl3NOAgZmpP9ZoemZ/RCaJeM+76g2oS54RAfozE4NTftrgWGNnxjMqF91WP44lzZY2yT8Kny7uX/nN5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078943; c=relaxed/simple;
	bh=M5tiK3RATozge4FziwBNYNYfV3FUhwK7Uc9yAAwdfFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjPZ+s+YfN2uNQpCznC2CUeL8DtwJgHCBf1O1zrNX8gGch1zRF8Xjffe4Aw/4H2rsK4p3US+1dGm8S4SZVVbBzv3QKLbOXTTSNJEKswyje9yHFixpgQfk1QfD+2+4ctm1I15XHNDS9gxbbaaRjgtL6+ZcXbPos2iMHGPoWahJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFWnB/oj; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFWnB/oj"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e620fa473so24831945e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790078939; x=1790683739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Ob1rSWsviM2/W9EUKI28cen2bu88iT9LHfUe7oDnzI=;
        b=qFWnB/ojN5L4bq7e8Ba1G/bZt50Y5vLz3P57qXlJioAAfUaHuGOlnKlLyDNAlHyRuG
         4V5uD3gJnUN1Bk0vxJj5iEpNsVw2TX5zJ7IW3MsBUnVKclBzRqBTz6mbhIF9yDm+jKCk
         2gI8cHg1t6yHsx8/CgTzgPL885pFKRj0Nv593uW7bHSikOwdpS1qcmlzshodBOH5cBhA
         nb5CVhCiZCFp/Hp0phHINIJXx4dPKtc6KR6ADsXryVpAJEcSX3OWybIwGQ++AvxaH+3R
         E75/NL83SVNvr9yWbsvknA0uiup73RfBKQEdqkmtSmzUSKNHBy9Y4i8OIwp7s8/b4xIu
         DeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790078939; x=1790683739;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Ob1rSWsviM2/W9EUKI28cen2bu88iT9LHfUe7oDnzI=;
        b=w63/rwg3CXit9CEpYESelVh7VzpkD9/4VAS0XGY/plbdyQhIfJT+gxZ/GmkDlHhKec
         FBEa1wYUhMS59Cvy03oe/hdF90OaYUXDovIRMKaIZrS2rooYRksulK4qd2HjEb9pglvS
         gOsi3+waQTp6AXruxfJs6nKCz/FwC801tV0ghSrWz72KEODYA5mXA2Ivii6En1Y0HAGb
         ReZ+R/U8mO+TuT7XPsSz1QpZ5sp5W5/TwPMe9Pq1uW6V0D4e4GrCvws62C3oHunfYmfT
         gxkkqSnXYdBHMFDkqxmSD3neP1G1Rg7rqmA54isDcPLZH4O1DOnDp0I+YHwrDXVw1Hkb
         CclA==
X-Forwarded-Encrypted: i=1; AKwUvBwOgXCe7zhNL7DWakmDYXthxVGGTNmhuEO4WPJ3OoKw9TvVKtYmIongCFr8SIZO5Z9iCothJ58=@vger.kernel.org
X-Gm-Message-State: AFuF++kAZgTgIMaRqz8gmJa0JWMCnTmkbDN0CqaXByVF5ebKqrspY0Ht
	EUnXj6EC+n323T+17SHqlapsuGQ5NX6selUQME/1RZyRawgvbUHgKv0uz3hp4xtF
X-Gm-Gg: AYBFou2in5G6pbhkhD02lRMbVYdpncKxFY1bw9YXUgRV8CG6/Mci4J+E3iy35dfL1kj
	hoQdOnrXpQa3TPVzvjysNrzobZfwcLot9+ieUPDTIqAo+EaNV+/X+pI7Dobff5hZBy1xnu44Nr3
	IH1FJbEu5EKbl2NaSFdkSRd7lw7+U27+J72mYnIC5Ln3AS8dXNYfUup+D65tIFuwJ6pebKipfBa
	mJbwDBYeAifjTPRtp1XwHjEF4NUpQCBkTW2aS7NhX3C9wGJvaLO/fYZay1HrCLpAu+BvkvubyAE
	7t4d9TCI3E6r4r4+o8TMOb9ZW6a5nDTaO5YTyQebeFfjEsG81AxlpqJeBagfCfB20NPCOG2/cha
	LR/zCdSvX6QkAzAq0bU+hqWha6LMSE8QjakFxshlRv2fpvgbkvoql9PWhb4+DkgXM8+ygLQp+ie
	0U+4d4llVPutdPxpxR57uCJWw3v1Szt2Rl0Xd2NMI6rlyLLIGMzJ5J1Nr914PE1fR/p1ZO0J25D
	aqRkIEBDq09EHuL3v+eaRi9tcxoDwyd5g0=
X-Received: by 2002:a05:600c:6296:b0:49e:63cd:31fb with SMTP id 5b1f17b1804b1-49fc5714bdamr194724835e9.9.1790078938152;
        Tue, 22 Sep 2026 05:08:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdad36439sm71860425e9.6.2026.09.22.05.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:08:57 -0700 (PDT)
Date: Tue, 22 Sep 2026 13:08:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net] udp: restore hlist_nulls for primary and secondary
 hash tables
Message-ID: <20260922130856.2c4f409a@pumpkin>
In-Reply-To: <20260922095747.3059954-1-edumazet@google.com>
References: <20260922095747.3059954-1-edumazet@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 09:57:47 +0000
Eric Dumazet <edumazet@google.com> wrote:

> Commit ca065d0cf80f ("udp: no longer use SLAB_DESTROY_BY_RCU") switched
> UDP sockets to SOCK_RCU_FREE and converted udptable->hash and
> udptable->hash2 from hlist_nulls_head to hlist_head.
> 
> While SOCK_RCU_FREE guarantees that a socket is not freed before an RCU
> grace period elapses, a live UDP socket can still be unhashed or moved
> to a different hash bucket without an RCU grace period:
> 
> 1. udp_lib_rehash() moves sk->skc_portaddr_node from hslot2 to a
>    different nhslot2 when inet_rcv_saddr changes (for instance via
>    connect() or disconnect() on an wildcard-bound socket).
> 2. __udp_disconnect() calls udp_lib_unhash() when an implicitly bound
>    port was used, and a subsequent connect() or bind() can immediately
>    re-insert sk->sk_nulls_node and sk->skc_portaddr_node into different
>    hash and hash2 buckets.
> 
> Because hlist_add_head_rcu() overwrites node->next with the new bucket
> chain without waiting for an RCU grace period, a concurrent lockless
> reader in udp4_lib_lookup1/2() or udp6_lib_lookup1/2() traversing the
> old bucket can silently jump to the new bucket chain, terminate early,
> and miss a matching socket that was located later in the original bucket.
> 
> Restore hlist_nulls for udptable->hash and udptable->hash2 while keeping
> SOCK_RCU_FREE (so RCU lookups remain refcount-free), and restart the
> bucket traversal if get_nulls_value(node) does not match the expected
> bucket index.

Thanks - I've reported it before.
This is hit by a real application and causes unexpected ICMP port unreachable
messages on localhost.
I'm not sure why that application hits it, it does use a lot of udp sockets
but I don't believe any are 'connected'.
The work around is to ignore a single icmp error message.
I can't test the change - the fault could never be reliably reproduced and
the failing systems run on the Amazon cloud.
(And I've retired and don't work for that company any more.)

David

> 
> Fixes: ca065d0cf80f ("udp: no longer use SLAB_DESTROY_BY_RCU")
> Assisted-by: LLM
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> ---
>  include/linux/udp.h |  11 +++--
>  include/net/sock.h  |  23 +++++----
>  include/net/udp.h   |   5 +-
>  net/ipv4/udp.c      | 112 ++++++++++++++++++++++++++++++--------------
>  net/ipv4/udp_diag.c |   5 +-
>  net/ipv6/udp.c      |  40 ++++++++++++----
>  6 files changed, 131 insertions(+), 65 deletions(-)
> 
> diff --git a/include/linux/udp.h b/include/linux/udp.h
> index 998906ec3b32add4652bde3ee9c28e8b2b98ce51..a1990350fd22f3418724c0e06d4b7405779f7c2b 100644
> --- a/include/linux/udp.h
> +++ b/include/linux/udp.h
> @@ -243,14 +243,15 @@ static inline void udp_allow_gso(struct sock *sk)
>  	udp_set_bit(ACCEPT_FRAGLIST, sk);
>  }
>  
> -#define udp_portaddr_for_each_entry(__sk, list) \
> -	hlist_for_each_entry(__sk, list, __sk_common.skc_portaddr_node)
> +#define udp_portaddr_for_each_entry(__sk, node, list) \
> +	hlist_nulls_for_each_entry(__sk, node, list, __sk_common.skc_portaddr_node)
>  
>  #define udp_portaddr_for_each_entry_from(__sk) \
> -	hlist_for_each_entry_from(__sk, __sk_common.skc_portaddr_node)
> +	for (; __sk; __sk = hlist_nulls_entry_safe((__sk)->__sk_common.skc_portaddr_node.next, \
> +						   typeof(*(__sk)), __sk_common.skc_portaddr_node))
>  
> -#define udp_portaddr_for_each_entry_rcu(__sk, list) \
> -	hlist_for_each_entry_rcu(__sk, list, __sk_common.skc_portaddr_node)
> +#define udp_portaddr_for_each_entry_rcu(__sk, node, list) \
> +	hlist_nulls_for_each_entry_rcu(__sk, node, list, __sk_common.skc_portaddr_node)
>  
>  #if !IS_ENABLED(CONFIG_BASE_SMALL)
>  #define udp_lrpa_for_each_entry_rcu(__up, node, list) \
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 60ea55dc18854a9759f5df618cc8c904d2323e95..78626aba52dca6ab9fcae60f5bc277089f143633 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -184,7 +184,7 @@ struct sock_common {
>  	int			skc_bound_dev_if;
>  	union {
>  		struct hlist_node	skc_bind_node;
> -		struct hlist_node	skc_portaddr_node;
> +		struct hlist_nulls_node	skc_portaddr_node;
>  	};
>  	struct proto		*skc_prot;
>  	possible_net_t		skc_net;
> @@ -930,7 +930,11 @@ static inline void __sk_nulls_add_node_tail_rcu(struct sock *sk, struct hlist_nu
>  static inline void sk_nulls_add_node_rcu(struct sock *sk, struct hlist_nulls_head *list)
>  {
>  	sock_hold(sk);
> -	__sk_nulls_add_node_rcu(sk, list);
> +	if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
> +	    sk->sk_family == AF_INET6)
> +		__sk_nulls_add_node_tail_rcu(sk, list);
> +	else
> +		__sk_nulls_add_node_rcu(sk, list);
>  }
>  
>  static inline void __sk_del_bind_node(struct sock *sk)
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
>  
>  static inline struct user_namespace *sk_user_ns(const struct sock *sk)
>  {
> diff --git a/include/net/udp.h b/include/net/udp.h
> index 1fee17274745f0b52837b7eb2498dbc423a450fd..1bba33479341e07f2dde9acc19b0b09cafa3ef29 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -56,10 +56,7 @@ struct udp_skb_cb {
>   */
>  struct udp_hslot {
>  	union {
> -		struct hlist_head	head;
> -		/* hash4 uses hlist_nulls to avoid moving wrongly onto another
> -		 * hlist, because rehash() can happen with lookup().
> -		 */
> +		struct hlist_nulls_head	head;
>  		struct hlist_nulls_head	nulls_head;
>  	};
>  	int			count;
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index b090bd1f59e86cd22edd9622b17b5679346ea24d..309220bf2fba9e7ccf48676d312924a6881bc34f 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -136,10 +136,11 @@ static int udp_lib_lport_inuse(struct net *net, __u16 num,
>  			       unsigned long *bitmap,
>  			       struct sock *sk, unsigned int log)
>  {
> +	struct hlist_nulls_node *node;
>  	kuid_t uid = sk_uid(sk);
>  	struct sock *sk2;
>  
> -	sk_for_each(sk2, &hslot->head) {
> +	sk_nulls_for_each(sk2, node, &hslot->head) {
>  		if (net_eq(sock_net(sk2), net) &&
>  		    sk2 != sk &&
>  		    (bitmap || udp_sk(sk2)->udp_port_hash == num) &&
> @@ -171,12 +172,13 @@ static int udp_lib_lport_inuse2(struct net *net, __u16 num,
>  				struct udp_hslot *hslot2,
>  				struct sock *sk)
>  {
> +	struct hlist_nulls_node *node;
>  	kuid_t uid = sk_uid(sk);
>  	struct sock *sk2;
>  	int res = 0;
>  
>  	spin_lock(&hslot2->lock);
> -	udp_portaddr_for_each_entry(sk2, &hslot2->head) {
> +	udp_portaddr_for_each_entry(sk2, node, &hslot2->head) {
>  		if (net_eq(sock_net(sk2), net) &&
>  		    sk2 != sk &&
>  		    (udp_sk(sk2)->udp_port_hash == num) &&
> @@ -201,10 +203,11 @@ static int udp_lib_lport_inuse2(struct net *net, __u16 num,
>  static int udp_reuseport_add_sock(struct sock *sk, struct udp_hslot *hslot)
>  {
>  	struct net *net = sock_net(sk);
> +	struct hlist_nulls_node *node;
>  	kuid_t uid = sk_uid(sk);
>  	struct sock *sk2;
>  
> -	sk_for_each(sk2, &hslot->head) {
> +	sk_nulls_for_each(sk2, node, &hslot->head) {
>  		if (net_eq(sock_net(sk2), net) &&
>  		    sk2 != sk &&
>  		    sk2->sk_family == sk->sk_family &&
> @@ -323,7 +326,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
>  
>  		sock_set_flag(sk, SOCK_RCU_FREE);
>  
> -		sk_add_node_rcu(sk, &hslot->head);
> +		sk_nulls_add_node_rcu(sk, &hslot->head);
>  		hslot->count++;
>  		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
>  
> @@ -331,11 +334,11 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
>  		spin_lock(&hslot2->lock);
>  		if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
>  		    sk->sk_family == AF_INET6)
> -			hlist_add_tail_rcu(&udp_sk(sk)->udp_portaddr_node,
> -					   &hslot2->head);
> +			hlist_nulls_add_tail_rcu(&udp_sk(sk)->udp_portaddr_node,
> +						 &hslot2->head);
>  		else
> -			hlist_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
> -					   &hslot2->head);
> +			hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
> +						 &hslot2->head);
>  		hslot2->count++;
>  		spin_unlock(&hslot2->lock);
>  	}
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
> @@ -463,13 +477,16 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
>  				     struct udp_hslot *hslot2,
>  				     struct sk_buff *skb)
>  {
> +	unsigned int slot2 = UDP_HSLOT_MAIN(hslot2) - net->ipv4.udp_table->hash2;
> +	struct hlist_nulls_node *node;
>  	struct sock *sk, *result;
>  	int score, badness;
>  	bool need_rescore;
>  
> +begin:
>  	result = NULL;
>  	badness = 0;
> -	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> +	udp_portaddr_for_each_entry_rcu(sk, node, &hslot2->head) {
>  		need_rescore = false;
>  rescore:
>  		score = compute_score(need_rescore ? result : sk, net, saddr,
> @@ -510,6 +527,13 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
>  			goto rescore;
>  		}
>  	}
> +	/*
> +	 * if the nulls value we got at the end of this lookup is
> +	 * not the expected one, we must restart lookup.
> +	 * We probably met an item that was moved to another chain.
> +	 */
> +	if (unlikely(get_nulls_value(node) != slot2))
> +		goto begin;
>  	return result;
>  }
>  
> @@ -562,7 +586,7 @@ static struct sock *udp4_lib_lookup4(const struct net *net,
>  	 * expected one, we must restart lookup. We probably met an item that
>  	 * was moved to another chain due to rehash.
>  	 */
> -	if (get_nulls_value(node) != slot)
> +	if (unlikely(get_nulls_value(node) != slot))
>  		goto begin;
>  
>  	return NULL;
> @@ -2251,13 +2275,13 @@ void udp_lib_unhash(struct sock *sk)
>  		spin_lock_bh(&hslot->lock);
>  		if (rcu_access_pointer(sk->sk_reuseport_cb))
>  			reuseport_detach_sock(sk);
> -		if (sk_del_node_init_rcu(sk)) {
> +		if (sk_nulls_del_node_init_rcu(sk)) {
>  			hslot->count--;
>  			inet_sk(sk)->inet_num = 0;
>  			sock_prot_inuse_add(net, sk->sk_prot, -1);
>  
>  			spin_lock(&hslot2->lock);
> -			hlist_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
> +			hlist_nulls_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
>  			hslot2->count--;
>  			spin_unlock(&hslot2->lock);
>  
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
> @@ -2513,9 +2542,9 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
>  	unsigned int hash2, hash2_any, offset;
>  	unsigned short hnum = ntohs(uh->dest);
>  	struct sock *sk, *first = NULL;
> +	struct hlist_nulls_node *node;
>  	int dif = skb->dev->ifindex;
>  	int sdif = inet_sdif(skb);
> -	struct hlist_node *node;
>  	struct udp_hslot *hslot;
>  	struct sk_buff *nskb;
>  	bool use_hash2;
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
> @@ -2749,6 +2778,7 @@ static struct sock *__udp4_lib_mcast_demux_lookup(struct net *net,
>  {
>  	struct udp_table *udptable = net->ipv4.udp_table;
>  	unsigned short hnum = ntohs(loc_port);
> +	struct hlist_nulls_node *node;
>  	struct sock *sk, *result;
>  	struct udp_hslot *hslot;
>  	unsigned int slot;
> @@ -2760,8 +2790,9 @@ static struct sock *__udp4_lib_mcast_demux_lookup(struct net *net,
>  	if (hslot->count > 10)
>  		return NULL;
>  
> +begin:
>  	result = NULL;
> -	sk_for_each_rcu(sk, &hslot->head) {
> +	sk_nulls_for_each_rcu(sk, node, &hslot->head) {
>  		if (__udp_is_mcast_sock(net, sk, loc_port, loc_addr,
>  					rmt_port, rmt_addr, dif, sdif, hnum)) {
>  			if (result)
> @@ -2769,6 +2800,13 @@ static struct sock *__udp4_lib_mcast_demux_lookup(struct net *net,
>  			result = sk;
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
> @@ -2785,6 +2823,7 @@ static struct sock *__udp4_lib_demux_lookup(struct net *net,
>  	struct udp_table *udptable = net->ipv4.udp_table;
>  	INET_ADDR_COOKIE(acookie, rmt_addr, loc_addr);
>  	unsigned short hnum = ntohs(loc_port);
> +	struct hlist_nulls_node *node;
>  	struct udp_hslot *hslot2;
>  	unsigned int hash2;
>  	__portpair ports;
> @@ -2794,7 +2833,7 @@ static struct sock *__udp4_lib_demux_lookup(struct net *net,
>  	hslot2 = udp_hashslot2(udptable, hash2);
>  	ports = INET_COMBINED_PORTS(rmt_port, hnum);
>  
> -	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> +	udp_portaddr_for_each_entry_rcu(sk, node, &hslot2->head) {
>  		if (inet_match(net, sk, acookie, ports, dif, sdif))
>  			return sk;
>  		/* Only check first socket in chain */
> @@ -3228,6 +3267,7 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
>  {
>  	struct udp_iter_state *state = seq->private;
>  	struct net *net = seq_file_net(seq);
> +	struct hlist_nulls_node *node;
>  	struct udp_table *udptable;
>  	struct sock *sk;
>  
> @@ -3237,11 +3277,11 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
>  	     ++state->bucket) {
>  		struct udp_hslot *hslot = &udptable->hash[state->bucket];
>  
> -		if (hlist_empty(&hslot->head))
> +		if (hlist_nulls_empty(&hslot->head))
>  			continue;
>  
>  		spin_lock_bh(&hslot->lock);
> -		sk_for_each(sk, &hslot->head) {
> +		sk_nulls_for_each(sk, node, &hslot->head) {
>  			if (seq_sk_match(seq, sk))
>  				goto found;
>  		}
> @@ -3259,7 +3299,7 @@ static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
>  	struct udp_table *udptable;
>  
>  	do {
> -		sk = sk_next(sk);
> +		sk = sk_nulls_next(sk);
>  	} while (sk && !seq_sk_match(seq, sk));
>  
>  	if (!sk) {
> @@ -3431,12 +3471,12 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>  	for (; state->bucket <= udptable->mask; state->bucket++) {
>  		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket].hslot;
>  
> -		if (hlist_empty(&hslot2->head))
> +		if (hlist_nulls_empty(&hslot2->head))
>  			goto next_bucket;
>  
>  		spin_lock_bh(&hslot2->lock);
> -		sk = hlist_entry_safe(hslot2->head.first, struct sock,
> -				      __sk_common.skc_portaddr_node);
> +		sk = hlist_nulls_entry_safe(hslot2->head.first, struct sock,
> +					    __sk_common.skc_portaddr_node);
>  		/* Resume from the first (in iteration order) unseen socket from
>  		 * the last batch that still exists in resume_bucket. Most of
>  		 * the time this will just be where the last iteration left off
> @@ -3488,9 +3528,9 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>  
>  			/* Pick up where we left off. */
>  			sk = iter->batch[iter->end_sk - 1].sk;
> -			sk = hlist_entry_safe(sk->__sk_common.skc_portaddr_node.next,
> -					      struct sock,
> -					      __sk_common.skc_portaddr_node);
> +			sk = hlist_nulls_entry_safe(sk->__sk_common.skc_portaddr_node.next,
> +						    struct sock,
> +						    __sk_common.skc_portaddr_node);
>  			batch_sks = iter->end_sk;
>  			goto fill_batch;
>  		}
> @@ -3717,12 +3757,12 @@ static void __init udp_table_init(struct udp_table *table, const char *name)
>  
>  	table->hash2 = (void *)(table->hash + (table->mask + 1));
>  	for (i = 0; i <= table->mask; i++) {
> -		INIT_HLIST_HEAD(&table->hash[i].head);
> +		INIT_HLIST_NULLS_HEAD(&table->hash[i].head, i);
>  		table->hash[i].count = 0;
>  		spin_lock_init(&table->hash[i].lock);
>  	}
>  	for (i = 0; i <= table->mask; i++) {
> -		INIT_HLIST_HEAD(&table->hash2[i].hslot.head);
> +		INIT_HLIST_NULLS_HEAD(&table->hash2[i].hslot.head, i);
>  		table->hash2[i].hslot.count = 0;
>  		spin_lock_init(&table->hash2[i].hslot.lock);
>  	}
> @@ -3771,11 +3811,11 @@ static struct udp_table __net_init *udp_pernet_table_alloc(unsigned int hash_ent
>  	udptable->log = ilog2(hash_entries);
>  
>  	for (i = 0; i < hash_entries; i++) {
> -		INIT_HLIST_HEAD(&udptable->hash[i].head);
> +		INIT_HLIST_NULLS_HEAD(&udptable->hash[i].head, i);
>  		udptable->hash[i].count = 0;
>  		spin_lock_init(&udptable->hash[i].lock);
>  
> -		INIT_HLIST_HEAD(&udptable->hash2[i].hslot.head);
> +		INIT_HLIST_NULLS_HEAD(&udptable->hash2[i].hslot.head, i);
>  		udptable->hash2[i].hslot.count = 0;
>  		spin_lock_init(&udptable->hash2[i].hslot.lock);
>  	}
> diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
> index f4b24e628cf8ded821d0c1887dd6ca5b83c4c8e2..5e0b4e07d9c1d80a727647273c9793ca11626827 100644
> --- a/net/ipv4/udp_diag.c
> +++ b/net/ipv4/udp_diag.c
> @@ -100,15 +100,16 @@ static void udp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
>  
>  	for (slot = s_slot; slot <= table->mask; s_num = 0, slot++) {
>  		struct udp_hslot *hslot = &table->hash[slot];
> +		struct hlist_nulls_node *node;
>  		struct sock *sk;
>  
>  		num = 0;
>  
> -		if (hlist_empty(&hslot->head))
> +		if (hlist_nulls_empty(&hslot->head))
>  			continue;
>  
>  		spin_lock_bh(&hslot->lock);
> -		sk_for_each(sk, &hslot->head) {
> +		sk_nulls_for_each(sk, node, &hslot->head) {
>  			struct inet_sock *inet = inet_sk(sk);
>  
>  			if (!net_eq(sock_net(sk), net))
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 93478d1ad5769c6058567ff4deb433b0656b8129..f14132d4006718ce1e065986b734fb098bae4d9a 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -201,10 +201,14 @@ static struct sock *udp6_lib_lookup1(const struct net *net,
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
> @@ -212,6 +216,13 @@ static struct sock *udp6_lib_lookup1(const struct net *net,
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
> @@ -223,13 +234,16 @@ static struct sock *udp6_lib_lookup2(const struct net *net,
>  		int dif, int sdif, struct udp_hslot *hslot2,
>  		struct sk_buff *skb)
>  {
> +	unsigned int slot2 = UDP_HSLOT_MAIN(hslot2) - net->ipv4.udp_table->hash2;
> +	struct hlist_nulls_node *node;
>  	struct sock *sk, *result;
>  	int score, badness;
>  	bool need_rescore;
>  
> +begin:
>  	result = NULL;
>  	badness = -1;
> -	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> +	udp_portaddr_for_each_entry_rcu(sk, node, &hslot2->head) {
>  		need_rescore = false;
>  rescore:
>  		score = compute_score(need_rescore ? result : sk, net, saddr,
> @@ -270,6 +284,13 @@ static struct sock *udp6_lib_lookup2(const struct net *net,
>  			goto rescore;
>  		}
>  	}
> +	/*
> +	 * if the nulls value we got at the end of this lookup is
> +	 * not the expected one, we must restart lookup.
> +	 * We probably met an item that was moved to another chain.
> +	 */
> +	if (unlikely(get_nulls_value(node) != slot2))
> +		goto begin;
>  	return result;
>  }
>  
> @@ -315,7 +336,7 @@ static struct sock *udp6_lib_lookup4(const struct net *net,
>  	 * expected one, we must restart lookup. We probably met an item that
>  	 * was moved to another chain due to rehash.
>  	 */
> -	if (get_nulls_value(node) != slot)
> +	if (unlikely(get_nulls_value(node) != slot))
>  		goto begin;
>  
>  	return NULL;
> @@ -956,9 +977,9 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
>  	unsigned int hash2, hash2_any, offset;
>  	unsigned short hnum = ntohs(uh->dest);
>  	struct sock *sk, *first = NULL;
> +	struct hlist_nulls_node *node;
>  	int sdif = inet6_sdif(skb);
>  	int dif = inet6_iif(skb);
> -	struct hlist_node *node;
>  	struct udp_hslot *hslot;
>  	struct sk_buff *nskb;
>  	bool use_hash2;
> @@ -968,7 +989,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
>  	hash2 = 0;
>  	hslot = udp_hashslot(udptable, net, hnum);
>  	use_hash2 = hslot->count > 10;
> -	offset = offsetof(typeof(*sk), sk_node);
> +	offset = offsetof(typeof(*sk), sk_nulls_node);
>  
>  	if (use_hash2) {
>  		hash2_any = ipv6_portaddr_hash(net, &in6addr_any, hnum) &
> @@ -979,7 +1000,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
>  		offset = offsetof(typeof(*sk), __sk_common.skc_portaddr_node);
>  	}
>  
> -	sk_for_each_entry_offset_rcu(sk, node, &hslot->head, offset) {
> +	sk_nulls_for_each_entry_offset_rcu(sk, node, &hslot->head, offset) {
>  		if (!__udp_v6_is_mcast_sock(net, sk, uh->dest, daddr,
>  					    uh->source, saddr, dif, sdif,
>  					    hnum))
> @@ -1205,6 +1226,7 @@ static struct sock *__udp6_lib_demux_lookup(struct net *net,
>  {
>  	struct udp_table *udptable = net->ipv4.udp_table;
>  	unsigned short hnum = ntohs(loc_port);
> +	struct hlist_nulls_node *node;
>  	struct udp_hslot *hslot2;
>  	unsigned int hash2;
>  	__portpair ports;
> @@ -1214,7 +1236,7 @@ static struct sock *__udp6_lib_demux_lookup(struct net *net,
>  	hslot2 = udp_hashslot2(udptable, hash2);
>  	ports = INET_COMBINED_PORTS(rmt_port, hnum);
>  
> -	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> +	udp_portaddr_for_each_entry_rcu(sk, node, &hslot2->head) {
>  		if (sk->sk_state == TCP_ESTABLISHED &&
>  		    inet6_match(net, sk, rmt_addr, loc_addr, ports, dif, sdif))
>  			return sk;

