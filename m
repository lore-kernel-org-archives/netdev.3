Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8E13B440E;
	Fri, 18 Sep 2026 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697381; cv=none; b=dDzqWTrbowkU12x5TdR2gPhcJiGMNnfa+LgRF51DFp6v2QFk+BlNFcIKv+g9kvZBd4XUIboyP+qfXo+cCcIjGAxg7QrJZLIYDQ/zBq3TL6Yvmo3pHfO+OOnD/Bo1/qP0Fep0fkh5vdps9IBqqjLXNjSlE2p1dljhkoYkc3gyL9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697381; c=relaxed/simple;
	bh=Q5x/DTX56b/xTiI5vf+X5ri/o4DS8zMxo9Qe13OKwbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acipyNF64NBbiZdzBgIHG2BecvConISpTOQGa5G/zbaYtgNCh1HrWEC73GajDmpKWD3fRfsFy/XBNmGBI7bTUJbLjP2Kqxtygl6X0HhbhK+UYgty6NTXRPegKwqlGRvjiEZjHd6Q5qQCg1fzFTd7twuOwzW0va8d2W9ecYY1H8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iACEDA8t; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iACEDA8t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OtZb8xM1BGXZULi6Xiil/vMjDP/awlPYczDGFcb4C9g=; b=iACEDA8tUWmYtuA8ZlnJIRKCOJ
	5e95/Q7W7APpyZDc+56Z6O7/VniSi3GtK4hTfCsH3TJzDvC8XM6/nwyganUiir882QxUnUTpuyxWt
	mYDZpYiVy5oE1Y/m3ARYQYPNW1vCpKqAkrM0a+ariEdZJDIV5ELUu6NpTPptf1Yi3Jec=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7O2e-005mih-6A; Fri, 18 Sep 2026 04:09:32 +0200
Date: Fri, 18 Sep 2026 04:09:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phylink: unwind the PHY binding when bringup
 fails late
Message-ID: <88b00f7e-1f17-462b-be03-84035e68d7aa@lunn.ch>
References: <20260918015109.2518797-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918015109.2518797-1-f@lex.la>

> +/* Disassociate @phy from @pl. Caller must hold pl->phydev_mutex. */

How often do you see this comment in phylink about holding a mutex?

Please make the comments follow the style of the file, same as you
make the code follow the style of the file.

     Andrew
