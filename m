Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56DC3161A1
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 05:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547817; cv=none; b=oEoZBshagFeqdcwY58B5BTLu8q45grHecRDdGJhsdjS91pvrFjD3+TjSN7wN9L1x8GXIMIIpReb74JyYMJH6O/5E2hL/TL0QELfDFFqAfTjMzyb7wKjWHMMlLOJJhbtlZt+Cwyfu0UcBwtVxnJL8q03bFET19RNWdysLi45Afk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547817; c=relaxed/simple;
	bh=2iTySOzcjhlB8VWXBooTJmo/VSXY/VAQ9EDqXRhR9BQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNgH48alm4tk4igBPY21GObKmiSU+eD5FJVyngpcGx976eg2yWNm+sPtO1KmTC+y7JQ1ozBdqaDc2POm349jQpdaCx4JkUbnsWATXLViJGDlVjWgUZMhLWdVpSF1A6r+3g5kIJ6RDMQaa4epTJPPFKQpKYBtm2JdTIDa8ptZKHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=IFgXGmQ1; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="IFgXGmQ1"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D11412050A;
	Mon, 24 Aug 2026 07:03:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hCF91EW-uDNm; Mon, 24 Aug 2026 07:03:33 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 23045201D3;
	Mon, 24 Aug 2026 07:03:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 23045201D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787547813;
	bh=MIdVJigwrUi8VtGbaNKmKMytuGr0T+f8F/1WdLfzuys=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=IFgXGmQ1j6vYrWVNrbjVoQXOGO57EVkqwsHLaj6jHwZX3HKDhy4OERjwIWfnebl0k
	 7vhwAZc/RxzzhoCwLOlJ8bvtLZdizZ5uHMV9sCQ8VrQi6xCNTVsY2zH/c87F3Qmon5
	 getwuZBzCWlJHDqtt0vDHxCAGXoa71CfFE5dBsNBNB69la6MxUFCvrCh2wsh6Q7PlK
	 fSZZguIDKPEcoFXEUA/Jo2fQgPmVAqn9kk3ko8AsamD1P5/w1lG1wZFjuOzcCBELgx
	 5et2HdBMMLbhaKhaZnS8QHtsuBxPf3UV2aikCkxmudXCw167sJc9o9aRSYKRUQMptf
	 uat8UoGKQeWYw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 24 Aug
 2026 07:03:32 +0200
Received: (nullmailer pid 655108 invoked by uid 1000);
	Mon, 24 Aug 2026 05:03:31 -0000
Date: Mon, 24 Aug 2026 07:03:31 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <vega@nebusec.ai>
Subject: Re: [PATCH net 1/1] ipv6: xfrm: use full sockets in local error paths
Message-ID: <aovQozbgbf4m1PHv@secunet.com>
References: <cover.1785761237.git.zhilinz@nebusec.ai>
 <b0a24c61d507fce6f881d95e233302e93227ad33.1785761237.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b0a24c61d507fce6f881d95e233302e93227ad33.1785761237.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Aug 03, 2026 at 09:28:58PM +0800, Zhiling Zou wrote:
> xfrm6_local_rxpmtu() and xfrm6_local_error() dereference skb->sk as if it
> always pointed at a full IPv6 socket.
> 
> That is not guaranteed. TCP SYN-ACK skbs can be owned by a
> TCP_NEW_SYN_RECV request_sock while the output path itself is driven by the
> full listener. If rerouting selects an IPv6 XFRM tunnel route with a lower
> MTU, the local PMTU/error handling path can reach these callbacks with that
> mini-socket still attached to the skb.
> 
> The callbacks then miscast the request socket as a full inet/IPv6 socket and
> can read beyond the request_sock allocation when they access inet_sock or
> ipv6_pinfo state.
> 
> Resolve the owner with skb_to_full_sk() in both callbacks and bail out when
> no full socket is attached. This matches the surrounding XFRM IPv6 PMTU/error
> logic, which already reasons about full sockets with skb_to_full_sk().
> 
> Fixes: dd767856a36e ("xfrm6: Don't call icmpv6_send on local error")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

Applied, thanks a lot!
