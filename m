Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC1149363A
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817411; cv=none; b=KGCCksjh5Yx2RfNomMrcNufy5TSPtI8dQVLAsOFHUIiMiv+u5MRsH4o3gePMFUDPaEbm9a8RoPyPtoeg4rWmjknuYnwt4K7BOXC82xtf6e3AlnAseC6N3DSkF6Hrdof0lD4Sdx36AQ9Q4WqPhFhb7zOdt78GWsZBOT+aW9rpyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817411; c=relaxed/simple;
	bh=VRPCFC2K7YxHlV93gUE0PcTL4lpH7r/Q8ZbdXHcnU+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfwrFf3PKVJppP7KIeIIhBwkul0OWlBCUHPG6nZpZVKGRKlloiXv2dlv9Kb3ITo3BKC7weFwBIp+0HOfOXXJI1o8W9c1k8aMcl/jLzuJ5lVuz1Lg1+h0WpT5urx0k61arKXJLMw7lvul9Ro+/T9jncTwJA5r9Vs4cznjwSc6udc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N972de9u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rEtO+1vJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N972de9u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rEtO+1vJ"
Date: Mon, 12 Oct 2026 17:03:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791817408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kzDEXNkTU/qRVrG5He5x4EzP3MIDqGgFo0zhmDlNxQc=;
	b=N972de9uh57AWya3JNI+Oki4NAU9LLXLV9nPz9pgiZRtILIFFU8NbzFH4OQKw0+rdbBHqS
	g7VqOfkB09WyYBOAng8qnXFnfLZOJEz7YOLHIIkMDyCjw06XVW0nDsCKcxMkFBHWp43yFr
	3k4rDxTLM7OjTUo9IKEfbuEca3KI2LVqjOLlhWyy8HLAAqnMsicAi6+A6zBGMPg6VCydUV
	Z4of8iyaqhyxISdTXMjMRKQLT/KlED5NPGgb7DR81AtkO7wB+CyYi23KXXV28RQ0FJkkj8
	jP3n1I3VyCgjnvtuNXJsoEpHPpmfRTbvU/6sokNuFKz5KbtRHFg2yMfQK6LhyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791817408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kzDEXNkTU/qRVrG5He5x4EzP3MIDqGgFo0zhmDlNxQc=;
	b=rEtO+1vJqjFhRzYP4aAVAH7+8YcHidjIW7mSY+kmXXmQrjLzdA1kGgetZCfRDfN+AjN5Jj
	pxWzH2IkDy7G50Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
	c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com,
	davem@davemloft.net, edumazet@google.com, fmaurer@redhat.com,
	kuba@kernel.org, neelima@ti.com, pabeni@redhat.com, praneeth@ti.com,
	pratheesh@ti.com, richardcochran@gmail.com, horms@kernel.org,
	vigneshr@ti.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v8 5/8] hsr: Use the port and header information
 in hsr_forward_skb()
Message-ID: <20261012150327.EafuO1XK@linutronix.de>
References: <20261002-hsr_ptp-v8-5-60dabc07e554@linutronix.de>
 <179129707887.434549.17889821067161034900@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179129707887.434549.17889821067161034900@kernel.org>

On 2026-10-06 14:31:18 [+0000], netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> Does "deliver it only on the requested port" still hold when the slaves
> have HSR hardware offload enabled?

No, this is software only. Driver with HW offload support enabled need
to be adjusted to support PTP without duplicating packets and so on.

> [Severity: Low]
> Does this clone lose the socket ownership of the original skb?
> 
> __skb_clone() sets n->sk and n->destructor to NULL on the clone. After
> that, hsr_forward_skb() frees the socket-owned original:
> 
> 	kfree_skb(frame.skb_std);
> 
> That runs sock_wfree() while the clone may still be queued on the slave.
> The socket's wmem accounting then stops covering the in-flight packet.
> Also, skb_tstamp_tx() sees a NULL sk, so the PTP TX timestamp never reaches
> the sender.
> 
> A later commit in the series, "hsr: Assign a socket for cloned skbs",
> seems to fix this. It adds the following to this branch, and does the same
> for the req_tx_port case in hsr_create_tagged_frame():
> 
> 	if (skb && frame->skb_std->sk)
> 		skb_set_owner_w(skb, frame->skb_std->sk);
> 
> The old path through hsr_create_tagged_frame() also cloned without
> restoring the socket, so this patch doesn't make things worse.
> 
> Could that fix be folded into this patch?

No, I want to keep it separate. The skbs are simply cloned, preserving
as much data as possible and later the socket is wired up. This is
primary to get the timestamp to work.

> [ ... ]

Sebastian
