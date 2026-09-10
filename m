Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9041F12F8;
	Thu, 10 Sep 2026 00:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789001297; cv=none; b=dqcBCo8saO+G91ZLJr/6u4LWPUV+lqV2yxKBSM49CCPXPQ/ifck0sob0OkVC9ytnXpKmK8kS4lK9EX7BLa9wfF1zPxgW87tbp214sdLsxLqkXjWKlnPTDbwRgA0ZYBZSFUWodwwYG2S/JmismxVgrTO6MguzzpNU0VSMNVnBd6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789001297; c=relaxed/simple;
	bh=bPpwF6iEuxSHgVxXvp+D5OclrHOrA/QktI+w8CtdnH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azODNRcFkSLD288TWb2o3vkxi7q59U03vzlFJJWh9hw3JSG7kMcYO8uVK+7phwVOsxvbrLs5tZTmmBGJq2xXjagX08EZ+SRA84y5Trjn1IwCq5zYCuIwgH03gKRMvF2J3Z+E42fOysu1L1+8n/p6etZPGCWrCLewH7Bf5qoWNJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDAqig/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDAqig/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D880E1F000FF;
	Thu, 10 Sep 2026 00:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789001296;
	bh=tzF23XXHHxB/VituFYYpHS3Om5RRZkcBvZ9tE0eGRK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QDAqig/V9zY+s592gJu2YcJTG3i5Ph8FXV92F/mcdepL4BniZfyyb2tzxJ2DRPzDK
	 2qhKWZ8nZEq05rWfpNp5iBDIoUxK3Hch0MCdiG2rWYvjSzux9/GBYB5u1a/lK16O3J
	 ib01/HfnJot5zYBet44sUtGIwhxyW/xBCVwd1V9GnxHE1zNW0WHQYdiYP+ASic3Oq9
	 sdE8lCG3FNkASsTb7b6XUJ6bZUwkXXeKtxJlz4MdCuKPoozLndo+C9PwNyUDRA89Ew
	 n5yY3YqSCrvx7D+JPceWKuCJWe0WgO2shHUKqlopWhw90tP7/bKnVRKQCQ1lg8+bkj
	 g70Yyjsma3zjQ==
Date: Wed, 9 Sep 2026 17:48:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: air_en8811h: simplify
 en8811h_probe() trailing return
Message-ID: <20260909174815.7c857995@kernel.org>
In-Reply-To: <20260906193557.35115-1-sochnev.v.74@gmail.com>
References: <20260906193557.35115-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Sep 2026 20:35:57 +0100 Vitaliy Sochnev wrote:
> en8811h_clk_provider_setup() is now the last statement in the
> function, so the intermediate "if (ret) return ret; return 0;" is
> redundant.
> 
> Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
> ---
>  drivers/net/phy/air_en8811h.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
> index ec7c44ca68e7..99221ee87977 100644
> --- a/drivers/net/phy/air_en8811h.c
> +++ b/drivers/net/phy/air_en8811h.c
> @@ -1168,11 +1168,7 @@ static int en8811h_probe(struct phy_device *phydev)
>  
>  	priv->phydev = phydev;
>  	/* Co-Clock Output */
> -	ret = en8811h_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return en8811h_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
>  }
>  
>  static int an8811hb_config_serdes_polarity(struct phy_device *phydev)

It's a personal preference, someone may think it's better to keep the
ret handling separate to avoid changing git blame when more code is
added. The shorter version is probably slightly better but not enough
to justify a cleanup of this sort IMO, sorry.
