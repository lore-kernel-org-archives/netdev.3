Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D8367B91;
	Tue, 21 Jul 2026 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635172; cv=none; b=OGQ/5PXPjIAGeerPuiPYgWiH+SY94aDEDUXhywa8Kt8hyxxIoXPqpDLQbU4KYCcO2RYQGw7esfKqm2EL2wOJzu0UffKEYhU3ykflCks6b2S0LwbDMV0CsLl+paULcyJSUZ/GJ/WrxkWdnmup6Wt0kcUYwvT/mhleVaRRiIVuKdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635172; c=relaxed/simple;
	bh=gXqMvUgM2umJPeLpEYg0LDcihGLqkNdGFx/69jnFUKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VNcbsayAHgrqrx821LxMU62g0U8ZrioR4WhSmnh+r53jVEgGYhWQfbgiggBMPDPuMVEq/m3zxKdWDYKlZ7gBTCKSSjO/s6Rj6NZp1LN+UM/t7mwA9E3TiRt2MgRgWjiMDXDUM9O79AgqfphEvafgBiafmMn9WamHAYQuKte8qXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lN9yo390; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lN9yo390"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D5DBB1A109D;
	Tue, 21 Jul 2026 11:59:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA34260368;
	Tue, 21 Jul 2026 11:59:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3109611BD2635;
	Tue, 21 Jul 2026 13:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784635167; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=mO74Pmw6UxmVZKXyVGBSWpqy/BgUtofKZS/t+pO3zxY=;
	b=lN9yo390/rq2VQ/FxlD+cm074MGQMPKR1qhZVtpF2vUIAh2feMxbi24XcA4Jo8iI5vEQPG
	yDzbbl9nt4PZhg+aY3pa+l+bA/ZxOMFdSdN2NH4mnNm+iyYQVpzg4Eq2t2y8JqLTFmTfXC
	CEG+pbj8aOfe6zFsEQGTp8E5zPVlJRm4oSNdpXvdHk966F7wtIWr8g7DpBvlhCUpBKctv/
	fCmaV0+4+HDfmkLx4xVW356MzPtB2SMWBmqFaY796+tsKQlIEVCXOwOWtGBIDA5IKZ8p/G
	ziTqE1IrCdPfrCumjG697Yrbvts9RFHoB659ngnRUrVYDYoXK/vPn0fdCcSzGA==
Message-ID: <baeff083-4c77-43e6-a6c0-9c0b24377fe5@bootlin.com>
Date: Tue, 21 Jul 2026 13:59:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 01/12] net: phylink: keep and use MAC
 supported_interfaces in phylink struct
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260717065448.1498335-1-ansuelsmth@gmail.com>
 <20260717065448.1498335-2-ansuelsmth@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260717065448.1498335-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/17/26 08:54, Christian Marangi wrote:
> Add in phylink struct a copy of supported_interfaces from phylink_config
> and make use of that instead of relying on phylink_config value.
> 
> This in preparation for support of PCS handling internally to phylink
> where a PCS can be removed or added after the phylink is created and we
> need both a reference of the supported_interfaces value from
> phylink_config and an internal value that can be updated with the new
> PCS info.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime
