Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E66488DAF;
	Mon, 21 Sep 2026 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993139; cv=none; b=WXz4vfUrhHkibO741QI0/rvQH20my0wlTSSVADISHl+oiluPJc2n0fXNv4M3yQuZWfXBuaN7u0mUlUpDbCeJRHGOZJK/41Xt9z1yZ4g1gtV3zHYSZidk5L+aYNr+F8WE9+QRLa7BrlQAPbPE5567pfliFaKG+kiaqH0yGxAPIJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993139; c=relaxed/simple;
	bh=bvnN0Mzpxckyl+yg6E4Z9E05lDmzEvpoRvpfpVG+JME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC/0PIbP93+RPJq3bM3xg7hTWKVhAsvDyZoy/SMSHM4gVPsg1wLhkFyC6XikcBLk+SPp08JZ/PK2NN1AKkgYS/2OXkgsY3Tr+tGXaQm+Sg8jYrBP8Ecf7st5HlsKRsV5LIFMRIFIiOiMvvYzdOTv3vV1Cir0BB+IwOEgBWB5C2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Judxc395; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Judxc395"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RI7sMNEp/l3Fru78fsbHiPfiT9uXTwKAZfOcDtetHmI=; b=Judxc395kuFBRMtxL1hozwVtMl
	p0iB7Bm4x1QBmUqhMxcFJ2nvzh9xAdfeijmUBeBUpZevDTBXuestVTpLMv2hB51++OQPAFgQbwZS+
	tpVnDhjOsfusmV1Elu/i179KYS8dfN8nWP43dY4RItd3sPpO4mYy+o2Aeon5PVJg7i7E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8cyu-006KM5-QQ; Mon, 21 Sep 2026 14:18:48 +0200
Date: Mon, 21 Sep 2026 14:18:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: nicolo.giuliani6@studio.unibo.it
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: mv88e6xxx: 88E6191X and 88E6193X have
 no PTP
Message-ID: <b9abe153-04b8-4990-b99e-38f5f63ec076@lunn.ch>
References: <20260921-send-net-v2-1-031ad720f140@studio.unibo.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-send-net-v2-1-031ad720f140@studio.unibo.it>

On Mon, Sep 21, 2026 at 05:56:29AM +0200, Nicolo Giuliani via B4 Relay wrote:
> From: Nicolo Giuliani <nicolo.giuliani6@studio.unibo.it>
> 
> The 88E6191X and 88E6193X are 6393 family devices that share
> mv88e6393x_ops with the 88E6393X and are marked as ptp_support. Marvell's
> UMSD driver describes both as parts without AVB (88E6193X: "BGA package -
> No AVB, No Routing, No Cut-through"), and the register access confirms it
> on an 88E6193X: the whole indirect AVB register space behind Global 2
> registers 0x16 and 0x17 reads zero, for every port, block and address,
> with the 6390 and with the 6352 command encoding. Writes to the TAI
> registers, including the clock period register and the TAI global
> configuration register, read back as zero.
> 
> Since commit 7e3c18097a70 ("net: dsa: mv88e6xxx: read cycle counter
> period from hardware") the PTP setup reads the TAI clock period, so the
> switch fails to probe:
> 
> mv88e6xxx ...: unexpected cycle counter period of 0 ps
> 
> Add mv88e6191x_ops, a copy of mv88e6393x_ops without avb_ops and ptp_ops,
> use it for the 88E6191X and the 88E6193X and stop setting ptp_support for
> them. The 88E6393X is unchanged.
> 
> Tested on an 88E6193X (Sophos XGS 107w): the switch probes and the ports
> work. I do not have an 88E6191X, it is changed because UMSD describes it
> the same way.
> 
> Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Assisted-by: LLM
> Signed-off-by: Nicolo Giuliani <nicolo.giuliani6@studio.unibo.it>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
