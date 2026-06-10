Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C03E120D
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101878; cv=none; b=So5ObHW1TTas0LpUirPEb7kG+WeBlGvJ6jFV+yav55BIZS6R2TAoPy+hZRzY/r6+FvoXhArWTP24GhFQ9J6sjR7k3a95l8sP9n7iDjYsSI84YFnYHieEHOHx+WvKfk8btlikgGqYiXKUPYjyP/UODiRHQzbmOvPiaIc2F8k8+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101878; c=relaxed/simple;
	bh=tRWCc0VGxYHHGzbMCnp3Wupf1eOzfKs+ALbDRS75O7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k93Y9v2NK19GRBwHFaDA/JRsCz8hrJbT5O37rR/H8MNcr5TpE9QQfwJU/7CInRWCA3Sl2XmcZeMe+7A+a2RaVvU7NIKjsLLLETYC5oJzoR8CPNQDm9CSeSDFp2r38bW/cG2ngDdfTp0fb2rTVmaDlxVwitoUnHN9wLHSyagmalE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qmzlzl9o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qmzlzl9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD641F00893;
	Wed, 10 Jun 2026 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781101872;
	bh=/zrnAFDsQiIgxF9TRP05xR9UguzkrzrtzioFKG2qt8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qmzlzl9owzUlScCjmZJJaM7e1xKD3aeklnSDMC6UUM3mO6pm2sjGeK/qUMasv420L
	 D2v3xOqMvlk+oryzhj4eSQUw4Wo8t7gEAfvIWBfS4dD0DFEIuMjCqpV+5VtpCdvgjx
	 hmjRgpj5qN73yfWM5ifKg9AwW3ZpctJ2wNImWw2c3EPWCr6W9fIUZjuiVIIq/0VMXr
	 rvFcL3KLO868MvwttWQgZLA5RYNbX9Qp8o9phdHfpKttMVb3XYfQQXYM2WImofiGf1
	 GLlB1HbdNl6Slu9H3c9zPYeSlvxC6DKeaV1YQNfNH5HFT1iR+CUrzYIzUPlz4iLPBB
	 pGKKnTaNP6HPA==
Date: Wed, 10 Jun 2026 07:31:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marco Baffo <marco@mandelbit.com>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org, Sabrina
 Dubroca <sd@queasysnail.net>, Ralf Lici <ralf@mandelbit.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 6/6] ovpn: use monotonic clock for peer keepalive
 timeouts
Message-ID: <20260610073111.6273e17a@kernel.org>
In-Reply-To: <1290464191.15539.1781081055969@app.mailbox.org>
References: <20260608150741.3320919-1-antonio@openvpn.net>
	<20260608150741.3320919-7-antonio@openvpn.net>
	<20260609194246.23c66818@kernel.org>
	<1290464191.15539.1781081055969@app.mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 10:44:15 +0200 (CEST) Marco Baffo wrote:
> > On Mon,  8 Jun 2026 17:07:37 +0200 Antonio Quartulli wrote:  
> > > Replace ktime_get_real_seconds() with the monotonic ktime_get_boottime_seconds()
> > > to ensure the keepalive mechanism is robust against system clock modifications.  
> > 
> > Why boottime? Unless there's a reason shouldn't we be using
> > plain ktime_get_seconds() which is CLOCK_MONOTONIC?
> > 
> > (if you decide to respin could you also drop the selftest change
> > from this PR and move it to net-next? memory leaks in selftests
> > are not important)  
> 
> Hi Jakub!
> ktime_get_boottime() is like ktime_get() but it does not stop when suspended.

Worrying about keepalive timeout when system is suspended seems
quite silly, did some AI tool suggest this? Anyway, if you want
to keep this code please improve the commit message.
