Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC536165A;
	Tue, 27 Jan 2026 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527319; cv=none; b=L1+ZgjWTloVV0c7CCWOOKnW+3oINn2GnIeDhrlLJL5xcc2o88UMTBeqCYlvHrHKUk9vg/9CZxz3/hj1PVnPffkexacLuVL4VYgjHSIIKs9iEUypbVEooHRY+5P0bqsED/sDvM/7n4zjX6Jzw1kVl+RCIONIosP+HB0Gkgykt8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527319; c=relaxed/simple;
	bh=fePkDsCv4hMZ3lUoQPHDKKsL3toGfU0bsvNxso3DkYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwMtYzbXyJ+vK33Y7YCTgAPRhJJYWvHdzZneW32qt9Kf5ccS+p00f4DHeInhavcIfh5UWxi3Ujqn1NVamATm9o2mr1jugfrjZVf1wFDp9c4GknEOr1iRBoNC+PGBwxB3h8MC4H3s4QGqvDbsLRcPaUMRxRBK43cQBco88hAykIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=invajB0R; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="invajB0R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9ueD2bTNAcEZWrpTO+lojWsvYSmrWq5yEY81xyWnTvQ=; b=invajB0RHQCFugw21wVkKd6eao
	tSeKPnaX6WWUQaLp7EgPfTTPRtZFY8wr7PEB6xl6lUox7mJdVwqMTi+iQgF/g6nBVUpmn6DaQCJ1/
	sjb5z8HMjhoEb24U1IziUIB9lJcIeJ/Z7j3RRhuxfP0YOylWiWIs96UOBZrtj2C8nMzA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vkksg-004yT5-3D; Tue, 27 Jan 2026 16:21:26 +0100
Date: Tue, 27 Jan 2026 16:21:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: dsa: lantiq,gswip:
 reference common PHY properties
Message-ID: <ad3bbac2-1aea-401a-881f-a8a9860f84a9@lunn.ch>
References: <cover.1769519758.git.daniel@makrotopia.org>
 <d9b6212ad5137feeb58b28e9b0784f1084c813df.1769519758.git.daniel@makrotopia.org>
 <20260127132919.xsvapgqc65f44iah@skbuf>
 <aXjGh1nzeAz8TQzH@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXjGh1nzeAz8TQzH@makrotopia.org>

> > Is the PCS integrated into the port?
> 
> The PCS is hard-tied to port 4 of the switch. Neither can that port be
> used for anything else than this PCS, nor can the PCS be used elsewhere.
> It's a bit like they nuked one of the TP PHY ports and glued in that
> SGMII PCS instead. The PCS is probably a ready-made IP block

Does it have IDs in register 2 and 3? Is there any clue if it is
licensed from somebody?

	 Andrew
