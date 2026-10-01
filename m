Received: from oak.phenome.org (oak.phenome.org [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4889C4DAFB5
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846568; cv=none; b=kalAQgrApcWJ5viie5xvBxWacfbPd3LWK78w5Xa2ev0G4SL5o9LPN85bP3/nARmtxHFWWyXsJUckb2BOiAHrvC9xGleO48aPGrcOWNA6J48DEiFPSLPmLDMo7pWJ02V08wimvB3VO2KwAiqAIdTdMUlwUnTmSLF8diHN+t4ixZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846568; c=relaxed/simple;
	bh=FfNIz3mJGt7wznRkDRvi6IKM9jWpUreCDqsqrLqFSg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc0yKgKj06rOCvZT4kU9yUH/A9oeo2kJlpEeav+vNm3mHIOL91I7dNeik2uiQ8eHzNoJ0zrv5SPkl2GD0mmfGauq4IZ6HTD+JFAL8kWozM8L9fDGJ7NICfh+tSsAKDJuWBpPIuscQzwEByJjs/WQ3bhpgr8MFRJbOeRITVKtB2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=IdQ9RpzO; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="IdQ9RpzO"
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1790846056; x=1791710057; bh=FfNI
	z3mJGt7wznRkDRvi6IKM9jWpUreCDqsqrLqFSg8=; b=IdQ9RpzOlvZI0dXcubXw
	93JBhErC/YgFhfWDo3SPXG0URxhrBna/SkWUfABhzGrCdpIbIwu8a5Dd+WH5BsbU
	Tu6sMyLHiGFnitS6+xMV3zYEXW4OKXeSZMevFUByyfAC5NtnXbptiiks36uXKShE
	2G4XvImGwgze2DzQE7cLMLBcYvTylGoIBQdmrN6Csxbjx+XvIouWY7iL0taDrx98
	yk/IFbLbpJP3gZUHh7vyS79aQObYIQ/jcluRi0Dsbl+6aoUu3Ihf2KOInm4SOhr3
	KOJO0LYUxaJ7fv8zUhV0XhIkUins54SOaCGQZ1tqdRhrIECwIUFClSXTXrdXLMrw
	+g==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Thu, 01 Oct 2026 11:14:13 +0200 (CEST)
Date: Thu, 1 Oct 2026 11:14:11 +0200
From: Antony Antony <antony@phenome.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Antony Antony <antony.antony@secunet.com>,
	Christian Hopps <chopps@labn.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH ipsec v3] xfrm: iptfs: fix pp_ref_count underflow when
 sharing page_pool frags
Message-ID: <ar4kY4_9NjKq_hIr@Antony2201.local>
References: <xfrm-iptfs-pp_ref_count-underflow-v3-1-9266ddaf3129@secunet.com>
 <arynw0nTgPsIHCUR@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arynw0nTgPsIHCUR@secunet.com>
X-Mutt-References: <arynw0nTgPsIHCUR@secunet.com>
X-Mutt-Fcc: ~/sent

On Wed, Sep 30, 2026 at 08:10:11AM +0200, Steffen Klassert wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> commit a719ecd0c8cfff38a8b6302ad3d654603fe9e7d1
> Author: Antony Antony <antony.antony@secunet.com>
> 
> xfrm: iptfs: fix pp_ref_count underflow when sharing page_pool frags
> 
> This commit modifies xfrm iptfs packet processing to correctly track page_pool
> references for shared fragments. It introduces iptfs_frag_ref() to selectively
> bump the page_pool reference when the destination has pp_recycle set and the
> fragment is owned by page_pool.
> 
> Link: https://patchwork.kernel.org/project/netdevbpf/patch/xfrm-iptfs-pp_ref_count-underflow-v1-1-5fb363833d41@secunet.com/
> Link: https://lore.kernel.org/all/xfrm-iptfs-pp_ref_count-underflow-v1-1-47b319c6d2f6@secunet.com/
> 
> > diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> > index 6920940a35b49..229f84ac6a31b 100644
> > --- a/net/xfrm/xfrm_iptfs.c
> > +++ b/net/xfrm/xfrm_iptfs.c
> [ ... ]
> > @@ -449,6 +450,20 @@ static bool iptfs_skb_can_add_frags(const struct sk_buff *skb,
> >  	return true;
> >  }
> >  
> > +static void iptfs_frag_ref(skb_frag_t *frag, bool recycle)
> > +{
> > +	struct page *head;
> > +
> > +	if (recycle && !skb_frag_is_net_iov(frag)) {
> > +		head = compound_head(skb_frag_page(frag));
> > +		if (page_pool_page_is_pp(head)) {
> > +			page_pool_ref_page(head);
> > +			return;
> > +		}
> > +	}
> > +	__skb_frag_ref(frag);
> > +}
> 
> Does skipping net_iov fragments here cause a reference counting mismatch?
> 
> If a devmem net_iov fragment is processed by iptfs_frag_ref(), the check
> !skb_frag_is_net_iov(frag) evaluates to false. This bypasses the page_pool
> reference tracking and forces the fragment into the fallback path, which
> increments the dmabuf_binding refcount via __skb_frag_ref().
> 
> However, when the destination SKB (with pp_recycle=true) is later freed,
> skb_frag_unref() calls napi_pp_put_page(). Since netmem_is_pp() evaluates
> to true for devmem fragments, this erroneously decrements the pp_ref_count
> instead of releasing the binding refcount.
> 
> Could this lead to a pp_ref_count underflow and use-after-free of devmem
> buffers during IPsec packet processing?

Possibly. I could not reproduce the devmem/netmem path and have no way
to test it here, which is why I left it out of this patch rather than
guess at a fix.

The issue this patch addresses is hit with a virtio NIC when traffic
running on two different physical hosts over network; I reproduced it and tested
the fix in that setup.

I see two options: apply v3 as is, or

I send a v4 that also handles devmem by following which I can only
compile-test. I'm fine with either; please let me know which you
prefer. Are there any devmem experts who could reveiew or test it?

I guess the following could work  for devmem
if (skb_frag_netmem(frag)) {
	page_pool_ref_netmem(netmem);
	return;
}
