Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D586451AFF1;
	Tue, 29 Sep 2026 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683270; cv=none; b=G4EMxy/c7iXnNy46zoYEKLAXF7l5Y3RBLjrsIsV0i96wpT7P8b6gROfuynEBgj3kP9wlEY8uKi8R6tvoxiQ4Jp5yCRa1X+z1GbC6Dn1PDzH07P0u/lL53evuDvDHOKFPYoal1HL/IPAtY1odgMfQ028yPJOaFotcwqRGnCyH2fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683270; c=relaxed/simple;
	bh=nyMeU35+Ypi/1OQ+wUrl2Zx8F5lkP4PYlGngnE085Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPq4lvKNlkhKJJz2sP8WG/UBUtQjXmTNSDT04FjRGskBZ3WqE+4ursbCa+Pg/7jTDFuUWFD7fo9dlq9TRdmXuH2ZneUdTIX60kPQJGiTP357UqnNPqXHPXOek6tTE2OynJG1CnAobKuIg3RMlUm5V45D7TS0TlrHCuDXlf0uHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w2WbMj7V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w2WbMj7V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+lZZYXDSu8XAzKlx2sutGalqGKpLcifjDDzGkb1+kCw=; b=w2WbMj7VgQXZ8PbygBwHK+K/yO
	Icq/YgHYsEFAIgVYRhZJJggjvA2ADCLzghnHavmakWNBMJRjsTRZ0NZU7ZmTGrQP06Pj4qT80tgCu
	ooXdw0mlDNxLN4TAApBhVWSWDRli1hrSz3W/vQoUNfCcK8afxadvdeihAd5gFEc38Otg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBWW3-007wVm-Da; Tue, 29 Sep 2026 14:00:59 +0200
Date: Tue, 29 Sep 2026 14:00:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, Frank.Sae@motor-comm.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com
Subject: Re: [PATCH net-next v22 2/3] net: phy: Add support for Template
 Control register for PMA
Message-ID: <f6844510-3fe6-45b3-85a4-8225be495f04@lunn.ch>
References: <20260929095430.508657-1-kyle.switch@motor-comm.com>
 <20260929095430.508657-3-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929095430.508657-3-kyle.switch@motor-comm.com>

On Tue, Sep 29, 2026 at 05:54:29PM +0800, Kyle Switch wrote:
> Add support for the 10GBASE-T PMA Template Test Mode register
> field, which allows selecting one of eight test modes (Normal and
> TestMode1..TestMode7) used for PHY validation.
> 
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
