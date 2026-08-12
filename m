Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B848381A
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786559058; cv=none; b=s0jdUL7m0pNKzLuHL7rNF9a3NlPG4/Ny/z0JvBd5O6GiCvahMdCDLXqKAC1gkYWpbb0Wy8vkMBZebu00pvPCbXSe6qyhCm8Zg+/qM/68U0qK/iLXhg+jyfyX2QOdwhHjDXb9unalE2LPU6JmentIFY7ZmlHaOvQIr2UlEt0Ez7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786559058; c=relaxed/simple;
	bh=XO3NucALKGhPzeGqUGsWUNBJvuCvo7AHykTGH8wD3Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFXnCH9fbG1K904zB9JHz4WNTRTQd2IX6CQ4TK6GtiBZFt9U95h2+c6R3qQAdUrSLvBQnBfrcLEXx0cm02V2NOwGeNa3c/hV75BJjhYdhzWs+QkBQ59ITMI4YOuQUoVDOWjhl218BDIC6+uzIVfHo6I5kll/yNrVvj9qWKcu8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=pFcCFO3F; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="pFcCFO3F"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso1360709a91.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 11:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1786559056; x=1787163856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eLPd2gik+ydyShlsoX0SM+lk6p7EV+mYUqTb977v6HI=;
        b=pFcCFO3Fgw46A3I7yVj4KWOayhBlmaY/uyWtc8dzdFhCnFbq88VRA4z27m4ljhwL16
         N6kmSKOCwMQsFSh7xpsnZi2KGzkt9oMtUHsdLCW+MjBtoFP0bVP9mHgrdWWX8xwQ6jg+
         P5z3WXnuxapYD7bZopgLdfqa8pwQGlSEXXAcD0B3PRt+kQlpMU5lUgtr37xiNGhyO2+H
         ab5hBqCNdrn5tMWMba1oCeki9Bb+3eQdl4IvmA/M75aeNRM96GwJ8wzr4QMSdorrSi0+
         JFAeLUScG3XGL7SMFVeeugS8u66NWpNZXTvXlf+IpD35gPBPgNZyx/l/0cfm9BReN/h7
         4zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786559056; x=1787163856;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eLPd2gik+ydyShlsoX0SM+lk6p7EV+mYUqTb977v6HI=;
        b=ePpgKgw4FhzTnt8vvJVn6jjUC64WUlzN8kuXVsvOOTsdpFoQgyd9PIisvgppE9gxc0
         UAcD1sSHYj7yIUz0gqK+ND4Gh2GuLW+AFgbFeNf+CXp5BQ7aN9g9HI0QvEVZRAc3UkA4
         WeuxwULv96EjFYFxnck8+Ao3jI+jPGeunwbBsBPLp4ix60jXGK9adkBLX2Xn93AEB95m
         2IDkg++xWOiiN4FnDx8xk0Fic5EP8rLCvXsXNcA14vHldiVnzMmlLfCRLGWNQxHWJOBn
         rEddfvuXXn34bCHo36QZ+9CQxaGzEIvGqS8rnlJroXY9UmdcHhl+P+ltzoiXic8Bc5Hd
         FAOQ==
X-Gm-Message-State: AOJu0YziAey6eHmaZ4/VkM7C3euhuKQpBUeRlDAXbKyPoH5IOiAc3BT5
	/QLLVxnbabfaWsKNS3rQCe+k1ZQwkuiTSPvx6LAnRD2Qa1cU7yF3QWKZG2ZD/7vc9G0=
X-Gm-Gg: AR+sD10GtJFUm/lsdQzmLXOr6/u5SAbSfVTSWXue8AqekQFpQFvfwAbGNug9O1t/px2
	n9xJPXFyq1PMW+JwXze/6qie2kTRtaGTkbte5uGQoXY9dhc7GQ3oGtuB0pODf0ACXOPWx+9vOUk
	xghKCiWNKoh09kA49YjeJhKIahe5iZ8UjM3XgvMQooFN/Sm9Is84TGwvMNM0ea/D1nY7LI+ngsO
	0ZArPVnhjSnyvKAWuAwVevzCsOAxRSvT5c0nw1QYSWRlujZdaVjL4cZBj1q08byLus2+1XkJLwz
	/9pxu7qhiGybxUQpq107f6eW9v00I/W7ExafCdgAJXXM1rqpt8GFN6jJF940LqsdOjKhunEl11t
	N09L8ROlcko1O5qoePG3FDviu4EnbxcSB9Ffz3CnTrXU2WvfZewI/HNIccvQEqo6Koh8lFwYP3+
	U6ds0skW/eSrBTn3wOaNj8i3fZTzB7qn06//iLX0RK
X-Received: by 2002:a17:90b:540c:b0:390:b41a:b92f with SMTP id 98e67ed59e1d1-3931e31bd38mr87086a91.18.1786559055080;
        Wed, 12 Aug 2026 11:24:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931cefe8efsm338390a91.15.2026.08.12.11.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 11:24:14 -0700 (PDT)
Date: Wed, 12 Aug 2026 11:24:13 -0700
From: Joe Damato <joe@dama.to>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, andrew+netdev@lunn.ch,
	willemb@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net/packet: Reduce VLAN tag code duplication
Message-ID: <any6TenWsCUdIPvX@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, andrew+netdev@lunn.ch,
	willemb@google.com, linux-kernel@vger.kernel.org
References: <20260811184722.2612345-1-joe@dama.to>
 <20260811184722.2612345-2-joe@dama.to>
 <willemdebruijn.kernel.57d27685522a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.57d27685522a@gmail.com>

On Wed, Aug 12, 2026 at 08:28:39AM -0400, Willem de Bruijn wrote:
> Joe Damato wrote:
> > Reduce code duplication for VLAN tag extraction by factoring the
> > repeated code into a helper and using it.
> > 
> > Signed-off-by: Joe Damato <joe@dama.to>
> 
> Especially with the improving AI bots, we're getting even more fixes
> to PF_PACKET lately. Cleanup patches can block fix backports to stable.
> The bar for pure cleanup patches has to be high to warrant that.
> 
> Plus, they add risk, if it is not trivial to review that they are NOOPs.
> 
> Subjective, but not sure this one warrants the cost.

OK. In that case, I'll mark the series as rejected below. I was also working
on a test for ORIGDEV because many, many years ago I got bit by unexpected
results mixing packet sockets with bonded interfaces.

But, I'll refrain from touching anything related to af_packet including tests
from now on.

> > ---
> >  net/packet/af_packet.c | 95 +++++++++++++++++++++++-------------------
> >  1 file changed, 53 insertions(+), 42 deletions(-)
> > 
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index 435756877aba..ee60dcc639ad 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c

[...]

> > @@ -997,20 +1018,19 @@ static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
> >  			struct tpacket3_hdr *ppd)
> >  {
> >  	struct packet_sock *po = container_of(pkc, struct packet_sock, rx_ring.prb_bdqc);
> > +	struct net_device *dev = NULL;
> > +	u16 tci, tpid;
> >  
> > -	if (skb_vlan_tag_present(pkc->skb)) {
> > -		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
> > -		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
> > -		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> > -	} else if (unlikely(po->sk.sk_type == SOCK_DGRAM && eth_type_vlan(pkc->skb->protocol))) {
> > -		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, pkc->skb->dev);
> > -		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
> > +	if (po->sk.sk_type == SOCK_DGRAM)
> > +		dev = pkc->skb->dev;
> > +
> > +	if (packet_get_vlan_tci_tpid(pkc->skb, dev, &tci, &tpid))
> >  		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> 
> Does this change behavior, now setting tp_status also for the second
> branch, where previously the flags were not set?

If you apply the patch to the tree and look at it, it'll be less confusing. It
looks weird because of what git generated, but as far as my reading of the
code goes, there is no behavior change.

---
pw-bot: rejected
