Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9495449ED6;
	Wed,  2 Sep 2026 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359371; cv=none; b=VkUN3YCQntxW5UMSSBaqZp26/0ZowBnvFMHZb3+gPcF9lPf0r/NfalRucV+uS+VUXKpaI5OPYBlIFxF9isTvvflpmg6+rapx02hIW8WWKaGDKjpJxbAcMyVdk6mTSfcPMNZh9QYECADSxCzFbqi8tbJAN+QGk3Gph4lbCShh/LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359371; c=relaxed/simple;
	bh=eFvTesQXbbnIOgn4z5XSLRkHMDaLaDmWWkgjyX/iymc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A75dxcFgCRA5tnAxoveYSRR+fBGcpSTns9Lp5k51YEDVYzFC48O4pyXItzj9UYkdj7lm2oeBvrWGo14/ymjVZqtOHHNu44GoCVuJcPxkh3+T37OhwMOxG0le2SZmHYEWRnRxTgTdqweFb0QvO/wZZlWJn+Y+S6IKcrnKFmYs+T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=As1F1XUL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="As1F1XUL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wcVmGicm0g4KKWFpQ8yskMFXBwKdhxtZU/RkcZob2Rs=; b=As1F1XUL6njlMjWJtzZoRP2ohp
	3dTorhM2Eyv5eYWhDcNYo6es4kxWTdxtvfsdwbkAwlCteFx+mmWv8F1zYUpxuH5Ud2Rz7zQopjN6o
	2n6JoSfImcDkHOGftgjh7r34CwoJPCevSh4AnGU9Jt+jfcNDq9feM9oOCbyFhmOak6jA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1lxP-002X7Q-WD; Wed, 02 Sep 2026 16:28:56 +0200
Date: Wed, 2 Sep 2026 16:28:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, linux@armlinux.org.uk,
	enelsonmoore@gmail.com, daniel@thingy.jp
Subject: Re: [PATCH net-next v9 0/7] r8169: add support for phylink
Message-ID: <f8376f65-f3df-4488-9ded-d97541734fcd@lunn.ch>
References: <20260831053745.1197-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831053745.1197-1-javen_xu@realsil.com.cn>

On Mon, Aug 31, 2026 at 01:37:38PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This series patch adds support for phylink. RTL8116af is a fiber mode
> card, link status and speed can not be read from standard phy reg. So
> we read link status and speed from serdes reg by pcs. So as RTL8127atf.

I think there is still too much code accessing the PHY, but lets get
this merged, so it is easier to see what is left, and figure out how
it can be cleaned up.

	Andrew
