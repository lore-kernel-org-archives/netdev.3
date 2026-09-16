Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC543CEBB7;
	Wed, 16 Sep 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789547166; cv=none; b=eNh7I+IHzuaCOWpyTATGOwziMi7lcLZKKhNHBUD2g9Ffp7ART0VrcBUzVLVn+sGsS1E1hrtQNeBuHNu8vKvL2CdJ0rZ9aXg/g6wH9iGRZP/WTiH6387GSF5EWTmrJRsC+PnMTs7qrjYcHLOnjX+ij3LDfYVUDFWvY56l/nuKva4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789547166; c=relaxed/simple;
	bh=tzunOIvX13T8GZssRW0g6nBYMCwuMKS4fREcQqWi5mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBr/MxnJM/ZCtmXd5SFnq7HvvdgaPMlLmYCUpAEK5kBD2x1NjCrIpyZLmDk2s9oUOY2SkFZLyRB4O9PxBL55hlCcxijGpKdyH5XU11hSmHAaey37qtdtjv4u5vLM9OlUtu5+vZxPndm1uPTJWYtwqpjScqsZ0GmzQKJ06gjkmxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=f7W97wSJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wfKpFGNG; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="f7W97wSJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wfKpFGNG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CC8FD1400228;
	Wed, 16 Sep 2026 04:25:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 16 Sep 2026 04:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789547158;
	 x=1789633558; bh=mNzhb6zN/R3JPWjJEG6KIlVLzjl1vGJ3j4ZmXL2PQVk=; b=
	f7W97wSJ1vm1e5mfnQLANTQPCgL6vFG7eWgoTbhmXPT5E2iJualCbuZy2mB193L6
	OcSqhDF4toOJcqvIOiMneG2QrvWL31NszeUx6a8Gumn1lWKWBVxLr9/nPCwAjuhf
	fY6pzyleWNs+6VSydL9qmBiw0RCsNCbk/28qYj9Ua+8oTLO0d9fcJSmEl2PRpveD
	IuSc3Jd9qzwKrrD41YcdGPyA+TjmiIlpyqYqEwgobE0dnbpPwBE6988LSVztFEH8
	Q3BSpAfZhD9u1rLBw8uQxxsLw0nbGe+sH1ao+44W6nX6W3FrnAiTTrMDmM5N8KpR
	EidZDVhqchQd4ALHobha8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789547158; x=
	1789633558; bh=mNzhb6zN/R3JPWjJEG6KIlVLzjl1vGJ3j4ZmXL2PQVk=; b=w
	fKpFGNGznogpmn7nzP87OSg93GOMg41ZHZ3calLyLxmsoAYZ36VacCbBWGXy+x0d
	VSn/hW5yJcuT0MI4elX00RkAmJ/n2hWMWY9288jzQLgaUnvcsLOzz9RFeUl8bu6C
	8HAg0c4pTyeg304yr+tGetH4AfTaMPWaSLFaMUe1svb8X7DleDvb1Z7Emck9J3PI
	PZhXew3suqBU3B75V5OxwH6NBspzIrYqipkETqFMU1zX/1rmCsBxT5fQjYoccKa3
	eZ5MV003R+GztMEoYd1YbDvDsogjogyi4Ayal4I2AHo2o+Vr3O/sz6gy8vety2sZ
	qZgIv1NxUI1So3mlOZiUg==
X-ME-Sender: <xms:llKqaoXnZQG_73EvK7jNjfwFPIr0Hf0fISC308JH67yKBX2hWrDbfA>
    <xme:llKqalWtKYg-SrK_r6NG6Pu6KstKOmvGhzlAZtY4LdwuQzBNM1P0kzCFYJI-fjx6N
    mlX9NGaHNjcN_4X-h6KXoAm4MRDapqkSYAJgVvzvr3cNzkaZJJWV3cs>
X-ME-Received: <xmr:llKqarFKdDZs3_GI9_9Z5j8jf6WYIU8fFroUiQ8k8kubcS4tC2jWyQpchEvuxfI3zAKBvX5bj3fSD72ypFj_Sw3CM9sXfrI>
X-ME-Proxy-Cause: dmFkZTGPlk8l6A01b8NTZDCmjhWoeD8Z03P5DrMHTQlRTWAwQVTHoih91/j66sk/fphTNt
    36s/TaRfmRD/AnRHob1tTzbk+ibNwI3Ph4xqpI+ktNBFPifqiRO6tbg4UjvND3Z+5Dz0wR
    /By7lYsEYxqifxb/UmlK/hwhwVJ0AJvC6Qe4rOKojzFOJor0qrzRYtz6iBRMRlCQ8Yn9DX
    6Xz4ZYqeJ3RFXWdJUOMhGZZWQoagUY7w+W2OG7x9Q6t0cTilCHMz2/tjOftHlpBfWRmygl
    pxIB4XwUbenlfJ3Gm5uIX7Navy8/JF6+lSwv7ohG6KqbOoeI6Qb5f0Egf+/YFVcYpc2tDl
    8ow3jKfR3qs17FiUQJOzoxoi3iX9p1rh991ZXlQ/ywYOOzArbN1VgMTJi5HSuerZCWA/ZK
    BouR5DESS8xv0CDlWXsNWIY8TzyrE5r6RHeY1EXg3XtZLjVQVkyXIM+8bojJnLf+rekE3U
    lEG4qQd4Br79tKxtiprY2zI3h4A0aGVud3VavhyrRI4FvmdZBXgAYUdbVRk5pRO2sKCuJq
    Gadr9pN4EZgb+DfbaeEkDFS59diQqRnI82q1y0ZY5M5OpGLldvk05xF0SocoRyCcFgimu/
    oyNmIqNkFD0y9t1NL5qiyenHT2MSKysoxbVx8TGUu3/Yyj6nJAuVBJ0YZe6w
X-ME-Proxy: <xmx:llKqaptq5WU9VS7EPndw0-1l1L83dwGcHQd8-tXglKV8HDwI7DY6Fg>
    <xmx:llKqamZlEM04ErnZKdCuC4tiNV9lAM2CTBoIVXVbTV5Gppidf3HXvA>
    <xmx:llKqahWHE_1YOBkpv1HrjIRtUmCsWC5YUXH6ut_TwiZpQPR3k6K85A>
    <xmx:llKqaoJrrx8sFY3T6QoPFCPHVsFNgt3qYNbBVfqLNNs0l9cGIvVtUQ>
    <xmx:llKqamORnZKAkgVVpt5PirA9Plt6Iz9WD1IuIuU30CBytYUnUD_T1_2H>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 04:25:57 -0400 (EDT)
Date: Wed, 16 Sep 2026 10:25:56 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Jakub Kicinski <kuba@kernel.org>
Cc: paul@pbarker.dev, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, sergei.shtylyov@gmail.com,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 02/10] net: ethernet: ravb: Move programming
 of gPTP timer interval
Message-ID: <20260916082556.GO1991210@fsdn.se>
References: <20260909173027.2201560-3-niklas.soderlund+renesas@ragnatech.se>
 <20260915015436.881118-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915015436.881118-1-kuba@kernel.org>

Hello Jakub,

On 2026-09-14 18:54:36 -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: ethernet: ravb: Move programming of gPTP timer interval
> 
> This moves the GTI write and the GCCR.LTI load request out of
> ravb_set_gti() in the main driver logic and into ravb_ptp_init(), so the
> programming happens under priv->lock.  ravb_ptp_init() now also seeds
> priv->ptp.default_addend from priv->gti_tiv instead of reading GTI back
> from the hardware.
> 
> > diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> > index 36173a09e2fd..a89f6fe7866f 100644
> > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > @@ -1846,20 +1846,6 @@ static int ravb_set_config_mode(struct net_device *ndev)
> >  	return error;
> >  }
> >  
> > -static void ravb_set_gti(struct net_device *ndev)
> > -{
> > -	struct ravb_private *priv = netdev_priv(ndev);
> > -	const struct ravb_hw_info *info = priv->info;
> > -
> > -	if (!(info->gptp || info->ccc_gac))
> > -		return;
> > -
> > -	ravb_write(ndev, priv->gti_tiv, GTI);
> > -
> > -	/* Request GTI loading */
> > -	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
> > -}
> > -
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
> > index 43218bc15b15..157fb78209c7 100644
> > --- a/drivers/net/ethernet/renesas/ravb_ptp.c
> > +++ b/drivers/net/ethernet/renesas/ravb_ptp.c
> > @@ -321,11 +321,20 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
> >  
> >  	priv->ptp.info = ravb_ptp_info;
> >  
> > -	priv->ptp.default_addend = ravb_read(ndev, GTI);
> > +	priv->ptp.default_addend = priv->gti_tiv;
> >  	priv->ptp.current_addend = priv->ptp.default_addend;
> >  
> >  	spin_lock_irqsave(&priv->lock, flags);
> > +
> > +	/* Set gPTP Timer Increment Value. */
> > +	ravb_write(ndev, priv->ptp.default_addend, GTI);
> > +
> > +	/* Request GTI loading. */
> > +	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
> > +
> > +	/* Wait for GIT loading to complete. */
> >  	ravb_wait(ndev, GCCR, GCCR_TCR, GCCR_TCR_NOREQ);
> > +
> >  	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
> 
> [Severity: Medium]
> Does this ravb_wait() actually observe the GTI load?  The load request is
> GCCR.LTI, but the poll masks GCCR.TCR, and those are separate fields in
> ravb.h:

Yes. This is the LLM hallucinating.. we write in LTI and pull for 
completion in TCR. I will update the comment to try and address the 
LLM..


> 
> 	GCCR_TCR	= 0x00000003,
> 	GCCR_TCR_NOREQ	= 0x00000000, /* No request */
> 	GCCR_TCR_RESET	= 0x00000001, /* gPTP/AVTP presentation timer reset */
> 	GCCR_TCR_CAPTURE = 0x00000003, /* Capture value set in GCCR.TCSS */
> 	GCCR_LTO	= 0x00000004,
> 	GCCR_LTI	= 0x00000008,
> 
> Setting LTI does not change TCR, and ravb_ptp_tcr_request() both issues and
> waits out its TCR request under priv->lock, so no TCR request is outstanding
> here.  Doesn't that make the poll return on its first read, leaving the
> GTI load unwaited-for?
> 
> If so, could the new comment be reworded?  It describes waiting for the
> increment load, while the wait is really draining a pending TCR request
> before switching GCCR.TCSS.  The comment also spells GTI as "GIT".
> 
> The same reasoning applies to the changelog:
> 
>   "as the first action of the gPTP init function is to wait for the timer
>   interval programming to be acknowledge by the hardware"
> 
> Since that first action polls TCR rather than LTI, does the stated
> justification for the move still hold?  (There is also a typo, "to be
> acknowledge" should be "to be acknowledged".)
> 
> There is a follow-on question about the ravb_modify() immediately after the
> wait.  It is a read-modify-write of GCCR:
> 
> drivers/net/ethernet/renesas/ravb_main.c:ravb_modify() {
> 	ravb_write(ndev, (ravb_read(ndev, reg) & ~clear) | set, reg);
> }
> 
> If LTI is still asserted at that point, doesn't this read it back and write
> it out again, re-issuing the load request while switching the capture
> source?  The driver's own runtime update path treats LTI as the pending
> indicator and declines to touch the registers in that state:
> 
> drivers/net/ethernet/renesas/ravb_ptp.c:ravb_ptp_adjfine() {
> 	gccr = ravb_read(ndev, GCCR);
> 	if (gccr & GCCR_LTI) {
> 		spin_unlock_irqrestore(&priv->lock, flags);
> 		return -EBUSY;
> 	}
> 	ravb_write(ndev, addend & GTI_TIV, GTI);
> 	ravb_write(ndev, gccr | GCCR_LTI, GCCR);
> 	...
> }
> 
> Relatedly, the new code writes GTI without first checking that LTI is
> clear.  On the re-init paths that reach ravb_ptp_init() from
> ravb_set_ringparam() and ravb_tx_timeout_work() (including the "goto out"
> case where ravb_stop_dma() failed and the MAC is still running), can a load
> requested by a preceding adjfine() be overwritten while still in flight?
> Would polling for (GCCR & GCCR_LTI) == 0 before the GTI write, and again
> after requesting the load, be the wait that was intended here?
> 
> This behaviour is unchanged at the end of the series (c7fa563cd046 still
> carries the same comment and the same GCCR_TCR poll).
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the return value of that
> ravb_wait() is discarded, and it was already unchecked before the move.
> ravb_wait() can fail:
> 
> drivers/net/ethernet/renesas/ravb_main.c:ravb_wait() {
> 	for (i = 0; i < 10000; i++) {
> 		if ((ravb_read(ndev, reg) & mask) == value)
> 			return 0;
> 		udelay(10);
> 	}
> 	return -ETIMEDOUT;
> }
> 
> On -ETIMEDOUT the code still programs GCCR.TCSS_ADJGPTP and registers the
> PTP clock, so the capture source can be reprogrammed with a reset/capture
> request still outstanding.  Since ravb_ptp_init() returns void at this
> revision there is nothing to propagate, so this would be a separate change
> rather than something for this patch.
> 
> >  	spin_unlock_irqrestore(&priv->lock, flags);
> >

-- 
Kind Regards,
Niklas Söderlund
