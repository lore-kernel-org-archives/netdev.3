Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF02446845;
	Tue, 11 Aug 2026 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456855; cv=none; b=IdxY5wio8/BJj6Z4hDXQH8rO1AP1GByB6K7PjJCmua4mhTNxjtW9TLoOFtinLiEvS85V3U4M7NS4XoQ5YgjPzXHaN9sN8a9Py/PxJN9YlkGZ7m/kSgi5fZrnvOa/113aNNRmyDjgTSaAnvlAWsIN3YfJvFkgTFo58DIig/YjrZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456855; c=relaxed/simple;
	bh=idtaSrZWpmB+b9o5Kz3JOpm+3XXo2BmjptG6NNKytyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcaklK7EeBNUr3YlajO5GqjBDzo9AKKF1Jk5mVtuDzWsy/2bKwYc1vlEP3vmtRJXK59/cl+LK7XvmHer8rZdHjHqLM27cRIhQLD6YCKuzbmdipmFRTvVF0o6thZzTdBbMPZDFey1401KpNh+VkTorMeC1wZjE09Y9z0nwKaxMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H2TmSP0E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H2TmSP0E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mUmyIQbRCPKT8jWk090I7pGzIqwkHGmRsIxVhiD6wnc=; b=H2TmSP0EjPaPtAKiMYkl36hbwl
	cslsffN9q5kcq70FHv21eBB77njYgCN+EOTowKtpAIqozYAXfIl+4bYmUR3X0uSzNDLQJ/peqd4Wm
	pH0gnvdZpv8KuH8cvihO49yVnC7jHKNJwRdBVmp1mKIB9EXEDm1gDewkojqfbZ3YzJbM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtn21-00H6LY-RM; Tue, 11 Aug 2026 16:00:41 +0200
Date: Tue, 11 Aug 2026 16:00:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sandeep Sondagar <sandeepsondagar@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Gabor Juhos <j4g8y7@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: phylink: treat PSGMII as an inband capable
 interface
Message-ID: <a687331e-d077-48e0-9ae8-097c4f80dca9@lunn.ch>
References: <20260809-phylink-psgmii-v3-1-908dcd3a9e3d@gmail.com>
 <61dd4a2e-ef14-46b6-bfc5-c5b6463deb38@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61dd4a2e-ef14-46b6-bfc5-c5b6463deb38@redhat.com>

> > Fixes: 83b5f0253b1e ("net: phy: Introduce PSGMII PHY interface mode")
> > Signed-off-by: Sandeep Sondagar <sandeepsondagar@gmail.com>
> Sashiko noted no in-tree driver is affected. At very least, this should
> go via the net-next tree without any fixes tag, but I'm wondering if we
> want it at all?

I thought there was a device which needs this. Sandeep? Is it in tree?

I would accept it, but the question is net-next or net.

  Andrew

