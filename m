Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC1641B8CC;
	Mon, 31 Aug 2026 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186760; cv=none; b=N6bcecETlqMHqQr/7NAQ5a+Ng6/q819xRi8jrsXES5V1j/2QnoDwFxP4JdXFL6LLYRlnMEEFbUie6CM9oXZ73jg7yz1PSk6mq4jTsr4k5AMXcLKMKdGedBE3EbX1xW/71nqxOPSMoCP+pa6a295y9cyCyM1m2vsGYibWz5qxYys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186760; c=relaxed/simple;
	bh=EyEgCzuxeJQC3nLUACqDsYEgC9pfzOG3fIzRvn1TRmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M13Q/gwbkJPSXBnghRBcYw1M+RPPLTC6PKImaI+ZXi3HDRz5bD+EESAQRIYSMALdeUl+UgE3Kz9oVttNZqH9o54K1j6P7HhSUhNRWKvq0QqwUjW+72pw1+ROsuI3hCb/95LxlQfYq/q8HwILa9eXnjdf1jdKnUdbrP0XTTqpo8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hlsqDf7M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hlsqDf7M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VTGirr9jlAj9jGAixqMmWdmq+Us0PYSlDcy8/h2zW8Q=; b=hlsqDf7Mvp823e/YE0+2Q5BwgL
	TlwPv7NTuO+hmur0/SjfVynnipMBlF8TgYfg9YqjnKjA8ReflYPQe7sC+zZxcZzHYZnHBk2Ld4gQd
	Ze6i5yYWDhY4W/7FkX7FaqnBupof+t5h57YJsQ9zBnxN2OhTe/zrWIg9Ca0MtVeyuHbg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x133m-002CFV-7j; Mon, 31 Aug 2026 16:32:30 +0200
Date: Mon, 31 Aug 2026 16:32:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v8 11/15] ax88179_178a: Add Suspend/resume
 support for AX88179A/772D/279
Message-ID: <8a28bc56-8307-4f88-9add-ee7fa032ae4e@lunn.ch>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
 <20260831-ax88179a-v8-11-de905f2ee426@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-ax88179a-v8-11-de905f2ee426@birger-koblitz.de>

On Mon, Aug 31, 2026 at 11:59:00AM +0200, Birger Koblitz wrote:
> The suspend and resume functions are called via the usb_driver structure,
> for which the driver has only a single instance. Add wrapper functions
> for the different implementations for the AX88179 and AX179A architecutres
> in ax88179_lib which calls the 2 implementations in ax88179_178a and
> ax88179a_devices, respectively.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> Suggested-by: Jianhui Xu <neuromoments@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
