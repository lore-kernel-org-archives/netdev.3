Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05F4339375;
	Thu, 10 Sep 2026 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005491; cv=none; b=M1X8mpzjn7BCPzfsxqusWHHBjfFewcJgEzdubBp5Aw2mpiHnIHHJqSwVJPdFbiDsrcPkAaEu3gP415ZOjA+MhZuKzSTeXYYVISLrLybHAlSHD2y5Jy0gTNRObivEXJ4KYsjoGurqyL/h0/3eZj9sJIyr1aRaAF2+BJipqpkzY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005491; c=relaxed/simple;
	bh=ZCghtGIoIb7TluQkPGz4st3S6s/X1LuzKJRtW5CsIXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeDiR5lfjwOIQDa9tfcUefaERDQM/cR6hDDZPulQGStaNNjsB/dnpN5gzTeJlhVMuwsHQ0XFvIK00brE2EfqgU6XjOP1PcZreXeQifGFyXWqgzz0C94PVwsaUYWW1GvuQgmsFbaRlqth/Lz85jhPgpvFyIvHr+Dxkqd69Xxw69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=S/GJokQn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S/GJokQn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9STbb1ZIxrlEg6JgZuQeaYBzFzmda1M11xD59R6th+k=; b=S/GJokQnwVko/NFdmVea+hQwI0
	DF8auFSjoiJ0F68XWkZsWzqwW9sgjPlQTYVFsgI4Y5gIzmMUO+T5U8hkiHYLNpnd0ncyaOxywCJqY
	yQFVIbIf3GzirUV4BctwtLf14fDvtfXlGBSjHsR9E8ARv1yG6US/diC/xHx1+ALLFMZE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4U2y-004Pu7-Fz; Thu, 10 Sep 2026 03:57:52 +0200
Date: Thu, 10 Sep 2026 03:57:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: David Yang <mmyangfl@gmail.com>, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v6 6/6] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
Message-ID: <0ad7cd3b-006f-41a0-9d58-5f6dad9c22e8@lunn.ch>
References: <20260908083614.2210505-1-kyle.switch@motor-comm.com>
 <20260908083614.2210505-7-kyle.switch@motor-comm.com>
 <CAAXyoMMLpaD5B4QojC0OKHxOFfPfFGpsS2nxCMT9e=nJeo8beg@mail.gmail.com>
 <0aa20394-2042-4c52-b30b-cdd742d4da65@lunn.ch>
 <5e492c8b-1afa-4af8-8f66-9b50799911e4@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e492c8b-1afa-4af8-8f66-9b50799911e4@motor-comm.com>

> > > No one else, except you, can maintain this stuff. Drop it for now and
> > > discuss it later.
> > There also appears to be similar magic in the PHY driver. Can this be
> > consolidated?
> 
> Ans: This part of the initialization is for the switch SerDes, so from my
> 
> side it may be hard to consolidate.

Is it the same IP? Same configuration? Or totally different?

	Andrew
