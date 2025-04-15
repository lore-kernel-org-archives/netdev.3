Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB591C3C14;
	Tue, 15 Apr 2025 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720443; cv=none; b=uTI55SYpLsonBM/T7zwCXDuf3EWrYNA7haiqGjAe8c8VawRg9d/wpsohvTWdRKJnzBBlTn5ih4lz7Ly99YHCXIZoP4tA+sAOUbbX0AzkKis/R9KKheXMBr80yNIwL0zrIrXFS4CgMW83zi6fJ5ITukE/myJonL1imcrbNBLMJXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720443; c=relaxed/simple;
	bh=VplDEb+pfRktqEvP1Hd/pZJ/qXcGgjlBOmmRAD4DSho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvmNuykeqsCvmIs0n4PMocGblYnkpW6shN2ZQo9G7+ZDa6E9V/kFsJ2sEQ6Pf7KiyOL8G/WXsYcmzuS2iYJkIA7gV+kJ2W9OPjs9O4KVpyxnAnAjiQ0+3qpXAv7qR3OhoWZguZgOEKx+c1wE/pKDY4Buc80NdRXmgtz6Z7rSmco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X0qqGUDK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X0qqGUDK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+Oq3Op1ncHhjcRT0g+zzweoEtQUM8AkWbsxINToJv1g=; b=X0qqGUDK5uhtVckvlcYVJySOH2
	8Aq9+aJHUShVMn5Fo9Pm5DIYjhsnE3G4DkgEqkTwn140anTVhVzIrlu6KcT69M3BsOp4a5mt+Z07I
	rmp5YVLOD19YwuRpbW01hdNy2OI1M/cCGU++6rI/PAuePgFy2185pg1a7mmy2bd7SQlM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4fTz-009R7v-9k; Tue, 15 Apr 2025 14:33:43 +0200
Date: Tue, 15 Apr 2025 14:33:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.or
Subject: Re: [net-next PATCH v7 5/6] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <d66d8163-76f2-4a34-9e7f-b735a6774156@lunn.ch>
References: <20250410095443.30848-1-ansuelsmth@gmail.com>
 <20250410095443.30848-6-ansuelsmth@gmail.com>
 <Z_4o7SBGxHBdjWFZ@shell.armlinux.org.uk>
 <67fe41e5.5d0a0220.1003f3.9737@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67fe41e5.5d0a0220.1003f3.9737@mx.google.com>

> > static bool aeon_ipc_ready(u16 val, bool parity_status)
> > {
> > 	u16 status;
> > 
> > 	if (FIELD_GET(AEON_IPC_STS_PARITY, val) != parity_status)
> > 		return false;
> > 
> > 	status = val & AEON_IPC_STS_STATUS;
> > 
> > 	return status != AEON_IPC_STS_STATUS_RCVD &&
> > 	       status != AEON_IPC_STS_STATUS_PROCESS &&
> > 	       status != AEON_IPC_STS_STATUS_BUSY;
> > }
> > 
> > would be better, and then maybe you can fit the code into less than 80
> > columns. I'm not a fan of FIELD_PREP_CONST() when it causes differing
> > usage patterns like the above (FIELD_GET(AEON_IPC_STS_STATUS, val)
> > would match the coding style, and probably makes no difference to the
> > code emitted.)
> > 
> 
> You are suggesting to use a generic readx function or use a while +
> sleep to use the suggested _ready function?

#define phy_read_mmd_poll_timeout(phydev, devaddr, regnum, val, cond, \
				  sleep_us, timeout_us, sleep_before_read) \
({ \
	int __ret, __val; \
	__ret = read_poll_timeout(__val = phy_read_mmd, val, \
				  __val < 0 || (cond), \

The macro magic probably allows you to make cond a function call.

	Andrew
