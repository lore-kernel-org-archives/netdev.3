Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB7242D9B
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961525; cv=none; b=ZSGNeiF5Jy77PrvFDeitxzGZbNTXmOC1tbJ83SwpNIWXvtVjKK3HtARus01q2g8QKvasgOkSQdzVWDjWY47Aos8p7u/aJR+LUtOVkCJEWmfRw6X/Rd9jqYgH3VR7OgwVW6ZCKfW3OmMEa98rrQxxNuSKwFGAcC0+8/ugrP043U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961525; c=relaxed/simple;
	bh=vc97Kdxihu9K4p0okJBFVQyPd1nlm/aJdmI27zbe9ZI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HU/iOqJzVcHQAXadU1aBdXhUNgI98r9q5awH8nYWw0UR+H0o4MWHRCVg2qjo2Ohe9/8oU0taWnwHGENFhlqlRWy9H3ogT7f1V5zfCxyA1Ye5EiHYIkl4XKYhyctXmJERZkhLj6qzKM7P8weLmbvjtyGTUyWSI1MZzrVFxxyjkdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8lyU2vS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8lyU2vS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3E81F00A3A;
	Wed,  9 Sep 2026 13:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961523;
	bh=miHrUx7HrqbY/E7N2cItt3ETqEa27hlDzoqphW7O64E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C8lyU2vSCXQ13oSOizk7ilCNWfv1WUdah5oK4a6SBv1lyyfKB1PDokBDx/yIPJJPh
	 SPYRrjKlFvEJhk9ZMiz/Q//LKqzRQFcfyAdPAdCVtZZTBoPY9C9+F3cy2EmZHn/60G
	 esi5xjgj81UsC+2JflOYp/JARB5/4TYVwelVzfQ3gljJMJQmqxkiqTfLj01ykBujQn
	 g13bw/MTn2gUXRuYWN3CgdHyr7fRuRge5oIYsvahDbXW6UVYixgDy0J08LCY/c1U3l
	 axCOP9Axcc6o6rxQR4LOzFtaTvThv5eHQXwx0zZTYUwcFBEgzVo+PQEVnBIWptnI+0
	 2tDyEukDG1kOw==
Subject: Re: [PATCH net v2 1/1] tcp: reject non zerocopy devmem tx
From: netdev-bot+sashiko@kernel.org
To: asml.silence@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 almasrymina@google.com
Date: Wed, 09 Sep 2026 13:45:22 +0000
Message-ID: <178896152268.219967.2387243409101048587@kernel.org>
In-Reply-To: =?utf-8?q?=3Cfdc2478d8f21268d7078556409887d8e6ba0ad32=2E1788529?=
 =?utf-8?q?053=2Egit=2Easml=2Esilence=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3Cfdc2478d8f21268d7078556409887d8e6ba0ad32=2E17885290?=
 =?utf-8?q?53=2Egit=2Easml=2Esilence=40gmail=2Ecom=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] Incomplete enforcement: devmem TX can still reach a byte-copy
  path that misinterprets dma-buf offsets as user virtual addresses.

--

tcp: reject non zerocopy devmem tx

The patch replaces the MSG_ZEROCOPY/SOCK_ZEROCOPY test that guards devmem
TX in tcp_sendmsg_locked() with a stricter check that requires the
zero-copy path to actually be in use and the dmabuf binding to have been
obtained.

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 1c867a3024446..562752352afe4 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1169,8 +1169,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  			zc = MSG_SPLICE_PAGES;
>  	}
>  
> -	if (!sockc_err && sockc.dmabuf_id &&
> -	    (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY))) {
> +	if (!sockc_err && sockc.dmabuf_id && (zc != MSG_ZEROCOPY || !binding)) {
>  		err = -EINVAL;
>  		goto out_err;
>  	}

[Severity: High]
Does this check still leave a devmem copy path reachable via TCP Fast
Open?  Right after it, tcp_sendmsg_locked() does:

	if (unlikely(flags & MSG_FASTOPEN ||
		     inet_test_bit(DEFER_CONNECT, sk)) &&
	    !tp->repair) {
		err = tcp_sendmsg_fastopen(sk, msg, &copied_syn, size, uarg);

Neither tcp_sendmsg_fastopen() nor tcp_connect()->tcp_send_syn_data()
gets the binding, and tcp_send_syn_data() copies straight out of the
same iterator:

net/ipv4/tcp_output.c:tcp_send_syn_data() {
	...
	space = copy_page_from_iter(pfrag->page, pfrag->offset,
				    space, &fo->data->msg_iter);
	...
	skb_fill_page_desc(syn_data, 0, pfrag->page,
			   pfrag->offset, space);
	...
	skb_zcopy_set(syn_data, fo->uarg, NULL);
}

For a devmem send the iovec entries are dma-buf offsets, not addresses:

net/core/datagram.c:zerocopy_fill_skb_from_devmem() {
	/* Devmem filling works by taking an IOVEC from the user where the
	 * iov_addrs are interpreted as an offset in bytes into the dma-buf to
	 * send from. We do not support other iter types.
	 */
}

So does copy_page_from_iter() here read whatever the caller happens to
have mapped at the numeric value of those offsets, put it into a regular
page frag, advance the iterator past the corresponding dma-buf range,
and then report those bytes back through fo->copied -> copied_syn ->
copied as if they had been sent?

Is the path reachable without MSG_FASTOPEN as well?  tcp_v4_connect()
runs sk_setup_caps(sk, &rt->dst) before tcp_fastopen_defer_connect(), so
with TCP_FASTOPEN_CONNECT the socket has a dst and NETIF_F_SG in
sk_route_caps while DEFER_CONNECT is still set.  A subsequent
sendmsg(MSG_ZEROCOPY) carrying SCM_DEVMEM_DMABUF would then get
zc == MSG_ZEROCOPY and a valid binding from net_devmem_get_binding(),
pass the new check, and land in tcp_send_syn_data().

There also looks to be a second residual route through repair mode.  The
tp->repair branch below reaches tcp_send_rcvq(), which copies from the
same iterator with no binding awareness:

net/ipv4/tcp_input.c:tcp_send_rcvq() {
	...
	err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
	...
}

That one needs CAP_NET_ADMIN, so it is less interesting, but it is still
a devmem iterator being byte-copied.

One more detail on the Fast Open case: msg_zerocopy_alloc() skips
accounting for devmem uargs:

net/core/skbuff.c:msg_zerocopy_alloc() {
	...
	if (likely(!devmem) && mm_account_pinned_pages(&uarg->mmp, size)) {
	...
}

so attaching that uarg to a copied page frag in tcp_send_syn_data()
would leave the frag unaccounted too.

Would it make sense to also reject dmabuf_id together with
MSG_FASTOPEN/DEFER_CONNECT and with repair-queue sends, or to teach
those paths about the binding?  The commit message mentions neither, so
it is hard to tell from the changelog whether these were considered,
which also matters for backporting given the two Fixes: tags.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/fdc2478d8f21268d7078556409887d8e6ba0ad32.1788529053.git.asml.silence%40gmail.com
