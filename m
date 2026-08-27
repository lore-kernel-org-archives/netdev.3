Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BBA331ED1;
	Thu, 27 Aug 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853866; cv=none; b=W/8tS2T4Fkhp2mwKmNoCTcTKuTeGSyYweeU5kLAqYMKbFZ0bWf2DfrpcPKTqPnvmULz6SZgGC0mCGcRihbbPvHnIOr1N37mhcLhgE55/PtiXzTaexBiDkcZ6lrY7b7BQ4bbJolENoQpetNtfM8LjAw/CgT33iimhUPzD/6DTDms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853866; c=relaxed/simple;
	bh=CGPVcLBdSgQDUKlMy4bBsZXWiyEOynDpRTPTRImEBeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8t95g/S6sMb0BKXsK7be6/9tEOyoAtw6bk0qQ77ZfDRLKzhRykfbTG1gj1i8jDcRkNaGUNd4QuHg0fMQc5TsN4vlFrrdUszzyleg4aODl+dNgl2Q6Ey/whGDGmCh9t6NBmhlzGcTwNHanSBTVpb1yJYaa7RzFsPveHPeWdCmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yr4n/WYO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yr4n/WYO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FMyoddCK5sJI0ngRSe0ctjtLlFTvLzofZ1I+hkT/Nds=; b=Yr4n/WYOTgJmAR6OBdCnQ4UX6K
	DstbjuDjJpxlqWmFbqWioX/5h5Wp97TRy4mDhwg6OyDK0CCa/NpP3odXG/wS/yl+b85zGUBC3rl8J
	faCA3NdOK8iBtGMnbfNW557tdNQIf+u8rR6rmI6ICyfojTiIoDcIsN+kQJmCe1JfFQjQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzeSW-001hii-Tv; Thu, 27 Aug 2026 20:04:16 +0200
Date: Thu, 27 Aug 2026 20:04:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: phylink: unwind the PHY binding
 when bringup fails late
Message-ID: <006ad9d6-b51b-46ed-8c5d-3649b70a4f62@lunn.ch>
References: <20260824024029.41310-1-f@lex.la>
 <20260824024029.41310-2-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824024029.41310-2-f@lex.la>

On Mon, Aug 24, 2026 at 05:40:27AM +0300, Aleksei Sviridkin wrote:
> phylink_bringup_phy() records the PHY in pl->phydev before its last
> fallible step: on a MAC whose phylink ops implement LPI,
> phy_eee_rx_clock_stop() can fail with a real MDIO error. The callers
> unwind with phy_detach(), which knows nothing about pl->phydev, so a
> pointer to a PHY that is no longer attached outlives the failed
> connect.
> 
> What that costs depends on how the caller got here.
> phylink_connect_phy() and the SFP path go through
> phylink_attach_phy(), which refuses to attach while pl->phydev is set
> and turns a transient MDIO error into a permanent -EBUSY.
> phylink_fwnode_phy_connect() has no such check, so a later connect
> overwrites the stale pointer and hides the problem. A disconnect does
> not: phylink_disconnect_phy() hands that pointer to phy_disconnect(),
> and the second phy_detach() on the same PHY drops references the first
> one already released.
> 
> Clear the binding on the failure path. This is the same operation
> phylink_disconnect_phy() performs, so both now share a helper. The
> PHY-side fields are left to phy_detach(), which every caller already
> runs on this path.
> 
> Fixes: 03abf2a7c654 ("net: phylink: add EEE management")
> Signed-off-by: Aleksei Sviridkin <f@lex.la>

This should be for net, not net-next.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
