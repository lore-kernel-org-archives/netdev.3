Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F43ED13E
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784058945; cv=none; b=QwqUC54oQVYWc3qT07gq+Zpsfju6hZAW8vUBjyCvEc2Z49h0GfPen2EtdpzovRMoYkzsrodV8XQMf+1inJkRiYeCVA/dWj2LDg9dxZyIxIQTvwlJktodfULaXtSPqyUTSz/epMgD+IrbuGtEh8hLLekUohNiEX5PgJIF9vrXhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784058945; c=relaxed/simple;
	bh=xZgaxnvE1V0Bn8v9qHMl8/NnGMb5gMjxc2bZcfc7O1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnmRnoOnvm+1C4JAyd0t9EGZpq4PqXQQzxx6lAFGa5cEiorfNxhhnj4DTLQtXmufM39RpJfUwbWKHjIHIxivKzz87MVitFK1++afTuijgGUVoltFrVZ4dJCaSUSk0XpMRjgg+hn70dIYyig31DdcsLQMpaEDQCN+q+FS3HwCgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cvH6i3lm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cvH6i3lm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oI0S4ZFR378em5gdXbTTpIauxguiZHRBB11Emx0Xs3c=; b=cvH6i3lmQ7QRlCkNbN+sVpKzDw
	zn+5Kd+vUm68iF0tZk1hLIDIVcdgfIDXMmf29ucCxXpa6TXzbNNx9LH+mMiM/WVhzc4TVMEA4mnPj
	lzuyY+pnBozByAoDMZrtkxuGtRhbjbXdNgyAh8CQYA1Li5r1nXf+lekS9qh7/QoRsOf8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjjEA-00CF95-Ic; Tue, 14 Jul 2026 21:55:38 +0200
Date: Tue, 14 Jul 2026 21:55:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>
Cc: Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for
 non-SFF pages
Message-ID: <23323308-6278-47ba-834e-662b0e408705@lunn.ch>
References: <AS4PR08MB80212ED810625BB46A8EE1B7B7FA2@AS4PR08MB8021.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR08MB80212ED810625BB46A8EE1B7B7FA2@AS4PR08MB8021.eurprd08.prod.outlook.com>

> There is no equivalent SET. ethtool --set-module-eeprom (both
> netlink and the legacy ioctl fallback)

In general, we are trying to block user space drivers, by only
allowing read.

> Concrete use case:
> 
> We (Technica Engineering) manufacture automotive SFP/SFP+ modules for 100/1000BASE-T1 and multi-gig automotive Ethernet (TE-1441, PT-1445). Alongside the standard SFF-8472 EEPROM at 0x50, these modules expose an I2C-to-MDIO gateway at I2C address 0x40 (0x80/0x81 as 8-bit read/write):
> 
> Writes to that address are relayed by the module's own logic as MDIO Clause 22/45 transactions to the embedded automotive PHY, giving access to link speed, master/slave mode, and other PHY configuration without needing register-level documentation of the PHY itself.

What protocol does it use? Have you seen drivers/net/mdio/mdio-i2c.c.
That currently implements two different C22 or C45 over I2C.

You should add your protocol here, and then Linux can just drive the
PHY, like it does for any other PHY.

	Andrew
