Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B292746F4A6;
	Fri, 16 Oct 2026 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163864; cv=none; b=g03PJQMFsmTTLSnWwiTsZHUyoblJ+40jlhwiidCSjvMo9CujobLcmP19KmXmYnbRDnyZRwKtBkiw/uilirf95HZ46dL/fN0I51ECObqAJTXu/p03LhrHLaNWsE3VL5Fy5xpGGDbNpcKnIz1cB00HqG9QNlSKc7Qd0Lsa92gsmvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163864; c=relaxed/simple;
	bh=S0cC7/QOZ211s+sMqObPJG6rINXOGu5G5uygArOyVF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3dCKfH4TkyeY6pvstXl7ShR2sqtGUGGrKxIoasxKx8DKE8iH1tpsJGQ6hrJjmH61V8w1p7Nu0qDVzuEiKWCQNoUVbf23cDIqyaw8uXl8SmPPwAr8roBUeh8sEF9BZtN0ofqp11KOmrHK1+5VEx8/tOx0ssmRLdqhW88/tzlWaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zh4hh7ut; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zh4hh7ut"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7885/ixmP6gyJsNIj6uZTmUOqtGEvwBooBf2XJfbSZ8=; b=zh4hh7ut/zpdYEgCDGAJZlNqVr
	67h/rDyowHcsN3HbsbtxYE1EcDVETrFsW0lyi/2IFox45vTdW5+aAuXSDBd05uxqrJg/oeBsww598
	o6RheaHaOUdpfaUt4UEGq9kfQ0VE4EiYgT0mHqiu2gYx0cxHEV1v34nxWNBzRWq87Eig=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHjgO-00BAXW-HJ; Fri, 16 Oct 2026 17:17:20 +0200
Date: Fri, 16 Oct 2026 17:17:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Alex Elder <elder@riscstar.com>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, Daniel Thompson <daniel@riscstar.com>,
	ansuelsmth@gmail.com, donggeunyoo.kernel@gmail.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: qcom: qca808x: Add regulator
 management
Message-ID: <e489ed64-9319-44f1-a74f-f75165c189c5@lunn.ch>
References: <20261015143849.483339-1-elder@riscstar.com>
 <20261015143849.483339-3-elder@riscstar.com>
 <atDz2hJ6xpA3p5y7@lore-desk>
 <4fc165eb-b57d-41f8-b7b9-c9fe433d866c@riscstar.com>
 <1af4e7a8-adb9-41bd-8841-61180b284470@lunn.ch>
 <atEBPbpMtlmG+Mxe@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atEBPbpMtlmG+Mxe@oss.qualcomm.com>

> I was going to share a text version of the power-up diagram given in
> this PHY's datasheet. This might help.
> 
> Power-Up Sequence
> 
> 1. DVDD asserted
>    |
>    |<-------- 10 ms -------->|   (required for external power)
>    |
> 2. DVDD18 / AVDD18 asserted
> 
> 3. VDD1P25 asserted
>    |
>    |<-------- 0.2 ms ------->|   (required for LDO to settle)
>    |
> 4. VDD_LDO asserted
> 
> 5. AVDD asserted
>    |
>    |<--------- 2 ms -------->|   (required for XTL to oscillate)
>    |
> 6. Crystal 50 MHz starts oscillating
> 
> 7. PAD reset deasserted
>    |
>    |<------- 10 ms --------->|   (deglitch time)
> 

Are these supposed to be staggered? Or can you turn them all on at
once.

23ms does seem like the worst case.

	Andrew
