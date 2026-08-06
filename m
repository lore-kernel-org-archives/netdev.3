Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C87345CC9;
	Thu,  6 Aug 2026 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979785; cv=none; b=cl0wC5rdSVAMQWvCHjOlvC7U7R6DsdSFXrrxxi5iCJnHywFFrckJt7k8E1X+cx0JLmDfzEdrGbFdnEdjR3PNOXu/2vM92d+awJxZjRpISU2JpVwLU0fGWcViw+s7rNcHHdgC8yuGqfWe93uN69ZDMpDwZK5mqs/QHBqjGt99Kyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979785; c=relaxed/simple;
	bh=umzTlYn/tqs33u8X14K9LFzBJSqVZO311sLlFj6GftQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjUdp5ZljubDAlJY50f7KgPseubdLH0A5uEcwu11AJ0JX8DVyWybWJrTGZv9iKE5mGmtiAf95RLwUeQ5kAfrgU4R7U7cYdr1tnx5wNBS7LYldjdf93HMdep7yXBiD/8bSO4cN6U/iiOIfC4L+dSok8RNyYzNnWT01dyBxyxE7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hS1uq7Mm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hS1uq7Mm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A241F000E9;
	Thu,  6 Aug 2026 01:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785979783;
	bh=Bne+eTkvNIlQCqiXyoMMk6gyvSRgzDCp6yQvIjoqXYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hS1uq7MmIDqdLrx4daAO9ovOPPiiWPglV1Chfm+nUHYD/3hPtG9sZ1F3L1+DZZi0T
	 4I8KG+g1rOo+I32FMDt3UT0p/6eZ+JVP0W/Iyq+rtm6tV5t+1nfJYHgpG6It+CeqYO
	 CHD5gWsMOL7InGOkZzW+QJfEnZ0TeyBrv4Y281wAdxavuMGG5FIz1Q2cvFix0obYtZ
	 LxaLECmwH6PO9FV7XuP2L5I8H9oMXJDDUGaCUxPZ1y3IbJrJdxuAwHJVQJY24Qb335
	 mgVgQ10xvM3zIOVlBqPwBK7vL9MZWrbHXAvf8fVE06xk5+dFwA0k5vr9OT8tATuCQU
	 cTTe3mBF87STw==
From: Jakub Kicinski <kuba@kernel.org>
To: qingfang.deng@linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-ppp@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kees@kernel.org,
	ericwouds@gmail.com,
	manizada@pm.me,
	nbd@nbd.name,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	norbert@doyensec.com,
	gnault@redhat.com
Subject: Re: [PATCH net-next] pppoe: pass bound packets directly to generic PPP
Date: Wed,  5 Aug 2026 18:28:21 -0700
Message-ID: <20260806012820.1905519-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804074452.75548-1-qingfang.deng@linux.dev>
References: <20260804074452.75548-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is (mostly) an AI-generated review of your patch.

One non-AI question - presumably you're doing this to improve performance?
Could you add some numbers to the cover letter?
---
pppoe: pass bound packets directly to generic PPP

This drops __sk_receive_skb() for PPPOX_BOUND PPPoE sockets and hands
session frames straight to ppp_input() from pppoe_rcv(), relying on the
RCU-deferred channel free added by ec4215683e47.  It also adds a
synchronize_net() in pppoe_connect() after the old session is unhashed,
before po->chan is cleared and reused.

No Link: tags are present in the commit header.

A few questions below.

> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index 6874a1a8edaf1..0624116241823 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -345,10 +345,10 @@ static struct notifier_block pppoe_notifier = {
>  
>  /************************************************************************
>   *
> - * Do the real work of receiving a PPPoE Session frame.
> + * Backlog receive a PPPoE Session frame and deliver to userspace.
>   *
>   ***********************************************************************/
> -static int pppoe_rcv_core(struct sock *sk, struct sk_buff *skb)
> +static int pppoe_backlog_rcv(struct sock *sk, struct sk_buff *skb)
>  {
>  	struct pppox_sock *po = pppox_sk(sk);

[Severity: Low]
Is the new banner comment accurate?  The function body still delivers to
the generic PPP layer, not to userspace:

drivers/net/ppp/pppoe.c:pppoe_backlog_rcv() {
	if (sk->sk_state & PPPOX_BOUND) {
		ppp_input(&po->chan, skb);
	} else {
		if (sock_queue_rcv_skb(sk, skb))
			goto abort_kfree;
	}
}

That branch still looks reachable: pppoe_rcv() only takes the new direct
path when it observes PPPOX_BOUND, and a frame observed while !BOUND is put
on the socket backlog by __sk_receive_skb() and only evaluated at
release_sock() time.  By then pppox_ioctl(PPPIOCGCHAN) may already have run
sk->sk_state |= PPPOX_BOUND under lock_sock().

Could the comment mention that the bound case still goes to ppp_input(), so
that a later reader does not remove the branch on the strength of the banner
text?

[ ... ]

> @@ -420,6 +420,10 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (!po)
>  		goto drop;
>  
> +	if (likely(po->sk.sk_state & PPPOX_BOUND)) {
> +		ppp_input(&po->chan, skb);
> +		return NET_RX_SUCCESS;
> +	}
>  	return __sk_receive_skb(&po->sk, skb, 0, 1, false);

[Severity: Medium]
Does this skip socket filters and the skb->dev clearing that
__sk_receive_skb() used to perform for bound sessions?

net/core/sock.c:__sk_receive_skb() {
	reason = sk_filter_trim_cap(sk, skb, trim_cap);
	if (reason)
		goto discard_and_relse;

	skb->dev = NULL;
	...
}

Two things in sk_filter_trim_cap() look relevant here.  A filter attached
with SO_ATTACH_FILTER/SO_ATTACH_BPF is now silently ignored for all bound
session traffic; do_sock_setsockopt() routes SOL_SOCKET options to
sock_setsockopt() for PF_PPPOX since pppoe does not set SOCK_CUSTOM_SOCKOPT,
so sk->sk_filter can be non-NULL.  The pfmemalloc guard is also bypassed:

net/core/filter.c:sk_filter_trim_cap() {
	if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)) {
		NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
		return SKB_DROP_REASON_PFMEMALLOC;
	}
	...
}

The dropped skb->dev = NULL also matters for the frames ppp_input() parks on
pch->file.rq (proto >= 0xc000, PPP_CCPFRAG, or pch->ppp == NULL) -- those can
now sit queued indefinitely holding a non-refcounted net_device pointer.  Is
that intentional?  The cgroup-BPF and LSM parts of sk_filter_trim_cap() do
appear to be no-ops for PF_PPPOX, so those are not a concern, and the
sk_rcvqueues_full() check is not meaningful for the bound path.

Note the PPPOX_BOUND branch in pppoe_backlog_rcv() still runs under the old
contract, so the same class of frame is handled two different ways depending
on timing.  Could the changelog say something about the filtering and
skb->dev behaviour change?

[Severity: Low]
Should this read be annotated?  po->sk.sk_state is loaded here from softirq
with no lock held, while every writer stores it with a plain access under
lock_sock():

drivers/net/ppp/pppox.c:pppox_unbind_sock()	sk->sk_state = PPPOX_DEAD;
drivers/net/ppp/pppox.c:pppox_ioctl()		sk->sk_state |= PPPOX_BOUND;
drivers/net/ppp/pppoe.c:pppoe_connect()		sk->sk_state = PPPOX_CONNECTED;

Before the patch the test happened inside bh_lock_sock() in
__sk_receive_skb(), so it was serialized against those writers.  Would
KCSAN report this now, and would READ_ONCE()/WRITE_ONCE() be appropriate?

There is also a bare control dependency: pppoe_connect() fills in
po->chan.{hdrlen,mtu,private,ops}, calls ppp_register_net_channel() (which
sets chan->ppp), and only then publishes sk->sk_state, with no release
store to pair with.  The reader then loads po->chan.ppp inside ppp_input()
with no acquire.  As far as I can tell the worst outcome is ppp_input()
seeing !pch and dropping the frame, so this looks like an annotation
question rather than a correctness one.  pppol2tp_recv() has the same
unannotated pattern.

[Severity: Low]
Can frames reach ppp_input() out of arrival order now?  Two paths can feed
the same channel:

pppoe_rcv() -> ppp_input()			(softirq, no socket lock)
release_sock() -> pppoe_backlog_rcv() -> ppp_input()	(process context)

pppox_ioctl(PPPIOCGCHAN) sets sk->sk_state |= PPPOX_BOUND under lock_sock().
A frame that arrived just before that, while the socket was owned by the
ioctl caller, went to the socket backlog.  A frame arriving after the BOUND
store but before release_sock() takes the new fast path and is handed to
ppp_input() immediately, ahead of the older backlogged one.

ppp_input() serializes internally, and the window only exists once per
session while LCP/auth frames are in flight, so this may be acceptable --
but is it worth a note?

[Severity: Low]
Does this leave the documented channel contract stale?

include/linux/ppp_channel.h {
 * SMP locking notes:
 * The channel code must ensure that when it calls ppp_unregister_channel,
 * nothing is executing in any of the procedures above, for that
 * channel.
}

ppp_input() is one of the listed procedures.  After this change pppoe_rcv()
calls it from softirq with no serialization, while every pppoe caller that
reaches ppp_unregister_channel() via pppox_unbind_sock() -- pppoe_release(),
pppoe_flush_dev(), pppoe_unbind_sock_work(), pppoe_connect() -- does so
without draining in-flight ppp_input() callers.  In pppoe_connect() the new
synchronize_net() sits after pppox_unbind_sock(), so it fences the later
memset(&po->chan) and re-registration rather than the unregister itself.

The RCU-deferred struct channel free from ec4215683e47 does appear to close
the use-after-free, and pppol2tp_recv() already calls ppp_input() the same
lockless way, so this is about the text rather than a runtime failure.
Should include/linux/ppp_channel.h (and possibly
Documentation/networking/ppp_generic.rst) be updated to describe the
RCU-based rule that now makes this safe?

[ ... ]

> @@ -625,6 +629,13 @@ static int pppoe_connect(struct socket *sock, struct sockaddr_unsized *uservaddr
>  		pn = pppoe_pernet(sock_net(sk));
>  		delete_item(pn, po->pppoe_pa.sid,
>  			    po->pppoe_pa.remote, po->pppoe_ifindex);
> +
> +		/* pppoe_rcv() can call ppp_input() without taking the socket
> +		 * lock. Once the socket is unhashed, wait for any receive path
> +		 * that found it earlier before clearing and reusing po->chan.
> +		 */
> +		synchronize_net();
> +
>  		if (po->pppoe_dev) {
>  			dev_put(po->pppoe_dev);
>  			po->pppoe_dev = NULL;

[Severity: Low]
Is holding the socket lock across the grace period necessary here?
pppoe_connect() takes lock_sock(sk) at the top, so every disconnect/rebind
of a session now blocks other users of that socket for a full,
non-expedited RCU grace period.  The drain is only needed to protect the
following memset(&po->chan, 0, sizeof(po->chan)), so could it be arranged
without the socket lock held?

For the record, this does not look like it can stall RTNL:
delete_item() unhashes the socket before synchronize_net(), and
pppoe_flush_dev() only locks sockets it finds by walking pn->hash_table, so
the RTNL-holding notifier cannot find the socket sleeping in the grace
period.
-- 
pw-bot: cr
