Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9D2244692;
	Wed,  9 Sep 2026 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788923811; cv=none; b=nf9/05f9RoFWIvHoit8LMKyFSmhFaFMMaKbO5ggVEUsz8whrfPniO1Lgj7BWrg/qucEbfXiBoC3481aS9eprhGqfAV38zUTyszYtkH9pJifpYIShbmEU594wMj3V3pORFA0Fpf2aXNr0adBquDMOMmfxFlwB/T0TUB9At9L3CL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788923811; c=relaxed/simple;
	bh=0U5hTNbyEeUK7kGjvfosGTLRrTM1il3C+BTfhlqktkk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHcn2MRubK5Y8GDc2tk5rdAZP4dbkX7ObbL2mBa/YEd6KmkC2DSHgmokNiVagG03InOol25oEYsWydg98oifcwIouBE5pmFNZX09jXUxAXOmBe9wVta0AqqFXtt/mv2uwdshPx5BbmOYdt/EGv2p5FPyyyBlVQyVp/YmLu86Bbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH71/6YD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH71/6YD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1299E1F00A3A;
	Wed,  9 Sep 2026 03:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788923809;
	bh=nOyPhUUjOAGK/f5eBS9tgcpfUcHH4ikyW2r5eX5Wc5w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FH71/6YD03qNfPHstms2cqVsk8oQc7Qiu1358ex4uMwjFAGRvsXvQhB66aXd0aKwL
	 JUc4lY2rTdHKQiUuBNnT1DhUPw2hG43sskaqpZlULmD5gEF1UKPph7ZvjkIASrQCiY
	 UsMNYEeqwH187uJchKWwf0Tbu+C+1Nsa8q+Xi0mdCZ1ymWyzKS4Xgw+1NVb7dSEiB+
	 C3yFw0rlTTgdipKENh/rYdeMNVhcFI1RMSwRJJcXY+wP6FauuJw/o8kH0GXSSU9mdC
	 CFm/dny9ANUK/BH769cRDjwOF2aeWw5VRiRQfQBW/mIBFXsH7BJoM9F+iHdkjFPZXh
	 gylU2IGCsIlFw==
Subject: Re: [PATCH] udp_tunnel: avoid calling the wrong GRO handler
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 03:16:48 +0000
Message-ID: <178892380854.219967.4849169204627691045@kernel.org>
In-Reply-To: <20260906211351.1272699-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260906211351.1272699-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

- [High] Incomplete fix: the patch removes the static-call dispatch but
  leaves the root cause named in its own commit message untouched.
- [Medium] The patch deletes the only reader of the static call and of
  the static key but leaves the entire producer side in the tree.

Pre-existing issues:
- [High] By making `udp_tunnel_gro_rcv()`
  (net/ipv4/udp_offload.c:147-152) the unconditional dispatch path, the…

--

udp_tunnel: avoid calling the wrong GRO handler

This drops the static-call fast path from udp_tunnel_gro_rcv() so that
dispatch always goes through call_gro_receive_sk() with the per-socket
gro_receive handler.  The changelog argues the static call can point at
another tunnel type's handler while setup_udp_tunnel_sock() is still
publishing the handlers on an already bound socket.

> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index cf07c3c6611a2..30649f407a788 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -148,13 +148,6 @@ static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
>  					  struct list_head *head,
>  					  struct sk_buff *skb)
>  {
> -	if (static_branch_likely(&udp_tunnel_static_call)) {
> -		if (unlikely(gro_recursion_inc_test(skb))) {
> -			NAPI_GRO_CB(skb)->flush |= 1;
> -			return NULL;
> -		}
> -		return static_call(udp_tunnel_gro_rcv)(sk, head, skb);
> -	}

[Severity: High]
Does this actually close the window described in the changelog?  The
commit message says:

    setup_udp_tunnel_sock() installs the GRO handlers before updating the
    global static call. The socket is already bound, so packets can arrive
    while the static call still points to the handler for another tunnel
    type.

but setup_udp_tunnel_sock() in net/ipv4/udp_tunnel_core.c is not touched
here, and it still publishes the handler pair with two independent plain
stores on a socket that GRO can already find:

	udp_sk(sk)->gro_receive = cfg->gro_receive;
	udp_sk(sk)->gro_complete = cfg->gro_complete;

	udp_tunnel_encap_enable(sk);

	udp_tunnel_update_gro_rcv(sk, true);

udp4_gro_receive() looks the socket up as soon as the global
udp_encap_needed_key is on, which any other encap socket in the system
already guarantees:

	if (static_branch_unlikely(&udp_encap_needed_key))
		sk = udp4_gro_lookup_skb(skb, uh->source, uh->dest);

So a packet arriving in that window can be aggregated by the tunnel
gro_receive while gro_complete is still NULL, and udp_gro_complete() then
takes the plain-segment branch:

	if (sk && udp_sk(sk)->gro_complete) {
		...
		skb->encapsulation = 1;
		err = udp_sk(sk)->gro_complete(sk, skb,
				nhoff + sizeof(struct udphdr));
	} else {
		err = udp_gro_complete_segment(skb);

Since both stores are plain, the opposite order is permitted too, so
udp_gro_complete() can observe a non-NULL gro_complete for an skb that was
aggregated as plain UDP, set skb->encapsulation and derive inner offsets
from packet bytes.

Isn't that the same "receive and completion can then parse the packet
differently" case the changelog claims to remove?  Would ordering the
publication of the handler set before the socket becomes GRO-reachable, or
fixing the setup ordering itself, be the fix that is needed here instead?

>  	return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but making this the only
dispatch path widens where it can be hit.  udp_sk(sk)->gro_receive is
validated once in udp_gro_receive():

	if (!sk || !udp_sk(sk)->gro_receive) {

and then re-read here for the indirect call, with no lock and no
READ_ONCE() pinning the value between the two loads.  call_gro_receive_sk()
in include/net/gro.h invokes cb(sk, head, skb) unconditionally after the
recursion test, so a NULL observed on the second load is called.

Can the field go NULL between those two loads?  gtp_encap_enable_socket()
in drivers/net/gtp.c passes an already bound user socket with

	struct udp_tunnel_sock_cfg tuncfg = {NULL};

and l2tp_tunnel_register() in net/l2tp/l2tp_core.c likewise passes a cfg
with no gro_receive, so setup_udp_tunnel_sock() stores NULL over whatever
was there.  The only admission check on those paths is
sk->sk_user_data == NULL, and the setsockopt(UDP_GRO)+setsockopt(UDP_ENCAP,
UDP_ENCAP_ESPINUDP) path in net/ipv4/udp.c installs
xfrm4_gro_udp_encap_rcv without setting sk_user_data.  A GRO softirq on
another CPU that already passed the check in udp_gro_receive() would then
call through NULL.

The same double read also means the handler invoked need not be the one
that was validated, which races with the annotated writer in
set_xfrm_gro_udp_encap_rcv():

			WRITE_ONCE(udp_sk(sk)->gro_receive, new_gro_receive);

Before this change the single-registered-type configuration went through
static_call(udp_tunnel_gro_rcv) and never re-read the socket field, so this
was only reachable with two or more registered tunnel types.  Should
udp_tunnel_gro_rcv() load the pointer once into a local with READ_ONCE()
and check it there?

[Severity: Medium]
With the static-call dispatch gone, is anything left that reads the static
call or the static key?  net/ipv4/udp_offload.c still carries
dummy_gro_rcv(), DEFINE_STATIC_CALL(udp_tunnel_gro_rcv, dummy_gro_rcv),
DEFINE_STATIC_KEY_FALSE(udp_tunnel_static_call), udp_tunnel_gro_types[],
UDP_MAX_TUNNEL_TYPES, udp_tunnel_gro_type_lock and the whole refcount
bookkeeping in udp_tunnel_update_gro_rcv(), including:

	if (udp_tunnel_gro_type_nr == 1) {
		static_call_update(udp_tunnel_gro_rcv,
				   udp_tunnel_gro_types[0].gro_receive);
		static_branch_enable(&udp_tunnel_static_call);
	} else if (old_gro_type_nr == 1) {
		static_branch_disable(&udp_tunnel_static_call);
		static_call_update(udp_tunnel_gro_rcv, dummy_gro_rcv);
	}

udp_tunnel_update_gro_rcv() is still exported and still called on every
tunnel socket add and remove from setup_udp_tunnel_sock() and from
udp_tunnel_cleanup_gro() in include/net/udp_tunnel.h, so each setup and
teardown still takes the global mutex and triggers text patching for state
that nothing consumes.

The remaining comments no longer match the code either, for example:

	/*
	 * Dummy GRO tunnel callback, exists mainly to avoid dangling/NULL
	 * values for the udp tunnel static call.
	 */

	/* Check if the static call is permanently disabled. */

	/* Ensure static call will never be enabled */

And the two arms of the CONFIG_NET_UDP_TUNNEL split are now identical:

	#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
	...
	static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
						  struct list_head *head,
						  struct sk_buff *skb)
	{
		return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
	}

	#else

	static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
						  struct list_head *head,
						  struct sk_buff *skb)
	{
		return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
	}

	#endif

Should the producer side be retired in the same patch, effectively
reverting 5d7f5b2f6b93, so the config split and the comments stop
describing machinery that has no consumer?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906211351.1272699-2-Jeremy.Jean%40oss.cyber.gouv.fr
