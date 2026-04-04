Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB4322B5AC;
	Sat,  4 Apr 2026 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775312542; cv=none; b=hBAxr3GCcpiaiFUNyVBFc4QPTfa0sO36uSFGseRZsK8S1rlVKILibaeGrgOOVs2+Yiw91WOWx/vXsAGoLdCxdTPmdeVfOFRzUHRFh7DJM8CSe/XBg2syTAN2YIu18b3IhnPIEKdxeu8FAJ1hznf3ZVdd1qyn4ojbogBio53gTbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775312542; c=relaxed/simple;
	bh=C7SFERNVRW67wb1s8I4XEIXMj3i0BSJ8dgI8WNPR9tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+KAQTKeIQ+veS6Qjk17OrOGwymeOtBNtPb41bh/gbef1CpOEwuWTEb9OxBJM2j7brnEIIu9CbIhosoKDD/TbBuJtxzJNZUalfge5fsGf9+tT3+UByqucSmlstURkYGvCJW3gl3mQgzwUJQfcNz7ZedBw5xRVz7JkyqZ27nbB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xiGEFtuF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xiGEFtuF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=GdecTGKWnl+gkDMzcPaF9Pdn1oZ7xI12TBdxMttxNnM=; b=xi
	GEFtuF/qAVS8xBD5Z3uoi55F+mwO+4ZaCG089gzQi4XmrR+P2qwVu+g0ld4xK2M8hPjXQMbDo10Tr
	M/qRuczlgZNhteUYIxDHmZjl7J6GkHT2cyVuFYdP5HbWfbpw59ziDsPHxUhiM7iKC+/2oqn5hxVjm
	TMupQINPPe65RbE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w91sq-00Emiz-In; Sat, 04 Apr 2026 16:21:56 +0200
Date: Sat, 4 Apr 2026 16:21:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidelio LAWSON <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: Re: [PATCH 1/3] dt-bindings: dsa: microchip: add KSZ low-loss cable
 errata properties
Message-ID: <72363208-76d2-409b-85ed-e53865b96629@lunn.ch>
References: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-1-79a698f43626@exotec.com>
 <521cf729-50d2-44c1-8c96-c1fba2127b9d@lunn.ch>
 <72c9a165-74bb-42a5-b5fe-67bfa2c8ce2e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72c9a165-74bb-42a5-b5fe-67bfa2c8ce2e@gmail.com>

> Regarding the difference between the two workarounds:
> Microchip’s errata does provide some insight into how they behave and when
> each should be used.
> Workaround 1 modifies the PHY equalizer settings by adjusting an indirect
> register (0x3c).
> According to Microchip’s support article:

....


Thanks for the documentation. This needs to go somewhere.

Not sure where yet. If we stay with a DT setting, it should be in the
DT binding. If we make it a PHY tuneable, maybe a comment in the PHY
driver, and in the commit message?

> Regarding the question of whether this should be exposed through a PHY
> tunable:
> I understand your concern. The erratum is indeed linked to cable
> characteristics, not the board itself.
> Since this patch modifies registers that belong to the DSA switch itself,
> and not the PHY driver,

I need to go look at the code, but maybe we can make use of the fact
the PHY is embedded within the switch, rather than being a discrete
device. So we can safely break the layering, even if it is
architecturally wrong.

	Andrew
