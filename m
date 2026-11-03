Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739273;
	b=PnVbCZi8uWrZWMDROQe/RTN6KpifWK69yyRfvyOflPLvaLg68tHwXZmNg48sKRKoryJq
	 gcxu0uLoEFict2Komr0NN0feFvRjglUODxgvttPhW+F1ums3xHn8yT48u5jHV7ScBMb5E
	 Md9gWs0dTwjasTM8V/eFL/Rw8xHSgTXJA6cFWCnFiiPntBljCoVWLA2ufwia5lJckdHI8
	 WZ1BlGSsrwdkdZXDsXBPcWzU2KIehww4Th12EspWLn3VtKULj/o5amrcjcu8pE+MWpyap
	 uzPsMcPBUFmXPV7TjOGi/nUIjiPefmGfbphlQQFu/PXWWjMIx3HyTTeIWB/5OJMmt8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739273;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=8Ho6FbCuVdMOZJQsLojFcN39BdF0YIJt6AGIGtdVT9o=;
	b=GWq6plPDY12SWXA6R/E6uQ0ueKJVToGeCNe9CwJtLYWeOuUeqi1AbWdVyXII23dEIkM0
	 4Z7tlViWOjOUvu0R/BVPkuOJRKGjKqe4S7IK+qrZNVhsT3iK9cefewEyt+5zKCGDH6V0A
	 2C44/u18U4PcRhSAqrNgKzj2S+AqOElpNnniSQx2hyxrUPWezBBKQdpPMxBQfmsVTf8V4
	 zYNXrNjdKNRbPtnVaJ7YeGpMHBBzGXPgFDqz6nQbOCygaP93reIDaQzOfCKIq3b8sKIPr
	 9ZZJShs1v2+B4NuTxLn56ln+Oi0i/MXNRBXnGCiopoJ5z1XaXtcsJcZjVSrjgS8lENQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xlttvC8G;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9688606A31B;
	Tue,  3 Nov 2026 20:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9688606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xlttvC8G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8Ho6FbCuVdMOZJQsLojFcN39BdF0YIJt6AGIGtdVT9o=; b=xlttvC8GWMCBEpLpc3lr+RDLkV
	MttWk7pgmEzN1/yGeMq6IyL6AsN1UxynuXhQ8vHt/t+rf2OUQ/5V1XESJ2XIrsiQo7E/CKWU8vuiX
	8DGefDC5kJBwy6Rn7txkbFLU/kUmDtvzfB+CfE2bXcQrPE3Ezy7j4xdt+U3ROUIbfsuI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOLWQ-00EAn0-3S; Tue, 03 Nov 2026 21:54:22 +0100
Date: Tue, 3 Nov 2026 21:54:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ciprian Regus <ciprian.regus@analog.com>
Subject: Re: [PATCH net-next 0/5] net: ethernet: adi: adin1110: Add OPEN
 Alliance TC6 support
Message-ID: <52abc911-67ea-45e0-b494-91652ed62220@lunn.ch>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
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
In-Reply-To: <20261103160918.409701-1-iustin.stolniceanu@analog.com>

> Open question: indirect MDIO is used automatically when STDCAP.DPRAC is
> not set. Would you prefer an explicit quirk flag instead?

I would say the current code is correct. Lets assume vendors don't
mess up and set STDCAP.DPRAC when they in fact don't support direct
access, until a vendor does actually mess up. Then we can add a quirk.

	Andrew
