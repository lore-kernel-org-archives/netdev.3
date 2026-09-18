Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94077246788;
	Fri, 18 Sep 2026 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715891; cv=none; b=ruRyKl3ARYsKMC4k5Nh+FDbWWKVWOT6nE+rD2nzjsp7EmVTCLgOHTRgJ7uutlWnzuSiK+/TZu213EoQjjvIB0oNJgBL3Jn1nPpxHvbmUVMWDoJa1C7iAtsO9ik8V02sRjLWGdzkNFIGMjwO41nE1Pn2qd8niAg1NQ9QYhIBs+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715891; c=relaxed/simple;
	bh=vcExdwYskntjQZFH0CJIvqJvt3cF0ureSfkjMoJf2jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzCV8p6Ftt2zp4gyu7gZkTcVvFueb2+A3sE++7FoTukgTL65qjj5AXfV2PlB6yaldEkILOWG8mwLi2GH1yzY5juBBMtksKBemF89uKwK6SvryF0KYzJgs9KnPZcTEquUV+As11+H71rx5t/40eSqmCsTIEDNigD/QNoUUM+Yxtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=DrDMPcu6; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="DrDMPcu6"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 667903F09D;
	Fri, 18 Sep 2026 07:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789715878; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=9qUr1LV8CWjtdoDUyhqFtHVCDXB6fURXnL18iR4Q5iE=;
	b=DrDMPcu6+VrSPkbnRj5PUfmgF9qWcYf39pVrau4IM/HPnsX/q5M4sfStQEZWagT+OYjv4+
	cEpEvAEJdDtMxKCMRiyTknxchoU4/6evSAHBuUD1+BILs9y+ZwCxbzQ57pgidhWMPLpuay
	5490lE4zBdziRSq/Ben6rYdmq/ue6w9Wo81leoeQ0wY2wqL5Vnc6h/ajEaNYMgzHtg0bl9
	FSXbFRsgiTl63veRmLHsqiagQj0bQmbXaeeLb+sUIfDqqt3hlZLwFVfPv3+utCY9f6Nk3J
	nNywIkUKCxUeSPru9N6FgDxQq9PORMokUMuwDePmSIS51Tc9W9cNm4RgXmkWXg==
Date: Fri, 18 Sep 2026 09:17:54 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Message-ID: <20260918071754.GA30413@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260915-wiznet-link-gpio-v8-2-d173622474cc@marmottus.net>
 <178967573088.22033.12415855189978378014@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <178967573088.22033.12415855189978378014@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTGMeemy83JBcSmIIQa0nTbEB9WWvLbOiWJ1uNkZWW3E6pqDUT8rvnRUTg7tyjD0NtGnxgHfqdUlQNBxHo+Ym6+fbMHaEbIheP2FQ1MxV7H5UdFEFhdvsvWWLrT8QgtvLkOnBmLdCu6q3gxVETUhDVI/3GCMl8Zvapm8viYHdUjSj9La3U14THUCaVAfK2CI2pAPef4FMAD1ZfuTaj5rXR0AuDWkM1RkhjWvy4nmvMpmQfmVGmzqo9ORwHzN+vRViM9IU1eDEmXHPQPVeqIbsWKji8Yi+645IdkNIaEawtUQgqJZB5ugIc90th7LXlsSE+suk/psQuCAgEh/OUmTC6a2Y7mIhjNU/cxWBrpS5xmkUmscjR6NQl+2E7+CF8aLrcJV6JBMjdMJBkd5MU4ccGWV24IIaHoSogAETPs2g2XArM+bwZV5XYb35V4LOtuWtrnyG3OmRcH0Nl5B1Ua7ap6/l0yVmJ1dDqrPRIru2C+GxfD2Rcyhd/vGfJNtLxWZ3j1YBN84F0VO0nEhFYkAKtBhq47oAOTmedQD1zQ6zuMJPtrmcyuWPNLzML7B1tQ9QgXBdY0P2sUcaaQ3yQ6+CVnO7qYAA2PZKi9xUtvTb2gB2TI3jtvzNz0I+VXDPUsZCsvyn7B7ICvVWBtBL406gexCEWBd+IIhh5EcHT61wOS78Q

On Thu, Sep 17, 2026 at 08:08:50PM +0000, netdev-bot+sashiko@kernel.org wrote:
>[Severity: Low]
>Is this else branch describing the hardware, or the current Linux driver?
>
>The LINKLED output exists on the w5100 and w5200 packages as well, so a
>board that routes w5100/w5200 LINKLED to a host GPIO cannot be described
>here:
>
>  compatible = "wiznet,w5200";
>  interrupts = <25 IRQ_TYPE_LEVEL_LOW>, <24 IRQ_TYPE_EDGE_BOTH>;
>
>The second entry is rejected by maxItems: 1 during dt_binding_check.
>
>The only in-tree justification found for the w5500 restriction is the
>driver gate added later in this series, in w5100_probe():
>
>  priv->link_irq = ops->chip_id == W5500 ?
>                   fwnode_irq_get(dev_fwnode(dev), 1) : -EINVAL;
>
>which is a software limitation (register readback of link state via w5500
>PHYCFGR) rather than absence of the pin.  Would it be preferable to allow
>two interrupts for all three compatibles and note in the interrupts
>description which parts can actually report link state, so this constraint
>does not have to be relaxed later?

The LINKLED pin exists on w5100/w5200 but cannot be reliably used as a
trigger to check the carrier state as it also blinks on RX/TX activity.

   Link LED
     Low: Link (10/100M)
     High: Un-Link
     link: TX or RX state on Link

Arthur
