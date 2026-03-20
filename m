Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E31DB95E;
	Fri, 20 Mar 2026 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021314; cv=none; b=aVYuAdfbfygkqVP/IS0Wx+qsVxpBO62gu7LQIHs3zsL6KfcO4WZCAKSY2hjD2csbl9YBqooGpydDTU6udkoCSi3kjaNesBXcv4IYF6YxRqaOrrMkoYa//PocVcl7MsqvhpmR1o7Xm8PjkthwIxRR3LdI6BxvIwNpTcQOWFaq8mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021314; c=relaxed/simple;
	bh=t/JZDHZbOJzg97wYny5FkHbNmpYduUjFddbDl7Tb4QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQ53btIDRpAU5ltcTeaJUUhRGlyfIIJ0xcSSebSmqC56R71fzA7mdwFb30tYDwk+9CLrQ9svSw078f9YigvUeR3D7FXoxpZXKFKjoFHcQ1h4T9UtOQQNyXPN9h3CAAi1PrIY5Cm4ncFIR8YApdZJbhIuBlR8Jf/HUYoNsUhoQz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aKpzz2F9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aKpzz2F9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=35EoSgbbhAMpHfUa5IEUpJhv+RfkkFYAmzR+GISPIcg=; b=aKpzz2F9dfiCBQHrtsBiS6N5tr
	g4AtNbwdyt0kzsS3C8LNah+XiY2waqV3n75UtiNdsrPY+8V8SUt0ve15lkf81AhMfdlneyApQNzLO
	+7YVv0QsgBW3IPWsC8LjsWqMbIZ8FZkKj0SuaDd0E7tfHP382wqwEh51JRPBfdyfvGXDU7NIcw55X
	wMi4ScybbCncHBruRK68hWArWkJfuRJqGBkV6PxWfK3d3Q1XsYX4yWnIRy6U8iSa2g9TdABcXb5zm
	FoI3M28F/A1BFrIT6e4X2OqE2TjHihLdD4S1juYeY6lBrzrZHB8Q1nNeUd16WTB/CvX49nTlTyuaH
	cHSshQGQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51948)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w3bys-000000006Eh-2XKC;
	Fri, 20 Mar 2026 15:41:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w3byo-000000000wF-1R2i;
	Fri, 20 Mar 2026 15:41:42 +0000
Date: Fri, 20 Mar 2026 15:41:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: yangg9 <cohenyang511@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	kuba@kernel.org, yangg9@xiaopeng.com, edumazet@google.com,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, maxime.chevallier@bootlin.com,
	vladimir.oltean@nxp.com, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: close reset IRQ window and avoid double free
Message-ID: <ab1qthMmffkAKVQ8@shell.armlinux.org.uk>
References: <20260320061955.833785-1-cohenyang511@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320061955.833785-1-cohenyang511@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 20, 2026 at 02:19:55PM +0800, yangg9 wrote:
> From: yangg9 <yangg9@xiaopeng.com>
> 
> During reset, stmmac_reset_subtask() used to set STMMAC_DOWN before IRQs
> were freed in __stmmac_release(). That leaves a window where interrupts can
> still fire after the device is marked down, which may lead to interrupt
> storms while the interface is transitioning.
> 
> Move stmmac_free_irq() earlier in the reset flow, before setting
> STMMAC_DOWN, so the reset path no longer has that interrupt window.
> 
> Since IRQs are now released in stmmac_reset_subtask(), guard IRQ release in
> __stmmac_release() with STMMAC_DOWN to avoid a second free_irq() during the
> same reset sequence.
> 
> This removes the interrupt-storm window in reset and prevents double IRQ
> release.

So, some points that need to be raised:

- What is the point of STMMAC_DOWN?

STMMAC_DOWN isn't set when the interface is administratively brought
down, the only place where this flag is set is in
stmmac_reset_subtask() and later cleared.

The flag appears to prevent stmmac_service_event_schedule() queueing
the service task while it's still operating, but STMMAC_SERVICE_SCHED
already does that.

It also prevents interrupts being serviced, which causes your
interrupt storm. However, does this matter? Surely stmmac_release()
can already cope with the interrupt handlers being active, since
taking an interface administratively down involves interacting with
it in an active state - when a packet may be received.

It's also used in stmmac_xdp_xmit() and stmmac_xsk_wakeup() to block
further processing in those paths. However, for stmmac_xsk_wakeup()
the only path which calls stmmac_service_event_schedule() is
stmmac_global_err() which nautily calls netif_carrier_off() behind
phylink's back, which will corrupt phylink's state and lead to
phylink API calls being made in weird orders to the driver (this
needs to die.) However, stmmac_xsk_wakeup() checks whether the
carrier is on as well, which is a duplicate check.

So, here's the question: do we need to test STMMAC_DOWN in the
interrupt handlers at all? Can we delete those tests? As you seem
to have a way of triggering the reset subtask, please try removing
those tests from the interrupt handlers, thus simplifying the code
rather than trying a more complex solution.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
