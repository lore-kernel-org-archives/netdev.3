Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6DD286D70;
	Fri, 25 Sep 2026 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347632; cv=none; b=oRc7vljiKKMWq5nOjvcwScTD8qoU/SR0woSTxSEQcGdkNsJDhn0sXYt0rMOloqWdWIl44RyvhYq2uJ7p2YO68cCiQlh5WouT3IxtBqWnRMN4YxmFqec/JZjlSyhgbNINRw0wNtXCP8q9saPD+FbShT257IFm8Rfk8WwCfjskRQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347632; c=relaxed/simple;
	bh=azGpzJ5PUILYa1UXOUYBjWo4zzEHBKr3D79v6e3S2fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zvk1qzn97qfe1ttoeT9dXTXYeP5WL9qasdYZsUuStQ3oC2BvAB5zwcGHKbcwwWXYjtnWjOIAIi7Nc3Zficm4TeFAGCejV8W/nAAJ3bAs/P43byrdbp4zAg4WWYBSUQven1M16u2g9/l7tSwLr9kI5jibTJxgYQW4BS5pv7vsGuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PvTTHNCm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PvTTHNCm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yj3GWzo29vDD9qZOnAhND1V+vLL49qsGH99b3nUnf3Y=; b=PvTTHNCmKgndZB+d1zYhq89cTl
	zn7b2v4+XZzI5ihpgj5hrngQPJK7eX/TbkJeO/qy4Fzh4WFfuMLzVYxPEBnO3uMgGBNPgd2ZB7uQL
	Vd4mL6kqmtQnBMBv2Wc/cWLSZIchoSA5d6LEdwBhcZQJ6FNy0Rd+rYfU4GUecuE8p3FU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xA7CT-007ELb-C3; Fri, 25 Sep 2026 16:46:57 +0200
Date: Fri, 25 Sep 2026 16:46:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] dt-bindings: net: Document Marvell PHY
 "marvell,reg-init"
Message-ID: <18e0762b-ada7-49f6-b055-061a525caa18@lunn.ch>
References: <20260925140410.1157036-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925140410.1157036-2-robh@kernel.org>

> +  marvell,reg-init:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    deprecated: true
> +    description:
> +      Register initialization tuples for Marvell PHYs.
> +    items:
> +      items:
> +        - description: register page
> +          maximum: 0xffff
> +        - description: register number
> +          maximum: 31
> +        - description: mask of bits to preserve
> +          maximum: 0xffff
> +        - description: value to apply
> +          maximum: 0xffff

This fits with my understanding of the hardware.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
