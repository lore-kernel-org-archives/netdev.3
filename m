Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6126C4B8DC4;
	Tue,  5 May 2026 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007716; cv=none; b=KlNr8r0qSbb49Mm5F9vqQCAIN2Iptiw+Hk3tsGYKS7Vi0YoayzSC1Mxn8LKpwmInvd8ZNWbdkcMznBhWDkZyGgCsOqks2/mKPYO+PN7KGZ9Kw8VRD+1V9ENalqDwNnKfOZpn0a5cKAqR0t7vjKgzBm8wT1hvLV7N4sEF5QizCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007716; c=relaxed/simple;
	bh=P9N778U3RllFTxP2AoteTVxbVBVX3pa8/oJW54oK+9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2hi7Tae38ZinGGu1dLmmBzD2iiaRooe8iYkVvzvOubSYZbIHQeO7vL4bNp2eOzvVDRrl/ByT8M/yogWR/2G3P1ibC7da/GrqAVNCcMgMVFVsNTyF9z4fD2oRfRBF80PmOoRxSZw0TB432A28BZinQvlr7NbJ1QUBBLp4jHNDz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EtODWq8w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EtODWq8w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Tc1Ou8TseUH7oOrozpxYqdSnMg7Q1I3CXcfA2cR25iM=; b=EtODWq8wk8aUDQVLg8P6rL/GQv
	vjspXkXXNTM/5Gk2B7xXoZk0X15u2OEWe6ry3XxhCTCVJznMzarvGxO6j699jm6lnMYckdNGZwOcO
	9UO+CKVf6F7KN+P9EE6sSA69nkWl4tADMMDtxwZ6iwxjl5n7hofRZD63pLQBcArLt9Rw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKL1W-001Wbh-4J; Tue, 05 May 2026 21:01:38 +0200
Date: Tue, 5 May 2026 21:01:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Rob Herring <robh@kernel.org>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] dt-bindings: net: add onsemi's
 TS2500/NCN26010 10BASE-T1S MACPHY
Message-ID: <69cfb4a7-93b8-4ea7-b4c8-422f19419fe5@lunn.ch>
References: <CY8PR02MB9249D083B637477C254F9B0583322@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260505134434.GA2493310-robh@kernel.org>
 <CY8PR02MB924915930E62AE03DF05C2DC833E2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <7fad56ee-88c8-4e0a-8411-eeb5c0ab4a38@lunn.ch>
 <CY8PR02MB9249B2450E2931FD5533F46E833E2@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249B2450E2931FD5533F46E833E2@CY8PR02MB9249.namprd02.prod.outlook.com>

> > Since it is a 10Mbps media, if the SPI speed is lower than 15MHz,
> > maybe it cannot keep up with the media? But this clock speed on its
> > own is not the deciding factor, there could be other users of the SPI
> > bus. I would expect the driver and device to keep working if the SPI
> > bus is saturated, just not give the full 10Mbps. And it would also be
> > a good test the device and driver do work correctly when the bus is
> > saturated.
> 
> 

> I should have given more information. If we configure SPI at lower
> speed, it may start losing frames as it can't sustain the PHY's
> speed. Please let me know If I should remove it.

So it is not really a requirement. Please add a comment that at speed
of at least 15MHz is recommended in order to obtain line rate
performance.

   Andrew
