Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7EF48B389;
	Tue,  5 May 2026 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002089; cv=none; b=b3VBpGcUWzRYKZf7BEBqb5OWiO0Bh2ucJoer17XChSQyG5xwb31PvHIslDDfDygV18VJHT/crF5oL5Xv14olUr5BxIjzgETvFOr9BO5j2EYaVLUyy9+JSGws/iKJgJarX/nRD4zoEBW3cWkTXbs9HLD1zDpIyckdtZHl64pPi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002089; c=relaxed/simple;
	bh=LzJN7Fs6VOQDpud4UTTma8uMftJBmgV3wyaAcUWi2WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOuCGT3Oxgflu11qsyETCICH7pXtpjTSyyfIiJM2XCYtuCGtDwdE71kcLhrDDEwTG3tE3FxZQIYHuRQnkl19sA/qRb/0aDAeQP8rB9Zx5WcNtquMbDC3J4cl/ik0Uj2g677Xo6//ZFnr7QFVixkGhxqu+9QRBJm1GDTA1HZPdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dCB3errv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dCB3errv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ohDDtqjwQ/7ssQBcXiRssQgtJor4cfVJslOhwwHcKe4=; b=dCB3errv9Qe07YxNgAl0xMG4vz
	ilB4j1osMlmjobg+peP/84c12XHt26FxKocYgbsCuJlpJCuBTOrcedMBDHLywdgFvgU7iQeaT3eAm
	U004EnARjmLLwbV/FhWPvqlVlEB70MJlYB0tCTSws8s/pVeBc9zze/EgeChIKQtdrEJk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKJYk-001Vp6-Bf; Tue, 05 May 2026 19:27:50 +0200
Date: Tue, 5 May 2026 19:27:50 +0200
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
Message-ID: <7fad56ee-88c8-4e0a-8411-eeb5c0ab4a38@lunn.ch>
References: <CY8PR02MB9249D083B637477C254F9B0583322@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260505134434.GA2493310-robh@kernel.org>
 <CY8PR02MB924915930E62AE03DF05C2DC833E2@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB924915930E62AE03DF05C2DC833E2@CY8PR02MB9249.namprd02.prod.outlook.com>

> Had the same question in internal review. Datasheet says the minimum
> speed 15 MHz is needed. That's why we had placed.

Could you try it at lower speeds. What happens?

Since it is a 10Mbps media, if the SPI speed is lower than 15MHz,
maybe it cannot keep up with the media? But this clock speed on its
own is not the deciding factor, there could be other users of the SPI
bus. I would expect the driver and device to keep working if the SPI
bus is saturated, just not give the full 10Mbps. And it would also be
a good test the device and driver do work correctly when the bus is
saturated.

	Andrew
