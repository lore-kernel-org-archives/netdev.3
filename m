Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60D1FE471;
	Sun,  9 Aug 2026 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786296611; cv=none; b=QXsMUppOzviQEH8WdXcbh+QGTzFpqGevw6OxzGoBeLT19KajwdG5pfhQWv5OK3j3foUGNx3Izme1PUn0UEj+tC0AnWKwe0TLfoWGKiUdrA8rqETnntZd4k7mIjK4KA9oQilPoJL5vXHI9SaxCj+0MNdcWaPF7sRt60CpCb0WBXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786296611; c=relaxed/simple;
	bh=PdJJC3jZEsT9AsF0KQ7GKyhBddN6YSTGc8B4cKMLbbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRNngIi7ZVdTfljDutdNiJaY6NYkN4L8wgtlqYONr59ZMSKJONmjZheJKpGxUhxNoDwRgNal/vrROlx5tK/RjBdjkCoUzLDkYn0SWuzzRWcgWK1CRzSGE/UMwdHdPZCTDk8sNjz8sGfBbnNPFsxuuqVwV3CnB0LFLNyC53Bmcfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ODwcXe2s; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ODwcXe2s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Us/yxeZ6wwubj5U9xONB7RaidvSHc+eag+wpQLfxyCY=; b=ODwcXe2sSCRkqUjH85Q4ytEYcF
	o0exTbl/kVkQJGsfGyBbJhxvTIVvCpz4cfLZ2lQ426doZbZUW8iQVsXw/2KbbCygnJJRgQw0AsYAf
	qZD3b4FDJltbS8VeURY4R+m2ACmY3xsOr25Mhb6hWTAbHbPV6B9i+/TGF8RnxRK/WEHk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wt7LT-00GpsI-AI; Sun, 09 Aug 2026 19:29:59 +0200
Date: Sun, 9 Aug 2026 19:29:59 +0200
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
Subject: Re: [PATCH net-next v11 04/12] net: phylink: save phylink instance
 fwnode on phylink_create
Message-ID: <351e90da-88bd-4dea-b75f-d848fe465ba1@lunn.ch>
References: <20260807131301.192060-1-ansuelsmth@gmail.com>
 <20260807131301.192060-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807131301.192060-5-ansuelsmth@gmail.com>

On Fri, Aug 07, 2026 at 03:12:46PM +0200, Christian Marangi wrote:
> The firmware node associated with the phylink instance might differ from
> the device firmware node passed in phylink_config as such device can
> reference the parent switch or other platform peripherals.
> 
> Some function might need to reference this firmware node after
> phylink_create so add a dedicated fwnode entry in phylink internal struct
> and save it on phylink_create().
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
