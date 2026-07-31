Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA7035C193;
	Fri, 31 Jul 2026 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478570; cv=none; b=McAxzxGiGh49XyVk7IF+UbS6FgCj8rV2HbjAOQ+/mGNwrdTIwDCy4pFoEIf8Hn5KyEXDXSMRdYsF7EaBUVSz/SHIB1K4jStvJGfOCau1XiMpHSl46ndEBU/p0Sq3v5N3gx2bUvoIl59LJQEZxYL5WJaApXEqls3nY1EQJlutzXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478570; c=relaxed/simple;
	bh=l3Q42nzcGMKxgcV6gSD/b6ksPLagU0fRBNetl032Cxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euwxLQB4Uu0vCMug3Nzk6e3WB+f2qYV+kdJG0CEXz3adbB9vIyXnC8ufl3qzEjPA23Y8I3YUW4J3kr3xRI9y9eq6OfFpM+W75wk6ZbZNSNdrgWkAPxz+OxnuBOAUmjFSjeucv6aI0Xp+n2hyHfC6+FrcuKrdig3eYQ3Hd8VaC48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Grf7iqz+; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Grf7iqz+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6D8D94E41041;
	Fri, 31 Jul 2026 06:16:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E8886039A;
	Fri, 31 Jul 2026 06:16:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4075611C1641B;
	Fri, 31 Jul 2026 08:15:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785478559; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+sLaQk5hMGac2ZjgsfEERJXkkAi0F/Kx63YTEf4+N0o=;
	b=Grf7iqz+h/x0ux6euMz1Of3HSeAbBOJgBbTjY7/Bq1h1hObeNZqBCuJ16CllzwnvmadZpD
	lGPd2zp1Je1QjF3jxjP8A7mpQ2NvZgMaC6nsCzfNIyPnPdCXKZnCEGS6+GxgATHJE8oeps
	g9dyMHYB3V2YBnmg/6As53byJ8NBomRd9S4QzPyFkiftYrbODgqJGvA6KwcXZGb6O8oy4x
	z0FKBdb43Jss+jS0V7jlxsFZtlmUyk+IXRVcBsvb1+aEvizlnvm97Dbm1Bw36u5oqxZdlW
	S130T2qU5wNzPb5qk8X0qJRwqks9OUo7CIb5Sig0b5tvhLZk00OLM37xxv1bow==
Message-ID: <94cdbd05-33df-4cf6-87f9-62c94f95a373@bootlin.com>
Date: Fri, 31 Jul 2026 08:15:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/10] net: dsa: microchip: add KSZ8463 tail
 tag handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260727-ksz-new-ptp-v3-0-caba39e680e3@bootlin.com>
 <20260727-ksz-new-ptp-v3-8-caba39e680e3@bootlin.com>
 <20260730192308.6ae496ad@kernel.org>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260730192308.6ae496ad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On 7/31/26 4:23 AM, Jakub Kicinski wrote:
> On Mon, 27 Jul 2026 12:20:50 +0200 Bastien Curutchet (Schneider
> Electric) wrote:
>> KSZ8463 uses the KSZ9893 DSA TAG driver. However, the KSZ8463 doesn't
>> use the tail tag to convey timestamps to the host as KSZ9893 does. It
>> uses the reserved fields in the PTP header instead.
> 
> Sigh, some of the marvell switches seem to be doing the same thing.
> Is this the _only_ option this switch supports?
> 
> Reserved fields in protocols are generally reserved, not free to use.

No sadly, it's the only option this switch supports.


Best regards,
Bastien
