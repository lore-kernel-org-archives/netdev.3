Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC2D34AB14;
	Mon,  3 Aug 2026 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773012; cv=none; b=tn/flahol6u+JsdHGD+gmzfNVDHiN0qaADdVmwGG/oGrBbfSliqEDhwpeqd76N+DWjySk4i2UlO9HFZOclbw8+nSa60JaaoJ2o1R8g+sVSxma7RUoC/9qhtRtvEZOKhbaFilPuVSkS1EEhYQoYSipU6i6EtHhDnBAiHEHqbdMzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773012; c=relaxed/simple;
	bh=3gtX+hr0G5gi0545QEYadIbHcRKukj1TTU5v2Wu3hUE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jwUcdUhNBSkrd5jdQLCJasx5fDi9MJu3lltRu8CnFYfmYLlaH0DZpBxiYJ6leVWZEIITd3QdBdPMi2GyhTVQxCu8b2uMCG9+X2Pyscc9QbIz1+LRTqXNfY+uNorshd/KLrLCFsINqmATtyIMQu0cHrXIHWnlfVOJf/sv+8WPKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IPb+9pTJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8EhXwcUc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IPb+9pTJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8EhXwcUc"
Message-ID: <7ae5b44aca9c478f9273422f84faf27700558c57.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785773009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3gtX+hr0G5gi0545QEYadIbHcRKukj1TTU5v2Wu3hUE=;
	b=IPb+9pTJNa498shCZTsdeLuFbzMyXosmA6tU16ncV7Y3qd7rCo9xCJ4UIaswnNPvLuI3lr
	0+2cDB/fbHLrxubSHCzbhQDttVqSsx+l9PGJAuhWYmSpGQWRFuuK1mCxEIcsNhxv+A6RhU
	Fxig4xS7x/8NWl6lGdUNUTsCzFWQpxXV6OGEFEqRo5ZZX/cDEyOrDHoiGgR9uhWtow40TY
	uTYgCtLyJ36jB1fYY4BWrZab+zfkfvQPZb28mQ7zlvq+jRlois0ms+T0je9MxiTZRHjkOc
	nr4rAXGXnCzS42/xW5na88vigI0d5QVx787oNzFxD9fNsx/kkHBh9G4PIGNL1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785773009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3gtX+hr0G5gi0545QEYadIbHcRKukj1TTU5v2Wu3hUE=;
	b=8EhXwcUcjD5iKD3Z4U5g8QMUEi6fif47pMTyRlhGDg48PThkGoA/7u1PY2yNIj2OfHyAYg
	ZLMkBh/WxdOt/7DA==
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: Add soce
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>
Date: Mon, 03 Aug 2026 18:03:28 +0200
In-Reply-To: <20260730-aquamarine-worm-of-contentment-bfbb9d@quoll>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <20260729-devel-vstrassheim-soce-dsa-ml-v1-1-be569dae1b20@linutronix.de>
	 <20260730-aquamarine-worm-of-contentment-bfbb9d@quoll>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-30 at 10:50 +0200, Krzysztof Kozlowski wrote:
> On Wed, Jul 29, 2026 at 06:36:54PM +0200, Vasilij Strassheim wrote:
> > Add the soce vendor prefix for System-On-Chip Engineering, S.L.
> >=20
> > This prefix is used by the new SoC-e Ethernet switch DT bindings.
>=20
> Drop, implied. You explain here things which are not obvious. You can
> also look at git history to see how this is done.
>=20
I see. I will fix that before re-submitting.

> Best regards,
> Krzysztof

Thanks,
Vasilij
