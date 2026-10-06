Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AEF46A5F0;
	Tue,  6 Oct 2026 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294873; cv=none; b=KDF0ZWsueDih0VQq0xNTWJkQAoyrwAuB+8Qs3ayaSUdKn50EPnFQ2km0UDElR8r7XPIxz9cDaHKcQD4YLmAzLWZQ4tmAEcEyni/JjqmqVvbt4owv91Tm67AWKDFKf80JYZvKusaIwzJV01mieejbif5WUk1907Z1hqNDZ9/floE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294873; c=relaxed/simple;
	bh=6KD3BfDkS4A3f1GG/6FZFdDJKHnXx2+ctB9ewgd0/JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCLvzGujcNFyPp53RZgnV1Oaa2WJhn7aX1CC+eSwS60YMlF1dnZvcZWkP44sznFH8q9KCrltOn2YaFXCGkr9AmKjPBC5RmI/8efooYIBJumZlbw+HtOtYWpe+U06o+VSjgW+gDBRXAH6cQKGfFRwykaSlSpTBKCRDiwhR2fWq+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M7hemzrl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M7hemzrl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BBOldn66zdYdytaWmd0vhO3eaTPDjOwo4kDec9rhLmw=; b=M7hemzrlir9TjKz3ha4S93e0r4
	Ia7MImvxUXN/kPg2PhBMJe6VoXLk4HZqFanQSGCQMfNOaUDYvOGcbhXxewJRZFTifXJn1SdRWI3Vp
	xnuBhw2wY9+7iKKSToSoxPWKreQbvs5LwabxnMUQGWXdtTdzJxYIPX83gh3pEyepAwzU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xE5cT-009GvD-PN; Tue, 06 Oct 2026 15:54:13 +0200
Date: Tue, 6 Oct 2026 15:54:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani.Rajagopal@onsemi.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Piergiorgio Beruto <pier.beruto@onsemi.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v8 10/11] onsemi: s2500: Add driver support for
 S2500 MAC-PHY
Message-ID: <1203b096-456b-45b0-9c2c-bbea2b0098b6@lunn.ch>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-10-7e011aacc309@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-s2500-mac-phy-support-v8-10-7e011aacc309@onsemi.com>

> +static void s2500_update_stats(struct s2500_info *priv)
> +{

> +	/* TX bytes is a 64-bit value that is stored in two regs */
> +	*(data++) += ((u64)*rptr) | (((u64)*(rptr + 1)) << 32);


> +	/* RX bytes is a 64-bit value that is stored in two regs */
> +	*(data++) += ((u64)*rptr) | (((u64)*(rptr + 1)) << 32);

Is it guaranteed by the hardware these two words are read atomically?

> +static int s2500_ptp_write_time(struct s2500_info *priv,
> +				const struct timespec64 *ts)
> +{
> +	u32 addr;
> +	u32 data[2];

Reverse christmas tree.

	Andrew
