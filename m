Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16CD30D3EF;
	Thu,  4 Jun 2026 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780611798; cv=none; b=WmJsYNZkm/IKD9ASnRRGWTrzGZ4qFpQKI4Ixhp8M2uEA0yb34arvv2ORwVGKQwp+nNL91mxqxgNHTBqIJUffUEA+PevLmTsILFgYYhBX9GwPLDBWcmooauz2rRy4as9XKPZhmy534Qc80x01l8rnq1WWTuib1GElZ4+Cj7vJBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780611798; c=relaxed/simple;
	bh=Cj3a5wtbJ7+9lriBGBUrGy+4XLBy51/W0EZUlVmGtGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXTdwZZL3ANOdTBd585nWKU2S2yUqfvQEd9PfvzflNDYZnXF0/bSKRuWn+lJlE/mecTVAMSG5YCurre/l6FFrmvlLeMTm1D4BPcDu6ZeWesR8ILRWj9vdcvLQAuJDsjURxkt+cHPqEHbtK+9WT+kgBysLg29IZxaXYdJ1TMqXgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qTEoC8WW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qTEoC8WW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=70hpHvvUCowNhdJWsu6EfsO0ZrtpVhg0eQt9nqZdnls=; b=qTEoC8WWwHUsxdgORz64AsaXpH
	sMpqf2ilVRBFEPq8GM56vJxIV+dg5sJEKP7eg3yrJ7QG5I+MB3FuHsAyF4tyxR62+lvtJ0ZUypdzb
	e8eqKjHP2eod+5q83rQZbI6r2jCf+3Nv2xEC1sikJzcEJamm/FdDAj3LETbu/pC4R3cg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVGSv-00674u-0d; Fri, 05 Jun 2026 00:23:05 +0200
Date: Fri, 5 Jun 2026 00:23:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 08/13] net: ethernet: oa_tc6: Use the
 read_mms/write_mms functions for C45
Message-ID: <22e977f2-c957-41ec-beed-0670a6704e15@lunn.ch>
References: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
 <20260604-adin1140-driver-v3-8-5debdb3173c4@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-adin1140-driver-v3-8-5debdb3173c4@analog.com>

On Thu, Jun 04, 2026 at 07:32:53PM +0300, Ciprian Regus via B4 Relay wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
> 
> Accessing PHY MMD devices requires control transactions to registers in
> a memory map other than 0. Replace the current formatting of the
> register addresses with the oa_tc6_{read,write}_register_mms()
> functions. While we're here, introduce the mms variable to store the
> memory map returned by oa_tc6_get_phy_c45_mms() instead of ret, in order
> to improve the code readability.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
