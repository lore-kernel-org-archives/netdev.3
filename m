Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B36631ED7C;
	Wed, 11 Mar 2026 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236217; cv=none; b=VP0DXrWbdMCCIOanEWQTiXQ5sMBdBLMyNIOb/f4XIAuu6XyQGBjLcVNJhsm+X8GjDx7adAeWXhxJdL7xbY53Si4KDcBLei2HwAHwUWUutH2xsLF5dg10VBTqKS1yQ008Q0CEamU6xKHbVJ1Kw7NXWoHw7HXR6UnTfRTlh0pzQwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236217; c=relaxed/simple;
	bh=7GklWG3OD2QFxzfWFfwTEW5tvNfC4M6UT0CgYIV3WMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Auy5WxDoeeCY+FKn/sRO3IBWgR2mw7OYINlenTeNyiz+7OYP+OdKjz+gvrf57chCUPwRXt83d0+p+j5NYegtF2M13MaRTPtF8dOMWSKkbh2Ml9Pt0nISFM94zdrdAAQ5ew0gLaEf98Sg9DS2FDUUqkd6IBWTRuFZQvo2A4cEr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JI/cpYo2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JI/cpYo2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UmX+KirSuyB2+B86LDzYFjEt72NuQxjUBpbWRsQVPBk=; b=JI/cpYo2Lb94LkXxI5hZf5/Npf
	iGa/8PpSLJLz7KadFQMURpjf+P5l6txxbE7qDqSo90tYas4xatIJHe5O1y3P9uYTl9ZeFU88TB90Z
	7vEjxVt8rSvjpiUUb6n4lhm4LeuOMDKhoXUC6J9Tf6P81R6A0Dj9ZrvwMlirtZkTbN5c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w0Jjx-00BBfh-6S; Wed, 11 Mar 2026 14:36:45 +0100
Date: Wed, 11 Mar 2026 14:36:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: hkallweit1@gmail.com, ojeda@kernel.org, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: phy: rust: add experimental Davicom
 PHY driver
Message-ID: <64ea50d9-4c7f-4c91-a686-718f0700580d@lunn.ch>
References: <20260310151935.33197-1-muchamadcoirulanwar@gmail.com>
 <917edd8c-cda0-4d35-8300-47205a975a81@lunn.ch>
 <CAO26r3S_zF4CWt1Ms3rwWqR-Rm4FCu4YRCTKVYbtJdmJEnVwQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO26r3S_zF4CWt1Ms3rwWqR-Rm4FCu4YRCTKVYbtJdmJEnVwQg@mail.gmail.com>

> I completely agree with your policy on untested code and avoiding
> C/Rust duplication. My primary goal with this RFC was exactly what you
> offered: to highlight the missing bindings (like `config_intr`,
> `config_init`, etc.) so the Rust API could be expanded.

Linux does not add an API without a user. If something is unused, it
is a pointless Maintenance burden.

> I will gladly take your advice, drop this Davicom port, and look for a
> new/unsupported PHY chip to write a proper Rust driver for. If you or
> the netdev team have any specific upcoming or unsupported PHY chips in
> mind that would be a good target for a first Rust driver, please let
> me know.

That is not really how Linux works. The Maintainers don't go out
searching for hardware which should be supported. Developers come to
us with patches.

One place you might look is Openwrt. They often have drivers for
hardware which never make it upstream to Mainline. Take such a driver,
buy the hardware, and port it to Rust. But please make sure it is
really a new device, not just a variant of an existing family of
devices which already has a driver.

	Andrew
