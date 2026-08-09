Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB712475CB;
	Sun,  9 Aug 2026 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786289316; cv=none; b=p7EzESxTur5Jn9EeVKac4wXklCCPVF+x8q8XAqMASzpokvH6upA8JYM+52b0DbsHLAKJCmdEZJrNwlGVrC+BVADGuQjK4Fp1oU6BmxrxQr7h2N5vMOzthhLvZXF1NY71UXctV7p9Q8fKz/oks0Y8Ds+YzC4rhnTEyuthghwizrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786289316; c=relaxed/simple;
	bh=7TshMjSyxLW0GG/HHQ+xDcD5T5AXokmXOx5pR2iOB+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKjpFrEdgL2w0MRouMSaIgrcDim1RfvFUa4wHoYYqTigbtLCvdltUv+QR1FOeB64TyGPEdrF5mxEQX7zSREoczWOCxWNu0tlnTeaMuDnj40LtDVj+qdxZtPOz9+rLawIk9tC6U8rZ7b9gi/ANMhmuNp3B510e8/c9LEYeDCIlP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s0+TIaYo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s0+TIaYo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wWKJcZweMkkj41xMwTO+SbluLJuHLmGKxxgmeOJ2sZg=; b=s0+TIaYoQYagMTnRysU2Qos54L
	Z1Eq1qojFas3YFreVBWS/A43mS68pZanlFbNZuhrrWLJiCi/rZtfSgHzNhrCPrl5Keau8PZE66S6T
	iQDuwdqj6lXv1enW0NPM1GjyMACJIsAhLHzWyXcWThn5rOeQdkoqKd98O/ycPwfZiv60=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wt5Rq-00Gp9l-VG; Sun, 09 Aug 2026 17:28:26 +0200
Date: Sun, 9 Aug 2026 17:28:26 +0200
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
Subject: Re: [PATCH net-next v5 13/13] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
Message-ID: <67e2bfa6-438d-4ec2-addd-6a1c1959ec0a@lunn.ch>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-13-dcb9fea4acd4@birger-koblitz.de>
 <5f32ac56-1c2f-474a-ab2a-f51464172d6d@lunn.ch>
 <4a203340-c2f1-48b3-b16f-93c31cbe2727@birger-koblitz.de>
 <f2a99d04-6d61-4cc2-814d-cfe1ef9b1395@lunn.ch>
 <7a91e550-ac70-4423-9aed-9f4406e71fe8@birger-koblitz.de>
 <527d31e5-1731-4925-bf7f-a567f3fb3774@lunn.ch>
 <6c165b0d-5e24-4b01-8057-1bef9fac851b@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c165b0d-5e24-4b01-8057-1bef9fac851b@birger-koblitz.de>

> I'll fix that in v7.

Great.

> I would like to give Jianhui time to test v6, first,
> tough. There were definitely bugs regarding suspend/resume and the MAC configuration
> introduced in v4/v5, that I would like to be sure have been fixed.

No rush. It is getting close to the v7.3 merge window, you probably
won't make it, so you have around 8 weeks to make the v7.4 merge
window.

	Andrew
