Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6893477981;
	Tue,  4 Aug 2026 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866085; cv=none; b=JvS7gqFRZ9hvqhNOLvW20n+iXbJcd3menroZmu26DHWUgIovy4zXvhbxMX5xbmJ81BHqfg3p7hfoN6fF0nYt2rnLDFtgUVvKv8bDZB6+A8AA/1SGWFcJVLZMwTy4UDbvfba/AGAbMyH1qY0big9b49cR0g6HY8dLCQ1rfbNwmXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866085; c=relaxed/simple;
	bh=OfcSOu8nZIpGrxT8OT2GBDyquxb279p8C5l8gAKXVpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj+nr++ZrN3O4fuWiyv1S2ZIXG5okkxeZxKtdsBGCZQVQ/NuZ8mlpBUbCHPpxwZNtl0BP3b7TB/SlkxCf/OxKSAZXkspyR3M0F9iQRusHC8fMGr8iQ6UCQpDk77uyWIlcoqXGFXZa2ZKGvyz7LauGnyaTWExk2OH9EefAf/wrTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kjqRJgXP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kjqRJgXP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=x5MBfBlaW1q66qx8cS8n8E+6RtEeRIkPWZZYN0nsGQk=; b=kj
	qRJgXP6xj+9GJOD9Itps12+eL28irrkjAzeIhOojq1NkYj+i5fMJwoJ26Tp+AUdz9UlILVKsWOOUz
	3RP0t5S8/TLQagQIpIG29sUAINt6fWzRLMsvQnHoUkE/GCM5EunYWYsmMiP0w8Q3W2DHeDlaSgnb2
	i1NGmvN8odNVZ5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrJLR-00G1zN-9b; Tue, 04 Aug 2026 19:54:29 +0200
Date: Tue, 4 Aug 2026 19:54:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Arthur =?iso-8859-1?Q?Cr=E9pin?= Leblond <arthur@marmottus.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w5100: restore GPIO-based link detection
Message-ID: <d762ff5f-30ba-42fc-bf58-500f807483ad@lunn.ch>
References: <20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net>

On Tue, Aug 04, 2026 at 04:38:35PM +0200, Arthur Crépin Leblond wrote:
> Commit dacf281771a9 ("w5100: remove unused gpio link detection")
> dropped the link_gpio/link_irq handling on the grounds that no
> devicetree user passed a "link" GPIO at the time.
> 
> Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>

Hi Arthur

Do you understand the architecture of this device? What exactly is on
the other end of this GPIO?

https://wiznet.io/products/ethernet-chips/w5100

suggests it has an integrated PHY. So why is a GPIO needed to report
link?

Thanks
	Andrew
