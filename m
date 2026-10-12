Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E59415B6C;
	Mon, 12 Oct 2026 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804358; cv=none; b=FFMs+3OxIGH1M582ipEzaTz6mVV2I5T46lek36dDZTpE0quq1yo/XCcPrsg+mM8t6qAIFhi7RlCDR+ra5S/ZO79QWwlbZNpAoz3DzaBXkwILKSxQdClhNuw+HKf6FzTzEob9aZPzUZYPCE8roDK+9+RqjB3jWHy3QjHaikeV31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804358; c=relaxed/simple;
	bh=aPfoKh0pENlZQF2yPePoAjlcDhUIfBpdes8MxeXMR5M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQU3hQRStjCMalAJdKL4qPHwUlX8NEe61SN7sXbWzlMeH5yB2tQPacQmzcsKY5YoIskWRh7P27ymmFEqilVbp4ShYN0QzZMcJ3GZu9kxDzMqH7RVFs1uer/S95cTSbmZC2rZgCUd40vMoZxCKW1A8fnUuoRyl2cCQsqBNtbfsbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wX+xMCmY; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wX+xMCmY"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 0C8AB2065A;
	Mon, 12 Oct 2026 13:25:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PdEw7npr7L6D; Mon, 12 Oct 2026 13:25:52 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8BCB120561;
	Mon, 12 Oct 2026 13:25:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8BCB120561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791804352;
	bh=z/fBnp4sUNd2yygbK2ji+wlwovDzcH8S/iQX9d5uU5I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=wX+xMCmYfpNM4qATUK83LzaADM+I2JrA3rC3xemh1kzuaN93Z+aim1wdlNJl9xBHt
	 HzDBLQfINoIxHfGq/mKSRWcAQnfjO6ar7qE8ZG7yw12Lae/l+vhnVnLLl4ejXr9nNT
	 xSPwG6/fbCEQNw9doBEYcv8UzcD3TjnmuHf3kEHfnFlvKFKrS/AW6P+sWeAwDt389f
	 f5Ea2gcFDDXuliPyKvyugm6HfOguJMvHnoPN31Cahjg8pdVQvSSncK0Ania/IA8asd
	 YXfT+1zzlXK6bC/UyYdTjI8UahxG5n9IsFP4xIsCwNSVHop7xx5Cg9+rHDVi9JABUX
	 xet0jFPQyBjZw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 13:25:51 +0200
Received: (nullmailer pid 2509225 invoked by uid 1000);
	Mon, 12 Oct 2026 11:25:51 -0000
Date: Mon, 12 Oct 2026 13:25:51 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Qihang <q.h.hack.winter@gmail.com>
CC: <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, Christian Hopps
	<chopps@labn.net>
Subject: Re: [PATCH net 1/2] vti: fix tunnel device use-after-free across
 async crypto resumption
Message-ID: <aszDv2BfpDq0htFQ@secunet.com>
References: <20260930090813.73901-1-q.h.hack.winter@gmail.com>
 <20260930090813.73901-2-q.h.hack.winter@gmail.com>
 <179110850671.434549.2584497019282941556@kernel.org>
 <1791424156.460.8ed76b88c7@gmail.com>
 <asySLDyakgLAKVdf@secunet.com>
 <CAH78Gvt0gUELPSeqf348P4-B8E7RH3L3PhFdgVdjfK=WKEpzdQ@mail.gmail.com>
 <asyytFvHJGf_KB_D@secunet.com>
 <CAH78GvuFZxvHWqpbBv3cOQAA-TqvjgS14vH-GsTF58wJ8_vLvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAH78GvuFZxvHWqpbBv3cOQAA-TqvjgS14vH-GsTF58wJ8_vLvA@mail.gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Oct 12, 2026 at 07:21:57PM +0800, Qihang wrote:
> Hi Steffen,
> 
> Sounds good -- thanks for taking the patchset.  Ccing Chris on the IPTFS
> part makes sense.  I'll follow the thread, and I'm happy to review it
> if that helps.

I'll handle the patchset once you've sent an updated version.
I'm reviewing and applyig the patches, but you have to submit it.
