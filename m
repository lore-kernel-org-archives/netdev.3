Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE158175A72;
	Tue, 28 Apr 2026 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777358593; cv=none; b=h3T+9qEnyUKRQO3z2hts/rgX4kZFUvja5sbH/zm4ER4OQRjISdiQd2KbkpqQ6LQxim0Kl4at5/PJ1H4YMU0lhy1xDEXkeMmwulvVz5Z3fnMoIlBCq3E5kIanCsfUGw3jGbq5r84ZFvKI1ijgRWfcjFpmBOC+pd3gnkhe/vQ+n7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777358593; c=relaxed/simple;
	bh=16TT7nFpQjoCc85++7ocnxKHeHKVm82G/ZFXyBMPiYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATUn5f4bKYfXYMQ2Z+ogwwY+kU/BBHeqDBXVaBF5s/fFSHhRLIFYeIXjWP3XXa3MoRGJGiZDGvs81Fp8wcJtVbxP1lF/0caTzBY970fmNQQH0fIx0IUNpsTQFXEVB6GQSYe3xVsqaBjiGfMbCwTSRWQIqSWdhfESj8q11QR4OPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AQ4UevR8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q5iY9kT3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AQ4UevR8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q5iY9kT3"
Date: Tue, 28 Apr 2026 08:43:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777358589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Qx9Swifn2YWGdVHmzJV+HoETG++IwApZjDF+DjL3RM=;
	b=AQ4UevR8m2yIGTpEBu0I1qMZMEp6ntoyl1AHA1krrYjuHhVzxHbOs/4cR9pQUa/vKga4Mf
	7pccAhHp9svSA6zX2OahC62dYyEd+PmsCJ7SwljZcKOzpUyNn0kLe5J0XFAT/sJxYOB+Zo
	+5LnxtJf1gj9nrZLTjRTNHCn0PG0JsWt++tuztNgnLo+H/cR9KzZrReF/z9+hd2Vebm4zU
	fNFg2nF3jcriTXwP5MORj88tUBJ5PkyS2G0SXQZKRpsWv738AaZN8FS0iW+SpdyL36m+Gd
	1oVp6N92mkkOOXCEVAXtafEbvIyA0xhvm3QCPUG0M45Tdlu+4SJ/zD0jWWtE8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777358589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Qx9Swifn2YWGdVHmzJV+HoETG++IwApZjDF+DjL3RM=;
	b=Q5iY9kT3Dc5ifvgk2NF3buz2fPZbqEaTlpOdUGvKwJfVL3YuFGt2xgi77++vsYtoTKTJZw
	S1aXi1s9kpZiUrAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Guillaume Nault <gnault@redhat.com>,
	Breno Leitao <leitao@debian.org>, Taegu Ha <hataegu0826@gmail.com>,
	Kees Cook <kees@kernel.org>, linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ppp: consolidate RX skb queueing
Message-ID: <20260428064307.uVnaImkV@linutronix.de>
References: <20260428024426.48605-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428024426.48605-1-qingfang.deng@linux.dev>

On 2026-04-28 10:44:23 [+0800], Qingfang Deng wrote:
> In ppp_input() and ppp_receive_nonmp_frame(), received skbs are queued
> for userspace delivery using the same open-coded pattern:
> 
> 	skb_queue_tail(&pf->rq, skb);
> 	while (pf->rq.qlen > PPP_MAX_RQLEN &&
> 	       (skb = skb_dequeue(&pf->rq)))
> 		kfree_skb(skb);
> 	wake_up_interruptible(&pf->rwait);
> 
> This has a potential race: skb_queue_tail() releases the queue lock,
> then qlen is read locklessly before skb_dequeue() re-acquires it.
> Another CPU enqueueing concurrently could cause the length check to see
> stale data. This race is benign, as it only causes extra skbs to be
> freed in the worst case.

That is not that bad. You could use skb_queue_len_lockless() to make it
more obvious. However, if thread A enqueues packets and is below the
limit and wakes the reader, it could enqueue more and which point it
will check the limit again. I don't see a problem except that the reader
may get more packets before the queue is trimmed. Again, not an issue.
It is only here to prevent a large amount of packets if userland does
not read the queue for some reason.

Merging the two instances into one function would be nice but there is
no need to complicate things.

Sebastian
