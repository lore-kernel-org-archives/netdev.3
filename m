Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37172750E6;
	Thu, 16 Apr 2026 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776336503; cv=none; b=qP5n7jjwZQ1iG2nvRIcPhjBqTulJLoapcHJMdjIBbLTGq6+G+A9m0tjX7Ni/DBSK9EUvg3PMKPbo3FdZHIpBlViZBAmaIZrYfSmjp91M+GWTCDPeS75tjNPAp/mhiLrG5lTKoerwBvFgbT4GPBakmo7NMRc0MtNi7CIIZkVE0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776336503; c=relaxed/simple;
	bh=FJAjF3c/YQAZ4eKmPCcFLz5owz9LmueVbVqgFhgoVpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zb6AqB0/Jq6RXqHE78qISulFtcJeJ3kho++TQDq+/uTXOdxXd6p2gOXVYwPlARiU+waOtcSxKTHnD6AT6igu6e2v6iT9BJgyGBMHJNi0JM8KcxyaO3wEsKs2Nk19keLp3NxVAEd45axr8eMdKMUeKLwDsPVawWowr93pAWnFrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M7tsHkFG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8GjlmBf+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M7tsHkFG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8GjlmBf+"
Date: Thu, 16 Apr 2026 12:48:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776336499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I3a7Sj+pE8WYMPoTgZHgFbXHwJPGyl/mbNxCrht2ciU=;
	b=M7tsHkFGF/XC8bt3idRz80P1SxzXCGO5gMiIWSHRK8LMVMmjP8P+3kTMmXxtO7N+rHVujO
	/9lPKTFh5pnHLY3aZo0FnLakIWA8NLCmwe208rHOmbAIZCHT8A2M78ZTTB0Z1fmbfxpzBZ
	KXKhIuoxSi7O4AHAJgOI0frsk5ZD457tJbJorusOKU+FYTrbdTlOH8tgKjXmA+3yNt2vva
	yIT//0jnfMNrYs/APwx5hyHpBbiXD2QSwVayAYMHh7YKRWlPYSkfpHcb9Lq46GuMAydJV3
	3Gnzs4x910dtN0uQFajj73frA9acmQ7Xr3L+kNwKifwZ8AEWCVhkxbEyNSe/dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776336499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I3a7Sj+pE8WYMPoTgZHgFbXHwJPGyl/mbNxCrht2ciU=;
	b=8GjlmBf+HMAGSVLkjIzbXCrFa42WdQ00ZsKu1/uWFYxmusGD/wcUQkNpsq+VB0rLr3aovX
	GqiFZulv+LsAkvAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Yicong Hui <yiconghui@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH v3 1/2] net: ks8851: Reinstate disabling of BHs
 around IRQ handler
Message-ID: <20260416104818._EDbo9hA@linutronix.de>
References: <20260414103327.113500-1-marex@nabladev.com>
 <20260414125753.Im6GAIHn@linutronix.de>
 <2fcfb84f-69f6-493e-94d6-95d85d8000f6@nabladev.com>
 <20260414145218.lsNpdAJI@linutronix.de>
 <7734527a-d08b-49fa-b258-c37c5ae2da55@nabladev.com>
 <20260416062159.fPxqc52X@linutronix.de>
 <afe7ed2c-4434-4394-9d87-a4bdf5a15ec1@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afe7ed2c-4434-4394-9d87-a4bdf5a15ec1@nabladev.com>

On 2026-04-16 11:26:00 [+0200], Marek Vasut wrote:
> > memory allocation. Therefore I am saying this backtrace is from an older
> > kernel.
> 
> I actually did update the backtrace in V3 with the one from next 20260413
> that contained b44596ffe1b4 ("ARM: Allow to enable RT") from
> stable-rt/v6.12-rt-rebase branch [1] .
> 
> I think I misunderstood the usage of "softirq is raised" vs. "softirq is
> invoked" above . Is it possible that there was an already raised softirq
> before the threaded IRQ handler was invoked, and __netdev_alloc_skb() is
> what invoked that softirq ?

It is not impossible. Something needs to netif_wake_queue() and
ks8851_irq() must only report IRQ_RXI (not IRQ_TXI). Then it can happen.
But usually the driver "stops" the queue if it can't process any new
packets and resumes it once a packet has been sent so it has room again.

> > If there is a flaw in my the theory please explain _how_ you managed
> > that get that backtrace. I am sure it must have from an older kernel and
> > _now_ this lockup also happens on !RT kernels (except for the SPI
> > platform).
> I used [1] , with PREEMPT_RT enabled , on stm32mp157c SoC . I ran iperf3 -s
> on the stm32 side, iperf3 -c 192.168.1.2 -t 0 --bidir on the hostpc side.
> The backtrace happened shortly after.

Hmm. Let me accept it then.

Sebastian
