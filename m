Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD413403F4
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776203; cv=none; b=kQTE3EZxaU8dIiB5+SMzXfCXCB7NGqCbZqYFqtCqW+T045mzkt6If4YQSQxLZaewjggBdffS6o5/jlwJZjtgZBrkYAZchpOPKMpkJRCo2sE5qSKa+yGTjiyg1mzwudHtvWQE4/nJfUdPV0fmxkjW/tMXBhYhb7ReXR4AgbD2O9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776203; c=relaxed/simple;
	bh=odIfeYKKEyimeDVjMKdu22UyryJFl8G+9vQn0ANMEGY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjDXC+ewYgNfnrVHjArISiTInfBK4/Tq+kzsqORM6Tx6sp6ZkdGLB+nYZtMX6oAqM8F/40X3i+Q5uNmz1Tn4hVGg5BBQWmgvtOGLddFhXZ2/YzicqvJmckkALnB0sV+x5XGk3LhTfoZYBO2DwjmEgRELeqRiNdjQK/Mp7/imbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=q8ubts+A; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="q8ubts+A"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 20C5120754;
	Mon,  3 Aug 2026 18:56:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gj2LNtHyq16j; Mon,  3 Aug 2026 18:56:37 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 35D852067A;
	Mon,  3 Aug 2026 18:56:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 35D852067A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785776197;
	bh=NqWOssJVr4ZvTlD4qOCwrX0D1pfEO1Dt/fqXO1wn+X0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=q8ubts+AOu8xPk/Cm2NDl3Bv1iTLdKb0n9UGVyva1muiq8ETFbXPyZR8NM0SfLVhx
	 m5AQP/v3UTqCOGqVmmRUpPgL8uVleDdAfVOGobz9Kfado1qCobvLMNek928H8Mo533
	 gRsebc9V/cm3H73z7qQP01T7tFlKAntoxK+jhRydTjVLCm9ld5G/GczWGnVVv0keD5
	 wZQYbPJ4RwxoyQJECS4YBXZ3fv20inJMkOxS6UO/WJOgydbMeH84oMzRpeeLgrSGHo
	 k3nsb3UgaCzQAA5J71iHqhcZrCDokUXHl9jcwM6Da1bahIrD3Cx6hsn8z1jeFxuMBz
	 JU2MaFCQAYDxg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 18:56:36 +0200
Received: (nullmailer pid 2443329 invoked by uid 1000);
	Mon, 03 Aug 2026 16:56:35 -0000
Date: Mon, 3 Aug 2026 18:56:35 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>, Maher Azzouzi <maherazz04@gmail.com>
CC: <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 2/8] esp: do not unref managed frag pages in
 esp_ssg_unref()
Message-ID: <anDIQ9-8Sf_6StfZ@secunet.com>
References: <20260729065035.1591985-3-steffen.klassert@secunet.com>
 <20260731021544.789075-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260731021544.789075-1-kuba@kernel.org>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

Maher, please look at this review of your patch.

Thanks!

On Thu, Jul 30, 2026 at 07:15:44PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> --- Patch [2]: [PATCH 2/8] esp: do not unref managed frag pages in esp_ssg_unref() ---
> commit 1913e3a658480a2d9a14804dfb34715f589f403d
> Author: Maher Azzouzi <maherazz04@gmail.com>
> 
> esp: do not unref managed frag pages in esp_ssg_unref()
> 
> The patch adds an early return to esp_ssg_unref() in both esp4.c and esp6.c
> so that no per-frag page reference is dropped when the skb carries managed
> frags (SKBFL_MANAGED_FRAG_REFS), mirroring the skip_unref handling in
> skb_release_data().
> 
> A couple of questions on the commit message and on the scope of the guard.
> 
> >     Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> >     Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> 
> [Severity: Medium]
> [Finding: main-1-2]
> [Sources: opus-5]
> 
> Are these the right commits to blame?  Both are dated 2017-01-17, while
> SKBFL_MANAGED_FRAG_REFS and the skb_zcopy_managed() helper used by the new
> guard only arrived with 753f1ca4e1e5 ("net: introduce managed frags
> infrastructure", 2022-07-12, v6.1).
> 
> The esp code as written in 2017 had nothing to be wrong about here; the
> described scenario only becomes possible once managed-frag skbs can reach
> the xfrm output path.
> 
> Since Fixes: tags drive stable and AUTOSEL selection, this points the patch
> at trees older than v6.1, where skb_zcopy_managed() does not exist at all
> (build failure) and where the described scenario cannot happen.  Would the
> commit that made managed-frag skbs reachable from esp_output() be the better
> blame target, or no Fixes: tag plus an explicit stable range?
> 
> > diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> > index dfc81ee969ae0..fa1710e27e505 100644
> > --- a/net/ipv4/esp4.c
> > +++ b/net/ipv4/esp4.c
> > @@ -104,6 +104,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
> >  	struct aead_request *req;
> >  	struct scatterlist *sg;
> >  
> > +	/* Managed frags are owned by the zerocopy ubuf; the skb holds no
> > +	 * per-frag page reference, so we must not drop one here.  Mirrors
> > +	 * the SKBFL_MANAGED_FRAG_REFS handling in skb_release_data().
> > +	 */
> > +	if (skb_zcopy_managed(skb))
> > +		return;
> > +
> 
> [Severity: High]
> [Finding: main-1-0]
> [Sources: opus-5]
> 
> Does this early return also suppress the release of the trailer page that
> ESP itself referenced?
> 
> The src scatterlist looks like it has mixed ownership.  Besides the
> ubuf-owned payload frags, esp_output_head() adds a trailer frag with an
> explicit reference in the only branch that sets esp->inplace = false:
> 
> net/ipv4/esp4.c:esp_output_head() {
> 	...
> 			page = pfrag->page;
> 			get_page(page);
> 	...
> 			__skb_fill_page_desc(skb, nfrags, page, pfrag->offset,
> 					     tailen);
> 			skb_shinfo(skb)->nr_frags = ++nfrags;
> 	...
> }
> 
> esp_output_tail() then drops that frag from the skb entirely:
> 
> net/ipv4/esp4.c:esp_output_tail() {
> 	...
> 		skb_shinfo(skb)->nr_frags = 1;
> 
> 		page = pfrag->page;
> 		get_page(page);
> 		/* replace page frags in skb with new page */
> 		__skb_fill_page_desc(skb, 0, page, pfrag->offset, skb->data_len);
> 	...
> }
> 
> so the loop in esp_ssg_unref() appears to be the only remaining release
> site for that trailer reference.  skb_release_data() cannot reach the
> orphaned frag, and for SKBFL_MANAGED_FRAG_REFS it takes the skip_unref
> branch to free_head anyway.
> 
> Both esp_ssg_unref() call sites in esp_output_tail() are affected: the error
> path
> 
> 		if (unlikely(err < 0)) {
> 			esp_ssg_unref(x, tmp, skb, true);
> 
> and the success path
> 
> 	if (sg != dsg)
> 		esp_ssg_unref(x, tmp, skb, false);
> 
> Note the loop only ever ran in exactly that non-inplace case
> (already_unref || req->src != req->dst), which is also the case that adds
> the trailer frag.  So does the get_page() from esp_output_head() stay
> unbalanced for a managed-frag skb?
> 
> Since a single stray reference pins the whole high-order x->xfrag
> page_frag page, would every x->xfrag page used for trailers become
> unfreeable, at packet rate?
> 
> Would it be better to distinguish ubuf-owned frags from the ESP-added
> trailer frag, for instance by calling skb_zcopy_downgrade_managed(skb)
> before ESP mutates the frag array, the way __ip_append_data() and
> __ip6_append_data() do, rather than skipping the unref wholesale?
> 
> Related to that, the new comment says "the skb holds no per-frag page
> reference".  Is that accurate?  It holds true for the ubuf-owned frags, but
> not for the trailer frag ESP added with get_page().
> 
> [Severity: High]
> [Finding: main-1-1]
> [Sources: opus-5]
> 
> This isn't a bug introduced by this patch, but it is the invariant the
> guard works around, and it stays unfixed: esp_output_tail() replaces the
> frag array of a managed-frag skb with a page it references itself, while
> SKBFL_MANAGED_FRAG_REFS remains set:
> 
> net/ipv4/esp4.c:esp_output_tail() {
> 	...
> 		skb_shinfo(skb)->nr_frags = 1;
> 
> 		page = pfrag->page;
> 		get_page(page);
> 		/* replace page frags in skb with new page */
> 		__skb_fill_page_desc(skb, 0, page, pfrag->offset, skb->data_len);
> 	...
> }
> 
> That destination page reference is owned by frag 0, but with the flag still
> set skb_release_data() takes the skip_unref branch:
> 
> net/core/skbuff.c:skb_release_data() {
> 	...
> 	if (skb_zcopy(skb)) {
> 		bool skip_unref = shinfo->flags & SKBFL_MANAGED_FRAG_REFS;
> 
> 		skb_zcopy_clear(skb, true);
> 		if (skip_unref)
> 			goto free_head;
> 	}
> 	...
> }
> 
> so is that reference ever dropped?  Neither net/ipv4/esp4.c nor
> net/ipv6/esp6.c calls skb_zcopy_downgrade_managed(); the canonical way to
> make a managed-frag skb safe for frag mutation and per-frag unref is:
> 
> net/core/skbuff.c:__skb_zcopy_downgrade_managed() {
> 	skb_shinfo(skb)->flags &= ~SKBFL_MANAGED_FRAG_REFS;
> 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
> 		skb_frag_ref(skb, i);
> }
> 
> which every other frag-mutating site uses (net/core/skbuff.c,
> net/ipv4/ip_output.c, net/ipv6/ip6_output.c, net/ipv4/tcp.c).
> 
> Would a single skb_zcopy_downgrade_managed(skb) before ESP touches the
> frags address both the original refcount underflow and this leak, instead
> of leaving a mixed managed/refcounted frag array as an ESP-specific special
> case?  In that light, is the commit message statement "The rest of the
> stack honours this invariant" only half applied here?
> 
> >  	if (x->props.flags & XFRM_STATE_ESN)
> >  		extralen += sizeof(struct esp_output_extra);
> >  
> > diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> > index 296b57926abb9..7d216b9c59f04 100644
> > --- a/net/ipv6/esp6.c
> > +++ b/net/ipv6/esp6.c
> > @@ -121,6 +121,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
> >  	struct aead_request *req;
> >  	struct scatterlist *sg;
> >  
> > +	/* Managed frags are owned by the zerocopy ubuf; the skb holds no
> > +	 * per-frag page reference, so we must not drop one here.  Mirrors
> > +	 * the SKBFL_MANAGED_FRAG_REFS handling in skb_release_data().
> > +	 */
> > +	if (skb_zcopy_managed(skb))
> > +		return;
> > +
> 
> [Severity: High]
> [Finding: main-1-0]
> [Sources: opus-5]
> 
> Do both questions above apply identically to the IPv6 copy?
> esp6_output_head() takes the same get_page() for the trailer frag,
> esp6_output_tail() performs the same nr_frags = 1 frag replacement, and both
> esp_ssg_unref() calls (already_unref == true in the skb_to_sgvec() error
> path, and the sg != dsg call after encryption) return early here too.
> 
> >  	if (x->props.flags & XFRM_STATE_ESN)
> >  		extralen += sizeof(struct esp_output_extra);
> >
