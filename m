Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8D82857EE
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413477; cv=none; b=HOaMkWVrxLrGqyOnaZ61S4cSYSrKJxF2o1sEHIZNO+/KgvuRFOtUQQrmSRffyM1fy+UA2FlqtxoNY2MqOzEt2Me4eAsJWe8KftXFH0wrmKUdVqivg/gkn/D9FvweaothYgu7HNKT9zPIwKjEaQg0OTTlWhmZ9kVqxtXXyPirCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413477; c=relaxed/simple;
	bh=24O9ufTn+KpeXTyH+UhpqjP8r5dJp2bWBei1LbqejsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drw2cNjthzMtliP7hZcU4AJwcxBQZHJciUjdR8b1FqmizH+R/9oSxIgf3I8XbjRc1Kojbp6I7ka+4yyxOhsRX5g8+XrtJDGEQgb4Eya0HlLuYQMyRNk9PbffnBQDe2R78cR6Ny1hi21tGcQjHhq7wA6Tk14HslGpjvf8NpPbSfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3pt6ooBT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3pt6ooBT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4GfUqHmjhF5Y3ptyOoI3cfx+jBCCJ3+Zs6xOZ9V1h4Y=; b=3pt6ooBTR7RX2oloQgeZ6wgEi+
	wZmzQO6iKeWFvwEsddsCarpxYZXe1/HYyka8KpNIbZxbzTpn8TZTtrzaDU7eYpE1BER3Ty3NmiFeL
	vuh2Mdcnbg+S6QysXrWgw9DIBkERKZlJvuYSMv5oo7dfNy5QvDc95KpR92Brxg8IqJKA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUQs8-005i2L-72; Tue, 02 Jun 2026 17:17:40 +0200
Date: Tue, 2 Jun 2026 17:17:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, mensi@mensi.ch
Subject: Re: [PATCH net-next 6/8] net: mdio: realtek-rtl9300: relocate
 topology setup
Message-ID: <6ebe2342-fd11-4588-a17a-fdb057335915@lunn.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-7-markus.stockhausen@gmx.de>
 <d56efb0d-c288-43d5-b3c4-922a164fd29e@lunn.ch>
 <02b201dcf28f$e4794470$ad6bcd50$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b201dcf28f$e4794470$ad6bcd50$@gmx.de>

> With the next series I want to deactivate/activate hardware polling 
> during the whole probing process (besides other things). This avoids
> that hardware polling fills wrong MAC register states during
> bus/PHY setup.
> 
> Are you thinking about this? If yes I can add that to this series.

No, i mean during normal operation. When the core takes the mdio bus
lock, you need to disable polling until the lock is released. That is
going to need some additional API calls in struct mii_bus.

      Andrew
