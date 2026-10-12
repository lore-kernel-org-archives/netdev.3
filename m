Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEF03A0B31;
	Mon, 12 Oct 2026 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791674; cv=none; b=OpxUZzH2tyRnic/3WKPi80agaZlq9tctEeHP9idDt2PwKnFfKl5bBSIfkSmL8bT0DkxeWS5VUzTRe/yiMSOeO2u/R+/V+zgtLJATecMGZiZBsf85y9zVd2TZCvzZuQ0unW+Ud9C8J56AROH+F0mPxW1cBoJ9cnigQd+S5z14wPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791674; c=relaxed/simple;
	bh=iOFjYct+NA/rBCnLOOO0w4AHLEjLlBpqJJ6RJmSPcPE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UobwRWtOU+tzCV96AGPbXYmkK9YTv9I7dzd+/7yXFCwIZk9T0rBWCHvz6QOJOvXqqbQ7i5REzjqEG5B+TvcJ9TlSUzNumYqNh2ClWWHmo7Nm9/xSxJaspxqOJocHNq3p+2vVc/G7osi2hip6QUK+qNKSp7i6XR91xvzUytfU1o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=r99Q2mnT; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="r99Q2mnT"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B1DFE20523;
	Mon, 12 Oct 2026 09:54:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nVQcTqQDLl-S; Mon, 12 Oct 2026 09:54:22 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 33EAF20185;
	Mon, 12 Oct 2026 09:54:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 33EAF20185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791791662;
	bh=Gbthn3cQMvB39iXiyDycUbw8EvcDj5qysY1Z6LXGzp8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=r99Q2mnTuhOt4NX66E5krF7jLIYQdyeVsuMg9DAnZEpowe6G4qhlHzxgfWtjh+gW8
	 pnNH+8aZDhphXp17kqczkdK4YSibTGBHXSjKszSDbfSho44XxQJwm08biPTwzrw7sQ
	 B5AqsmaTQY8yIT8xU5GcxoMa5OPjRhC8mW3I1S/WUTYe8N39ooomXqKryLWqTWRa1C
	 bAhPra9iI7KQM3jjXFAYYO14aAEyoZs2ZWajP+gtjNj8WLEm+dDhAP+Q6Hl2+zKeBs
	 TiFxiHTCJhCfdm2HBQRINzg6UJ7YlRNhxSNqSIQR0niP5Cd0pXri+QkC4QEr3np4q6
	 g/ZUNaVKmuUPQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 09:54:21 +0200
Received: (nullmailer pid 2341654 invoked by uid 1000);
	Mon, 12 Oct 2026 07:54:20 -0000
Date: Mon, 12 Oct 2026 09:54:20 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Qihang <q.h.hack.winter@gmail.com>
CC: <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/2] vti: fix tunnel device use-after-free across
 async crypto resumption
Message-ID: <asySLDyakgLAKVdf@secunet.com>
References: <20260930090813.73901-1-q.h.hack.winter@gmail.com>
 <20260930090813.73901-2-q.h.hack.winter@gmail.com>
 <179110850671.434549.2584497019282941556@kernel.org>
 <1791424156.460.8ed76b88c7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1791424156.460.8ed76b88c7@gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Oct 08, 2026 at 01:49:16AM +0000, Qihang wrote:
> All real, and vti6 has the same problems.
> 
> The dev_hold()/dev_put() idea assumed the callback runs exactly once
> per skb, which xfrm_input() doesn't guarantee. IPTFS frees the outer
> skb on its own without any callback.

This is a IPTFS bug. If IPTFS frees the skb, it has to make sure
to run the whole destruction path including all the callbacks.

> The early drop when the SA is no
> longer valid happens while family is still AF_UNSPEC, so xfrm_rcv_cb()
> can't find the afinfo and never calls us.

Assigning family before the early drop should fix this.

> And on the success path I'd
> drop the last reference before gro_cells_receive() is done with
> skb->dev.

I think we should unconditionally refcount skb->dev in the
xfrm input path to fix that for now.

