Received: from mta0.migadu.com (out-156.mta0.migadu.com [91.218.175.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94D3839A0
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 06:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789108837; cv=none; b=NAcooxPjD2N8lEgzWAa6q0VxeTj3PCm+0S72BUYgZN8gOfhQl1t5voH49VKkgRi4t9rxRM3oP7D1ikTdsmmSHgrchx5OKK0gZ1WC1vq+CUA3FOvmE0CrJwgQkpz8zsYXd8jWKnq72lwow+JL7xlqGBC0TQJ2+GVh+Rt1kxHdw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789108837; c=relaxed/simple;
	bh=DRgM2sZR9+U2TYq2r7Swte23UdF70NogfAQ1RXcZ558=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlajxLvBjWkJEImF4b+bnZXkx3SWPtD9LYFB9O87Fs6jwJtxhcmLRf0ip6mfQngufvZCX+bjCmFuOlrqu/LPBV7FAaXIzbx0QOoxfTzkQu22D7migv1hGCiuAzCFzsgYFMjC4B6o8HEPkPWzOw7AL6KL2FqUIB30iqNi1YoLzNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XqojSlfy; arc=none smtp.client-ip=91.218.175.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XqojSlfy"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DRgM2sZR9+U2TYq2r7Swte23UdF70NogfAQ1RXcZ558=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789108826; v=1; x=1789713626;
 b=XqojSlfymz8jHdYj36Y+bB1kVE/4I8LUpjQdpke5hooDot2DPtCEU03O5ji0xRmnRfM5n52Q
 BJDCP3mUjW8lYc4ycyBH25v6r7h66xkYx5ix7em0FcsswIXWwO0tCXxlrK1iGUSMqcS1RDlfnPY
 6V70P42BFu2aPciz5nVdTPic=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1cdcfac8cafa065e;
	Fri, 11 Sep 2026 06:40:22 +0000
X-Mizu-Trace-ID: 1cdcfac8cafa065e
X-Migadu-Flow: FLOW_OUT
Message-ID: <a9099104-3348-4df5-ade6-25d9503bc74d@linux.dev>
Date: Fri, 11 Sep 2026 14:40:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: reject a forward path that loops back to the
 tunnel
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: falemi@asu.edu, Simon Horman <horms@kernel.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <CA+0ovCj+Pd5owGH+51rA8-RDu9YFx5oYUv8bV0zOE72QgVfY0A@mail.gmail.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <CA+0ovCj+Pd5owGH+51rA8-RDu9YFx5oYUv8bV0zOE72QgVfY0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> ipip_fill_forward_path() and ip6_tnl_fill_forward_path() assign the outer
> route's device to ctx->dev without checking that it differs from the tunnel
> device itself.  When a tunnel's outer route resolves back to that same
> tunnel, the walk in dev_fill_forward_path() makes no progress and trips its
> loop check WARN_ON_ONCE(last_dev == ctx->dev). Release the route and
> return -EOPNOTSUPP when the resolved dst device equals ctx->dev, so the
> path walk either advances to a different device or fails cleanly.
>
> Closes: https://lore.kernel.org/all/CA+0ovCgaRvbd0Udj70b2xxG8Cx3CaCpNhnf1V4RWQuDveZYZhA@mail.gmail.com/
> Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>

Please add the missing Fixes tags. These appear to be the relevant
commits:

Fixes: ab427db178858 ("netfilter: flowtable: Add IPIP rx sw acceleration")
Fixes: d98103575dcdd ("netfilter: flowtable: Add IP6IP6 rx sw acceleration")

Thanks,
Xuanqiang

