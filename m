Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F543D9DA0
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340071; cv=none; b=dMDR4+NsBZqjwi2KgjSKKl+KjqLBtQI7fe450o8tvE5i4QIsCOEhFeEgFBstWEgIsfvTpIQxcH+SCdIehZN0yZO5pbHG9h+fH04Tou5SFrF22eZEmZ5SIPGYfm5cazvxv1t84o93a9cI00zY+SgLjyvL7X+hEaYLtIrnP2BfhFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340071; c=relaxed/simple;
	bh=56JhJ3kSovobXIzAI+79nECHLndUgUPFhOseXiIrZIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jy0OY3rMOhyCnxqw5B+JMIqSaxE2Rft7uU6JE3BeT0CMq5ODJaH7lEEEnRX9FWCWMX1oURGh4LYAyccho2xeJtDzyAKupIoUhdC3Wyes6P6anqYsRlgV1Y24JosBsEfZwtIEoeO5BcLbibMeE1DYr+Z/4BL0Y6GhSRSo7gI48/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q7aEkBZZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o31asT3l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q7aEkBZZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o31asT3l"
Date: Sun, 18 Oct 2026 18:14:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792340061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56JhJ3kSovobXIzAI+79nECHLndUgUPFhOseXiIrZIE=;
	b=Q7aEkBZZkX+hqm0sDm+FIi2x1kWhfGkDJasHtNyqnCdFItyaBQvqfjbcYomnTsWHwyurg/
	iK7bh87NOBj8WRPLfXGVd/qTf7Lr/SukWc6+FYwma3vruRBbKiakB1RlkMcJKcwnDwMVz1
	//BRJB9uqMvJ7B3bXDgE0D5BUazlgI7pG7oPwCUKyNs4wQPIlY5ysczuJPo7kWXxo2qMD4
	s1ruRENLpT2jRx0jWzdsVCUP3p5xsOlnt3Bn2s/m/n0d03b8ok3YuxR4TaoaSD8AFqHcSa
	cQTVvmPx2i2opcUOxAFC075Qa/jFgSKqD+TIhdZtwvBzLJNRsGxfYaOwXu45bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792340061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56JhJ3kSovobXIzAI+79nECHLndUgUPFhOseXiIrZIE=;
	b=o31asT3l0X1pbynmiKEDulMPcRJ5vO8rVgKM/QjChNasN78NcReySnWVwJDDeltdAFrCO9
	2r6iTphw/NSbtyCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org
Cc: "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net-next v9 0/8] hsr: Add additional info to send/
 receive skbs
Message-ID: <20261018161420.IEzribKh@linutronix.de>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>

On 2026-10-14 16:43:54 [+0200], To netdev@vger.kernel.org wrote:
> I am trying to extend linuxptp to support PTP over a HSR network.

Let me update the few things Daniel Machon pointed out.

pw-bot: cr

Sebastian
