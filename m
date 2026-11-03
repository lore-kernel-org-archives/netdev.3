Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701078;
	b=qQtspbq0ZbNOGICrmqrf/R2+4zPk58txD5Q7KHF0ueoFb1lalJuzDzCIiJ60E+qu/R1v
	 2NhRNFZCz7l1WN6OciFsGx7jgByuiGNUMYMU5upOMpNxloTIGvdBdeQ7dZ9ycuaku57cL
	 tHO1TNZRu5AuEy5M79KKeC8rmTNBvHUyTZyaJ5oK4n4uKlB2Fkw9y/cYI2eodPYtEAy3O
	 L/pSRJiKzL4GcgXM1+QWvCvdA0GIzWbzJMm4Jq0jPvhh2PlGffzH7L+/sF74PATeBBu4u
	 m/kpKSQiFoD0G8Sf4gm1gTNsqJPyC54OVk6tEO4VkTCivs6bxom9wD/wLHUzepixReg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701078;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy;
	bh=3LzEg+08CDGt5CVl5TtdoB9eeNw9o9QcraQdpSTb0xk=;
	b=zC2UMA4pQEAdurNY6yQLO7S8OdmE5zpyXKygvPJ0Gy09J1CmXn45SVVTWAU4M3wbDx1L
	 g8NOB71oQyUtc+R2EVGJEUPZgPOvKEFJpYltAHwblUyNvRRdXsD0HywLXwFKi/CL4wr4r
	 HtADacN8XgoFc1DxJgw0Y2mbMEi/TIKneSKmFrpCaWdgkB3wpJEB6l5t8mzNTU2YtaSg9
	 rC62Dfu8EEUZfxji0uPIqeiAK6wbhUdUrjWYJCbTv5E3fdWSoW5ND50/ENfdaWWLNuoSa
	 3vHoc2FD2zcc+A9+0/kCxFivn+030z7/vevfyGYBoRvU9Yyak9GOi1C5br25CqA5UPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=AWle+HDk;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4674F606A810
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 10:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4674F606A810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=AWle+HDk
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3FE582074F;
	Tue,  3 Nov 2026 11:17:55 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L641Yx1eMc-i; Tue,  3 Nov 2026 11:17:54 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7577B201A7;
	Tue,  3 Nov 2026 11:17:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7577B201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793701074;
	bh=3LzEg+08CDGt5CVl5TtdoB9eeNw9o9QcraQdpSTb0xk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=AWle+HDkxwrqTn1D/5mdS4F29/861P8TOeMwyKkxjs2ey8pdwHabxlmXPkgJDAUAg
	 UJ1EDmiCdCzhcssC3txHWXBqzaNQQdxa13Y2f+IaWs8LqbdTJnMcvzbhsIBEhS+LW0
	 rMVUHqGGK38Mc4wbQoEBJEtVPbGh5tV841ud4SZpryXy/PP8CVA/XRp4SD55vihqVk
	 gEObkZX4OfvktNSQn8NqWGX/7VBW9S9gADFjG4sMTxIwkPQif9syRyJhN2L/t3U/+G
	 0OuEGAsv+MQSSkGdfnZEAphyaNiUGO2UN2Opk0LAHNwCFU1j71VTnL9+UWMxl/gfFB
	 Fpcan3fLDyvlg==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 3 Nov
 2026 11:17:53 +0100
Received: (nullmailer pid 3763646 invoked by uid 1000);
	Tue, 03 Nov 2026 10:17:52 -0000
Date: Tue, 3 Nov 2026 11:17:52 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, Antony Antony <antony.antony@secunet.com>
Subject: Re: [PATCH 08/14] xfrm: state: exact mark/mask match for SPI-keyed
 control-plane SA lookups
Message-ID: <aum00JViMLUecAM8@gauss4>
References: <20261102100451.2505200-9-steffen.klassert@secunet.com>
 <179369310478.488856.2697392451062168303@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179369310478.488856.2697392451062168303@kernel.org>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Nov 03, 2026 at 08:05:04AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 4 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The patch changes netlink request semantics without saying so.
> - [Medium] The commit says ALLOCSPI larval states may be unmarked (0/0)
>   and keeps UPDSA on the wildcard match for that reason.
> - [Medium] UPDSA (xfrm_state_update()) still finds its target through
>   __xfrm_state_locate(), which calls the wildcard…
> - [Medium] The commit says it wires exact matching into DELSA/GETSA, but
>   xfrm_user_state_lookup() converts only the SPI branch.

The commit messages could have been more precise, but no need
to revert it because of that.

> [Severity: Medium]
> UPDSA still picks its target through this wildcard lookup. Can
> xfrm_state_update() still update the wrong SA when the states are VALID?
> 
> Overlapping SAs can coexist. The duplicate check in xfrm_state_add()
> also goes through __xfrm_state_locate(), so the result depends on
> insertion order:
> 
>   NEWSA A {mark 5, mask 0xff}
>   NEWSA B {mark 0, mask 0}, same daddr/spi/proto
>     key is 0, (0 & 0xff) != 5, so the add succeeds
> 
> XFRM_STATE_INSERT puts newer software states ahead of older ones in the
> byspi chain, so B sits before A. Then:
> 
>   UPDSA with XFRMA_MARK 5/0xff
>     xfrm_add_sa()->xfrm_state_update()->__xfrm_state_locate()
>       key is 5, B matches first since (5 & 0) == 0
> 
> In the VALID branch, xfrm_state_update() then overwrites B's encap,
> coaddr, lifetimes, smark and if_id, and restarts B's timer. A, the SA
> named in the request, stays unchanged.
> 
> The commit message gives unmarked ALLOCSPI larval states as the reason
> to keep the wildcard here. That reason only covers XFRM_STATE_ACQ
> states.
> 
> Would it work to try an exact match first, and fall back to the wildcard
> only for XFRM_STATE_ACQ larval states?

Might work, can be done with a followup. I leave that to Antony.

> 
> [ ... ]
> 
> > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > index c1571c7a23153..5a9f729b4fcb0 100644
> > --- a/net/xfrm/xfrm_user.c
> > +++ b/net/xfrm/xfrm_user.c
> > @@ -1109,11 +1109,12 @@ static struct xfrm_state *xfrm_user_state_lookup(struct net *net,
> >  	struct xfrm_state *x = NULL;
> >  	struct xfrm_mark m;
> >  	int err;
> > -	u32 mark = xfrm_mark_get(attrs, &m);
> > +
> > +	xfrm_mark_get(attrs, &m);
> >
> >  	if (xfrm_id_proto_match(p->proto, IPSEC_PROTO_ANY)) {
> >  		err = -ESRCH;
> > -		x = xfrm_state_lookup(net, mark, &p->daddr, p->spi, p->proto, p->family);
> > +		x = xfrm_state_lookup_exact(net, &m, &p->daddr, p->spi, p->proto, p->family);
> 
> [Severity: Medium]
> The commit message says ALLOCSPI larval states may be unmarked (0/0).
> Can DELSA still find those larval states after this change?
> 
> xfrm_alloc_userspi() passes the request's mark to xfrm_find_acq(), and
> __find_acq_core() copies it into the new ACQ state:
> 
> net/xfrm/xfrm_state.c:__find_acq_core() {
>     ...
> 		x->mark.v = m->v;
> 		x->mark.m = m->m;
>     ...
> }
> 
> So an ALLOCSPI without XFRMA_MARK creates a 0/0 larval state that holds
> the allocated SPI.
> 
> Suppose negotiation fails, or the CHILD_SA is torn down before UPDSA. An
> IKE daemon then sends DELSA for that SPI with its configured inbound
> mark, for example 5/0xffffffff. strongSwan behaves this way: its
> ALLOCSPI carries no mark, and its child_sa destroy deletes my_spi with
> mark_in.

If the larval state was allocated without mark, then it should also be
deleted witout mark. Looks more like a strongSwan problem.

> 
> Before this patch the key was 5. Since (5 & 0) == 0, the larval state
> was found and deleted.
> 
> Now xfrm_del_sa()->xfrm_user_state_lookup()->xfrm_state_lookup_exact()
> requires v == 5 && m == 0xffffffff, so DELSA returns -ESRCH. No delete
> notification is sent. The larval state keeps the SPI reserved until its
> acquire hard timer (sysctl_acq_expires) fires.

In the worst case, this SPI is blocked for 30 sec. with a standard
configuration.

> 
> >  	} else {
> >  		xfrm_address_t *saddr = NULL;
> >
> > @@ -1124,7 +1125,7 @@ static struct xfrm_state *xfrm_user_state_lookup(struct net *net,
> >  		}
> >
> >  		err = -ESRCH;
> > -		x = xfrm_state_lookup_byaddr(net, mark,
> > +		x = xfrm_state_lookup_byaddr(net, m.v & m.m,
> >  					     &p->daddr, saddr,
> >  					     p->proto, p->family);
> 
> [Severity: Medium]
> The commit message says DELSA/GETSA now use exact matching. This branch
> still does a wildcard lookup and drops the request's mask. Should the
> non-SPI path be converted as well?
> 
> This branch handles protocols where xfrm_id_proto_match(p->proto,
> IPSEC_PROTO_ANY) is false, such as MIPv6 IPPROTO_ROUTING and
> IPPROTO_DSTOPTS states. __xfrm_state_lookup_byaddr() still does:

This is ancient stuff, not even sure if this is still functional.
We should consider to deprecate these.

> 
> 		if ((mark & x->mark.m) != x->mark.v)
> 			continue;
> 
> Overlapping states can coexist here too:
> 
>   NEWSA A {mark 5, mask 0xff}
>   NEWSA B {mark 0, mask 0}, same daddr/saddr/proto
>     duplicate check key is 0, (0 & 0xff) != 5, so the add succeeds
> 
> XFRM_STATE_INSERT puts B ahead of A in the bysrc chain. Then:
> 
>   DELSA with XFRMA_MARK 5/0xff and XFRMA_SRCADDR
>     xfrm_del_sa()->xfrm_user_state_lookup()->xfrm_state_lookup_byaddr()
>       key is 5, B matches first since (5 & 0) == 0
>     xfrm_state_delete(B)
> 
> As a result B is deleted, not the SA named in the request. GETSA returns
> the wrong SA in the same way.

It is a missing path, can be fixed with a followup.

