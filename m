Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BBA280018
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 05:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547757; cv=none; b=dag0BZFOsE2TvdUjSvH4UeVs7ftkZ9HeUIgVPxhGJHSZdr3+oGp6thYigCpvDNy/cQw+0DhtXbk4/58bv4Xlca6lugM97eKUFSMGkSw1kKoPn4x8Xzj8gHJM80hNSntWj2ID4dfhKyccoc53tbgIGxBlGgjoFDxmKR/6vVHq5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547757; c=relaxed/simple;
	bh=uHA+zVjXy33KuddGI+UTysYSib8KbpwhqPAOXMXjdgk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUDc2N7ZHrD2MHPP1onUcibldxbVbGnVl+sA2HyW2C7LsytijUY7r8QW8iLh3WIyXUwSsjN/Kg2j8FSPH6zhcb0dFWBtVyJm2kSeBBWbQaEHfTHS9jm+VIb3MOesSPtlbKV4SXzKvFEYgwM9IP1ECGQORX9cdcdFNp1xf+MKd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=rZNiByoe; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="rZNiByoe"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A34B120748;
	Mon, 24 Aug 2026 07:02:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QbXaWRA66Gmc; Mon, 24 Aug 2026 07:02:33 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1DC7C2050A;
	Mon, 24 Aug 2026 07:02:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1DC7C2050A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787547753;
	bh=CyUri/4o2r5KJtLw/zEAAYURLvG+fFP/eSA1FJqFQAs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=rZNiByoeg4xn6NcTaJH0wilfjpRqqY+WKUm+1Qx+NSi/tfU8lcmDqvtKOe25I4lv2
	 6JSrRiPpmcK+0ZW6gvCL4N53zLnCopAiJ9LkNIhBH/9agXfP2UsfSWVwZ7b5Ko2s3D
	 H9khlsfuI1e0Xpn7MCpvqf9b3XbMd2wivC++UHKiU8/phE2Gxkj45sAcs/YI3jY6kj
	 c7NhfsbG6EcyFMZmlGSVukq5Ua6lilKqD1LmS9ibAATf9LaftzEnVKfd1QPnLCt5NY
	 gj4jhExsXccRt0ieooMdL37QFSrRQw+nx4bssPfjBlcQe4y6h3wxbAWGE67LBZgSOX
	 Du54HLQ9GUwBA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 24 Aug
 2026 07:02:32 +0200
Received: (nullmailer pid 654209 invoked by uid 1000);
	Mon, 24 Aug 2026 05:02:31 -0000
Date: Mon, 24 Aug 2026 07:02:31 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>, <chopps@labn.net>
Subject: Re: [PATCH] xfrm: iptfs: fix runt reassembly panic from short inner
 tot_len
Message-ID: <aovQZ6hskpqW_Ok4@secunet.com>
References: <20260803040154.3024160-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260803040154.3024160-1-bsdhenrymartin@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Aug 03, 2026 at 12:01:54PM +0800, Henry Martin wrote:
> When the start of an inner packet is split across two outer packets
> such that fewer than 4 bytes land at the end of the first one,
> __input_process_payload() saves those bytes as a runt and skips the
> iplen/iphlen validation performed for in-place packets. When the
> continuation packet arrives, iptfs_reassem_cont() only requires the
> declared inner length to be >= sizeof(ra_runt) (6) before allocating
> the reassembly skb with that attacker-controlled length.
> 
> However, __iptfs_iphlen() always returns the fixed minimum IP header
> size (20 for IPv4, 40 for IPv6), so for an inner IPv4 tot_len in
> [6, 19] the header-completion copy writes past the declared packet
> length, and the subsequent "ipremain -= copylen" underflows to ~4GB,
> leaving the payload copy length bounded only by blkoff (up to 64KB).
> At runtime the skb_put() tailroom check turns this into
> skb_over_panic(), i.e. an unprivileged kernel panic (DoS), reachable
> locally via userns+netns IPTFS SAs and remotely against IPTFS VPN
> gateways when the decrypted outer skb is linear (e.g. AF_PACKET taps,
> tun/tap delivery).
> 
> Align the runt path with the normal path by requiring the declared
> inner length to cover at least the IP header size. This also subsumes
> the previous >= sizeof(ra_runt) check, since the minimum IP header
> is always larger than the runt buffer.
> 
> This issue was found by the autokbug dynamic kernel fuzzer at
> Tencent Yunding Lab.
> 
> Fixes: 075694765446 ("xfrm: iptfs: handle received fragmented inner packets")
> Reported-by: Henry Martin <bsdhenrymartin@gmail.com>
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>

Applied to the ipsec tree, thanks a lot!
