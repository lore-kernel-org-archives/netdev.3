Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770DC38D;
	Thu, 29 Jan 2026 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769694711; cv=none; b=KS3iUE3RWwSMF5WSrTbG/nGjfFfb6rgUu+AunBvdjojhkFQFXA94mhRV+0zaVctwLRaQOkDtlQbsBzSxxAPsvmWh8/dTQWDLyT85pdyJKVOW52rbrBBeJJburEeLIXautC4o8aK9TKJRQHRvrk+9MnGFWy3ghNWRqlsXpjHjckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769694711; c=relaxed/simple;
	bh=4FlT/Ehe5yNkBs6wxX5bI7W7kmk/+7Cto8xrSPojX3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwQpvLnKhq7epaj7AsGh6YxjrkDXxnIOy4X62zR7/2F6+r0uGR5kyMXnuiBhx8k0+GVdUET6y7SfNUH6LY0rCx4c8O7fWwPOHOxmI/Eii9WqhtMt84ToJd/FLq/CWJ8T0+DLjTF4BsDR0GVZH60rPdupNWx7WQ7y23NmclCEL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hwVisHL7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hwVisHL7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1lcXkV7KcZEtUSZxPr/UJgAxOsEp8lMqEuRz2Y1R0vE=; b=hwVisHL7Uv8FLJ6eYfbkDJLMes
	GBpeZ08yNuWS77zXJljq9XMAhSSFNHaHoei6AivyUM6YSNcq84R2uyvavYuxP7zKiT5ycYZo0dBuQ
	FYliR8wtdTW7armfsbiZxETCMctIX5SocC+PdGwY/e92ftMUEia4kZKHjir/08z1Fnk3mDTPeGD6q
	dKQlnS5gG450UOSdUTC8Hg5Kg858ej0EejX/vHVk7O6OqadCOKasEBuvar9VTs+V7NZjUn1HaYTS1
	EAQWTr6cSKQg9+5R0gcUZZY9WRJA0KdhprDe6RY0e0kmn5suVKf0DEkKcUhOyhd5ODY/d1yyyO1E9
	F7cjFp5A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43926)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlSQt-0000000008s-36KN;
	Thu, 29 Jan 2026 13:51:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlSQr-00000000822-21Fq;
	Thu, 29 Jan 2026 13:51:37 +0000
Date: Thu, 29 Jan 2026 13:51:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vincent Guittot <vincent.guittot@linaro.org>, vkoul@kernel.org,
	neil.armstrong@linaro.org
Cc: Simon Horman <horms@kernel.org>, krzk+dt@kernel.org,
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com,
	p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com,
	Ionut.Vicovan@nxp.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Frank.li@nxp.com
Subject: Re: [PATCH 2/4] phy: s32g: Add serdes subsystem phy
Message-ID: <aXtl6eQ8zD_olTdc@shell.armlinux.org.uk>
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-3-vincent.guittot@linaro.org>
 <aXsuRTZUUnw0kdzV@horms.kernel.org>
 <CAKfTPtDfnpzq2CB-isVzvh1ZCWo7kit9KRJvVGoU1C3zZTgdXw@mail.gmail.com>
 <aXtfVUb0eLwP4R28@shell.armlinux.org.uk>
 <CAKfTPtCiJcNOdoddZN5N1dKHXfUJBe0=zeWfZ5uENoXDvbMnpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCiJcNOdoddZN5N1dKHXfUJBe0=zeWfZ5uENoXDvbMnpQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 29, 2026 at 02:36:01PM +0100, Vincent Guittot wrote:
> On Thu, 29 Jan 2026 at 14:23, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, Jan 29, 2026 at 02:01:13PM +0100, Vincent Guittot wrote:
> > > yes, the usual pattern is :
> > > - phy_set_mode_ext()
> > > - then phy_power_on()
> > > but I can add an additional check
> >
> > Please read Documentation/driver-api/phy/phy.rst section "Order of API
> > calls" which suggests phy_set_mode_ext() after phy_power_on().
> 
> Fair enough.
> That being said, all pcie drivers  that use phy_set_mode_ext(), call
> it before phy_power_on()

It looks like many ethernet drivers do the same, so I think maybe the
generic PHY documentation is incorrect or misleading, or is expressing
a preference that almost no one follows. Something for the generic PHY
maintainers to look at and/or comment on.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
