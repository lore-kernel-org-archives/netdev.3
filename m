Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAA54D0CDD;
	Wed, 16 Sep 2026 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593318; cv=none; b=aNWjbN6/ZowzxFSTFDybEpW2oYXr0hapXjBhPDRL0w+9HkumTmwduzYcd3vfJANJV6aTPXosuTD/TM+F0qdAKQyrDqJyBI+kOe+9v2w71AfvHplAqoGoiYPIhdBZ7V0A7UsX9wwY2Gbl7tRqAIHjhUkMDaI+3+SFEmyzYIUkmPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593318; c=relaxed/simple;
	bh=LSLpYjSu8Pl9R8fY1PVyPbi6DXcri7bY+YiEsgQNpsw=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=QEwFsneIOqJwm41vRGfYWvWMH5McnR3qeuvry/LCjRvgRRvSeAZ1/g1EKezT7CqXpGaIAVNQjMKqY+GL6IwyoD3rQ5HBpm8CjFenG0UDTaYw8oFtmuhFp9+bnnQMJ9M5I/iYCDqiswkxSe4bMc7IbHsa+oJbrA0+E2chqpVuvN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=1efzjaMJ; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="1efzjaMJ"
Received: from webmail.inf.ufrgs.br (webmail.inf.ufrgs.br [143.54.11.45])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 3ED121202B5;
	Wed, 16 Sep 2026 18:15:00 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1789593300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSLpYjSu8Pl9R8fY1PVyPbi6DXcri7bY+YiEsgQNpsw=;
	b=1efzjaMJLEebMXy+XNEipP78E8c9qXnuQ6xevhz41qtKrt35zR0N+a5y6mXJ0y8MRGmFba
	FWkO12HD2cx2lE+bmh7Tmqx9IjGdZy+840BO+95/jFT4iEo+XEjGI3X/WiBHVHypa+q8L8
	rbmo88KP0CTC48XMUAxiX1dBBdoO9mb9WwQyAKjMqcRFDhTEk4PuGSAxYv9eR76sH+/vyk
	O/T8/Y0xdISVdm88xFvp4iNC4P/zAN/yk/dwwDVI+wGSaxWTCLBhORnu/EJSATzGEeuxZn
	AreaGNwJlrrQAwX47ucbtnCqE52bH0OBrbonBBXgEvmwPdvauhNHtHN5HlBsGg==
Received: from 186-210-028-117.xd-dynamic.algarnetsuper.com.br
 ([186.210.28.117])
 by webmail.inf.ufrgs.br
 with HTTP (HTTP/1.1 POST); Wed, 16 Sep 2026 18:15:00 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Sep 2026 18:15:00 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] r8169: release firmware on application
 failure
In-Reply-To: <fe23c6bb-2cdf-4641-aae8-25b03b38be42@lunn.ch>
References: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
 <20260916152444.167196-4-matheus.aalmeida@inf.ufrgs.br>
 <fe23c6bb-2cdf-4641-aae8-25b03b38be42@lunn.ch>
Message-ID: <4ee3cd8a9a299d504fc95ba86a3f387a@inf.ufrgs.br>
X-Sender: matheus.aalmeida@inf.ufrgs.br
User-Agent: Roundcube Webmail/0.9.5

> If the firmware cannot be written, is the device dead? Should this
> return an error, so the caller can abort the probe?

A timeout while applying firmware could indeed indicate a PHY access
problem. However, firmware loading failures are already non-fatal,
and the callers of r8169_apply_firmware() do not propagate errors
either. Making firmware application failures fatal would require
broader changes to several r8169 PHY initialization paths.
