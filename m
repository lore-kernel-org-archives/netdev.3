Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C53D9DB4;
	Fri,  3 Jul 2026 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088040; cv=none; b=sjqRt6K2qemm5eO9hJ2KOfVNjYi9DN/n6/tAU2q25iPe8ju1ePWrI7vQ6pnm4/nWr9OgIsDQgU55a+m/MrlJOrQi5ZsIaPhq/0y6OHkcH1Q5dej1oSCzIqHf+A81Qlr7UrbpHTmMrKHm2n49d6s5vtpBCtivBYILmgG4lMDsdR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088040; c=relaxed/simple;
	bh=nXaaI8u190JJP15Am0mo4GN5gaSwcUDGHh5PVCLrhOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrbKJHQeh3Ch3HYFBLX/JABUOWRa3dEOhPs2MexkTfIEROhHetA69rkEhe5FZ4t4L57t7vyE7/mqlEzTjT10G1az4ta1P5ogB9QPXzta/BW/7fTg5r4JbZlFUQ3PIYaTtuJlOjr6ZvfilT1rs33egxf9MRhNJnNkY1F2UZLYAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Fri, 3 Jul 2026 16:13:49 +0200
From: Brett Sheffield <bacs@librecast.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	regressions@lists.linux.dev, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] tun/tap & vhost-net: multi-threaded
 network performance
Message-ID: <akfDnfkgorxJ_Q6G@karahi.librecast.net>
References: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
 <20260701165359-mutt-send-email-mst@kernel.org>
 <ef33f0a7-f0b7-4bc4-9263-10d2b480d717@tu-dortmund.de>
 <akZGg96-Xu9VeGrw@karahi.librecast.net>
 <20260702185420-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702185420-mutt-send-email-mst@kernel.org>

On 2026-07-02 18:55, Michael S. Tsirkin wrote:
> On Thu, Jul 02, 2026 at 01:07:47PM +0200, Brett Sheffield wrote:
> > On 2026-07-02 09:24, Simon Schippers wrote:
> > > On 7/1/26 22:56, Michael S. Tsirkin wrote:
> > > > - does it help to increase the tun queue size?
> > > 
> > > I agree, this would be great to know.

I tried adding a queue (qdisc pfifo limit 500) on both host and guest - no
apparent difference in drops or performance.

If there's any other setting you want me to try, let me know.

> Maybe it's the supposedly rare case? Does this change anything
> for you?

I also tried both patches, but again, no noticable difference.


-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/
