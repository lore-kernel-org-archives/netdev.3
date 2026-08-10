Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288843E00A6;
	Mon, 10 Aug 2026 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368330; cv=none; b=cuK2YiPUDb06q0qIbOti5tme/Z5BPLgO3SrfVUT5f9uL1JAhzWn+dhlQzNCzb6h1z9ZUZgMtWZQKVPk22izzWdxeU9ndbmAuB/+ZwR7sU/WcVHVvdSG7zUJSt4qm/bjeqT4pVGFH0Vt4yZZWwrwJaFqN4oYt5/Xvs9IqiTg6DxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368330; c=relaxed/simple;
	bh=jwf8osgQgNa8DsmwzcrlBrkSzR9b+BkemrnWZR+Av4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHQ+ArRagnp2YMAs2e88tx4eKiD4K5CLwnJ4edcIUmpeRM5TrYPKDlqiOi+SZt7Efc92MS2PG9jRDqslhnIha0l3JWIx8RP2IcZ2sN3nToZBqBsQTuwpOJ566/9xnYhQf9SMMeYUg1mqtdv96YXzmrc9pmdnsqpEJPda2UAAN4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2w5xjFPM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2w5xjFPM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4ME9kX6f+rjkkeysP1/Ieca/7WQmbxxucNkHFOJ61LQ=; b=2w5xjFPMcSS54yNFv1JZG5e1Kb
	638gloj61az/6oL4d4W9NVO6t40xFHEMD+I/0kPz7UWTAWhBF9vmh0xrd4MS2r0lkSfbDMYvmq5z0
	aug9dsWUhPGQdcjMzIFgdWpaJ/fLw2SlaAMW9JjxuUZAy/3iUNZHY5Tg5KTaUkxOyxDU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtQ0C-00GvnO-Hf; Mon, 10 Aug 2026 15:25:16 +0200
Date: Mon, 10 Aug 2026 15:25:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Jianhui Xu <neuromoments@gmail.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux@armlinux.org.uk,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v6 00/13] ax88179_178a: Add support for
 AX88179A-based chips
Message-ID: <60e05662-5f0d-4b2e-9646-f7d42e04ef13@lunn.ch>
References: <2eeb01b5-7d3d-425e-9865-4e2fe1614e67@birger-koblitz.de>
 <20260810013549.2510969-1-neuromoments@gmail.com>
 <5b2c4498-2e3c-4ae6-b078-deeccf8b7a5c@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b2c4498-2e3c-4ae6-b078-deeccf8b7a5c@birger-koblitz.de>

> I have finally understood what is happening: There is a race condition between
> the controller of the AX88179A trying to set up and optimize the link and
> phylink trying to configure the link on the mac-side.

This is why i dislike any hardware/firmware which thinks it is smarter
than Linux and directly access the hardware. Such features often break
stuff, because it does not respect the mutex Linux uses to serialise
access to the device.

> I will provide a v7 with an additional phylink function phylink_mac_interrupt()
> being introduced as suggested by Andrew, which is called by ax88179a_status()
> in response to usbnet receiving the link change interrupt. I tested changing
> the link a couple of dozen times and it always worked, now.

This will make it safer, but might not stop all the problems. Does the
PHY have LEDs? Does it have temperature sensors? Features like this
operate asynchronously to link state. The user can configure them at
any time. Such register writes might collide with what the firmware is
doing. I don't suppose you have physical access to the MDIO bus and
can put a logic analyser on it? Are there bus transactions happening
during normal operation which are not from Linux?

	Andrew
