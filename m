Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F62F8BC0;
	Wed, 15 Jul 2026 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131754; cv=none; b=FcfWucJd2jbx62YJXxbxEZl9O94N+O4lgkbhKG7suoEcZd2MfsMTRZgY0dmtQe7LKXhI0k4K+tovKG0e2lp+PqTS5hwM30ea93LbT14RCFOZpGRCWGjxA/sOO/lE9I7o5zT1tJzpZZRyoCuY9IO1PV7JMK9SR+e7SBr78kMeWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131754; c=relaxed/simple;
	bh=31qH0PQJXVBSB531y9HeXA8tm1BMvZOOF7UIxhisTtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8hBB8/59UpwxMkWseqIzRC7vpeX7M6SY+ey8TOd9MRDqBdAh26Ag6tTT89jwk4Kb/ANWRaIjR/lcicL+7fCi5c9tcmdRWaBbBHPdeYt45S1pQVqBPIr+AbTU7V5df8AsTFzOnrxfLaj6n03Rh1S3itOwMt96kP6CcUNvZN3ggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vO3cm7v2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vO3cm7v2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T7qi0wjqw+T24Xr8wpK4TVGLaBhYNi0U20FSDe/v/ig=; b=vO3cm7v27gbIX2NkA8hpCjAP7e
	pxKwIkxWJO9cj6JatLoo1VS7q/2JBz1/WHrKVzJKM9BK5dq5AEXP+HU8LtDLpoYVX1Mq9jI6xuN4u
	G3JlaHoEkW71eb6GTZwh6/2Tr5gUXXo5ahYVWeE7ls2PwtkGzGKnArVqtVo+XRlyxEyw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wk2AQ-00CNlk-VJ; Wed, 15 Jul 2026 18:09:02 +0200
Date: Wed, 15 Jul 2026 18:09:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Coia Prant <coiaprant@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, robh@kernel.org, krzk+dt@kernel.org,
	heiko@sntech.de, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [RFC PATCH 01/10] net: stmmac: move XPCS lifetime management to
 platform drivers
Message-ID: <685d91a3-be6f-42c6-9e23-07629e21bcee@lunn.ch>
References: <20260714191341.690906-1-coiaprant@gmail.com>
 <20260714191341.690906-2-coiaprant@gmail.com>
 <dc21b2fc-ae11-4fde-a5b9-09e2c6bee5c9@bootlin.com>
 <CALj3r0gWyfHHp0S4=71M1-TjgHKcgGax4Lr0DzPi37Q69-iCwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALj3r0gWyfHHp0S4=71M1-TjgHKcgGax4Lr0DzPi37Q69-iCwA@mail.gmail.com>

> I actually spent all night debugging call traces caused by the current
> stmmac PCS lifetime management, and it was not a pleasant experience.
> The code feels like accumulated technical debt that should be cleaned
> up.

Russell King will strongly agree with you, if he was around. The
phylink integration into stmmac causes a lot of pain, and he wanted to
rip it all out and start again. But doing that without breaking stuff
is going to be interesting.

If you feel up to it, have a go. But take a good look around first,
make sure you understand the different variant, internal vs external
PCS.

	Andrew
