Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21AB2AE78
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154863; cv=none; b=O+3P65cqsDFV1fkZxwfCUYZHImRaysOrNg/QvSAD1gVkNnpBfC4lsxQt1e4uQDk390qQdIrBieUen6nZEzuUEyFz/cifc/OafWG9CTsyFGO3okK0bK+66EMNl3pXfHI5nU6ax8/2sDFTe9lIdroYahb0bB2jctML7Un8AxREJeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154863; c=relaxed/simple;
	bh=wFUxiSQrjhgg1LqLsImPUk7bWXvDpxCTcBCCMQuppO4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUOocGUV/jnzMkKrVzmLSFMD4L36+Y0FvLFfs2xvD10PzU74tINdzKkK2lkR733XZUNEDPQcpgMX8+gDpvSetZShU69Ex4lJztnoUsHKuaViVsv8xfl1kk48cT8QhQq6r9poWvd+/zbwYkDXLfmTUznVXuHkEdmf4tmmjtW9drc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Z/YpPcLq; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Z/YpPcLq"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id BA1882069C;
	Mon, 27 Jul 2026 14:20:58 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cUKV7o8uqfuu; Mon, 27 Jul 2026 14:20:58 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1C6DD206D2;
	Mon, 27 Jul 2026 14:20:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1C6DD206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785154858;
	bh=I3UAhik44KqbRaY175Ph+jAAj1wVKvW7kA2+6Oy9gWs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Z/YpPcLqEZ9e7o3b2HkH3c5/0HU3eBH01VxntnlLfK4xxv+F7MVabg1e8Bh6blR91
	 agh71Id4QLq83NKsDUhWVLrR4xPbz558UFd+IzvjCcQ0FZJ3nBsx+EIdIiFD108OjZ
	 xIic9koZhwGFDyUkpl7FOWmHNLMiOLXRncZSLu4KVm4RjjY7WCzyp8kcu+d+9ntWiX
	 nT9R0z2eThNtlGDfrFVOmjVosRp4f5F1SXo211I9WLYIrGx2bVJJENU114LPlQCPxH
	 pb+TE1fXi4AMgp1OJ5eQYP9g4++FVwLA06g2d0I8yT/bP8x9pZnv/CvFaMpRjBMJO1
	 E0t1x/WFf6DIA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 27 Jul
 2026 14:20:57 +0200
Received: (nullmailer pid 4023483 invoked by uid 1000);
	Mon, 27 Jul 2026 12:20:56 -0000
Date: Mon, 27 Jul 2026 14:20:56 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Ashish Kunwar <ashishkunwar280@gmail.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
Subject: Re: [PATCH v2] xfrm: fix TOCTOU race in per-CPU state cache add path
Message-ID: <amdNKFJzzxj2OM2i@secunet.com>
References: <CACk7sWd8q8Go4BEBNiVstgJpK6FvC4myj6yNEHdOMEE9QaB3Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACk7sWd8q8Go4BEBNiVstgJpK6FvC4myj6yNEHdOMEE9QaB3Vg@mail.gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Jul 27, 2026 at 05:46:21PM +0530, Ashish Kunwar wrote:
> xfrm_input_state_lookup() checks x->km.state == XFRM_STATE_VALID
> without holding xfrm_state_lock, then acquires the lock and adds the
> state to the per-CPU state_cache_input list. A concurrent
> __xfrm_state_delete() on another CPU can set km.state to DEAD and
> remove the state from the cache between the check and the lock
> acquisition. The lookup then re-adds the now-DEAD state to the cache.
> 
> After GC frees the xfrm_state, the per-CPU cache holds a dangling
> pointer. The next inbound packet that iterates the cache dereferences
> freed slab memory.
> 
> The same pattern exists in xfrm_state_find() for the outbound
> state_cache.
> 
> Fix both by re-checking km.state inside the lock before adding the
> state to the cache. For xfrm_input_state_lookup, a DEAD state must
> not be returned to the caller, so drop the refcount and return NULL.
> For xfrm_state_find, fold the state check into the existing
> conditional so the cache insertion is simply skipped.
> 
> Fixes: 81a331a0e72 ("xfrm: add an inbound state cache")
> Signed-off-by: Ashish Kunwar <ashishkunwar280@gmail.com>
> ---
> v2: Rebased, fixed outbound path to use proper conditional instead of
> empty statement. Submitted to netdev per Steffen's feedback.
> ---
> net/xfrm/xfrm_state.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 1748d37..d8a9cd1 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1230,6 +1230,12 @@ struct xfrm_state *xfrm_input_state_lookup(struct
> net *net, u32 mark,
> 
> if (x && x->km.state == XFRM_STATE_VALID) {
> spin_lock_bh(&net->xfrm.xfrm_state_lock);
> + if (x->km.state != XFRM_STATE_VALID) {
> + spin_unlock_bh(&net->xfrm.xfrm_state_lock);
> + xfrm_state_put(x);
> + x = NULL;
> + goto out;
> + }
> if (hlist_unhashed(&x->state_cache_input)) {
> hlist_add_head_rcu(&x->state_cache_input, state_cache_input);
> } else {
> @@ -1622,7 +1628,8 @@ out:
> if (x && x->km.state == XFRM_STATE_VALID && !cached &&
> (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) || x->pcpu_num == pcpu_id)) {
> spin_lock_bh(&net->xfrm.xfrm_state_lock);
> - if (hlist_unhashed(&x->state_cache))
> + if (x->km.state == XFRM_STATE_VALID &&
> + hlist_unhashed(&x->state_cache))
> hlist_add_head_rcu(&x->state_cache, &pol->state_cache_list);
> spin_unlock_bh(&net->xfrm.xfrm_state_lock);
> }

Your mailer removed all indentations.
