Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23502A1CF
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017229; cv=none; b=k3EybjyQ7+03bWEEFoHd2GlbAWa0L8BNulKe/UBnu09hM9SplZM9IhzMgcHzH9S7UNhdTEyf5efMpp5+3hfTDa1h0/lQTgvf7yx162Vs659Mc3xY7gILnscm+m1Es4GNaLoxJ09axU0mQQN+gksqLFGuzG3TUl9bi0tW9Tr9VvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017229; c=relaxed/simple;
	bh=Qon9tCJHr0S18IqjJd6LiMkXGdeLiK4Xc1RMTU6WKv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QH6FqH59XlNZhbjrLZHzPietAtVsOsyuAYOsezh/NePkDrHfN9hnhYwthn+9Ar+RhPxeoRZS+ixqWqAEny3fvTb1WMDi+jg7Udh21pDRMRXP68MDW0msrLZ0Eg8ENV8wMtMN5K1BkOIs7sU+5uRYTVtmAcMmhijiOWsSjGz/kQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bTGKWJwg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bTGKWJwg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oUxRZju2vw1xu57cPyUfgPeIMhtTvNTSg8kNmG2+xnc=; b=bTGKWJwgt9Tyg5LldY4kSdM+Xb
	2vb63X204wtq2cZP8DgUqjYCg/TgGZp/GJWJppRt604pX29o5NRpeoTG2o0WWNmdPUlc+bcZ3pARM
	Azu9EvU7mBHrvL+X3PNIkPuXjr+p1tv4mpEXtDOregjAf3toSrp349LGVgElB1QUFHfU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSlnC-004zNw-6c; Fri, 29 May 2026 03:13:42 +0200
Date: Fri, 29 May 2026 03:13:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Subject: Re: [PATCH net-next v2 4/4] net: mdio: realtek-rtl9300: use command
 runner for read_c22()
Message-ID: <ea3c4b3a-9f0b-4dff-b468-2538e4892600@lunn.ch>
References: <20260527163449.1294961-1-markus.stockhausen@gmx.de>
 <20260527163449.1294961-5-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527163449.1294961-5-markus.stockhausen@gmx.de>

On Wed, May 27, 2026 at 06:34:49PM +0200, Markus Stockhausen wrote:
> Convert the final missing read_c22() path to the new read enabled command
> runner. Do it the same way as other implementations.
> 
> - bus calls otto_emdio_read_c22()
> - this hands over to SoC specific otto_emdio_9300_read_c22()
> - finally the registers are filled and the runner issued
> 
> With this cleanup remove the obsolete helper otto_emdio_wait_ready()
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
