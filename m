Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B505B2EB874;
	Wed,  9 Sep 2026 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965371; cv=none; b=sfSHi8WhjIPhuUlLyyv32NF2G9+qXATmmvMZ8kfguQHKpqu9MoXKAmdqBmu2xyW6wctaAYfk11LTJED2Uv+Yt7ZbvHtKFDLraeJuinI0pvx30z+L7RfDXtjY0DvjYJNXpvUKREkbwGqMTo4w7I6mTKj5+ydEN4A4noLAR853pU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965371; c=relaxed/simple;
	bh=0+jxatOJkTKz0Z36TjwcFYNxrqZtDXkyMFYR1moq7wM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A1eq/xFw7kiP6rcAvCTIB//vpStDrdjQSX89TGg/1wwHT9rfoPOpIaUY8nMghbeJYcAkj+AR+ZOim6l+8RyLJCAMv7PdZQgSVHpezGbnqQF06ggfMhejjkcKMzs/DQanybN385on9xZWTmu/RDsyfc6HEp5B658H2FkHwdQ1qtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV0GyHbd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV0GyHbd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A4C1F00A3D;
	Wed,  9 Sep 2026 14:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965369;
	bh=Kcc1zwfb6ErZoIcCaGyi/utsNG8G7ufybP3WOFJTiEw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TV0GyHbd25UEcoqz6ZWhLSAW9W5O139pA2tmxm0zZ+NMKRduKHBwG76bDDK89RR4c
	 rYghjHH5RVZTAHH1vQr1zByLsO80Tch69X8+2joX8td0lxj42m+/jgbQInrFs8q4HL
	 xnkxpFejhiURdTb0M5SfFrmPE77G9kiOaaYQj7+pIq4XX5K0/13mKN9TUF/CgVGcFh
	 HrSRuvauwfwB9JlvYPStwJYyZO/YwkN8VM2q6qcMRkDoN4bFGAsvKAj/EhCr8A/hBk
	 ujwU4jqXKl+iuAp2qErX9+E2p8ldKOJdlv5FGyeElAhq5PHeausvWpR0kz3nkWjbJP
	 qHROtHm1KcA4g==
Subject: Re: [PATCH net] netlink: render SCM_CREDENTIALS pid in the receiver's
 pid namespace
From: netdev-bot+sashiko@kernel.org
To: maoyixie.tju@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuniyu@google.com, horms@kernel.org,
 alexander@mihalicyn.com, brauner@kernel.org, adobriyan@openvz.org,
 akpm@linux-foundation.org, leitao@debian.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 14:49:27 +0000
Message-ID: <178896536799.219967.8543805128620693752@kernel.org>
In-Reply-To: <20260904144636.3443342-1-maoyixie.tju@gmail.com>
References: <20260904144636.3443342-1-maoyixie.tju@gmail.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 1 · High: 0 · Medium: 1 · Low: 1

- [Critical] Storing destructor-needed data (struct pid *) in skb->cb
  violates SKB Control Block Lifetime rules.
- [Medium] The new reference-counting scheme leaves a dangling `struct
  pid *` inside a live skb and then unconditionally re-acquires a…
- [Low] The three comments this patch adds to document its new borrowed-
  pid reference scheme contain two verifiably false statements about the…

--

netlink: render SCM_CREDENTIALS pid in the receiver's pid namespace

The patch carries the sender's struct pid in NETLINK_CB so that
netlink_recvmsg() can translate it into the reader's pid namespace with
scm_set_cred(), instead of copying the sender-rendered u32. The reference
is taken in netlink_skb_set_owner_r() and dropped in
netlink_skb_destructor().

> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> index 882e9c1b6c1dc..26266754e27c1 100644
> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -30,6 +30,15 @@ struct netlink_skb_parms {
>  	struct sock		*sk;
>  	bool			nsid_is_set;
>  	int			nsid;
> +	/*
> +	 * Sender's struct pid.  netlink_sendmsg() stores a borrowed pointer
> +	 * taken from its own scm_cookie.  netlink_skb_set_owner_r() takes a
> +	 * reference when it takes ownership of the skb for a receiver, and
> +	 * netlink_skb_destructor() drops that reference.  A clone starts out
> +	 * borrowing again, because __skb_clone() clears both skb->sk and
> +	 * skb->destructor.  NULL for a kernel generated skb.
> +	 */
> +	struct pid		*pid;
>  };
>  
>  #define NETLINK_CB(skb)		(*(struct netlink_skb_parms*)&((skb)->cb))
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index e6b1d9758c9c9..170d90d472a0d 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -379,13 +379,24 @@ static void netlink_skb_destructor(struct sk_buff *skb)
>  
>  		skb->head = NULL;
>  	}
> -	if (skb->sk != NULL)
> +	if (skb->sk) {
> +		/*
> +		 * The reference is held for as long as skb->sk is set, taken
> +		 * in netlink_skb_set_owner_r() and dropped here.  The pointer
> +		 * is left in place: do_one_broadcast() orphans an skb one
> +		 * listener owned and hands it to the next, which takes its
> +		 * own reference, and the sender's scm_cookie keeps the pid
> +		 * alive across the whole broadcast.
> +		 */
> +		put_pid(NETLINK_CB(skb).pid);
>  		sock_rfree(skb);
> +	}
>  }
>  
>  static void netlink_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
>  {
>  	WARN_ON(skb->sk != NULL);
> +	NETLINK_CB(skb).pid = get_pid(NETLINK_CB(skb).pid);
>  	skb->sk = sk;
>  	skb->destructor = netlink_skb_destructor;
>  	sk_mem_charge(sk, skb->truesize);

[Severity: Critical]
NETLINK_CB() is just an overlay on skb->cb, the 48-byte scratch
area that every layer an skb passes through is allowed to reuse.
Until now netlink only parked plain values and one non-refcounted
struct sock *sk there, so a clobbered cb cost at most wrong
metadata. After this patch the cb holds the *only* reference to a
struct pid for as long as the skb is owned by a receiver, and
netlink_skb_destructor() consumes it. If anything rewrites those
eight bytes between netlink_skb_set_owner_r() and the destructor
running, put_pid() executes refcount_dec_and_test() and
kmem_cache_free() on whatever now sits at that offset; the mirror
case, cb overwritten before the destructor, silently leaks the pid.
Storing destructor-needed state in skb->cb is the pattern the
networking guidance calls out precisely because the read side runs
long after the write side.

What establishes the invariant that the cb is untouched for that
whole window? For an skb parked in a netlink socket's
sk_receive_queue I believe nothing else writes cb, but the patch
adds no assertion or comment saying that, and netlink skbs do get
handed to other code: __netlink_deliver_tap_skb() clones into
dev_queue_xmit(), and netlink_skb_clone() callers such as
nl_fib_input() and nfnetlink_rcv_batch() pass clones on. Those
clones copy the pointer verbatim through __copy_skb_header() while
__skb_clone() clears skb->sk and skb->destructor, so today no
put_pid() runs on them - the safety comes from the clone never
being re-owned, not from anything the new code enforces.
netlink_skb_set_owner_r() does get_pid() on whatever byte pattern
it finds in the cb, with no way to tell a live pointer from
leftovers.

Could the reference be tied to something with a defined lifetime
instead? Taking it in netlink_sendmsg() when the cb is written, and
dropping it on every skb-free path rather than only when skb->sk
happens to be set, would at least make the ownership match the
skb's lifetime rather than the sk/destructor pairing. If keeping
the pointer in cb is the intent, please state in the commit message
which paths may see an skb with a live pid in NETLINK_CB and why no
layer on those paths rewrites cb offset 40.

Unrelated but adjacent: adding a pointer makes struct
netlink_skb_parms fill the cb exactly on 64-bit. Did you check it
against the BUILD_BUG_ON in netlink_proto_init(), and is leaving
zero slack in a shared scratch area something we want to do for a
stable backport?

[Severity: Medium]
Is it intentional to leave the pointer in the control block after
put_pid(), given that netlink_skb_set_owner_r() then does get_pid() on
whatever it finds there without any validation?

The drop-then-re-acquire window exists in tree, in do_one_broadcast():

	if (p->skb2 == NULL) {
		if (skb_shared(p->skb)) {
			p->skb2 = skb_clone(p->skb, p->allocation);
		} else {
			p->skb2 = skb_get(p->skb);
			/*
			 * skb ownership may have been set when
			 * delivered to a previous socket.
			 */
			skb_orphan(p->skb2);
		}
	}

skb_orphan() runs netlink_skb_destructor(), which drops the reference the
previous listener took, and the next listener re-increments the same
pointer through netlink_broadcast_deliver()->netlink_skb_set_owner_r().

The only thing keeping that get_pid() off a freed struct pid is a
reference in a different stack frame, scm.pid in netlink_sendmsg(),
released by scm_destroy() after both netlink_broadcast() and
netlink_unicast() have returned. Nothing in the exported entry points
(netlink_unicast(), netlink_broadcast(), netlink_broadcast_filtered())
expresses or checks that invariant, and skb_clone()/skb_copy()/
netlink_skb_clone() copy the cb, and therefore the bare pid pointer,
verbatim via __copy_skb_header(). netlink_trim() has the same shape: it
clones a shared skb and consume_skb()s the source before the clone is
re-owned, guarded only by the WARN_ON(skb->sk != NULL) above.

I could not construct a path that is live today: other senders use freshly
allocated skbs whose cb is zeroed, and the netlink_skb_clone() users I
looked at, nl_fib_input() and nfnetlink_rcv_batch(), run synchronously
while the origin skb still owns its reference. Still, would setting

	NETLINK_CB(skb).pid = NULL;

after put_pid() be preferable? A re-owned skb would then report pid 0,
which is the value the changelog already describes as acceptable for
"unknown". Alternatively, taking the reference at send time the way
unix_scm_to_skb() does would match what the changelog says is being
imitated.

> @@ -1880,6 +1891,13 @@ static int netlink_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>  	NETLINK_CB(skb).dst_group = dst_group;
>  	NETLINK_CB(skb).creds	= scm.creds;
>  	NETLINK_CB(skb).flags	= netlink_skb_flags;
> +	/*
> +	 * Borrowed here.  scm_destroy() below drops the scm_cookie's own
> +	 * reference, and every delivery in between is synchronous, so the
> +	 * pointer stays valid until netlink_skb_set_owner_r() takes a
> +	 * reference of its own.
> +	 */
> +	NETLINK_CB(skb).pid	= scm.pid;
>  
>  	err = -EFAULT;
>  	if (memcpy_from_msg(skb_put(skb, len), msg, len)) {

[ ... ]

> @@ -1971,7 +1989,15 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		netlink_cmsg_listen_all_nsid(sk, msg, skb);
>  
>  	memset(&scm, 0, sizeof(scm));
> -	scm.creds = *NETLINK_CREDS(skb);
> +	/*
> +	 * Render the sender's pid in the reader's pid namespace, the way
> +	 * unix_skb_to_scm() does through scm_set_cred().  A NULL pid gives 0,
> +	 * so a control block that lost its reference reports "unknown" rather
> +	 * than the sender's own untranslated number.  scm_recv() below drops
> +	 * the reference taken here on both of its paths.
> +	 */
> +	scm_set_cred(&scm, NETLINK_CB(skb).pid, NETLINK_CREDS(skb)->uid,
> +		     NETLINK_CREDS(skb)->gid);

[Severity: Low]
Two of the comments this patch adds seem to describe a model the code does
not implement.

First, this comment says "A NULL pid gives 0, so a control block that lost
its reference reports 'unknown'". Which code produces that NULL? The
destructor added a few lines above states the opposite and keeps the
pointer:

	/*
	 * ... The pointer
	 * is left in place: do_one_broadcast() orphans an skb one
	 * listener owned and hands it to the next, ...
	 */
	put_pid(NETLINK_CB(skb).pid);

So a control block that "lost its reference" holds a stale non-NULL
pointer, not NULL, and scm_set_cred() would call get_pid()/pid_vnr() on
it. Should the two comments be reconciled?

Second, the netlink_sendmsg() comment says "every delivery in between is
synchronous". Does that hold for the tap path?

	__netlink_deliver_tap_skb()
		nskb = skb_clone(skb, GFP_ATOMIC);
		...
		ret = dev_queue_xmit(nskb);

__skb_clone() copies the full 48-byte cb, so the borrowed pid pointer
comes along while nskb->sk and nskb->destructor are cleared and no
reference is taken. dev_queue_xmit() can then leave the clone in an
AF_PACKET receive queue via dev_queue_xmit_nit(), or in a qdisc attached
to the nlmon device with transmission deferred to net_tx_action(), both of
which can outlive sendmsg() and the scm_destroy() that drops the sender's
only reference. The escaping copy is not overwritten by those layers,
since qdisc_skb_cb and PACKET_SKB_CB stay within the first ~28 bytes of
cb while pid sits at cb offset 40 on 64-bit.

No current consumer dereferences that escaped pointer, so this is a
comment accuracy question rather than a runtime bug, but the prose
invariant is what a later change would build on. Would it be clearer to
state the invariant that actually holds, namely that an skb only reaches
netlink_recvmsg() after netlink_skb_set_owner_r() gave it its own
reference, and that while borrowed the liveness comes solely from the
scm_cookie on netlink_sendmsg()'s stack?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904144636.3443342-1-maoyixie.tju%40gmail.com
