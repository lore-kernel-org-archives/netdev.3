Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782924;
	b=oUsensVd9iWBt5mENb6rezvrfNl7iPa6b5MgbOG0C9iUWOJd4akCW9XiDd3XNFXPPcDd
	 nZYwBW3NhYPLSlRJ26uN+uSfN8k3zTwT7k7rFhzlRCh4p/85kyuvRSWHdGB7BLAJJB5CA
	 SSPiMKn+kg2Mxdpkad8/SlUeEowF0044Wmy8vbv50lHX/Dp+RX6ZSmnWfPhN7B7otpo0h
	 QVv2iO4u11O61XYfLRdmw2i6Thh2M4fGkRngIJf3iOuL+DPiW+4E+SsEzZ9oCNqrulp1c
	 hF0qBBuY8pIaPwQP7tolprOjwFVehH+nfrbfYVxeb6fh7azOytbwLg6QWA0X44lGYDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782924;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7K6HjA65RbxLhotG+xqE4WNbbNBpJ+HkuzJl8AH55mo=;
	b=1YorIGKZgZCtC5KeWdbrM3tNezW6NG//a/KnhsN6mDylzFeOrXeXXBHRCJ5lTVraA7/6
	 USU8YjZGrjP0NAFW+tX7o+6bVQ6DBflDCZaFsuq1OAoCMYEvkIfJ1DE6DFJI2DuEfPE7D
	 q2OS2D+wf24F5xascOoSc4uIdoBYKRYFiCV+Z6YOuiU+2bsOM2DqBpY2i8yJ5X21ZRidb
	 LntLQPVaIUOzswP/zIladbxRK1bTDroitQ7RHl9dB3RwnLBT7CCXwZAI9PD/Hzdq1zR/H
	 wD5P68zdE72AERp46NVsJgPP+WYWbNyMgRxpNkNXTi5IE9/fmy4ceKK/mRhNmoxVB+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0fImH2i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D06606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0fImH2i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A41C1F000C1;
	Wed,  4 Nov 2026 09:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793782923;
	bh=7K6HjA65RbxLhotG+xqE4WNbbNBpJ+HkuzJl8AH55mo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y0fImH2iLHf479Z+DSHlaNu0HsnDOkvKsDQs8qX39Mkhvl06r1gkSy6anlAfiXXNQ
	 WZUeyjFEsABl66B9itLiCdimGCfGvEQvUfBQbh6SPJco5wSLf74E8JH1p8jfaI557/
	 z9rip73wiDG0X69zwHG1J2XmYj6U3xcZigmBUNNjmWDqc1QjtbgnX7Ulnzl1uAUj1k
	 mZRzDC3BqcAtsfbaaN54vXBd1TYFmfjfzrqahkc8ObGuXwTVl+iFk3B66DFBSHwSRR
	 nf7RjzWX5eWt1wAifQr0urgiGw8E2jE5HDHz4HvB9uLLeLJ+DaIrlGdGBGRtXHXPbP
	 vlBx0HsyP6BTQ==
Subject:
 Re: [PATCH net] tcp: ipv6: free ireq->ipv6_opt after an RCU grace period
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, sashiko-bot@kernel.org
Date: Wed, 04 Nov 2026 09:02:02 +0000
Message-ID: <179378292255.488856.6917577451813010963@kernel.org>
In-Reply-To: <20261103090011.4128420-1-edumazet@kernel.org>
References: <20261103090011.4128420-1-edumazet@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.

Pre-existing issues:
- [High] The ipv6_opt attached to a request socket is charged to the
  listener's sk_omem_alloc and never uncharged.
- [Low] After this patch, ireq->ipv6_opt is freed after an RCU grace
  period, and the commit message says its readers 'already run under…

--

tcp: ipv6: free ireq->ipv6_opt after an RCU grace period

When a request socket is migrated, the old request socket and its clone
share ireq->ipv6_opt. If the clone is freed while another CPU is still
using the options through the old request socket, that is a
use-after-free. The patch frees ipv6_opt with kfree_rcu() in
tcp_v6_reqsk_destructor(), as was already done for the IPv4 ireq_opt.

Closes: https://lore.kernel.org/netdev/179369559062.488856.15441115725436277776@kernel.org/

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e006a30360eae..517f34166cda6 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -607,7 +607,7 @@ static int tcp_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
>  
>  static void tcp_v6_reqsk_destructor(struct request_sock *req)
>  {
> -	kfree(inet_rsk(req)->ipv6_opt);
> +	kfree_rcu(inet_rsk(req)->ipv6_opt, rcu);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but it
is on the line being changed. Is the listener's sk_omem_alloc charge for
ipv6_opt ever released?

calipso_req_setattr() charges the listener, sk_to_full_sk(req), through
ipv6_renew_options()->sock_kmalloc(). It only uncharges the options that
it replaces:

net/ipv6/calipso.c:calipso_req_setattr() {
    ...
	txopts = ipv6_renew_options(sk, req_inet->ipv6_opt, IPV6_HOPOPTS, new);
    ...
	txopts = xchg(&req_inet->ipv6_opt, txopts);
	if (txopts) {
		atomic_sub(txopts->tot_len, &sk->sk_omem_alloc);
		txopt_put(txopts);
	}
    ...
}

calipso_req_delattr() uncharges in the same way. tcp_v6_reqsk_destructor()
does the final free of ipv6_opt with no atomic_sub(), both with kfree()
before this patch and with kfree_rcu() after it.

tcp_v6_syn_recv_sock() charges the child separately through
ipv6_dup_options(newsk, ...), so the listener's charge stays in place.

On a listener with a CALIPSO label, does sk_omem_alloc grow by roughly
80-110 bytes for each connection request? With the default optmem_max of
128KB, sock_kmalloc() would start failing after about 1300 requests. Then
ipv6_renew_options() returns -ENOBUFS, and every later SYN is dropped by
the LSM hook in tcp_v6_route_req():

	if (security_inet_conn_request(sk, skb, req))
		return NULL;

When the listener is destroyed, __sk_destruct() would also report optmem
leakage.

[Severity: Low]
This isn't a bug introduced by this patch, but the commit message says
that both readers "already run under RCU, like their IPv4 counterparts".
Now that ipv6_opt is freed after a grace period, should it get the
matching RCU annotations?

In struct inet_request_sock, ipv6_opt is a plain pointer, while the IPv4
member of the same union is __rcu:

	union {
		struct ip_options_rcu __rcu	*ireq_opt;
#if IS_ENABLED(CONFIG_IPV6)
		struct {
			struct ipv6_txoptions	*ipv6_opt;

Both IPv6 readers load it with a plain read. For example, in
tcp_v6_syn_recv_sock():

	opt = ireq->ipv6_opt;
	if (!opt)
		opt = rcu_dereference(np->opt);
	if (opt) {
		opt = ipv6_dup_options(newsk, opt);

The IPv4 readers use rcu_dereference(ireq->ireq_opt). Meanwhile,
reqsk_migrate_reset() writes NULL to the same field with a plain store,
on a request that other CPUs may still be reading.

KCSAN would report this as a data race, and sparse cannot check the RCU
usage. In theory the compiler could reload ireq->ipv6_opt after the NULL
test and pass NULL to ipv6_dup_options().

Would it make sense to add __rcu, rcu_dereference() and RCU_INIT_POINTER()
on top of the kfree_rcu() change?

>  	consume_skb(inet_rsk(req)->pktopts);

[Severity: High]
Does this fully close the window described in the commit message?

After inet_reqsk_clone(), the old request and its clone also share the
same inet_rsk(req)->pktopts skb. reqsk_migrate_reset() clears it together
with ipv6_opt:

net/ipv4/inet_connection_sock.c:reqsk_migrate_reset() {
    ...
	inet_rsk(req)->ipv6_opt = NULL;
	inet_rsk(req)->pktopts = NULL;
    ...
}

pktopts is still freed right away, both here and in tcp_v6_syn_recv_sock()
when that request wins own_req:

net/ipv6/tcp_ipv6.c:tcp_v6_syn_recv_sock() {
    ...
	if (*own_req) {
		...
		if (ireq->pktopts) {
			newnp->pktoptions = skb_clone_and_charge_r(ireq->pktopts, newsk);
			consume_skb(ireq->pktopts);
			ireq->pktopts = NULL;
    ...
}

At the same time, tcp_v6_send_synack() on the sibling request can read it
without any RCU protection:

net/ipv6/tcp_ipv6.c:tcp_v6_send_synack() {
    ...
		if (inet6_test_bit(REPFLOW, sk) && ireq->pktopts)
			fl6->flowlabel = ip6_flowlabel(ipv6_hdr(ireq->pktopts));
    ...
}

tcp_v6_init_req() keeps pktopts whenever REPFLOW (or the common rxopt
bits) is set on the listener, so this does not need CALIPSO.

With REPFLOW set, tcp_migrate_req=1 (or a BPF migrate program), and a
listener that is closing, one possible sequence is:

CPU A                                CPU C
reqsk_timer_handler(oreq)
  nreq = inet_reqsk_clone(oreq, nsk)
  tcp_rtx_synack(nsk, nreq)
    tcp_v6_send_synack()             tcp_check_req(oreq) (final ACK)
                                       tcp_v6_syn_recv_sock(oreq)
                                         own_req = true
                                         consume_skb(oreq->pktopts)
      ipv6_hdr(ireq->pktopts)  <- skb already freed

The timer's reference on oreq protects ipv6_opt in this case, but it does
not protect pktopts.

The reverse order also looks possible. CPU C handles a retransmitted SYN
on oreq and calls tcp_check_req()->tcp_rtx_synack()->tcp_v6_send_synack().
At the same time, CPU A has done inet_ehash_insert(nreq, oreq) but not yet
reqsk_migrate_reset(oreq). CPU B then processes the final ACK on nreq and
frees the shared skb in tcp_v6_syn_recv_sock().

In both cases ipv6_hdr() reads from a freed sk_buff. That can oops, or it
can put stale bits into the flow label of the SYNACK.

tcp_v6_syn_recv_sock() frees the skb directly, so switching to an RCU
deferred free would not help here. Does pktopts need its own handling,
for example an skb_get() for the clone, so that each request drops only
its own reference?

>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103090011.4128420-1-edumazet%40kernel.org
