Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E66409293;
	Thu, 13 Aug 2026 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646712; cv=none; b=HxT20mU+BPoIcq5NyOkzgDtfjXqfV0VBOgf5XyyvOf4EYP4vF8gkD5A8e4cfWWDY00LkjKft9B2QmepuAp3KS7C3Mua3tW0Qw22R04JJJqck53Lj1v7ZDbTo0cnuAFPT+mKYPeV/2g96biOrjGvgD76gkTLsCiRr5pOVl4jt6yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646712; c=relaxed/simple;
	bh=QyTAeoLfLW1whwh11/phuC32/CsPkaZRqBcTGJh1X0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nnp1xJWmFbmatNjrZQVpSevYml1TbmPM8Jg2RY3hhIweypurcqCW7bmoENeDJEUIXubaaSEiqSLTv32FcxK41HdqyNT+G/eAOrK4gKjUHZPS/h90mgWTDY6g9Mfy6+O7O/LwO2ygSvHd+80PNB24PAzTYSfAJXM4jzws0To872M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R+b9PQ+R; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R+b9PQ+R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N2GHrWIwVqWBq+hKvbImLZxRE8BwGz+mCYcNqVa2Se4=; b=R+b9PQ+RfOxpPELtujldmuJkPY
	Op+Wes4+SKURYV79AvsSO5iiHnE9hUnpdf8vHTNIFY5ZD+L2vcL0hspIh3OxGwsxyVgNQ7uiBN5vr
	Z3BoSTMvvHJ5RNLJ+yRwQv2EbeppMp7bBvjb98kHtMUNMSOYOWchw5IERVovZEpf2EXQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wuaQ9-00HTmo-1A; Thu, 13 Aug 2026 20:44:53 +0200
Date: Thu, 13 Aug 2026 20:44:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: khendry@reliablecontrols.com
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: pcs: rzn1-miic: Fix config array initialization
Message-ID: <fe2e76b4-1be9-4324-ab6e-3a7af72c2fa2@lunn.ch>
References: <20260813-rzn1-miic-fix-array-v1-1-b58cafcc917e@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-rzn1-miic-fix-array-v1-1-b58cafcc917e@reliablecontrols.com>

On Thu, Aug 13, 2026 at 11:05:43AM -0700, Kyle Hendry via B4 Relay wrote:
> From: Kyle Hendry <khendry@reliablecontrols.com>
> 
> Fix memset parameters to initialize the entire DT value array
> 
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
