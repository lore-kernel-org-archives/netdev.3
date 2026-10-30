Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793393080;
	b=zhzaPzoFWCjnRcjnlxGuvUouJDKcaci06UzETrftPgLuVLWDb/xsUQopHvT6ed7tCgAB
	 RT0huefzBz3+XF0lYlEle5WSXM76Sq1rBJ1/sgurh+CYzJ61cwA/ycrWTvDny7XYB2NFp
	 NRfm6tcXggiOFYpk18f8cuHD4lC8B7AZMO3pxP3Ev7QlxJR7OnEUZq0tv5hnGZ5RSoQvh
	 rao9WerwdXLlBEgD5auQGCYc91HhNgmFvnV7Bma1QBNKSyTVsc96GaACVqrHf0R2SxhGY
	 R7tqCF/g3fdBL+GbDY7hLO6X5EAcOvYWywUHupT9P0ZlkAzQ5YS7oU2s8Uk0v+aCQCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393080;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=B733tl/iJgtUaIicfu4vyW4w+2Xm7tgzANdFaqcSk34=;
	b=4YZWS8iXEtxeDQKMHLGfYJ6MTgw5Pg3YLXAtHS1Py94hbHckJRv00OdEf72Lua4tUcqd
	 oLWE8en2hCFAxrfch+Qe6bWYlR2s6L0lLNTBoFPCGRqbFkZk8ATGb/SR3ZIMBZ2w+lCGO
	 +dEtIHI1FPDZEhcrd4pCaJMI+jD2fwKYTqY8gH7vn4m0/O7yBgdAcWw2G65FxwtaraALb
	 54xK06E/uGbaoLVmMS4hI9KZn1Dq/G4jiZbSGJTN1J2bRH0Lo1z9MvfQrrhhRY0R9RK6F
	 z9NENGDMk7QcF5t/dyi3lDuzUXGQUHhK1crRUCqB9YUSIEF4beImGC8K7oPOS0OqWPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="tb3t/Bu/";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6482E606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 20:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6482E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=tb3t/Bu/
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C33EA1A13D4;
	Fri, 30 Oct 2026 20:44:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7D523603C2;
	Fri, 30 Oct 2026 20:44:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 47E7E10329108;
	Fri, 30 Oct 2026 21:44:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793393070; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=B733tl/iJgtUaIicfu4vyW4w+2Xm7tgzANdFaqcSk34=;
	b=tb3t/Bu/M5Y3a2J2moGNqoLGux7zYhIpongIoJi4Q1715/qm4t4PqfjDaJddm8DbUeRBPR
	oWg3VQDDZUgwK7BKYPNv3ToM0PhsQGYpcfKWLRhRB/HCO2alCA6PcB9Fj4DuDDBPH84hkL
	YqhxrhXO/zEyaIQLBbCI/VKGRrw4nLOD5pUTNKQMH0H70z1CzQnHLW6MOgcIZhbL8yQtpH
	EHXopXMf69F3vS9QyXbLnY+o/oV5kQj5dwzux0y5A4+BPnY7WBYB4bjgmHAEHFiINvOYyt
	jvh4i8KC/89PneQNc1P65+5Hxla0W6r9wDqE/mM1J4j2gKoewRit10c5Oc7+xg==
Message-ID: <c5fc86f9-3c43-4aee-8d88-92e8f88c6d5d@bootlin.com>
Date: Fri, 30 Oct 2026 21:44:22 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: pcs: xpcs-rk: limit advertised interfaces
To: Coia Prant <coiaprant@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261029094916.3127193-2-coiaprant@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261029094916.3127193-2-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Coia,

On 10/29/26 10:49, Coia Prant wrote:
> The RK3568 XPCS supports 1000BASE-X, SGMII and QSGMII, but the RK3568
> GMAC only implements SGMII, so only SGMII is advertised in
> supported_interfaces.
> 
> The generic xpcs core fills the mask from the compat table, which
> includes 1000BASE-X, QSGMII and the higher-speed modes. Clearing it and
> setting only SGMII keeps phylink from validating interfaces that are
> not usable here.
> 
> 1000BASE-X and QSGMII can be enabled later when a board actually wires
> them up.

So the PCS supports them, but not the MAC ? The correct fix for that is
likely in the MAC then.

There's nothing board-specific when it comes to supporting 1000BaseX if you
already support SGMII, 2500BaseX may work (it's 1000BaseX but 2.5x faster).

Ii may just be that these modes aren't implemented in the MAC, so we should
keep them enabled at the PCS level.

Maxime

