Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853A6397321;
	Sun,  9 Aug 2026 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786289100; cv=none; b=fR+BVyqxsbMHRJDLJdmtqGdu5VjfdB6RSHK9JSgnHujdodiDPknBJBE6bk7QnwMwUm4olUw9VohrKDlbc3Q4prfKxrETXtIlMVgFoChKTIXMTHNeZYL1oA4tV60h28Wtj//RkHKafxY8CMNsTvH5ZEJsgRh1ck9LELyfLvjW1WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786289100; c=relaxed/simple;
	bh=cuUJh+50zehlMz+YLNrryEu5fGtwlRvptvWygfPha7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5/+ae33RNN6RmJj4owzrfU9pOek6egVct64sZby0E/ppIhEIGXHi5FR5bzwPsKLts3qVLT3ysFpMnZgtvuuj+Qp9geyxJj0bpqNBv7qqLNDyN90YEe1+N1B+B5hTUN84IUNlTixWNR/HyhBPBzib7gPy7e/P0JbHBpDjdSjdKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Pg5XCser; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Pg5XCser"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QlFQdlpYQXVze/i0pns9IvhVr3wSIHheJL2cxAvWdPU=; b=Pg5XCserdxQ320AjIIF23feJBu
	O2wcnaPXG0xuzz84xL5dbCvQ4B+NylAgFNOypzvNTCktcbD5VhXUlF3zDPS9QAH7kk4kqL5V3ukau
	dXYfrdOXC36ZJJS0lsYKPGAfnbRCq1W0L3ODNdemA6aoKdHyMzFKWsbh4blBpbJ0+xI8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wt5OM-00Gp8O-GO; Sun, 09 Aug 2026 17:24:50 +0200
Date: Sun, 9 Aug 2026 17:24:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sandeep Sondagar <sandeepsondagar@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org, j4g8y7@gmail.com,
	robert.marko@sartura.hr
Subject: Re: [PATCH net v2] net: phylink: treat PSGMII as an inband capable
 interface
Message-ID: <da51c001-c18d-40e2-9757-39e9d759e3c1@lunn.ch>
References: <20260712194937.785825-1-sandeepsondagar@gmail.com>
 <20260808020955.787569-1-sandeepsondagar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808020955.787569-1-sandeepsondagar@gmail.com>

On Sat, Aug 08, 2026 at 07:39:55AM +0530, Sandeep Sondagar wrote:
> PSGMII (the Qualcomm 5-port SGMII) conveys the link negotiation result
> from the PHY back to the MAC through per-channel in-band SGMII words,
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
> PCS negotiates in-band and the resolved link speed comes from the PHY
> in-band word.
> 
> Fixes: 83b5f0253b1e ("net: phy: Introduce PSGMII PHY interface mode")
> Signed-off-by: Sandeep Sondagar <sandeepsondagar@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
