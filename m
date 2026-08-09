Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1BB26F2BF;
	Sun,  9 Aug 2026 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786296367; cv=none; b=CjQSAVaJKLLHpycoYimC6DIpUQnJVzqkHuziNBqoblXRmnOvOBcOVXvjMSIND1bl0QhuVGFCZUjqd0aphh9eeIFu6B3wTrJm2M9nMjRaQY0NLHwjYDmIwxk72OOri0QzdDytSJNkkuueVc9VIOnfQ2lCXvDE4/RqrEC8acrJEr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786296367; c=relaxed/simple;
	bh=6UrDoWCemHZaHTA5t+2EbSF//z0gX4NZCttaryizV5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fK6+n09CZa1Cps06QkZEeH5Oe3ePDy9/iOnDT1SUa4fzRkoHFOXvxq91WcH9cvMCzqMJNeGHDgVWPtG/V5sO5jls1YTCqteItmNnLvGr/Of61usO1PMr/D1EbN7q5yn+g6eOrA4oQg3b2VwG1Ls0w/s3XTYevt2sY39yTbWxbvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=voAcElwK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="voAcElwK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ry9fk0XG9JYbqeFPh0yNld54SQt3A83a8vQYvm01BjY=; b=voAcElwKJGsW/1k0o6ZQjOjwA9
	AMbOZ2HQBU3A0RvorYkukinZR6ZouFHHTdmG8KGPGhEEN3r8qJQRl96TthwUiGUgzBjetNnHIY2Au
	HW3Wn2WZC8EXW2fv/AJLKQKJ50eoNV6mMfIgg/0JmkTa5VPk4PhweO3gtL6NeEHGxVfc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wt7HW-00Gpot-Ip; Sun, 09 Aug 2026 19:25:54 +0200
Date: Sun, 9 Aug 2026 19:25:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v11 02/12] net: phylink: introduce internal
 phylink PCS handling
Message-ID: <72c39d88-f901-48e0-ac3d-c7aca6e98dd5@lunn.ch>
References: <20260807131301.192060-1-ansuelsmth@gmail.com>
 <20260807131301.192060-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807131301.192060-3-ansuelsmth@gmail.com>

> +++ b/drivers/net/phy/phylink.c
> @@ -60,6 +60,9 @@ struct phylink {
>  	/* The link configuration settings */
>  	struct phylink_link_state link_config;
>  
> +	/* List of available PCS */
> +	struct list_head pcs_list;
> +
>  	/* What interface are supported by the current link.
>  	 * Can change on removal or addition of new PCS.
>  	 */
> @@ -154,6 +157,8 @@ static const phy_interface_t phylink_sfp_interface_preference[] = {
>  
>  static DECLARE_PHY_INTERFACE_MASK(phylink_sfp_interfaces);
>  
> +static void phylink_run_resolve(struct phylink *pl);

forward definitions are not liked. Please add a patch which moves it
earlier.

	Andrew
