Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2863E5EDB;
	Tue,  6 Oct 2026 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791319523; cv=none; b=pT7cLKJ2uFHr5IFgWdECfcdix0IBdXeYjR5Z0TwreSVG9pqL55TrgzXLDwutYyZJ1Cq6KQqJQdB8rk+ae4ecJkoBA6pnldLI8jhDbM1p23gUPpWP3wjQpr7xRjlI5iZdMoG4U/gF016naOG+gtj/Ih3pE6LDg/0oUOv20crRbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791319523; c=relaxed/simple;
	bh=ATTTyP+88KjceGR5QEQPws/hPLP7MJ6ZWEzi1w+P0e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUDLfnIAPo8wSVLVTO8hE0iBYc7xQti48nwvA48SvmQxfM83HM1uUWhfi92E6HQl+IiyY+nSdHXGm60C+jS9OAk2M92oqvwOL5+h/cRaM7jAMVOT9G7WNdEtxkrdwQy3MY+t6e3fOJU7NOQ0GO6oR3hNZROzgZe70M9aOVQbJcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gcNCk6Pl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gcNCk6Pl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4SfT0hIOP6oHUcuxOuqxpmJe0Evkh9k6/ySYUDHxEew=; b=gcNCk6Pl7m6QXgbpzy+2vBcG+f
	zYl/m1aQlCtQN4ULUjgX156TYvB7YF/NJ4fGLO286fnJUr3s6khPzNdQ5/mXU/HhQI2jli61582Zm
	c3AQ9XK7CPpSa8TrUalorRf2SdD2T38sBm75WjatHleEvhcl4lo5L96nNjdfgR4Tbg88=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEC28-009KlI-Ep; Tue, 06 Oct 2026 22:45:08 +0200
Date: Tue, 6 Oct 2026 22:45:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: phy: motorcomm: Add driver entry
 for internal YT861x PHYs
Message-ID: <f7410366-c457-4916-8c0b-6e071ec7ff0f@lunn.ch>
References: <20261006202352.1616626-1-mmyangfl@gmail.com>
 <20261006202352.1616626-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006202352.1616626-2-mmyangfl@gmail.com>

On Wed, Oct 07, 2026 at 04:23:47AM +0800, David Yang wrote:
> The YT921x switches integrate GbE PHYs of the YT861x family on the
> switch-internal MDIO bus exposed by the yt921x DSA driver. Without a
> specific driver they bind to the generic PHY driver. Add a driver entry
> for them.
> 
> The PHY ID 0x01e04281 is live captured from the switch-internal MDIO
> bus. The switch SerDes PCS does follow the pattern, 0x4f51e899, though.
> 
> Auto sleep can be disabled with the "motorcomm,auto-sleep-disabled"
> device property, as with the other Motorcomm PHYs.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
