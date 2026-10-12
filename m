Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245135676A;
	Mon, 12 Oct 2026 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811307; cv=none; b=MqyII24xNEe7+n9ra0pTEx7xb9T5yJaCL6yM6Y3NrEBF6RXsPZmmlkK9XjXmXoPpUpZ6C3fhcTeiF3CZ/CeK/ptKHmKj21pmPs0pYBa1ud9j/bCZ7qw6zf6/7wWAmuJKZlzWo/c+75OFxaef1lgqvP8OFC15JG/xeNQC6HPJh2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811307; c=relaxed/simple;
	bh=DMZOdfKytZnLQjyc9n8gx9SmQZxHEIS7G58n4AS/ZHc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=s+MX8Mg93yLiCJvDxgS2zgWfzvJk/ECrY3aWFQecn82NkfGL58RSrriQtbIG2YLWrUucLCOys9s+MLtjCGGJwwqkkcrFNY3BmKBvxvT6te5iuV8D27dD1xOGPFbQP/FeMFTZVUYElrVBytcxDUTOeBkT9AmrKiBO+mwQCPOcuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=xN8Mgv9A; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="xN8Mgv9A"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 776A2A1586;
	Mon, 12 Oct 2026 15:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791811303; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=br2Uo0TfGFmcWIfzpme71eLxbbRkju2EGkGnvz8BVxc=;
	b=xN8Mgv9As1BfNeyx0aTKytY4L6bxQiAjyLPHmFlp6ChA1INSeOLFn2+DIWoKxuNdZOVrxe
	ctjVbZd9j3MDJlxkSPoiROrGmC/8K5WHC3Mt3yroDYZdFrc9TpPvM1EhrXhiJ+fYhB9pY4
	NQedRVLov/q24K7/6AyQ0+YX/GpzPtnZr47sUTqxdShntrFYzp9HeIsyx14xovJpIthmtY
	ZtwHtBA3Q+C/xGR9OXbXNwbpRiHVsU6Ji2/O3ynlo4yztBx1oC4tMtiWCgTi+b17uOwj6A
	vSdMywt8I+X2oAMdOw/XNu1ramn3auE89aClDQAsADmqOAeE17HQ89w7Pnu49Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 15:21:42 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: James Clark <jjc@jclark.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Doug Berger <opendmb@gmail.com>, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, Russell King <linux@armlinux.org.uk>, Conor
 Dooley <conor.dooley@microchip.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>,
 Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: mdio: bcm-unimac: implement timestamped
 MDIO writes
In-Reply-To: <68eeee64-7f62-459c-b53d-61ec04b4d8e3@lunn.ch>
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-6-jjc@jclark.com>
 <3b1a2994-5251-4800-8c61-b63d7a435b21@broadcom.com>
 <60accbd89cfaf0d4be1da5ec2fafd975@tipi-net.de>
 <CANz3_EYfcBopo=HgRioXkhoT6P+4WWpfFT7UeWkXd5eM_RNpSA@mail.gmail.com>
 <41c32f5a6f38ec9df8a79ce896912fb9@tipi-net.de>
 <68eeee64-7f62-459c-b53d-61ec04b4d8e3@lunn.ch>
Message-ID: <6b5ff0aee5db9bba10828d2f949c9d67@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrew

On 12.10.2026 13:51, Andrew Lunn wrote:

> [...]

>> I've put together 3 patches, which do the clock plumbing:
>> https://github.com/nbuchwitz/linux/commits/devel/bcm2711-gisb-clk/
> 
> It would be nice to extend this and set the divider based on this to
> give 2.5Mhz, as required by 802.3, as the default. Allow boards to
> override this using the clock-frequency property.

Sure, as a net-next follow-up once James's clock lookup is in, plus a
binding tweak since it currently promises hardware defaults?

Only BCM2711 would notice for now, 10 MHz down to 2.5. Both Pi PHYs do
12.5 MHz and the slower bus mainly hurts the PTP path, so I'd set
clock-frequency = <10000000> in bcm2711-rpi.dtsi to keep what the
boards do today. Florian, ok?

Thanks,
Nicolai
