Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D627F451984
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634244; cv=none; b=MZ2u1DIv0ac0XBd+qpCelY+0zWTcDtGvd31Z7CXmDuoRAeXZC0GHKIsYtoA8fI5BNUahrgIJ0JixV0SmfIoF2tsUc2VitKOU5+ngPqguydazLRNGRndjjRYJzhEq3aYi0v9QRvC0Xg+IwyOGNvWyAnavk6Mc6ahGBSPsUEX3Qzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634244; c=relaxed/simple;
	bh=TcYdCgjat4sRp3k/mgKPjBft55Zc7FekWHextFO9+2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrW6YgyMsGkPqQ7ZcNvpzI/A9oa5FszwKebas8BYwSXCb/t7k2XoGnng3D77+NREYKy7dHJ1rGloYyUjr2FkmiS+OQYcu3sM47VPT4Vkp4lakwKEieVAs5I+Ovf4b/kf/TFZd2GThx8xmVCP1YlXs29UgAKsgareeI/5rFtTlcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yja7gtuv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yja7gtuv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aTuhpX+B24zfJBOZMteUvwDbbBGDBfXX6kBD9sb1oN4=; b=yja7gtuv5KB9Zxt84kCKL0HBEF
	KLd36il9rDZWA47sqGCe9SP8HSLpBlRsFjMsGUuZnePlpoAQKrY7c60UcJur/0e26MlJmJYalCmQc
	NIemiLyIzAtkWIFwWhZoivKDojupBBwsPTLFWiEa4j5sVKlykVq1FLJjMZYo64crKGs4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wuXB7-00HRq6-FB; Thu, 13 Aug 2026 17:17:09 +0200
Date: Thu, 13 Aug 2026 17:17:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zhixing Chen <running910@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] r8169: keep LED device name valid after setup
Message-ID: <b3d1aacb-8e7f-4ebb-b287-3dd09b02943e@lunn.ch>
References: <20260813100711.14724-1-running910@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813100711.14724-1-running910@gmail.com>

On Thu, Aug 13, 2026 at 06:07:11PM +0800, Zhixing Chen wrote:
> rtl8168_setup_ldev() and rtl8125_setup_led_ldev() build the LED device
> name in a stack buffer and assign it to led_cdev->name.
> 
> The LED class device registration path reads led_cdev->name after it has
> been assigned, and struct led_classdev stores the name as part of the LED
> class device state. Do not keep a pointer to a setup function's stack
> buffer there.
> 
> Store the name in struct r8169_led_classdev instead, so it remains valid
> for the lifetime of the LED class device.

led_classdev_register_ext() does make a copy of name, in order that it
can mangle the name to fit the naming scheme. led-class.c only
accesses led_cdev->name in led_classdev_register_ext(). So i think the
current code is safe.

However, it could become an issue in the future, if the LED core code
ever changes.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
