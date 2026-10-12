Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5C489899
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809564; cv=none; b=nP5hnjaoi3AHgNH8Lfcl1jIY+3gMRibpkcmfFvBElabG2NVjnc7M0J9/AHsSju9FYzzzCwNcAN+TZMcAikAZJCYVXOerqjJWcyspl3B20ZQESqCSk86c2JTngjQVwRQy52Y42o4U7EYcYx1CRV5DdqGSrPbnmY5o0NA/MXvyM1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809564; c=relaxed/simple;
	bh=pnSQs3hRZcIb4/Hu2Ve62mMiYEjj8nVNFxy28PeYRT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL3HAIb5uYFNLBOK2rim7myXse5zpDGLxAiZuU7q1EahBCq1WNgl9e25nW7nC1S5PEEPxbU4iWcAidVhNkYRprhWnB9PDxvLNiApMi6zBz3iP0VHJZHVVONe7fDUIQ/8seFkyorA9wAVGa7yVUjDPo0XYyAD5l+W7Nm8rooJ1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=elge/06j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w3YL00Us; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="elge/06j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w3YL00Us"
Date: Mon, 12 Oct 2026 14:52:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791809560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a8oUwUfLmxUQ/NbGTjJH+pFwXbzrMqSwIfs9wrUHxEc=;
	b=elge/06jdBgZNUBffA4E8lUCJrbpUYPXftloFKIF+J2mys/76YR/dtSfF361rA6R/yqaxs
	WeiAu2KPaTZ/9RUtk+VllyBkT8B//hQ4v/S/uIpdo0fGAr7kUM/dbKLjQvvSbDqzVBc1nu
	krgivqkfvNyUy1UFRTPA76sqAqEIdas42n1+MjXnEBfK7tTTVQXZlPMa5caaekSnPnjq4r
	1vXD4g9xrBN6JaIJBNu9NTb878d8eaUQ6m2nZvO7ykntXbi+/L8JPpLbSKeezAoRNr9iP4
	B9/xOVO0r1XzZmIVhyKWdY5OKWi4ssSEQWsQnnrRF8DJDmT2nOS1hP8Nwk2XQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791809560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a8oUwUfLmxUQ/NbGTjJH+pFwXbzrMqSwIfs9wrUHxEc=;
	b=w3YL00UsIjhY/JNxNkRRjWd6a+cOXKrnaI6FQkyynB4/cjowCPuTlnhX3++qCL24GeV9Vy
	NsnyIYu4KtaL4oCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev@vger.kernel.org, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v8 0/8] hsr: Add additional info to send/
 receive skbs
Message-ID: <20261012125239.Jj4ToyNY@linutronix.de>
References: <20261002-hsr_ptp-v8-0-60dabc07e554@linutronix.de>
 <20261005121645.kfcnbceg3viayccr@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005121645.kfcnbceg3viayccr@DEN-DL-M70577>

On 2026-10-05 14:16:45 [+0200], Daniel Machon wrote:
> Sebastian,
Hi Daniel,

> Do any drivers need to be updated as part of this series?

Only in the offloaded case where PTP is intended.

> A number of drivers offload HSR duplication using NETIF_F_HW_HSR_DUP. For a
> directed PTP frame the HSR layer only sends it to the requested tx_port, but
> that is undone further down the stack (e.g. dsa_xmit_port_mask() adds the HSR
> partner port back, and icssg sends it as undirected), so e.g. a SYNC frame sent
> to port B would also leave on port A. Or am I missing something?

Before this series PTP did not work with HSR/PRP in a meaningful way. I
do have here icssg patches but there is no DSA involved. The icssg
driver tells the firmware to not duplicate "this" packet (once it
figured out it is PTP and it does HSR ) while sending and the firmware
needs to avoid automatically (as in cut-through) forward PTP packets it
received on one port to the other. This also requires firmware updates
if I remember correctly.
So yes, these changes need to happen if support is needed.
Looking at dsa_xmit_port_mask() I think it should not add additional
ports if it is a skb packet. It feels like you could avoid the loop if
HSR is not configured but enabled by add an "if (_hsr)" to
dsa_hsr_foreach_port() before the list_for_each_entry() loop.

There are also 1step capable devices which write the PTP timestamp into
the packet while it is sent. This won't work if it is not possible to
adjust the offset due to the HSR header.

> > This has been tested in a pure software environment and in an HW-assisted
> > environment where the HW is able to duplicate and duplicate packets
> > but does not do it for PTP packets.
> > It has not been tested within an environment where the HW is able to
> > forward the PTP packet and correctly update the timing information.
> 
> We support PTP over HSR downstream on lan969x and lan9645x (with a different
> uAPI). Maybe I can be of assistance testing this. Let me know.

Sure. I posted userland patches for linuxptp but didn't get much
feedback. I have the feeling that they wait until the kernel part is in.
I make a mental note to put you on Cc: once I repost them.

> /Daniel

Sebastian
