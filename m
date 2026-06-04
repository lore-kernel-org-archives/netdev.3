Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0AA39DBE8;
	Thu,  4 Jun 2026 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561082; cv=none; b=OgV1e7Evwv3i6Z6RAl6FbP+bwkLGSBLBUF8J+SOT9cfTur4uj1oa5F9KMUrLhzRDdmVrZ4qi5/JuExGsZ3Z4tV8e8Bzk5zkDAEUDydkNnds3DawFXScNPJKSAPWkc4EdumqLwpuIP15b9jzvGgj+OWHuRIY/wSnOxl7e+WeU6fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561082; c=relaxed/simple;
	bh=ByEm3TUK6eUzjF5SjlhbvOJ6jVwo3FM3oHJbVBvrrmc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PgvqQ0YDdmU4PTU1xNHBw6+gcCBIiS0EBhZy9pXkoSDW1Rz9KekVNAGInS6H2Ln6pHfoy0SqXeyngPE8liqE3Da0LmAqA4gfny9tTB6nxd4JxaAZE1dAZ+pWjnKb2B85amtJkOTHOc+Q/gWtLDSpW/n7Dsg1oGNxJzL1UMu18PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Q7rptp2N; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Q7rptp2N"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A66EFA4C2B;
	Thu,  4 Jun 2026 10:17:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780561078; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6A98WJJ7gTV9m+rio9++J4CMz0Lll/v+T5HkaBJuKnE=;
	b=Q7rptp2Nomp+MyBrxG2yQVSXEtIAccyjmKvrCIzs+J/JXf/EfDv0f44QJi/b6p7c/HGkfb
	QlJs70qIhOMdn+/P7aZc/qYW1IxGvn4NI3lBb45PgyVFsx2fE9jq+ZJaWi1G8mjtoRnME2
	xTUFJSWYyIeKlUQgxG8cluzuOsMU28QeQTdxtCZ3DDItq0Cym8Sl+IKV1Xqf4WjcuyfxdI
	3Gg2y7P97/8NqYPjtYTLn33bFESjZ8yazXgkzaGcfkJ21xgal0GtKHtUNOe917QY30OKDy
	i20mXqa5IRW3szQjf6EvD0D5tINk6UY96LbrlNJ/lx3ZIoPn8lDXC7ydFIg8hg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Jun 2026 10:17:55 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v2 1/4] net: phy: c45: add
 genphy_c45_soft_reset()
In-Reply-To: <20260604074209.93-2-javen_xu@realsil.com.cn>
References: <20260604074209.93-1-javen_xu@realsil.com.cn>
 <20260604074209.93-2-javen_xu@realsil.com.cn>
Message-ID: <e0fd12f5a19611e6fa4a1fff64baed51@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Javen

On 4.6.2026 09:42, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add a generic Clause 45 software reset helper. The helper sets the 
> reset
> bit in the PMA/PMD control register and waits until the bit is cleared 
> by
> hardware.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

> [...]

> +
>  /**
>   * genphy_c45_restart_aneg - Enable and restart auto-negotiation
>   * @phydev: target phy_device struct
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 199a7aaa341b..25a66320df56 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -2309,6 +2309,7 @@ int genphy_c37_read_status(struct phy_device 
> *phydev, bool *changed);
>  /* Clause 45 PHY */
>  int genphy_c45_restart_aneg(struct phy_device *phydev);
>  int genphy_c45_check_and_restart_aneg(struct phy_device *phydev, bool 
> restart);
> +int genphy_c45_soft_reset(struct phy_device *phydev);
>  int genphy_c45_aneg_done(struct phy_device *phydev);
>  int genphy_c45_read_link(struct phy_device *phydev);
>  int genphy_c45_read_lpa(struct phy_device *phydev);

nit: Ordering in c and header files mismatches, but this probably my OCD 
:-)

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

THanks,
Nicolai
