Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DCC39A7F4
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421132; cv=none; b=nbRYsjfxv1gMkbsgPAKNKrPFySPdz1Edg7Vj1AaTC6G4cOGqjqtGNoA2DlwqGB+b3dIlfAnUDaFKL3HYXDVrzAb+QFB04A/oTGpfo/naBzPj07RVBHGEi3LUBXFOe5CyYZSmt1vz7NIOMA/HPmKFQt/AOqVcz1mZH8BiiJ3gCDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421132; c=relaxed/simple;
	bh=f7gtz8QjSNAg5pHyrGiOOrkclbRo1+IX09cHLVPK/aU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKGA83ijqGNBCm4jweNnVUJlpP0q9jOMK0r2yp6ef+E6u63rlBJManqneQA2SYtRIpwxuPLAl4E48NjBVJgbEh1i4vEA/LxmdhYBfH+yFSN5R6XLJKIyH2KUZeuVPemp9q12rQYdSocZ2aBt3UU4HQFJs81IJ35AofdkVtmGtSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=h8OAaRLR; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="h8OAaRLR"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6951320820;
	Thu,  3 Sep 2026 09:38:48 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bW-BOlLP79P8; Thu,  3 Sep 2026 09:38:47 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C5D5E20189;
	Thu,  3 Sep 2026 09:38:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C5D5E20189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788421127;
	bh=+kCsOXU3MeAtDhdihv4S7IMDhCqMI/xSXvcAcFu+8ec=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=h8OAaRLRkfDOPwh5oSsuue9z3kRtCf9BWEu5cq22Vr4LRkSEIlO23ln0Br85uztl1
	 B6AxKX6o4FTsUADjU6Xn61+rRV1Wb1GpA8+/ovjztHEJb9bnAJ5gCYgsRc6717rQuo
	 rSRVGXK9UoH8n3w3a5i9NID/7E8x9nvvz9Nh3CUjSTaR/NQZ7HBJW9uK5YjrpRNAM6
	 oWvsNyTvask0aOMKlZlh8z0EbgF9mxmailOiOKZ8jRGgb1U8mgd3zVbGqmx1Bw4cNQ
	 nA9qpbT6Th2cY0ELhulbn+sUg5UWojXXH5FFxL3aaxMWtXzd89hJ+VCMI1fFXfZROJ
	 ptW8mEgFnpKnQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 3 Sep
 2026 09:38:46 +0200
Received: (nullmailer pid 1409810 invoked by uid 1000);
	Thu, 03 Sep 2026 07:38:45 -0000
Date: Thu, 3 Sep 2026 09:38:45 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Ren Wei <weir@nebusec.ai>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <sd@queasysnail.net>,
	<vega@nebusec.ai>, <wf.kernel.dev@gmail.com>
Subject: Re: [PATCH net 1/1] net: xfrm: reject unrepresentable espintcp
 transport headers
Message-ID: <apkkBfCh9BdOzGEZ@secunet.com>
References: <cover.1787986691.git.wf.kernel.dev@gmail.com>
 <d138815e0f52e8898e83c5db62b3938993f813a2.1787986691.git.wf.kernel.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d138815e0f52e8898e83c5db62b3938993f813a2.1787986691.git.wf.kernel.dev@gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Sat, Aug 29, 2026 at 11:44:32PM +0800, Ren Wei wrote:
> From: Wyatt Feng <wf.kernel.dev@gmail.com>
> 
> ESP-in-TCP can hand xfrm packets whose transport header offset no longer
> fits after the stream parser trims the TCP envelope. The plain transport
> header reset truncates that offset and triggers the skb warning path.
> 
> Use the careful transport-header helper and drop the skb through the
> existing XFRM error path when the offset cannot be represented.
> 
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Wyatt Feng <wf.kernel.dev@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>

Applied, thanks a lot!
