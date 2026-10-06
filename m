Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE334A1DF3;
	Tue,  6 Oct 2026 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304313; cv=none; b=nQ92FK/j6KQRkMbDsNtox+iuNtrD1/fx65w4vdhrRtUFYxtcQWFCT3yKZNg9cLLo3D6pUT3g0rsDsosSrcRvZ/14EktwUUTo1KttITF38d2aKozqWwdIUxOUGxmlttvPCsn/pn7diIqtPLJA9+DC5OyMZuhBmhoHQpvtdLfcyHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304313; c=relaxed/simple;
	bh=lynKH9J1r+yLEq18u3SeYGVfPmGE2YqBxMHTxUGRN2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx7BeGe/kRiOi3+wLo7US2/oRThRhxZ5TB1gmjGqxkEVRnCGM/YxKeo2eUydth8fWpZsFy5xfIl+4qUtxhg+ZQBEmEYmJcmoyX8zrQ2puDa+MDsP02sZQkoq8pCXrpkR/B+Aj1jxXUEamWJudn0+7JLY0LBhE9wt3R7J6RWH4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L6t/cpFw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L6t/cpFw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B6T2ShZYF6QLE9lOD1rDDU/G79U+U5EjdXOIJBHeE2E=; b=L6t/cpFwZOrA0RajbFQgQrDkOI
	1svUCk2SuKgWi4r0me2/5fn1eC5bKe7W1i/35cXV4b21p9kSVKVYTRq1IWDNLQ7el4mWgJ9h7wwlF
	hq0PD6lkxEb7RiK+rXgbINDZAnmToaXUC52nqcRs2vsbmjMy8/n6rTzOD2L7JpyQZK1w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xE84q-009IZy-VG; Tue, 06 Oct 2026 18:31:40 +0200
Date: Tue, 6 Oct 2026 18:31:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/6] net: ftgmac100: Enable AST2700 RMII
 support
Message-ID: <268b6bc5-40a5-47b4-99a2-68d9f56b359a@lunn.ch>
References: <20261006-support_ast2700-v2-0-36de51fb8066@aspeedtech.com>
 <20261006-support_ast2700-v2-3-36de51fb8066@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-support_ast2700-v2-3-36de51fb8066@aspeedtech.com>

>  static void ftgmac100_start_hw(struct ftgmac100 *priv)
>  {
>  	u32 maccr = ioread32(priv->base + FTGMAC100_OFFSET_MACCR);
> +	struct phy_device *phydev = priv->netdev->phydev;

Is it safe to assume there is a phydev? The AI is better at this sort
of logic, but looking at ftgmac100_probe_dt() is think it is possible
to not have a phydev. And ftgmac100_phy_disconnect() does guard
against not having one.

	Andrew
