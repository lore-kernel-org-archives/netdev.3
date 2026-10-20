Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455711;
	b=reRToT2li+LjUVjCeom+ZF5TVAEKwZBZkPNZIYEgsLTMfAlaj0hfE+HyBmGjzedX+z2I
	 KBY9lQpEyH7YpFE/D7YcQU7z+7agmNJ7NrsKpTVtmRytrQqLMSIWeMf+x82sg7cGRe85C
	 +uvbaYIrrrDsX9wsQ3JQxNW2ecW2ZEaljGborxulBni7TLbsHlhIEnhkuP0AqIGdsa9VA
	 UK4xEjfEOfSAP5j+fe7ZXvvv0v2z2c5yRKZ0Lknxd/CC1XlgXh5VyHoQMzzqQQol3ri5w
	 ntUbfTgszzNlJ3V4tKdXnnhL6Y1909xR0oN+3v2FJUrSnVOh+0E0eWLERiwcRC2c8Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455711;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=X+MR1ZcOqtF9urUXxQbiG80cYzn2Vu2j0TnZkl/W2Vg=;
	b=NyMB1uVjNfdSAjKpFYHccgyc16toEp4hjyT4rKE/aNBLWQTG0ymfgfjKa/QfgPRRYWmE
	 zS3JrgiWEFNUfgwi+F0zUzKyuzY/OSC8y0E67fFxEqPuelWCrDBtzpTJ3CesdlgX2MHn5
	 MNPWkvLDaoWtCl0iNioHfBj8GFkHG+te1AVDd0Q/IUQMN5PYfpo3LU1TTfzYEVIhVzSH5
	 YswcVvdshujSLsA9OM9BPYG7HA1nx5mnmE98md8FCBg4FGxxT4d/WYSNO/7NNGS6VSdap
	 1vHrmJmSbFxqDzVL+9F12Kw8IgkIFoKx8nSQdcUi8LpkRSpL1ASORGvejTQxoI39OLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Om7TCyx7;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9AD606A319;
	Tue, 20 Oct 2026 00:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF9AD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Om7TCyx7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X+MR1ZcOqtF9urUXxQbiG80cYzn2Vu2j0TnZkl/W2Vg=; b=Om7TCyx7YSA5VqHNa9DK/8xLoN
	KW/PdGOK6O76w6dKSevF5dmkADDWAHbEwdDfjC8moBfwFyoJYqTQnreKGTKde6odynrDDPO6jHFdj
	oSOxs8rK/3jxzp7bIExeoQciYg5d+n5phVGdPpSm6qRLoRopHL07J30mHsjR8Vp+s+LA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xIxbn-00BjB5-Im; Tue, 20 Oct 2026 02:21:39 +0200
Date: Tue, 20 Oct 2026 02:21:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Lucien Jheng <lucienzx159@gmail.com>,
	Albert-AL Lee <albert-al.lee@airoha.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: air_en8811h: use firmware loaded by
 the bootloader
Message-ID: <3078aefc-aad7-4cfb-b7bb-3a1bec5a832b@lunn.ch>
References: <2d6df47b-2cc3-4003-85db-f72b878427d9@lunn.ch>
 <20261019013304.1612468-1-f@lex.la>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019013304.1612468-1-f@lex.la>

On Mon, Oct 19, 2026 at 04:33:04AM +0300, Aleksei Sviridkin wrote:
> On Sun, Oct 18, 2026 at 09:13:46PM +0200, Andrew Lunn wrote:
> > Is it possible to figure out from the firmware blob what version it
> > is?
> 
> Not reliably, as far as I can tell. The version the driver prints is
> written into DM by the running MCU; the file holds zeros at that
> address. In the DSP blob the halves 0x2506 and 0x2302 sit eight bytes
> apart, which looks like the code that builds the word, but that is a
> guess at an offset in vendor code.
> 
> Lucien, Albert, does Airoha guarantee any field in EthMD32.dm.bin or
> EthMD32.DSP.bin as the firmware version, at a fixed place that will not
> move in later releases? Without such a guarantee I would rather not
> compare versions in the driver.

linux-firmware/airoha$ git log --oneline EthMD32.dm.bin 
149f9b8e linux-firmware: update firmware for en8811h 2.5G ethernet phy
d88562a0 linux-firmware: update firmware for en8811h 2.5G ethernet phy
d3480463 linux-firmware: update firmware for en8811h 2.5G ethernet phy
75ac03a8 linux-firmware: update firmware for en8811h 2.5G ethernet phy
73b4429f linux-firmware: update firmware for en8811h 2.5G ethernet phy
ddc99b3d linux-firmware: add firmware for en8811h 2.5G ethernet phy
linux-firmware/airoha$ git log --oneline EthMD32.DSP.bin
149f9b8e linux-firmware: update firmware for en8811h 2.5G ethernet phy
d88562a0 linux-firmware: update firmware for en8811h 2.5G ethernet phy
d3480463 linux-firmware: update firmware for en8811h 2.5G ethernet phy
75ac03a8 linux-firmware: update firmware for en8811h 2.5G ethernet phy
73b4429f linux-firmware: update firmware for en8811h 2.5G ethernet phy
ddc99b3d linux-firmware: add firmware for en8811h 2.5G ethernet phy

Looks like there is 6 of each. Maybe you can look at all these
versions and see if there is a pattern?

But it is just nice to have. Its not required for this patch to be
merged.

    Andrew
