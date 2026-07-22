Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A318E24676D;
	Wed, 22 Jul 2026 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727462; cv=none; b=e/Ii38V3xb+a8kfEvPclCNKNSzpUX/4on2zIroiorHqy1rzvjB3chNPzv2GaE0z9fzS6JOYyo5CWQY0cO7QRL3eAPGixf/4NGvX9G/mWSjrg9PSxmxUS04FPLM/rIWUNw4XAbXDnnFyS9ibGWOSFnDynMmpOKtv/ycL1OmbfNpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727462; c=relaxed/simple;
	bh=sd2eC4lZSMcDxz6OS/IOivS5mejSy6pG698mz8TjVUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeE1PquyJF19ERaBN8XwGvGa8jT0m1i1lO5c55MNKhUtb6r82lu+EmhwNpkjq59qseXiRjAs/JZRWcAxyZZKckRwqM2ZoVnfcbyEvUMs/1pV751SzVPMgVQaZxBCgBpo+2KorTQWuXY3x+E5xppNT9qZXx04sGMiTBPaG+8shDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ta/98/TE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ta/98/TE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bMw0V9fb9Cp+8riohawi3qSk/wwI8ylTID223oQ0L1g=; b=ta/98/TEYyf0q1+SEh5aEx1Aj0
	zh3MlbSwfks7tWo0hY0HJvC2Dq1gIPa2laDN6K6qW7V8xsOFnZvn6Ut1OzX2QB8OA9x+4rMVi3NuG
	5USqsMfvcYPOmH2dwoVIxaUpF7D7QR3o90fIM3PSSnb6cQXwDdJBamWQcTMkB44n12S8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmX8f-00DdWe-MY; Wed, 22 Jul 2026 15:37:33 +0200
Date: Wed, 22 Jul 2026 15:37:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: kr494167@gmail.com
Cc: ioana.ciornei@nxp.com, vladimir.oltean@nxp.com, vkoul@kernel.org,
	neil.armstrong@linaro.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: fsl-lynx-28g: propagate PCVT enable errors
Message-ID: <59053559-8590-4d7f-808f-bff1bbea09e7@lunn.ch>
References: <20260722033619.10647-1-kr494167@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722033619.10647-1-kr494167@gmail.com>

On Wed, Jul 22, 2026 at 09:06:19AM +0530, kr494167@gmail.com wrote:
> From: surendra <kr494167@gmail.com>
> 
> lynx_28g_set_mode() currently ignores failures from
> lynx_28g_lane_enable_pcvt(). It then updates the lane mode and reports
> success even though the protocol converter may remain disabled.
> 
> Propagate the error and leave the previous lane mode intact so the caller
> can handle the failed reconfiguration.
> 
> Fixes: 8f73b37cf3fb ("phy: add support for the Layerscape SerDes 28G")
> Signed-off-by: surendra <kr494167@gmail.com>
> ---
>  drivers/phy/freescale/phy-fsl-lynx-28g.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
> index 38afcd081a2a..1fe406adc83c 100644
> --- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
> +++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
> @@ -1003,7 +1003,9 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
>  
>  	lynx_28g_lane_change_proto_conf(lane, lane_mode);
>  	lynx_28g_lane_remap_pll(lane, lane_mode);
> -	WARN_ON(lynx_28g_lane_enable_pcvt(lane, lane_mode));

A WARN_ON() produces a very noticeable splat, which will aid
debugging. Just returning the error code makes is easy to miss what
causes the issue. Maybe the WARN_ON() should be kept? At least, i
would add justification to the commit message for removing it.

    Andrew

---
pw-bot: cr
