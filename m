Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA2937419B;
	Fri,  8 May 2026 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247664; cv=none; b=mkUfTUOP8Jneb2pWwlRHDEBc3it61OpmYkfhpEhauKrBAMVsjHMC9UZu0ySXNsFPbXKbrlM614y9mi51Km9K7chbjBYxqG16QsCkoDRLFvMVUtvlY8IVC/y2sSy2m99vx5KhRVboD6LGyUgaAlkjJTb3KLu7OPtZYveS1PZkbVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247664; c=relaxed/simple;
	bh=mfMIFp8OlSOd98T1kC1LhYj4A4fV7dYb1x+gh2ih10w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Skb5yC2xIl2S+PILz06t3aWLqgO8Lp4gP4uCZ62AQkl5l8SpzEDvdMhak7W99CuaOIZWYdHSzhZb6Z4NDag6zwqUh7E5MsNKIg9k2uPSGzmKrdx0oFPRo+UCRvrhcnsvfoCmtPbQBWmG31l8HBuncECbanuI51IpbDsGzJec/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bGPlDiGH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bGPlDiGH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8jYBlJurA7H2/29k8CP0C4HEnBKLf57PI9B4HQDRtrE=; b=bGPlDiGHM3F2v3OpskK2kBiVlb
	8PFc09cGeG9JhWve6wwBXxvT0IDveI/l79yjqqnYsib5rMgLcv1L3+WG5CbdkdAhLZzXt1QMLeYw8
	GmVLty8v03ZCSsh+BAKv5xapE26rgXIFQYe+JzMb8lbbI2gs81pY7ZkY4uYTsh8s6EFQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wLLRS-001yeh-Vl; Fri, 08 May 2026 15:40:34 +0200
Date: Fri, 8 May 2026 15:40:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Illusion Wang <Illusion.Wang@nebula-matrix.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Dimon <dimon.zhao@nebula-matrix.com>,
	Alvin <alvin.wang@nebula-matrix.com>,
	Sam <sam.chen@nebula-matrix.com>, netdev <netdev@vger.kernel.org>,
	andrew+netdev <andrew+netdev@lunn.ch>, corbet <corbet@lwn.net>,
	kuba <kuba@kernel.org>, linux-doc <linux-doc@vger.kernel.org>,
	lorenzo <lorenzo@kernel.org>, horms <horms@kernel.org>,
	"vadim.fedorenko" <vadim.fedorenko@linux.dev>,
	"lukas.bulwahn" <lukas.bulwahn@redhat.com>,
	edumazet <edumazet@google.com>,
	enelsonmoore <enelsonmoore@gmail.com>,
	skhan <skhan@linuxfoundation.org>,
	hkallweit1 <hkallweit1@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVENIIHYxMyBu?= =?utf-8?Q?et-next?=
 03/11] net/nebula-matrix: add chip related definitions
Message-ID: <bdaf51a9-66d1-4469-960f-d5ec74f870de@lunn.ch>
References: <20260428114910.2616-1-illusion.wang@nebula-matrix.com>
 <20260428114910.2616-4-illusion.wang@nebula-matrix.com>
 <e41adaad-8937-4b5d-bdbf-d57d3efe2855@redhat.com>
 <b240b971-81b8-4325-80b6-5352e1515f07.Illusion.Wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b240b971-81b8-4325-80b6-5352e1515f07.Illusion.Wang@nebula-matrix.com>

> But I printed out the results: 
> ARRAY_SIZE(nbl_sec009_data) equals NBL_SEC009_SIZE,
> ARRAY_SIZE(nbl_sec025_data) equals NBL_SEC025_SIZE,
> and ARRAY_SIZE(nbl_sec022_data) equals NBL_SEC022_SIZE.
> 
> Is the AI making a mistake here?

Just a guess, i've not looked at this patch at all.

Are you doing this on a 32 bit build? Maybe the AI is?

    Andrew
