Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10F53382C0
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771330400; cv=none; b=phjqQS2PEXrJhr7k/c3vabSIWcv89h4nBiGb1N6SLHbE0hWvQ1DHg5u+7Hu6nZyJmUUfG+no7evOa+ngHrwT0nBJxsHyQBPMd9NkVCT18OoVIQC0nn8qXrr+W8QPc/1yBzh4Af27gdRMk3stfNj7ONyKzIoRkAkUCojz1QVti3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771330400; c=relaxed/simple;
	bh=ZKANkxJJiG5MMXLF/4rfpKITDUsG4g2rcXz3W3BvQZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4AQTE1IuONs85bLxLTZHz+T+5nKQduuolJ8mb2z8rqS+57K3w0OqYvpoGuAOuxkGwXsDighmuOsnNf4/z/JFWVagYzjYNQ0lA8vFNT5QKe+oIvenfEF/AGSgWu8LrkCFpzr8QrVBEd6GZCWT9p7LDCW+isAO2iHUP5amrtJnp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rRiG+n6H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OrLKptTj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rRiG+n6H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OrLKptTj"
Date: Tue, 17 Feb 2026 13:13:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771330397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FiNas+B9QpuPRZVx+b791giiE2yUMdi7Ggy+QIGZWQw=;
	b=rRiG+n6HODr82Xk/nFhsObqJDDD4IxT+jb5QrAoni/hMW4p3aUcxlzL0ThAJQ3wjo10j1P
	8wN7+hfp485arzr0hTYrZkiat4xJlj1pG8mXiGbOEE9DLoqB3gLB7X+GwEEg9Z+jfO/zcQ
	zlvD2qLkc3ClpQQB4k7OVs1SfslPMas85RYnn3nX7F+9BWJsrRxZ9ig4y/V3g/H/VQuqYS
	oXyq0iupnomTLxNVVi5Mr5cULQ1/3rPHXhYK2ap5fOiipBfMOl+Ux9D4qSDrAlZHOV0I9H
	9N/I+KuFXsuAY4LrOsp+Wy5xq7zpoHscbboVh3ybCEr/ZXQdhJmEnTxXfvhu+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771330397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FiNas+B9QpuPRZVx+b791giiE2yUMdi7Ggy+QIGZWQw=;
	b=OrLKptTjLrrHWv2La8ZnCxoDc5Hru84s3tD0NWlZY1osoXYwaLOMRY0axMLNh/mUK4eqRV
	sAlQjBjgLUVMAYCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] net: Drop the lock in skb_may_tx_timestamp()
Message-ID: <20260217121316.h4PJG-6s@linutronix.de>
References: <20260214232456.A37oV4KQ@linutronix.de>
 <willemdebruijn.kernel.1682a93525c87@gmail.com>
 <20260215184608.8dk4hemG@linutronix.de>
 <9130dfca-1e85-4975-8df9-4de8bd9e8f5e@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9130dfca-1e85-4975-8df9-4de8bd9e8f5e@linux.dev>

On 2026-02-16 16:47:03 [+0000], Vadim Fedorenko wrote:
> > > Such as a packet socket sending and hitting the __skb_tstamp_tx
> > > SCM_TSTAMP_SCHED at the top of __dev_queue_xmit.
> > 
> > If that is the case, then we could create a RCU read section here.
> 
> well, __dev_queue_xmit() grabs rcu_read_lock_bh() already, we just have
> to move it right before timestamping check:

For __skb_tstamp_tx() there is:
- hci_conn_tx_queue() -> __skb_tstamp_tx() which appears to be called
  from a worker and has a GPF_KERNEL allocation later.
- hci_num_comp_pkts_evt() (does acquire a mutex) ->
  hci_conn_tx_dequeue() -> __skb_tstamp_tx()
- prueth_rx_mgm_ts_thread_sr1() (explicit threaded IRQ) ->
  prueth_tx_ts_sr1() -> skb_tstamp_tx()

There is also skb_complete_tx_timestamp():
- ines_txtstamp_work() -> skb_complete_tx_timestamp()
- nxp_c45_do_aux_work() -> nxp_c45_process_txts() ->
  skb_complete_tx_timestamp()
- ksz_ptp_txtstamp_skb() -> skb_complete_tx_timestamp()
  and ksz_ptp_txtstamp_skb() has a wait_for_completion_timeout() so no
  RCU here either.
- hellcreek_txtstamp_work() -> skb_complete_tx_timestamp()

so maybe an explicit RCU region is easier.

Sebastian
