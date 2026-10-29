Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279456;
	b=waHpvWwHBTWtRwpRv5izGglhtWxEgAhRcJzS88zuGZUNlRmJADbSUUEvNJv0Qsh6fS6u
	 9maB3nVVGaDgoUGo8/LPGRmatE8l9Qg5ApBAigs3qzT34ZUV3ZSptzWTUoX+mOkidnWqK
	 3iZUzxcqNVVLjWjAjceK7Xi6eV7XU7bIQjqXNqobVP9puzRkUYqh9yEo8AV3D/TNMId+y
	 SG6aq71v1LjT5eoo/F0HuptnW7siJxO/oXdoIslEZ/LhxaS3DoUiQQDsubjT51y6OsGR8
	 r1OuszTL/OPrfVSvO1e4zzf4JsoKYSJ1QK6/FJgNd7O5i7LPb2LQkiMX+cUTYR7ZorA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279456;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=xEX+VUkqLlTdDV/lONb3Jp5n3X29i+nwYbi6eZJH5mk=;
	b=4IDQN4MKCH5/sFBPXnDpZO1Vr/Adzu/sA26TCbQR83Gilky0E+R8y6/BrK7wcvUQVj+y
	 Tnkr2PGDDoa/3u3fgLj+GhlQQWLAEWa9OwjxzwOWAR0dqtG3jZPpNAqodB+Iu7O7ZiJjN
	 xvOvVAOtqlnnaX2tn1mJL9vQgSCNa7Tgee7L+dsx8YVLVWGYhNZElf//Hk4bIIzCvjVJr
	 ilB+lS5MtrxekWfWxcoo3ufzmqhiTn2xor2zqsPFxtC/Tp8qgBkN3RRpypA3Vx14mvTsx
	 DLcbX9Gw6Z1zXMB/eucHNWs/hJ+oMCQrEXq2f806tAgTJegSzMaFHlIUZCQryd11Rtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=zvTybEo+;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C0606A321;
	Thu, 29 Oct 2026 13:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 545C0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=zvTybEo+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xEX+VUkqLlTdDV/lONb3Jp5n3X29i+nwYbi6eZJH5mk=; b=zvTybEo+UjTGt38a18tRwnzwB6
	DT+YhzzZZEIj0vutoFd5RI6qXLSpj8+uihrnXiC0eJ/NZ8zIYnMtTK/kDCVH4ucYGyfNmyILmQXdU
	lMCwewguiTZQ5TawgNEq3m5vAs+B0KKRhshzrxD12zSzxca2vV7Y/NhM7kChKW+ljhCs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xMPtn-00DFME-83; Thu, 29 Oct 2026 14:10:31 +0100
Date: Thu, 29 Oct 2026 14:10:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Coia Prant <coiaprant@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: pcs: xpcs: make supported_interfaces
 authoritative
Message-ID: <8cd7eb4a-84ba-487a-b1f2-226d6fa02af0@lunn.ch>
References: <20261029102728.3189359-2-coiaprant@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029102728.3189359-2-coiaprant@gmail.com>

> +	/*
> +	 * The RK3568 XPCS supports 1000BASE-X, SGMII and QSGMII.
> +	 */
> +	phy_interface_zero(xpcs->pcs.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_SGMII, xpcs->pcs.supported_interfaces);

The comment and the code does not really match. Why not set the other
two interface modes as well?

    Andrew
