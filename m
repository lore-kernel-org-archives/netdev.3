Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE970318BA7
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779232907; cv=none; b=GtyGU5DxtMQgnIMIfqPqE/cZWDD7+67GesMZliyUa+R69fGRSczSnfDa+IybYvEzWnFWymp33Fbc0/T7+iPSnK2tYl6QAQp2gZ7OVQXu7aAAcPy0phbYABPKEvMCCWMAjAmmvGX2PY9CvaNN0FMN0/3i/UdlhzdCKA3QEq4Taao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779232907; c=relaxed/simple;
	bh=IseuENXx+644M8eKBleTS0FnvA/vLR6TfzYXRwLRuE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/AtSMeRNLQPrzVYbbxu1nN1WllhNLaBkAw+k8bOOmr82b+3IaLFLVGsgCvi2sooaPVlqV5SVuCqjtILhJ9wG0Mk7p3ohra/lcX9zZl9UvDR0H7AXqEX7OpfCq7vFHjytEGsWMHItZiFLwEti/QebFMQ0pzaENrGvbJNe0IIdr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WA9n8jH9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WA9n8jH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D301F000E9;
	Tue, 19 May 2026 23:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779232906;
	bh=4wqCViT48zK52R+F8FpmLE4hdgt67yGn/SGXp249alA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WA9n8jH9pq8r/Z9Dfq/JeWMF+H8XXOucEohum5iO+I0prldaNkAxBUys3E70dVUGc
	 8TvCXHaACPlZeeCjYMJ6vCu/ylwmdzn+/8ptC+Sq8TYi+RwPKjDaFWw02VN/AftGHd
	 K/2q7B1Btm49iIsWag/t9AvQ5LP/B3etZWDwFJtP0KGMCPxAT4GO0DKCBz0M1JvhOS
	 9jTfm5k8fdN8St8VYD0wM4KV463PDCzfoEqMque2cVgPIvpmllDlHIAy8fB3VgMj7j
	 fQvow19WBGXOJbKL/ITxdAKTd+wxfXm6VTruhiNnb/tt5bHxPxRqAXf9ZeL4OPgaqE
	 iP0jDXuvMDcLA==
Date: Tue, 19 May 2026 16:21:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] net: team: fix NULL pointer dereference in
 team_xmit during mode change
Message-ID: <20260519162145.524da69e@kernel.org>
In-Reply-To: <agwJNX-q0NmmrMpy@Air.local>
References: <20260509181825.1523951-2-bestswngs@gmail.com>
	<20260510082509.1530a1a3@kernel.org>
	<agCtGqWLK53TWCaS@Air.local>
	<20260510095937.598c27a6@kernel.org>
	<agrdjt6CjpJo3AYF@Air.local>
	<20260518142230.4403b3ce@kernel.org>
	<agwJNX-q0NmmrMpy@Air.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 16:51:28 +0800 Weiming Shi wrote:
> On 26-05-18 14:22, Jakub Kicinski wrote:
> > On Mon, 18 May 2026 17:51:54 +0800 Weiming Shi wrote: =20
> > > On 26-05-10 09:59, Jakub Kicinski wrote: =20
> > > Apologies for the late reply and for rushing v3.
> > >=20
> > > I was muddling two things. On teardown synchronize_net() is the prote=
ction,
> > > the release/acquire is for the setup path where init() writes
> > > mode_priv before team_adjust_ops() publishes the handler.
> > >=20
> > > If that makes sense I'll send v4 with the corrected commit message. =
=20
> >=20
> > Can you provide more details for the init() path race?
> > What's the sequence of events? =20
>=20
> With loadbalance mode:
> =20
>   lb_init() stores select_tx_port_func (team_mode_loadbalance.c:595).
>   When a port is later enabled, team_adjust_ops() publishes
>   lb_transmit with a plain store (team_core.c:539).
>=20
> Without the release/acquire, a concurrent team_xmit() on a weakly-ordered=
=20
> arch can see lb_transmit but not the select_tx_port_func store, and lb_tr=
ansmit=20
> dereferences it at line 227.
>=20
> I'll send a PoC in the next mail so you can reproduce it.

Not sure this is enough. But feel free to send the v3 if you prefer.

=46rom looking at the repro it seems like you never add any ports?
I suspect that the author of this code assumed that if there are=20
no ports there must be no traffic, so it's safe to be flipping the
modes. I'd rather prevent the race than make it safe. Could we defer
setting the real handler until after the first port is added?
