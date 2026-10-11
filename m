Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBD744E66A;
	Sun, 11 Oct 2026 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791725405; cv=none; b=kGVC/NVifyyPHvaA2u43RcjzqVeMzL8HZZWFpo/Igkxkgt4MK28S4YD4mVgksleJycD7LKSc7T5ccz2YZPKVhYx+WApEhiER+ttca8JlymTo/rmqO4W/yfFFXnskEo9PkjGazHyBSFwHta04eki0HwCy/x0dmiX82yWdn3bGggQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791725405; c=relaxed/simple;
	bh=HKd0ACWvGmKqMqUoCSBpThnhJKI2tt9TG5MjiGlsX3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgRJ6XjOo5inhP/+3eQdahXesniCuicTGW3qyxNZn/YaVbOyqqs5u2fv5EkrrHSruXWt9u07p5FqSk0Hykff3aIQiSI+i+yG1sEGaAerYsqkUTc8EIsVtRxEjkZNHaKAqTO+m2Waom/7RXgg8YNjW2pQqcULY1G22c8Qe/XA6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hr4hWWkQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hr4hWWkQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YuBf7zzPwXxfSbYtDT7fF3omaynctIz2OFGOV/bNjvo=; b=hr4hWWkQybx0/UeLMncYWYFKPC
	VBMwvkYa0kgpXeQUAV7w/bd0GIsEqzyMtpevuxsZZSwkpHeThoW5bEjIKzssUscutsaBv4NkIgu+e
	7hTj4wJ5p+yNHIBBu127rHwggkJxY4C45wvgyArZky08BhHNcJWUnqm7tepuibJu17EU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xFtcQ-00A6HZ-AO; Sun, 11 Oct 2026 15:29:38 +0200
Date: Sun, 11 Oct 2026 15:29:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Josef Schlehofer <pepe.schlehofer@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for TP-LINK SM410U
Message-ID: <6b07eaee-beae-42c4-9da8-3c11e9163fd2@lunn.ch>
References: <172a4fed74d35b1be51f4e8aba2222aa33845b08.1791679663.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172a4fed74d35b1be51f4e8aba2222aa33845b08.1791679663.git.daniel@makrotopia.org>

On Sun, Oct 11, 2026 at 01:51:14AM +0100, Daniel Golle wrote:
> The TP-LINK SM410U is a 2.5G copper module which is based on RealTek
> RTL8221B, but doesn't seem to offer any way to access the PHY over I2C.
> Add a quirk to disable in-band which isn't supported by the PHY.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
