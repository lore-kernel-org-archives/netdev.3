Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C6C53E318;
	Tue, 22 Sep 2026 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078837; cv=none; b=BbfW7Yvio4SfbyBV50VLYIbKecJdu+NiVXBVODWsrSKYLBQMWnRg7BdXkspC8Eh7QwWLZqXupVmYux6MEppdamlsDKuTLoGJqgKGTJRiSV1A4VRPuKRrpcCNj1c24Nc3rKNsCpSz2Uc6AclwAJAL+fgcIli/3xMg3+oiDdLsE08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078837; c=relaxed/simple;
	bh=XugyeEcMHXfNkN+QRx8zCx1QW0GF1RUvwF2cj71zs4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RONl+TlOncKmzK+644NdirZsqnT2riEvC3xQJ0JjM9mVawZT39WBxNTpcsZRrIF8APirZso5qaW56Zn021iAeFFkrnZbga3T2aTgy//jCDnY9UpbHa55pEyxdEwRRl4szRD3fMLvYkxKGg8xW8+RhrtJk8wkFgbBHscH1J5mdbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u/hL/g6T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u/hL/g6T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cyw7bhUZUJ2EvAmvLNl/3FKnZggWM+baPq7PsFCB+48=; b=u/hL/g6T9kiYFfb2FWKP/M+j03
	lBFkh5yKOu8m8v8YCh4+x2HaHspstUE3xq5pXjtL7anA+gfVfKGwhtH+jn4jYUzV6rdd4aV9kPsfa
	UnGSg0UJcB1jozZ093DAllKtYEyjn2px4IIvqwA9UBGX4t/wYTprgQntu3nN7sc5yxZU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8zH1-006a2J-Ue; Tue, 22 Sep 2026 14:06:59 +0200
Date: Tue, 22 Sep 2026 14:06:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jan Hoffmann <jan@3e8.eu>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for XikeStor SKT-2.5G-100M
Message-ID: <b4a42595-295e-456b-82a0-91076f72407d@lunn.ch>
References: <20260920192632.72729-2-jan@3e8.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920192632.72729-2-jan@3e8.eu>

> Note: The RTL8221B PHY in this module becomes stuck in a broken state
> after attempting to read some registers on MMD 30 while it has already
> established a link (this is a general issue with this PHY which happens
> when it is configured for rate adaptation mode).

This sounds like something which should be fixed in the PHY
driver. Can you take a look at that. Is there an errata for it with a
suggested workaround?

> Signed-off-by: Jan Hoffmann <jan@3e8.eu>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
