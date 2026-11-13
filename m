Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578258;
	b=CnW9+2s08Vgs88xQ2AHAVK69RgF9hL5/qilpWHPV0oxCNdncPhDdYuZeL1VNXLQPc1hQ
	 LcHfQu8cElbEt5kZn4QxckrAMAtkKKNk4Wxsvb8V8uZsdc55/U4632LsxB8I9dsKGlWyL
	 KN7R1AUNM+ImGmGzXjdqrhm9Wk80p4ou1Id+A3gV1BkA/hMOY8Rm/21PFMRVUtcXkbWYm
	 AAXbExyfvWItKg92m6Aj+aI1cfFxb1XhXyUnsDcQbIkeG72kmMlN0qmi+U9jaY3zYd9si
	 peSXLWt/R7It2TJFV5Qkf39tlG7L9hGirg4VrB4ZTjYhliOE0YpcAq4zog4wuMtmsWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578258;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=vBg4f1DJKHnsKi59e06aAlsOugxRaVJjQ+BOGPHs0Qk=;
	b=SA37gnBcb0e2StqoBGnP4OcJLXW48veI2ZxhbEcL2cKKfyZ6Z4u4Du3L4b/Hgrftkude
	 DerCqexZFsmLZCElUhvCOglyW6WJgTb3ug2lh/xZE+b70mVCTFPdoMdTZPyBfom0nPPAt
	 4lXWpB+Bc9yvaMIeP3fCZA2KibiAnDNXng5XCpCzZoAEKqR2i90TCeG9+C77HtcM854U4
	 3dTmvpeERJArRoZ2Ddn5px9EPtYgRHm/Q+Mkn8TtkJCIotbGej58uP+vEV1KpXS2LjjkC
	 8ryVw0pWvcFYuc5dF/MKvZCBBiQxvgwx9o18hISxz3jzQu6nYnKNFbTcUYBsvrFhGOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=bzE4fmmw;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB4606A33F;
	Fri, 13 Nov 2026 13:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCAB4606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=bzE4fmmw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vBg4f1DJKHnsKi59e06aAlsOugxRaVJjQ+BOGPHs0Qk=; b=bzE4fmmw8f9bClVK3eXmlCIgt9
	bwR5k1Ty6+FT45AEFW3yungPTyFv1Xg3Z/0fupNKBwPGKd5gc1ItYUdFfmnSN4yaDa0kbTycV6Oz1
	WxzY5ItZ2IwwUynvNQVJ5qiwv1IeLdda2I6x8/AhVKgyVsomgSgEULaGjarvRoJgYCWM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRrmV-00GHru-HS; Fri, 13 Nov 2026 14:57:31 +0100
Date: Fri, 13 Nov 2026 14:57:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: fix trivial whitespace/format
 issue
Message-ID: <4023160b-835d-4290-9f15-84b1dc257f14@lunn.ch>
References: <20261112131358.106442-1-ansuelsmth@gmail.com>
 <20261112131358.106442-2-ansuelsmth@gmail.com>
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
In-Reply-To: <20261112131358.106442-2-ansuelsmth@gmail.com>

On Thu, Nov 12, 2026 at 02:13:57PM +0100, Christian Marangi wrote:
> Running checkpatch on phylink code, points out some trivial issue with
> whitespace instead of tab, if-else condition with a return in the if
> condition and manually printing the function name instead of using
> __func__.
> 
> Fix all of these trivial issue to mute checkpatch warning.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
