Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9A233928;
	Sun, 31 May 2026 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780242184; cv=none; b=HybG69DM/QKGbX6TvkzSaMGEe76WdP2cz/IftMoJxQt9p1VnpwGcdEotNsWMbZKrLAt8hNBiky9KgLk5a0XoIIGQjcH5xLYlCZCglpQ6TJL/QHAHx3fdHLo1jCC5rko22zuAuOuLRapXA37EqmH4SIVcXcRJcLObrhOnLVHdvPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780242184; c=relaxed/simple;
	bh=ch1RoagxSojYx7msAGe7NsXjSdmsRwcTiY1Wo9JLJfs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjaGyLss49l4sSAERTexS6soZ2QLSs09NUReGbLuMenLBbZ9ggLbM2Q2pC1Bk/VfBL9pGxN4f+CEAPGTH2mTQXfJDVmW7bDvpaFDwytZfB5OIc1K3NDkbMm13r0T52B4+lxjExsSKJt3ZuvyG6qyO7MFoYJogyZ/Gy4ogh4g4SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=oyIiNNzu; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="oyIiNNzu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1780242181; x=1780501381;
	bh=cNO4Goq9At+taxiUz/cEqwK3XlIcahGoxkUriFNDIOY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=oyIiNNzuTjwO/uxDuEEr+T05drMy9pxkdUyZwhuiUZtbqWTQnH9FzCHZyRyznADqH
	 Md7R2nwAtasxO/7fEVpMbdin69epaTUjws+sKqT9KlH+qXif1SN+vzlTdxmUT0x1Pd
	 aKrxJKZ+HtOokkO6vDFvHaTRGjLCEnDC6L55AAVgzMfD3hF+ePtc/PkbxGtToy1L95
	 O49X/SNqUqi4aZFhEdMrMh+KY84RKFM2KYVpwwbrE08shpnfOn2OmfVtegz7m5j0qn
	 mK/UGlmaPNwRLQEHgwTC+qj1R2DjyvNrB1UzfiU/wcJknw3UOmTnDbojIYOKqVEUPn
	 Qd/rVUIxf758g==
Date: Sun, 31 May 2026 15:42:54 +0000
To: =?utf-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
From: Gustavo Kenji <kaneko.dev@pm.me>
Cc: netdev@vger.kernel.org, conor.dooley@microchip.com, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: macb: fix ignored return value of clk_prepare_enable() in runtime resume
Message-ID: <_4d39Uy7TfuTOibgqaeaA2DcW-DMmampPqAAekPTyMK87lYN6UCWzR0MGWcDZU4_Sz6HGvIWLRABRp1Io_jg5bz-apo_I6C11sar1a1efX8=@pm.me>
In-Reply-To: <DIWNNTPN8ZRN.2HYJUO6WIETTD@bootlin.com>
References: <20260531051841.55311-1-kaneko.dev@pm.me> <DIWNNTPN8ZRN.2HYJUO6WIETTD@bootlin.com>
Feedback-ID: 165279626:user:proton
X-Pm-Message-ID: f41821e5aa2a29e50a8bb014e6fbcd7ae5faac23
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Th=C3=A9o,

Thanks for the review.

> Your CC list is lacking some net maintainers, how did you get who to
> send this email to?

You're right, and I apologize. I did run get_maintainer.pl, but I made a
mistake assembling the --to/--cc lists and dropped the networking
maintainers. The full output is:

  Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>      (macb maintainer)
  Conor Dooley <conor.dooley@microchip.com>  (reviewer)
  Andrew Lunn <andrew+netdev@lunn.ch>        (netdev)
  David S. Miller <davem@davemloft.net>
  Eric Dumazet <edumazet@google.com>
  Jakub Kicinski <kuba@kernel.org>
  Paolo Abeni <pabeni@redhat.com>
  netdev@vger.kernel.org
  linux-kernel@vger.kernel.org

I'll Cc all of them in v2.

> Could you point out if this was figured out to address a bug or if it
> is only a theoretical defense?

It is not tied to an observed failure. I found it by code review and I do
not have macb hardware to test on, so this is a robustness fix rather
than a bug fix: clk_prepare_enable() is __must_check, and here its return
value is silently discarded in the runtime-resume path. If you feel this
isn't worth changing, I'm fine with dropping the patch.

> "atomically" usually refers to some locking mechanism [...]

That was a poor word choice on my part; there is no locking involved. I
meant only that clk_bulk_prepare_enable() enables the clocks as a group
and, on failure, unwinds the ones it already enabled. I've dropped
"atomically" and reworded the commit message in v2.

Thanks,
Gustavo
