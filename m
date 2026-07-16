Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62723A1A3B
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225499; cv=none; b=KJMAdzCEBTrfzJ4eCRlA/1oUpAXl4A1HKlAgTGWSykKhFT1ai7qiUa6NFOYLkVENdMz1jKNp5c2lnhjfC1u5+3SdoTOaDa/wH+Zh1k89yDs5DwV2IfQQNTm+6N4/b3RM/RH2PoQhEfTstIQ7F3or/C5BtqdmrvMdjkeebo9UgLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225499; c=relaxed/simple;
	bh=EcOMe9+x7BDLWCEpjDqWHDpdK0XxSFwXz7BgmG7GDXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+TtZIsmJx8nB3ArTtjBLNo4Db3XZEsRoYCURRR4xjQb632vaxc3sxTHfuSL1090gmuHiOYjhTX/0h8YHSfoaArYlRKFDVHWA4dxR/S/P70dQKzxMY5zNWw+P+N4g5MTd7zgG1r2gyIysYLZbRFDzuaoQt18jCjFBR93qQ5nH48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FLD3gkOE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FLD3gkOE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E38FE4E40E01;
	Thu, 16 Jul 2026 18:11:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ACEE16035F;
	Thu, 16 Jul 2026 18:11:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 667CC11BD3D29;
	Thu, 16 Jul 2026 20:11:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784225493; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3BxAjPrDAaY7o3N4I183aNhJmaPF5p2TWfasYaaLgeA=;
	b=FLD3gkOEvmtlP+U7U2uxLBHNBwf1A/TJYLEuFDLY9fbAwQMWVFDEitDOr4iJ9ripLtENa2
	KtF4gUz1izKxZp1Rtinf3cCd9jVSaFpzVjZy3RHzxnk8/c8z25png4eH5PmnctQANxHNVW
	V5HlkV3KYHR8hB9UZQZcuuOTajPrGsz9zVUPmEoewr/W6oAcs2deEOjNnZe74+e8k5xSuT
	M7z0Ui0L32pJ5FxebENUX3yBfRN+rWxfT4/RN1XGwDkAYC8An26b+DcWNWw5lNQQ2L6Coc
	CO4gAcDl9XDhxgpLfXSu4fmx+NCcc6px+zWjNZ/0msGTEeVupYy2XTB2hSyvhg==
Message-ID: <77f1cc14-cc5f-4f32-a972-f0350a60931b@bootlin.com>
Date: Thu, 16 Jul 2026 20:11:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/2] Add DAPU Telecom DAP8211R(I) Gigabit
 Ethernet PHY driver
To: Artem Shimko <a.shimko.dev@gmail.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Zhi Li <lizhi2@eswincomputing.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260716173325.653164-1-a.shimko.dev@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260716173325.653164-1-a.shimko.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Artem,

Please slow down a bit, you need to wait at least 24h between patch
submissions :

https://docs.kernel.org/process/maintainer-netdev.html

On 7/16/26 19:33, Artem Shimko wrote:
> Hello,
> 
> This series adds support for the DAPU Telecom DAP8211R(I) Gigabit
> Ethernet PHY, commonly used in enterprise and industrial networking
> applications. The PHY supports 10/100/1000 Mbps operation with RGMII
> interface and includes features such as IEEE 802.3az Energy Efficient
> Ethernet, IEEE 1588 SyncE, and an internal packet generator for
> diagnostics.
> 
> The driver implements extended register access via indirect addressing
> (registers 0x1E/0x1F) and provides comprehensive device tree support
> for RGMII delay configuration. The rx-internal-delay-ps and
> tx-internal-delay-ps properties allow precise tuning of clock delays
> in 150 ps steps from 0 to 2250 ps. The optional dapu,tx-inverted-clk
> flag enables 180-degree TX clock phase shift for boards where signal
> integrity or MAC requirements necessitate clock inversion.

+Zhi Li

This isn't the first time we see clock inversion being used to overcome
RGMII timing issues, for setups that have too big of an internal delay,
see [1].

I'm wondering if we should either reject this on the account that this
is bad HW design, or embrace that in which case it would probably be
a good idea to come-up with more generic ways to handle that.

This patch proposes the "dapu,tx-inverted-clk" property, while Zhi Li's
patch has a dedicated compatible for that (and inversion is on RX, on the
MAC side)

If clock inversion is a common thing for MAC and PHYs to be able to do,
should we add some way of representing the RGMII delays that are
introduced by the HW itself in DT, and let drivers figure-out from that
if they need to resort to clock inversion to align clk and data correctly ?

Phylib could maybe even provide helpers for that ?

[1] : https://lore.kernel.org/netdev/20260707064159.1299-1-lizhi2@eswincomputing.com/

Maxime

