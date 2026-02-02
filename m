Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423E1B652;
	Mon,  2 Feb 2026 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068553; cv=none; b=TIyteectoaNA4OIZNZqPXl+xD5Rv+JiEpqzWvoBMWCER+S561RUK97pxYvAO+rE1Np+GeIeJZ/lijgRk4p/J2oSadExqHvfShgtDxFfRPyH3I/ST/RszIhqEcefV8SbYOk3TkdLAYkKUh5Hv7NEON90k9V50LpsXBOpgAyQs14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068553; c=relaxed/simple;
	bh=1cW6nJgiUn0o8YqkJhl2rjDJez9Oaccdb6OY1wHDHrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAKhIqjlGigh79bhVws1PuHXhuwJj1FB1aSG5qUOyQkcoiZyLKDBo6Y8OWjozfUXrkUvrmtdfuNTi+fy9XqENVqix0Z5LCtnPBjNS707rCzIQnp4mdHQWCnZdHirKQ5CLk7vS9Ab49ednKrLX6lE22RkQxnAD7C5zvoeCV4SpAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fN8D7Pog; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fN8D7Pog"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eBev5ACnfMzQ/DawAIzsOOKf2WXvK8lcKRpFBPZBjms=; b=fN8D7PogomgQoY+8u5ruHjk3fR
	KmoVrJc+XdNrK8nUiM63FEcHyU3Rgf1JKQbPKTMa7h3xTKiV18PGlTw2bU+mFYVPxFEyclcw4S6xO
	CjbF1JI+g4kenxvv8hP/teKbtIt25RDiHcNWK6N7tavAHdajhAXuknZqH3lF7HXEUEO8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vn1gU-005sEP-Dj; Mon, 02 Feb 2026 22:42:14 +0100
Date: Mon, 2 Feb 2026 22:42:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>, loongarch@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Hongliang Wang <wanghongliang@loongson.cn>
Subject: Re: [PATCH net-next] net: stmmac: dwmac-loongson: Set clk_csr_i to
 100-150MHz
Message-ID: <4d1abb0c-e518-4751-b462-345ed76bb3f1@lunn.ch>
References: <20260201023700.366531-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201023700.366531-1-chenhuacai@loongson.cn>

On Sun, Feb 01, 2026 at 10:37:00AM +0800, Huacai Chen wrote:
> Current clk_csr_i setting of Loongson STMMAC (including LS7A1000/2000
> and LS2K1000/2000/3000) are copy & paste from other drivers. In fact,
> Loongson STMMAC use 125MHz clocks and need 62 freq division to within
> 2.5MHz, meeting most PHY MDC requirement. So fix by setting clk_csr_i
> to 100-150MHz.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Fixes tag?

Does the error mean that MDC is ticking at 9.7Mhz? That is pretty fast
for PHYs. But i assume it must work for some boards.

Separate to this fix, you might be interested in:

  clock-frequency:
    description:
      Desired MDIO bus clock frequency in Hz. Values greater than IEEE 802.3
      defined 2.5MHz should only be used when all devices on the bus support
      the given clock speed.

So you could allow faster MDC values using this property.

    Andrew

---
pw-bot: cr
