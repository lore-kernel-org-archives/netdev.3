Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416EA1D63E4;
	Mon, 24 Aug 2026 05:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547882; cv=none; b=e0KOaVptx+OZHbAJYNRJoYIJMi1wQqFhCJtCr5Df+suX3oYFws3yd50gcgUSoqvlPqgqsCjZ6LRnZbIEsjtPNhJoepN8AiYC2m7M9odxSx9947WQzGVBzrgTURtHXrRVXQlWW+8NHNU/HkUj5/f9mkUgxfwgq+z3MjsDw6iTZ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547882; c=relaxed/simple;
	bh=hl47vzRG+G1yQBJaTzfe5Q+UyAZPaimrzJ/AP4KkGyQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sl0Qo/QmDpT0t36/HJqWdfX70qgSo2oanaxkZQ7hcXHpFxo7a32qJnFs/Ccb+kHhCjiGfPsrou/aAaV/h8cw/Z8qybT9Kt6pDxrgLvEy54jGYsMqZK+kIwZkU0+TcG5KDxp7+5uzZMwbU+9jyc6c1Krd5jx5yx6he29IyFAhY4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=JGsDT5/Y; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="JGsDT5/Y"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 529802068C;
	Mon, 24 Aug 2026 07:04:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q7C7aG-zmHbI; Mon, 24 Aug 2026 07:04:37 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 810FC201D3;
	Mon, 24 Aug 2026 07:04:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 810FC201D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787547877;
	bh=vqxThvMueNlFLbLk9G7Pmvq0Dur+HWa8fI5pbCJ2yuM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=JGsDT5/YxTnXFpjr8C3ESrFlWIKJTFdJ1hABP244jtL2HaWavLuV5QU7ulDcy+0dm
	 3FJ5V2FahRJ9ABYCOFUKzlYVDUjMmQm2ruz6B1+vpGxmfKgc0Kyz/aPKu81j8khy1s
	 Z1MkalKIsPFcWPjaY+gcpA3eZmB63ZwpBUBtDro4tqlkjHx8k0wHsRQ98u3wI+jkHl
	 CDPqV8R5nmuwG+xx4CCpDPiLqlc2AfYspVjOPKaJgb25Pydcp3Wk8Zpy32294dgNTa
	 DbCi9paScmvOPTBDjL7e0j1bUA5g3P9vxDmIW8mhO5DbRI2lwK/96YIRklgOpjyEzx
	 TKSYepNivHslQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 24 Aug
 2026 07:04:36 +0200
Received: (nullmailer pid 656010 invoked by uid 1000);
	Mon, 24 Aug 2026 05:04:35 -0000
Date: Mon, 24 Aug 2026 07:04:35 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Lee <david.lee@trailofbits.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, Kyle Zeng
	<kylebot@openai.com>, Dominik 'Disconnect3d' Czarnota
	<dominik.czarnota@trailofbits.com>, Sven Eckelmann <sven@narfation.org>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ipsec v2] xfrm: fix compat ALLOCSPI request use-after-free
Message-ID: <aovQ4y8Fdz4Zrosh@secunet.com>
References: <20260804061038.711373-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260804061038.711373-1-david.lee@trailofbits.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Aug 04, 2026 at 06:10:37AM +0000, David Lee wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> xfrm_state_netlink() builds the ALLOCSPI response with
> dump_one_state(), which already calls alloc_compat() with the response
> skb and header.
> 
> xfrm_alloc_userspi() then calls alloc_compat() again, but passes the
> original request skb and its header. For a compat request, the
> translator therefore interprets the 228-byte compat xfrm_userspi_info
> as the 232-byte native layout and reads four bytes past the declared
> payload. It also publishes the translated child through the request's
> frag_list.
> 
> A multicast clone of the request shares skb_shared_info and can observe
> that child. xfrm_user_rcv_msg() frees it after the request handler
> returns, racing a compat receiver which may still be copying from it and
> resulting in a use-after-free.
> 
> Remove the redundant conversion. The response keeps its correct compat
> translation from dump_one_state(), and no child is attached to the
> inbound request.
> 
> Fixes: 5f3eea6b7e8f ("xfrm/compat: Attach xfrm dumps to 64=>32 bit translator")
> Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Co-developed-by: David Lee <david.lee@trailofbits.com>
> Signed-off-by: David Lee <david.lee@trailofbits.com>

Applied, thanks a lot!
