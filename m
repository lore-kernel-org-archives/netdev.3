Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5142C50F;
	Wed, 29 Jul 2026 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345108; cv=none; b=IY/83ZpACdfJggLA/2Gt+AN19omCvEBI+sUzjafBakcV5tPDwm1jDR9cUGPR9BWZhOJ4sDAIhoGVREyDagEFO6L4fOJI9ZT90lfr8WipbSCTcTn4gOduhvWKtnMRyoKj5uhuTE2DvWldgyzaF8BHlpso38qwIDPfWDT+oY9CTMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345108; c=relaxed/simple;
	bh=/J+gbad++KlAbn6+JW9XL1VvtcgF8kwAptXRwlIoCeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP663NDy+fvfQTWLQewf6asblJsuBX+YJMV3ihMDyf0zeuM0jEAhBi9yJs5TzrW6oVzyXJeSAqUk04Pxq5nmKSbg08pQTbRch+apOiHwmUZc3W1B80Yw+ect9x0zu1VlAQwaw/oJhyGd1ONn/CRHaIfH6GtcNURLb1GBkAzMVec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F5jMp7vj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F5jMp7vj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6F2BSMvOMWsFdr+XjFrmXx4LFvQNGnAlv8X2MhpyFYk=; b=F5jMp7vjmn4/QvsATmq8YaiBZ+
	HYI6ldkfBOqiDjuUtDyNRzr2j3j8I5GbAYFtlugdV/AS4H7q+p2e+vZ7+uf/AA1x9UZcqh4jN/I98
	EKf694pD7EP0w9BSa2X8+BFwIxwFncJPnhMF0+nXMOa1+wPnG6dXBy/JmZEq3t5Ez3zI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wp7oe-00Equi-NC; Wed, 29 Jul 2026 19:11:36 +0200
Date: Wed, 29 Jul 2026 19:11:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
Message-ID: <879a1366-872d-4bad-8bec-fa8a7ee82dab@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>

> +description: |
> +  This node is the MDIO-bus device entry for the SoC-e DSA switch driver.
> +  It is a lightweight configuration node that lives on the MDIO bus of the
> +  SoC Ethernet controller acting as the DSA conduit (CPU port).

Must it be the conduit interfaces MDIO bus? There are boards which
exist using Marvell switches where the MDIO bus of the conduit
interface is not a Linux MDIO bus, because it is an intel i210, and
intel likes reinventing the wheel and does not use the Linux MDIO bus
infrastructure. So the MDIO interface of the switch is connected to
two GPIOs and a Linux bit bashing MDIO bus is used.

> +  soce,num-ports:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Total number of switch ports (external/user ports plus the CPU uplink
> +      port). Must be greater than zero and not exceed the selected IP variant.

Why is this needed if we already have a description of the ports?

    Andrew
