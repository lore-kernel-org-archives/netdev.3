Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5162E23B63E;
	Sun,  9 Aug 2026 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786313966; cv=none; b=FD5U2TZxYcWQSqlb6XqSShZr+86ujYBOJo1rPboDoDTaUMB6LttzMTgZhqrxK8pdaUd81Jk3tIvMgm/POsh9C1hsG3gfiqYAC9BaAObsXYrzBoXhdH65D+EbanX3zAB7wZYE6pFkP/A/BWdgPYquGywRtlcnb2QemIASkaXld90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786313966; c=relaxed/simple;
	bh=JC7SNobLR0xwZYQ6lv0nBuNlW4WZWmHYDMUsZx5V0OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exGkx3qZHAr8qY6u6FBcz2dFy6hDut9ziAkQXQHUPVRzKuDhheuTnpk/UxoFw7b4GrpTb/EAlznbY2MZmu5azG//DBU2VjMjVGoFkEfRuU4wSf5AxYRT5yDFvPAPobNDnWeC5ed/BEFya46cWDdrN775jW5wJhbm9mVCgpEKfkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s/eKT7KR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s/eKT7KR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PS5xLjRT7zMYU7FoEfBrLkUKx+ZxRmrNfh4rboZHG3w=; b=s/eKT7KRaoWLEOUTBNFjqnm9U8
	hSgTC5ckFpcJffN+cKFmz4FFHnuyavpi8VGw2BIjihEZZI83lfZhd5BGCY19rIRZZwtq7t6rq6XSz
	MaJ69YaldvuSJ55QUlKXRGOcUjTSXZqGEGnNrZQnF98R8B9XVhA5DhjKJpYCECBFl3O0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtBrL-00GrOe-Pp; Mon, 10 Aug 2026 00:19:11 +0200
Date: Mon, 10 Aug 2026 00:19:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v13 10/11] net: mdio: realtek-rtl9300: Add
 support for RTL839x
Message-ID: <7e8f9f4d-8d76-4dfb-952b-985e9aac00dd@lunn.ch>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de>
 <20260807171058.522833-11-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807171058.522833-11-markus.stockhausen@gmx.de>

> As per the SDK the PHYs on a RTl83xx bus are mainly C22 driven. The
> polling unit works in C22 mode and the devicetree usually does not
> make use of the ethernet-phy-ieee802.3-c45 flag. Nevertheless there are
> some PHY MMD registers (e.g. EEE) that might be of interest for the
> future development of the hardware. Until that is really needed keep
> the C45 read/write helpers out of the driver.

Actually, since C45 over C22 is FUBAR, you probably do want C45 bus
transactions so you can access the EEE registers.

    Andrew
