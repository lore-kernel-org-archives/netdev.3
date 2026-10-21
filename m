Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585161;
	b=nJIDCjIxCT43uct7u9njRDBldRZmZ6Qmts6y4xvJe6ttYHfC2XBjL4ycvGhvg5S3avOi
	 sbDHipf9nfJ+LXfm/UT2I5tqwoE8NsfxizbZM2Iz6PTFL4GLPwpnKJOxE+yXXZgiyz9AL
	 V6wxkuE1FsBdI/pVYNn4ND9dBPwULrFREKcUXbyEFUMNlx2/LLw2tp0oMjmWKzPXxXaEF
	 tYgeiJY42U2ntXpJqf206ZMpf+qNHizECAYngysgXLJCUxshcM9Fr95tkRQCucoExroDF
	 EpwOq1QncxCP3gTelSvzKRjEF3Y19j5H2dWWZ/kQ5ruNLSYK+d+HojH7jyLaWwqGXTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585161;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=AMHcS9Ye7mJ4VtQa8j3eoiUCpuDp1FJCCfYruVi3NE4=;
	b=b74PIRk6uM4CDoUexOrY3D6ypx0Iv0x1VdAjSCu+8RohFmzOac7spQc+rF7aYjeMrWJt
	 Jwtp5UYKL0YIgIE6v3KlkHHP+iUmIwqSswmjqar83pg3Al4npwuOkTL1ArLLg2O8TKBEo
	 o3cYi+OUOYO1GmWgWGc5wtVG8FkDr0dAnhgzlAJQl3SDDoqKww1h5hKi+AMlYtdkF/eOw
	 DXpsDZZE8aSzn4c7U1APg5aMbeQlQisj29aVqKb22aw8DoQVot4/KzcE5WySxEOx7M5jB
	 BaTJJhb6StxQXk6S+e/3UFc+lg/CQ/nWroO0TB5qaLj35AobjmCq+Ylis3xgDVvVUKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=4XDsezLS;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE272606A31E;
	Wed, 21 Oct 2026 12:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE272606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=4XDsezLS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AMHcS9Ye7mJ4VtQa8j3eoiUCpuDp1FJCCfYruVi3NE4=; b=4XDsezLSrHNAlSFojIShKXMs7k
	OHevL229eR+vIGZtluUMY0+oDP7ibpcH70dMXsjrW28uwH7/OQ1GVWrCeY9OPkJweaHu5n5GkswdR
	HDgekvY5ovSUM/KuFZvt4y0yXMv/Q4iRfHKHhxQBKEMr4IgZzRyiGH1wokQtRul2B/pg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJVHg-00C4yl-PR; Wed, 21 Oct 2026 14:19:08 +0200
Date: Wed, 21 Oct 2026 14:19:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pufan Jin <cyan2254650260@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: phy: realtek: Add support for JLSemi
 JL2101 and JL2121 PHYs
Message-ID: <d4517460-7598-4c87-8540-3abd6f6339b3@lunn.ch>
References: <20261021042029.44853-1-cyan2254650260@gmail.com>
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
In-Reply-To: <20261021042029.44853-1-cyan2254650260@gmail.com>

> - Drop standalone driver drivers/net/phy/jlsemi.c and extend the Realtek
>   PHY driver directly as suggested by Andrew Lunn.

> +#define JLSEMI_JL2101_PHYID			0x937c4032
> +#define JLSEMI_JL2121_PHYID			0x937c4030

> +	}, {
> +		PHY_ID_MATCH_EXACT(JLSEMI_JL2101_PHYID),
> +		.name		= "JLSemi JL2101 Gigabit Ethernet",

...

> +	}, {
> +		PHY_ID_MATCH_MODEL(JLSEMI_JL2121_PHYID),
> +		.name		= "JLSemi JL2121 Gigabit Ethernet",

Do you have any documentation about these IDs? Why do you think one
should be an exact match, and the other a model match? The fact the
2102 is within the 2121 range makes this look odd to me. So it would
be good to have some explanation.

       Andrew
