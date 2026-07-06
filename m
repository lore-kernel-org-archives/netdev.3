Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC37335575;
	Mon,  6 Jul 2026 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357849; cv=none; b=CnZpe8Tyc46um48nXEtAVenzVMwTD9BAhLB4Me2dNfxWSN8PM0Jp1F2Q9UySNh6K2JqUiohcIZLgnhXk0c2pDO9CfCApHAArN1OfnvJStQGK6SlrKmraJl36ontHTV7mzqo4VZwJX7DnDgMzIJAypK3EDAWzZEmjktyN292tdao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357849; c=relaxed/simple;
	bh=jxznkJTFiiITpRV5RH/SiwXDsTQHneY6BFzvo/DLJIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1JsuYp1CxZJ285pSm/oe9JYnCLw1pJ3maQz8Gzl3H4cq0gKo0mT7Pas40IEUSIl+vYndDtSTxYeB6yAPoAH1rpj+2ERzsjrYMoMidoSmIWI0B/GoeYZNHwfy9KpZQ6bkHH52n6ThUmFvKHpXYnFjLxv6DoHJX4ZtEJ3z77Yb8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Mon, 6 Jul 2026 19:10:31 +0200
From: Brett A C Sheffield <bacs@librecast.net>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <akvhhy_JpH64KrcL@karahi.librecast.net>
References: <20260706094242.115992-1-simon.schippers@tu-dortmund.de>
 <akt_Q7kdR3Zb8_GZ@karahi.librecast.net>
 <20260706091706-mutt-send-email-mst@kernel.org>
 <2728c540-2e76-4e06-9064-ed1dff071cbe@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2728c540-2e76-4e06-9064-ed1dff071cbe@tu-dortmund.de>

On 2026-07-06 17:33, Simon Schippers wrote:
> But even if we could perfectly fix the performance issues, maybe users
> even users rely on the dropping behavior. From Brett [1]:
> 
> "In our multicast use case data is sent by multiple threads to multiple
> groups simultaneously, this just breaks things to the extent that a 
> <2 second test times out after 5 minutes."
> 
> We are *not* factor 5min * 60sec/min / 2s = 150 times slower than without
> the patchset.

I didn't mean to suggest 150x slower. It would have been more correct if I'd
simply said "the test normally takes <2s but fails to complete with the
patchset". The 5min timeout was irrelevant detail.

The iperf3 tests give a much better picture of the performance impact.

I thought a simple TCP test with a familar tool might be easier than explaining
the ways in which we're torturing multicast ;-)

> My theory is that the sender sends a fixed amount of data
> of which most is dropped without backpressure, which is much faster then
> the real processing, and so the test *relies* on the tail-dropping to
> work.
> 
> @Brett can you maybe support this theory?

The test synchronizes two blobs of data. The amount of data that needs syncing
is fixed, but the amount sent will vary as it is encoded with RaptorQ.

The test sends on several multicast groups simultaneously. Each group is a
stream of RaptorQ encoded symbols and the receiver listens on that group until
is has enough symbols to decode. In practice, on a local tap interface, the
packet loss is normally zero, so the amount of data sent is more or less fixed.



-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/
