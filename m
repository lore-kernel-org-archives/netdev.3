Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413382D77F7
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091138; cv=none; b=s384Q1cfjO1CMOEGbvCK6qjJmpXpFU4TlghlFVxgSuUlySMgOomCHRpcSXdz/2vsFWYceRPJlPK0gkaTli4lcuj9NqYCwy0d4veJ0sSJhNXIEQUUAJj9bq7cDyU0G4selIrnwMMbvZQ4dCQu0cGUoGCD1rxR7UUMka79kxe8s60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091138; c=relaxed/simple;
	bh=x55hYzCSm7VgD+GfN6eoDfS7Btq8R1kEb9kTFNiOzy4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLljTifrobzdk7RBgSbk51XYC4i+q43hjIe3GfqJIlGYqgRxwM0ZaOLzPbdE9OdxTFLkgUNbZNu7bS2vf5HW0BrlZ4tdSZwKaeBLy3btuqU+Ou3NMbEpOqQGisE2cMDFsZIypw5Ntxibm9M6RAFL0ogu06jIriC2YPBi9rEpQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=jt3WkLao; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="jt3WkLao"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9C6712053D;
	Thu, 26 Feb 2026 08:32:08 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2RU0LFAGqFiD; Thu, 26 Feb 2026 08:32:08 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2335920538;
	Thu, 26 Feb 2026 08:32:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2335920538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1772091128;
	bh=XgeaWrYyfzhZpi0iUGl++AjyNSvw6dNqiDgXhtzNjTc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=jt3WkLaoikmCqZ2XePPt48t5JUuucbTtDWkh7QyIrP1Ecm0GS/vrV5TGtZi0tAMgC
	 DIVPrkZKPgZ+6zC3cnfT9m48TixJ/D0AvYTeEFIvXmaeA9QhgOj75ALe+X1KA+s8dn
	 uo6NgVfwGY23/LlfVajcXAgWV8jPi/jigmWP9NojRzrE0W8RORyx1Hc2wFJSN/zSw4
	 /RdaNxdGQ1Z/kjw0yoorVdWPo32zEjnYtuYmeQMl3nzPGJVMeaRlTiOhMAHf/Lx4NT
	 j1W8ZCObttZ1nb+tDtIH6W+A631MHoIc/Rgv+Tx6OOkZKLdfNah+JCd9lfrcPsM4ju
	 SS+w8sRu7xYjg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Feb
 2026 08:32:07 +0100
Received: (nullmailer pid 3246379 invoked by uid 1000);
	Thu, 26 Feb 2026 07:32:06 -0000
Date: Thu, 26 Feb 2026 08:32:06 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec 0/4] xfrm: misc bugfixes
Message-ID: <aZ_29mjhbCRxRr5Z@secunet.com>
References: <cover.1771876412.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1771876412.git.sd@queasysnail.net>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Feb 24, 2026 at 12:05:10AM +0100, Sabrina Dubroca wrote:
> These patches fix a few small bugs in IPsec.
> 
> Sabrina Dubroca (4):
>   xfrm: add missing extack for XFRMA_SA_PCPU in add_acquire and allocspi
>   xfrm: fix the condition on x->pcpu_num in xfrm_sa_len
>   xfrm: call xdo_dev_state_delete during state update
>   esp: fix skb leak with espintcp and async crypto
> 
>  net/ipv4/esp4.c       | 9 ++++++---
>  net/ipv6/esp6.c       | 9 ++++++---
>  net/xfrm/xfrm_state.c | 1 +
>  net/xfrm/xfrm_user.c  | 7 +++++--
>  4 files changed, 18 insertions(+), 8 deletions(-)

Series applied, thanks a lot Sabrina!
