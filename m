Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47AD283FE6;
	Thu, 19 Mar 2026 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938860; cv=none; b=MAN6clt+4JjVWKA0PTTBGeHfPYd+OHAMKThkQGniOgLzPm+weXp3s1mtWGdiFQ0DmHLVBMpJZraReUChyGw3F/6kYw11p6amMWEE9zn/PlqTE1sdMvYa46xMcDTwzS3Qi7qhvaPlL2nEgwKHsrcPyj30ejxxHs4oylLIUHdEc2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938860; c=relaxed/simple;
	bh=g4Tvq8CkWxqrelZzfJ83az7+uXnOXpYXLq/DjGrFSoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDT9Pk17gXexMZXHGJdJ3rePDy1x0hLIiyV0DR9b96MIfAXsnOxwM9uwmBcEDsugUPR41OdAEcRZ0Sm/evI5TofVBEacljnjgXW8Lq7K+zs2mYQAL7gSjciEObOF3xqhZuT4lpDSK+Awq8PogS9LforyLoPCXO8sarq9KPDFB8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1IfSxMD2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1IfSxMD2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vP2q63Krwp1ZYUbVHlEUrPz5JO0vXusTHqO5My0Upkc=; b=1IfSxMD24FW4L5sRcBs3T1O0k0
	qJzXMyAXWNGlL6QcMD1H7WOQ71f5LKlq3ErblhEBXpnpYCez/pUzjUtF29AIYklUXlylmMDZGQWQv
	sGYZd+i1/XBh83cwmRPvFANJzASLhmWPYLR70k4Vu6/yebSRufrMCsW1rx5E7jJ9J0i0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3GWq-00CPwy-Rs; Thu, 19 Mar 2026 17:47:24 +0100
Date: Thu, 19 Mar 2026 17:47:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: document Microchip
 PIC64-HPSC/HX MDIO controller
Message-ID: <bd7f6434-3f23-44ae-bb10-d23b6dce057a@lunn.ch>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-2-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317184610.315852-2-charles.perry@microchip.com>

> The hardware supports an interrupt pin to signal transaction completion
> which is not strictly needed as the software can also poll a "TRIGGER"
> bit for this.

Experience with the FEC is that using interrupts is slower, but you
save some CPU load. The vast majority of MDIO devices poll.

     Andrew
