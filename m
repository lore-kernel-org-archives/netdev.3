Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36CC3EF659;
	Thu, 19 Mar 2026 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939588; cv=none; b=ZNdHcXk11P/iUoFjFfYlhQFaNPilMsp+7qqF3iSx+b/uIBZk0G9UB3ieuwAbj6Me3VFWjjUi7ZDVMMR7wIkhXsaEAFv9m7RAjDDpMode9UvRgYwpRUAUjMcd1k/VaokNwfBkWDXgrFpCIB7k3Ulr5uYqmmDYPgSyQA1JLpYXthU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939588; c=relaxed/simple;
	bh=onLJ+pxMVmd7Pd+PgF+4SS2Hno3iBQGyuKeGVVy73To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g68TYOaZ6aq+DTawaRJezbs4dp/gTGnleTmbHevBuCKMJJiL8JXSp/tXNf77fSe4j70K1QhAxKl/p4MPkKWJ//TOGwnp2kO+ENb89u0O7tAzFK+AnIrVaZBJ69au3OBhIPNxKVBbLV1Xyq2Jch0rY8YI4YgjToPglBIksSfzWZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3KYLWBb9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3KYLWBb9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mNsmJRzjMq9v6DLmEUk7yS3p8jyGsynvkUpJInBKrmU=; b=3KYLWBb9vjMusvjL0MM8pAmsAz
	iXMIJWHbgdkhmW0TUIIcP7N7MuNqY3FgzkUAUL0lzh6IisgD55tcD6fTfObIP0xpsV3wI54AoUAP1
	KDjJjsKFAs829xyA9oyDxG9tMGU511Z+cpzSMXIrseSPnODKuQM8qJLZvS/gxPqOQIVY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3Gie-00CQ8E-P7; Thu, 19 Mar 2026 17:59:36 +0100
Date: Thu, 19 Mar 2026 17:59:36 +0100
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
Message-ID: <1dec7b03-1ad1-4b7b-897a-5dc144dc18ee@lunn.ch>
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

If the interrupt always exists, it is better to have it in DT. I
assume it will be in the SoC .dtsi file?

Always requiring it makes the code simpler when somebody adds support
for interrupts. You don't need all the _optional_ and dealing with it
being missing etc.

      Andrew
