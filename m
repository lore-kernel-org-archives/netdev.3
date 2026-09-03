Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055AC339393;
	Thu,  3 Sep 2026 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446252; cv=none; b=LIDF1EiNfpY6oxliOlPxefIEsfx7u+Ai3ysdNscKifXb+EQ+Or6WTkbKYut8Z7waV6vIh9tW/5wX74eet+Val+9US2k1NcCvyQncOTO/zxLu8nbgncyKSMWgVvIHZ+YCYpqm8k/JzqUSV2iRBOTUJHl4FK5TY2hPduUteYIlO9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446252; c=relaxed/simple;
	bh=25sfnjrYMyiyi3Tzjt+wXiLm/hFswPpqI9Ab2qlVp+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpeLfLCUdsaMmaWGZBDk4bCjlBmmfdSY92fhUQqQ6i7dtC/4mt1Ws65rXegaxOVK4iDJ9IeWgPyDuXkZ12W3ySUsPQ2+lEnyI2+3rZYTeG8a2+VGpf4xeddCdQD5Nl0TPRThylkPq/Fx91lzO23yhdL+9rTZtEvtrP9Ztp+bcSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PF3Ks04L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PF3Ks04L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LEz9Tb9f8OVoBDZLKQcN/GJCDuYh/GaMSq25q2xb+7s=; b=PF3Ks04L3diGp+VtXZXP33e5O3
	AyDbU4I/0ckZ80xeuM6bOrNj8KsMlZDEEI82w+tHbrXwYfVudiLDctGRb9QcmY1be0WeKQQhW+aTU
	q0S9Vq0sgmIOc4v+A1GozFSun1/1y39DCXyM+lpU8qHNTpg6NEESrQVspv6m3hsPTVd8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x28Z1-002k4y-TM; Thu, 03 Sep 2026 16:37:15 +0200
Date: Thu, 3 Sep 2026 16:37:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: "phucduc.bui@gmail.com" <phucduc.bui@gmail.com>,
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Fugang Duan <fugang.duan@nxp.com>,
	Anson Huang <Anson.Huang@nxp.com>,
	Stephen Boyd <swboyd@chromium.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: fec: Propagate PTP initialization errors
Message-ID: <12f294b9-a8e0-4d62-bc08-b23f7c66931e@lunn.ch>
References: <20260903092430.354186-1-phucduc.bui@gmail.com>
 <GV2PR04MB117394049F412AAAC59FE93FE88B62@GV2PR04MB11739.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR04MB117394049F412AAAC59FE93FE88B62@GV2PR04MB11739.eurprd04.prod.outlook.com>

On Thu, Sep 03, 2026 at 09:29:11AM +0000, Wei Fang wrote:
> > Change fec_ptp_init() to return an error code instead of silently
> > ignoring failures during PTP initialization.
> > 
> > The PPS IRQ is not required for the FEC/PTP functionality, so its
> > absence should not make the probe fail. However, an unavailable
> > optional IRQ should be distinguished from an actual error returned
> > during the IRQ lookup.
> > 
> > If a platform does not support the PPS IRQ, it can omit the IRQ from
> > its device tree and the optional lookup will return -ENXIO. Propagate
> > other errors from the IRQ lookup instead of silently ignoring them.
> > 
> > Also propagate failures from devm_request_irq() and ptp_clock_register().
> > 
> > Update the function declaration in fec.h accordingly.
> > 
> > Found by manual code inspection.
> > 
> > Fixes: b86bcb299092 ("net: fec_ptp: Use platform_get_irq_xxx_optional() to
> > avoid error message")
> 
> If this is a bug fix, it should target to net tree rather than net-next.

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Stable rules say it must be a bug that bothers people. Does this
bother you?

       Andrew
