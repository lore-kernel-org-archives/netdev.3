Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE07C4534BB;
	Thu,  6 Aug 2026 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029946; cv=none; b=KYPU9oUGQ5d3l1Pfz7CfTpx4anCTtUXFluTYo4ghuA7i4UtYOZ5PBtYnKODRZNhI+dV5bBaJijk9lzK7LIS7l+vMo7tTXxV+SjG2WDoAn65sOfa9Y6+J3Vghwhj8HRrrUNCRioN2myEQikZMGyFDjwZsruxurMPTpK0AuZbNqQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029946; c=relaxed/simple;
	bh=6ZmyFdti4jUjXxdahptyIuC0nIWw63KYauFtkrL+iTA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gc+PwEDO8nHJcToOrsxn+aj565ahtLr6V4VpOMNCFSSzp5DqrxBntG1deUl+sov6XM1lOt7cz0Z8aajMS0ZNHUlFnFJPQbdRs9HkDEzbyDNo+3u4ONVMEdqTBOWfUQpTGarF3h604ylWv22X9KTa3S56A1ewRhr36Jw+/1XpBmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1SHe8hNs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Na0ofr4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1SHe8hNs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Na0ofr4"
Date: Thu, 6 Aug 2026 17:25:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786029942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpfdccAUVHz0tdtPTBfIMNzx7scFBPZBXLSSy/lEYpE=;
	b=1SHe8hNsEiu5ukMZ6FiR9tDPnb5wfN5Ovwo551qPZB2fu64CVBv+BXiZ1jbjt8Yux5PqeY
	2DzfWcjEp3KFd8UeaLv35s9IcX/vprgE+cPCmvz7LCXlsldlJbOKde4JMt6VUpbw23piIs
	b/uM0Z1ui4EFbaVg6hbu5WzOedAqSXJdD9MPGPLDWHhRi9la7oZUUK0zGqWQtT0MupELSL
	MCa6TmfqAowAzqJDTKZjM1CEAqOGZpywvYYggFAszchgHQxu8PWubRT08Dz+Ikjd7vA1Ex
	ARdp4gA1NX0bAzQE4U3tAZk6DpKJ1Nc7Ed6KVPqvx3bMn3vTPjFFzHJDuocOwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786029942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpfdccAUVHz0tdtPTBfIMNzx7scFBPZBXLSSy/lEYpE=;
	b=3Na0ofr4Im3AR5eD9a48+BM+33OP2k3Nfr2kGluGXN6CsxEfOJWrDRaFDL33k91fw0M37e
	mnMs0Hj3pcLPbkBQ==
From: Benedikt Spranger <b.spranger@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vasilij Strassheim <v.strassheim@linutronix.de>, Krzysztof Kozlowski
 <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Martin Kaistra
 <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
Message-ID: <20260806172541.009f1295@mitra>
In-Reply-To: <b47e0589-a3a2-4f88-ba90-72d176efccd3@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
	<20260730-loutish-labrador-of-joviality-6e6c79@quoll>
	<411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>
	<590a933f-85af-4eaa-b9ee-be689dc15c69@lunn.ch>
	<20260805153220.3860b262@mitra>
	<9f8ac30b-6579-4e48-abe3-823302a3da0e@lunn.ch>
	<20260805162705.1a3467ea@mitra>
	<b47e0589-a3a2-4f88-ba90-72d176efccd3@lunn.ch>
Organization: Linutronix GmbH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Aug 2026 15:35:36 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > The minimal IP core is an unmanaged switch. No need for a DSA driver
> > here. The IP core profides a MDIO bus, therefor a MDIO driver would
> > be good. The version register in combination with some feature
> > register can be determined to get the needed information to
> > configure the DSA driver, or in the minimal case to return -ENODEV.
 
> I think you misunderstood my comment. I expect the MDIO bus is part of
> the licensed core.
OK, I did the second step, but the first was not clear, so lets do some
ASCII art:

                     ---------
               S_AXI |   S   | port_0_gmii
              clk_in |   W   |     ...
               reset |   I   | port_N_gmii
           IP_enable |   T   |
default_op_mode[4:0] |   C   |
         port_0_link |   H   | port_0_phy_rst_n
             ...     |       |     ...
         port_N_link |   I   | port_N_phy_rst_n
          S_AXI_ACLK |   P   |
       S_AXI_ARESETN |       |
                     ---------

The switch is connected through an AXI Stream interface i.e. the memory
interface ==> Device Tree binding needed (Base Register)
Other AXI related signals are hiden and need no device tree
representation.

The switch has one mandatory and 6 optional clocks:
1. System Clock / clk_in (mandatory)
2. AXI4 Lite Clock
3. AXI Stream Clock
4. port_x_ref_rmii_clk
5. PHY RX Clock
6. PHY TX Clock
7. Port_x MDC

Here are all Device Tree bindings optional, since the mandatory clock
can be provided by some not exposed internal clock signal as in our
case and the other clocks are optional.

GMII ports ==> The ports are defined by the DSA bindings.

reset ==> optional GPIO device tree binding

IP_enable ==> optional GPIO device tree binding

default_op_mode ==> optional GPIO device tree bindings

port_x_link and port_x_phy_rst_n are signals to the PHY ==> mdio device
tree binding.

> So when you take your FPGA design, and delete the
> licensed part, that disappears as well. When you delete the licensed
> part, you should have a big hole in the middle of the design, leaving
> just what surrounds the switch. That is that logical? Clock dividers?
See above; hope that helps.

> Logic to map the switch registers to MMIO, so maybe a PCIe device
> core?
The AXI bus may connected to an PCIe bridge for example. In our case it
is connected directly to the SoC ARM core.

> Does any of this surrounding logic need software?
In our case: No.

> If it does, that is probably specific to your design, and needs a
> compatible which covers both the licensed switch core, and the
> surrounding design specific logic.

In our case the clocks are routed to fixed clocks, which have no device
tree representation. reset , IP_enable and default_op_mode are an fixed
levels.

Therefore no need for a detailed compatible string and no optional
device tree properties. Clean and simple *knock on wood*

Regards
    Bene
