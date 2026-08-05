Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9597C13B293;
	Wed,  5 Aug 2026 02:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896191; cv=none; b=otZ54Tezx0pIIlLh0xA3MF5bBrCGdin+viJJ9wDyo+Jvcw8AjQdDA0DMQ81Xc9Ax6S2ZWv8EG/GkitVLc6L3q6mjEGBbD+vV7esevUK4M2hYAKiyqZSHp3OfzswtK/x0mIfBf6KMcIAuliT6SfSANRuOgHJ34UZ3D5NMW3nUyWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896191; c=relaxed/simple;
	bh=VnQkekESFii1X2Vskm6pxkJV/5SA9hR2k0ndu0FBadU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baPEZ9n/8pvWrqWC5fkTG5HM/r7gEauLnCnqnoTqYScgq2QAKMSMbeo85DOmPumglKIt2r4jwHmX1AsRS1a6WxWchm+285SD6beHunSH+ufOXBbrjesEflNGbx3KEKgINMLF674R/BKAgJcboxjFLqaOF0nvTxrPgERKnWpbnkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHHNyS9a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHHNyS9a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EE31F000E9;
	Wed,  5 Aug 2026 02:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896190;
	bh=X7KNpUcS5hg5+5+jaN8Ml1UGUdjmv7GCemk4lP0cN4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bHHNyS9adp4M+4T5BPaoDL1AmYmPwp0XBXrYOQzsUAmczlx1mmLzlmxu9rxSjx93f
	 Y3KU1nF+42XN7br16dqm8Equh9qfCVebd5UrQF56ZCimddFg19q8v7FG5ST/9o+4I5
	 +BR6dEeJjPhek1vwkYwsgix+38sCLcizZHv3LeQfzbvrRLOzwYV/vnDrzbAZmV54jQ
	 R1JNY7Del48bXJ8ugrkCAL1GRkSfWoU6wZwJdKIMa+6EfGxRk1Ob4Q9CpICXdLBxjZ
	 kL5pClYo66q2Zg/CstyFCHwnGxk/IKiIlaG4yP06be8vYVPk+jRfNSfC9BRZJ6ldCi
	 o9UTD1zPRPumw==
Date: Tue, 4 Aug 2026 19:16:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
 toke@redhat.com, shenjian15@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, yangshuaisong@h-partners.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net] net: page_pool: fix UAF in
 __page_pool_release_netmem_dma on xa_cmpxchg race
Message-ID: <20260804191628.762ec7eb@kernel.org>
In-Reply-To: <CAHS8izPpwz=swSXJZhnVFvTeu43WBhtRv7PmC_OQ0XzG8no8bQ@mail.gmail.com>
References: <20260731111507.2355601-1-shaojijie@huawei.com>
	<CAHS8izPpwz=swSXJZhnVFvTeu43WBhtRv7PmC_OQ0XzG8no8bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 10:37:58 -0700 Mina Almasry wrote:
> > +       __page_pool_unmap_netmem_dma(pool, netmem);
> >         page_pool_set_dma_addr_netmem(netmem, 0);
> > +       if (likely(PP_DMA_INDEX_BITS))
> > +               netmem_set_dma_index(netmem, 0);  
> 
> I now notice that maybe another cleanup we could have done is open
> code __page_pool_unmap_netmem_dma() in this function to cut down 1
> helper, and just have the scrub function call
> __page_pool_release_netmem_dma() to reduce some code. But this is more
> than fine too I think, especially since this is a fix the stable trees
> are going to want I guess.

Not sure this is a good idea? scrub is trying to touch just the DMA
mapping, right? It shouldn't try to update the page itself because
it has no reference to the page, the page may get freed in parallel.
Hopefully DMA unmap on a freed page is legal..
