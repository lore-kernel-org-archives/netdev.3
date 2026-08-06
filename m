Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D65C383987;
	Thu,  6 Aug 2026 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023357; cv=none; b=Faq+HFnVn3+oruvCcLk0K2uRcPEdzZWrFfC8n2auidg4vUtfdBZKJkuqf/EjcGk84LUKU6aTNuve1A7La1HzyZX7brbnO1lFjjKgtYEuEgc9jwz+Hn5EismWIC+DiQPrvnlbcPU43r5Oez7vMTr8AbRFSaVuPFQ+iakywlIeDkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023357; c=relaxed/simple;
	bh=KRYUIXbWpXe85W6pY4Oe5fd1QED4PCEDPNzBmk7DZ+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXODjrd0jA/AY1lgAxV0MhWTL2/TeUQnh58QdjZHxdLB1xo4376oSworCyGzjhkT6w7zEBeBthtIhdJDi5tAMCi2eQw3QBZArv+JRZHf/G4gyQolutrtHrYuTf0gNQC5ak9NQthR5fovP+9tUV5mZaohzzhUjd5ex+hRlt6bnGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u1Efov7U; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u1Efov7U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XlP+tUjsmu3AxOdXxNXi5cm6k+5WijPQpXHUrFwGtBI=; b=u1Efov7U/eclQ717qAmFBj7B/W
	sJ36GpS+bBcIq/hP3r3S6JO3HqMRDzWDvi1mwAQagxL/TNVK5dwzZ4ngVy+d+rRjJwYkpuFAQaXnD
	uCMkrfWWw/RmoGsVIfp14CQYTgXgi2JJq68Kc2kIH1aqIrBRXOr0vQ+HeLdu9B8Ypyus=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wryG0-00GNp2-2L; Thu, 06 Aug 2026 15:35:36 +0200
Date: Thu, 6 Aug 2026 15:35:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: Vasilij Strassheim <v.strassheim@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Message-ID: <b47e0589-a3a2-4f88-ba90-72d176efccd3@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
 <20260730-loutish-labrador-of-joviality-6e6c79@quoll>
 <411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>
 <590a933f-85af-4eaa-b9ee-be689dc15c69@lunn.ch>
 <20260805153220.3860b262@mitra>
 <9f8ac30b-6579-4e48-abe3-823302a3da0e@lunn.ch>
 <20260805162705.1a3467ea@mitra>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805162705.1a3467ea@mitra>

On Wed, Aug 05, 2026 at 04:27:05PM +0200, Benedikt Spranger wrote:
> Am Wed, 5 Aug 2026 15:53:59 +0200
> schrieb Andrew Lunn <andrew@lunn.ch>:
> 
> > So i suspect you will need to support integration specific
> > compatibles.
> 
> Me too. But for *now* things are, better seem to be, simple. The aim is
> not to plug forseeable future development.
> 
> > One way to consider this. Look at your FPGA design. Delete the
> > licensed core. What do you have left? Does it need software to drive
> > it?

> The minimal IP core is an unmanaged switch. No need for a DSA driver
> here. The IP core profides a MDIO bus, therefor a MDIO driver would be
> good. The version register in combination with some feature register
> can be determined to get the needed information to configure the DSA
> driver, or in the minimal case to return -ENODEV.

I think you misunderstood my comment. I expect the MDIO bus is part of
the licensed core. So when you take your FPGA design, and delete the
licensed part, that disappears as well. When you delete the licensed
part, you should have a big hole in the middle of the design, leaving
just what surrounds the switch. That is that logical? Clock dividers?
Logic to map the switch registers to MMIO, so maybe a PCIe device
core? Does any of this surrounding logic need software? If it does,
that is probably specific to your design, and needs a compatible which
covers both the licensed switch core, and the surrounding design
specific logic.

	Andrew
