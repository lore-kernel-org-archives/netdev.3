Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0447A889
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032991; cv=none; b=pSE/U0OWdjt4fcEW0kKOYZ0iNBcB0Qewer7jv9huVGEo7JOx2YjdwxNz4ol4V8qEiC5zkxOnrPbaf+Q5Y8p6ilW/UAjFGIJlov8oUBaG6t7sIbY2yWnZCK8KBkTunQSZq9cSdmSxBN3V79YAMTyEXwlZH4AR+Du99uoSgUE1OBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032991; c=relaxed/simple;
	bh=T0kIYN2WaXDteIMhze7dkiKYRuSzu4Ko7YIC3Q7f2Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZaZLiRHNcKUARkgCQ1h+Qm7/cNk3vPV8bGBS+eo0diN4tAa4yyJpfQWI07wPcMKpF3lDiG5jgbGmlaqR+E2AEBEhSZmw6PlTRpSBFR6YkV58z08TDlWQrotW28Dm+auyUy/nx2fFyV3ijmzysm4s+JU6t3lQZ889KfJx5olOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xtLC+8LF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xtLC+8LF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GgLnSrqxUATy7F+NIEgKKNKEEDplCr9ZXoiVMNkSG/o=; b=xtLC+8LFEsIvxeySSK6RHPtlPr
	+IRtcRsj1VxmhVozk22VX1MY/3ayA+5smf/6C4KvhplAjis3ag7Y6PnjIrEfaUxExakXbaNK6v0re
	4G/iN5Wfd55/i8sATxJoIG3hTjZViH0d5savNkaVY1w0jUofg66IESSzGtmyuPOtyzlo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ws0lI-00GPOo-Ha; Thu, 06 Aug 2026 18:16:04 +0200
Date: Thu, 6 Aug 2026 18:16:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: Re: [PATCH net] net: mvneta_bm: fix gen_pool_free address for BPPI
Message-ID: <03d1d8b5-0251-43c9-a48b-8f702733bbeb@lunn.ch>
References: <20260805061438.955717-1-chenguang.zhao@linux.dev>
 <8a46fda8-79a7-44c6-b4ef-2ca66c4dc3c0@lunn.ch>
 <8358b477-5dad-40cf-949b-bac905253be6@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8358b477-5dad-40cf-949b-bac905253be6@linux.dev>

> > The cast is ugly, but it also seems correct. However, can the API be
> > improved. If the intention is
> >
> > gen_pool_free(priv->bppi_pool,
> >               gen_pool_dma_alloc(priv->bppi_pool,
> >                                  MVNETA_BM_BPPI_SIZE,
> >                                  &priv->bppi_phys_addr),
> >               MVNETA_BM_BPPI_SIZE);
> >
> > maybe gen_pool_free() should be changed to take a void *?
> >
> >       Andrew
> Thanks for the suggestion.
> 
> The cast is indeed a bit ugly, but several other drivers free memory from
> gen_pool_dma_alloc() in the same way today.

Flip it around. Are there many calls which don't have the cast?

> Changing gen_pool_free()
> itself to take a void * would touch quite a few call sites, including
> ones that use genalloc for non-pointer cookies, so that may be a larger
> change than we want for this fix.

I agree it is more than just the fix here. But this fix is adding yet
another instance where maybe bad design is forcing a cast.

It should also be quite a mechanical change. Can Coccinelle do the
change needed?

	Andrew
