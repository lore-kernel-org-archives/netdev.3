Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5B233953;
	Sun, 19 Jul 2026 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784475317; cv=none; b=fFDIMehMUqENA91ls+z8uIPFqWW+XPZLV5k9ehA7/FfA0v2s8lbvHKKK6VLT86Kkoi0lNtEZwpvvJ8ItvwoXm6NLp8f+r3MYVsY214UQwY2YUJmuYVWAuaP8x+vSFk43LQ1mBIwrgIt7IwdU7aCwft23v7ESO7u7wD5zipXv/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784475317; c=relaxed/simple;
	bh=jUkkh4wv43BWR9DvuI5n5+PQAju4g1DJW6CyzhPO0ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dC3ZfxQcjs3InolnFBn+HiXc9XuR01KrJpRVlFJQw/nhwMaUiig51lCcUZBzbGrjERtn2XsL+qva9fK+W6DjQDnISUuIEWM7ldT+CO38R/hpxycoi7jSGqYYNvK5saaO/TfTL3yUYMFFXmZvIyWUUM+/FtkmKc3RNm8BkCkiOvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zUHEfQmz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zUHEfQmz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QL3WAS6qAwfUzWShk/ZMh4Zf5wiO0S+HMW1AfZITg6U=; b=zUHEfQmz9m9Y0r2wTXye2upa4q
	Tb+SyVouGmQzHVR/kIZYaoLBiJW9QSlKzveqW8N2huj6fymzZVvMQa2h8KQuruRW+whVTYO6BFqX5
	cIwhBRwSC3U8CbkKnU0yHCVOkLvcAIScJWeGm5fmG5VxVbQZKwi0Ee+uisgpQuQHdln0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlTXU-00D6GL-00; Sun, 19 Jul 2026 17:34:48 +0200
Date: Sun, 19 Jul 2026 17:34:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
	heiko@sntech.de, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net-next] net: phy: motorcomm: enable the reference clock
 for YT8531
Message-ID: <96f4db7b-70d7-49a1-a12e-7d7f22d59dd5@lunn.ch>
References: <20260719034555.3623003-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719034555.3623003-1-gahing@gahingwoo.com>

On Sun, Jul 19, 2026 at 03:45:55PM +1200, Jiaxing Hu wrote:
> The YT8531 needs a 25 MHz reference. On boards without a local crystal
> it is fed from the SoC, described as a clock on the PHY node. Get and
> enable it in probe so the PHY is clocked before its registers are
> accessed. The clock is optional, so crystal-clocked boards are
> unaffected.
> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
