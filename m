Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74A94F5DF7
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416833; cv=none; b=s/Wpqeb5wNegLwQIz+V0olF4Y1ksCMtJL4FkHUQQ0JDnQ74hKFOpxjpC7cMwaaydZcN2zxEz0oGvBecKl92pCZOVPT2PvLcbN3R0pz1g/uCE0MtoB9fTfkk29ZYciqxzgp+nF5nwHaAPUf4UFz4c1qmF0SpccT6W+LQuley9h/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416833; c=relaxed/simple;
	bh=EvuQ5/ZmAOkpURpwGLFG8ZUesxUOZy5+XlwsFsXO7Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eih5n31/gDs6gN99N0qB6TyC/mGgzuT39vbkeLgwGTdaYgJ0dVVT3Maem61hdpaZTacYwBdN1uLwNQ3QWdhQE9E9js7iG68IuODPVXDGCG96TU9hIyXzgtk5W3GS0S1fgbPxZbJp+7q8iUOjPpsawgvcYl7menYJCrMsSurAsUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bbgT4HHt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EYzJeIA5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bbgT4HHt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EYzJeIA5"
Date: Mon, 19 Oct 2026 15:33:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792416829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qnq+bsMRivn1fuUpeza/2gvb0so3pEDLMOaIAJ1Ax4Q=;
	b=bbgT4HHtB7bx94a6uCMMIYXeWYpP+7rKPi68PLCxMhNIO65pwsGBXSv5mz/mrh9frJQ4z1
	brscXg6CvB9AFrmq+hP7mqNf33Y8uYTlSgmYUiv2tOWJa389w5YQZmN9H64smq+gKXXxc0
	cQyxilNOkz8xPMw69NHSmjATQIujFhs267wayCwcdJpgajzmXSL6OxCzlrj7j9dmz8Li9g
	VMaKjvuAQMTPwqDwXOKzTDeqWS0OfkpMACYgsKoqVI/6rMTiWmPdmpCKKdXxDlmtAt4Qso
	nsdPBieU+u5uz02zsZQ/i2gNJwsaXunfQpSM4aChZcPCAKrvTlYN63R0Ip+PRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792416829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qnq+bsMRivn1fuUpeza/2gvb0so3pEDLMOaIAJ1Ax4Q=;
	b=EYzJeIA5gaLHrYHaSBsb/qyJ0sugYa6v65tMTApB1yUpNTwJIw2Vds+61mceM/uU5s2Unn
	zjXHKG4HtffPVICg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev@vger.kernel.org, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
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
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net-next v9 2/8] hsr: Use skb_clone() while adding the
 HSR header
Message-ID: <20261019133348.Mp_8923i@linutronix.de>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
 <20261014-hsr_ptp-v9-2-2d20a2a0f816@linutronix.de>
 <20261016090940.a2ztkv6p3wtysk57@DEN-DL-M70577.microsemi.net>
 <20261016094118.Mq6pgtly@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016094118.Mq6pgtly@linutronix.de>

On 2026-10-16 11:41:20 [+0200], To Daniel Machon wrote:
> If this is important, I could add to the patch description. The removed
> skb_reset_mac_header() should be obvious.
> The csum_start() removal and so on was mostly sashiko complaining about
> one thing at at time and memove() got replaced with
> skb_postpush_data_move() in the last iteration which I just learned
> about myself ;) That looks like a nice clean up.

Updated as:

| hsr_create_tagged_frame() creates a new skb where the HSR header can be
| prepended via __pskb_copy(). This does not copy the skb_shared_info part
| of the original skb so any timestamp request is lost.
|  
| An alternative is to use skb_clone() where the skb_shared_info part is
| shared and then skb_cow_head() to make the header part writeable. This
| avoids touching manually the tx_flags and tskey members.
| Using skb_clone() allows also return early (after the clone) in the
| offloaded case so this can be unified a bit.
| The clone case does not need manual adjustment of sk_buff::csum_start
| because by using skb_cow_head() the head does not move relative to the
| payload. Should the head need expansion then pskb_expand_head() will
| move it and update sk_buff::csum_start accordingly. The clone also
| preserves metadata (if available) so skb_postpush_data_move() is used
| instead of memmove() to move both. Finally skb_reset_mac_len() is added
| to set the new length of the header after expansion.
|  
| This is a preparation for PTP handling where timestamps are requested.

Is this better?

> > /Daniel
> 
Sebastian
