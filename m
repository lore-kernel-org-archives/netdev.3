Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B645237B4
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868583; cv=none; b=Ki4WmaiZpKkfJitgIIPeviPOjHqoxTqRCDY5l/xDsutwMu3u+mevcaeBC1n201bcN2/kQRgnCu5M1HOo5fdVuZn6KvgecigyFATXNmxYX1cBzgDAqQIBwl5BtCG2LF+eFzlFLjZp4N7qxg75NPPwdg+FOKgwvIEb/8VysThBHNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868583; c=relaxed/simple;
	bh=4sMz2iExU5t7uPhfiPKsEPf9vIHDl17oanmcU5Ysmdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5gCAbKXzt9d47KLtY/yZ3IPPTHEiNnBWtE40TQXGUja+SkbNc7DeeFuzKhFxLb0A/kOkOcwD8ulYC/DGXj4egXGtw12MbbG5F0LyD2f7QsdUcE/YQEEOVipvGa2uxmLCEviP7KlaId+9wOmlk/+BCu/FM9FkVkVrrHYgnEncHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sH0RxSB3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sH0RxSB3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=srn/91SoCyCvbC6oaiqLuiQQjjKq7uBepZlADrxatx0=; b=sH0RxSB3LH23Jz4ZjhPKch7gTb
	4xL5aPEwoDC/mBMArACt0nvPbzmUgIrxYn2TVUBe9tEH1SbmE1r+U6IdVm0JC2F6KZZbT5uqBfRMG
	JwtXBzTfLt/sJLeWYj1vELFGi2ZBMpCBTZ9FOZiZ1p7GEd3iH7ONUoDjaQjRHj3oZGbI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3uR0-003sIS-Rz; Tue, 08 Sep 2026 13:56:18 +0200
Date: Tue, 8 Sep 2026 13:56:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Julien Blanc <julien.blanc@sprinte.eu>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>
Subject: Re: [PATCH v2] Add config phase for dp83td510e phy
Message-ID: <00b4abdd-4a6b-4013-a235-bbf11769af75@lunn.ch>
References: <d304c248bc54092d2302adebc2076ff2a9e7b3e4.camel@sprinte.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d304c248bc54092d2302adebc2076ff2a9e7b3e4.camel@sprinte.eu>

On Tue, Sep 08, 2026 at 10:08:43AM +0000, Julien Blanc wrote:
> Add a config phase for the Texas Instruments DP83TD510E ethenet PHY
> 
> The config phase currently sets the following properties from the
> device tree:
>   * RMII / RGMII mode (note : RMII master / slave can only be set
>     by straps and cannot be changed at runtime)
>   * RGMII delays. These delays can be enabled on the phy side, only
>     as a boolean. Delays are enabled if phy-mode is rgmii-id, or
>     rgmii-[rx|tx]id which enables only the corresponding delay.
> 
> Signed-off-by: Julien Blanc <julien.blanc@sprinte.eu>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
