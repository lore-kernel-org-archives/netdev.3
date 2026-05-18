Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E45272631
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132572; cv=none; b=fOVgPt/MFnq9nPGTtvmt9ZvftiRZD36qk2ZE5RAYXIDOJHyiXFYZg+EM9Hmiw2WPakMtpjibaOioBnC3tEnmeyq4d9plReoH/2ZUAqZireq4NTD/8T/pCkAlGQQO7tOGlURTVPSkArPHhcXIgHVamP7e0WTPFSSRfWOCsDh9zxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132572; c=relaxed/simple;
	bh=JDsdY9G1dQ/eZIXfsZCaSUIqdlqfJeWQa7KOUN08GEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6o1/zTMNo7gsD//tnmKQ0ZI+xvx6nUS8mSCnKNXR0tt81wE2yTycXqit0jr8zwji+IS97M+CCbtjVcjCL0qXsp1IAqlnKpv+q+yoTAtlfmQpWvyO5qFiK7HkIRGTSda2haPWyBTT3iz/l4eZvSbXQAMEtpswMDqiKQwMR/DNlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O88Q1p5R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ONecJMe0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O88Q1p5R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ONecJMe0"
Date: Mon, 18 May 2026 21:29:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779132568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glhxBV75c/mzW0CCe268K2hp2pJlAABlx8lXSFl9BD8=;
	b=O88Q1p5Rza+ecNiteSim+yLpexC2oNzFfJ1fNEZ0l0APTnNtL+tjeEaZjDqDmRZLnqM0zX
	MraBognbiME/nlyOsPXnDtYYQjsT4d8DKGj1CCvutXtDiiBrJLwn1MHgBIAwaLUjRTMdW2
	y3ESslmmOoOirTu93+j2tqcTl1YvO/tQc8edM1P4LvOhL0gzdjD6U22NugKU3OJZJfKpMw
	bDn6zQk+MkIxv3SwAyVET7vzWSgdzcpCrSs6EpwZzcZB4JAzPnj3nSTBE2/nsgmVOhJy+E
	Rwb8m94FuY/AZ/SDhZJV2ncLfGu4Be3stbnn+SjeJN60hUwyMnAe7De2ZC/nyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779132568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glhxBV75c/mzW0CCe268K2hp2pJlAABlx8lXSFl9BD8=;
	b=ONecJMe0yhCHWdTjWCL6cJgxAc+DXrTrlhwXiQyibVIm3sxQ1+qXcNHV0bnkltWjvw1yAZ
	uGfSowxMW6cmcHAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jayachandran <j-rameshbabu@ti.com>,
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
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v4] hsr: Allow to send a specific port and with
 HSR header
Message-ID: <20260518192927.5M3H_w4Y@linutronix.de>
References: <20260508-hsr_ptp-v4-1-aa19aa7c6a71@linutronix.de>
 <willemdebruijn.kernel.38ce4095cf2f5@gmail.com>
 <20260515151454.LJU-RugA@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515151454.LJU-RugA@linutronix.de>

On 2026-05-15 17:14:56 [+0200], To Willem de Bruijn wrote:
> > 
> > Need a pskb_may_pull before accessing fields?
> 
> I did check the size. Should I use pskb_may_pull() instead of checking
> skb->len directly?

This and the other things, I think I figured it all out.
Thanks for the pointers.

Sebastian
