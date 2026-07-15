Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5873E51EF
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110383; cv=none; b=ZCQxX6RbLPoB+/fVBt5xmNVBsKvsx8GCnzMW/I+czqVy6L2gn7zgNwkjGasftqB1n29D+P2QSrtRhHaSeHrevcOhBFNPFTQ+mCCZCIcC7I2QOxX95Gg9p9bonFcD/cFzJnI5RRTlr4BoCUZCLorBUmhu8YxMT5/vZ2qbDkDcxts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110383; c=relaxed/simple;
	bh=LFCEaDlwL9cNp9v1FObooaiKQquWh/FRDHIhUalHqew=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOIz6a4bsXY2LAUd6Tb14LnvagPeojEu1+fKS/wX6cVC9/xif4NtqWgYoZXzID0YJDdsQBIMDNs7QnHyj87U45GnmPmu2IzW0zZelNiTdz+RJSOeV1IQz9l9ho45EODRHRu1kH0VY0r6wJKvq8y4jxH1rAnSfkltLyIiwaPrtC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=u2L4GyO4; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="u2L4GyO4"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2296820704;
	Wed, 15 Jul 2026 12:12:52 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 51TTMTvMCrsd; Wed, 15 Jul 2026 12:12:51 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 78F07205CF;
	Wed, 15 Jul 2026 12:12:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 78F07205CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1784110371;
	bh=QveCguXAVzVCk9cJnko5Xk0qUwVgWcQY/UdWt24PyBQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=u2L4GyO4vx9sIm054l4+KvG5dzj31dtKFScD3VzPhNkcjBGmmRkD8/4273Tddx0WZ
	 RRSm1YiPE96YfJZUea8N0GX3YrFOpsKhUTRGglaMxjt+MK/rHQ2J7Ic6FVzofB8JF4
	 858P0za+AlnPGrIjsYZXi0emfIFcJSZugxTIZkSS+ZrzBfEiglP60kbBj7lN5s8DH0
	 pQ9yhc6olCNzLY8kR84lZsM8USTvIbE0gVaSrP9iX6sXqkJrtGWVzvgdSG5VAOhb1u
	 EnkBXFNQnwPLpTQePkctN3MbOMtk/dqmjt75j42MZb5tJAq/c7RYThTcyF+fi7GMmm
	 aEYnIvaMr0cjA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 15 Jul
 2026 12:12:51 +0200
Received: (nullmailer pid 699358 invoked by uid 1000);
	Wed, 15 Jul 2026 10:12:50 -0000
Date: Wed, 15 Jul 2026 12:12:50 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Xiang Mei <xmei5@asu.edu>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<nakam@linux-ipv6.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<bestswngs@gmail.com>
Subject: Re: [PATCH ipsec] xfrm6: fix out-of-bounds write in
 xfrm6_input_addr() when secpath is full
Message-ID: <alddIi8ArJ13ytSC@secunet.com>
References: <20260704210333.668216-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260704210333.668216-1-xmei5@asu.edu>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Sat, Jul 04, 2026 at 02:03:32PM -0700, Xiang Mei wrote:
> The depth check in xfrm6_input_addr() is off by one:
> 
>   if (1 + sp->len == XFRM_MAX_DEPTH)
>           goto drop;
>   ...
>   sp->xvec[sp->len++] = x;
> 
> xfrm_input() can leave sp->len == XFRM_MAX_DEPTH, and the transport-mode
> receive path re-enters IPv6 input via xfrm_trans_reinject() with that
> secpath preserved. If the inner packet carries a destination-options HAO
> option or a type-2 routing header, xfrm6_input_addr() is called with
> sp->len == XFRM_MAX_DEPTH; the check (1 + 6 == 6) is false, so
> sp->xvec[sp->len++] writes one slot past the 6-element xvec[]. The write
> stays within the sec_path allocation (invisible to KASAN); UBSAN_BOUNDS
> flags it and panics under panic_on_warn.
> 
> Use "sp->len >= XFRM_MAX_DEPTH", matching xfrm_input(). This also
> restores one chain level the old check rejected at sp->len == 5.
> 
>   UBSAN: array-index-out-of-bounds in net/ipv6/xfrm6_input.c:309:10
>   index 6 is out of range for type 'xfrm_state *[6]'
> 
> Fixes: 9473e1f631de ("[XFRM] MIPv6: Fix to input RO state correctly.")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Applied, thanks a lot!
