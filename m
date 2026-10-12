Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C84A6CC0
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820810; cv=none; b=hjWR/tQVVERJcCVpHjuLQiX8jOV8irk4KOwEs1PWNrBaUUCj6QUehdZsPZRp8J6LpqKPcbVnUseRVZdjoqAUARj10k/ZbdQ333scwDvkzGTmsoqk1YRG+pXZIykmCZoHmKUdK3FQAfyRyV+6IVEYmSE81XdCs1N2WeJb3ONp1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820810; c=relaxed/simple;
	bh=u1T3ZxFN4M7y05bKMmxwrpjs0/x8MDNHyo8Lkwy9YKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvrHuIamOFQZdH6xTXhIm1NKMjtxkNX+cVQoCevq8kZkUtry1yPGRhJThz6OCwCQIFIbfPhb8U9ruHBpEt/PN8itVHG9/nY8Fa1290YGiOb7Aq2gWxP0iGULqZFRD9xV41+KqB9aO9Ptool8dm/pgg9pYzbDfpW0BCbUjGGsXeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CcALxnzq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yKM3gX4q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CcALxnzq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yKM3gX4q"
Date: Mon, 12 Oct 2026 18:00:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791820807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4E2tdX254QmdVDFQRZdSU4XKuoTDXfaGKCZHZMT8Ns0=;
	b=CcALxnzqwR3PyiaX9nbegSrQNkzZB9VVbhU8PMIw/+iyshHy0HMc/rMiDkSHmq1zku4Smo
	ryfoBwbEXVHN8K+0RxnXUG1pL6kb9FHKzCCcRy79Fk/vKoGiy2AX3AGtzx25Heh9VkEgUu
	Zkbt+Rwkj3G4bQBwk8a+uGaFNY2mBIN7G/+swnS99vvaUxXnBWQshPl51kKT+vac7Wlowq
	LvEBNu2VWY12Sf2/fZYWRfg6uWDJyKSihwVMkxcfqXoDPrx0G5ENRvQ4b6E/j/wpCyim/9
	s7CfKZ/ZgjilRKGR05jqoDzSm/usLaXj30AG9OslHZoPwi/Tl9BRqVNu1vg5Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791820807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4E2tdX254QmdVDFQRZdSU4XKuoTDXfaGKCZHZMT8Ns0=;
	b=yKM3gX4qhrDuHaCHsvkRwpw7MnQwSP1QfaPTOxdo4K4cZYSjAojy1j5Vvt2ClQcI3QEH4i
	3Y6Bp6f2Fk/CJLDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
	c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com,
	davem@davemloft.net, edumazet@google.com, fmaurer@redhat.com,
	kuba@kernel.org, neelima@ti.com, pabeni@redhat.com, praneeth@ti.com,
	pratheesh@ti.com, richardcochran@gmail.com, horms@kernel.org,
	vigneshr@ti.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v8 2/8] hsr: Use skb_clone() while adding the
 HSR header
Message-ID: <20261012160005.3Lcx_XLP@linutronix.de>
References: <20261002-hsr_ptp-v8-2-60dabc07e554@linutronix.de>
 <179129707396.434549.16689509180703800541@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <179129707396.434549.16689509180703800541@kernel.org>

On 2026-10-06 14:31:13 [+0000], netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> Each per-slave skb now keeps SKBTX_HW_TSTAMP, SKBTX_SW_TSTAMP,
> SKBTX_SCHED_TSTAMP and tskey in its shinfo. However, __skb_clone() leaves
> it without an owning socket:
=E2=80=A6
> Will a slave driver with hardware timestamping enabled now take a TX
> timestamp for this clone, only for __skb_tstamp_tx() to discard it?

Yes. There is a patch later in this series where a socket is assigned.

=E2=80=A6
> Before this patch, __pskb_copy() did not carry these flags over on the
> software path, so the slaves never saw these requests. Some NICs have only
> a single in-flight TX timestamp slot. On those, a concurrent PTP request =
on
> the same slave might be skipped.
>=20
> The later patch "hsr: Assign a socket for cloned skbs" calls
> skb_set_owner_w() only when frame->req_tx_port !=3D HSR_PT_NONE. Ordinary
> traffic sent over hsr0 by a socket with SOF_TIMESTAMPING_TX_HARDWARE would
> still reach this through:
>=20
> hsr_dev_xmit()->hsr_forward_do()->hsr_create_tagged_frame()->
>     hsr_xmit()->dev_queue_xmit()
>=20
> The NETIF_F_HW_HSR_TAG_INS path already sent sk-less clones like this
> before the patch. Should the timestamp request flags be cleared on clones
> that have no socket attached?

No. If there is no socket, it gets dropped. If there the HW is capable
of concurrent PTP request then the user shouldn't ask for them. We
didn't have PTP timestamps before.

> >  	if (!skb)
> >  		return NULL;
> > -	skb_reset_mac_header(skb);
> > =20
> > -	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL)
> > -		skb->csum_start +=3D HSR_HLEN;
> > +	if (port->dev->features & NETIF_F_HW_HSR_TAG_INS)
> > +		return skb;
> > +
> > +	/* Ensure the cloned skb has enough headroom to fit the HSR tag */
> > +	if (skb_cow_head(skb, HSR_HLEN))
> > +		goto err;
> > =20
> >  	movelen =3D ETH_HLEN;
> >  	if (frame->is_vlan)
> >  		movelen +=3D VLAN_HLEN;
> > =20
> > +	/* The entire header area needs to be linear */
> > +	if (!pskb_may_pull(skb, movelen))
> > +		goto err;
> > +
> >  	src =3D skb_mac_header(skb);
> >  	dst =3D skb_push(skb, HSR_HLEN);
> >  	memmove(dst, src, movelen);
>=20
> [Severity: Medium]
> Can skb_shared_info.meta_len end up describing the wrong bytes here?
>=20
> skb_clone() shares the shinfo of frame->skb_std. pskb_expand_head() then
> copies both the shinfo and the head contents, so the XDP metadata length =
is
> kept. __pskb_copy() used a fresh shinfo, so meta_len used to be 0 on this
> path.
>=20
> skb_metadata_end() returns skb_mac_header(). This code pushes HSR_HLEN,
> moves only the ETH(+VLAN) header 6 bytes earlier and resets mac_header. As
> a result, the range [mac - meta_len, mac) begins with 6 bytes that are not
> metadata, followed by only the first meta_len - 6 bytes of the original
> metadata. The memmove() also overwrites the last 6 bytes of the original
> metadata with the start of the Ethernet header.
>=20
=E2=80=A6
> Should this use skb_postpush_data_move(), or clear the metadata with
> skb_metadata_clear() after the clone?

puh. This is the only thing I found that could be improved. It looks
like the memmove() could be replace with
	skb_postpush_data_move(skb, HSR_HLEN, movelen);

should I re-spin the whole series or send a follow-up for this change?

> > +	skb_set_network_header(skb, HSR_HLEN + movelen);
> >  	skb_reset_mac_header(skb);
> > +	skb_reset_mac_len(skb);
>=20
> [Severity: Low]
> The commit message only covers preserving skb_shared_info for timestamps:
>=20
>     hsr_create_tagged_frame() creates a new skb where the HSR header can =
be
>     prepended via __pskb_copy(). This does not copy the skb_shared_info p=
art
>     of the original skb so any timestamp request is lost.
>=20
> Could the changelog also mention the header layout changes made here?
>=20
> With the old code, __pskb_copy() only ran skb_copy_header(), so the
> head-relative offsets were copied unchanged into a buffer with HSR_HLEN
> more headroom. Only mac_header and csum_start were fixed up afterwards.
> That left network_header pointing at the HSR tag, transport_header
> HSR_HLEN bytes too early, and mac_len at 14 (18 with VLAN).
>=20
> With this patch:
>=20
> - skb_cow_head()->pskb_expand_head()->skb_headers_offset_update() moves
>   all offsets, which replaces the manual csum_start adjustment.
> - network_header now points past the HSR tag.
> - mac_len becomes 20 (24 with VLAN).
> - A new pskb_may_pull() drop path is added.
>=20
> So the patch fixes the transport_header offset and changes what
> network_header and mac_len mean for these frames. Neither change is
> described in the changelog.

This sounds like a fix? I just followed the API and it is a side effect.

Sebastian
