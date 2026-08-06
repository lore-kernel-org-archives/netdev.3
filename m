Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8463C1405
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042171; cv=none; b=dfwWGmlI07nCMSy/H1WA1xh5InC9JS+wdeKb74i7HUAlfu85Mz4WRJfLvE4g8iaWXK0N3AvUVlH7VSaTjKhi6Xl7no+elXuPaeA4bm2XWTTyp8wzClCHbsCpoGknNLxeO7h4Kq0G9kHoXW21tlSbQl+EyjBjN9+qsbMr+He6xac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042171; c=relaxed/simple;
	bh=WBMzskrzyqXMBtkRyI0n32CsImN7BPIZeMcc2FayuIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V27ROun1DXIIHzxxmykr6+f3fMe/irDu4dV1YXq38U0AyrnNqOKzI3Hb1UrNkAI8dsz4AWM8zsWZSw7F12Y39Q81p2SQga+yrxaDR1n31u5E/1K7S3MkMMqAnoIXCdFz99fKdf3ZvC1VQLvZx9ogY/h/0hdaZ0ioZQXV3j4WDQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TML5eYOs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TML5eYOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD2F1F000E9;
	Thu,  6 Aug 2026 18:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786042169;
	bh=K3lSD/y8TLLfT3QSIOcYK/1bKB7Bn58FgfNGm0YW9jE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TML5eYOsd5ouRIUF5mWZ6u7W/MnY6SfJjuVAtNP6UNQ3DX8+jSQI4T46pcqVzAZrn
	 4hF5L+8uN3g0Vsem5mqEt7RWIR4lqTbQB8fD6xgkKsVedVQa8MUIK+I9cFp0RCV6MC
	 6LL41dqzsa22OlDFdf57YIwmIboBkHvo2qk5Yo1Ap+HpMLpIWFyqdSBTNQEbvki3CX
	 TOT6VT8aGHENTMPh+KoPtvI+drIaRLdOVa+RZTbNYVCqB7TID+rg0uAmoYmvbkaE5y
	 93U9Dv2USEUmQ+NgsxegUazt5+ik4qojHHgF2jG0vi4BsjnzSuSdUJt11GEc2jHLhK
	 RnOcdv+cbijmA==
Date: Thu, 6 Aug 2026 11:49:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
 pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
 shaik.abdulla1@ibm.com, Dave Marquardt <davemarq@linux.ibm.com>
Subject: Re: [PATCH net-next v4 14/14] ibmveth: Fix MQ RX poll and shutdown
 hangs after queue resize
Message-ID: <20260806114928.3f4adfa9@kernel.org>
In-Reply-To: <6c687fce21930e4ded39610717ac05862b67e7aa.1785457143.git.mmc@linux.ibm.com>
References: <cover.1785457143.git.mmc@linux.ibm.com>
	<6c687fce21930e4ded39610717ac05862b67e7aa.1785457143.git.mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 17:47:17 -0700 Mingming Cao wrote:
> After aggressive ethtool -L cycling, PHYP can leave a VALID RX descriptor
> with a correlator that no longer matches the per-queue buffer pools. Poll
> treated this as fatal: ibmveth_rxq_get_buffer() WARNed and returned NULL
> without advancing the ring, then restart_poll retried the same slot
> forever.
> 
> Advance past bad correlators instead of spinning: validate correlators
> without WARN_ON, skip invalid slots in poll (count as invalid_buffers),
> and advance the RX ring when remove_buffer_from_pool cannot map the
> correlator. Rate-limit the bad correlator message.
> 
> Complete NAPI when the interface is down or napi_disable is pending so
> close/quiesce can finish. Do not restart_poll in that window. Close
> keeps hypervisor IRQ disable before napi_disable (via
> cleanup_rx_interrupts() / related cleanup helpers).
> 
> Also validate descriptor length against skb tailroom before skb_put(),
> and after napi_complete_done() on the budget-exhausted shutdown path
> return a value less than budget so NAPI does not immediately reschedule.

This patch looks very odd, like there's a bug somewhere and instead of
fixing it we're making the rx path more resilient. BTW minor coding
note - you're adding a bunch of heavily indented code to an already
long function. Please consider factoring things out. Similar comment
can be applied to other patches.
