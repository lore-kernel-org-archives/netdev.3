Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09452843F;
	Wed, 23 Sep 2026 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168964; cv=none; b=fontmqjTFRWlgkIWaGtn8Vd891jccURn/Mvr3fYk+kZOBS6nS/eAssgjHn6Cm1/LYJZhrZfwxtg7csMnJtzjs5U8VRaXGxKJIU2G5fxBzrApRlgjFiDAj6Nv5eNumfNHJ6ucx/JPEVBbIWvYdPe9mEG9SI6WJI17Gd/bXp9Gmxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168964; c=relaxed/simple;
	bh=PMfQYJu4S+eyo4CBcRx81ldB54dXieCgifT7oTiD4WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8RGHUXtUJ2iqkaqzJPCwIXlBZkI0D+rXRtfTCWlXbDX72WxmNy1d61XGqkWsnb6y2+bXMq5EvQn5SdyezZpMPBaL1MA6zwCFzUVHqMmABiKLPeYeZeqayNKsEJfsQWRIBxpsLF8yV3wO6le1823A46/C39WXw5VP8QVIOXlTUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ijRDIoVc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ijRDIoVc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eX4lFJvGPAAq+TJkwdWXeBO2K4L3FS4jS7wg6NEAm3A=; b=ijRDIoVchibeZIUomjltED/2Hq
	VfxSznYOnK+TKFtBwkXpLs4nqsS0KB4L5IpvK3W62pbep+V5Z3dF8tMMIybdkQA9cUYh/IqgOp9K6
	ZcJ+7Mrpn3YQg1KknkSRVw7gQn0AIx2TzD0Rpg/giMDIqJxODtoWeq0eZxmzbsHxsFkw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9Mib-006oGi-Qs; Wed, 23 Sep 2026 15:09:01 +0200
Date: Wed, 23 Sep 2026 15:09:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Cc: shengchao.guo@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
	mohd.anwar@oss.qualcomm.com, maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: stmmac: support low-speed USXGMII validation
Message-ID: <e05baad3-49ec-4db0-ac70-ffd8e0f52b10@lunn.ch>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923084921.3942100-1-zhangfei.gao@oss.qualcomm.com>
 <20260923084921.3942100-2-zhangfei.gao@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923084921.3942100-2-zhangfei.gao@oss.qualcomm.com>

> The XPCS also consumes the PHY-generated Clause 37 in-band link and
> speed status, so USXGMII must use in-band signalling.

Is this a qualcomm specific feature, or defined in the databook of the
licensed IP.

>  	case DW_AN_C37_USXGMII:
> -		return LINK_INBAND_DISABLE;
> +		/* The PCS consumes the PHY's CL37 in-band link and speed status. */
> +		return LINK_INBAND_ENABLE;

I ask, because when i look at this, i immediately think is this a
behaviour change? Is it going to break existing systems? Or was the
old code broken?

The commit message is where you try to guess what reviewers are going
to ask, and answer the question before they ask. Seeing such answers
in the commit message gives me a good idea you have done your due
diligence, and the patch is probably O.K. Without such comments, i
have to assume this is poor quality code and really exam it in detail.

     Andrew
