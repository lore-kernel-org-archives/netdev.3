Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE062DAFBD
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541816; cv=none; b=C27eQzotx7TFogWt1ubjOzrIueUkPdS1+j/MW0Qn5Tl9wvItMQnQ3DEmYVvck+uH2/dUG6aCjqX06JAn8w/YgEFXXeVmF1d5wZuY5Ejqm73vMqUZIALCOWZNht15edCas9RjluXAtnG7jf5+4k67gM4bOUbJb268UtB8UVksVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541816; c=relaxed/simple;
	bh=HNny5WE316f2TANfsEdkhdW0sj0uB1BhkEwgUQExPDM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=aH/bZnEqZNizMYdAIKUJ6Dv7B5pNY5+j829G1ZbhepNeGGBDUGffkamEXrsuS9O+OQ2Oog1keHUztqqMisBsy3IC5IZ7Fdv/T5gjBWmPPh17jlxuegGOg6AhmyhuO3tVKf2ltmwzL25+MvI+Dsdk7T66eWNZlO530OrMH/nN9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uXNcoISC; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uXNcoISC"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260708201647euoutp026e89dc692b6957e76047ab19a2100c56~AadMKfaaD0511105111euoutp02Z
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 20:16:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260708201647euoutp026e89dc692b6957e76047ab19a2100c56~AadMKfaaD0511105111euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783541807;
	bh=RYx5u+5FGWCJdyvt6JytRXDJ/jVT6gVVxpgW5mLqOwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uXNcoISCsD7Metr8ZkJ1mZrZ0T1+I81OIj5dF7xW5GCScFcnJuPA3pY34RFG8NXFv
	 ThYeAHT5X5Fpq4YBNTebOyA1WHeOZG+W3TGjgpTNToX4HsKgV3zFGBtIfJpcbNRJ4n
	 2MPZ0U7Vj2uPVH1h75Z9KQ1hm1h4Yj8vixQcvhos=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260708201646eucas1p1dff8fa3d9a443180852126f72f1cb3a1~AadLmuqnh2208022080eucas1p1H;
	Wed,  8 Jul 2026 20:16:46 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260708201645eusmtip15a406be522cc4e7c4578748b4c2e0a3f~AadKo4mXv0367403674eusmtip1M;
	Wed,  8 Jul 2026 20:16:45 +0000 (GMT)
Date: Wed, 8 Jul 2026 22:16:45 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: k.tegowski@samsung.com, k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sashiko
	AI <sashiko-bot@kernel.org>
Subject: Re: [PATCH net 2/2] net/stmmac: Prevent dma queue NULL free on
 allocation failure
Message-ID: <ak6wLcK1xCXZf4mS@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260707174115.1264466-3-j.raczynski@samsung.com>
X-CMS-MailID: 20260708201646eucas1p1dff8fa3d9a443180852126f72f1cb3a1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad66_"
X-RootMTR: 20260707174136eucas1p2dca8fd11dc7642c913eb03bcdf5aa276
X-EPHeader: CA
X-CMS-RootMailID: 20260707174136eucas1p2dca8fd11dc7642c913eb03bcdf5aa276
References: <20260707174115.1264466-1-j.raczynski@samsung.com>
	<CGME20260707174136eucas1p2dca8fd11dc7642c913eb03bcdf5aa276@eucas1p2.samsung.com>
	<20260707174115.1264466-3-j.raczynski@samsung.com>

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad66_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jul 07, 2026 at 07:41:15PM +0200, Jakub Raczynski wrote:
> During allocation of RX/TX descriptor resources and its DMA,
> there is verification of failed dma_alloc_coherent() due to lack of memory.
> In case of that failure, all allocated resources are freed instantly after,
> but there are no checks for dma_free_coherent() whether previous step has
> failed.
> This will generally result in panic due to freeing NULL address.
> 
> Fix it by adding NULL verification of memory that is to be freed.
> 
> Theoretically code should also set address of pointed memory to zero when
> freeing, but currently the only path of invalid address is non intialized zero,
> and there is no case possible of double-free of same memory.
> 
> Fixes: e73b19baa3b1c ("net: stmmac: simplify DMA descriptor allocation/init/freeing")
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> ---

Sashiko AI gave review that has valid point, patch needs changes.
Please drop it.

--
pw-bot: cr

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad66_
Content-Type: text/plain; charset="utf-8"


------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad66_--
