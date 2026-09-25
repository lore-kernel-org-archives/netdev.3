Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085AF3672A8;
	Fri, 25 Sep 2026 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379132; cv=none; b=XyR9WaZivmjTK/1JkfUF6kRM10wRb2VSP8UWRloBNqr3I6h2UxNJCZZT4+9QAiM+sawqIFWVAX+AxfB/iDnz1j1SJ/7jepv75aLkQaM+JZKo7zJZJmxhRCFSRs1gIgWOo+6vqaBLq55UYxkS5MqTxgCigBvIc+XHlXFUduMPNx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379132; c=relaxed/simple;
	bh=aO9rVdUf6S7DpG35lHyxcThT3OLUrsjzpMEu5YQiIEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmFisZ711FQY1jW5TE/RBgZakXG4untQONXVbitFY3dvWCoib6650A4/2PKI5QqHn4q8QpQ8YzvzGfrGWjDIA0vi/KrByJfwBWgYziUPj7PP/fSIzj4UfgN11f9P/GKlyCDLV6F7WUVLL+tdNVY+88kKRdGjVCx3B6ADS4aVBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MTkq5B+o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MTkq5B+o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=l/NBHFaoiuJNGXiZ+cdtccDptKGDkX5wQYf8DMsB90g=; b=MTkq5B+oy7iwfCGgmhIs7ky7TW
	j3g4NHhdmbh1tu5yySzLsywogvSIYLDW4jJEx1vm6nNq8JrFZZbcRXrQ16lfUwjFd/DtBDt5Hu6qt
	J3n4TcVp+EKbTE7sY33XnXc8UtnxcqZ+KXUv+Hm+iZHUA9JQwuzuoSTJYr65XU/m0WdA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAFOd-007KHM-73; Sat, 26 Sep 2026 01:32:03 +0200
Date: Sat, 26 Sep 2026 01:32:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v3 7/8] net: dsa: soce: Add VLAN offload support
Message-ID: <0b2a2e55-7a3f-44d8-9a91-f48547a5794d@lunn.ch>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-7-ddebafcb9ba7@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-7-ddebafcb9ba7@linutronix.de>

> The port and VID selectors are shared by all VLAN operations, so
> serialize selector and data register sequences with a dedicated mutex.
> Track member and untagged masks in software and restore the shadow state
> if programming fails.

Looking at other features of the switch, how many different mutex are
going to be needed? Is it better to have a single mutex which protects
everything?

	Andrew
