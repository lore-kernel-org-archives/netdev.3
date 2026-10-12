Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB473BFE4F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816051; cv=none; b=fgDHq0NIeBu58Q0K4RlPwEmU6jQDB5ZqgMBGsuHLqYIgb924awFDeEPilxMCD/5yQv5Z81sE8TvtHgmxnvZiXAKa70E6G8AyuAcnYMFr62a/GvPawBcpkMVlXaRSNbgatxdTeKhs2ihXK0T8ROfM749QJgdMeEnErS0+qhoNlaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816051; c=relaxed/simple;
	bh=OpCKGsuEEQudaupBRlEcFM/4I8uPP0jHGdefzxFkaC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbcbKMnQgO5QnD3k2om/PYM74ZIUA9VgEePBv5dJZbWtGzHZAnkOIPu9xJEKOOnipm2Zgp7vIzj807UEVS+H8fVfmvDih6qiNDih5qpVMkTKc0P15XgcYi/ilCC7cHAJeSuVKntAgA8zUWKACeqTNT9yQTSD7OZjYbl1pzZ2Zc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V9p7WEgZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eiNdgPYd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V9p7WEgZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eiNdgPYd"
Date: Mon, 12 Oct 2026 16:40:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791816047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFOS6LHTgsAWTs1TcMPNNosAGr6AqDD5RgF/NzKrfQs=;
	b=V9p7WEgZKEjhvSn7cG0pFFXCYwKvpKn7qjWya2XljHfN/UrQNUywxxriWVPMUI3a0ixJru
	/GXUjbQsJpaS5X1JLxFNJL6wHog/kHty3WM1oXAsp7srKEl4g45WW8iEM0H3FgtLL+JzgV
	Zpa2+jworFevBF8KB3CE3iHHUG9UnBQFKLTgOm3Bw4rZMQg0O+tqgFT8lA7O5zoUFrEvCE
	VTpdSBQ0L4p49R0NhiHcnuYeEvb3wlISF34F+S7N2eRBoWdsDhCvaAb8bBdSKDSxd2gPn8
	WZv7FLdlDXrfbBJoC/HVD24Fh1TaO+lHvQgQJAXi4aC2hJCf6B0wjaBMkxTIEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791816047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFOS6LHTgsAWTs1TcMPNNosAGr6AqDD5RgF/NzKrfQs=;
	b=eiNdgPYd00UawSxm7xIyX1yEQTSriqPbUW4fRP3BCKgJUofpJRCplhm+Ci+Z4icwueGKw5
	BZPUIGZXrkQeBwBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
	c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com,
	davem@davemloft.net, edumazet@google.com, fmaurer@redhat.com,
	kuba@kernel.org, neelima@ti.com, pabeni@redhat.com, praneeth@ti.com,
	pratheesh@ti.com, richardcochran@gmail.com, horms@kernel.org,
	vigneshr@ti.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v8 3/8] hsr: Add a magic header for sending PTP
 packets
Message-ID: <20261012144046.X-Bi2B6J@linutronix.de>
References: <20261002-hsr_ptp-v8-3-60dabc07e554@linutronix.de>
 <179129707549.434549.12538393070496080930@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <179129707549.434549.12538393070496080930@kernel.org>

On 2026-10-06 14:31:15 [+0000], netdev-bot+sashiko@kernel.org wrote:
> > +	skb->dev =3D master->dev;
> > +	if (skb->protocol =3D=3D htons(ETH_P_1588)) {
>=20
> [Severity: Medium]
> Does this drop every PTP frame that lacks the new inline header?

Yes. Intended.

=E2=80=A6
> That covers local senders that ask for TX timestamps. Does it also hold
> for transit PTP traffic, or for PTP traffic that doesn't use
> timestamps?

PTP traffic without timestamps does not sound like accurate usage of
PTP.

> The commit message calls the header mandatory. It doesn't mention that
> existing senders without the header now lose their traffic.
> hsr_dev_xmit() isn't changed later in the series, so this stays in place.

Mandatory implies this.

> > +		struct hsr_inline_header *hsr_opt;
> > +		struct ethhdr *eth_hdr;
> > +		unsigned int hdr_len;
> > +
> > +		BUILD_BUG_ON(sizeof(struct hsr_inline_header) !=3D sizeof(struct eth=
hdr));
> > +
> > +		/* need to access the magic header */
> > +		if (!pskb_may_pull(skb, sizeof(struct hsr_inline_header)))
> > +			goto drop;
> > +
> > +		hsr_opt =3D (struct hsr_inline_header *)skb_mac_header(skb);
> > +		if (hsr_opt->magic !=3D htonl(HSR_INLINE_HDR))
> > +			goto drop;
>=20
> [Severity: Medium]
> Can a remote host provide this control header?
>=20
> The only check is a constant magic in the source MAC position, and the
> struct maps directly onto dst MAC, src MAC and ethertype.
>=20
> Some frames are received from the wire and forwarded into hsr0 by tc
> mirred (ingress to egress) or by an OVS output action. They keep
> skb->protocol =3D ETH_P_1588 from eth_type_trans(). Their first 14 bytes
> are the Ethernet header that the remote sender chose.
>=20
> Consider a frame with:
>=20
>   - dst MAC {01 or 02, hsr_hdr, 00, 00, 00, 00}
>   - src MAC {af:48:53:52, 00, 00}
>   - ethertype 0x88f7

This shouldn't happen. This injection/ magic header is in hsr_dev_xmit()
and only for the HSR_PT_MASTER port which is the hsr0 interface. So it
does not happen on received packets which would be the HSR_PT_SLAVE_{AB}
interface. So no.

=E2=80=A6
> [Severity: Low]
> Should hsr_hdr be checked against the inner frame before it is trusted
> here?
>=20
> With hsr_hdr set, mac_len becomes ETH_HLEN + HSR_HLEN. Nothing checks
> that eth_hdr->h_proto is really an HSR ethertype.
>=20
> Take a VLAN-tagged frame with an encapsulated ETH_P_HSR and hsr_hdr =3D 1.
> It gets past this guard in hsr_fill_frame_info(), which would otherwise
> reject it:
>=20
> 	if (skb->mac_len < sizeof(struct hsr_ethhdr))
> 		return -EINVAL;
>=20
> Then hsr_get_skb_sequence_nr() and hsr_set_path_id() read and write the
> tag at mac_header + 14, which is inside the VLAN header, instead of at
> mac_header + 18.
>=20
> The pskb_may_pull() above keeps these accesses within the linear data.
>=20
> The later commit "hsr: Use the port and header information in
> hsr_forward_skb()" makes hsr_fill_frame_info() return early when
> has_foreign_header is set. hsr_forward_do() then sends a clone of
> skb_std without calling hsr_set_path_id(). So this affects only this
> intermediate commit.

If this only effects intermediate commit, then it should be fine.

> [ ... ]
>=20
> > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > index 73bc4b8950071..4afe9e1d65b7e 100644
> > --- a/net/hsr/hsr_forward.c
> > +++ b/net/hsr/hsr_forward.c
> > @@ -773,7 +773,8 @@ static int fill_frame_info(struct hsr_frame_info *f=
rame,
> >  }
> > =20
> >  /* Must be called holding rcu read lock (because of the port parameter=
) */
> > -void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
> > +void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
> > +		     enum hsr_port_type tx_port, bool has_hsr_header)
> >  {
> >  	struct hsr_frame_info frame;
> > =20
>=20
> [Severity: Low]
> At this commit, hsr_forward_skb() accepts tx_port and has_hsr_header but
> doesn't use them. The body still does:
=E2=80=A6
> The commit message says the values "will be used later". The follow-up
> commit "hsr: Use the port and header information in hsr_forward_skb()"
> adds frame->req_tx_port and frame->has_foreign_header. It acts on them in
> fill_frame_info(), hsr_fill_frame_info(), hsr_forward_do() and
> hsr_xmit(). So this only matters when bisecting onto this commit.

This is fine as-is.

Sebastian
