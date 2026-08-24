Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3333360EF9
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583685; cv=none; b=HhnaUr0a+o4fkteCZjPkdzXbRf0ofAetKkPwK+dChPV3Z/ESw2yRTq5Dh0gSS+I8z+/sD/AGyErwd2Ubj/3tiyMJ+Ew1RxSVTFm9rBoW0j18ah72re/i3jL6cUiF1GGazasWEtG2AFy6IudNq+MXKcRJ/hg+SMWnffV6f4FXWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583685; c=relaxed/simple;
	bh=NyxZOPfmcvYycaO0/GB1x544T8zdLlUGZ5oDJiPPBrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCedeIXaz641Egb9ph6IK0f5JcC3RLiyQiPBU6ey5b9PJRXvecdzNy598orviKnp6KssERz6A5uThZY1pHU2PB57kGyg1tp9tDHHEZ62MPzN0u8lQnsR6uhXs469dcwJwrwS/bvgBQwD+0nrL0pT+Iw/Cr+2KEkb2cb1odXZJa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEoBdXIh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEoBdXIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A4B1F000E9;
	Mon, 24 Aug 2026 15:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787583683;
	bh=xCvHEDlGeMC/nupSeEr3NtezEDMx1EIe2VQVji1m3Aw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZEoBdXIhZlEbH7Y4Oz6deKO6gb1VXBa5UTOnA5dBSjwW1VD02N3izMq+fmZFbal+4
	 /0AlszTGQm/JZEOGg6nWK4xL+mvb9q68q6b0bNdmo8PxL8sHyELHRb6l/fRCVO3k5m
	 hjGNa/SDoRo+KHMzkOWPaUsoB3WZgJtSyJubb29F5liApyx1OwZN2kE4mFw4hkHBlk
	 25TqwViFHAJG2aOn4ca+9/wA1ANvmFHcZmWCpXToambCkylQNKDjYWKMD5jiolhc3m
	 TBHBf30HMRDdbWAV38UTy5bmtFQdm1dMivk3d+b2VV10L6fr8yvl8nxoLoleUZTbz4
	 KAULRRXrGpIRw==
Date: Mon, 24 Aug 2026 08:01:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: <willemdebruijn.kernel@gmail.com>, <edumazet@google.com>,
 <cratiu@nvidia.com>, <borisp@nvidia.com>, <kuniyu@google.com>,
 <netdev@vger.kernel.org>
Subject: Re: [RFC net-next 1/6] psp: steer Rx queues with the virtualization
 cookie
Message-ID: <20260824080122.17be0e16@kernel.org>
In-Reply-To: <DKWFJ9D12OPD.2ZLQHDM0276G4@gmail.com>
References: <20260822225524.2328465-1-kuba@kernel.org>
	<20260822225524.2328465-2-kuba@kernel.org>
	<DKWFJ9D12OPD.2ZLQHDM0276G4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 11:31:03 -0400 Daniel Zahka wrote:
> On Sat Aug 22, 2026 at 6:55 PM EDT, Jakub Kicinski wrote:
> > @@ -72,6 +90,27 @@ name: psp
> >            Present when in associated namespace, absent when in primary/host
> >            namespace.
> >          type: flag
> > +      -
> > +        name: vc-steer-cap
> > +        doc: |
> > +          Device can steer received traffic on the PSP virtualization
> > +          cookie (VC). The VC is split into a 32b reserved part, a 16b
> > +          queue ID the sender is asking the peer to send to, and a 16b
> > +          queue ID granting the peer's own request. Steering installs low
> > +          priority rules matching the latter, which win over the RSS table
> > +          result. Only needed for the rx direction; granting a peer's
> > +          request is just header generation and needs no device support.
> > +        type: flag
> > +      -
> > +        name: vc-steer-ena
> > +        doc: |
> > +          Directions taking part in VC based queue steering. Leave the
> > +          attribute out of a dev-set request to keep the current setting.
> > +          Applies to associations created from then on, existing ones keep
> > +          the setting they were created with.
> > +        type: u32
> > +        enum: vc-steer
> > +        enum-as-flags: true
> >    
> 
> Should vc-steer-ena be a connection level setting? Maybe it could go
> into rx-assoc. The way it's implemented here, the state is already per
> assoc.

That's what I started with but then given the security implications
of the current simple design I could not think of a reason do configure
this connection by connection. Besides the SW stack responsible for
security is likely somewhat orthogonal to steering configuration. 
Should have put this in the cover letter as well.

> > +Every driver has to carry the cookie, not just those which advertise
> > +``vc-steer-cap`` - granting a peer's request needs no help from the
> > +device, so the ``tx`` direction of ``vc-steer-ena`` may be turned on
> > +anywhere. Drivers must ask ``psp_assoc_vc_tx_get()`` for the cookie to
> > +place in the Tx header, and report the queue IDs a received cookie held
> > +in ``psp_skb_ext.vc_req`` and ``vc_dst`` (``psp_dev_rcv()`` does this for
> > +drivers which let the core strip the headers). Reporting is what allows
> > +the core to grant the peer's request. The steering itself is only
> > +expected of drivers which advertise ``vc-steer-cap``.
> > +
> > +When VC steering is enabled GRO implementations are allowed to ignore
> > +changes in the cookie for transport mode PSP.
> > +  
> 
> Makes sense. Do we would need to update __psp_skb_coalesce_diff() here
> then for the sw gro?

Ack.

> Unrelated, but this reminds me: some of the other fields here:
> generation, spi, peer_tx, have some reads/writes that probably require
> READ/WRITE_ONCE() and maybe deserve a similar comment here... Probably
> all bugs that I introduced :/
> 
> >  /* Encapsulate a TCP packet with PSP by adding the UDP+PSP headers and filling
> > - * them in.
> > + * them in. @vc is the virtualization cookie to place in the header, 0 for
> > + * a header with no optional fields.
> >   */
> >  bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb, __be32 spi,
> > -			 u8 ver, __be16 sport)
> > +			 u8 ver, __be16 sport, u64 vc)
> >  {
> >  	u32 network_len = skb_network_header_len(skb);
> >  	u32 ethr_len = skb_mac_header_len(skb);
> >  	u32 bufflen = ethr_len + network_len;
> > +	u32 encap_len = PSP_ENCAP_HLEN;
> >  
> >  	if (skb->protocol != htons(ETH_P_IP) &&
> >  	    skb->protocol != htons(ETH_P_IPV6))
> >  		return false;
> >  
> > -	if (skb_cow_head(skb, PSP_ENCAP_HLEN))
> > +	if (vc)
> > +		encap_len += PSP_VC_SIZE;
> > +  
> 
> I suppose vc of 0 is probably valid. We might need something else to
> disambiguate "not present".

Ah, good point. We should probably encode the queue as idx+1,
I was going back and forth on this. Doesn't feel super clean but
it solves a bunch of corner cases, so the benefits probably outweigh
the slightly confusing indexing.
