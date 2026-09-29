Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D174E3CF1F0;
	Tue, 29 Sep 2026 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701697; cv=none; b=UV1JjwRt/u++vR+UtyNYh24s2JL/aYu9/evvWadNvnAi4li8ghZZPmDF6Q51adSLtwq+JAR3n4I54ibuAkdsaRL3m8yqAhvWLfY1e853lnY8HiRIJC99VuyERhFjHRKkUqPHIQulF5OFRdw2RTR8ElYr/QIZidp8/FUy/lvcDMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701697; c=relaxed/simple;
	bh=1T/3DOW2LSLCBaZrPUhD7ZDCqrfXxV89qF30RGN+lM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxmdfOo02wNsghsBwjOy3WkYGGag0apvZZf5GGcPuTqj1lCwl5/UhsCYw8DKnRgs83U1i++vGfybXwEGdLnh/O5XQIR7z+qRuuz07gWOf2rwE4p2vBVN2vhMqMh1buk5uj4GM402bmTM82s4K9HsA6Y5mnvxhqwdK5iTA/rPvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nPNXpA1D; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nPNXpA1D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bVqiwYvqBDRYgnbvE97lGWFpjKFcPJENqU7hkjMEoaU=; b=nPNXpA1DYh8OalQce3L3qElCh4
	dVZUl4cykos+Tcr+dflxi8MaCz11NDCBDxUQAg9GV3PIxVehk5RnQTotoBZLfuEuUdl4ZUFagniCv
	ZF+81BhBVpF+ajVLo3sZ//v6f9o2HCeZnNl9ht7z1HDn1Dmv0nIko7HUlx1POoeES8uI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBbJD-007zXo-PA; Tue, 29 Sep 2026 19:08:03 +0200
Date: Tue, 29 Sep 2026 19:08:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [PATCH 0/5] net: ftgmac100:
 Add AST2700 support
Message-ID: <36d6dac0-30ab-440a-bf35-81b33ecd8e8b@lunn.ch>
References: <20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com>
 <14a281e2-c88e-42e3-acd3-b20f111a4c28@lunn.ch>
 <SEYPR06MB5134D5AEAD86D3E4C97D1DB99D8C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134D5AEAD86D3E4C97D1DB99D8C2@SEYPR06MB5134.apcprd06.prod.outlook.com>

> Currently, we provide our custom or user to configure RGMII delay in bootloader stage,
> it is the same as AST2600 in bootloader.

From what i understand, openBMC have changed their bootloader to not
insert delays, for the ATS2600. That allows them to have DTS files
with the correct 'rgmii-id'.

> So, when booting to kernel, the RGMII delay will
> be kept. The ftgmac100 driver with AST2600 and the next generation AST2700 does not
> need to configure the RGMII delay.

Does your AST2700 bootloader also have the delays off by default?

     Andrew

