Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578908;
	b=1u+aZ/96RnJOK1jf79rezfe+YWfvDMjGv3GWeOwjMEElexkzz+uPBCVjPV4HY4nmZM+M
	 qZQcv4OLimXGkxiUInnu5v1wkDMy3MDHpQtLEx7pvM/fHl669RJ5NpLcvzTmGcwpqX/5R
	 uMve8ImS5z6zZGyObfYBSFvJGgMYQVLmCwwJ/PFTA7ykTLOu1oxbS5sU+YA0AcV6nAGOV
	 2ZW7ukSgTiyQeJps3uoYoHYxDkvFfX3QLz0xShgfmppcXLBmYshOzcCqwcDFetDeVxn01
	 Dk9xCr0FtEIUnr8dUOEq+cojFiTStdt7LzN+ItPm32iiyKd1ebJTLzp/tMNKgkVUd9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578908;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=WsrGw3edm9FzwMEE9G632XVGf6LNTuNlP557XSOGQsU=;
	b=LhKOmcmi1KIQE/ANE69VJ6YhnZUNyq839KNbbZQbPJ1eCcWehLXCqVDIOMxTRqyPbM08
	 yCQB32Z5cJmBz1CsQRMLKdQbkda0n46To4tgCDtpXaeH6ftV64RyjaLR23eWpGUGOzB70
	 r/e9cCOIC9aXqVSCx9/P5tb5D0d2DgrceLzhXnVLx07j40MGWeM0ULGB9krVugLQut/9z
	 483WGl4VQFvmsePo1vySCv39uLsOiMIV7ui9tGfbSAlWo9HWhqQpRw4vVYa7WMCf7quQM
	 RTCRSk2gqRbpsiKmz4b7UlhXS4vy/GGNmfUWd+W676bMSAUHodGaQoZmec8E1r2kw8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=v1KRo8ct;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D8B606A323;
	Fri, 13 Nov 2026 14:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80D8B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=v1KRo8ct
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WsrGw3edm9FzwMEE9G632XVGf6LNTuNlP557XSOGQsU=; b=v1KRo8ctYX8V68DybfaVBGInQB
	CAwiZBXVU6EzUsd1jj3OmGkx32696PURT0HnInRE5ZfPYpFtl0z1t/Dza3SLYw0hl935/NAJzDftN
	P8qyfok68We1jdiuyeUcXCtGp13dv7DeaStf+ixq2AhQgy5LVkObq9Jn4EOVqsOUMvgs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRrwo-00GHxb-VE; Fri, 13 Nov 2026 15:08:10 +0100
Date: Fri, 13 Nov 2026 15:08:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: joseph@telaak.dev
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] net: dsa: mxl-gsw1xx: reset the switch
 through reset-gpios
Message-ID: <a2f45802-b75b-4a19-9508-2d1b5ebe473a@lunn.ch>
References: <20261112-mxl-gsw1xx-reset-v3-0-863e82074893@telaak.dev>
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
In-Reply-To: <20261112-mxl-gsw1xx-reset-v3-0-863e82074893@telaak.dev>

> This is separate from commit 82e2c7db0830 ("net: dsa: mxl-gsw1xx: force
> internal PHYs into a known reset state"), which only programs the PHY
> bits of RST_REQ. On this board that commit is applied, and the PHYs still
> sit at the shifted addresses; only a hardware reset of the switch moves
> them back.

I don't think 82e2c7db0830 is relevant here. The commit message says
nothing about the address of the PHY.

How does the bootloader change the address? I assume there is a
register it writes?

Is there a comment about why it changes the address?

Does the driver have an implicit assumption about the addresses of the
PHYs? Should the driver actually be writing this register to put the
PHYs at the expected address?

	Andrew
