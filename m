Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97839C011;
	Thu, 19 Mar 2026 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948862; cv=none; b=ZzCmwdlwjYnFJnpG/OwXpQspPLlFOY+MdUPqq6ah0v8Z31hOgPwzb9ZqSsiJCGKb6GfDqKwzR4D7IkrdXkyvUT/AlvdGn0T6LXsbKzXfxwsFV4pFfCT4aX/5j4hGwHOAAwshFcB48shPJ3nlsYSkq6YCLrhlvqIcDZKS/Rv2FPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948862; c=relaxed/simple;
	bh=mjxUWXDZK80V25cp2I/yJyEECs4pfxIzuYFdqW1vVFg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ffo4yhgIYmKbWbaQAjZOyZZDJZyiapdN6OCDEh+Y9/5Ng3oO6Acxp40esr/6u9jXHBVWbTA3cnYqEd7UpKCm7JNJMSIU0hkad/lFbQmAOnekxdNjwwxh93/1iopXBN4V2hlYQag4CLlc+tUG8CsfYtN8YNBoCGIkw3Abhz5ciH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A5MtX2Mr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A5MtX2Mr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773948859; x=1805484859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mjxUWXDZK80V25cp2I/yJyEECs4pfxIzuYFdqW1vVFg=;
  b=A5MtX2MrrOArXdk4xeR/i6vEzJUspdUUhZ59bXCxrzUBFsrQTkPfmlFw
   SgOH+qoypFu++DeJgkDv0b7m1S708vD4yejuCh9nuiSIOP217uoVW5MSJ
   XhMhlUbsK8dKoqM5p1FRqJEahYRAeZFtCYGfiZMQfQGW1LcyoWvpBwjz2
   D6LOeS1HpRFa653zxCb7LtyYCA9bov6WnELZXK7wjFMG7d3XBPSvp/V7q
   hBpYP3k3/FXJy35efeMHB3duV+DzElOd26C4J+QqehERjf2WY1VBfFwXu
   F2STAojxGFegT8lVwes5ZM5EWk5dG0vyNsuosTVFgOmTojgvx8nf88H+C
   A==;
X-CSE-ConnectionGUID: efHJ93C/Tr6M9PTXKPS65w==
X-CSE-MsgGUID: WeADiobLRyqMaiK7W0DnDA==
X-IronPort-AV: E=Sophos;i="6.23,129,1770620400"; 
   d="scan'208";a="62585084"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 12:34:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 19 Mar 2026 12:33:47 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 19 Mar 2026 12:33:45 -0700
Date: Thu, 19 Mar 2026 12:33:43 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: mdio: add a driver for PIC64-HPSC/HX
 MDIO controller
Message-ID: <abxPl3wg5WCBY+hJ@bby-cbu-swbuild03.eng.microchip.com>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-3-charles.perry@microchip.com>
 <c1e28c56-70b7-45b8-a43d-21aca1942764@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c1e28c56-70b7-45b8-a43d-21aca1942764@lunn.ch>

On Thu, Mar 19, 2026 at 06:03:09PM +0100, Andrew Lunn wrote:
> > +	u32 bus_freq;
> 
> > +	of_property_read_u32(np, "clock-frequency", &bus_freq);
> 
> clock-frequency is not required. So this can return an error, and
> leave bus_freq untouched, which is a stack variable with random
> contents.

You're right, I'll check the return value.

Thanks,
Charles

> 
> 	Andrew
