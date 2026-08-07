Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53024441021;
	Fri,  7 Aug 2026 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786133782; cv=none; b=WPBXfBQd+PFYPaklXWiJsQxUeSF+oGj8VyqpNXfM8pd6I/Fbs9a0rNdMzmtWUWNd6iWO//i8MB3iA4tHT3CYIg4ZSbDnTkyWAzD7DrqpjMzWid/S7j91TKfYY1ZI/fEhUTWw0FI/DqJUVFFn4oYe1bS7VX98rMmNhxIGG2UNNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786133782; c=relaxed/simple;
	bh=t9sion3LQCfehSPkh/ptYyjGMilpuJm1PsjwwnoxLbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcqiNpxyfmZVGGryPwd9WghEn961pvPbf8NERvTBU6dsDMtbRA5Sm4I19uxCXsciP0McFhpuaglsNsCqEFOXLeU390EgxOz01xOyMMJubBSr/rAv+iHHcDOxz4uVTGFzqm+4u/9s/EROf3JRvAwTPoxNDaTUaDMHs/HTk8j3TVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zR+6xLuk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zR+6xLuk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZE28Ju/ssIIk2vC0q1SaUohySp0VHR84WvDQ9/3yHew=; b=zR+6xLukSk2NUP0bKV0e49Yecp
	WOGQuFAFSDRM2sQadWdJR7vc4TrF3mguCfJFezqIL/vnMlhEC93xzD3CQfvRNRuuUWERWFvzyekgv
	10zAR0PyeWcQjeqNtTMiXbTy71BcqN/k1BRJGMKVi1TToCZ/GOxyEHFv8OEnH8gbcWpY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wsQzB-00GdXD-MD; Fri, 07 Aug 2026 22:16:09 +0200
Date: Fri, 7 Aug 2026 22:16:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sandeep Sondagar <sandeepsondagar@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phylink: treat PSGMII as an inband capable
 interface
Message-ID: <9d558c14-ddff-44d5-bf08-a6fad351e640@lunn.ch>
References: <20260807194937.785825-1-sandeepsondagar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807194937.785825-1-sandeepsondagar@gmail.com>

On Sat, Aug 08, 2026 at 01:19:37AM +0530, Sandeep Sondagar wrote:
> PSGMII (the Qualcomm 5-port SGMII) conveys the link negotiation result
> from the PHY back to the MAC through per-channel inband SGMII words,
> exactly like SGMII and QSGMII.
> 
> However, PHY_INTERFACE_MODE_PSGMII is missing from
> phylink_get_inband_type(), so phylink reports INBAND_NONE for it and
> phylink_pcs_neg_mode() falls back to PHYLINK_PCS_NEG_NONE. The PCS is
> then programmed in force mode and its control-register speed bits (which
> default to 1000base) are used, so a slower copper link - e.g. 100base-T
> - is reported as 1Gbps and cannot pass traffic.
> 
> Classify PSGMII alongside SGMII and QSGMII as INBAND_CISCO_SGMII so the
> PCS negotiates inband and the resolved link speed comes from the PHY
> inband word.
> 
> Signed-off-by: Sandeep Sondagar <sandeepsondagar@gmail.com>

If you are targeting net, this needs a Fixes: tag. When did this
break?

	Andrew
