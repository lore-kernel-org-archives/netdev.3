Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877174D1786
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604622; cv=none; b=smvVBCvIYBcKCKdSJtiXIaK2o+ogkXo3fqRY7YkRxeoa9YTLpqE7qTnedJRceH0E8YbNjkRQZz02clAsJgdBatHwgVOZwPQovqZRTq7yvAm7mE0P3+0DQ1Dnb4JkDvw4XNhf7uep4tnfMq8pfblgf5CDNyJw7ur3h1WxK7/Owt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604622; c=relaxed/simple;
	bh=ibXVRhQV9XVe6uL0EeqxAWPPfBAUvcInh0xeJW5ny70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAD30LdnhOYSVVdeqK+Dv0CRzHV3kWswH10UOcwUteJMCVGwTt42fBa95IuErMT9tfBEywIb4NGfwh/lHdoC8vNkXkHVhT1KOtyiJYjym+vjrVXrRDs17laWJq5TkpQEfnPgC6wYfg9Sv1rjmV6XilCRd67+91/Xbw63LjrrJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X+U+i5vZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X+U+i5vZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BKiLtZtIuHwYcDNSLZ28bKiuCe1HYL8jjB5xzC2jMvA=; b=X+U+i5vZ7FRwTJ4hoKbJIUf7C9
	siA7UGwOJGqrRAiVG0okUvx5yf3quNa41jo3GlyJsmJTmkzqJoPAp8Hp876KWAJ2XPllpRwfOhnpH
	J6CZCMMad87w4nM4uf3iTxAR4lpaVvzk1/qbZ/n4AjLYlmtxka+nAUQ1DDFEd/0kS8Us=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBC3d-007j3F-5M; Mon, 28 Sep 2026 16:10:17 +0200
Date: Mon, 28 Sep 2026 16:10:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: John Crispin <john@phrozen.org>, Ziyou Xu <xuziyougm@gmail.com>,
	netdev@vger.kernel.org,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Gaoyang Wei <yhyxwgy@gmail.com>
Subject: Re: [RFC] net: towards a generic PON framework
Message-ID: <e3dfe67b-6d29-4bfb-9642-8c9e86a9a7b1@lunn.ch>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <b0d1908c-a6f6-4c28-bb4f-b00644acacfc@lunn.ch>
 <92d9c8a9-ef43-45ce-a599-2c00d0a2fa61@gmail.com>
 <3d5e9f9f-09e0-41a2-aa3a-e3bcfcecbef3@lunn.ch>
 <7a469037-1266-4ca3-904b-9e8117cce5e9@gmail.com>
 <e17ad80f-f2f8-4776-9f8b-1b7d3407c438@lunn.ch>
 <86e368cd-9f5a-49cb-a798-0f26a661fc30@gmail.com>
 <372bc103-e98f-486d-8dd2-f013b1dbbdcb@lunn.ch>
 <0077ab02-2215-4015-9e74-eeb8c3de6b14@phrozen.org>
 <747749a2-b168-4ba4-98d1-12991e8694bc@genexis.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <747749a2-b168-4ba4-98d1-12991e8694bc@genexis.eu>

> In the case of ANI-G 263 I looked at hwmon a while ago and IIRC there was no
> nice way to consume hwmon information from inside the kernel

Not my subsystem, but that surprises me. How is temperature management
performed, where you need to reduce clocks speeds if the system is
getting too warm. Fan control is a similar problem. Both need access
to temperature sensor values.

	Andrew
