Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCDD326923;
	Mon,  7 Sep 2026 03:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788751647; cv=none; b=Xl0Go9P1jLbgky/4OKG+EZN0Tnc7d6fYrUEICZ2cP2pAsU3BKsxeN8Rjkkw8W1O8QuzKrL+Le25CugOytprRsMVC8j/DFBpq9lRp7FSlYZSHj3fdAqNMMK8XAFQOkyytxMJYtEnNhz0a5Gr+Ck/FEHWDcLM5Ujz1QsqQAJC0wvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788751647; c=relaxed/simple;
	bh=38oaFWyNLVs8SqYOxYpN0DxRw0EcUvonwDgWKA2sieY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNJrfP2zSkIoPOEHJhigfmyWoofjY44QOrMwC/PHYENJq74rjH2lG6Er2piC7RdS5vuerm1AvgJCeDgUofrl56ogtxcPOrkPzXc9BLBO1F0l2S4NDWy8d8M1ItbiHmEtLjWV8DgLHUeOFpFN5ieUYHQeQcyfOBoQrZFuJSPJdvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tGze5aYn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tGze5aYn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kCUL5nqybqNuKe6WZoppc38jGe//sVPhuSzPlITI3VI=; b=tGze5aYnl0VKkOvSlEVBJonOSJ
	NQnDZBIBKQyGkzuASmtGDzGGz4AEqd2bJFJtxs8FboFwDyO/O+pblrx+Efur/vhfY7xdCw7pbpAKS
	EMfCaMNEq+4X5GZ3cOmGNW1B8KTiI/GgMeh/YbfD6Q3BSUt0R7sD9WJO5pBu9Va8lisA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3Pam-003PNT-1E; Mon, 07 Sep 2026 05:00:20 +0200
Date: Mon, 7 Sep 2026 05:00:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: David Yang <mmyangfl@gmail.com>, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v5 1/6] net: dsa: motorcomm: refactor
 registration path for upcoming switch families
Message-ID: <8704e277-3968-4c04-91b6-04ce046fa806@lunn.ch>
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
 <CAAXyoMN-RX1aY_isyajES5LgiDMp7_YTbM=jiS6d-8o2kKQXqg@mail.gmail.com>
 <27a16f29-14a9-40d0-941b-f07d5b63ec4a@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a16f29-14a9-40d0-941b-f07d5b63ec4a@motor-comm.com>

> > >   static const struct of_device_id yt921x_of_match[] = {
> > > -       { .compatible = "motorcomm,yt9215" },
> > > -       {}
> > > +       {
> > > +               .compatible = "motorcomm,yt9215",
> > > +               .data = &yt92xx_series_info_table[YT921X],
> > Redundant if you use both runtime identification and the match data.
> > Also I'm concerned with early IO operations, although I didn't see any
> > incorrectness here.
> 
> Ans: we have considered this issue before. in the next version, we
> 
> will consider whether to do it via chip_detect() or using indexed
> 
> assignment. From your suggestion, what are the side effects of each
> 
> approach and which of the two approaches do you recommend?

One problem with compatible is what do you do when it does not
actually match the hardware, because the DT author has messed up?

For the Marvell devices, the compatible only indicates where the ID
register can be found, because Marvell likes hide and seek, they keep
moving it. Once the ID register is read, it is matched against a table
to find the correct structure for that device.

Where compatible are interesting is when the silicon vendor messed up
and produced two different devices with the same ID value, or put no
ID in the ID register at all. Then you have to work around the silicon
vendors mess, and hope the DT author gets it correct.

My suggestion would be to use the ID register and not have
compatibles.

	Andrew
