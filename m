Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658063563CD;
	Sun, 23 Aug 2026 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505513; cv=none; b=YrjNxgqJQ1iATGzdMYF8U3YXdDkjkUF/9gk5pPuINWJGYxqAES4orS4rRxBqu1Npyf6YKYpZkLEZbMpanzRB4AMk9Hdcrk27ksUG+mXEtFuWQZrtsbzvK2yXsOOcHZGaSnWTYxb2Euv0jLN+3aholwTX/VvF8Yq2Q1rCH0llqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505513; c=relaxed/simple;
	bh=s2Ofoq3QFJCf+pWdDJdnlg51ogjBRNucz+965DL/fGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXckFGo9PxWf9GPwRl7vVQ3EkuATVo7+BM1hHd57wYb4M529N/05ZN48GeEGM5oSsMxxPyDE5U5GVXjpPPrpLMKIE8kkO5Bbuxlv4e94+kFPjO4RYyP0fJlDWF1hoWwpXAJle9oEKtwnZzLhZvIi54QdHe6XB5VPyO7n4PYm6Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=YQ5LUO4b; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="YQ5LUO4b"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id C9B1DE8368A;
	Sun, 23 Aug 2026 19:08:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1787504917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sPDN2D2ApdJ/kSQZK4Y9a3jBKLYMsxmH+j0j+sH9hw=;
	b=YQ5LUO4bQ2IuCk/WzvLRHY7HVBFHnXZSvQMfoXSjPzPYpFymYdOOGygO2h62Okjn4KVNeC
	jkEEYPw0mnFemKH1Kr9L2R2/O2kuqV7ebKhe/puzf+MRfRrNuB1/ZxvefyVUfyAXhijFzD
	dEbRAdDEc4JysMsDWKAQYi0/W8oBgpnnabeE9dpg+R2aIxcXpf5vO3w8rTgs2MObKZJwDM
	oLkSvCsjyW2V8tlP4ghRBfFv8HCmCQD1Ni3PZv493BMiUlZQIejzAHc2383mXbVnzKc3Rh
	jsjZda0Haohf4KoQz9KfxpAHOuvFqLridtQVo12le/qP3up156YeSNqXZSXg8w==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id DzZcx4Pl6ErL; Sun, 23 Aug 2026 19:08:37 +0200 (CEST)
Received: from p14sgen5.lan (p578611d6.dip0.t-ipconnect.de [87.134.17.214])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 23 Aug 2026 19:08:37 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: Re: [PATCH net v3 2/3] net: pse-pd: guard regulator ops against freed PI data during unregister
Date: Sun, 23 Aug 2026 19:08:24 +0200
Message-ID: <20260823170824.1429431-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818162606.3981504-1-kuba@kernel.org>
References: <20260818162606.3981504-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for running this through review, Jakub.

Most of the points fall into two buckets: the consumer-outlives-controller
race that I'm already leaving to the notifier series, and pre-existing bugs
that aren't really about this teardown fix. Let me go through them.

> [Severity: High]
> Now that pcdev->pi can legitimately be NULL, do the other readers of
> pcdev->pi in this file need the same guard?  Only the three regulator ops
> were updated, but the consumer-facing paths still index the array
> unconditionally:
[...]
> So after unbinding the PSE controller driver, an ethtool PSE request on
> the still registered interface, or a later PHY removal, would reach these
> reads with pcdev->pi == NULL.

Right. This is the case where a phy keeps its pse_control across driver
unbind - of_pse_control_get() only takes a module ref, no device link - so
ethtool and __pse_control_release() can still land here after pcdev->pi is
gone. Adding !pcdev->pi checks to all these paths doesn't really fix it, the
handle itself is stale by then.

So I'd leave these paths as they are here and not add guards. The notifier
series [1] fixes it properly: on PSE_UNREGISTERED the phy layer drops
phydev->psec before pse_release_pis() frees anything, and phy is the only
pse_control user in tree.

> [Severity: High]
> This isn't a bug introduced by this patch, but the ordering in
> pse_controller_unregister() looks like it leaves part of the window the
> commit message claims to close still open:
[...]
> pse_flush_pw_ds() drops the power-domain kref, and __pse_pw_d_release()
> calls regulator_put(pw_d->supply) [...] the new guards pass and the ops
> proceed to the released supply

Good catch, it's real. But it needs the same racing consumer to hit it -
something has to call into the regulator ops while unregister sits between
pse_flush_pw_ds() and the free. The notifier series closes this one too: it
fires PSE_UNREGISTERED at the top of unregister, so every consumer is gone
before pse_flush_pw_ds() drops the supply. Same bucket as above.

If you'd rather net not carry that window until [1] lands, I can add a small
stopgap - NULL pcdev->pi[i].pw_d in pse_flush_pw_ds() under pcdev->lock, so
pse_pi_deallocate_pw_budget()'s existing !pi->pw_d check catches it. Happy to
do either. Makes sense?

> [Severity: High]
> This isn't a bug introduced by this patch, but since these lines are being
> reworked anyway: should ret be returned here instead of 0?

Yes, that's a real one, but it's pre-existing and not about the UAF -
pse_pi_disable() has always swallowed the disable error. I'd send that as its
own patch with its own Fixes tag rather than bury it in here. Correct?

> [Severity: High]
> One more pre-existing item [...] pse_controller_register() [...] there is
> no error unwinding after the early allocations. [...] devres then frees the
> pw_d while the xarray still points at it

Also real, also pre-existing, and it's in the register path, not the teardown
one this series is about. The dangling xarray entry is the nasty part. I'd
recommend we handle that as its own patch rather than in this series - ok?

> [Severity: Medium]
> Also, pse_pi_enable() returns -ENODEV for the same condition while this one
> returns 0.  Is the asymmetry intended?

I understood it like this: a disable that races teardown has nothing left to
turn off, so returning "done" keeps the regulator core from warning, while
enable really can't proceed so -ENODEV made sense there. If that's right I'd
add a one-line comment so it doesn't read like an oversight. Makes sense to
you?

So, short version: I'd keep patches 1-3 as they are, leave the consumer
lifetime stuff and the supply window to the notifier series [1], and send the
two pre-existing bugs on their own.

Does that sound right to you, or would you do it differently? What would you
recommend as the next step?

[1] https://lore.kernel.org/netdev/20260630091125.3162481-1-github@szelinsky.de/

Thanks,
Carlo
