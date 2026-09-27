Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640EB3B71B0;
	Sun, 27 Sep 2026 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790535098; cv=none; b=BBpA8buysf6cvS3dgy7tQAgj5eiJHAB+2Wdwertk3iSD8C3ZmGndVz6FgDFIw0NSkuqex5fhNlOSHUb45ZW9xvucIgBPwrmVEQFhlc9zuWvZCtC0A7noYIc7KEzbKLZzqX/5DjPLkT2z6jPV7jP6UWwZZon7ypg7ud392QHD23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790535098; c=relaxed/simple;
	bh=exooF4t8Z/X13rQf10O4FQSD1sBZu2VEBBgxA+Eg2lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ1ERlc+AwtfmrO3rXUa1CagU2fcdJxWLlGxX6hBav/NU4ccW2APuuZmecQYLW2ESie65wpA//C1F9DtnQTNklmn5mPcWDoRvNXH2pVU/mxeGF7A8e6LdEKo7+rj+drduof0pr5/2e1+gOa2JU2Z0uAqHQFHD2c+aStoFzRRvqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Sgtlxa2+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sgtlxa2+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CcZlrq36jN2pkMV34cMOplpSYdzUUCdpucEDszn1/ZI=; b=Sgtlxa2+GoXGuP42agneQT3GjG
	6LvNym4fI8J17O1966sfV8n3zcjN4UbsfrOFbI7XJdfhUKVk1s2a0yjRMxD8kq6WAg/Um+T1BUqMr
	+atVPOeGT1RqnXws9hm8wYyw92x6DF3sw2e1c2H2ox+Z7STKT8L48syvAUkUPUGNlUTs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAty5-007YPf-Vs; Sun, 27 Sep 2026 20:51:21 +0200
Date: Sun, 27 Sep 2026 20:51:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v23 7/9] MAINTAINERS: add myself as maintainer
 for Airoha AN8855 Switch
Message-ID: <7be51225-fe6e-466a-83ee-fbf0dac22610@lunn.ch>
References: <20260925182435.21207-1-ansuelsmth@gmail.com>
 <20260925182435.21207-8-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925182435.21207-8-ansuelsmth@gmail.com>

On Fri, Sep 25, 2026 at 08:24:29PM +0200, Christian Marangi wrote:
> Add myself as maintainer for AN8855 DSA driver and all the related
> subdriver (mfd, mdio, phy, nvmem)
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
