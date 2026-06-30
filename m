Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E3A2C235E;
	Tue, 30 Jun 2026 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834187; cv=none; b=j9+hT6XliOImK0i7j4MJhzDRZWNhf8Z+jKS/4OyMtu2IyHyh9BXyr0zo3+GvzViNWYzZIZVKMpseVGG26lnjlJzTQ3SP1VNBUPEScGIKUe8pD6aroY4iMwab4/IFf6X5BDfa7BHa9TnWfodVMqiH9TapJ6SpJVPOHivL5kcEtRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834187; c=relaxed/simple;
	bh=a5G8lj5Vr3Cug92qW+jRXYhGd1wpChW9VT0ikwed4/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ds5+WIZmDMeg3A4uvnI80DnRevB2zZ0RSjwSDOfMOrDVWvzJA7SOEvU/Ct7I4OkK3gUi/dFuQjuM3wZu8ym7+n8+0tRy2F6z/9p81BXMxxEX8jSqkvoVdn1bJP2pcRi35p00r1x13ADRfJKh5qUeJE07AlFadUD5G/A9uWbZ7EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NRf0kcaR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NRf0kcaR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 71D1F4E40BB4;
	Tue, 30 Jun 2026 15:43:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2CED36025A;
	Tue, 30 Jun 2026 15:43:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0673106F2116;
	Tue, 30 Jun 2026 17:42:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782834183; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ip7IFQoe+FjDmN/C09LzOH0hgzEjluyXXN8qgQJUD6g=;
	b=NRf0kcaRF6+dzSqatZMU6jAZsF3CbnVzeWRZfIL/O2jDpkAxiL1B2Fw9066IRCYycAxOW0
	ZrtC9XkzokO8Vxs8QrE4k8Ve54K0KgcKQpNyn4mGle0cPqxEpC6PEDIkHDP6FSgS2zdQBB
	UQ6VlI6PrIFjOxyjT8relPexBhA6I1oIRVGYf0hsQNkXcJOuHjxLXlyIMHsDzHyaxHv9kc
	9Y/2mSq6EOz6chGC+v3YWSiZdd2iz6XXdUib/TLNCPbEiyALIdeeaeLD86oS12CXmTL1oe
	FtmAU4XjT7PoUBiOzWOqmaH2OHc/X9do/cf0PYy8szLNG1nTPy3A0D8YNxRDlA==
Message-ID: <e691298f-b3e5-4c1a-8270-a821c1f46a2b@bootlin.com>
Date: Tue, 30 Jun 2026 17:42:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: stmmac: dwmac-socfpga: Add mac-mode DT property
 support
To: "Nazle Asmade, Muhammad Nazim Amirul"
 <muhammad.nazim.amirul.nazle.asmade@altera.com>, Andrew Lunn <andrew@lunn.ch>
Cc: "dinguyen@kernel.org" <dinguyen@kernel.org>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <4c285993-978c-4d9e-a8c5-c3b36baa6840@lunn.ch>
 <7c57bb08-b72d-44bf-be44-f1bcb2aa9a84@bootlin.com>
 <b6c52ac8-32dc-4a58-83ec-ef600b306448@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <b6c52ac8-32dc-4a58-83ec-ef600b306448@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 6/30/26 17:13, Nazle Asmade, Muhammad Nazim Amirul wrote:

> Yes, Agilex5 has the same concept. The GMII-to-RGMII converter is a 
> Quartus soft IP instantiated in the FPGA fabric — equivalent to the 
> CycloneV EMAC splitter. The XGMAC outputs GMII signals to the FPGA 
> fabric, the soft IP converts them to RGMII, and the RGMII signals then 
> go through the FPGA HVIO pins to the external Marvell 88E1512 PHY.

Does this converter need any special config, and does it expose any
control registers ? or is it fully autonomous ?

If it's fully autonomous, can you detect its presence through some
capability registers or something like that ?


Maxime

