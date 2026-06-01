Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7165B389115;
	Mon,  1 Jun 2026 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321551; cv=none; b=jCs3DLuXpWQ1IX7IqwNtMyjjBVG10Ia6o311NIs9KOrr3mI4GaE78v4WbmYnOLcz3/3+inluhQEg5y3ni8GHXn8p2MhohA0JmJ3Ssh6RLouI7pVp/RR4PBAkX0GxVrGyf91+nKQHXkPgOSI2Yhwnb+2O8X3/6IPmrSReJK/MEYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321551; c=relaxed/simple;
	bh=cwxJeqivm3mgnXdE8hPq+wtuaGmPOEUHybjGctqTUZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZoqev9lfezgYB2Lc3TYxsbvAGLTsr2W3vT8frOywfEWX2Hh/ixWwSHf5oB1r184kOJz18hPkrV2vfFbu/ksJPgq4LpYzjiGO9RiPwj5XKOy/IIdq4TDalnYKWZ3zpL3vd7f7K8LTcJiEylOUX9eraDsccgsuo5JEJvRNXmpXPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Yhmp9CwB; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Yhmp9CwB"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C7AF116BD5;
	Mon,  1 Jun 2026 15:45:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1780321546;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=69UPH7OAHQ2Vkj/h/vJDBk4vjvGspC0wDiSfrX21sGE=;
	b=Yhmp9CwBYu6Bti1AAWVEu9NVsx/9t0PzlNyfZnn5P2J3rnIkjbAtriYaS5/zsgO7G1ekje
	D0oSuh+e2J2DVkwjpu1p4kmd4glMy5nuZSf4WHDiE8X2XtN0b6fuV0umSX2Xxz53v1XRZq
	09C42Lz4LM2+VcRC7WUgs/t88lLZE8cR9iYxA2nEQbwZ9Qm0LU1mPSrpYkaLwhCEqDiB3I
	nOjICEBvSSv5hFJ1YDr7vsHR8BMeyIqmn7dzpa8nh4i5uUUxckNFqwd7gfka79+kuaa3ab
	ritBggCnjbno4v4MxnCxxylnyTLVoq28ThfSmvOqq4LNqLsGnjtKI97RbExXDg==
Message-ID: <6fab4d83-8af9-487c-82a4-292d15fb70f7@nabladev.com>
Date: Mon, 1 Jun 2026 15:44:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 1/3] net: dsa: microchip: implement KSZ87xx
 Module 3 low-loss cable errata
To: Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nicolai Buchwitz <nb@tipi-net.de>, Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260601-ksz87xx_errata_low_loss_connections-v8-0-cfa102cf62c0@exotec.com>
 <20260601-ksz87xx_errata_low_loss_connections-v8-1-cfa102cf62c0@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260601-ksz87xx_errata_low_loss_connections-v8-1-cfa102cf62c0@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 6/1/26 1:54 PM, Fidelio Lawson wrote:
> Implement the KSZ87xx short cable workaround.
> 
> This patch implements the KSZ87xx short cable erratum
> described in Microchip document DS80000687C for KSZ87xx switches
> and the following support article:
> 
> Link: https://support.microchip.com/s/article/Solution-for-Using-CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family
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
> This change models the erratum handling as vendor-specific Clause 22 PHY
> registers, virtualized by the KSZ8 DSA driver and accessed via
> ksz8_r_phy() / ksz8_w_phy(). The following controls are provided:
> 
> - A boolean “short-cable” preset, which applies a documented and
>    conservative configuration (LPF 62 MHz bandwidth and DSP EQ initial
>    value 0), and is the recommended interface for typical use cases.
> 
> - Separate LPF bandwidth and DSP EQ initial value controls intended for
>    advanced or experimental tuning. These are orthogonal and independent,
>    and override the corresponding settings without requiring any specific
>    ordering.
> 
> The preset and tunables act as simple setters with no implicit state
> machine or invalid combinations, keeping the API predictable and aligned
> with the KISS principle.
> 
> The erratum affects the shared PHY analog front-end and therefore applies
> globally to the switch.
> 
> Fixes: e66f840c08a2 ("net: dsa: ksz: Add Microchip KSZ8795 DSA driver")
> Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
Reviewed-by: Marek Vasut <marex@nabladev.com>
