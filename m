Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF33A9610;
	Sun, 11 Oct 2026 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791730842; cv=none; b=CXMxpewpqq3/SCGZku3x4oUzH3AZd+q405q4iu8Pc8ODxmaeZ5mmp4+xmwBgEeHJyEUv01P1GSO5vu8W0+ji51NvV3OhZQ2Fgq4HOtN4x2lg8Q+qi1Z/d65dMl84exP/00JUDI/tb/O+CkuLRnvbsawuJpk5NHQYKknLGg8r6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791730842; c=relaxed/simple;
	bh=qAnQL4TPq/88O2MR/mjY3NH3AHX9H1/lbW+UwPLRsoo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ArGr1ON8/5bHNwvMKnFmp7QytIVRhdCGtqgoCtv+Qhk1fzaaS3gjbVqwKKi5j9TCXrKxyAe8gmkVjV/4cjIhHN0xkz2rAcJMd9RKSG/SgrJT0g6sDdk22EffuY/DAcd+9ACcUrKYO8nTWX8JMGIR1kUjHrqPCt89L+qu0fITEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN5J5gh4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN5J5gh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9A01F0089B;
	Sun, 11 Oct 2026 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791730840;
	bh=PJALqDt5bu15r0YG967irhHtAS42dFq6VRlVQNypGwc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oN5J5gh40j+DvZP7jocRE/QrIXMjeNbo0JdlsFA/OMauMD+RAbBF+otk8IGrPS5xC
	 sU9+Dz4xKI8wC3jvZjgXd89c7wzAR8cRmFRR2029drM5a4FpIQAsFY2nu/Uu5Z+Kqp
	 85cqybbdDLxf7FUjCe2pmGITwLTdxI+3OKxD6usAUm7hDjKNQ8jbEE9MFrNXGF1z48
	 ZxNb4wRE7EdPsNW0SBRPzi58F1ZsLYLDP4Ij4JqJ24jzFsMzFVp47Qnz8oO6s84f76
	 HU2i/mqIqVAVtnQoErmEc4l0Ngpmzv+xYIlELrhn1wkYHdXNMouds+8Fl27DM0N9Qb
	 xVJALGQXBJIyg==
Subject: Re: [PATCH net v1] net: devmem: prevent mixing fragments from
 different bindings
From: netdev-bot+sashiko@kernel.org
To: almasrymina@google.com
Cc: netdev@vger.kernel.org, kaiyuanz@google.com, sdf@fomichev.me,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, horms@kernel.org,
 bobbyeshleman@meta.com, antonio@openvpn.net, asml.silence@gmail.com,
 ralf@mandelbit.com
Date: Sun, 11 Oct 2026 15:00:39 +0000
Message-ID: <179173083927.434549.6834667881612626912@kernel.org>
In-Reply-To: <20261008034027.1403188-1-almasrymina@google.com>
References: <20261008034027.1403188-1-almasrymina@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch makes a valid devmem MSG_ZEROCOPY sendmsg() fail with
  -EFAULT.
- [High] The commit says it prevents mixing fragments from different
  devmem bindings in one skb, but it only guards the…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it undermines
  the validation the patch hardens.

--

net: devmem: prevent mixing fragments from different bindings

This patch adds net_devmem_skb_binding(), which returns the devmem binding
of an unreadable skb's first frag. validate_xmit_unreadable_skb() now uses
it, and zerocopy_fill_skb_from_devmem() now refuses to append frags from a
different binding to an skb that already has frags. The aim is to stop
consecutive sendmsg() calls with different dmabuf bindings from sharing
one skb and getting past the per-device and unbind checks at xmit time.

> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index 173b5d97bd409..ed8f1045f3cca 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -712,7 +712,7 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
>  	size_t virt_addr, size, off;
>  	struct net_iov *niov;
>  
> -	if (i && skb_frags_readable(skb))
> +	if (i && net_devmem_skb_binding(skb) != binding)
>  		return -EFAULT;

[Severity: High]
Can this make a valid devmem MSG_ZEROCOPY sendmsg() fail with -EFAULT?

Segment selection in tcp_sendmsg_locked() still compares only readability,
not binding identity:

net/ipv4/tcp.c:tcp_sendmsg_locked() {
    ...
		if (copy <= 0 || !tcp_skb_can_collapse_to(skb) ||
		    unlikely(skb_frags_readable(skb) != !binding)) {
    ...
}

Say the unsent tail skb holds frags from binding A, and the next sendmsg()
passes binding B through SCM_DEVMEM_DMABUF. The condition above is false,
so TCP appends to the tail skb.

On back-to-back calls, msg_zerocopy_realloc() extends and returns the same
uarg, so skb_zerocopy_iter_stream() does not return -EEXIST. We then reach
the new check with nr_frags > 0 and net_devmem_skb_binding(skb) == A != B.

The -EFAULT is not one of the errors that start a new segment:

net/ipv4/tcp.c:tcp_sendmsg_locked() {
    ...
			err = skb_zerocopy_iter_stream(sk, skb, msg, copy, uarg,
						       binding);
			if (err == -EMSGSIZE || err == -EEXIST) {
				tcp_mark_push(tp, skb);
				goto new_segment;
			}
			if (err < 0)
				goto do_error;
    ...
}

With copied == 0, userspace gets -EFAULT. Retries fail the same way until
the tail skb leaves the write queue. That can take a while if the socket
is corked, MSG_MORE is used, Nagle or TSO defers, or cwnd is the limit.

The old "i && skb_frags_readable(skb)" check could not be reached from
TCP, because the tcp_sendmsg_locked() condition above already filtered
that case. The new check can be reached.

net_devmem_get_binding() accepts any binding whose dev (or vdev) matches
the socket's dst device. So using two dmabufs bound to the same NIC on one
socket is legitimate, and it worked before this patch.

Would it be better to start a new segment when the binding changes? One
option is to add net_devmem_skb_binding(skb) != binding to the
tcp_sendmsg_locked() condition. Another is to return -EEXIST or -EMSGSIZE
here.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360e..ad2b587dfee27 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4054,8 +4054,7 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
>  static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
>  						    struct net_device *dev)
>  {
> -	struct skb_shared_info *shinfo;
> -	struct net_iov *niov;
> +	struct net_devmem_dmabuf_binding *binding;
>  
>  	if (likely(skb_frags_readable(skb) ||
>  		   dev->netmem_tx == NETMEM_TX_NO_DMA))

[Severity: High]
This issue was not introduced by this patch, but does this early return
let MTU probe skbs skip all of the devmem checks?

tcp_mtu_probe() allocates the probe skb as a readable skb:

net/ipv4/tcp_output.c:tcp_mtu_probe() {
    ...
	nskb = tcp_stream_alloc_skb(sk, GFP_ATOMIC, false);
    ...
}

tcp_clone_payload() then copies the devmem net_iov frags into nskb with
skb_frag_page_copy() and skb_frag_ref(). It never sets to->unreadable; it
only propagates SKBFL_SHARED_FRAG.

So skb_frags_readable(nskb) is true, and validate_xmit_unreadable_skb()
returns here, before the NETMEM_TX_NONE, binding->dev and unbind checks.

The mislabelled skb also looks readable to any code that reads the
payload. With an AF_PACKET tap on the egress device, for example,
tpacket_rcv() calls skb_copy_bits(). That passes its !skb_frags_readable()
guard and then kmaps skb_frag_page(), which is NULL for a net_iov.

packet_rcv() recvmsg, BPF socket filters and skb_checksum_help() appear to
be exposed the same way.

A separate question: skb_frag_page() is NULL for every net_iov, so can the
merge test in tcp_clone_payload() join frags from different niovs?

net/ipv4/tcp_output.c:tcp_clone_payload() {
    ...
			if (lastfrag &&
			    skb_frag_page(fragfrom) == skb_frag_page(lastfrag) &&
			    skb_frag_off(fragfrom) == skb_frag_off(lastfrag) +
						      skb_frag_size(lastfrag)) {
				skb_frag_size_add(lastfrag, todo);
    ...
}

net_devmem_get_niov_at() sets off = virt_addr % PAGE_SIZE. Take an iov at
dmabuf offset 0 with length 1000, followed by an iov at offset
8192 + 1000. That gives niov0 {off 0, len 1000} and niov2 {off 1000}.

Those two frags would be merged into one niov0 frag, and the wrong dmabuf
bytes would go on the wire.

> @@ -4064,14 +4063,9 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
>  	if (dev->netmem_tx == NETMEM_TX_NONE)
>  		goto out_free;
>  
> -	shinfo = skb_shinfo(skb);
> -
> -	if (shinfo->nr_frags > 0) {
> -		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
> -		if (net_is_devmem_iov(niov) &&
> -		    READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev)
> -			goto out_free;
> -	}
> +	binding = net_devmem_skb_binding(skb);
> +	if (binding && READ_ONCE(binding->dev) != dev)
> +		goto out_free;

[Severity: High]
The commit message says this prevents mixing fragments from different
bindings. Is the tcp_sendmsg_locked() append path the only place where
that mixing can happen?

Adjacent write-queue skbs with different bindings can still be created
after this patch. This happens when the binding A skb reached size_goal,
was sent with MSG_EOR, or msg_zerocopy_realloc() allocated a new uarg
(-EEXIST).

With MTU probing enabled and cwnd >= 11, tcp_mtu_probe() checks:

net/ipv4/tcp_output.c:tcp_can_coalesce_send_queue_head() {
    ...
		if (tcp_has_tx_tstamp(skb) || !tcp_skb_can_collapse(skb, next))
			return false;
    ...
}

tcp_skb_can_collapse() compares readability but not the binding:

include/net/tcp.h:tcp_skb_can_collapse() {
	return likely(tcp_skb_can_collapse_to(to) &&
		      mptcp_skb_can_collapse(to, from) &&
		      !skb_cmp_decrypted(to, from) &&
		      skb_pure_zcopy_same(to, from) &&
		      skb_frags_readable(to) == skb_frags_readable(from));
}

tcp_clone_payload() then copies the frags of both skbs into one probe
skb. net_devmem_skb_binding() only looks at frags[0]. So even if the probe
skb were correctly marked unreadable (see above), this check would only
validate binding A's dev. Binding B's dev and unbind state would never be
checked.

The other merge sites look covered. tcp_grow_skb() and SACK shifting go
through skb_shift(), which refuses zerocopy skbs. Retransmit collapse is
blocked because tcp_can_collapse() rejects unreadable skbs.

Should tcp_skb_can_collapse() or tcp_can_coalesce_send_queue_head() also
compare net_devmem_skb_binding() for the two skbs?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008034027.1403188-1-almasrymina%40google.com
