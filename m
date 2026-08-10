Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F302ECE91;
	Mon, 10 Aug 2026 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345505; cv=none; b=MS8aTz1df0VtfqQSgrROM4MhGusGV15Y+xkpp7nhCfE1ExzMZ8XgPtRs3eYONlvOTIciZrN4EFWwxbdOPfumMlYAtk36nUduaK8PFj+ywUUdrdIqS0Ix+say/ND2aMobVgGomGsGIwwsR7A4NR1U9iONGiqC+xa53Ur6aVAwk8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345505; c=relaxed/simple;
	bh=J8PmxqFOrhkbedwVzgb3/HZ2GmbPkvGslDvkma8bsTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cp5KTmJtXgC9H/PiYcXGy41d8p56N7Rp4DQJYc3ER2ANgJPhWFXbTr8MlKl/fa9QZOsQ0gvyMQaODIRCcwZGPEbxsM9J4Ytbd24PiQCOsZUmikIVbNA7ldvY4fxjwcCUAuUoF1TEV5Pxl6pcJ9lXqWgVGQBlITYsulSGMR8yr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MlWdsl+a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fukFOPcR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MlWdsl+a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fukFOPcR"
Date: Mon, 10 Aug 2026 09:04:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786345495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7pNtl3hHfQqX1Bg1nl8gCISMc2h+9ryXu4fgZpV5kg=;
	b=MlWdsl+a/3xuToZHevjpzF4OS5ZXYaHIYIWijgCufINNah4sHThNOvzt2iEE3P5dNPNiif
	M0p7Di8Amwq0jsjmmKqCNz4N3/1+HCVZPNR604ZsnQAYMM2n8B8nPq4rUdnGdBIZIIxVJj
	sIOnbuzvow0JyAPK6EgO5SxUHZIyETlMZmhj2a0YoywSImh/x7XxG/liTuzhayZ19KZNUm
	jSXRQBhJWlRTS76lL+WnVfri78Nrdz308MC2RIh8xGwU//tfmdboE9AyxvG2ehDb01qrB3
	Y4aajmzfR/yvcHiXQLvDcyfvHLuyOr+tnKhPD5M+tQDLzWTVB0Ge5mMaMat8oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786345495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7pNtl3hHfQqX1Bg1nl8gCISMc2h+9ryXu4fgZpV5kg=;
	b=fukFOPcRq25uhAYVYn2La93NzDOKUapCoMZGlhy7GsTH7sEM6ciotdUM2ag4Lq+8RGFtqn
	7AO7jhG8N6ycIdAQ==
From: Benedikt Spranger <b.spranger@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vasilij Strassheim <v.strassheim@linutronix.de>, Krzysztof Kozlowski
 <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Martin Kaistra
 <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
Message-ID: <20260810090453.77e896a5@mitra>
In-Reply-To: <cce12342-8352-4e59-a646-1a1cd1054f7d@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
	<20260730-loutish-labrador-of-joviality-6e6c79@quoll>
	<411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>
	<590a933f-85af-4eaa-b9ee-be689dc15c69@lunn.ch>
	<20260805153220.3860b262@mitra>
	<9f8ac30b-6579-4e48-abe3-823302a3da0e@lunn.ch>
	<20260805162705.1a3467ea@mitra>
	<b47e0589-a3a2-4f88-ba90-72d176efccd3@lunn.ch>
	<20260806172541.009f1295@mitra>
	<cce12342-8352-4e59-a646-1a1cd1054f7d@lunn.ch>
Organization: Linutronix GmbH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Sun, 9 Aug 2026 18:52:42 +0200
schrieb Andrew Lunn <andrew@lunn.ch>:

> > > Does any of this surrounding logic need software?
> > In our case: No.
> 
> Great, you have a nice simple integration.
At least for now. The backing project has an estimated service livespan
of 25 years - bad things may come...
*knock on wood* 

> But stmmac shows us, integrators do often put additional things around
> the stmmac core.
I am aware of this freak show.

> So you should keep in mind that others will add extra things around
> this device. Is that going to cause an issue?
Hopefully not. But I am well aware of: "If you can fix it in software,
It is not a hardware problem..."

> Can they do that without breaking your device?
Hopefully yes.

> Spend a little bit of time thinking about this.
We will spend some time and discussing the bindings. Especially with
the background of the STMAC. More on that in next version.

Thanks for the input.

    Bene
