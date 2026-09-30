Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30051B16B;
	Wed, 30 Sep 2026 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793174; cv=none; b=it6coxvIisgWa0pDPrBwk91TzN223DtEPLAXhrEWCCOhf9unPkvk+lisBfsOe3mqDB18g6m5c9eaeYZFb9X6OkfRx3YQvBaUNtxMZEe82pKRZaXhFZl7QoK0lmyWPkz5HOjLvAy6VRiUL7GUCKsgYTwyDC8evwHFHmkbRK1tTTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793174; c=relaxed/simple;
	bh=z3mMhpAuURdGRsJCLv3OGMxqEnwpzMGo+I+gCLmRMZg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=buJxLVmnLwjayZsiP3BEQdxBtN1U+kJnCUe43XowwLUB/EHcSF+F6gFHoc1L81wOMQ47UvXk/2VO+RGME3H0bue5V7odjPOXPr+WSTwpUNjsB88OIZFUAbGaZujGkgzkwevAuN7i/ldx5tB9C9EnQa1CISIFgOEUnDNPYt/XhQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OnHXTFep; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wu4aNhL5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OnHXTFep";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wu4aNhL5"
Message-ID: <fd331b369c5eaa0d2945ed1d9c9b83c03d4a4cac.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790793171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQI//mOEofY2yiNYa2my0sB0MF6vg0jqkMYCBTMU8XI=;
	b=OnHXTFepD3Rr2fO8/WHio0edxfRjVsoWXvZJ3GiPrhl67+MLnJAwYT0QUtesxHxvQPaG+6
	+CORBSoAHMkRLlgThPwpAqGlERDA6JHbx/Q3hYYOPf7WjXEz6iMqCQWru/2NejMq7s/iWS
	z/c7P/12QNz99Z9xWRecKjmqOyW2wbgvM2zuYJoLJ+6Q6fIDQcNBLhTpG9MB4d66bx9rVw
	+L+pX9rkM0Mg9Gti/4Bqkra8REbOE4j/lY9+eXtg5MY3H1fldDnBAcsIvfXSXoDI2LkzAo
	1jbh9G1L/L2c9DG4XrdomszYCmGtf0N0LI5dh75JCiDzXYuXOeEBGblaFxnMnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790793171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQI//mOEofY2yiNYa2my0sB0MF6vg0jqkMYCBTMU8XI=;
	b=Wu4aNhL5M0V4RZYwv2UUJnZAe5pvt/mGw0/FX6vgVXnSDGfEd08KAgh/dfk7SP0L0shL4f
	VaF5As96wBP+5zAA==
Subject: Re: [PATCH net-next v3 7/8] net: dsa: soce: Add VLAN offload support
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Wed, 30 Sep 2026 20:32:50 +0200
In-Reply-To: <0b2a2e55-7a3f-44d8-9a91-f48547a5794d@lunn.ch>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
	 <20260923-devel-vstrassheim-soce-dsa-ml-v3-7-ddebafcb9ba7@linutronix.de>
	 <0b2a2e55-7a3f-44d8-9a91-f48547a5794d@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-26 at 01:32 +0200, Andrew Lunn wrote:
> > The port and VID selectors are shared by all VLAN operations, so
> > serialize selector and data register sequences with a dedicated mutex.
> > Track member and untagged masks in software and restore the shadow stat=
e
> > if programming fails.
>=20
> Looking at other features of the switch, how many different mutex are
> going to be needed? Is it better to have a single mutex which protects
> everything?

Yes, this all relates to configuration and is therefore not critical.
One mutex is sufficient and makes the code clearer.
I will change that.

>=20
> 	Andrew

Thanks,
Vasilij
