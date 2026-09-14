Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6815E4499BB
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388236; cv=none; b=JQ8miT0pO/G2TqDxLLPgWsNqn5vhjvq3KQxvrqmNov098zuzLYkoQxy0l4lLPgPxEf2cqnUsoSO3Jeu0rpW+1fklRi8VyMsq8Vr4/hGhtzYHrxXOSa3dhJn5gZLz3ujTI81NJcb2wPbqGB5gU47f5aUYxZRSuJ7rJbQ5z4xxDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388236; c=relaxed/simple;
	bh=1WAg+HVHsqG5kegq35KXYYfALf5elMFBL++wLWw9RB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiE1Vj3TxbEPGsufc/3LtQTk+f2zeJDhhVhBFJH3xpc6yjFgS9DFyRtm8PPU/WGV+w39lZa0n3t9R1opcwfGtn9egEVwv7JuX27lpA54LYTkqVQYO+QaXX3DGOCdAlkwIbU3OLxaMDQQwGVHakcStkDLts9lnHiAMklhGI9dDpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W0LAx5g3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W0LAx5g3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7D7744E4059C;
	Mon, 14 Sep 2026 12:17:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 50B8160323;
	Mon, 14 Sep 2026 12:17:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B80FF11C7AFD6;
	Mon, 14 Sep 2026 14:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789388230; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=o3d0UjjwQUMYDrQDTrdQmOMYxL8/GlCL9xvEoQry5gE=;
	b=W0LAx5g3efI/KGot3taI+LLvtNXTTUvvZ/4EW69XQtUOrsYGX+V/1eVQZnUEGXb9su7jz2
	bczPT1GUbl1TI9UH9X83TwGYJWTB1jjBawOT/CD4FRgMXX8OFxfyovSJGBAj61KzMMzMoS
	L7aSXX/WBoP7oQweW3dZWcm8IIpjT60LwWWbDtlMrdvRGZ+8FqWy2Qlq3HimDAf0UUFaWR
	cyZ6hhzRLXSgZE9G9gkjlr+xN3vTtcy1PZbkRG+XCtkKHXZs0J47lb3Rj55fDqhAa1idlN
	pLcw5r9TkfobKxwSE4Z3p50fvCNKkqmqlLCdIMRy6EanIeg+Bht+5k4ovsN4wA==
Message-ID: <aaeb3d28-facd-4980-a102-f18f52975095@bootlin.com>
Date: Mon, 14 Sep 2026 14:17:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net-next 06/10] netlink: specs: ethtool: re-align
 c33-pse-ext-state
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Danielle Ratson <danieller@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260911214148.1184806-1-ast@fiberby.net>
 <20260911214148.1184806-7-ast@fiberby.net>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260911214148.1184806-7-ast@fiberby.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/11/26 23:41, Asbjørn Sloth Tønnesen wrote:
> enum ethtool_c33_pse_ext_state is mis-aligned with YNL:
> 
> - ETHTOOL_C33_PSE_EXT_STATE_OVLD_DETECTED is 6.
> - ETHTOOL_C33_PSE_EXT_STATE_PD_DLL_POWER_TYPE is 7 (not in YNL).
> - ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE is 8, not 7.
> - ETHTOOL_C33_PSE_EXT_STATE_SHORT_DETECTED is 9, not 8.
> 
> In commit c8149739af86 ("netlink: specs: Expand the PSE netlink command
> with C33 new features") the PD_DLL_POWER_TYPE enum member was skipped,
> leading incorrect values for power-not-available and short-detected.
> 
> As PD_DLL_POWER_TYPE is not used, then skip it, but set the value for
> power-not-available to 8.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

