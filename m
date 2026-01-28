Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F3D15539A
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609739; cv=none; b=Lr7U/42eJp6hJFNxFaOdx55Ohi8SmJ3Nec16/KSNYvkTmo/xNM/vKd4HUOISlJVZ4sBo3m1CxU86Hj+qgqJztmZIlyNROIL5McnvEMfKfGeUGWNITj8TxHU9OtqyKDUK1gtlr1r3/fMaUcWaL1pWMZ2/JG37DtjUljJ7f5nL5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609739; c=relaxed/simple;
	bh=bkDLy03dnBpy3kR9hyawvjbxX2sRY3xbivrggE47a8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czStEjfPnz27PB+HyRPJA71EKbUCx+wNthpCHqY+bF0DAZO6c5l2m/R7tu3mpeHHoXLwkT4eX+Hmy+/C2Dh2ok1Sl+8XmROqvai6SHUXwY2v1qRVS1V2htB9U1jemtt76Q+/LjD3svm6ej3ba2TQr1bFamdS+Y1PQL+SEpedPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2laH6QUh; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2laH6QUh"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A5C38C211E8;
	Wed, 28 Jan 2026 14:15:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 235796071F;
	Wed, 28 Jan 2026 14:15:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97CFC119A880E;
	Wed, 28 Jan 2026 15:15:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769609736; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=JzIHVDwFjCIwEjLThlMak+eaj2p5mVb9GNydSBLEdFY=;
	b=2laH6QUhpYYvedtbtK1TszrakUYndSaoMPZaLGLxQjTtGVjD7aGeF+DbC9TmEefWfX62Fm
	gIwU0WSgtC4YkPybIWcrIK2XaM8Le2TNik5+kLG/e0q+ZQBvah2yYHnpg7nBhponAxEYVw
	kF2p+eWpeZQn5ONETh64nPywAe3yLa1yLoMHt+DWGwZzHAyBNWshe4ma6ifcAwZHevNnR4
	tjCqa0Gj5r1k8INjkOOtv7xuzz+YT5OdnPZ62x2CzES5G6sXm8b5oj+kWgOyfPqvzwoSVS
	ly2jTDoCeHscriEYmFOWCjzZFD1Fc9qggGWZx5zLC3i+di4YixudZFyqQUtHGA==
Message-ID: <cca153df-ae6d-4644-97ca-653f3078564d@bootlin.com>
Date: Wed, 28 Jan 2026 15:15:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: stmmac: thead: avoid conflicts with
 PHY_INTF_* definitions
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Drew Fustini <fustini@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Fu Wei <wefu@redhat.com>,
 Guo Ren <guoren@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aXnpTy6XckPGcmg0@shell.armlinux.org.uk>
 <E1vl36A-00000006urf-19ox@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vl36A-00000006urf-19ox@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 28/01/2026 11:48, Russell King (Oracle) wrote:
> Avoid conflicts between stmmac PHY_INTF_* and GMAC_INTF_CTRL register
> definitions by replacing the PHY_ prefix with GMAC_.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime
