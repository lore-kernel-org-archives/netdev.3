Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A284D98E9;
	Tue,  6 Oct 2026 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327135; cv=none; b=C7VTzfeI4ThHk8fGlQXq1vbOlYiZ0JSsxmSL6r9pxnj4q1ssFLXK9/vS6tGXgTnRD/lprmSIYMO+03u/jsuM3NcnjsVXUfN1rP5CxKXp+tklMoHD7UiZu9pWvjwgGxU4Y7YlOJWqR4diGnHEFsHENr/kEuNWW8amBpT33nyzlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327135; c=relaxed/simple;
	bh=hLALOZmXVKC/7v6S/3QtsQXA+nJltuNJa18BiD2mBk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9IPE/B0xuWQjl4LyP0NaXUGj1jWrdCrOumQUJDNM+BQFaj0Tu6Pgx0D9iddV52VyWS76sCjtmezz3v3nfW8ZBO1Dzlhz9or+adRXebEJUEArKsXPfjqSKt+vzyQ5JqubwdC12m5Jf5BfDJLuVfNQqE1EDbNhHg0EYRSWmfGTMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c86XRavd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c86XRavd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E03F1F0089B;
	Tue,  6 Oct 2026 22:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327135;
	bh=hLALOZmXVKC/7v6S/3QtsQXA+nJltuNJa18BiD2mBk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c86XRavdi6mixAcbFn60iQqJKDNxvlC3R4NG1MoXRR1iUrisAwx77o5A5KU3tVk5r
	 CIkd5H8KxVw5MZeoxLUiWWPwEblA+YnA/3wUM4gTRWfPB/xKNQlfyD4bWQdO7Yg28k
	 XU0c14TSLwvXjMhU70PI4CjxPlwxuswuTm+c4i7bRXtrqAhIX1YCCkngZogcUOo+AR
	 r6WazXMScCoJKzNeUnlpFYjjz8nHhiEcYSDcEgY28sZ08dgq85U5RrcPZ754GIw6T9
	 qsYlBOpZCFK+Ho4QQL/HHtV4TRU7Zey7t320/IkWT4nVttQtQuWxoKhviIUGMhKx9u
	 4hPoKnz/kq3LQ==
Date: Tue, 6 Oct 2026 15:52:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Serge Semin <fancer.lancer@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Nicolai Buchwitz <nb@tipi-net.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: unwind the WoL IRQ after a safety
 IRQ request failure
Message-ID: <20261006155214.63c5cb5b@kernel.org>
In-Reply-To: <CADvTj4orth=RYtb78ND1rdiYh2yb6d+TjZt5ohK_-+1mnVpqfQ@mail.gmail.com>
References: <20261006-stmmac-irq-unwind-v2-1-194591c87460@gmail.com>
	<179127056620.2231598.8882282421523696709@kernel.org>
	<CADvTj4orth=RYtb78ND1rdiYh2yb6d+TjZt5ohK_-+1mnVpqfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Oct 2026 01:14:52 -0600 James Hilliard wrote:
> > Please do not repost the series just to address the above. Instead,
> > reply to this email with the missing information, so that reviewers
> > can take it into account. If the series needs another revision for
> > other reasons, please include the information in the commit messages
> > then.

Please make sure you read this paragraph, to the end.
