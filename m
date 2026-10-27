Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793065145;
	b=0SKpeeQubxfJXG+LQhqgWdGjb7jRLQePfyJwTmJNL+EezZueHQSuvL3eI2KXC9MlCx7V
	 wuef5bs7erXp+BxqsfHFsRA0Q8UbrZPKwF5XCZbRPgaCy0EdEZyDLhf2fm9z0saeS0efV
	 2wcl7UUNgKuy4G1/SBmf3AVO9dvgpUqTCh+ux9V+KiUAwi6hFevCGMFqbC0h7tc6P3Kqf
	 ap0f6FrB9TH/af/J/soyQUiD/8DGvYLJRjOLYwjydjQjfzG0cmBbnx08YHR8XXoFE+vXz
	 f7rJsPXoMaHURrN/fkW4NDu1tOios+ETGhvSxHRQ535GwrCsgXiTNjgno6I5Dev3Www==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=owcLOhT6B0L2zpFJ4qxJtIChKYa9NbwHdfmuwcKI1W4=;
	b=ZcTBZiGvfBVXbkNetbqvPSdIiGtDaiXu6Hmhkvs03Xrd64BK/sMaAR5K13CN65E6yhUq
	 PXPFYCbgnFREt9pDBSEXLfikgT/ZJxFVNevKQmo9GNbH9kKKmZI+qfgWKBGxgA1Ikt3Lu
	 OCobPp56cwTr6afUbfNEx8BvN3dGsuAQTSqQwzJj0t2w8wd9z/E5dRX9tQj9OMxU44e5P
	 acnsUbQn/GAkV9+6KYL27/QJz9KnjJa5Rc9iBkqJ/z9MbUE7Qk18fMsLdb6LjZr5ZQ2/M
	 UknIfLg/7NZFluTh5OQisdlYcuw/9KkvSqiSiF1AMOng2ZAT+pBljEloSUcwQxbjYig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jyKJp91J;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3B3606A322
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C3B3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jyKJp91J
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d5dbso2942279a91.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793065144; x=1793669944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=owcLOhT6B0L2zpFJ4qxJtIChKYa9NbwHdfmuwcKI1W4=;
        b=jyKJp91JHYvS4A6WBfuKZN3xtn3dP0T9loAQXVU/ZVThikKdjIPq/igAKxy7Q7FuHi
         XjC9rSPJxnJMP8kbQbA77heSZgayVuXtVYKoGxlNn74xaTm3h/IDmXDKfF73ekrkHXyB
         d/5e+T2/zsMOb4m5aQMWHAm5/tgRe3W3aa8DVKDubO3KseCtLDEu4jINSZdW4dgdZ5N8
         jBcZNVVxGXzKmZ45aPJ7mZ6VQffWDkV+sURnKwk8csyt1A7p0yB7UnH5r3U3e911HcPe
         YTIsjc0lIhxxyflwE7K0AxgleXDW+cSQ7K1kOxMIEsCCUPtTb+RyTgPO1YnDqPL0ge3i
         ejBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793065144; x=1793669944;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owcLOhT6B0L2zpFJ4qxJtIChKYa9NbwHdfmuwcKI1W4=;
        b=fYvNJu1KGSIFOGhB6li3DtfIV5ryR2ra3sRHfJMZGwkPEIxd0MJlQn3NOj5nZ8hjp/
         yKh7omgE1dQTFEWSSGhDLF4LTY1JK5ND5UqyAcSgzKDPFg154v4ChDJ0KnytmbF2q4QM
         C9ZSN273QqQMTRIU8bUsPCc07e5Ij6btG4MKLX8XHbL4b5a8aIWP96TlZ0qGBwdF7H3b
         AyDrxvtQvUG9HxNshkNFzdEJPPF6OIg5daRilVHFgZ4GAsmPq7RR0gaM1dvtBZy0NAn5
         DUjCNSoqqiuvuwVej/IMRIqW6rBcJg8VRJ4lbCyeGgTgz0x/Zn+REh018YE0VVSYFCRU
         jrfA==
X-Forwarded-Encrypted: i=1; AKwUvByL7qyjtOaecE/5WKDi7sJ6H7opwJwPS1UQVxwMmlsZUWetMZSjH6+bwnpoirawY/tqb4MqA4E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEoSlpYQDcUor8u9SOmebTGtbDIuoGcSvT7a1NpqsbXY3PVQVe
	vRjwpnWWrIJrMIq8QxF+QlPSVdbR1G0boOZe0zQ54DTNtAeJ0Wxihbvks0UUR/nD7Lb/RWRct7R
	+ZPwiag==
X-Received: from plfn3.prod.google.com ([2002:a17:902:e543:b0:2e4:ad81:3a9d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fc8:b0:3ab:5758:3757
 with SMTP id 98e67ed59e1d1-3adeafafbe9mr6357800a91.61.1793065144281; Mon, 26
 Oct 2026 18:39:04 -0700 (PDT)
Date: Tue, 27 Oct 2026 01:39:03 +0000
In-Reply-To: <179306162016.3134.9236911749193166053@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023003750.1133904-1-user148783812897@gmail.com> <179306162016.3134.9236911749193166053@kernel.org>
Message-ID: <auAANdRqePrBiCHG@google.com>
Subject: Re: [PATCH net] net: limit priority VLAN untag depth
From: Kuniyuki Iwashima <kuniyu@google.com>
To: netdev-bot+sashiko@kernel.org
Cc: user148783812897@gmail.com, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 00:40:20 +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [High] The commit message promises a per-packet bound, but the patch
>   only bounds one pass through __netif_receive_skb_core()=E2=80=A6
>=20
> --
>=20
> net: limit priority VLAN untag depth
>=20
> This patch adds a vlan_depth counter to the VID 0 retry branch in
> __netif_receive_skb_core(). Once VLAN_MAX_DEPTH tags have been consumed,
> the packet is dropped. The aim is to stop repeated skb_vlan_untag() calls
> from wrapping the 16-bit network and transport header offsets.
>=20
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index e76762e29360e..b40efea27dc29 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6198,6 +6198,8 @@ static int __netif_receive_skb_core(struct sk_buf=
f **pskb, bool pfmemalloc,
> >  	}
> > =20
> >  	if (unlikely(skb_vlan_tag_present(skb)) && !netdev_uses_dsa(skb->dev)=
) {
> > +		unsigned int vlan_depth =3D 1;
> > +
> >  check_vlan_id:
> >  		if (skb_vlan_tag_get_id(skb)) {
> >  			/* Vlan id is non 0 and vlan_do_receive() above couldn't
> > @@ -6209,6 +6211,10 @@ static int __netif_receive_skb_core(struct sk_bu=
ff **pskb, bool pfmemalloc,
> >  			 * 802.1Q or 802.1AD and vlan_do_receive() above could
> >  			 * not find vlan dev for vlan id 0.
> >  			 */
> > +			if (unlikely(vlan_depth >=3D VLAN_MAX_DEPTH))
> > +				goto drop;
> > +
> > +			vlan_depth++;
> >  			__vlan_hwaccel_clear_tag(skb);
> >  			skb =3D skb_vlan_untag(skb);
> >  			if (unlikely(!skb))
>=20
> [Severity: High]
>=20
> Does this limit the number of tags removed per packet, or only per pass
> through __netif_receive_skb_core()?
>=20
> vlan_depth is declared inside the if block, so it goes back to 1 every
> time processing jumps to another_round. The VID 0 branch itself leaves
> through another_round when the inner tag matches a VLAN device:
>=20
> 			if (vlan_do_receive(&skb))
> 				/* After stripping off 802.1P header with vlan 0
> 				 * vlan dev is found for inner header.
> 				 */
> 				goto another_round;
>=20
> A TC ingress peer redirect also restarts the round on the same skb, and
> skb->data does not change:
>=20
> net/core/dev.c:sch_handle_ingress() {
>     ...
> 	__skb_push(skb, skb->mac_len);
> 	if (skb_do_redirect(skb) =3D=3D -EAGAIN) {
> 		__skb_pull(skb, skb->mac_len);
> 		*another =3D true;
> 		break;
> 	}
>     ...
> }
>=20
> With BPF_F_PEER, skb_do_redirect() calls skb_scrub_packet(), sets skb->de=
v
> to the peer in the other netns, and returns -EAGAIN. skb_scrub_packet()
> leaves vlan_all alone, and nothing in this cycle counts iterations.
>=20
> Here is one example setup. A veth pair is split across two netns. Each en=
d
> has a VID 100 VLAN device and no VID 0 device. Each VLAN device has an
> ingress BPF program that calls bpf_redirect_peer() on its lower veth. A
> frame carrying repeated [VID 0, VID 100] tag pairs could then cycle like
> this:
>=20
>   vethA: VID 0 branch untags the next VID 100 tag (vlan_depth =3D=3D 2)
>   vlan_do_receive() finds vlan100A -> goto another_round
>   top-of-round skb_vlan_untag() strips the next VID 0 tag
>   TC on vlan100A peer-redirects to vethB -> another_round
>   vethB: VID 0 branch starts over with vlan_depth =3D=3D 1
>   ...
>=20
> The same loop also seems possible with VID 100 tags alone. That version
> goes through the earlier vlan_do_receive() -> goto another_round before
> rx_handler and never reaches the patched branch.
>=20
> Each round, skb_vlan_untag() calls skb_reset_network_header():
>=20
> include/linux/skbuff.h:skb_reset_network_header() {
> 	long offset =3D skb->data - skb->head;
>=20
> 	DEBUG_NET_WARN_ON_ONCE(offset !=3D (typeof(skb->network_header))offset);
> 	skb->network_header =3D offset;
> }
>=20
> After about 16K tags the 16-bit offset wraps. That is the out-of-bounds
> condition the commit message describes.
>=20
> Would it work better to put the bound inside skb_vlan_untag() itself, for
> example on the header offset or the headroom? Another option is a depth
> count that survives another_round.

I have a complimentary patch that implements the latter,
and this change itself looks good to me.


>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261023003750.1133904-1-user148783812897%40gmail.com
