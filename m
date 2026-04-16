Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25C3E47B;
	Thu, 16 Apr 2026 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776320530; cv=none; b=KMFmJ/wbr6VHa11DBik+8ZHT6fBAFhSpfF0kiznGknsHZQi8PsbAgrR8aOC3vPcilKzHN3ilnlikeCmzuRuO+n0h2fIfcI54ElY4FI1MBv6ODZkgmPkFbspPqb/EpX1LI9ZBeCDebnz+auhVeDe8H/YyGz69gTYRxjoEWNSzRjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776320530; c=relaxed/simple;
	bh=L03K7wgv0HG3lp+inFLDMx7vtTcPsOMgCaTopreSxt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzCjWbzm9dWXwtkLF2+AOMC5Smuzws0iysUIR71lc8Ctu+xf++AjKBT6WsGU5eY3u/z9cV8JEFKh93oMHkFwdqwZfZaKJSH8Omz1EB8I3FCH+k8JA7lq2pQJ5uqPJFXUu0bdoMGeQDlmjCWQfPX0FbmGMLmJbVQ6mBc4b6hY4Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JGlQOhpC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DYCNXtQa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JGlQOhpC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DYCNXtQa"
Date: Thu, 16 Apr 2026 08:21:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776320520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L03K7wgv0HG3lp+inFLDMx7vtTcPsOMgCaTopreSxt8=;
	b=JGlQOhpCttHrTVGoh/Gin7OP8xVbnJaZ1oa0t6/Ob6aAUCHkGmfPDsDcqUy7GdW8tiX164
	ChpFaKfFqd3iPIKHvPNZqcv7bOYnzTmubn6QvPkhVnNigsNnvIN3RvUnYAu9AK6B6IlocY
	I829e9tkcSA8oSDuMBeBfSXU9gxeY5uHMMLU6wQ7WvgSoNbcoTdnYjD9M6xioW/gM3c3+P
	XHRhKPGozlxtCiTz3T4wdBzaRVDGdqQ3SfhN19kq8kGmG7AUBIEe2Tk0haryeIba/TDEWo
	lBOkgjanZWmBJzxFdnN1+YXSB1s9/sqRhLYvFy3T6QVqLbIbUEOY+cg3xIrCqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776320520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L03K7wgv0HG3lp+inFLDMx7vtTcPsOMgCaTopreSxt8=;
	b=DYCNXtQaJi3GaDQgG8vnwfptTcyYwoS89pEjawunYcmF2OUGGXhIAQU196GqugZlqe8Pgl
	VXHAebvshabDOqBg==
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
Message-ID: <20260416062159.fPxqc52X@linutronix.de>
References: <20260414103327.113500-1-marex@nabladev.com>
 <20260414125753.Im6GAIHn@linutronix.de>
 <2fcfb84f-69f6-493e-94d6-95d85d8000f6@nabladev.com>
 <20260414145218.lsNpdAJI@linutronix.de>
 <7734527a-d08b-49fa-b258-c37c5ae2da55@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7734527a-d08b-49fa-b258-c37c5ae2da55@nabladev.com>

On 2026-04-16 01:14:35 [+0200], Marek Vasut wrote:
> > spin_unlock_bh(&ks->statelock)? After that unlock, the softirq must be
> > processed and __netdev_alloc_skb() _could_ observe pending softirqs but
> > not from ks8851.
> Because __netdev_alloc_skb() also enables/disables BH , see the "else"

Yes. But there is no softirq raised in that part. That softirq is raised
by netif_wake_queue() within a bh disabled section. Therefore upon the
unlock the softirq must be invoked.
After that, rhe allocation later on may invoke softirqs which were
raised but I don't see how ks8851 can be part of it.
Before commit 0913ec336a6c0 ("net: ks8851: Fix deadlock with the SPI
chip variant") there was no _bh around it meaning the softirq was raised
but not invoked immediately. This happened on the bh unlock during
memory allocation. Therefore I am saying this backtrace is from an older
kernel.

If there is a flaw in my the theory please explain _how_ you managed
that get that backtrace. I am sure it must have from an older kernel and
_now_ this lockup also happens on !RT kernels (except for the SPI
platform).

Sebastian
