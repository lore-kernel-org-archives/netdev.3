Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6100473C82;
	Tue,  4 Aug 2026 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867098; cv=none; b=Q2KwanJ2DOXRtLk2VFywEMTqdrXHknFQOtv9ZfshNjjh0y0H3EzroAkYteYcEUThRPdG3klrCd5v2qPaJIVYFrqIf9iCPzX1lX//GY0lbmL/C3jvqxDwY++YS3D9ZnJhME2bKvvmFPWfNC7gAvZK1UgakYbvQoLeUb4T3VWBNWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867098; c=relaxed/simple;
	bh=2l7VWC2zQ/8rW09nY+6O8/QJSkUFC5Mtg0ypYUlSTnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0x8vYqpsE3t54KkHz2oWRUXoAUeDVohN6wkk8RuGADC/tfzjqzHP+W0xrT5swrQQJCWpGaSQKJRhhHdA0Wp6u9Kp6yXBQl1PGTFlc9ivtjr4f94kUN++vqj8w0Uxt6PK7+Ba3ZE2FvtC7Ttwe6tPCqfoulvRTQyewswvEztAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wal0hsuV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wal0hsuV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NslrfSxDR9Zcwgcgcqz00P8rnhgZYqobMPxF/Sv42Jo=; b=wal0hsuVOpfztKjLsH7JZV9vr3
	vcEfrIGhQBhOFyRa6fvumQXuM/Aa8Rlg7BDKx13d1oGTnxvCbb3YW1SemOsyMjPjFmpV8OyCwVUGr
	AClwJfR130Q1GLfkkmAm67GITrQCDLNyPdlrevhYrirX10OCxVnKkakH/Bwcq9+3SsUs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrJbl-00G2FC-H7; Tue, 04 Aug 2026 20:11:21 +0200
Date: Tue, 4 Aug 2026 20:11:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ahmed Naseef <naseefkm@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Qingfang Deng <dqfext@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: phy: mediatek: fix TX blink masks using the RX
 bits
Message-ID: <ab2f7f4f-0f46-4c6e-b3b1-ea713dbd08c6@lunn.ch>
References: <20260804113511.3371248-1-naseefkm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804113511.3371248-1-naseefkm@gmail.com>

On Tue, Aug 04, 2026 at 03:35:11PM +0400, Ahmed Naseef wrote:
> MTK_GPHY_LED_TX_BLINK_SET and MTK_2P5GPHY_LED_TX_BLINK_SET are built
> from the RX blink bits instead of the TX ones, so both TX masks are
> identical to their RX counterparts. The TX bits they should be using,
> MTK_PHY_LED_BLINK_{10,100,1000,2500}TX, are otherwise only referenced
> by the per-speed branch of mtk_phy_led_hw_ctrl_set().
> 
> A TX trigger selected without a link trigger therefore programs the RX
> blink bits, and the LED blinks on received traffic. The masks are also
> used to decode the blink register in mtk_phy_led_hw_ctrl_get(), which
> as a result cannot tell the two triggers apart: an RX-only
> configuration reads back as RX and TX, and a TX-only configuration
> reads back as neither.
> 
> Fixes: 7f9c320c98db ("net: phy: mediatek: Move LED helper functions into mtk phy lib")

Was this bug introduced in this commit, or did this commit just move
the code around and it was broken before? The Fixes should go back to
where the bug was added, which could be earlier.

	Andrew
