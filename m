Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C05322A;
	Thu, 29 Jan 2026 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697043; cv=none; b=smyJM8FoMDkL6V5VFePXTviJSu6swcBPCuHlQKADBlt59/Kc1DEr57yH4VlvW9bMadKsOmGUIja6iX50LH2ArdvCghswx+htrdq1OsfBMn/I+3kWOSZKpauBjhbXxK1v8b3zLw12tUE1vyW/QSHfA8Zy1JyH8Jw1jbxU7jrn2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697043; c=relaxed/simple;
	bh=R8m7a1FGKdQNUJUMAWJS1FeEHbADDyjLfJT3bxHHWNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ec/jB9BxTtftcJmdTeyHyLrybCq1H04+5z76nybi4I8rsDCm/LlNWQbhGh2Bxha5gXxOYbdnFar7/6DXZACU6kmlOrfuBjtXVt9Q4YOA9xIaHVyiZHDc8AqPNal8XCrMXeaGV3kMqptJNZg9TL6rCQpXADZrYcx/WqZO5GpudN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJnkmjiG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJnkmjiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA413C4CEF7;
	Thu, 29 Jan 2026 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769697042;
	bh=R8m7a1FGKdQNUJUMAWJS1FeEHbADDyjLfJT3bxHHWNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJnkmjiGkCFrF4qvF3ug5n40EZjp/rJM3B7h/L+DUXojjYQUAHYYQElxUKSXiXbe4
	 AcrFePyw47VS0dabq3cpyn9Nk/Wc2kgbScqHhqzVTpONzQOO8zf21r5DkmGyFOa/E6
	 n1tr7Ycv5asJd6B4F9d5D+Y80dNqUTJc/v4/TG2U+uCPcE1tjdhpxifXxWORBC/OxN
	 s8xJ1UTQ6BlqjKXrzhzos3DwskpOfPcX5nuFbhgVzdCYw2T9s1RHeG8JBqQQfH6tyK
	 ySkrzRt0VpcPDAWbLtDHSbITuhVkXCtQ0D7q3gDyiMj6Q7OUESbTS2SUyMv+bIGwZ7
	 yWuSLmupGl95A==
Date: Thu, 29 Jan 2026 20:00:38 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, neil.armstrong@linaro.org,
	Simon Horman <horms@kernel.org>, krzk+dt@kernel.org,
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com,
	p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com,
	Ionut.Vicovan@nxp.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Frank.li@nxp.com
Subject: Re: [PATCH 2/4] phy: s32g: Add serdes subsystem phy
Message-ID: <aXtvDn_-pCuKPrnf@vaman>
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-3-vincent.guittot@linaro.org>
 <aXsuRTZUUnw0kdzV@horms.kernel.org>
 <CAKfTPtDfnpzq2CB-isVzvh1ZCWo7kit9KRJvVGoU1C3zZTgdXw@mail.gmail.com>
 <aXtfVUb0eLwP4R28@shell.armlinux.org.uk>
 <CAKfTPtCiJcNOdoddZN5N1dKHXfUJBe0=zeWfZ5uENoXDvbMnpQ@mail.gmail.com>
 <aXtl6eQ8zD_olTdc@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXtl6eQ8zD_olTdc@shell.armlinux.org.uk>

On 29-01-26, 13:51, Russell King (Oracle) wrote:
> On Thu, Jan 29, 2026 at 02:36:01PM +0100, Vincent Guittot wrote:
> > On Thu, 29 Jan 2026 at 14:23, Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Thu, Jan 29, 2026 at 02:01:13PM +0100, Vincent Guittot wrote:
> > > > yes, the usual pattern is :
> > > > - phy_set_mode_ext()
> > > > - then phy_power_on()
> > > > but I can add an additional check
> > >
> > > Please read Documentation/driver-api/phy/phy.rst section "Order of API
> > > calls" which suggests phy_set_mode_ext() after phy_power_on().
> > 
> > Fair enough.
> > That being said, all pcie drivers  that use phy_set_mode_ext(), call
> > it before phy_power_on()
> 
> It looks like many ethernet drivers do the same, so I think maybe the
> generic PHY documentation is incorrect or misleading, or is expressing
> a preference that almost no one follows. Something for the generic PHY
> maintainers to look at and/or comment on.

I would feel it makes sense to configure the mode first and then power
the phy up. As commented above yes it looks like apart from one tegra
driver rest seem to do it this way.

Lets update the documentation

-- 
~Vinod
