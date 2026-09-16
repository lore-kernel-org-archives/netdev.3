Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D71559D624;
	Wed, 16 Sep 2026 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583983; cv=none; b=Jh+p8EPJYH9PH/oBxlktm8rY0qzG8wEjoCIj08gPmlYRsOYjzDL26/13QHJpbmphArzeNbIGMsJ9s41QAv3LDctiMeu8t2LvOUoYiiMgsId34e3DGhFeB21aRTFjl063jpTdOOBwhtqfn4Osy+T6Ki4LNtH0YQJ56yks8lVZZC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583983; c=relaxed/simple;
	bh=+f5Tgl4cEFfd82o/W147y9QknzaaQJiNYhCNBAio0x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMDkrl64RAV8dTKu9WZ77Lk8e+QQ4lb+u7Rmc+0VoCW4N2wzPaHSvDOTCqj+Ba4j5gKCvyulG7KWy3E0CZdHdCugvVonHVtPcDuWPOi9HpYKitd4DoecWG1J9YA8I1bfqh8De5WHoJx5L/TXqTLLO4p23OiSJ13oyxqjS+7W+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5l45xZVP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5l45xZVP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n8RfaPTtIcuG/AoRXgZK8uOBj18+7W4RZVpPqIbO+pg=; b=5l45xZVPxuKbo+gEAzosZhFSjo
	xNq9Rahs5J9NHg45piEHuVPsAO9d1FfS1aUb9DYWR7CtTR4LySos/YGQxGqSWy125MA+eTnj94SVR
	X+C407wiDntzGcqHY57hisO+aNkPtKHFEYNaPY2+rq7V7drU0SNVpKxuXyWWBYmnSKjw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6uX2-005X4y-Dw; Wed, 16 Sep 2026 20:38:56 +0200
Date: Wed, 16 Sep 2026 20:38:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] r8169: propagate errors from PHY write
 operations
Message-ID: <f4e563a9-5c25-4026-853f-5d5d30f5a0d9@lunn.ch>
References: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
 <20260916152444.167196-2-matheus.aalmeida@inf.ufrgs.br>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916152444.167196-2-matheus.aalmeida@inf.ufrgs.br>

> -static void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
> +static int r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
>  {
>  	if (rtl_ocp_reg_failure(reg))
> -		return;
> +		return 0;
>  
>  	RTL_W32(tp, GPHY_OCP, OCPAR_FLAG | (reg << 15) | data);
>  
> -	rtl_loop_wait_low(tp, &rtl_ocp_gphy_cond, 25, 10);
> +	return rtl_loop_wait_low(tp, &rtl_ocp_gphy_cond, 25, 10) ?
> +		0 : -ETIMEDOUT;

Maybe rewrite rtl_loop_wait_low(), _high() and rtl_loop_wait() to use
iopoll.h?

	Andrew
