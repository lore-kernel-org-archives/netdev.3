Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794072169;
	b=GoBYyWDI7Td+AGpwLMhLcqnZ1oxJL4cFCwSoRvK/ol6AjYvWQ1esHuN9zGFnSmwwkuQy
	 4HuiBEMzYcmIPEYBjzb8+i3sb4+cgWfgeXKSIdAnFxqxzETVMja2UVo5oxHqCIAm+/ZU7
	 /Oatwybmjp0PBC4r/MHjRlYf0hR6iQKoA5ZfnDdHaIztVgLNvcwRBj8hgJuvNBaXyAV70
	 dAI2qXvZW7Ga0V1kq/dZ4k2f7gpf9gOxlSgwk1Qq5xi8H8/kyKo3b8PTrIxesCvtY4ntX
	 3MK9Np5PJCXGtdqVKBTib6p3EYEMxjRypuXHuEnJQ5OiJ4ZKLW4Eb5U3o/DsGuGUOoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794072169;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=3+26X4FrIWSJIpPtLmwtzOL6QJxtOcwEBNGPs2Yh7TU=;
	b=NhAmVQTBanans4ro1rC90FJD+Jnfje/GCb9gksbFeecrl/NqssfQnSQ1ils/6uyN1w7+
	 tG5pkYxtyTVk4Iwy4OnzGOSN1/EnPUlapNl7eSlrWdyDByX6BtEIFGupzvsUYAOYzrO2z
	 2iLkRCQmxo0EUjNTJlk8wVYCaywSogzCVmd8Dj/MMI7E3/C7+zrekc3g6Dkghc8SO8H7P
	 dlDCy1Gk8fAIKC9saal8JaeXMzS3wWlzk3e3GvDnz5qfbTaW6uMIVZ+MSWzTmwWVlxk8o
	 lQ5x1VkhPRvHuhOdWu09gCwcIaj23IxaJRr83HNaASqNewOuOANu4lzDYP6zF8norPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=KVk9fFvL;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C8606A326;
	Sat,  7 Nov 2026 17:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB9C8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=KVk9fFvL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3+26X4FrIWSJIpPtLmwtzOL6QJxtOcwEBNGPs2Yh7TU=; b=KVk9fFvLnif8VaeZ5yXc5yAzZh
	lU2EsYCOIanugCgo+EH2MXKrm218mWfPJrAQJPAKB05cn3QDIeYoh/zAQYngnaTbSZNWVlCc48fel
	sgE3dIyVrMF28lPPj5PXTe+KsZrkLAVQbrLJK1/kVrJ5GeIVwOkXfZyq9mVyFy8x34uk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPk7g-00Ez7t-Af; Sat, 07 Nov 2026 18:22:36 +0100
Date: Sat, 7 Nov 2026 18:22:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: me@marleb.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: phy: realtek: register hwmon
 thermal zones
Message-ID: <ed20a09c-e275-4124-90b7-8b1ada9fbf91@lunn.ch>
References: <20261107-realtek-hwmon-tz-v2-0-6b9a69d44470@marleb.org>
 <20261107-realtek-hwmon-tz-v2-3-6b9a69d44470@marleb.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107-realtek-hwmon-tz-v2-3-6b9a69d44470@marleb.org>

> I tested this on a Zyxel XGS1250-12 B1 with OpenWrt's Linux 6.18.55,
> where OpenWrt's out-of-tree RTL8261N support calls
> rtl822x_hwmon_init():

Mainline does not care about out of tree code.

Does this have any value for Mainline?

If not, drop it.

Or bring the out of tree code into Mainline.

	Andrew
