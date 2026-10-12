Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295449B5C2
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819211; cv=none; b=DO0pVlC52+p4LDiIr3guUWPBMYFWuh+Y+j0TjZslrv4vPlV+jOqqANWgKIK2VGzM6MFON6AeDNp/FyPurJjGVcKfWyzSDxTvq/SoaCeqSMhynpoEj0NyCW14n4UbzSFj9aZyI893oFkwHgByRheOePuA3jHMLYU/QCn+Ql3isYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819211; c=relaxed/simple;
	bh=QKyIDWs4Yg0YOBXKbAJ/BZSzK06X3AdXprSE+BcPPcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIrnoCUwVD38CNPmRNFjYqwSa7jrfKk84BxJ+6xq/5UH0Z3Ao4hW+zBXmWRNuldyVJwstR5loU6yFtYSXCV1BVqBq/SezhSnwTcN7YMLc7ZQRelaeKwnU64X83dtXhyQQJUOeou1F4wi7xwWLSNjaLswTxjybSZ0DD+8KJzQpGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gtv1tFsz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PVsqozTQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gtv1tFsz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PVsqozTQ"
Date: Mon, 12 Oct 2026 17:33:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791819206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1osWiF4wkmuhqxvwGegPz+/CYWT5ehZKYMUCxnJOcmQ=;
	b=gtv1tFszEaGRSl0kRr7yd3aYByuAhexPAVDcF9P5Gf6OOpyKtSwlwOD3q3Kf2dC1V2l+8d
	k13XHcAPrvLh/r0tWFvHdo1p7XX1knRtksqHJAHS1hfvnKcOvpNd1ltKWkSvXc5QkK70tT
	lOEbDCyVYKxCXdXyf1CNm2OEwnuu3tDMcrBdnnVGO4kUV/cJ1vVpDHia4zO6Va2kv3bP4h
	YLxJe/B76waOMQhLxvTpx59qVVk9MjdmaU9Q07EkZoLbNkTVcxKeM1t8wGV1+/nsB4xCxF
	28Afthuqpl/MwYCsufszY5Y8RxsSqpaoZsLKGBDo0g4G3RQ7isfynQJs3nr51A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791819206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1osWiF4wkmuhqxvwGegPz+/CYWT5ehZKYMUCxnJOcmQ=;
	b=PVsqozTQJBHJsqkaPvRfv08QW/oxVcsRyv0fAkfhwd2Y31hZk51rE2XwDyT3DU1NOwx9RK
	g59+f2engnF/p/Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
	c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com,
	davem@davemloft.net, edumazet@google.com, fmaurer@redhat.com,
	kuba@kernel.org, neelima@ti.com, pabeni@redhat.com, praneeth@ti.com,
	pratheesh@ti.com, richardcochran@gmail.com, horms@kernel.org,
	vigneshr@ti.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v8 6/8] hsr: Assign a socket for cloned skbs
Message-ID: <20261012153324.fsnDpWZy@linutronix.de>
References: <20261002-hsr_ptp-v8-6-60dabc07e554@linutronix.de>
 <179129708052.434549.14508967433709198337@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <179129708052.434549.14508967433709198337@kernel.org>

On 2026-10-06 14:31:20 [+0000], netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> Could the commit message say that this only covers port-directed PTP
> frames?
>=20
> hsr_create_tagged_frame() only assigns the socket when
> frame->req_tx_port !=3D HSR_PT_NONE. hsr_dev_xmit() only moves tx_port aw=
ay
> from HSR_PT_NONE for ETH_P_1588 frames that carry the inline HSR header.
> The has_foreign_header path in hsr_forward_do() also needs a port.
>=20
> Other traffic that asks for TX timestamps still reaches the slaves as
> clones with skb->sk =3D=3D NULL. One example is a UDP socket using
> SO_TIMESTAMPING over hsr0. For those clones, __skb_tstamp_tx() returns
> early:
=E2=80=A6
UDP timestamping is not a thing here (in HSR).

> The restriction looks deliberate, since it avoids one timestamp per slave
> and double charging. The message, though, reads as if it applies to all
> cloned skbs.
>=20
> The message also leaves out the side effects of skb_set_owner_w(). The
> clone is now charged to the sender's sk_wmem_alloc, and its skb->hash and
> ooo_okay now come from the socket.

Right. None of this should have an impact that should be mentioned
explicitly. The primary motivation is the timestamp information which
requires the socket.
The accounting for sk_wmem_alloc happens, too. The original skb is freed
early.

> > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > index 562802ddff003..46f9bd5039821 100644
> > --- a/net/hsr/hsr_forward.c
> > +++ b/net/hsr/hsr_forward.c
>=20
> [ ... ]
>=20
> > @@ -348,6 +349,9 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_=
frame_info *frame,
> >  	if (!skb)
> >  		return NULL;
> > =20
> > +	if (frame->req_tx_port !=3D HSR_PT_NONE && frame->skb_std->sk)
> > +		skb_set_owner_w(skb, frame->skb_std->sk);
> > +
> >  	if (port->dev->features & NETIF_F_HW_HSR_TAG_INS)
> >  		return skb;
> > =20
>=20
> [Severity: High]
> Does the timestamp still get lost on PRP devices?
=E2=80=A6

Not really. PTP+PRP is a bit different compared to PTP+HSR. According to
the specification, there is no PRP header attached to PTP message (where
we would need Kernel's sequence number for the packet and so on).
Therefore for the PRP case the prp0 device isn't used but the interface
of the underlying slave device.

> [ ... ]
>=20
> > @@ -581,6 +585,8 @@ static void hsr_forward_do(struct hsr_frame_info *f=
rame)
> >  		 */
> >  		if (frame->has_foreign_header && frame->skb_std) {
> >  			skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
> > +			if (skb && frame->skb_std->sk)
> > +				skb_set_owner_w(skb, frame->skb_std->sk);
> >  			goto inject_into_stack;
> >  		}
>=20
> [Severity: Medium]
> Is it safe to call skb_set_owner_w() here, and in
> hsr_create_tagged_frame(), without checking how the original skb holds
> skb_std->sk?
>=20
> skb_set_owner_w() adds the clone's truesize to sk->sk_wmem_alloc. It does
> not take an sk_refcnt reference. That is fine when the original skb is
> owned through sock_wfree, which is the usual AF_PACKET case, because that
> charge keeps the socket alive. For comparison, skb_clone_sk() calls
> refcount_inc_not_zero() on sk_refcnt.
>=20
> An egress skb can carry a socket that nothing pins, though.
> bpf_sk_assign() at TC ingress does:
>=20
> 	skb->sk =3D sk;
> 	skb->destructor =3D sock_pfree;
>=20
> It takes no reference for SOCK_RCU_FREE sockets. The tcx ingress redirect
> path and __bpf_tx_skb() do not orphan the skb before dev_queue_xmit().
> hsr_dev_xmit() accepts any ETH_P_1588 skb with the inline magic,
> whatever its destructor.
>=20
> Suppose that socket is being closed at the same time and sk_wmem_alloc
> has already reached zero. Could skb_set_owner_w() then add to a zero
> refcount? After the clone leaves the RCU section through the slave qdisc
> or driver, could its sock_wfree() touch the freed socket?
>=20
> Triggering this needs CAP_BPF or CAP_NET_ADMIN and a narrow close race,
> and the full race has not been shown in practice.
>=20
> Would it make sense to transfer ownership only when
> frame->skb_std->destructor =3D=3D sock_wfree, like the copy_dtor check in
> UDP GSO? ip_frag_next() calls skb_set_owner_w(skb2, skb->sk)
> unconditionally, so similar exposure exists elsewhere in the kernel.

That skb arrives from the user on that socket so this skb holds a
reference on that socket. That original skb is returned to the stack
after the skb_set_owner_w() so none of this should happen.

Sebastian
