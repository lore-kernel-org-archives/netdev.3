Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB613E0C69
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787048794; cv=none; b=C3HE7/eIYatUr7/n4geUS4Q/O8S/apRjx3JFRtTVBYki4/3UM8uWPu/dE96x4ITHKGkih7CdgNKL34mk6rT+6MCLAjeg4V5uquw6xZxRV04G/2ZCyDbpU8RxbsC6DWAEtshlmnV8TkfztJhH2TaFyZ6E9qICYs6Xr42ggm8/Wgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787048794; c=relaxed/simple;
	bh=CReJfGOQIweazChp4gKkOEZpCpHDfzvIdc/fCxMH0ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+Vsto7c3nwklcRdrZuDJzOtghCOhGVS46lJGc/Cwk0rBD5UoRiporWGkSlnYKITg3Fd3LFyimr1yDGvfMxhLUSlMJBvldbaxZHJpUyZKa9VgBIqkUmBq35IHd9jHSrO5lORqoycWKeHLuK2W1mU80vL4rPes1zSG5UfMNK+6YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dlbGIYMh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlbGIYMh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787048787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7AuActJwr3QYknfd/jAkZDLUHsQxsuAsg7NH6tktkRQ=;
	b=dlbGIYMhS2vFpOIV2LtnPkZmKV0Esw1PB5O7RyBr/1rVTRO1dLldZOpFY2M2X5d53rra4v
	/YcG5q6xYQLIMTq4+Yu4k4RK83QGSMtJMlf1QmD/wOWfHTyTU4jWCz5EuR1VNBURJ7OLi7
	TPhhJBBPnyz2mVyOa+IP6+1EmhJdpLo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-sQ9lgLGJNDmqRzVrkz_KmQ-1; Tue,
 18 Aug 2026 06:26:23 -0400
X-MC-Unique: sQ9lgLGJNDmqRzVrkz_KmQ-1
X-Mimecast-MFC-AGG-ID: sQ9lgLGJNDmqRzVrkz_KmQ_1787048781
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED35A18005B3;
	Tue, 18 Aug 2026 10:26:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.207])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E3CE423;
	Tue, 18 Aug 2026 10:26:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: almasrymina@google.com
Cc: kuba@kernel.org,
	kaiyuanz@google.com,
	willemb@google.com,
	edumazet@google.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	davem@davemloft.net,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	kerneljasonxing@gmail.com,
	asml.silence@gmail.com,
	bobbyeshleman@gmail.com,
	fw@strlen.de
Subject: Re: [PATCH net v4 2/2] net: tcp: block mixing readable and unreadable frags
Date: Tue, 18 Aug 2026 12:26:11 +0200
Message-ID: <20260818102612.132228-1-pabeni@redhat.com>
In-Reply-To: <20260814191336.187243-2-almasrymina@google.com>
References: <20260814191336.187243-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: tcp: block mixing readable and unreadable frags

This adds a check in tcp_sendmsg_locked() so an existing tail SKB is not
collapsed into when its readability does not match the presence of a
devmem binding, forcing a new segment instead.

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 455441f1b6949..b4237d0e994d6 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1240,7 +1240,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  
>  		trace_tcp_sendmsg_locked(sk, msg, skb, size_goal);
>  
> -		if (copy <= 0 || !tcp_skb_can_collapse_to(skb)) {
> +		if (copy <= 0 || !tcp_skb_can_collapse_to(skb) ||
> +		    unlikely(skb_frags_readable(skb) != !binding)) {
>  			bool first_skb;
>  
>  new_segment:

[Severity: Medium]
Is binding alone the right proxy here for "this send will append
unreadable frags"?

What actually selects the devmem filler is the zc dispatch in the loop
plus __zerocopy_sg_from_iter():

net/core/datagram.c:__zerocopy_sg_from_iter() {
	...
	else if (binding)
		ret = zerocopy_fill_skb_from_devmem(skb, from, length, binding);
	else
		ret = zerocopy_fill_skb_from_iter(skb, from, length);
}

and that is only reached from the zc == MSG_ZEROCOPY arm of
tcp_sendmsg_locked().

Can binding != NULL coexist with zc == 0?  In tcp_sendmsg_locked() the
binding is taken whenever the cmsg carries dmabuf_id:

		if (sk->sk_route_caps & NETIF_F_SG)
			zc = MSG_ZEROCOPY;
		else
			uarg_to_msgzc(uarg)->zerocopy = 0;

		if (!sockc_err && sockc.dmabuf_id) {
			binding = net_devmem_get_binding(sk, sockc.dmabuf_id);

while zc is only set under NETIF_F_SG.  The one dmabuf_id validation
does not look at SG at all:

	if (!sockc_err && sockc.dmabuf_id &&
	    (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY))) {
		err = -EINVAL;

And sk_setup_caps() in net/core/sock.c only force-adds NETIF_F_SG when
sk_can_gso() holds:

	if (unlikely(sk->sk_gso_disabled))
		sk->sk_route_caps &= ~NETIF_F_GSO_MASK;
	if (sk_can_gso(sk)) {
		if (dst->header_len && !xfrm_dst_offload_ok(dst)) {
			sk->sk_route_caps &= ~NETIF_F_GSO_MASK;
		} else {
			sk->sk_route_caps |= NETIF_F_SG | NETIF_F_HW_CSUM;

so a TCP-MD5/TCP-AO socket (sk_gso_disable()) or an IPsec dst on a device
with sg turned off ends up with binding != NULL and zc == 0.

In that state, does the new predicate go wrong in both directions?

If the tail is readable or newly allocated, skb_frags_readable(skb) !=
!binding evaluates to true != false, so every iteration takes
goto new_segment and the write is split into one skb per iteration, even
though the zc == 0 path only appends readable page frags via
skb_fill_page_desc().

If the tail is already unreadable from an earlier devmem send, the test
is false != false, collapsing is allowed, and skb_fill_page_desc() adds a
readable page frag to an skb that __skb_fill_netmem_desc() already marked
unreadable = 1 — the mixing this patch aims to prevent.  Would
validate_xmit_unreadable_skb() catch that?  It only looks at the first
frag:

net/core/dev.c:validate_xmit_unreadable_skb() {
	if (shinfo->nr_frags > 0) {
		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));

Would keying the new clause on binding && zc == MSG_ZEROCOPY, or
rejecting dmabuf_id when the route cannot do SG, line the predicate up
with the code that actually fills the frags?

Note the mixing described in the second direction pre-dates this patch
(there was no check at all before); the incorrect predicate and the
forced re-segmentation are new.  Reaching this also needs a local
privileged setup (dmabuf TX binding plus MD5/AO or IPsec plus an ethtool
feature change), and in that configuration a devmem send through the copy
path would likely already fail in skb_copy_to_page_nocache() since the
iovec holds dmabuf offsets rather than user addresses, so this is stated
as an observation rather than a demonstrated corruption path.
-- 
This is an AI-generated review.

