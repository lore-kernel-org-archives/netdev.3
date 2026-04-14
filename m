Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60173364029;
	Tue, 14 Apr 2026 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164757; cv=none; b=N8VjnQbdrchZJTVJOrdyHkkP8pEP69tid7zet5c0wNf8tosF2FFHJgubA/sBw7NyAUa84klmo8TiGso5T0msr24OKxljkqZ/OVXAZiYRRFuXmi4Ys8fCr9qQi2uRE72EEGV0t0w4KKkb157wqLwbkY6S4RADVU0zfu1WiozSYp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164757; c=relaxed/simple;
	bh=+TLpAQHHV2gKVLYyH7LUSXX3vchNPU4uKvWT6SUvbf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YX8/etzBV3hrLjBN7S4MOAPHc30nIRjWvVXA6JUgUBllxyktqXmR2ANiTLsoy632p/xLu98n4mIWgCyS6Tq1Gnzb3d/bvfoBs1Sd6tU76AITdvtQqV3LvgPevGuca/mmLa1qS9NfpDBVluKM1YNn1NDovMu0bXUZvqzFwzqC+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=jdpvlL4c; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="jdpvlL4c"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 689B110BA27;
	Tue, 14 Apr 2026 13:05:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776164752;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BY4gvjLY2PHP5tFHL2nhgpoXJE4OtL1jotbHRkdxzEI=;
	b=jdpvlL4cMaRANMQGTRdt1neDLv+wpGir5f/mPAsB/MjnLxFIt48NGXGafTcmxHmGXKaAto
	Rr4o/oTs+VEwOUvFTg2gQebCK7r8jUnkq4CSvxNDNs7x1G803veSDdqL6lGM8pk01YCGys
	K3yQ3jqgAHHtqvI7RLfh4Js2ih9jj70WEd2EL7AjKNSov2hvb1aLO4Z7n3XSiYyyCJN8Zz
	VekMrnbHjqsuQnnhaKHal6qivVOBif+/sKkTVSZf6gkghoc7DLrAtnDVOvrvhrh65RsBvR
	PV3e/o1FRBY3qo9yZhmGPlYty2kQnKPAq1FShTxV4ti2xR+N8REuDc+1eqqT4Q==
Message-ID: <ea90a671-70be-4d89-b842-1e54d687336f@nabladev.com>
Date: Tue, 14 Apr 2026 13:05:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
 <20260414-ksz87xx_errata_low_loss_connections-v3-1-0e3838ca98c9@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260414-ksz87xx_errata_low_loss_connections-v3-1-0e3838ca98c9@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 4/14/26 11:12 AM, Fidelio Lawson wrote:
> Implement the "Module 3: Equalizer fix for short cables" erratum from
> Microchip document DS80000687C for KSZ87xx switches.
> 
> The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
> where the PHY receiver equalizer may amplify high-amplitude signals
> excessively, resulting in internal distortion and link establishment
> failures.
> 
> KSZ87xx devices require a workaround for the Module 3 low-loss cable
> condition, controlled through the switch TABLE_LINK_MD_V indirect
> registers.
> 
> The affected registers are part of the switch address space and are not
> directly accessible from the PHY driver. To keep the PHY-facing API
> clean and avoid leaking switch-specific details, model this errata
> control as vendor-specific Clause 22 PHY registers.
> 
> A vendor-specific Clause 22 PHY register is introduced as a mode
> selector in PHY_REG_LOW_LOSS_CTRL, and ksz8_r_phy() / ksz8_w_phy()
> translate accesses to these bits into the appropriate indirect
> TABLE_LINK_MD_V accesses.
> 
> The control register defines the following modes:
> 0: disabled (default behavior)
> 1: EQ training workaround
> 2: LPF 90 MHz
> 3: LPF 62 MHz
> 4: LPF 55 MHz
> 5: LPF 44 MHz
I may not fully understand this, but aren't the EQ and LPF settings 
orthogonal ?
