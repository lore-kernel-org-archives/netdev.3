Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2066334844C;
	Thu,  2 Jul 2026 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783033486; cv=none; b=VTJw3KHluXVOqL6FD7zXeM8ILB9E/+MxJQFHR6367PT4ffXz3sNEIEGXIJ4tPFo93auGZEmRKE8Rqon45nbz1w/QfH4RCE87FLiLMuoVU2uxFIo81mCVvHq+YI+Nt91vdkf614wQjT81UxLDeueZn6rU8ILaThg9k/vMXo06gug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783033486; c=relaxed/simple;
	bh=2v2rPEjHVsGtiy+kHWOMMw8c4jVma+FxNPnoW2o1n6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msANYRNaJ0si2ieMYFoXTz+PO/sp2lZM9MhxcjMocpLfQoTkWcerj9NdSElRcMVUfz3ZWGIZNAVIotHdxtY8xpJ/ydpyl2PozTvQWMJQvx4Q79omV05gDFWCQAOBiD2kHZwamPJki7aDKQ7HlpRCpd8JuUoeT07JuiN/vUmVHFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IcfikiMJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IcfikiMJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=We0ffywX9vRmupUCoJ2FuGSl3qVbuRmpOg3Wyz3SNZc=; b=IcfikiMJ6jarymOqoX0FklH7GS
	PBSXifd70W7vwxwhw5/kFLot2HnnWUZdG3gqq73z5b9bbju+JanjEXfKmUfVHZ3vtiKD2nJKg7ei4
	KETN1KSpi/6coF7vJxQoiy/0iQS5sCG+pHw/3KGjrjZMr//bbiO/xRU1kLDmGSe2sAnE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfQSO-00ARsN-I5; Fri, 03 Jul 2026 01:04:32 +0200
Date: Fri, 3 Jul 2026 01:04:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ben Brown <ben.brown@alliedtelesis.co.nz>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH] net: phy: marvell: Add soft reset for 88E1510
Message-ID: <3536a59f-405c-452a-a7d6-359c0ea1b151@lunn.ch>
References: <20260702225034.1062457-1-ben.brown@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702225034.1062457-1-ben.brown@alliedtelesis.co.nz>

On Fri, Jul 03, 2026 at 10:50:34AM +1200, Ben Brown wrote:
> When bringing down then up the link on a 88e1512 phy a link is not
> getting established. This is because the phy is coming out of reset then
> immediately getting configured. During configuration the page is
> unsuccessfully updated causing writes to the wrong registers.
> 
> Add the soft reset function that does a reset then polling read waiting
> for the phy to come back online, at which stage the page register can be
> updated successfully.
> 
> This was tested on a 88E1512 phy, using ip link to bring up/down the
> link.

What makes the 88E1512 special that it needs this, but no other
Marvell PHY does?

	Andrew
