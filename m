Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D983D812C;
	Thu,  7 May 2026 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154327; cv=none; b=t2aXhxx1h9trNdniZdeZgDnLch7rNp87T3Qd+b76Un8BT/KWEd1WPE22cTAKzvIyeugzCd3Gm3l8wNjRzDEVOrbGkTCSZhGvV46PE7CPCJfIUqeQQ6qgwqk5QU+f8BpNgoQN4ggEkzP//tJtKCJp/7S4voiAfGF581letJzwyOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154327; c=relaxed/simple;
	bh=y88ANMEB1Rz96O0OTRK0xxZCVFv7ypteibGlSq5EQks=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=brPyksKMI4bY2cU9XOxg+f37JW0U5BFBBwZGR9hUI6CEYcgdjcvq7PAQClPKfOdraV1KoEJ7HJcPf8xsts0WpJ2pwQ5Zmpca6ibjArgjri/Wmu61WIh5p9OvDugG4HWZFIp+TlJsd17tpXj8LNMp54kMPlcBRY8ZjzIVDJIvXNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 4E42692009C; Thu,  7 May 2026 13:45:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 4B0C192009B;
	Thu,  7 May 2026 12:45:22 +0100 (BST)
Date: Thu, 7 May 2026 12:45:22 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: netdev@vger.kernel.org, linux-mips@vger.kernel.org, 
    Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] declance: Remove IRQF_ONESHOT
In-Reply-To: <20260507073427.atoJ5zsY@linutronix.de>
Message-ID: <alpine.DEB.2.21.2605071211350.46195@angie.orcam.me.uk>
References: <20260127165430.7ui_LGkg@linutronix.de> <alpine.DEB.2.21.2601271739250.40317@angie.orcam.me.uk> <alpine.DEB.2.21.2603292037020.60268@angie.orcam.me.uk> <alpine.DEB.2.21.2605042332070.46195@angie.orcam.me.uk> <20260505072954.Ov2t-FGt@linutronix.de>
 <alpine.DEB.2.21.2605051233210.46195@angie.orcam.me.uk> <20260505123203.jifiaxEL@linutronix.de> <alpine.DEB.2.21.2605051410280.46195@angie.orcam.me.uk> <20260505152450.1KYVS2pr@linutronix.de> <alpine.DEB.2.21.2605060040230.46195@angie.orcam.me.uk>
 <20260507073427.atoJ5zsY@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 7 May 2026, Sebastian Andrzej Siewior wrote:

> >  The interrupt is exceedingly rare, I've only seen it actually fire maybe 
> > a dozen times across all my systems in 25+ years.  It happens when there 
> > is a memory read error on DMA, such as an uncorrected ECC or parity error 
> > (depending on the system variant), or a bus timeout.
> 
> I assumed you have other interrupts on that hw, cascaded/ operating the
> same way. But otherwise…

 Hardware does have such stuff, but we don't make use of any other sources 
right now.

 We don't use DMA with the SCC serial ports -- I've had plans to wire that 
even for asynchronous operation, because with the 3-entry only input FIFO 
it's quite easy for characters to get lost at higher baud rates; we have 
no driver support for the synchronous modes with these systems although 
hardware has all the necessary circuitry and external port connections.

 And the driver for the ESP SCSI interface was sadly lost in a conversion 
many years ago when I got stuck due to a peculiarity with the hardware and 
never completed it, which is a shame, but there you go -- I still hope to 
do that one day, and that I consider much higher priority than DMA for the 
SCC.

 Another system model, the Personal DECstation, also has ISDN and sound 
interfaces wired for DMA, but no driver was ever written/ported for either 
and no one running Linux seems to have a specimen available anymore.  I 
think NetBSD guys have full support for that system.

 So yeah, right now it's only LANCE that makes use of any of the DMA IRQs, 
and it's actually the least complext arrangement of all the devices: LANCE 
makes use of 1 DMA IRQ, ESP makes use of 3 and the SCC ports make use of 4 
each.  Each has one IRQ dedicated to memory read errors, and ESP and SCC 
also have one each for overrun errors.  The remaining IRQs are for regular 
DMA operation, i.e. buffer flipping, which LANCE does not do as it makes 
use of the usual DMA descriptor ring arrangement instead.

  Maciej
