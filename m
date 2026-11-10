Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352565;
	b=zIC8NP5CaY/K0Z2FO3WEyAkNLUcQDptMMjaLks5z4FdQUDnlx3gKKk0hdAmpw8mcjy6i
	 SU8VduixvqBTcVsWH6e/gWgyv0qMvDRNFOgBqlEFDj+Ztev5ZLkZE3NMFxEkfrQ+vQ1DS
	 DHvQDGYkWqSCA0pEHTB9pCVbUcZsoi+TWvL4RMjZCJ+lrrJdJRURFGY6pCL1Q0ngzc6IA
	 PuBJS8HyQ57EsN/+QytFOJzwDvkzbOYzTffL+IdAFh3WyfhF8WdsD0xuyA0Ly+G7rx7kJ
	 l1gs4jkl6edvguUnI+M63DLHGw9zfnoSDuEwGOxF3hmk6jU648tGn73qEFTkCyKPAlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352565;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aXOcZXRZG9W9cTt57WRkxGPk1ieKxWzcKQyjGslnx3U=;
	b=GkFR2NT0Y2DPwgV8sTiqTfrpoWyZu6utX/5LKQWfRtEhmpOn0jT9wEiK3yyDCt/e95H1
	 NNrLP/ayuPPEsPrnOUH0sqc9DU1cjhcKGdU0NqGd92GdHYJtSqMUZi8QA0L1cd4C86jae
	 l39uYPOF6qKOKJ7M1qW2nKn3yDUZzU4MvZ3X8kpLgu0OTr11JobmZ/qyqUfvy6/jsMykZ
	 TmFvlaWn8zhNdG6qD3M5V3ngXarGzKoUQLKAowp3rZ6Vygj9zPgGat0ZTvgsQHRX1dkXk
	 d836KqMijtJb2CKa7XpAln7pKYXD2mZpptsIrSUyZrnjvWBRv1hRGYgMlXRhznFiFWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=goArgeLC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DBE606A31C;
	Tue, 10 Nov 2026 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=goArgeLC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D531F0093C;
	Tue, 10 Nov 2026 23:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352564;
	bh=aXOcZXRZG9W9cTt57WRkxGPk1ieKxWzcKQyjGslnx3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=goArgeLCqTdLh1pc3Du1L2cgqIMUG4ujmouYTqhWdu//9Dxngx2x4ncWfM7v+qVTY
	 Kpg+i8NLYpO9RV19S//2Zy0get7IG37AB5AUVwQajojjnoHj08Hv2h53ARAdbyys/T
	 nDgB28HVfTT0dJynSquxooDiEsjfO7eiUjKUSXNA1Fb4STSRHDpLnsyXdto9HN9ecB
	 ssM8wVYEQsxxqKRxy47RNefAZ2NihcRCT0viSc87xJnEblWYxJH6Ce9U45LJXDfd8F
	 WWGC2eE1SUx31xN48rUBTcJ0DS8Cvsk3LtfEK2gnUeXL/4OGa9RVO8vI6mBQaIWzIn
	 afBpEx2nAUUog==
Date: Tue, 10 Nov 2026 15:16:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: James Clark <jjc@jclark.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Doug Berger <opendmb@gmail.com>, Nicolai
 Buchwitz <nb@tipi-net.de>, =?UTF-8?B?VGjDqW8=?= Lebrun
 <theo.lebrun@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Conor Dooley <conor.dooley@microchip.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miroslav
 Lichvar <mlichvar@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Hubert
 Feurstein <h.feurstein@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/6] net: mdio: add timestamped MDIO writes
 for PHY gettimex64
Message-ID: <20261110151602.7a065b73@kernel.org>
In-Reply-To: <20261105054839.2248046-1-jjc@jclark.com>
References: <20261105054839.2248046-1-jjc@jclark.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Nov 2026 12:48:33 +0700 James Clark wrote:
> PTP_SYS_OFFSET_EXTENDED uses gettimex64 to bracket each PHC read with
> system clock reads. Some PHYs have a PTP hardware clock (PHC) that is
> read over MDIO and sometimes multiple MDIO transfers are needed to read
> the clock. This leads to brackets in the tens of microseconds.
> Applications that synchronize the system clock from the PHC typically
> use the midpoint of the bracket as the system time of the PHC reading.
> With multiple transfers, the midpoint of the bracket is typically far
> from the time when the PHC reading actually occurred.

There are some AI nit picks available:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105054839.2248046-1-jjc@jclark.com
But frankly unless someone with time expertise reviews this it is going
nowhere.
