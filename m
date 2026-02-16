Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF40E3B1BD;
	Mon, 16 Feb 2026 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771207091; cv=none; b=Mc49ZeA8mKCa3wAGJK7223hfjYGKOx7+VJMbLjyoY3ZtL79t4rKm1Nf1cbBdwdXJhETsTTQ3OiOZiSGoiB04b/gPEgSqNYxx6ownZR3e4j//4oThNNqZhTHxpNGJlDX0ucoAFZZ5tRMKXOuk1s9xnOSS4JAiqTGpwFrbuesVu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771207091; c=relaxed/simple;
	bh=xLYjo0R5nKI1doM2qtYzktPaC4eWOHCI4hd9jZ3RF4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv50kkHqTutKNSyjt2MVd6XvsmU4WXcCyqFgBaMnwYfMEhveww1/aoFIzT91QkwmAnxm0pO/iOeNQC2bgsyOUDHWYq3YTMEMgDXogjub5KEA4A0DtBSvSzAOpla8XAIsc9/fBtl46x7Tzx7J5izhl/m0r00cvGNUKMfJhwFOIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nfIHjmae; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nfIHjmae"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uc89jBtcLlFdS6/M6+W3LFai5QtY7x4yNmHjHJ8jUSk=; b=nfIHjmaeZZaFa/nCmijVPvJMJZ
	X8JLzv0KLKsk05aHsVvLYYg2df7DL5rQViVc1/Uok4zGVJAUikXJaP8iwOjaOfkxHAcOzS62Xr7/a
	4x5rH4LK+GMIH9jxFfA1WU8H8HMTzCpzemZmI3K/lqqzGy1i30trWM8U3InvwBfi0RS0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vrnrw-007RYn-Tn; Mon, 16 Feb 2026 02:57:48 +0100
Date: Mon, 16 Feb 2026 02:57:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Yao Zi <me@ziyao.cc>, Heiko Stuebner <heiko@sntech.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: Problematic understanding of phy-mode in Rockchip DWMAC driver
Message-ID: <a4aebacc-c273-4e42-97ff-0cdd88d771dd@lunn.ch>
References: <aY9s5PXP4zZ7R6fa@pie>
 <aY9xsslT56D9LGLe@shell.armlinux.org.uk>
 <f1e047e1-3f1c-4562-ab43-af2fe358fe04@lunn.ch>
 <aZDGsJNLZIty0242@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZDGsJNLZIty0242@shell.armlinux.org.uk>

On Sat, Feb 14, 2026 at 07:02:08PM +0000, Russell King (Oracle) wrote:
> On Sat, Feb 14, 2026 at 05:50:15PM +0100, Andrew Lunn wrote:
> > Rockchip have recently started adding support for a new version, and
> > appear to of listened to what we have been saying. So it could be the
> > next generation of chips get this correct.
> 
> Have you seen any proposed code from Rockchip for their new scheme?

There was a patch, including a rather odd formulae to convert register
value to delay. I gave some feedback, but it has been silence
afterwards.

	Andrew
