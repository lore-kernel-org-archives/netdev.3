Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0012E8B82;
	Thu,  2 Jul 2026 11:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990485; cv=none; b=A7+l78aLHAqWKbB5iHkDmrX2nT3t8Wf3Ju0vCxfU7QZpBgZkWEyOrcKDtMp78ZohrjAf6PlcwNpl6tlZdplYXa9tBxYcdOSA6QTQ2sIbUMKobpdGEBzjkv8EWJHrHDheb9IkF2iDdFL3OdwLaI/CIHF+U+MtBWGRxUvI7AgS0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990485; c=relaxed/simple;
	bh=NtwljrLY6p2ZueS5jksY4cMrkYyHa7GgXF7EIKbYhZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFnPrg1Za2yanCf6b4pa+xzbYkB6LNx2PIKrBjPaa7hFjbCNwXNKJoYwgPiqOoCyXWZcHEw3rs++4Nr3eVExTkpHjqrmqMSXBB8axCVJVM1S3bXJ4BHMyi1mCBIkHcuhv4W5c05Bn8+UmFnfM6tl+7mrDD6UG/ruzMDXVS/zYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Thu, 2 Jul 2026 13:07:47 +0200
From: Brett Sheffield <bacs@librecast.net>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, regressions@lists.linux.dev,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] tun/tap & vhost-net: multi-threaded
 network performance
Message-ID: <akZGg96-Xu9VeGrw@karahi.librecast.net>
References: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
 <20260701165359-mutt-send-email-mst@kernel.org>
 <ef33f0a7-f0b7-4bc4-9263-10d2b480d717@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef33f0a7-f0b7-4bc4-9263-10d2b480d717@tu-dortmund.de>

On 2026-07-02 09:24, Simon Schippers wrote:
> On 7/1/26 22:56, Michael S. Tsirkin wrote:
> > On Wed, Jul 01, 2026 at 09:16:48PM +0200, Brett Sheffield wrote:
> >> TL;DR - Commit 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 causes
> >> significant performance regressions with TAP interfaces and multithreaded
> >> network code. Please revert.
> >>
> >>
> >> Librecast is an IPv6 multicast library. One of the tests (0055) fails under
> >> Linux 7.2-rc1. The test performs data synchronization over IPv6 multicast using a TAP
> >> interface. This test has run successfully on every stable, LTS and mainline RC
> >> released in the past year. Every kernel with my Tested-by has run this test.
> >>
> >> There have been a bunch of changes to MLDv2 so I started bisecting there, but
> >> the culprit is actually 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 "tun/tap &
> >> vhost-net: avoid ptr_ring tail-drop when a qdisc is present"
> >>
> >> Reverting this commit fixes the test.
> >>
> >> To eliminate my code and any multicast weirdness, I ran tests with iperf3
> >> comparing the same host running 7.2-rc1 both with and without 1d6e569b7d0
> >> reverted.
> 
> Thank you very much for your bisect!
> 
> As the author, I am sorry for that regression!

No worries. That's why we test :-)

> > - does it help to increase the tun queue size?
> 
> I agree, this would be great to know.
> 
> However, even then we must act. I am considering IFF_BACKPRESSURE
> as a feature flag, defaulting to off. It would just enable/disable
> the stopping logic in tun_net_xmit() and the waking logic
> in __tun_wake_queue(). If disabled, it would result in the same logic
> as before.
> 
> I could provide such a patch as [net] material.

I'm going to make myself a strong cup of tea and dig into it a bit more here and
will let you know if I find anything worth reporting.

If you need me to try re-testing with specific settings or test a patch I'm
happy to do so.

Cheers,


Brett
-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/
