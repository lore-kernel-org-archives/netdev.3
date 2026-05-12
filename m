Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B983911BB;
	Tue, 12 May 2026 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589969; cv=none; b=irKvjiWbNHSrOUJ770ciA0i3b+hqOOHQZDHx/YpmBVwRd+FHv51cbj+mbCbSQzV1bszb+afII7PMTedYekDj8r21fkl24H4EQklEV9IQq6aoPj/39KBQsvBV32rI0JMhpTax2lU2+Bav9r/MgKjXgybhBNfahqz69xpAyv7092s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589969; c=relaxed/simple;
	bh=BhjdQ4h48TWzkfTIsl8ByQ3qXTThf6k7q21oSePuRAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHIy6uSGUmE+x8q0zkv2RwS2lpt1JWH4E1RC70lbhtg9b0x6iq7QARIWfF59XyanbErZGSc4YKhwt3QV/UHaWpCH1ZZNbFQkU7nk70y+xle9TWYNBg7YfL+6KLnyzPAnbHx2t8Xqj6IgYwUcTO3xidPOwhadY/8jdlBbgjK3nHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N7wG6Ip5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N7wG6Ip5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Aor+j30AXKQpRlz90c/Iubq9sr2W4SUorqjCI2Ip5pk=; b=N7wG6Ip5OPGf2SpCkt4mIY0wd3
	0vTAe9Pu2Mr5azVg+UHgb2oxIEc9lzXHyvuJZQLMuFwgWfoTX5TZhz37M95RG/IfK9SVbOLelbhQl
	nFrpUsC3BBTihBFJBIeP1WF2Gk774ysqITFJQtugBoxJuuD4bofJ0EtdWZhHIzPrm/tA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMmUj-002Xvj-PF; Tue, 12 May 2026 14:45:53 +0200
Date: Tue, 12 May 2026 14:45:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, kevin-kw.huang@airoha.com,
	macpaul.lin@mediatek.com, matthias.bgg@gmail.com,
	kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/6] net: phy: Rename Airoha common BuckPBus
 register accessors
Message-ID: <804a1ec8-d009-45c2-b08f-a42611f8e5fd@lunn.ch>
References: <20260512-add-airoha-an8801-support-v3-0-1edb34e363ae@collabora.com>
 <20260512-add-airoha-an8801-support-v3-4-1edb34e363ae@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-add-airoha-an8801-support-v3-4-1edb34e363ae@collabora.com>

On Tue, May 12, 2026 at 06:33:21AM +0200, Louis-Alexis Eyraud wrote:
> Rename the BuckPBus register accessors functions present in air_phy_lib
> and their calls in air_en8811h driver, so all exported functions start
> with the same prefix.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
