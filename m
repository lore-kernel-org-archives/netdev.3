Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4D25A321;
	Sun,  9 Aug 2026 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786313984; cv=none; b=BqqbFGG5mn91Evr+z88AV+mel6NGVYi7HkI5VtVper5VvjBSVdkoR/HET4YCpVXxdWGBqGTbVVxbPtrkipbgibDAFdBVo3j1feNmskSreQ5b++5EUwZR8wNk8WqFx6jilV8aitOFdivWoI9SJf1rk2QD8fR3MVwca1j7DcL7eow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786313984; c=relaxed/simple;
	bh=WWqlWAmh+xpxnUrOfAqoaE6jcfkAQLmTosZ0ur97Z8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMaly4r9LaTeKtjabzW6jlvSd4Dxd/e4usR5nM6F1MbMw/Z0IqP+sVAwb093gKaJGO93wCkurCCcsiD5U8dA0T2yI3LY3cAE6AxkR4wEUySjKFqp0CnPFWnzoaLduVd20JWZUdatMiB0YJ/69OyzEC5hl749CClY9jhAa2m1De8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=29pQ2i0v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="29pQ2i0v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IEtVJuENv3ZV/PvSU5+TeyzV/e5y+pAttWd1L+984pU=; b=29pQ2i0vvtIe9MVaD0x9I1UXvw
	QQ9EM3LXJ8WoEGDjDR8MzzvGsvv+sW2PokUVKO+i3hjgyHVw9bYAW8G2anDmj4x7ivWWOnKfDDQHW
	wvImoKJDB02M9NEW9uAD0rnMsLfpFCyomQVPwXq4jm+8BZyANMwv24U7cGvKF5JC0wgw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtBrg-00GrP5-F0; Mon, 10 Aug 2026 00:19:32 +0200
Date: Mon, 10 Aug 2026 00:19:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v13 11/11] net: mdio: realtek-rtl9300: reword
 Kconfig and module description
Message-ID: <682377d0-09d9-41b7-8d38-eb26bfeb1a56@lunn.ch>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de>
 <20260807171058.522833-12-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807171058.522833-12-markus.stockhausen@gmx.de>

On Fri, Aug 07, 2026 at 07:10:58PM +0200, Markus Stockhausen wrote:
> The Realtek MDIO driver has been enhanced to support multiple
> devices from the RTL83xx/RTL93xx series. Reword Kconfig and
> module description accordingly.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
