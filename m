Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695592;
	b=2e1+Q1Gz8we4fJA6eR/PpiMwDDJInVh70iVonxTcHHUuDWCSQB5UNa2LI2aLgLa0xIyA
	 mUYIlu+Sb5TVgSP2MKdBYiwSZTr3wgjr1MRlHwl11cxAX+W7jEFrzBsnopWKOhMnbTRUh
	 wqfdLhgtsarxv+fyOoCcm8cTidiOGqSzwyJ4F24WFMZ6lBK7C3uT+F5I4lLoLdIGaFkAK
	 XNsjhMLI6Wl507jkf62wM6/ntI1/u5wPQH8uC1gIRPPJmDEhkkxq32iIrG1iwSlLe8zoo
	 BTuwLmvTxGQs7k7qCMrdKE4MlavQP3eRt6XCqrrzdVxh+PAOeV2tKmsG68HqNWAqZeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695592;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6eDHmZ4cA95jFUW8/CBKQpWOAmh7vIpJBDFLTKpgQCc=;
	b=hFDiyMf6LTTeQz/vKYG14pPJj/Hp/lD8tLbclCyOFAiOaUrRosSjYmclZ5jR2cQsDBVX
	 p60emAhmF/rVPSjrB27ypg4nXwS0N2ieFnVKMZ8pu3LoabusBHLUvWiDvgfeZUcIbDcky
	 UBUNg2XXIxNZSIYriomMebMb26CCFzlKv8wB5UcUgbrMRxy8MHI+D5DnjeCPQaHDLLXwn
	 1FjRTSWhi5r0EN4es8Gm6jurRthR+f6nsQcQ5p9jiHib3QqAvsso4phJyX/ZFbKFdA2QU
	 akul070nH3XP0mbRBqs4t2yypX9vQE0AlAPfqO0oBpMiIE/crO9netdSA0vZx0j3a9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtiZ2EhU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3D606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtiZ2EhU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2173F1F00919;
	Tue,  3 Nov 2026 08:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793695591;
	bh=6eDHmZ4cA95jFUW8/CBKQpWOAmh7vIpJBDFLTKpgQCc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EtiZ2EhUnqiC4q2hHdNKGIEndRACZg7oRv1qPM7WWtFaHBdffTlpcM+/nseFEIzGL
	 jgc1UXRXGebOa5JYzLyMytKPL9Er0Ev78f2ywekBBYVEyTkiA45dQzJVAZHX3bGeBR
	 wNpx+kzcUlDItFiNeYu0/rOZcaOobBF3lpgohWaR1uSDWbSb3xQ/7FaKdK0WzMEnvS
	 wztLDGDeZpH7iF/TUvbNbzQa3/ZsZ8u/5OCV56/W87pRQQzfyIBCDq1iDG/KJo2+Ht
	 f9SK1O8y2/tdRpQPyRMRpb03RQG/1UjAJBXVafav4CBD0GdF5ZNyRzRjUiG0jkw5GA
	 VjLqQbfEemaAw==
Subject: Re: [PATCH net] tcp: ipv6: do not read ireq->pktopts from
 tcp_v6_send_synack()
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, permissiontogallop@gmail.com, x-professor@outlook.com
Date: Tue, 03 Nov 2026 08:46:30 +0000
Message-ID: <179369559062.488856.15441115725436277776@kernel.org>
In-Reply-To: <20261102075441.3771550-1-edumazet@kernel.org>
References: <20261102075441.3771550-1-edumazet@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes only half of the migration use-after-free (UAF)
  it describes.
- [Low] Leftover from this patch: tcp_v6_init_req()
  (net/ipv6/tcp_ipv6.c:799-806) still keeps a reference to the SYN skb…

--

tcp: ipv6: do not read ireq->pktopts from tcp_v6_send_synack()

This commit adds a syn_flowlabel field to tcp_request_sock. The field is
filled from the SYN in tcp_v6_init_req(), and tcp_v6_send_synack() now
uses it instead of reading ireq->pktopts. The old read could hit a freed
skb when another cpu completed the 3WHS or migrated the request socket.

Closes: https://lore.kernel.org/netdev/82c31e4d5043f3dbd11b44177cfba779d335aae3.1793599929.git.x-professor@outlook.com/

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e006a30360eae..d406cd3c8ceab 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -578,8 +578,8 @@ static int tcp_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
>  				    &ireq->ir_v6_rmt_addr);
>  
>  		fl6->daddr = ireq->ir_v6_rmt_addr;
> -		if (inet6_test_bit(REPFLOW, sk) && ireq->pktopts)
> -			fl6->flowlabel = ip6_flowlabel(ipv6_hdr(ireq->pktopts));
> +		if (inet6_test_bit(REPFLOW, sk))
> +			fl6->flowlabel = tcp_rsk(req)->syn_flowlabel;

[Severity: High]
This removes the pktopts read. Does the migration race described in the
commit message still apply to ireq->ipv6_opt, a few lines further down in
the same function?

net/ipv6/tcp_ipv6.c:tcp_v6_send_synack() {
    ...
		rcu_read_lock();
		opt = ireq->ipv6_opt;
		if (!opt)
			opt = rcu_dereference(np->opt);
		err = ip6_xmit(sk, skb, fl6, skb->mark ? : READ_ONCE(sk->sk_mark),
			       opt, tclass, READ_ONCE(sk->sk_priority));
    ...
}

reqsk_migrate_reset() hands ipv6_opt over to the clone along with pktopts:

net/ipv4/inet_connection_sock.c:reqsk_migrate_reset() {
	req->saved_syn = NULL;
#if IS_ENABLED(CONFIG_IPV6)
	inet_rsk(req)->ipv6_opt = NULL;
	inet_rsk(req)->pktopts = NULL;
    ...
}

inet_reqsk_clone() memcpy()s the request socket. Until the reset runs, nreq
and oreq both point at the same ipv6_txoptions. After the reset, nreq owns
it. When nreq is freed, the destructor releases it without waiting for an
RCU grace period:

net/ipv6/tcp_ipv6.c:tcp_v6_reqsk_destructor() {
	kfree(inet_rsk(req)->ipv6_opt);
	consume_skb(inet_rsk(req)->pktopts);
}

So the rcu_read_lock() in tcp_v6_send_synack() does not protect opt. IPv4
does this differently: tcp_v4_reqsk_destructor() frees ireq_opt with
kfree_rcu().

Could this sequence happen?

CPU0 (holds a reference on oreq)
tcp_v6_rcv()->tcp_check_req()->tcp_rtx_synack()->tcp_v6_send_synack()
    opt = ireq->ipv6_opt;     /* still non-NULL */

CPU1
inet_csk_complete_hashdance() or reqsk_timer_handler()
    reqsk_migrate_reset(oreq);
...
nreq is freed, on accept() of the child or after an RST leads to
inet_csk_reqsk_queue_drop() and the last reqsk_put():
    tcp_v6_reqsk_destructor()
        kfree(inet_rsk(req)->ipv6_opt);

CPU0
    ip6_xmit(..., opt, ...)
        /* reads opt->opt_nflen/opt_flen, pushes opt->hopopt etc. */

Only calipso_req_setattr() sets ireq->ipv6_opt. It is reached through
security_inet_conn_request()->netlbl_req_setattr() when a CALIPSO NetLabel
mapping is configured. The race also needs:

- SO_REUSEPORT listeners with request migration enabled
  (net.ipv4.tcp_migrate_req or a BPF sk_reuseport migrate program)
- a listener being closed

The patch carries Fixes: c905dee62232, and the commit message names
reqsk_migrate_reset() as one of the causes. Should ipv6_opt be handled
here too?

[ ... ]

> @@ -789,6 +789,7 @@ static void tcp_v6_init_req(struct request_sock *req,
>  	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
>  	ireq->ir_rmt_addr = LOOPBACK4_IPV6;
>  	ireq->ir_loc_addr = LOOPBACK4_IPV6;
> +	tcp_rsk(req)->syn_flowlabel = ip6_flowlabel(ipv6_hdr(skb));
>  
>  	/* So that link locals have meaning */
>  	if ((!sk_listener->sk_bound_dev_if || l3_slave) &&

[Severity: Low]
This isn't a bug, but now that the flowlabel comes from syn_flowlabel, is
the REPFLOW term still needed in the pktopts condition further down in
tcp_v6_init_req()?

	if (!tw_isn &&
	    (ipv6_opt_accepted(sk_listener, skb, &TCP_SKB_CB(skb)->header.h6) ||
	     np->rxopt.bits.rxinfo ||
	     np->rxopt.bits.rxoinfo || np->rxopt.bits.rxhlim ||
	     np->rxopt.bits.rxohlim || inet6_test_bit(REPFLOW, sk_listener))) {
		refcount_inc(&skb->users);
		ireq->pktopts = skb;
	}

On a REPFLOW listener with no rxopt bits set, every request socket still
holds a reference to its SYN skb. cookie_v6_check() uses the same condition
without the REPFLOW term, so the two places now differ.

One reader is left: IPV6_2292PKTOPTIONS in do_ipv6_getsockopt(), through
np->pktoptions on the child. It only produces cmsgs if rxopt bits are set
on the child after accept(). Dropping the term would change behaviour
slightly in that case.

Could a follow-up remove the term so that tcp_v6_init_req() matches
cookie_v6_check()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102075441.3771550-1-edumazet%40kernel.org
