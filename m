Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E492456DFD;
	Wed,  5 Aug 2026 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932589; cv=none; b=ge0oRdH2oUmFccn0XPOxhO803rBmnYBXjRbQW7gpum+yv+LxdFqmTRBvQFqnV368ykZaRWFaSS6VjvphnFIFjvKMAeUSrwW9cl7MheKk6v1UGiWrcvV6WWFXoM53w1jN0PkLWNOeEGzx4Jh9t6zmw1z0khX+CooAZbZNbws+MOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932589; c=relaxed/simple;
	bh=p6hiuKUYPbCDEUa8VdovzyDtIYEZMwdepebrTe/lPAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glWEX488K7pBlp5//3YJyfWcL6lVeWrJwZsgnbuGlPqStqEzODTYAE+AHI9f1cVo2wbya8C851K+aJU/r+sFfKnEEUC5iqZHDfxPVIurVPFjZ5QPBUgkfAEI4KlEF9X/MCOcHUNKjmSNmn8ZzVlqKJ86eDpzhYtTGU/SxokE0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XY4YXHWo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XY4YXHWo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8XjuuAS9qzELKWMzzGKFt00IGUUpW4MBEhvQC26pWBc=; b=XY4YXHWoFxOikBgzmUK4/FQFSi
	mHJDkn1jprsIY1vu53fcnRoDUYwGNLBLyh8aA8HGBQFJevr6dktTjyoR/sOhysO/pehiL3Pl+Xfuc
	PUvomUBObKIB6exaioP9dCxSjP/mjzrFAobd7YCNCg6uQHuqyqeiR+ClP3X8w/cT+YVU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrae7-00GAIv-J5; Wed, 05 Aug 2026 14:22:55 +0200
Date: Wed, 5 Aug 2026 14:22:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mfd@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net-next v2 6/8] net: phy: add X-Powers AC300 EPHY
 control driver
Message-ID: <05af101c-62d4-4d46-b170-052487ecb681@lunn.ch>
References: <20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com>
 <20260804-submit-acx00-of-dynamic-v1-v2-6-3eef49ff1d8c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-submit-acx00-of-dynamic-v1-v2-6-3eef49ff1d8c@gmail.com>

On Tue, Aug 04, 2026 at 08:27:04PM -0600, James Hilliard wrote:
> The AC300 Fast Ethernet PHY needs a separate non-PHY Clause 22 endpoint
> to complete package setup before the link endpoint becomes usable.

Please use the functions in phy_package.c

    Andrew

---
pw-bot: cr
