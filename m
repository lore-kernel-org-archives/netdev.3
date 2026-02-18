Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ABE306D3D;
	Wed, 18 Feb 2026 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771433636; cv=none; b=lUobx+rQIVjIBkDF8xTPlmTdnSIVOf1u9Ah7kjzlhSQy1uOhfMZCddwPZNaFs0T2P/3KAg6hNb/rgnehp6fxWneNRjK/KYUBVUlcPG2bmoXALjlSZ++b97TKXEJaHwLiEH+NTvQLk+GG6nLBo767n5CK6licHzR2FkVrTxAZu1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771433636; c=relaxed/simple;
	bh=ezJGl5AppxBxudp1Fvfq/WN8g1f/nh9JiKYOwVbmLMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K80MBvqn6oHyoRfHoy1wb+85CEJOD5mPg5/zc9mkbl2I2mVsfHhSqMiPu8ZzRIvZGgunjYS49JZ45MvvKb6wMvh/0aCwOvKbS3Hbv1rkRAzjsUDh+TMONRkSHhr4qPxUM55b81EYUPDp7DqYSkshYnK5nnc/wNzwuKN9aLPZhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oCj7C1S8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oCj7C1S8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wEUH7PMEoSRaXj1Vunp6d10yQXzGqp9cKc7mzpp+Mp4=; b=oCj7C1S8utVpI5i860g1CWGEm8
	u/e422/tk6VYGHYFDlYJ5MhFRT4IW2KJXHrrUxCS6n6gbXrNqTKsTblN9EI9xtDGmzWpL3F33WEj2
	FpQvKJU3BqwXlsaiabhsvIjGJmJIohGpaDIcaaclf3VV23gNfFEAI8DovHZHW80P1Z/Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vsko1-007n30-Hx; Wed, 18 Feb 2026 17:53:41 +0100
Date: Wed, 18 Feb 2026 17:53:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: dsa: sja1105: protect link replay helpers
 against NULL phylink instance
Message-ID: <698d5342-c4c5-4979-b7bd-c610eaae6575@lunn.ch>
References: <20260218160551.194782-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218160551.194782-1-vladimir.oltean@nxp.com>

> Fixes: 0b2edc531e0b ("net: dsa: sja1105: let phylink help with the replay of link callbacks")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

For the code change:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

I will leave open the discussion about the commit message.

    Andrew
