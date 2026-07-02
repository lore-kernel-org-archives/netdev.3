Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6528CF6F
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987476; cv=none; b=bAeaNVwAK5zy2pecQytpZjtIYt1JFNxojcc2AnZMTYM+ZjP+KXK2OMaipEmGnyc1/910XK0X2Cov2ld9C8hxvs59Yk76D42kPiXCQO7TE0ukDs3odAUX2VmlZHNsY5vbwMtgxAT021RRdHgXHiF06JDp/DYI0lmItkPGLD1W6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987476; c=relaxed/simple;
	bh=X1iC97eUSPuQXlgakRjY9VBk8mEq2sDcNORENhgPlGI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=lrNuQy5rfFsEN3eZhPxrBdaKpqSlHiDYOnhkRx3Ku4DJIl22xv1Trki/jdJshAVnsDl22Ee+iM/szQz9Qkj8yQQ5ouZqnWtQdu+eGKSdnmnkB8WgW1HJnNWP5sr4y4aKYDvDhnM6wyHPFq8COFGQR0cP2ta8h7rMCeI+d3yVRKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YBujIPJo; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YBujIPJo"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260702101745euoutp01542527eebcaca2f1ae64bc61543ead05~_cacvMCij1739417394euoutp01l
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:17:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260702101745euoutp01542527eebcaca2f1ae64bc61543ead05~_cacvMCij1739417394euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782987465;
	bh=kwG2TG20wXUcOw/yFt5rURuaMwy9sdR9dNRrfe6/MxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YBujIPJoOWWQV9lakUl5Yk2UFjFCSqs0V6M+3JqW8IQLMrQGLoq5d70t75iPQ3Aey
	 vrJHGejGVXxDkSzpbdh3pm04wtZD9PtB90EsaAs3rzz1RhHbXBtR52GanTbxDN9g20
	 Z/ShITQ3yCJ+IjLMcqRdkRoqiSM5jESMUpxIy2WU=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260702101744eucas1p1a97532a37be582391eeeb673254ef2dc~_cacYvQ9j1877718777eucas1p1U;
	Thu,  2 Jul 2026 10:17:44 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260702101744eusmtip2cd23e3f0ea6009b91f26dbe1d232c91f~_cabz5FjD1223012230eusmtip2w;
	Thu,  2 Jul 2026 10:17:44 +0000 (GMT)
Date: Thu, 2 Jul 2026 12:17:40 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
	k.tegowski@samsung.com, k.domagalski@samsung.com, Yashwant Varur
	<yashwant.v@samsung.com>
Subject: Re: [PATCH net] net/stmmac: Set Rx queue page_pool to NULL when
 freeing DMA resources
Message-ID: <akY6xLKAnpxwAct4@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1e4cedb5-fc16-4007-9a11-8c819f2c5731@bootlin.com>
X-CMS-MailID: 20260702101744eucas1p1a97532a37be582391eeeb673254ef2dc
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_100cf9_"
X-RootMTR: 20260630101157eucas1p1b1cef0db9381391bdd9400f1d255ce49
X-EPHeader: CA
X-CMS-RootMailID: 20260630101157eucas1p1b1cef0db9381391bdd9400f1d255ce49
References: <CGME20260630101157eucas1p1b1cef0db9381391bdd9400f1d255ce49@eucas1p1.samsung.com>
	<20260630100953.747868-1-j.raczynski@samsung.com>
	<1e4cedb5-fc16-4007-9a11-8c819f2c5731@bootlin.com>

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_100cf9_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Jul 02, 2026 at 11:24:41AM +0200, Maxime Chevallier wrote:
> >  
> >  	kfree(rx_q->buf_pool);
> > -	if (rx_q->page_pool)
> > +	if (rx_q->page_pool) {
> >  		page_pool_destroy(rx_q->page_pool);
> > +		rx_q->page_pool = NULL;
> > +	}
> 
> page_pool_destroy can be passed NULL, as you're fixing this I think you might as well
> drop the if(rx_q->page_pool) at the same time :) I agree with the change otherwise.
> 
> with that changed,
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Maxime
>

Agreed, will send V2 soon.

BR
Jakub Raczynski 

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_100cf9_
Content-Type: text/plain; charset="utf-8"


------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_100cf9_--
