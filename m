Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27965448D0D;
	Thu, 30 Jul 2026 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429286; cv=none; b=ghlRdGcxt6YDuAsjARTjIUqQWaR2z0hGog7XSh7RbN++s1X/lWSK+OqzIErpg6SQb0JtPaumv5W5HJdHuQGtq21gWQ7m82nnW9IskXE5iEoGltdoRpSgshVGVxtrDR8ATx9TIHj3csTusvoQwfjjd8nLwEQclWI1RBfAhzQ7pqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429286; c=relaxed/simple;
	bh=1PuMJJvJlG1Zm0cchYttJHHdZBgvkDXaaOdZaFfrUdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyjGHfeDAFzspbZbHbK7xWfh04UjvBLZsvb4GfdHnu8EXvOv5VTBkAa7iB7oX5i8tcQKUGg+/MfEffsmQsqVMcGe0AdSevkMOrQaTBE0g0meNXSqxM8JSP7gxau/9EdqBaI555CXfsKnhb+VXrGvT5ceL4OwfW5jeyki4VfCTy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfwB/iHw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfwB/iHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E431F000E9;
	Thu, 30 Jul 2026 16:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785429284;
	bh=XWg6SdRoiEscgSxEnJp0ilq1kD+g/1pc5IyB6EebBtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cfwB/iHwzmlJITXYQBcJp/3oWznakyomnl8TSf5UOQbeXnA01Sn70zhTqRdkgDPCY
	 wKT5wXBLDQteNfM9zaZpnl2ie7MBmB3e29tkFjn8J90REnfVprGmK+TQxA5yygUlze
	 eBInxRzEs3wjKHNPOTl4F0R8ZwLTL3cdjnRklDPhrDytqmSSjlvU6Te8Gt2/p+zCJ2
	 XnCMLjGYvBgKDWn4DgDJ2zLZOfKNuSqhPImg/XlJlo83tK83gaZ4nk4Q8PpLBJHElA
	 9xURl4O955Niz9td2WK1FcsXLXtrmQCMJ2vnRUI5SrI0hFLmjafRPLDK6tlkpfV39F
	 tgyHU/Epcb9Lg==
Date: Thu, 30 Jul 2026 17:34:40 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	yangshuaisong@h-partners.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 net] net: hns3: fix speed configuration residue after
 driver reload
Message-ID: <20260730163440.GE51943@horms.kernel.org>
References: <20260724093036.426631-1-shaojijie@huawei.com>
 <20260729110240.GA76598@horms.kernel.org>
 <87b5d9ec-3a8d-4bca-92d0-53d27beb9e2b@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87b5d9ec-3a8d-4bca-92d0-53d27beb9e2b@huawei.com>

On Wed, Jul 29, 2026 at 07:45:21PM +0800, Jijie Shao wrote:
> 
> on 2026/7/29 19:03, Simon Horman wrote:
> > On Fri, Jul 24, 2026 at 05:30:36PM +0800, Jijie Shao wrote:
> > > After setting a 100G optical port to 40G via ethtool and reloading
> > > the driver, the port remains at 40G instead of reverting to the
> > > firmware default speed of 100G.
> > > 
> > > The commit referenced in Fixes: added two overwrites in
> > > hclge_init_ae_dev() for non-copper media, so that optical ports
> > > connected to forced-mode remotes inherit the firmware-preset
> > > autoneg and speed instead of the hardcoded defaults:
> > > 
> > >    req_autoneg = mac.autoneg
> > >    req_speed   = mac.speed         (when autoneg disabled)
> > > 
> > > The autoneg overwrite keeps existing behavior:
> > > hclge_set_autoneg_speed_dup() already uses mac.autoneg (not
> > > req_autoneg) since it was introduced, so autoneg inheritance from
> > > firmware was already in place. This part is kept.
> > The AI-generated review on netdev-ai [1] flags that this isn't strictly
> > true as req_autoneg does appear to be used in hclge_set_autoneg_speed_dup().
> > I don't want to nitpick, but perhaps this is worth clarifying.
> > 
> > [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260724093036.426631-1-shaojijie%40huawei.com
> 
> 
> The intent is to restore the pre-c711f6d1cee9 behavior for non-copper
> media, where the helper read mac.autoneg directly and fiber ports
> inherited firmware autoneg at init. c711f6d1cee9 switched the helper
> to req_autoneg, breaking that inheritance; d9d349c4e8a0 (same patchset)
> added the explicit req_autoneg = autoneg copy to restore
> it, and also added a req_speed = mac.speed copy.
> 
> This patch keeps the req_autoneg copy — load-bearing as the sole
> init-time path for non-copper media — and drops the req_speed copy,
> which is the residue source. The commit message wording about the
> helper reading mac.autoneg describes the pre-c711f6d1cee9 state,
> not the current code.

Thanks for clarifying.

In that case all seems to be in order to me.

Reviewed-by: Simon Horman <horms@kernel.org>

