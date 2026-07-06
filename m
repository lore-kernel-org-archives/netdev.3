Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B7233F582;
	Mon,  6 Jul 2026 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332704; cv=none; b=VDESHk7jpURQihjTvV8QpQftf0ntCETGvF3gwGHIXodg2cXNKxye2ipClbqfLK2IOsdXl4gDdDqkC9qkCowBDUCIUXzv2S7JmEj8E/5rj5IQY799x133d3c3rJfO4+yGzYyqsf6acWV75Ar14+eQuEuW4ov1F2L5bVyaDPOT8AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332704; c=relaxed/simple;
	bh=MBzYfn6wrT/moznkuon8LGgRLOwNEgezeJ/ZvYxKR6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sv/Ya2K3VH/pYQnqAFe1gOES49fbCu9BaE15OCIxiS0oHMF5afoveFxdntk/XX9CGtuBlknUDJHBfQS2i/ncDnMfr+p5TEQYJPaB7N9wdsi/E6P/0Zsoq9dRGVJ+tEafPw4u2V8dMkFBGLGzZ13hO366BYxA4RWAU8EHikySyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Mon, 6 Jul 2026 12:11:15 +0200
From: Brett A C Sheffield <bacs@librecast.net>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <akt_Q7kdR3Zb8_GZ@karahi.librecast.net>
References: <20260706094242.115992-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706094242.115992-1-simon.schippers@tu-dortmund.de>

On 2026-07-06 11:42, Simon Schippers wrote:
> Commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop
> when a qdisc is present") did not show a relevant performance regression
> in my testing but on Brett Sheffield's librecast testbed it shows a
> significant performance drop in a IPv6 multicast testcase. The regression
> can be pinpointed when multiple iperf3 UDP threads are sending. For 8
> threads the performance dropped from 13.5 Gbit/s to 9.13 Gbit/s. This is
> the reason why this patch makes the qdisc backpressure behavior opt-in.

Your v1 commit message was correct.  The iperf3 tests were TCP, not UDP.

The original failing test that alerted me to the problem was IPv6 multicast
(UDP), but the reproducer tests I provided stats for in the regression report
were TCP "To eliminate my code and any multicast weirdness" and also to verify
that this also affected TCP.

Sorry for the confusion. The command lines used are in the regression report.

I've tested the v2 patch (with IPv6 multicast), and verified the
previously failing test passes.

Tested-by: Brett A C Sheffield <bacs@librecast.net>

Cheers,


Brett
-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/
