Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D963D3CE4;
	Thu, 19 Mar 2026 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939800; cv=none; b=TAzsoUsXwOu/a7AJx1aW3Gg24f6QfBd5FyuBfJFbTgJJHWp20/7ueIkdDPtELt96XczHDifod+ahIH+Td3+3VBAs133Y62nRuulTngmpkLU1/TS2ssXWUGRUK0hFLb4eHrds+poMOP25P8oQKf3CrU+kpHX4XI5CpHNhjyPqg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939800; c=relaxed/simple;
	bh=H6mbJkD4bY73bkEnSvHAiPbJH+mnQLOf3o9uaqpmHDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCcTTO9RVBvnQiX8TmaauY27Pqhkdm01UsuPvBSkXXUAP5QLW65aXW3UwiIR8K+Mnm1WgLAmuRTAoKXp/d/3oMJpfCIGhZC4fVigGIQOg/YooEJJIyojFca9z9uk14yx+8wFPFF1l11jUuBUZC37S8CiFfP6gymwt/mnmU3XM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6HZCgH1V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6HZCgH1V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mIj9dM4yySJHztmJxGxux7K0mwRPGPNHgYqFd1tuVmw=; b=6HZCgH1VXO9zOTio/h4jSeVbYE
	cyjyrjOaH2Tar6wpfXCLqFZPtMXwVWd+f1P8HgaLDa9Y7egINePeGKSNPH2JvZe3HE/PtKv0RiNOg
	ZyQqqGYpkJFnq3bBzRBypnNQGKc/TuGXMjilCP6N1UdA9ZWUE1l7RDmc1jnoWR8RDlRo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3Gm5-00CQAH-4W; Thu, 19 Mar 2026 18:03:09 +0100
Date: Thu, 19 Mar 2026 18:03:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: mdio: add a driver for PIC64-HPSC/HX
 MDIO controller
Message-ID: <c1e28c56-70b7-45b8-a43d-21aca1942764@lunn.ch>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-3-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317184610.315852-3-charles.perry@microchip.com>

> +	u32 bus_freq;

> +	of_property_read_u32(np, "clock-frequency", &bus_freq);

clock-frequency is not required. So this can return an error, and
leave bus_freq untouched, which is a stack variable with random
contents.

	Andrew
