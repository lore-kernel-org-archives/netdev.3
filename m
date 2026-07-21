Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA563B0AC6;
	Tue, 21 Jul 2026 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784666708; cv=none; b=FR3uFuy6KlFa1itdWZA0k11LtJ4YPa34uHok5DBCjakksW7eazLGhsMBrRJ8s/xUGZ4ZZ8YPPJdp/iQEKQSFzIN7qczu3iJqfqudK4lG3dpuYQWEDI/7ly/R89Up0HTITdiagY70LEjkjPzbQnDdjB29IKFo0HLaCQjo2WAyYlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784666708; c=relaxed/simple;
	bh=0U94faIDDS1woR5NOMfVeA6ynexCuUQFr9FBTZXjJ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KoBTpS2mrgvotdr4LwUiEaDIh9CXU029qOdXVt3C/taOZsBsoqdwCSLo3AaBNImt4mfhhNq69r9bjDR7BZovl9/DnUCH437XxnI1u6kGxFQgZic5K5+epTl2itZGPd/ZNGnmQaK8RC+9lGvdeFkgHaRQw86IhfAImnqgzhQJS/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5AVCOhH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5AVCOhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A731F000E9;
	Tue, 21 Jul 2026 20:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784666706;
	bh=w4dA4OBo/jCWkv3M2aNH4tpnEQVsUPkR9zfMNTrGbwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V5AVCOhHDbiskVq/Sy4NJht3OJF8SEL6OHLLexVNzPXeU0BNlEo6lpaNgnbyuVy0i
	 bpqmE4Orzsq8gOK7v2wG0tE6zGRmDS/tVjSCeAtxmKeEbwIyvXOt7OyO6LbocvXAmR
	 9s/yd98Ccgu5IuyeYSRtdqIbZtF7Ib1H9Bc0gQsEvsikE76jnGPKn6jgIfPs3WzJq3
	 opeb4SSxEIBVLh3sI4S6EPNr/xeOPSuefzyvQuaa++p7J05w0Ek1wv11d+jQ3XFzcx
	 i7t598CgZMrGGlAQAm+gLv/eeTFflZJO1Hn9sfvrJ23rVpj4qKdNLNf45EfC31ev0l
	 i2jAOuMdyyPkA==
Date: Tue, 21 Jul 2026 13:45:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Markus Stockhausen" <markus.stockhausen@gmx.de>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <chris.packham@alliedtelesis.co.nz>,
 <daniel@makrotopia.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/8] net: phy: add
 (*notify_phy_attach/detach)() hooks to struct mii_bus
Message-ID: <20260721134505.4aa7c62d@kernel.org>
In-Reply-To: <009001dd194b$835acaf0$8a1060d0$@gmx.de>
References: <20260709064157.2865063-4-markus.stockhausen@gmx.de>
	<20260721181549.855625-1-kuba@kernel.org>
	<009001dd194b$835acaf0$8a1060d0$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 21:59:54 +0200 Markus Stockhausen wrote:
> > [Medium]
> > Is the pairing between notify_phy_attach and notify_phy_detach
> > symmetric on all failure paths?  
> 
> thanks for the check. I already asked for guidance on this [1]
> but got no feedback yet. Maybe someone can assist what is
> the best way to make these calls symmetrical.

With wide spread AI code generation the real contribution is not
the typed code but the ability to design the system and answer such
questions.
