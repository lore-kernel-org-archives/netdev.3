Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F8337BB8
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144583; cv=none; b=cTYOTNn9yBDKDgGp7EbCDy2IQUpYlJ43lBQVVIgcZL+Ckp0dsuBBYeHp2zpdN0A5NNkkAExQNAJ7HUU9LWL89TNnUsn3athm2QmA0Jrk4PwtfiBmsaIdYx7fXGGSIzxoHNkh7+tRFA+RwyZoV4PSHyY9Eo+nPUPmuZTbPZfq/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144583; c=relaxed/simple;
	bh=KS+hyG8c1op4kAF/V5/p31OA1NEKdfCe5DgHHpZ9sjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0HF6hbX0yqOtrCDo/YFLIuO15LgvRGGmVp+OfFUbaQDdNhVL1MqUMMOZLYNLfS/m3x6IsnkXnScB1Blx31x3Vs25z8+KFw3b1RgFD2ySzSWq13OXgXQEIbev44eN2vZ1yR9Lkwm8PIHWQnZlVaDooZdHx8vgiA36SltaYkmzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UOKCmCom; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cpWDeT5p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UOKCmCom";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cpWDeT5p"
Date: Fri, 16 Oct 2026 11:56:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792144572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQPC4olfHWFHQdUeCdi2r09y8heMXe015t/8jgh07KA=;
	b=UOKCmComBwA2vTZAW6nDIWyDE9TY5QhDwAx1wUBVMOx+0xvBPT+UUto/xsLjXi7D0GswMM
	Kee5lNYb1xYvsElmzAhGmoAizxf/JwEffPEWex/V2hcNRSgr8/dJNV8/41rp7tJiiQcZ0i
	sCr1jzCH0N2+i+P2iV2Wuarwd8N8GQLErXdYCyP1rW68ZXEngswfhB2IhwcNfhNr6B5+Zw
	1mipnNhubX0sfCnbwcUOu+6cvUaGmYCuIPoTNkfvdmD9OzBBBwKs0TvewZbv5E9V19KSLK
	Xr1Kjln1OXmQcl2oI9tcSUhhjlfQtLumaUGKbtwr8g+YLY2utmUiuVy/cF67Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792144572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQPC4olfHWFHQdUeCdi2r09y8heMXe015t/8jgh07KA=;
	b=cpWDeT5pSXPIYJshKpcNoP+kCMq5bghlprss+B+9PyACwKyV5YmOtr7+hKtHVic47GOIwM
	CviwHIapeXcYKkAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev@vger.kernel.org, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net-next v9 5/8] hsr: Use the port and header information
 in hsr_forward_skb()
Message-ID: <20261016095611.x_Nm0lpH@linutronix.de>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
 <20261014-hsr_ptp-v9-5-2d20a2a0f816@linutronix.de>
 <20261016092416.5ssargoekf74pcwn@DEN-DL-M70577.microsemi.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261016092416.5ssargoekf74pcwn@DEN-DL-M70577.microsemi.net>

On 2026-10-16 11:24:16 [+0200], Daniel Machon wrote:
> > The upper layer can submit a port on which the skb should be sent and
> > whether or not a HSR header should be added. Use this information while
> > forwarding the packet:
> > - If the port set, deliver it only on the requested port.
> > - If a header is already present then skip parts of the stack:
> >   - The packet originates from the master port and we don't want to
> >     assign a sequence number to it, it needs to preserve the original
> >     one.
> >   - The existing h_source must be used (and not replaced).
> >   - The node should already exist in the node_db if "other" packets are
> >     exchanged. If the node information is not yet existing then
> >     creating it makes no sense because it is used for deduplication of
> >     incoming packets and this is not used in the PTP case. If no other
> >     packets are exchanged then the node_db will age and then removed.
> >=20
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  net/hsr/hsr_forward.c  | 45 ++++++++++++++++++++++++++++++++++++------=
---
> >  net/hsr/hsr_framereg.h |  2 ++
> >  2 files changed, 38 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > index 2b8ae9723bd7f..534798da48d53 100644
> > --- a/net/hsr/hsr_forward.c
> > +++ b/net/hsr/hsr_forward.c
> > @@ -426,7 +426,7 @@ static void hsr_deliver_master(struct sk_buff *skb,=
 struct net_device *dev,
> >  static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
> >  		    struct hsr_frame_info *frame)
> >  {
> > -	if (frame->port_rcv->type =3D=3D HSR_PT_MASTER) {
> > +	if (frame->port_rcv->type =3D=3D HSR_PT_MASTER && !frame->has_foreign=
_header) {
> >  		hsr_addr_subst_dest(frame->node_src, skb, port);
> > =20
> >  		/* Address substitution (IEC62439-3 pp 26, 50): replace mac
> > @@ -547,11 +547,12 @@ bool hsr_drop_frame(struct hsr_frame_info *frame,=
 struct hsr_port *port)
> >  static void hsr_forward_do(struct hsr_frame_info *frame)
> >  {
> >  	struct hsr_port *port;
> > -	struct sk_buff *skb;
>=20
> Is this needed, or just cleanup?

Sort of cleanup. It is still used in the loop where it is used. The NULL
init is not needed so It could stay as-is where it is.

> >  	bool sent =3D false;
> > =20
> >  	hsr_for_each_port(frame->port_rcv->hsr, port) {
> >  		struct hsr_priv *hsr =3D port->hsr;
> > +		struct sk_buff *skb =3D NULL;
> > +
> >  		/* Don't send frame back the way it came */
> >  		if (port =3D=3D frame->port_rcv)
> >  			continue;
> > @@ -570,6 +571,17 @@ static void hsr_forward_do(struct hsr_frame_info *=
frame)
> >  		if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
> >  			continue;
> > =20
> > +		/* PTP TX packets have an outgoing port specified */
> > +		if (frame->req_tx_port !=3D HSR_PT_NONE && frame->req_tx_port !=3D p=
ort->type)
> > +			continue;
>=20
> This checks that if the frame is directed and that the frame is only send=
 to the
> directed port. Maybe the comments could be more clear about that.

Oki.

=E2=80=A6
> > diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
> > index 127a3fb64d5f0..e5e6363c0466f 100644
> > --- a/net/hsr/hsr_framereg.h
> > +++ b/net/hsr/hsr_framereg.h
> > @@ -29,6 +29,8 @@ struct hsr_frame_info {
> >  	bool is_from_san;
> >  	bool dst_in_node_db;
> >  	bool dst_in_proxy_node_db;
> > +	bool has_foreign_header;
> > +	enum hsr_port_type req_tx_port;
>=20
> The same flag is hsr_hdr in the uAPI, has_header in hsr_dev_xmit(),
> has_hsr_header in hsr_forward_skb() and has_foreign_header here. The
> port is tx_port in some places and req_tx_port in others. Could the namin=
g be
> aligned?

I could align it with has_hsr_header probably.

> >  };
> > =20
> >  void hsr_del_self_node(struct hsr_priv *hsr);
>=20
> /Daniel

Sebastian
