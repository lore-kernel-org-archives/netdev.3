Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2B263F5D;
	Thu,  1 Oct 2026 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790818458; cv=none; b=TNr7KSsJ+Rc8x7/HT/T6b/pqv4seeOgYauiyBaIfNm1ZKEB4RLf62z1lF4g+yEVU7aGuqe/5Ql2EJLmhS+KFMCY+z7F/odk6U5m25IWv9lxNgGOCKqoqxYtc2HU+gkonlnkQmADd8VhmqTKcdrKAgoBLaJYwlV/5/cnedLeAyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790818458; c=relaxed/simple;
	bh=C+jsNGQ3FL4goplrfsCbMjy3+eqHXyzCkvpCV8mkNRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fv3W3V6qdR+VQ++BDNR9KYiyoQIvJ3jxeWKuvDxHv/kVvsQoleo322F5JIYS2maSDq/LFGmWfGNy5SU7B5ixaDihnrr/AUDPNYL9SV6nXxQUQmXOMNvnk+wMhNRZZc2BfdFTgDyOfUADiWuykWBCnGfoSK4Ciw8OXdAzu9qLAlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Q+1hJWVO; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Q+1hJWVO"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1519C106FBC;
	Thu, 01 Oct 2026 03:34:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790818454;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=NjgmiFQVKa4zAjO/LIqAXz65QfcuTP0PTq0IBCVgr7Q=;
	b=Q+1hJWVOAh5oibOJdgrV+FAYt6jNt1bh7wkG+94HG8TilYMx85ct61VDXzbrp2EAr354Ho
	Dn5NOHU7pfmAVrrSTx6YJ51BH+CWB3XNAvwREPMYuZoIWiM0Jcj6mndbTJG76w7M5hdo5N
	FhADSnfm/0l4LNHr/IHXHzJqliGkAh6K2BONA72/czA/q6JkJ4aMfnGNXbudNHN4UJfNxh
	bRlsexTB0JnCfhbgLOXBY2DQQhZU5to+tbJlRk296pfmOVPp5YFx+m5Ao9Ck0s78RbU46C
	lqe/zOzn1ttianpUm4qxRUrXE2jXb6f7oezT61uklevpuwtOWtAtyK6G2C2kpQ==
Message-ID: <e7f574ab-5fcf-484a-a5bf-fc94d45b2311@nabladev.com>
Date: Thu, 1 Oct 2026 03:34:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
To: Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
 <AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <b4addd8f-43ba-417e-85ad-a78391c8f2fb@nabladev.com>
 <AS4PR04MB9338E76DB4A59D70F1D6AB2F888A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <AS4PR04MB9338E76DB4A59D70F1D6AB2F888A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/1/26 2:45 AM, Wei Fang wrote:

Hello Wei,

>> Hmmmm, are those clock available on MX95 ? Maybe we can do some sort of
>> fallback -- assume 166 MHz clock on LS, and obtain the clock and clock
>> rate via clock framework on MX95 ?
> 
> The MDC clock is derived from the NETC system clock. For iMX platforms, the
> system clock is controlled by system manager (M33 core), Linux cannot
> configure it.

That is probably still fine, as long as the clock are available via SCMI 
and their clock frequency can be read (not written/set), we can use them.

> Moreover, the actual situation is a bit complicated. For iMX95, the
> system clock source provided by the SoC to NETC is IMX95_CLK_ENET, which is
> 666MHz. There is a 1/2 divisor in NETCMIX, so the clock input to NETC is 333MHz.
> Therefore, to obtain the actual system clock from the clock framework, we need
> to add a fixed-factor clock to the DTS as the NETC's system clock. Some platforms
> do not have this divisor. So we do not add the system clock to the binding-doc of
> both emdio and enetc.

This is something which can still be handled by a compatible string match.

> In addition, the NETC is also used on S32 platforms, that might be another story
> altogether.
> 
> Therefore, hardcoding the clock frequency according to the NETC revision in
> the driver is a simple and quick method, just like we did in the enetc driver.
> https://elixir.bootlin.com/linux/v7.3-rc5/source/drivers/net/ethernet/freescale/enetc/enetc.c#L3770

Let me try something better, give me a day or two.

Jakub, do you want a revert of this one, fix, or follow up patch ?
