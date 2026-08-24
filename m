Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241DA375F97;
	Mon, 24 Aug 2026 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787548483; cv=none; b=p0GL8QjGT7Bvzl0WgppaT1IEVhusSTD2KCLy3cxA7KAsboeB2z0JEarmYthQGayE9p/ZD7O41eCREDPfoK2Pfh5vvlYTxQytZHgXs6IplDq1bY7i9C8CB9tOJioausfcRn9CxUN4mH3o1WlVVeDXn2SkFw3wDNhy7fACPn9Gm7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787548483; c=relaxed/simple;
	bh=tXIJLuWL2VFPo9b/mzbfE0YEAbaqoUXVPty/mLVMQ4I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoOPf4fsAg5W0Ho5zc3SP6KYic9xZjj62fC7DkGOktzVzU7gHRqmsiFDhcx9Y3mu3PYa3aJjexiE0WdqJrwhOz8Y25VuPlx96Cjn4lpD7aEIGo61nZNkJLoIr68BuJVeDGJXaynGvcPstfIHW4oy826cBdukGtxvAS3yXY25Imw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=a3Zc0iFE; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="a3Zc0iFE"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EFE22207FB;
	Mon, 24 Aug 2026 07:14:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EGk190Kp5w0E; Mon, 24 Aug 2026 07:14:38 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6316420764;
	Mon, 24 Aug 2026 07:14:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6316420764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787548478;
	bh=1ZvuMBzIjDhRmY+lCfc3mEB8p+8DA4JC5jSWL4SA2GY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=a3Zc0iFEjxKOakf0AmAj/j3PBVSm7fxN17lTUcfboKS9rcM0Dc8fl2JQGMIZrFlGd
	 DBSHGKz/qTeG04HXgtU5MO+qtJy6sT+P5sT1pCTgXjCneFr7GFjeOI7gkYJ/bdhtQ7
	 ts+QlWjAeiE9ffzJQ/BhrLjgBvfs6xY5+dDU1VZJuK2HHN2DfrfbzeDpm22RJS/kzx
	 fYrw0ZtZr1q4QqplI+2J2vW+VfjErtnP8skYGQI18xt4iE8F9sHHkRHqyd5HhCG8bp
	 aODC8G+TZGJJWgRmK0SjhICEKYycmQnFdtsd/w5Sc1gHUiDkxDE4BB1ov9zw+MaFyW
	 lBCl7qr+PG0KQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 24 Aug
 2026 07:14:37 +0200
Received: (nullmailer pid 666422 invoked by uid 1000);
	Mon, 24 Aug 2026 05:14:37 -0000
Date: Mon, 24 Aug 2026 07:14:37 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Lilly Aronleigh <lilly@aronleigh.au>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Christian Hopps <chopps@labn.net>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: iptfs: avoid canceling reorder-window drop
 timer
Message-ID: <aovTPU8CUB_Ud4zT@secunet.com>
References: <CAFrrV-O1fesaza+5_WqH8OciXRu9KKE4UsB6RcMamDu0j2-nBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFrrV-O1fesaza+5_WqH8OciXRu9KKE4UsB6RcMamDu0j2-nBA@mail.gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Jul 30, 2026 at 01:12:44PM +1000, Lilly Aronleigh wrote:
> IP-TFS uses xtfs->drop_timer for both partial inner-packet
> reassembly and the reorder-window drop timeout. Reassembly completion
> currently cancels the timer unconditionally.
> 
> That is only correct when the reorder window is empty. If the reorder
> window already contains saved packets, the same timer belongs to the
> reorder-window state and must remain armed so the missing sequence can
> be considered lost and the window can advance.
> 
> Only cancel drop_timer from __iptfs_reassem_done() when the reorder
> window has no saved packets. The existing drop_lock serializes this
> with the reorder-window paths, and a failed cancel remains harmless.
> 
> Tested with a reproducer that completes reassembly while the reorder
> window contains saved packets.
> 
> With this change, the reorder-window timeout remains active and the
> window can advance correctly when the missing sequence is not received.
> 
> Fixes: 0756947654468 ("xfrm: iptfs: handle received fragmented inner packets")
> Assisted-by: ChatGPT:5.5-extrahigh
> Assisted-by: Claude:4.6-opus
> Signed-off-by: Lilly Aronleigh <lilly@aronleigh.au>

Your patch does not apply to the ipsec tree.
Please rebase onto the ipsec tree, thanks!
