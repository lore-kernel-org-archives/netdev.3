Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C8394EBA
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382283; cv=none; b=XXxgKJKsUYwXa0AId1sk2dKyy4uKKedOzS87YLzlkIFKXWOGsas4fENl10sPg0XgNmhTeUJgQcwYVvVUOpiDnReVThPDdBl4k4oM82I/Xgbx1/FAcIoIP5MpkNCtGNAA56uYqR67hW2r+dEjxm5TO0rQeTlFO5HVJ8fhwjMVW2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382283; c=relaxed/simple;
	bh=vaKiVp0WWTteSwTiV1GcSwZBtksCPRHJTVPmkc0AOuY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG2Auyth2HsqtzeohZZkW+LpZajYPKt/Z6r+pfybbpTStrmK7s5h/mQoQI90pnXsFNe1tGSBYkauDcxNII+cvyec+wllfButA/Bti8ChJ00/lL0cyE02t6KKGK51FPPmV2mBrGL+WkeDJPxIdH2fgoP4GnqsLIulVRXdAdeWNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=DUvUanuj; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="DUvUanuj"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 183CF2082E;
	Mon, 14 Sep 2026 12:37:59 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6EBfTsnrVra0; Mon, 14 Sep 2026 12:37:58 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B210020860;
	Mon, 14 Sep 2026 12:37:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B210020860
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789382276;
	bh=uzJsiXZHGQL26SSQfWfpXj3el1HoTp4b9otVfnOZotY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=DUvUanuj8DotmALxQWBaPEiE9i1hBB7TRrfdNL+JtWzf97YXth2EfNeKA7a7X2HCJ
	 Q16stQJ6OEUieLP6U7eI8QKKMHNI80Wflcyg9qqqV2IwOjUnU8fBIvFaO5V3t4x7An
	 va19G5Dnce7bVGYlZle0lX8z70j9Hz1S3sYd3SUa0bvv+5qjqlXqVfGnUoT4Zj23HA
	 vL1JU47gMRY+qzNSWe/UY4+5rCDJTtj0DoWEQANo5sdtlskjw3vQLYxJAUZ+/jq5jD
	 phX/zw+Soyy13cfMPSqNEivdPcTbd/eqbe9GjvoqQAy0wiUYHm8qoP6TIK0Wz6A9Co
	 cvF1YuM10j7og==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 14 Sep
 2026 12:37:56 +0200
Received: (nullmailer pid 1920493 invoked by uid 1000);
	Mon, 14 Sep 2026 10:37:55 -0000
Date: Mon, 14 Sep 2026 12:37:55 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, Roshan Kumar <roshaen09@gmail.com>, Christian Hopps
	<chopps@labn.net>
Subject: Re: [PATCH 01/12] xfrm: iptfs: fix stack OOB read in
 iptfs_skb_reset_frag_walk()
Message-ID: <aqfOg-hbkOP3kwW5@secunet.com>
References: <20260907093020.2228346-2-steffen.klassert@secunet.com>
 <20260908224803.1587019-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908224803.1587019-1-kuba@kernel.org>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

Ccing Author of the patch and author of IPTFS.

On Tue, Sep 08, 2026 at 03:48:02PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> xfrm: iptfs: fix stack OOB read in iptfs_skb_reset_frag_walk()
> 
> This adds an up-front range check to iptfs_skb_can_add_frags() so that
> iptfs_skb_reset_frag_walk() is never entered with an offset at or beyond
> the end of the walk's fragment data, where its unbounded advance loop
> would read past walk->frags[]. The guard mirrors the one already present
> in iptfs_skb_add_frags().
> 
> > diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> > index 597aedeac26eb..2ce15c472cc4d 100644
> > --- a/net/xfrm/xfrm_iptfs.c
> > +++ b/net/xfrm/xfrm_iptfs.c
> > @@ -416,6 +416,14 @@ static bool iptfs_skb_can_add_frags(const struct sk_buff *skb,
> >  	if (skb_has_frag_list(skb) || skb->pp_recycle != walk->pp_recycle)
> >  		return false;
> >  
> > +	/* Reject an @offset that is at or beyond the end of the walk's data
> > +	 * before calling iptfs_skb_reset_frag_walk(), whose fragment-advance
> > +	 * loop is otherwise unbounded and would index past walk->frags[].
> > +	 * This mirrors the guard already present in iptfs_skb_add_frags().
> > +	 */
> > +	if (!walk->nr_frags || offset >= walk->total + walk->initial_offset)
> > +		return false;
> > +
> 
> [Severity: Medium]
> 
> Should this return true (or be conditioned on len) instead of false?
> 
> In the iptfs_reassem_cont() path the walk is prepared and then queried
> with the same offset:
> 
> net/xfrm/xfrm_iptfs.c:iptfs_reassem_cont() {
> 	...
> 	fraglen = min(blkoff, remaining);
> 	copylen = min(fraglen, ipremain);
> 
> 	if (!skb_has_frag_list(skb) && !skb_has_frag_list(newskb) &&
> 	    (skb->head_frag || skb->len == skb->data_len) &&
> 	    skb->pp_recycle == newskb->pp_recycle) {
> 		fragwalk = &_fragwalk;
> 		iptfs_skb_prepare_frag_walk(skb, data, fragwalk);
> 	}
> 
> 	if (fragwalk &&
> 	    iptfs_skb_can_add_frags(newskb, fragwalk, data, copylen)) {
> 	...
> }
> 
> Since offset == walk->initial_offset == data here, the new clause reduces
> to walk->total == 0, and iptfs_skb_prepare_frag_walk() sums exactly
> skb->len - data, so it only fires when data == skb->len, i.e. when
> remaining == 0 and therefore copylen == 0 as well.
> 
> For that case the guard now sends control into the else branch:
> 
> 	} else {
> 		if (skb_linearize(newskb)) {
> 			...
> 		}
> 
> 		/* copy fragment data into newskb */
> 		if (skb_copy_seq_read(st, data, skb_put(newskb, copylen),
> 				      copylen)) {
> 			XFRM_INC_STATS(xs_net(xtfs->x),
> 				       LINUX_MIB_XFRMINBUFFERERROR);
> 			goto abandon;
> 		}
> 	}
> 
> with copylen == 0 and data == skb->len.  skb_copy_seq_read() calls
> skb_seq_read() before it looks at len:
> 
> net/core/skbuff.c:skb_copy_seq_read() {
> 	for (;;) {
> 		sqlen = skb_seq_read(offset, &data, st);
> 		if (sqlen == 0)
> 			return -EINVAL;
> 		if (sqlen >= len) {
> 	...
> }
> 
> and skb_seq_read() returns 0 once abs_offset >= st->upper_offset, so the
> zero-length copy returns -EINVAL and iptfs_reassem_cont() takes the
> abandon label, where iptfs_reassem_abort() frees xtfs->ra_newskb and
> destroys the in-progress inner packet reassembly.
> 
> Before this patch the same input took the sharing branch: can_add_frags()
> fell through its "while (len && fragi < walk->nr_frags)" loop with len == 0
> and returned true, iptfs_skb_add_frags() returned immediately via its own
> !walk->nr_frags check, and reassembly continued via
> "if (copylen < ipremain) xtfs->ra_wantseq++;".
> 
> Two inputs from a peer on an IPTFS SA appear to reach this: an AGGFRAG
> payload carrying only the basic/CC header with block_offset >= ipremain
> while a reassembly is in progress, and the "newskb->len < iphlen" block
> copying exactly iphremain == remaining bytes so that "data += copylen"
> leaves data == skb->len.
> 
> Would a guard on len, for example returning true when len == 0 and only
> rejecting when there is data left to add, close the stack out-of-bounds
> read without changing the reassembly outcome?

This might make the IPTFS reassembly inefficient. But as my knowledge
of IPTFS is limited and I don't get reviews from the original author,
I plan to keep this fix.
