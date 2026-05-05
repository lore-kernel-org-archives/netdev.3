Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AD54266A8;
	Tue,  5 May 2026 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777982547; cv=none; b=fy9eny7MXGK09NlOeNBRkNHNWAikymBoqkLWw/k+Bs3OlWxzqCs8Pyozg0azCgJabGGd6kgnhXvnK5dpnoqA0V45FdgcgXcn2xXO9/7olGeoXDA5n1YszQW9gJH8T3tskJ2ZQfpL1X5pe2ObccJbqqY5e+QVLPpIgALTF9/ZKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777982547; c=relaxed/simple;
	bh=b/zIcom3hsUQ8kP/XBrUYbmMke5OJa2Y+fnt3KVZSnY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FNREKs2h790NaST13FLBWLhKfCAEupIjRdFE3GRKayDIDk596aCzmzJ47Nf1Bhd4U4VrpRE8fiwX1NEHy2JNCPmhpIqHp8wschSZgtme3F9YNxuPSjOhokNuqoH1NHxWHXXRdPksL8fddT5fwcfg0YDR56ClouXziLo4U9TwNEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8515692009C; Tue,  5 May 2026 14:02:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7F18592009B;
	Tue,  5 May 2026 13:02:16 +0100 (BST)
Date: Tue, 5 May 2026 13:02:16 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: netdev@vger.kernel.org, linux-mips@vger.kernel.org, 
    Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] declance: Remove IRQF_ONESHOT
In-Reply-To: <20260505072954.Ov2t-FGt@linutronix.de>
Message-ID: <alpine.DEB.2.21.2605051233210.46195@angie.orcam.me.uk>
References: <20260127135334.qUEaYP9G@linutronix.de> <alpine.DEB.2.21.2601271508160.40317@angie.orcam.me.uk> <20260127165430.7ui_LGkg@linutronix.de> <alpine.DEB.2.21.2601271739250.40317@angie.orcam.me.uk> <alpine.DEB.2.21.2603292037020.60268@angie.orcam.me.uk>
 <alpine.DEB.2.21.2605042332070.46195@angie.orcam.me.uk> <20260505072954.Ov2t-FGt@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 5 May 2026, Sebastian Andrzej Siewior wrote:

> >  No reply, but I've gone through irq_setup_forced_threading() now and my 
> > inference was indeed correct, and the handler does need to be installed 
> > with IRQF_NO_THREAD.  I'll send corrective patches shortly.
> 
> Sorry. I missed that previous email.
> IRQF_NO_THREAD will not force-thread the interrupt handler so it will
> run with interrupts disabled.

 That's one clear option I've identified and given that the handler 
amounts to a printk() call it may well be the path of least resistance 
solution.

> With force-threading enabled, the interrupt handler is masked in the
> IRQ-chip until after the threaded-handler run. See the cond_unmask_irq()
> in handle_level_irq() or the mask_irq() & cond_unmask_eoi_irq() in
> handle_fasteoi_ack_irq(). That means the hw-IRQ is done, the thread is
> running with interrupts enabled but the hw-IRQ will not trigger again.
> The cited commit 5a4a4ad851dd8 ("MIPS: Mark cascade and low level
> interrupts IRQF_NO_THREAD") is different as it acts on cascading
> interrupts which is not what we have here.

 Not with the current handle_fasteoi_irq() handler.

 And actually not with handle_fasteoi_ack_irq() either, which doesn't call 
mask_irq() unless IRQF_ONESHOT has been requested (but ->irq_ack() could 
be repurposed to do masking), however handle_fasteoi_mask_irq() seems a 
matching candidate.  To use that handler the platform would have to select 
IRQ_DOMAIN_HIERARCHY and IRQ_FASTEOI_HIERARCHY_HANDLERS, although none of 
the stuff beyond just handle_fasteoi_mask_irq() appears relevant, so it 
seems like a waste of memory.  Note that the handlers are much more recent 
than the driver and back in the time IRQF_ONESHOT seemed a reasonable 
approach.

 The handle_level_irq() handler is irrelevant, because we do need to issue 
the EOI for deassertion.

> If you request a threaded interrupt you must either provide two handler
> and the primary must mask the interrupt so it does not fire again or you
> pass a flag such as IRQF_ONESHOT and which point the IRQ subsystem will
> mask the IRQ within the irqchip so it does not fire again.

 Well, yes, but you've just removed the flag from this driver, so either 
the flag has to reinstated or the driver adjusted differently for the 
threaded case to be handled correctly.

  Maciej
