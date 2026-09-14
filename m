Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1287F41F357
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377576; cv=none; b=dqdCDXqHaKI2hI2hcdrfjOMk7HPSVRUHw2kl0XXs8BKTrMnairmVG3xZXQo+pTqogcAaLmjInczt/iLQWawWDwqimcFeQQ6hXiFkYg72J8GhQ4srVMl47Pv3foWPETK2tEEQX2keKZpypsDQ2M1acMGbK2g/mLmWaYrXzfJC1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377576; c=relaxed/simple;
	bh=DmRpqvyrCOluZseueUiQUCdTDbTLfPvIJOSXL+jjLWE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tubji8SGJcxpn3qJQHyA/4c9hFCcvyTJxDEZqeal35R2yXbF068vkoaSpvJ5jkGRj5Sov8ob1KWSAdyW0XkrJAd5k4/7VchrW7Cq6tzchCZlxgPW2+jn7eS/0LfhydgfmpInvQgdAIvra+GXoaRjnvlnRU/6VlIuR7Vro/Q9ios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=nibXD4On; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="nibXD4On"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C9D2E201E5;
	Mon, 14 Sep 2026 11:19:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8_w2IsnF6mJS; Mon, 14 Sep 2026 11:19:23 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CFCED20758;
	Mon, 14 Sep 2026 11:19:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CFCED20758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789377562;
	bh=IRnlkNdJRxxRxggWTvGu7hhOaMNuulusA/3it/Z+5d8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=nibXD4On5TjsL5IVAxpVwLTyVk9m9J38EaYNPAbuUwAL7jgDKSbjvg1cKkXIJdARl
	 csrj1M3rtuHaUxq3JkM3WyCTR1YlA5ffs4E/c2/byBxRAH5twvxzF5y7ZwapebMMmw
	 5uQrSUsG3TP0DSWB75hQ6GqqHDOHPBUzFGw56EwvyhJpb8JpR2sK0s19KymUIZvy/5
	 HvmMXstX3sw/2+mi+co2uLuIom5KlOCkOM0wYzzN5IUeGob7ATo8LUq09c/jhEpbPi
	 A1Az0Q9Y/D46aO/LwrTk/poleSvvDYa/7HDg+AuZbzf76tUkZJ8Gm9RrgfI0vOv/tH
	 vOMjAmFFsQe6A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 14 Sep
 2026 11:19:22 +0200
Received: (nullmailer pid 1853225 invoked by uid 1000);
	Mon, 14 Sep 2026 09:19:21 -0000
Date: Mon, 14 Sep 2026 11:19:21 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, Henry Martin <bsdhenrymartin@gmail.com>, Christian
 Hopps <chopps@chopps.org>
Subject: Re: [PATCH 04/12] xfrm: iptfs: fix runt reassembly panic from short
 inner tot_len
Message-ID: <aqe8GTMt9jEpzdrx@secunet.com>
References: <20260907093020.2228346-5-steffen.klassert@secunet.com>
 <20260908224855.1591147-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908224855.1591147-1-kuba@kernel.org>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

Ccing Author of the patch and author of IPTFS.

On Tue, Sep 08, 2026 at 03:48:55PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> xfrm: iptfs: fix runt reassembly panic from short inner tot_len
> 
> This tightens the runt continuation path in iptfs_reassem_cont() so the
> declared inner IP length must cover at least the IP header size before the
> in-progress reassembly skb is allocated, replacing the old check against
> sizeof(xtfs->ra_runt). A few questions below on how completely this matches
> the in-place validation, plus two pre-existing observations in the same
> function.
> 
> > diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> > index 2ce15c472cc4d..6920940a35b49 100644
> > --- a/net/xfrm/xfrm_iptfs.c
> > +++ b/net/xfrm/xfrm_iptfs.c
> > @@ -828,8 +828,8 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
> >  		 * allocate an in progress skb
> >  		 */
> >  		ipremain = __iptfs_iplen(xtfs->ra_runt);
> > -		if (ipremain < sizeof(xtfs->ra_runt)) {
> > -			/* length has to be at least runtsize large */
> > +		if (ipremain < __iptfs_iphlen(xtfs->ra_runt)) {
> > +			/* length has to be at least the IP header size */
> 
> [Severity: Medium]
> The changelog says this will "Align the runt path with the normal path by
> requiring the declared inner length to cover at least the IP header size."
> Is that alignment complete for IPv4 with options?
> 
> __iptfs_iphlen() never looks at iph->ihl:
> 
> net/xfrm/xfrm_iptfs.c:__iptfs_iphlen() {
> 	if (iph->version == 0x4)
> 		return sizeof(*iph);
> 	return sizeof(struct ipv6hdr);
> }
> 
> The in-place parser uses the declared header length instead:
> 
> net/xfrm/xfrm_iptfs.c:__input_process_payload() {
> 	...
> 	iplen = be16_to_cpu(iph->tot_len);
> 	iphlen = iph->ihl << 2;
> 	if (iplen < iphlen || iphlen < sizeof(*iph)) {
> 		XFRM_INC_STATS(net, LINUX_MIB_XFRMINHDRERROR);
> 	...
> }
> 
> So a runt-started inner IPv4 packet declaring ihl < 5, or ihl * 4 greater
> than tot_len (for example tot_len 20 with ihl 15), passes the new check,
> gets a 20 byte allocation, is treated as completely reassembled and is
> handed to iptfs_complete_inner_skb() and xfrm_input(), while byte-identical
> input arriving wholly inside one outer payload is rejected with
> LINUX_MIB_XFRMINHDRERROR. Should the runt path also test iph->ihl so the
> two parsers agree on both acceptance and MIB accounting?
> 
> As far as I can tell the residual effect is bounded, since ip_rcv_core()
> drops such a packet:
> 
> net/ipv4/ip_input.c:ip_rcv_core() {
> 	if (iph->ihl < 5 || iph->version != 4)
> 		goto inhdr_error;
> 	...
> 	if (!pskb_may_pull(skb, iph->ihl*4))
> 		goto inhdr_error;
> }
> 
> The panic class described in the changelog (tot_len in [6, 19] making
> "ipremain -= copylen" underflow) does look closed by this change for the
> runt path.

I think this is OK as is. The panic is fixed and it did not add a
regression.

> 
> Also, the kernel-doc on __iptfs_iphlen() says it returns "the IP header
> size based on the IP version", and the new comment here says "length has to
> be at least the IP header size". For IPv4 with options that is the minimum
> header size rather than the header size. Would it be worth rewording either
> the comment or the helper's kernel-doc?
> 
> >  			XFRM_INC_STATS(xs_net(xtfs->x),
> >  				       LINUX_MIB_XFRMINIPTFSERROR);
> >  			goto abandon;
> 
> Two further observations in this same function, both outside the hunk.
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can the copy fallback later
> in iptfs_reassem_cont() still reach skb_over_panic() on the normal
> (non-runt) path?

This is not a regression introduced by this patch. Can be fixed as
followup.
